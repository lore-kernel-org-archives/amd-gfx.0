From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][drm-next] drm/radeon: make functions alloc_pasid and
 free_pasid static
Date: Fri, 29 Sep 2017 16:13:49 -0400
Message-ID: <CADnq5_OGJ-_59XJ_aQ8C6VR3TRbDAhMYqc=nkv2CncBZnunrBQ@mail.gmail.com>
References: <20170928134617.8168-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170928134617.8168-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Sep 28, 2017 at 9:46 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The functions alloc_pasid  and free_pasid are local to the
> source and do not need to be in global scope, so make them static.
>
> Cleans up sparse warnings:
> warning: symbol 'alloc_pasid' was not declared. Should it be static?
> warning: symbol 'free_pasid' was not declared. Should it be static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/radeon_kfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kfd.c b/drivers/gpu/drm/radeon/radeon_kfd.c
> index a2ac8ac0930d..385b4d76956d 100644
> --- a/drivers/gpu/drm/radeon/radeon_kfd.c
> +++ b/drivers/gpu/drm/radeon/radeon_kfd.c
> @@ -352,7 +352,7 @@ static uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
>   */
>  static DEFINE_IDA(pasid_ida);
>
> -int alloc_pasid(unsigned int bits)
> +static int alloc_pasid(unsigned int bits)
>  {
>         int pasid = -EINVAL;
>
> @@ -367,7 +367,7 @@ int alloc_pasid(unsigned int bits)
>         return pasid;
>  }
>
> -void free_pasid(unsigned int pasid)
> +static void free_pasid(unsigned int pasid)
>  {
>         ida_simple_remove(&pasid_ida, pasid);
>  }
> --
> 2.14.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
