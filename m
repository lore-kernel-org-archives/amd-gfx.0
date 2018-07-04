From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Reserve fence slots for command submission
Date: Wed, 4 Jul 2018 08:34:44 +0200
Message-ID: <e6385817-e437-e5de-0297-a6af16648a2c@gmail.com>
References: <1530673358-20219-1-git-send-email-Jerry.Zhang@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530673358-20219-1-git-send-email-Jerry.Zhang@amd.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Junwei Zhang <Jerry.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: michel.daenzer@amd.com, christian.koenig@amd.com, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 04.07.2018 um 05:02 schrieb Junwei Zhang:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> Without this, there could not be enough slots, which could trigger the
> BUG_ON in reservation_object_add_shared_fence.
>
> v2:
> * Jump to the error label instead of returning directly (Jerry Zhang)
> v3:
> * Reserve slots for command submission after VM updates (Christian König)
>
> Cc: stable@vger.kernel.org
> Bugzilla: https://bugs.freedesktop.org/106418
> Reported-by: mikhail.v.gavrilov@gmail.com
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>

I would put that at the end of amdgpu_bo_vm_update_pte(), but that is 
only a minor nit pick.

Patch is Reviewed-by: Christian König <christian.koenig@amd.com> anyway.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 7a625f3..1bc0281 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -928,6 +928,10 @@ static int amdgpu_cs_ib_vm_chunk(struct amdgpu_device *adev,
>   		r = amdgpu_bo_vm_update_pte(p);
>   		if (r)
>   			return r;
> +
> +		r = reservation_object_reserve_shared(vm->root.base.bo->tbo.resv);
> +		if (r)
> +			return r;
>   	}
>   
>   	return amdgpu_cs_sync_rings(p);
