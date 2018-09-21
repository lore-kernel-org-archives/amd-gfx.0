From: zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH] drm: amd: Use kmemdup instead of duplicating its function
Date: Fri, 21 Sep 2018 22:13:09 +0800
Message-ID: <5BA4FC75.7040902@huawei.com>
References: <1537284932-62278-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537284932-62278-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, alexander.deucher@amd.com
Cc: oded.gabbay@gmail.com, christian.koenig@amd.com, David1.Zhou@amd.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

+cc  amd-gfx@lists.freedesktop.org

Thanks,
zhong jiang

On 2018/9/18 23:35, zhong jiang wrote:
> kmemdup has implemented the function that kmalloc() + memcpy().
> We prefer to kmemdup rather than code opened implementation.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index ee49960..8ddd585 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -747,12 +747,10 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  		return -ENODATA;
>  	}
>  
> -	pcrat_image = kmalloc(crat_table->length, GFP_KERNEL);
> +	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
>  	if (!pcrat_image)
>  		return -ENOMEM;
>  
> -	memcpy(pcrat_image, crat_table, crat_table->length);
> -
>  	*crat_image = pcrat_image;
>  	*size = crat_table->length;
>  
