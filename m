From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: radeon Disabling GPU acceleration (WB disabled?)
Date: Tue, 22 Oct 2019 23:04:06 -0400
Message-ID: <CADnq5_OEP8Rwcjok8LbedZ00B=3voEu97ngeOMiGLde=ZjXrHg@mail.gmail.com>
References: <24b5f681-df58-7663-af7c-9fa9b9158be9@linux.ee> <61646cbe-c4a9-cef1-d586-f3ac794b998a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61646cbe-c4a9-cef1-d586-f3ac794b998a@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Meelis Roos <mroos@linux.ee>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Oct 22, 2019 at 12:09 PM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> On 2019-10-20 11:21 p.m., Meelis Roos wrote:
> > I tried 5.2, 5.3 and 5.4-rc4 on my old Fujitsu RX220 with integrated
> > Radeon RV100. Dmesg tells that GPU acceleration is disabled. I do not
> > know if it has been enabled in the past - no old kernels handy at the
> > moment.
> >
> > From dmesg it looks like something with MTRR maybe: WB disabled.
>
> That's harmless.
>
>
> > [    8.535975] [drm] Driver supports precise vblank timestamp query.
> > [    8.535981] radeon 0000:00:05.0: Disabling GPU acceleration
>
> This looks like drm_irq_install returns an error in radeon_irq_kms_init.
>

Check to see that the sbios assigns an irq to the device.  There may
be an option in the sbios configuration settings.  IIRC, some old
platforms didn't always assign interrupts to vga devices.

Alex
