From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 0/7] amdgpu clang warning fixes on next-20190703
Date: Tue, 9 Jul 2019 00:22:47 -0700
Message-ID: <20190709072247.GA92551@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <CADnq5_MGzLLMNPSQXpdxwrBpvsp7Fd1KdExS-K4yNeDBQYEGMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_MGzLLMNPSQXpdxwrBpvsp7Fd1KdExS-K4yNeDBQYEGMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, clang-built-linux@googlegroups.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 08, 2019 at 11:55:50AM -0400, Alex Deucher wrote:
> Applied the series.  thanks!
> 
> Alex

Thank you :)

I don't see the enum conversion ones in your current tree. If they
indeed caused issues, could you guys please look into fixing the
warnings properly yourselves (maybe something like Arnd's patch?)
or let me know how you would like them fixed (explicit casts, changing
type to int, etc)?

https://patchwork.freedesktop.org/patch/316466/

Cheers,
Nathan
