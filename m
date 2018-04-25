From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 15:36:40 +0200
Message-ID: <CAKMK7uF7LumuFWw3Xezw+QYDEhz6pFrJueZqFvSnmmoynYqpgQ@mail.gmail.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net> <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com> <20180424214027.GG25142@phenom.ffwll.local>
 <20180425132228.GC7592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425132228.GC7592@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, David.Panariti@amd.com, Eric Biederman <ebiederm@xmission.com>, Alex Deucher <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Apr 25, 2018 at 3:22 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/24, Daniel Vetter wrote:
>>
>> wait_event_killabel doesn't check for fatal_signal_pending before calling
>> schedule, so definitely has a nice race there.
>
> This is fine. See the signal_pending_state() check in __schedule().
>
> And this doesn't differ from wait_event_interruptible(), it too doesn't
> check signal_pending(), we rely on schedule() which must not block if the
> caller is signalled/killed.
>
> The problem is that it is not clear what should fatal_signal_pending() or
> even signal_pending() mean after exit_signals().

Uh, I was totally thrown off in all the wait_event* macros and somehow
landed in the _locked variants, which all need to recheck before they
drop the lock, for efficiency reasons. See do_wait_intr().

Sorry for the confusion.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
