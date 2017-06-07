From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdgpu/gfx: move more common KIQ code to
 amdgpu_gfx.c
Date: Wed, 7 Jun 2017 17:59:23 -0400
Message-ID: <69d4d5d4-70a4-0a0d-6eed-c33dab3edcc2@amd.com>
References: <1496864097-4322-1-git-send-email-alexander.deucher@amd.com>
 <1496864097-4322-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1852521151=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496864097-4322-4-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1852521151==
Content-Type: multipart/alternative;
 boundary="------------C6D5C0504D2C2EA57BEC453E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C6D5C0504D2C2EA57BEC453E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 03:34 PM, Alex Deucher wrote:
> Lots more common stuff.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 103 ++++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  11 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 110 ++------------------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 109 ++-----------------------------
>   4 files changed, 122 insertions(+), 211 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 51a9708..c5aa465 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -145,3 +145,106 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>   	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
>   		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>   }
> +
> +static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
> +				  struct amdgpu_ring *ring)
> +{
> +	int queue_bit;
> +	int mec, pipe, queue;
> +
> +	queue_bit = adev->gfx.mec.num_mec
> +		    * adev->gfx.mec.num_pipe_per_mec
> +		    * adev->gfx.mec.num_queue_per_pipe;
> +
> +	while (queue_bit-- >= 0) {
> +		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
> +			continue;
> +
> +		amdgpu_gfx_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
> +
> +		/* Using pipes 2/3 from MEC 2 seems cause problems */
> +		if (mec == 1 && pipe > 1)
> +			continue;
> +
> +		ring->me = mec + 1;
> +		ring->pipe = pipe;
> +		ring->queue = queue;
> +
> +		return 0;
> +	}
> +
> +	dev_err(adev->dev, "Failed to find a queue for KIQ\n");
> +	return -EINVAL;
> +}
> +
> +int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
> +			     struct amdgpu_ring *ring,
> +			     struct amdgpu_irq_src *irq)
> +{
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	int r = 0;
> +
> +	mutex_init(&kiq->ring_mutex);
> +
> +	r = amdgpu_wb_get(adev, &adev->virt.reg_val_offs);
> +	if (r)
> +		return r;
> +
> +	ring->adev = NULL;
> +	ring->ring_obj = NULL;
> +	ring->use_doorbell = true;
> +	ring->doorbell_index = AMDGPU_DOORBELL_KIQ;
> +
> +	r = amdgpu_gfx_kiq_acquire(adev, ring);
> +	if (r)
> +		return r;
> +
> +	ring->eop_gpu_addr = kiq->eop_gpu_addr;
> +	sprintf(ring->name, "kiq %d.%d.%d", ring->me, ring->pipe, ring->queue);
> +	r = amdgpu_ring_init(adev, ring, 1024,
> +			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
> +	if (r)
> +		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> +
> +	return r;
> +}
> +
> +void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring,
> +			      struct amdgpu_irq_src *irq)
> +{
> +	amdgpu_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
> +	amdgpu_ring_fini(ring);
> +}
> +
> +void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +
> +	amdgpu_bo_free_kernel(&kiq->eop_obj, &kiq->eop_gpu_addr, NULL);
> +}
> +
> +int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
> +			unsigned hpd_size)
> +{
> +	int r;
> +	u32 *hpd;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +
> +	r = amdgpu_bo_create_kernel(adev, hpd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
> +				    &kiq->eop_gpu_addr, (void **)&hpd);
> +	if (r) {
> +		dev_warn(adev->dev, "failed to create KIQ bo (%d).\n", r);
> +		return r;
> +	}
> +
> +	memset(hpd, 0, hpd_size);
> +
> +	r = amdgpu_bo_reserve(kiq->eop_obj, true);
> +	if (unlikely(r != 0))
> +		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
> +	amdgpu_bo_kunmap(kiq->eop_obj);
> +	amdgpu_bo_unreserve(kiq->eop_obj);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index fa20438..b1766fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -32,6 +32,17 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
>   
>   void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev);
>   
> +int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
> +			     struct amdgpu_ring *ring,
> +			     struct amdgpu_irq_src *irq);
> +
> +void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring,
> +			      struct amdgpu_irq_src *irq);
> +
> +void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev);
> +int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
> +			unsigned hpd_size);
> +
>   /**
>    * amdgpu_gfx_create_bitmask - create a bitmask
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fc8e03b..8a9d35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1379,76 +1379,6 @@ static void gfx_v8_0_mec_fini(struct amdgpu_device *adev)
>   	}
>   }
>   
> -static int gfx_v8_0_kiq_acquire(struct amdgpu_device *adev,
> -				 struct amdgpu_ring *ring)
> -{
> -	int queue_bit;
> -	int mec, pipe, queue;
> -
> -	queue_bit = adev->gfx.mec.num_mec
> -		    * adev->gfx.mec.num_pipe_per_mec
> -		    * adev->gfx.mec.num_queue_per_pipe;
> -
> -	while (queue_bit-- >= 0) {
> -		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
> -			continue;
> -
> -		amdgpu_gfx_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
> -
> -		/* Using pipes 2/3 from MEC 2 seems cause problems */
> -		if (mec == 1 && pipe > 1)
> -			continue;
> -
> -		ring->me = mec + 1;
> -		ring->pipe = pipe;
> -		ring->queue = queue;
> -
> -		return 0;
> -	}
> -
> -	dev_err(adev->dev, "Failed to find a queue for KIQ\n");
> -	return -EINVAL;
> -}
> -
> -static int gfx_v8_0_kiq_init_ring(struct amdgpu_device *adev,
> -				  struct amdgpu_ring *ring,
> -				  struct amdgpu_irq_src *irq)
> -{
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -	int r = 0;
> -
> -	mutex_init(&kiq->ring_mutex);
> -
> -	r = amdgpu_wb_get(adev, &adev->virt.reg_val_offs);
> -	if (r)
> -		return r;
> -
> -	ring->adev = NULL;
> -	ring->ring_obj = NULL;
> -	ring->use_doorbell = true;
> -	ring->doorbell_index = AMDGPU_DOORBELL_KIQ;
> -
> -	r = gfx_v8_0_kiq_acquire(adev, ring);
> -	if (r)
> -		return r;
> -
> -	ring->eop_gpu_addr = kiq->eop_gpu_addr;
> -	sprintf(ring->name, "kiq %d.%d.%d", ring->me, ring->pipe, ring->queue);
> -	r = amdgpu_ring_init(adev, ring, 1024,
> -			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
> -	if (r)
> -		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> -
> -	return r;
> -}
> -
> -static void gfx_v8_0_kiq_free_ring(struct amdgpu_ring *ring,
> -				   struct amdgpu_irq_src *irq)
> -{
> -	amdgpu_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
> -	amdgpu_ring_fini(ring);
> -}
> -
>   static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   {
>   	int r;
> @@ -1520,38 +1450,6 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static void gfx_v8_0_kiq_fini(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
> -	amdgpu_bo_free_kernel(&kiq->eop_obj, &kiq->eop_gpu_addr, NULL);
> -}
> -
> -static int gfx_v8_0_kiq_init(struct amdgpu_device *adev)
> -{
> -	int r;
> -	u32 *hpd;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
> -	r = amdgpu_bo_create_kernel(adev, GFX8_MEC_HPD_SIZE, PAGE_SIZE,
> -				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
> -				    &kiq->eop_gpu_addr, (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "failed to create KIQ bo (%d).\n", r);
> -		return r;
> -	}
> -
> -	memset(hpd, 0, GFX8_MEC_HPD_SIZE);
> -
> -	r = amdgpu_bo_reserve(kiq->eop_obj, true);
> -	if (unlikely(r != 0))
> -		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
> -	amdgpu_bo_kunmap(kiq->eop_obj);
> -	amdgpu_bo_unreserve(kiq->eop_obj);
> -
> -	return 0;
> -}
> -
>   static const u32 vgpr_init_compute_shader[] =
>   {
>   	0x7e000209, 0x7e020208,
> @@ -2192,14 +2090,14 @@ static int gfx_v8_0_sw_init(void *handle)
>   		}
>   	}
>   
> -	r = gfx_v8_0_kiq_init(adev);
> +	r = amdgpu_gfx_kiq_init(adev, GFX8_MEC_HPD_SIZE);
>   	if (r) {
>   		DRM_ERROR("Failed to init KIQ BOs!\n");
>   		return r;
>   	}
>   
>   	kiq = &adev->gfx.kiq;
> -	r = gfx_v8_0_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
> +	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
>   	if (r)
>   		return r;
>   
> @@ -2251,8 +2149,8 @@ static int gfx_v8_0_sw_fini(void *handle)
>   		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>   
>   	gfx_v8_0_compute_mqd_sw_fini(adev);
> -	gfx_v8_0_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
> -	gfx_v8_0_kiq_fini(adev);
> +	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
> +	amdgpu_gfx_kiq_fini(adev);
>   
>   	gfx_v8_0_mec_fini(adev);
>   	gfx_v8_0_rlc_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 6d30476..fbb9d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -969,107 +969,6 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static void gfx_v9_0_kiq_fini(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
> -	amdgpu_bo_free_kernel(&kiq->eop_obj, &kiq->eop_gpu_addr, NULL);
> -}
> -
> -static int gfx_v9_0_kiq_init(struct amdgpu_device *adev)
> -{
> -	int r;
> -	u32 *hpd;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -
> -	r = amdgpu_bo_create_kernel(adev, GFX9_MEC_HPD_SIZE, PAGE_SIZE,
> -				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
> -				    &kiq->eop_gpu_addr, (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "failed to create KIQ bo (%d).\n", r);
> -		return r;
> -	}
> -
> -	memset(hpd, 0, GFX9_MEC_HPD_SIZE);
> -
> -	r = amdgpu_bo_reserve(kiq->eop_obj, true);
> -	if (unlikely(r != 0))
> -		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
> -	amdgpu_bo_kunmap(kiq->eop_obj);
> -	amdgpu_bo_unreserve(kiq->eop_obj);
> -
> -	return 0;
> -}
> -
> -static int gfx_v9_0_kiq_acquire(struct amdgpu_device *adev,
> -				 struct amdgpu_ring *ring)
> -{
> -	int queue_bit;
> -	int mec, pipe, queue;
> -
> -	queue_bit = adev->gfx.mec.num_mec
> -		    * adev->gfx.mec.num_pipe_per_mec
> -		    * adev->gfx.mec.num_queue_per_pipe;
> -
> -	while (queue_bit-- >= 0) {
> -		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
> -			continue;
> -
> -		amdgpu_gfx_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
> -
> -		/* Using pipes 2/3 from MEC 2 seems cause problems */
> -		if (mec == 1 && pipe > 1)
> -			continue;
> -
> -		ring->me = mec + 1;
> -		ring->pipe = pipe;
> -		ring->queue = queue;
> -
> -		return 0;
> -	}
> -
> -	dev_err(adev->dev, "Failed to find a queue for KIQ\n");
> -	return -EINVAL;
> -}
> -
> -static int gfx_v9_0_kiq_init_ring(struct amdgpu_device *adev,
> -				  struct amdgpu_ring *ring,
> -				  struct amdgpu_irq_src *irq)
> -{
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> -	int r = 0;
> -
> -	mutex_init(&kiq->ring_mutex);
> -
> -	r = amdgpu_wb_get(adev, &adev->virt.reg_val_offs);
> -	if (r)
> -		return r;
> -
> -	ring->adev = NULL;
> -	ring->ring_obj = NULL;
> -	ring->use_doorbell = true;
> -	ring->doorbell_index = AMDGPU_DOORBELL_KIQ;
> -
> -	r = gfx_v9_0_kiq_acquire(adev, ring);
> -	if (r)
> -		return r;
> -
> -	ring->eop_gpu_addr = kiq->eop_gpu_addr;
> -	sprintf(ring->name, "kiq %d.%d.%d", ring->me, ring->pipe, ring->queue);
> -	r = amdgpu_ring_init(adev, ring, 1024,
> -			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
> -	if (r)
> -		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> -
> -	return r;
> -}
> -static void gfx_v9_0_kiq_free_ring(struct amdgpu_ring *ring,
> -				   struct amdgpu_irq_src *irq)
> -{
> -	amdgpu_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
> -	amdgpu_ring_fini(ring);
> -}
> -
>   /* create MQD for each compute queue */
>   static int gfx_v9_0_compute_mqd_sw_init(struct amdgpu_device *adev)
>   {
> @@ -1570,14 +1469,14 @@ static int gfx_v9_0_sw_init(void *handle)
>   		}
>   	}
>   
> -	r = gfx_v9_0_kiq_init(adev);
> +	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE);
>   	if (r) {
>   		DRM_ERROR("Failed to init KIQ BOs!\n");
>   		return r;
>   	}
>   
>   	kiq = &adev->gfx.kiq;
> -	r = gfx_v9_0_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
> +	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
>   	if (r)
>   		return r;
>   
> @@ -1632,8 +1531,8 @@ static int gfx_v9_0_sw_fini(void *handle)
>   		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>   
>   	gfx_v9_0_compute_mqd_sw_fini(adev);
> -	gfx_v9_0_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
> -	gfx_v9_0_kiq_fini(adev);
> +	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
> +	amdgpu_gfx_kiq_fini(adev);
>   
>   	gfx_v9_0_mec_fini(adev);
>   	gfx_v9_0_ngg_fini(adev);


--------------C6D5C0504D2C2EA57BEC453E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-by: Alex Xie <a class="moz-txt-link-rfc2396E"
        href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
    <br>
    <div class="moz-cite-prefix">On 2017-06-07 03:34 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1496864097-4322-4-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Lots more common stuff.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 103 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  11 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 110 ++------------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 109 ++-----------------------------
 4 files changed, 122 insertions(+), 211 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 51a9708..c5aa465 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -145,3 +145,106 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 	if (WARN_ON(adev-&gt;gfx.num_compute_rings &gt; AMDGPU_MAX_COMPUTE_RINGS))
 		adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 }
+
+static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
+				  struct amdgpu_ring *ring)
+{
+	int queue_bit;
+	int mec, pipe, queue;
+
+	queue_bit = adev-&gt;gfx.mec.num_mec
+		    * adev-&gt;gfx.mec.num_pipe_per_mec
+		    * adev-&gt;gfx.mec.num_queue_per_pipe;
+
+	while (queue_bit-- &gt;= 0) {
+		if (test_bit(queue_bit, adev-&gt;gfx.mec.queue_bitmap))
+			continue;
+
+		amdgpu_gfx_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
+
+		/* Using pipes 2/3 from MEC 2 seems cause problems */
+		if (mec == 1 &amp;&amp; pipe &gt; 1)
+			continue;
+
+		ring-&gt;me = mec + 1;
+		ring-&gt;pipe = pipe;
+		ring-&gt;queue = queue;
+
+		return 0;
+	}
+
+	dev_err(adev-&gt;dev, "Failed to find a queue for KIQ\n");
+	return -EINVAL;
+}
+
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
+			     struct amdgpu_ring *ring,
+			     struct amdgpu_irq_src *irq)
+{
+	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
+	int r = 0;
+
+	mutex_init(&amp;kiq-&gt;ring_mutex);
+
+	r = amdgpu_wb_get(adev, &amp;adev-&gt;virt.reg_val_offs);
+	if (r)
+		return r;
+
+	ring-&gt;adev = NULL;
+	ring-&gt;ring_obj = NULL;
+	ring-&gt;use_doorbell = true;
+	ring-&gt;doorbell_index = AMDGPU_DOORBELL_KIQ;
+
+	r = amdgpu_gfx_kiq_acquire(adev, ring);
+	if (r)
+		return r;
+
+	ring-&gt;eop_gpu_addr = kiq-&gt;eop_gpu_addr;
+	sprintf(ring-&gt;name, "kiq %d.%d.%d", ring-&gt;me, ring-&gt;pipe, ring-&gt;queue);
+	r = amdgpu_ring_init(adev, ring, 1024,
+			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
+	if (r)
+		dev_warn(adev-&gt;dev, "(%d) failed to init kiq ring\n", r);
+
+	return r;
+}
+
+void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring,
+			      struct amdgpu_irq_src *irq)
+{
+	amdgpu_wb_free(ring-&gt;adev, ring-&gt;adev-&gt;virt.reg_val_offs);
+	amdgpu_ring_fini(ring);
+}
+
+void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
+
+	amdgpu_bo_free_kernel(&amp;kiq-&gt;eop_obj, &amp;kiq-&gt;eop_gpu_addr, NULL);
+}
+
+int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
+			unsigned hpd_size)
+{
+	int r;
+	u32 *hpd;
+	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
+
+	r = amdgpu_bo_create_kernel(adev, hpd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &amp;kiq-&gt;eop_obj,
+				    &amp;kiq-&gt;eop_gpu_addr, (void **)&amp;hpd);
+	if (r) {
+		dev_warn(adev-&gt;dev, "failed to create KIQ bo (%d).\n", r);
+		return r;
+	}
+
+	memset(hpd, 0, hpd_size);
+
+	r = amdgpu_bo_reserve(kiq-&gt;eop_obj, true);
+	if (unlikely(r != 0))
+		dev_warn(adev-&gt;dev, "(%d) reserve kiq eop bo failed\n", r);
+	amdgpu_bo_kunmap(kiq-&gt;eop_obj);
+	amdgpu_bo_unreserve(kiq-&gt;eop_obj);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fa20438..b1766fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -32,6 +32,17 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev);
 
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
+			     struct amdgpu_ring *ring,
+			     struct amdgpu_irq_src *irq);
+
+void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring,
+			      struct amdgpu_irq_src *irq);
+
+void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev);
+int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
+			unsigned hpd_size);
+
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc8e03b..8a9d35a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1379,76 +1379,6 @@ static void gfx_v8_0_mec_fini(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v8_0_kiq_acquire(struct amdgpu_device *adev,
-				 struct amdgpu_ring *ring)
-{
-	int queue_bit;
-	int mec, pipe, queue;
-
-	queue_bit = adev-&gt;gfx.mec.num_mec
-		    * adev-&gt;gfx.mec.num_pipe_per_mec
-		    * adev-&gt;gfx.mec.num_queue_per_pipe;
-
-	while (queue_bit-- &gt;= 0) {
-		if (test_bit(queue_bit, adev-&gt;gfx.mec.queue_bitmap))
-			continue;
-
-		amdgpu_gfx_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
-
-		/* Using pipes 2/3 from MEC 2 seems cause problems */
-		if (mec == 1 &amp;&amp; pipe &gt; 1)
-			continue;
-
-		ring-&gt;me = mec + 1;
-		ring-&gt;pipe = pipe;
-		ring-&gt;queue = queue;
-
-		return 0;
-	}
-
-	dev_err(adev-&gt;dev, "Failed to find a queue for KIQ\n");
-	return -EINVAL;
-}
-
-static int gfx_v8_0_kiq_init_ring(struct amdgpu_device *adev,
-				  struct amdgpu_ring *ring,
-				  struct amdgpu_irq_src *irq)
-{
-	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
-	int r = 0;
-
-	mutex_init(&amp;kiq-&gt;ring_mutex);
-
-	r = amdgpu_wb_get(adev, &amp;adev-&gt;virt.reg_val_offs);
-	if (r)
-		return r;
-
-	ring-&gt;adev = NULL;
-	ring-&gt;ring_obj = NULL;
-	ring-&gt;use_doorbell = true;
-	ring-&gt;doorbell_index = AMDGPU_DOORBELL_KIQ;
-
-	r = gfx_v8_0_kiq_acquire(adev, ring);
-	if (r)
-		return r;
-
-	ring-&gt;eop_gpu_addr = kiq-&gt;eop_gpu_addr;
-	sprintf(ring-&gt;name, "kiq %d.%d.%d", ring-&gt;me, ring-&gt;pipe, ring-&gt;queue);
-	r = amdgpu_ring_init(adev, ring, 1024,
-			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
-	if (r)
-		dev_warn(adev-&gt;dev, "(%d) failed to init kiq ring\n", r);
-
-	return r;
-}
-
-static void gfx_v8_0_kiq_free_ring(struct amdgpu_ring *ring,
-				   struct amdgpu_irq_src *irq)
-{
-	amdgpu_wb_free(ring-&gt;adev, ring-&gt;adev-&gt;virt.reg_val_offs);
-	amdgpu_ring_fini(ring);
-}
-
 static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -1520,38 +1450,6 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v8_0_kiq_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
-
-	amdgpu_bo_free_kernel(&amp;kiq-&gt;eop_obj, &amp;kiq-&gt;eop_gpu_addr, NULL);
-}
-
-static int gfx_v8_0_kiq_init(struct amdgpu_device *adev)
-{
-	int r;
-	u32 *hpd;
-	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
-
-	r = amdgpu_bo_create_kernel(adev, GFX8_MEC_HPD_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT, &amp;kiq-&gt;eop_obj,
-				    &amp;kiq-&gt;eop_gpu_addr, (void **)&amp;hpd);
-	if (r) {
-		dev_warn(adev-&gt;dev, "failed to create KIQ bo (%d).\n", r);
-		return r;
-	}
-
-	memset(hpd, 0, GFX8_MEC_HPD_SIZE);
-
-	r = amdgpu_bo_reserve(kiq-&gt;eop_obj, true);
-	if (unlikely(r != 0))
-		dev_warn(adev-&gt;dev, "(%d) reserve kiq eop bo failed\n", r);
-	amdgpu_bo_kunmap(kiq-&gt;eop_obj);
-	amdgpu_bo_unreserve(kiq-&gt;eop_obj);
-
-	return 0;
-}
-
 static const u32 vgpr_init_compute_shader[] =
 {
 	0x7e000209, 0x7e020208,
@@ -2192,14 +2090,14 @@ static int gfx_v8_0_sw_init(void *handle)
 		}
 	}
 
-	r = gfx_v8_0_kiq_init(adev);
+	r = amdgpu_gfx_kiq_init(adev, GFX8_MEC_HPD_SIZE);
 	if (r) {
 		DRM_ERROR("Failed to init KIQ BOs!\n");
 		return r;
 	}
 
 	kiq = &amp;adev-&gt;gfx.kiq;
-	r = gfx_v8_0_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);
+	r = amdgpu_gfx_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);
 	if (r)
 		return r;
 
@@ -2251,8 +2149,8 @@ static int gfx_v8_0_sw_fini(void *handle)
 		amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);
 
 	gfx_v8_0_compute_mqd_sw_fini(adev);
-	gfx_v8_0_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);
-	gfx_v8_0_kiq_fini(adev);
+	amdgpu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);
+	amdgpu_gfx_kiq_fini(adev);
 
 	gfx_v8_0_mec_fini(adev);
 	gfx_v8_0_rlc_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6d30476..fbb9d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -969,107 +969,6 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_0_kiq_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
-
-	amdgpu_bo_free_kernel(&amp;kiq-&gt;eop_obj, &amp;kiq-&gt;eop_gpu_addr, NULL);
-}
-
-static int gfx_v9_0_kiq_init(struct amdgpu_device *adev)
-{
-	int r;
-	u32 *hpd;
-	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
-
-	r = amdgpu_bo_create_kernel(adev, GFX9_MEC_HPD_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT, &amp;kiq-&gt;eop_obj,
-				    &amp;kiq-&gt;eop_gpu_addr, (void **)&amp;hpd);
-	if (r) {
-		dev_warn(adev-&gt;dev, "failed to create KIQ bo (%d).\n", r);
-		return r;
-	}
-
-	memset(hpd, 0, GFX9_MEC_HPD_SIZE);
-
-	r = amdgpu_bo_reserve(kiq-&gt;eop_obj, true);
-	if (unlikely(r != 0))
-		dev_warn(adev-&gt;dev, "(%d) reserve kiq eop bo failed\n", r);
-	amdgpu_bo_kunmap(kiq-&gt;eop_obj);
-	amdgpu_bo_unreserve(kiq-&gt;eop_obj);
-
-	return 0;
-}
-
-static int gfx_v9_0_kiq_acquire(struct amdgpu_device *adev,
-				 struct amdgpu_ring *ring)
-{
-	int queue_bit;
-	int mec, pipe, queue;
-
-	queue_bit = adev-&gt;gfx.mec.num_mec
-		    * adev-&gt;gfx.mec.num_pipe_per_mec
-		    * adev-&gt;gfx.mec.num_queue_per_pipe;
-
-	while (queue_bit-- &gt;= 0) {
-		if (test_bit(queue_bit, adev-&gt;gfx.mec.queue_bitmap))
-			continue;
-
-		amdgpu_gfx_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
-
-		/* Using pipes 2/3 from MEC 2 seems cause problems */
-		if (mec == 1 &amp;&amp; pipe &gt; 1)
-			continue;
-
-		ring-&gt;me = mec + 1;
-		ring-&gt;pipe = pipe;
-		ring-&gt;queue = queue;
-
-		return 0;
-	}
-
-	dev_err(adev-&gt;dev, "Failed to find a queue for KIQ\n");
-	return -EINVAL;
-}
-
-static int gfx_v9_0_kiq_init_ring(struct amdgpu_device *adev,
-				  struct amdgpu_ring *ring,
-				  struct amdgpu_irq_src *irq)
-{
-	struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;
-	int r = 0;
-
-	mutex_init(&amp;kiq-&gt;ring_mutex);
-
-	r = amdgpu_wb_get(adev, &amp;adev-&gt;virt.reg_val_offs);
-	if (r)
-		return r;
-
-	ring-&gt;adev = NULL;
-	ring-&gt;ring_obj = NULL;
-	ring-&gt;use_doorbell = true;
-	ring-&gt;doorbell_index = AMDGPU_DOORBELL_KIQ;
-
-	r = gfx_v9_0_kiq_acquire(adev, ring);
-	if (r)
-		return r;
-
-	ring-&gt;eop_gpu_addr = kiq-&gt;eop_gpu_addr;
-	sprintf(ring-&gt;name, "kiq %d.%d.%d", ring-&gt;me, ring-&gt;pipe, ring-&gt;queue);
-	r = amdgpu_ring_init(adev, ring, 1024,
-			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
-	if (r)
-		dev_warn(adev-&gt;dev, "(%d) failed to init kiq ring\n", r);
-
-	return r;
-}
-static void gfx_v9_0_kiq_free_ring(struct amdgpu_ring *ring,
-				   struct amdgpu_irq_src *irq)
-{
-	amdgpu_wb_free(ring-&gt;adev, ring-&gt;adev-&gt;virt.reg_val_offs);
-	amdgpu_ring_fini(ring);
-}
-
 /* create MQD for each compute queue */
 static int gfx_v9_0_compute_mqd_sw_init(struct amdgpu_device *adev)
 {
@@ -1570,14 +1469,14 @@ static int gfx_v9_0_sw_init(void *handle)
 		}
 	}
 
-	r = gfx_v9_0_kiq_init(adev);
+	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE);
 	if (r) {
 		DRM_ERROR("Failed to init KIQ BOs!\n");
 		return r;
 	}
 
 	kiq = &amp;adev-&gt;gfx.kiq;
-	r = gfx_v9_0_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);
+	r = amdgpu_gfx_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);
 	if (r)
 		return r;
 
@@ -1632,8 +1531,8 @@ static int gfx_v9_0_sw_fini(void *handle)
 		amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);
 
 	gfx_v9_0_compute_mqd_sw_fini(adev);
-	gfx_v9_0_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);
-	gfx_v9_0_kiq_fini(adev);
+	amdgpu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);
+	amdgpu_gfx_kiq_fini(adev);
 
 	gfx_v9_0_mec_fini(adev);
 	gfx_v9_0_ngg_fini(adev);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C6D5C0504D2C2EA57BEC453E--

--===============1852521151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1852521151==--
