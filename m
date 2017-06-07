From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx: consolidate mqd buffer setup code
Date: Wed, 7 Jun 2017 18:04:21 -0400
Message-ID: <5638425d-835b-ebb6-72cc-695c5cc52fd9@amd.com>
References: <1496864097-4322-1-git-send-email-alexander.deucher@amd.com>
 <1496864097-4322-6-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0061931008=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496864097-4322-6-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============0061931008==
Content-Type: multipart/alternative;
 boundary="------------A3528FA6677584EDDD5D997B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A3528FA6677584EDDD5D997B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 03:34 PM, Alex Deucher wrote:
> It was duplicated across multiple generations.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 66 ++++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 71 +--------------------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 65 +-----------------------------
>   4 files changed, 74 insertions(+), 132 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c5aa465..dfbf027 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -248,3 +248,69 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
> +
> +/* create MQD for each compute queue */
> +int amdgpu_gfx_compute_mqd_sw_init(struct amdgpu_device *adev,
> +				   unsigned mqd_size)
> +{
> +	struct amdgpu_ring *ring = NULL;
> +	int r, i;
> +
> +	/* create MQD for KIQ */
> +	ring = &adev->gfx.kiq.ring;
> +	if (!ring->mqd_obj) {
> +		r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +					    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> +					    &ring->mqd_gpu_addr, &ring->mqd_ptr);
> +		if (r) {
> +			dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> +			return r;
> +		}
> +
> +		/* prepare MQD backup */
> +		adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(mqd_size, GFP_KERNEL);
> +		if (!adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
> +				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> +	}
> +
> +	/* create MQD for each KCQ */
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		ring = &adev->gfx.compute_ring[i];
> +		if (!ring->mqd_obj) {
> +			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> +						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
> +			if (r) {
> +				dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> +				return r;
> +			}
> +
> +			/* prepare MQD backup */
> +			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
> +			if (!adev->gfx.mec.mqd_backup[i])
> +				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *ring = NULL;
> +	int i;
> +
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		ring = &adev->gfx.compute_ring[i];
> +		kfree(adev->gfx.mec.mqd_backup[i]);
> +		amdgpu_bo_free_kernel(&ring->mqd_obj,
> +				      &ring->mqd_gpu_addr,
> +				      &ring->mqd_ptr);
> +	}
> +
> +	ring = &adev->gfx.kiq.ring;
> +	kfree(adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
> +	amdgpu_bo_free_kernel(&ring->mqd_obj,
> +			      &ring->mqd_gpu_addr,
> +			      &ring->mqd_ptr);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index b1766fa..1f27905 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -43,6 +43,10 @@ void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev);
>   int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
>   			unsigned hpd_size);
>   
> +int amdgpu_gfx_compute_mqd_sw_init(struct amdgpu_device *adev,
> +				   unsigned mqd_size);
> +void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_device *adev);
> +
>   /**
>    * amdgpu_gfx_create_bitmask - create a bitmask
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 97d39369..6e541af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -659,8 +659,6 @@ static u32 gfx_v8_0_get_csb_size(struct amdgpu_device *adev);
>   static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev);
>   static void gfx_v8_0_ring_emit_ce_meta(struct amdgpu_ring *ring);
>   static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> -static int gfx_v8_0_compute_mqd_sw_init(struct amdgpu_device *adev);
> -static void gfx_v8_0_compute_mqd_sw_fini(struct amdgpu_device *adev);
>   
>   static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
>   {
> @@ -2102,7 +2100,7 @@ static int gfx_v8_0_sw_init(void *handle)
>   		return r;
>   
>   	/* create MQD for all compute queues as well as KIQ for SRIOV case */
> -	r = gfx_v8_0_compute_mqd_sw_init(adev);
> +	r = amdgpu_gfx_compute_mqd_sw_init(adev, sizeof(struct vi_mqd));
>   	if (r)
>   		return r;
>   
> @@ -2148,7 +2146,7 @@ static int gfx_v8_0_sw_fini(void *handle)
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>   
> -	gfx_v8_0_compute_mqd_sw_fini(adev);
> +	amdgpu_gfx_compute_mqd_sw_fini(adev);
>   	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
>   	amdgpu_gfx_kiq_fini(adev);
>   
> @@ -7146,68 +7144,3 @@ static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, upper_32_bits(de_payload_addr));
>   	amdgpu_ring_write_multiple(ring, (void *)&de_payload, cnt_de - 2);
>   }
> -
> -/* create MQD for each compute queue */
> -static int gfx_v8_0_compute_mqd_sw_init(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ring *ring = NULL;
> -	int r, i;
> -
> -	/* create MQD for KIQ */
> -	ring = &adev->gfx.kiq.ring;
> -	if (!ring->mqd_obj) {
> -		r = amdgpu_bo_create_kernel(adev, sizeof(struct vi_mqd), PAGE_SIZE,
> -					    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> -					    &ring->mqd_gpu_addr, &ring->mqd_ptr);
> -		if (r) {
> -			dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> -			return r;
> -		}
> -
> -		/* prepare MQD backup */
> -		adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(sizeof(struct vi_mqd), GFP_KERNEL);
> -		if (!adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
> -				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> -	}
> -
> -	/* create MQD for each KCQ */
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		if (!ring->mqd_obj) {
> -			r = amdgpu_bo_create_kernel(adev, sizeof(struct vi_mqd), PAGE_SIZE,
> -						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> -						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
> -			if (r) {
> -				dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> -				return r;
> -			}
> -
> -			/* prepare MQD backup */
> -			adev->gfx.mec.mqd_backup[i] = kmalloc(sizeof(struct vi_mqd), GFP_KERNEL);
> -			if (!adev->gfx.mec.mqd_backup[i])
> -				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void gfx_v8_0_compute_mqd_sw_fini(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ring *ring = NULL;
> -	int i;
> -
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		kfree(adev->gfx.mec.mqd_backup[i]);
> -		amdgpu_bo_free_kernel(&ring->mqd_obj,
> -				      &ring->mqd_gpu_addr,
> -				      &ring->mqd_ptr);
> -	}
> -
> -	ring = &adev->gfx.kiq.ring;
> -	kfree(adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
> -	amdgpu_bo_free_kernel(&ring->mqd_obj,
> -			      &ring->mqd_gpu_addr,
> -			      &ring->mqd_ptr);
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b7094c3..375620a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -956,67 +956,6 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -/* create MQD for each compute queue */
> -static int gfx_v9_0_compute_mqd_sw_init(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ring *ring = NULL;
> -	int r, i;
> -
> -	/* create MQD for KIQ */
> -	ring = &adev->gfx.kiq.ring;
> -	if (!ring->mqd_obj) {
> -		r = amdgpu_bo_create_kernel(adev, sizeof(struct v9_mqd), PAGE_SIZE,
> -					    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> -					    &ring->mqd_gpu_addr, (void **)&ring->mqd_ptr);
> -		if (r) {
> -			dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> -			return r;
> -		}
> -
> -		/* prepare MQD backup */
> -		adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(sizeof(struct v9_mqd), GFP_KERNEL);
> -		if (!adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
> -			dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> -	}
> -
> -	/* create MQD for each KCQ */
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		if (!ring->mqd_obj) {
> -			r = amdgpu_bo_create_kernel(adev, sizeof(struct v9_mqd), PAGE_SIZE,
> -						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> -						    &ring->mqd_gpu_addr, (void **)&ring->mqd_ptr);
> -			if (r) {
> -				dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
> -				return r;
> -			}
> -
> -			/* prepare MQD backup */
> -			adev->gfx.mec.mqd_backup[i] = kmalloc(sizeof(struct v9_mqd), GFP_KERNEL);
> -			if (!adev->gfx.mec.mqd_backup[i])
> -				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void gfx_v9_0_compute_mqd_sw_fini(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ring *ring = NULL;
> -	int i;
> -
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		kfree(adev->gfx.mec.mqd_backup[i]);
> -		amdgpu_bo_free_kernel(&ring->mqd_obj, &ring->mqd_gpu_addr, (void **)&ring->mqd_ptr);
> -	}
> -
> -	ring = &adev->gfx.kiq.ring;
> -	kfree(adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
> -	amdgpu_bo_free_kernel(&ring->mqd_obj, &ring->mqd_gpu_addr, (void **)&ring->mqd_ptr);
> -}
> -
>   static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
>   {
>   	WREG32_SOC15(GC, 0, mmSQ_IND_INDEX,
> @@ -1481,7 +1420,7 @@ static int gfx_v9_0_sw_init(void *handle)
>   		return r;
>   
>   	/* create MQD for all compute queues as wel as KIQ for SRIOV case */
> -	r = gfx_v9_0_compute_mqd_sw_init(adev);
> +	r = amdgpu_gfx_compute_mqd_sw_init(adev, sizeof(struct v9_mqd));
>   	if (r)
>   		return r;
>   
> @@ -1530,7 +1469,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>   
> -	gfx_v9_0_compute_mqd_sw_fini(adev);
> +	amdgpu_gfx_compute_mqd_sw_fini(adev);
>   	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
>   	amdgpu_gfx_kiq_fini(adev);
>   


--------------A3528FA6677584EDDD5D997B
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
      cite="mid:1496864097-4322-6-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">It was duplicated across multiple generations.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 66 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 71 +--------------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 65 +-----------------------------
 4 files changed, 74 insertions(+), 132 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c5aa465..dfbf027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -248,3 +248,69 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+/* create MQD for each compute queue */
+int amdgpu_gfx_compute_mqd_sw_init(struct amdgpu_device *adev,
+				   unsigned mqd_size)
+{
+	struct amdgpu_ring *ring = NULL;
+	int r, i;
+
+	/* create MQD for KIQ */
+	ring = &amp;adev-&gt;gfx.kiq.ring;
+	if (!ring-&gt;mqd_obj) {
+		r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT, &amp;ring-&gt;mqd_obj,
+					    &amp;ring-&gt;mqd_gpu_addr, &amp;ring-&gt;mqd_ptr);
+		if (r) {
+			dev_warn(adev-&gt;dev, "failed to create ring mqd ob (%d)", r);
+			return r;
+		}
+
+		/* prepare MQD backup */
+		adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(mqd_size, GFP_KERNEL);
+		if (!adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
+				dev_warn(adev-&gt;dev, "no memory to create MQD backup for ring %s\n", ring-&gt;name);
+	}
+
+	/* create MQD for each KCQ */
+	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
+		ring = &amp;adev-&gt;gfx.compute_ring[i];
+		if (!ring-&gt;mqd_obj) {
+			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+						    AMDGPU_GEM_DOMAIN_GTT, &amp;ring-&gt;mqd_obj,
+						    &amp;ring-&gt;mqd_gpu_addr, &amp;ring-&gt;mqd_ptr);
+			if (r) {
+				dev_warn(adev-&gt;dev, "failed to create ring mqd ob (%d)", r);
+				return r;
+			}
+
+			/* prepare MQD backup */
+			adev-&gt;gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
+			if (!adev-&gt;gfx.mec.mqd_backup[i])
+				dev_warn(adev-&gt;dev, "no memory to create MQD backup for ring %s\n", ring-&gt;name);
+		}
+	}
+
+	return 0;
+}
+
+void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = NULL;
+	int i;
+
+	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
+		ring = &amp;adev-&gt;gfx.compute_ring[i];
+		kfree(adev-&gt;gfx.mec.mqd_backup[i]);
+		amdgpu_bo_free_kernel(&amp;ring-&gt;mqd_obj,
+				      &amp;ring-&gt;mqd_gpu_addr,
+				      &amp;ring-&gt;mqd_ptr);
+	}
+
+	ring = &amp;adev-&gt;gfx.kiq.ring;
+	kfree(adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
+	amdgpu_bo_free_kernel(&amp;ring-&gt;mqd_obj,
+			      &amp;ring-&gt;mqd_gpu_addr,
+			      &amp;ring-&gt;mqd_ptr);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index b1766fa..1f27905 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -43,6 +43,10 @@ void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 			unsigned hpd_size);
 
+int amdgpu_gfx_compute_mqd_sw_init(struct amdgpu_device *adev,
+				   unsigned mqd_size);
+void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_device *adev);
+
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 97d39369..6e541af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -659,8 +659,6 @@ static u32 gfx_v8_0_get_csb_size(struct amdgpu_device *adev);
 static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev);
 static void gfx_v8_0_ring_emit_ce_meta(struct amdgpu_ring *ring);
 static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_ring *ring);
-static int gfx_v8_0_compute_mqd_sw_init(struct amdgpu_device *adev);
-static void gfx_v8_0_compute_mqd_sw_fini(struct amdgpu_device *adev);
 
 static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
 {
@@ -2102,7 +2100,7 @@ static int gfx_v8_0_sw_init(void *handle)
 		return r;
 
 	/* create MQD for all compute queues as well as KIQ for SRIOV case */
-	r = gfx_v8_0_compute_mqd_sw_init(adev);
+	r = amdgpu_gfx_compute_mqd_sw_init(adev, sizeof(struct vi_mqd));
 	if (r)
 		return r;
 
@@ -2148,7 +2146,7 @@ static int gfx_v8_0_sw_fini(void *handle)
 	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);
 
-	gfx_v8_0_compute_mqd_sw_fini(adev);
+	amdgpu_gfx_compute_mqd_sw_fini(adev);
 	amdgpu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);
 	amdgpu_gfx_kiq_fini(adev);
 
@@ -7146,68 +7144,3 @@ static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, upper_32_bits(de_payload_addr));
 	amdgpu_ring_write_multiple(ring, (void *)&amp;de_payload, cnt_de - 2);
 }
-
-/* create MQD for each compute queue */
-static int gfx_v8_0_compute_mqd_sw_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring = NULL;
-	int r, i;
-
-	/* create MQD for KIQ */
-	ring = &amp;adev-&gt;gfx.kiq.ring;
-	if (!ring-&gt;mqd_obj) {
-		r = amdgpu_bo_create_kernel(adev, sizeof(struct vi_mqd), PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_GTT, &amp;ring-&gt;mqd_obj,
-					    &amp;ring-&gt;mqd_gpu_addr, &amp;ring-&gt;mqd_ptr);
-		if (r) {
-			dev_warn(adev-&gt;dev, "failed to create ring mqd ob (%d)", r);
-			return r;
-		}
-
-		/* prepare MQD backup */
-		adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(sizeof(struct vi_mqd), GFP_KERNEL);
-		if (!adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
-				dev_warn(adev-&gt;dev, "no memory to create MQD backup for ring %s\n", ring-&gt;name);
-	}
-
-	/* create MQD for each KCQ */
-	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
-		ring = &amp;adev-&gt;gfx.compute_ring[i];
-		if (!ring-&gt;mqd_obj) {
-			r = amdgpu_bo_create_kernel(adev, sizeof(struct vi_mqd), PAGE_SIZE,
-						    AMDGPU_GEM_DOMAIN_GTT, &amp;ring-&gt;mqd_obj,
-						    &amp;ring-&gt;mqd_gpu_addr, &amp;ring-&gt;mqd_ptr);
-			if (r) {
-				dev_warn(adev-&gt;dev, "failed to create ring mqd ob (%d)", r);
-				return r;
-			}
-
-			/* prepare MQD backup */
-			adev-&gt;gfx.mec.mqd_backup[i] = kmalloc(sizeof(struct vi_mqd), GFP_KERNEL);
-			if (!adev-&gt;gfx.mec.mqd_backup[i])
-				dev_warn(adev-&gt;dev, "no memory to create MQD backup for ring %s\n", ring-&gt;name);
-		}
-	}
-
-	return 0;
-}
-
-static void gfx_v8_0_compute_mqd_sw_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring = NULL;
-	int i;
-
-	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
-		ring = &amp;adev-&gt;gfx.compute_ring[i];
-		kfree(adev-&gt;gfx.mec.mqd_backup[i]);
-		amdgpu_bo_free_kernel(&amp;ring-&gt;mqd_obj,
-				      &amp;ring-&gt;mqd_gpu_addr,
-				      &amp;ring-&gt;mqd_ptr);
-	}
-
-	ring = &amp;adev-&gt;gfx.kiq.ring;
-	kfree(adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
-	amdgpu_bo_free_kernel(&amp;ring-&gt;mqd_obj,
-			      &amp;ring-&gt;mqd_gpu_addr,
-			      &amp;ring-&gt;mqd_ptr);
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b7094c3..375620a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -956,67 +956,6 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-/* create MQD for each compute queue */
-static int gfx_v9_0_compute_mqd_sw_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring = NULL;
-	int r, i;
-
-	/* create MQD for KIQ */
-	ring = &amp;adev-&gt;gfx.kiq.ring;
-	if (!ring-&gt;mqd_obj) {
-		r = amdgpu_bo_create_kernel(adev, sizeof(struct v9_mqd), PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_GTT, &amp;ring-&gt;mqd_obj,
-					    &amp;ring-&gt;mqd_gpu_addr, (void **)&amp;ring-&gt;mqd_ptr);
-		if (r) {
-			dev_warn(adev-&gt;dev, "failed to create ring mqd ob (%d)", r);
-			return r;
-		}
-
-		/* prepare MQD backup */
-		adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(sizeof(struct v9_mqd), GFP_KERNEL);
-		if (!adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
-			dev_warn(adev-&gt;dev, "no memory to create MQD backup for ring %s\n", ring-&gt;name);
-	}
-
-	/* create MQD for each KCQ */
-	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
-		ring = &amp;adev-&gt;gfx.compute_ring[i];
-		if (!ring-&gt;mqd_obj) {
-			r = amdgpu_bo_create_kernel(adev, sizeof(struct v9_mqd), PAGE_SIZE,
-						    AMDGPU_GEM_DOMAIN_GTT, &amp;ring-&gt;mqd_obj,
-						    &amp;ring-&gt;mqd_gpu_addr, (void **)&amp;ring-&gt;mqd_ptr);
-			if (r) {
-				dev_warn(adev-&gt;dev, "failed to create ring mqd ob (%d)", r);
-				return r;
-			}
-
-			/* prepare MQD backup */
-			adev-&gt;gfx.mec.mqd_backup[i] = kmalloc(sizeof(struct v9_mqd), GFP_KERNEL);
-			if (!adev-&gt;gfx.mec.mqd_backup[i])
-				dev_warn(adev-&gt;dev, "no memory to create MQD backup for ring %s\n", ring-&gt;name);
-		}
-	}
-
-	return 0;
-}
-
-static void gfx_v9_0_compute_mqd_sw_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring = NULL;
-	int i;
-
-	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
-		ring = &amp;adev-&gt;gfx.compute_ring[i];
-		kfree(adev-&gt;gfx.mec.mqd_backup[i]);
-		amdgpu_bo_free_kernel(&amp;ring-&gt;mqd_obj, &amp;ring-&gt;mqd_gpu_addr, (void **)&amp;ring-&gt;mqd_ptr);
-	}
-
-	ring = &amp;adev-&gt;gfx.kiq.ring;
-	kfree(adev-&gt;gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
-	amdgpu_bo_free_kernel(&amp;ring-&gt;mqd_obj, &amp;ring-&gt;mqd_gpu_addr, (void **)&amp;ring-&gt;mqd_ptr);
-}
-
 static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
 {
 	WREG32_SOC15(GC, 0, mmSQ_IND_INDEX,
@@ -1481,7 +1420,7 @@ static int gfx_v9_0_sw_init(void *handle)
 		return r;
 
 	/* create MQD for all compute queues as wel as KIQ for SRIOV case */
-	r = gfx_v9_0_compute_mqd_sw_init(adev);
+	r = amdgpu_gfx_compute_mqd_sw_init(adev, sizeof(struct v9_mqd));
 	if (r)
 		return r;
 
@@ -1530,7 +1469,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 	for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);
 
-	gfx_v9_0_compute_mqd_sw_fini(adev);
+	amdgpu_gfx_compute_mqd_sw_fini(adev);
 	amdgpu_gfx_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);
 	amdgpu_gfx_kiq_fini(adev);
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------A3528FA6677584EDDD5D997B--

--===============0061931008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0061931008==--
