From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH -next] drm/amdkfd: Make function kfd_dev_is_large_bar()
 static
Date: Mon, 2 Apr 2018 14:03:33 -0400
Message-ID: <623cef28-530e-21af-e90c-64905f5c84b5@amd.com>
References: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>, oded.gabbay@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


On 2018-03-29 10:25 PM, Wei Yongjun wrote:
> Fixes the following sparse warning:
>
> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:1150:6: warning:
>  symbol 'kfd_dev_is_large_bar' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cd679cf..fb5d997 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1147,7 +1147,7 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>  	return ret;
>  }
>  
> -bool kfd_dev_is_large_bar(struct kfd_dev *dev)
> +static bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>  {
>  	struct kfd_local_mem_info mem_info;
>
