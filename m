From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/7] various '-Wunused-but-set-variable' gcc warning fixes
Date: Wed, 13 Nov 2019 10:24:07 -0500
Message-ID: <CADnq5_P38AfOHtRAAYXHVmjPPS9ot4NTGX-dQXgeUiGUjYUCHw@mail.gmail.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yu kuai <yukuai3@huawei.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>, yi.zhang@huawei.com, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin <zhengbin13@huawei.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied the series, although a couple of the patches were already
applied from a previous patch set.

Thanks,

Alex

On Wed, Nov 13, 2019 at 9:12 AM yu kuai <yukuai3@huawei.com> wrote:
>
> This patch set fixes various unrelated gcc '-Wunused-but-set-variable'
> warnings.
>
> yu kuai (7):
>   drm/amdgpu: remove set but not used variable 'mc_shared_chmap' from
>     'gfx_v6_0.c' and 'gfx_v7_0.c'
>   drm/amdgpu: remove set but not used variable 'amdgpu_connector'
>   drm/amdgpu: remove set but not used variable 'count'
>   drm/amdgpu: remove set but not used variable 'invalid'
>   drm/amdgpu: remove set but not used variable 'threshold'
>   drm/amdgpu: remove set but not used variable 'state'
>   drm/amdgpu: remove set but not used variable 'us_mvdd'
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c         |  2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c               |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c               |  3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c             |  4 ++--
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c  |  7 ++-----
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
>  7 files changed, 8 insertions(+), 27 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
