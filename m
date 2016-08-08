From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/7] Minor DP aux transaction fixes
Date: Mon, 8 Aug 2016 13:30:37 -0400
Message-ID: <CADnq5_PUcNjttK8zB_G_RnbHFbdaxHZED_VzpEEk29fMu1E89g@mail.gmail.com>
References: <1470443443-27252-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470443443-27252-1-git-send-email-cpaul@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude <cpaul@redhat.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, xorg-driver-ati@lists.freedesktop.org, Tom St Denis <tom.stdenis@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Aug 5, 2016 at 8:30 PM, Lyude <cpaul@redhat.com> wrote:
> While I was investigating an unrelated bug on the radeon driver, I noticed that
> it's become rather difficult to actually read through dmesg with drm.debug
> turned on, on account of the huge number of messages we end up printing from
> failed DP aux transactions that happen every time we reprobe each connector.
>
> Timed out transactions are relatively normal, and as well there's a lot of
> places in radeon/amdgpu where we're printing redundant debugging information
> dozens of times each time we attempt a DP aux transactions.
>
> Additionally, I've removed some of the retry loops in amdgpu/radeon. These were
> definitely useful at one point, but since we now retry any failed aux
> transaction unconditionally in DRM's dp helpers they don't serve much purpose
> other then to make failing aux transactions take a lot more time then they need
> to.

I've applied the amdgpu and radeon patches.  For the drm patches, I
can either take them through my tree or via drm-misc.

Alex

>
> Lyude (7):
>   drm/dp_helper: Print first error received on failure in
>     drm_dp_dpcd_access()
>   drm/radeon: Don't print error on aux transaction timeouts
>   drm/radeon: Don't retry 7 times in radeon_dp_dpcd()
>   drm/amdgpu: Don't print error on aux transaction timeouts
>   drm/amdgpu: Don't retry 7 times in amdgpu_atombios_dp_get_dpcd()
>   drm: Add ratelimited versions of the DRM_DEBUG* macros
>   drm/dp_helper: Rate limit timeout errors from drm_dp_i2c_do_msg()
>
>  drivers/gpu/drm/amd/amdgpu/atombios_dp.c | 22 ++++++++++------------
>  drivers/gpu/drm/drm_dp_helper.c          | 14 ++++++++++++--
>  drivers/gpu/drm/radeon/atombios_dp.c     | 21 ++++++++++-----------
>  drivers/gpu/drm/radeon/radeon_dp_auxch.c |  1 -
>  include/drm/drmP.h                       | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 62 insertions(+), 26 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
