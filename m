From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove excess function parameter description
Date: Thu, 19 Sep 2019 13:48:06 -0400
Message-ID: <CADnq5_MFLy3zFXu39BaUb-7Y4rYqqFQt2B=_fVMOozh87Z2X1g@mail.gmail.com>
References: <1568902149-70787-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568902149-70787-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yu kuai <yukuai3@huawei.com>
Cc: Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, yi.zhang@huawei.com, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin13@huawei.com, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Sep 19, 2019 at 10:03 AM yu kuai <yukuai3@huawei.com> wrote:
>
> Fixes gcc warning:
>
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:431: warning: Excess function
> parameter 'sw' description in 'vcn_v2_5_disable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:550: warning: Excess function
> parameter 'sw' description in 'vcn_v2_5_enable_clock_gating'
>
> Fixes: cbead2bdfcf1 ("drm/amdgpu: add VCN2.5 VCPU start and stop")
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 395c225..9d778a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -423,7 +423,6 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
>   * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Disable clock gating for VCN block
>   */
> @@ -542,7 +541,6 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
>   * vcn_v2_5_enable_clock_gating - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Enable clock gating for VCN block
>   */
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
