From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] gpu: drm: drm_mm: Fix a sleep-in-atomic-context bug in
 show_leaks()
Date: Mon, 3 Sep 2018 09:52:44 +0200
Message-ID: <20180903075244.GE21634@phenom.ffwll.local>
References: <20180901122041.2357-1-baijiaju1990@gmail.com>
 <153580517420.12034.2035309606925619207@skylake-alporthouse-com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153580517420.12034.2035309606925619207@skylake-alporthouse-com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie, gustavo@padovan.org, maarten.lankhorst@linux.intel.com, seanpaul@chromium.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org, David Zhou <David1.Zhou@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Sat, Sep 01, 2018 at 01:32:54PM +0100, Chris Wilson wrote:
> Quoting Jia-Ju Bai (2018-09-01 13:20:41)
> > The driver may sleep with holding a spinlock.
> > 
> > The function call paths (from bottom to top) in Linux-4.16 are:
> > 
> > [FUNC] kmalloc(GFP_KERNEL)
> > drivers/gpu/drm/drm_mm.c, 130: 
> >         kmalloc in show_leaks
> > drivers/gpu/drm/drm_mm.c, 913: 
> >         show_leaks in drm_mm_takedown
> > drivers/gpu/drm/drm_vma_manager.c, 107: 
> >         drm_mm_takedown in drm_vma_offset_manager_destroy
> > drivers/gpu/drm/drm_vma_manager.c, 106: 
> >         _raw_write_lock in drm_vma_offset_manager_destroy
> > 
> > [FUNC] kmalloc(GFP_KERNEL)
> > drivers/gpu/drm/drm_mm.c, 130: 
> >         kmalloc in show_leaks
> > drivers/gpu/drm/drm_mm.c, 913: 
> >         show_leaks in drm_mm_takedown
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 71: 
> >         drm_mm_takedown in amdgpu_vram_mgr_fini
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 70: 
> >         spin_lock in amdgpu_vram_mgr_fini
> > 
> > [FUNC] kmalloc(GFP_KERNEL)
> > drivers/gpu/drm/drm_mm.c, 130: 
> >         kmalloc in show_leaks
> > drivers/gpu/drm/drm_mm.c, 913: 
> >         show_leaks in drm_mm_takedown
> > drivers/gpu/drm/ttm/ttm_bo_manager.c, 128: 
> >         drm_mm_takedown in ttm_bo_man_takedown
> > drivers/gpu/drm/ttm/ttm_bo_manager.c, 126: 
> >         spin_lock in ttm_bo_man_takedown
> > 
> > To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> The bug are above, since those spinlocks do not protect the data and
> imply use-after-free.

Adding amdgpu, since that's where the bug seems to be.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
