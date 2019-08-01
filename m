From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][drm-next] drm/amdgpu: fix unsigned variable instance
 compared to less than zero
Date: Thu, 1 Aug 2019 15:12:16 -0400
Message-ID: <CADnq5_Oo8AthzgGsRCRaiNqn7skzGCGMZGdMcNo8Et+5Zt12Og@mail.gmail.com>
References: <20190801110145.10803-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801110145.10803-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Le Ma <le.ma@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 1, 2019 at 7:01 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currenly the error check on variable instance is always false because
> it is a uint32_t type and this is never less than zero. Fix this by
> making it an int type.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 7d0e6329dfdc ("drm/amdgpu: update more sdma instances irq support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index a33bd867287e..92257f2bf171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1962,7 +1962,8 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
>  static int sdma_v4_0_process_ras_data_cb(struct amdgpu_device *adev,
>                 struct amdgpu_iv_entry *entry)
>  {
> -       uint32_t instance, err_source;
> +       uint32_t err_source;
> +       int instance;
>
>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>         if (instance < 0)
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
