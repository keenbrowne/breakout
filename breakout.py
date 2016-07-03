import pyglet

class PygletMain(pyglet.window.Window):

    def __init__(self):
        pass

    def create_breakout(self):
        pass

    def run(self):
        pyglet.clock.schedule_interval(self.update, 1 / 120.0)
        pyglet.app.run()

    def update(self, elapsed_time):
        pass

    def on_draw(self):
        pass

    def on_close(self):
        pass

if __name__ == '__main__':
    pyglet.resource.path = ['./img']
    pyglet.resource.reindex()
    run()
