From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Wed, 4 Sep 2019 10:37:47 +0200
Message-ID: <20190904083747.GE2112@phenom.ffwll.local>
References: <20190830032948.13516-1-hdanton@sina.com>
 <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
 <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
 <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
 <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux kernel <linux-kernel@vger.kernel.org>, Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <hwentlan@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 04, 2019 at 09:17:16AM +0800, Hillf Danton wrote:
> Daniel Vetter <daniel@ffwll.ch>
> >>
> >> Now 11:01pm and "gnome shell stuck warning" not appear since 19:17. So
> >> looks like issue happens only when computer blocked and monitor in
> >> power save mode.
> >
> > I'd bet on runtime pm or some other power saving feature in amdgpu
> > shutting the interrupt handling down before we've handled all the
> > interrupts. That would then result in a stuck fence.
> >
> > Do we already know which fence is stuck?
> 
> It is welcomed to shed a thread of light on how to collect/print that info.
> Say line:xxx-yyy in path/to/amdgpu/zzz.c

Extend your backtrac warning slightly like

	WARN(r, "we're stuck on fence %pS\n", fence->ops);

Also adding Harry and Alex, I'm not really working on amdgpu ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
