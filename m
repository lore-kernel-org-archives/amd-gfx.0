From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Tue, 3 Sep 2019 22:18:55 +0200
Message-ID: <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
References: <20190830032948.13516-1-hdanton@sina.com> <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com> <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 3, 2019 at 8:07 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, 3 Sep 2019 at 13:21, Hillf Danton <hdanton@sina.com> wrote:
> >
> > Describe the problems you are experiencing please.
> > Say is the screen locked up? Machine lockedup?
> > Anything unnormal after you see the warning?
> >
>
> According to my observations, all "gnome shell stuck warning" happened
> when me not sitting on the computer and the computer was locked.
>
> I did not notice any problems at the morning (I did not even look at
> the kernel logs), I found that the problem happened when I remotely
> connected to my computer via ssh from work and accidently look dmesg
> output.
>
> At the evening after work, I even played in the "Division", and still
> not noted any problems.
>
> Now 11:01pm and "gnome shell stuck warning" not appear since 19:17. So
> looks like issue happens only when computer blocked and monitor in
> power save mode.

I'd bet on runtime pm or some other power saving feature in amdgpu
shutting the interrupt handling down before we've handled all the
interrupts. That would then result in a stuck fence.

Do we already know which fence is stuck? All the debuggin on the
dma_fence_wait side is just looking at the messenger, this isn't the
source of the problem.
-Daniel

>
> $ dmesg -T | grep gnome
>
> ---> I am goto sleep
> [Tue Sep  3 01:00:10 2019] gnome shell stuck warning
> [Tue Sep  3 01:00:55 2019] gnome shell stuck warning
> [Tue Sep  3 06:54:50 2019] gnome shell stuck warning
> <--- I am wake up at 8:00 am and sitting again on the computer
> ---> I am went to work at 9:30
> [Tue Sep  3 10:00:05 2019] gnome shell stuck warning
> [Tue Sep  3 10:10:01 2019] gnome shell stuck warning
> [Tue Sep  3 10:13:43 2019] gnome shell stuck warning
> [Tue Sep  3 10:23:37 2019] gnome shell stuck warning
> [Tue Sep  3 10:42:07 2019] gnome shell stuck warning
> [Tue Sep  3 10:42:57 2019] gnome shell stuck warning
> [Tue Sep  3 10:59:25 2019] gnome shell stuck warning
> [Tue Sep  3 11:08:35 2019] gnome shell stuck warning
> [Tue Sep  3 11:13:19 2019] gnome shell stuck warning
> [Tue Sep  3 11:15:20 2019] gnome shell stuck warning
> [Tue Sep  3 11:26:20 2019] gnome shell stuck warning
> [Tue Sep  3 11:26:20 2019] gnome shell stuck warning
> [Tue Sep  3 11:36:30 2019] gnome shell stuck warning
> [Tue Sep  3 11:46:08 2019] gnome shell stuck warning
> [Tue Sep  3 11:53:52 2019] gnome shell stuck warning
> [Tue Sep  3 11:56:36 2019] gnome shell stuck warning
> [Tue Sep  3 12:17:10 2019] gnome shell stuck warning
> [Tue Sep  3 12:20:20 2019] gnome shell stuck warning
> [Tue Sep  3 12:20:20 2019] gnome shell stuck warning
> [Tue Sep  3 12:30:46 2019] gnome shell stuck warning
> [Tue Sep  3 12:40:52 2019] gnome shell stuck warning
> [Tue Sep  3 12:55:30 2019] gnome shell stuck warning
> [Tue Sep  3 12:57:52 2019] gnome shell stuck warning
> [Tue Sep  3 13:04:00 2019] gnome shell stuck warning
> [Tue Sep  3 13:12:38 2019] gnome shell stuck warning
> [Tue Sep  3 13:14:32 2019] gnome shell stuck warning
> [Tue Sep  3 13:53:12 2019] gnome shell stuck warning
> [Tue Sep  3 14:12:52 2019] gnome shell stuck warning
> [Tue Sep  3 14:15:54 2019] gnome shell stuck warning
> [Tue Sep  3 14:17:04 2019] gnome shell stuck warning
> [Tue Sep  3 14:21:57 2019] gnome shell stuck warning
> [Tue Sep  3 14:22:10 2019] gnome shell stuck warning
> [Tue Sep  3 14:37:42 2019] gnome shell stuck warning
> [Tue Sep  3 14:41:51 2019] gnome shell stuck warning
> [Tue Sep  3 14:42:52 2019] gnome shell stuck warning
> [Tue Sep  3 14:46:35 2019] gnome shell stuck warning
> [Tue Sep  3 15:03:18 2019] gnome shell stuck warning
> [Tue Sep  3 15:16:50 2019] gnome shell stuck warning
> [Tue Sep  3 15:27:30 2019] gnome shell stuck warning
> [Tue Sep  3 15:27:41 2019] gnome shell stuck warning
> [Tue Sep  3 16:08:06 2019] gnome shell stuck warning
> [Tue Sep  3 16:24:16 2019] gnome shell stuck warning
> [Tue Sep  3 16:33:04 2019] gnome shell stuck warning
> [Tue Sep  3 16:52:10 2019] gnome shell stuck warning
> [Tue Sep  3 17:18:27 2019] gnome shell stuck warning
> [Tue Sep  3 17:25:30 2019] gnome shell stuck warning
> [Tue Sep  3 17:41:16 2019] gnome shell stuck warning
> [Tue Sep  3 17:43:32 2019] gnome shell stuck warning
> [Tue Sep  3 17:51:10 2019] gnome shell stuck warning
> [Tue Sep  3 18:41:44 2019] gnome shell stuck warning
> [Tue Sep  3 18:44:18 2019] gnome shell stuck warning
> [Tue Sep  3 19:03:07 2019] gnome shell stuck warning
> [Tue Sep  3 19:17:58 2019] gnome shell stuck warning
> <--- Returned to home and sitting again on the computer
>
> --
> Best Regards,
> Mike Gavrilov.



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
