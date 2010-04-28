/* The following line (global) is for JSLint */
/*global console*/

function Event(name, value, time) {
    this.name = name;
    this.value = value;
    this.time = time;
}

function Question(id) {
    this.id = id;
    this.prompt = '';
    this.correct_answer = '';
    this.answer = '';
    this.unit = '';
    this.start_time = null;
    this.end_time = null;
}

function Section() {
    this.events = [];
    this.questions = [];
    this.start_time = null;
    this.end_time = null;
}

/* Log object structure
 * - session is the unit of upload to server
 * 
 *   SESSION
 *     start_time:
 *     end_time:
 *     sections:
 *       - section
 *           start_time:
 *           end_time:
 *           events:
 *             - event
 *                 name:
 *                 value:
 *                 time:
 *           questions:
 *             - question
 *                 id:
 *                 correct_answer:
 *                 answer:
 *                 unit:
 *                 correct:
 *                 start_time:
 *                 end_time:
 */
function Session() {
    this.sections = [];
    this.start_time = null;
    this.end_time = null;
}

function ActivityLog()
{
    //console.log('ENTER ActivityLog');
    
    this.sessions = [];
    this.numSessions = 0;
}

ActivityLog.prototype =
{
    eventNames : { start_session: 1,
                   end_session: 1,
                   start_section: 1,
                   end_section: 1,
                   start_question: 1,
                   end_question: 1,
                   connect: 1,
                   disconnect: 1,
                   make_circuit: 1,
                   break_circuit: 1,
                   multimeter_dial: 1,
                   multimeter_power: 1,
                   resistor_nominal_value: 1,
                   resistor_real_value: 1,
                   resistor_display_value: 1 },
    
    valueNames : { nominal_resistance: 1,
                   tolerance: 1,
                   real_resistance: 1,
                   displayed_resistance: 1 },
    
    beginNextSession : function() {
        var session = new Session();
        var section = new Section();
        var questions = section.questions;
        
        questions.push(new Question('rated_resistance'));
        questions.push(new Question('rated_tolerance'));
        questions.push(new Question('measured_resistance'));
        questions.push(new Question('measured_tolerance'));
        questions.push(new Question('within_tolerance'));
        
        session.sections.push(section);
        this.sessions.push(session);
        this.numSessions += 1;
    },
    
    currentSession : function() {
        return this.sessions[this.numSessions - 1];
    },
 
    setValue : function(name, value) {
        if (this.valueNames[name]) {
            this.currentSession().sections[0][name] = value;
        }
        else {
            this.currentSession().sections[0].UNREGISTERED_NAME = name;
        }
    },

    // Add event
    add : function(name, params) {
        var now = new Date().valueOf();
        var section = this.currentSession().sections[0];

        if (!this.eventNames[name]) { 
            console.log('ERROR: add: Unknown log event name ' + name);
            section.events.push(new Event('UNREGISTERED_NAME', name, now));
            return;
        }
        
        switch (name)
        {
        case 'connect':
            console.log('connect ' + params.conn1 + ' to ' + params.conn2);
            section.events.push(new Event('connect', params.conn1 + '|' + params.conn2, now));
            break;
        case 'make_circuit':
            section.events.push(new Event('make_circuit', '', now));
            break;
        case 'break_circuit':
            section.events.push(new Event('break_circuit', '', now));
            break;
        case 'start_section':
            section.start_time = now;
            break;
        case 'end_section':
            section.end_time = now;
            break;
        case 'start_question':
            section.questions[params.question-1].start_time = now;
            break;
        case 'end_question':
            section.questions[params.question-1].end_time = now;
            break;
        case 'start_session':
            this.currentSession().start_time = now;
            break;
        case 'end_session':
            this.currentSession().end_time = now;
            break;
        default:
            section.events.push(new Event(name, params.value, now));
        }
    }
};