From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'header'
Date: Wed, 10 Oct 2018 15:18:56 -0400
Message-ID: <CADnq5_MF1KvBQQRPNuuRE1gcTq6aHutktCPBi2ocfjYyZAcPYA@mail.gmail.com>
References: <1537971334-130152-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537971334-130152-1-git-send-email-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Likun Gao <Likun.Gao@amd.com>, David Francis <David.Francis@amd.com>, Huang Rui <ray.huang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, "monk.liu" <Monk.Liu@amd.com>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 26, 2018 at 11:01 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c: In function 'amdgpu_ucode_init_bo':
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:431:39: warning:
>  variable 'header' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 1fa8bc3..afd5cf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -428,7 +428,6 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>         uint64_t fw_offset = 0;
>         int i, err;
>         struct amdgpu_firmware_info *ucode = NULL;
> -       const struct common_firmware_header *header = NULL;
>
>         if (!adev->firmware.fw_size) {
>                 dev_warn(adev->dev, "No ip firmware need to load\n");
> @@ -465,7 +464,6 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>         for (i = 0; i < adev->firmware.max_ucodes; i++) {
>                 ucode = &adev->firmware.ucode[i];
>                 if (ucode->fw) {
> -                       header = (const struct common_firmware_header *)ucode->fw->data;
>                         amdgpu_ucode_init_single_fw(adev, ucode, adev->firmware.fw_buf_mc + fw_offset,
>                                                     adev->firmware.fw_buf_ptr + fw_offset);
>                         if (i == AMDGPU_UCODE_ID_CP_MEC1 &&
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
