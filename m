From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: gnome-shell is frozen upon wakeup from DPMS (bisected)
Date: Fri, 11 Nov 2016 10:30:06 +0100
Message-ID: <20161111093006.4ohlgbhoqatg67fb@phenom.ffwll.local>
References: <e0aa85a5-c26e-f5ea-556b-ee8e5f3bc37e@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0aa85a5-c26e-f5ea-556b-ee8e5f3bc37e@suse.de>
Sender: stable-owner@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>
Cc: stable@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, daniel.vetter@ffwll.ch, michel.daenzer@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Nov 10, 2016 at 06:21:50PM +0100, Max Staudt wrote:
> Hi,
> 
> I have bisected a commit in v4.6 that fixes a freeze of the screen on
> DPMS sleep:
> 
> 777e3cbc791f131806d9bf24b3325637c7fc228d drm/radeon: Switch to drm_vblank_on/off
> 
> 
> When running 'xset dpms force off' in a GNOME session (I tested this on
> openSUSE Leap 42.2), sometimes the screen will freeze, sometimes it will
> not. It may take several tries.
> 
> When it does freeze, the mouse can still be used, but clicking anything
> will (seem to?) have no effect. Typing in an open terminal still works,
> albeit the screen will still be frozen. Run "xterm" and the screen will
> unfreeze. Running "xlogo" does not unfreeze it.
> 
> 
> Can we include the above commit in linux-stable?
> 
> I have tested it on v4.4 - it applies cleanly and resolves the issue.

I had to take a few rounds in getting this one right, personally I'd be
wary with backporting due to that fireworks potential. Yes it works for
you, but who knows where it blows up.

Leaving the final decision to Alex ofc.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
