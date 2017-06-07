From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu/gfx: move mec parameter setup into sw_init
Date: Wed, 7 Jun 2017 18:03:45 -0400
Message-ID: <3d3ba859-7414-daeb-b38e-3338330b79c3@amd.com>
References: <1496864097-4322-1-git-send-email-alexander.deucher@amd.com>
 <1496864097-4322-5-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1327028372=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496864097-4322-5-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1327028372==
Content-Type: multipart/alternative;
 boundary="------------2FE7E9D7BDA7F976E0ABE0BD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2FE7E9D7BDA7F976E0ABE0BD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

On 2017-06-07 03:34 PM, Alex Deucher wrote:
> This will allow us to share more mec code.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 30 +++++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 38 +++++++++++++++++------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 26 ++++++++++++------------
>   3 files changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index d80cf72..e30c7d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2817,21 +2817,6 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
>   
>   	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_KAVERI:
> -		adev->gfx.mec.num_mec = 2;
> -		break;
> -	case CHIP_BONAIRE:
> -	case CHIP_HAWAII:
> -	case CHIP_KABINI:
> -	case CHIP_MULLINS:
> -	default:
> -		adev->gfx.mec.num_mec = 1;
> -		break;
> -	}
> -	adev->gfx.mec.num_pipe_per_mec = 4;
> -	adev->gfx.mec.num_queue_per_pipe = 8;
> -
>   	/* take ownership of the relevant compute queues */
>   	amdgpu_gfx_compute_queue_acquire(adev);
>   
> @@ -4723,6 +4708,21 @@ static int gfx_v7_0_sw_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int i, j, k, r, ring_id;
>   
> +	switch (adev->asic_type) {
> +	case CHIP_KAVERI:
> +		adev->gfx.mec.num_mec = 2;
> +		break;
> +	case CHIP_BONAIRE:
> +	case CHIP_HAWAII:
> +	case CHIP_KABINI:
> +	case CHIP_MULLINS:
> +	default:
> +		adev->gfx.mec.num_mec = 1;
> +		break;
> +	}
> +	adev->gfx.mec.num_pipe_per_mec = 4;
> +	adev->gfx.mec.num_queue_per_pipe = 8;
> +
>   	/* EOP Event */
>   	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_LEGACY, 181, &adev->gfx.eop_irq);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8a9d35a..97d39369 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1387,25 +1387,6 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   
>   	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_FIJI:
> -	case CHIP_TONGA:
> -	case CHIP_POLARIS11:
> -	case CHIP_POLARIS12:
> -	case CHIP_POLARIS10:
> -	case CHIP_CARRIZO:
> -		adev->gfx.mec.num_mec = 2;
> -		break;
> -	case CHIP_TOPAZ:
> -	case CHIP_STONEY:
> -	default:
> -		adev->gfx.mec.num_mec = 1;
> -		break;
> -	}
> -
> -	adev->gfx.mec.num_pipe_per_mec = 4;
> -	adev->gfx.mec.num_queue_per_pipe = 8;
> -
>   	/* take ownership of the relevant compute queues */
>   	amdgpu_gfx_compute_queue_acquire(adev);
>   
> @@ -2009,6 +1990,25 @@ static int gfx_v8_0_sw_init(void *handle)
>   	struct amdgpu_kiq *kiq;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	switch (adev->asic_type) {
> +	case CHIP_FIJI:
> +	case CHIP_TONGA:
> +	case CHIP_POLARIS11:
> +	case CHIP_POLARIS12:
> +	case CHIP_POLARIS10:
> +	case CHIP_CARRIZO:
> +		adev->gfx.mec.num_mec = 2;
> +		break;
> +	case CHIP_TOPAZ:
> +	case CHIP_STONEY:
> +	default:
> +		adev->gfx.mec.num_mec = 1;
> +		break;
> +	}
> +
> +	adev->gfx.mec.num_pipe_per_mec = 4;
> +	adev->gfx.mec.num_queue_per_pipe = 8;
> +
>   	/* KIQ event */
>   	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_LEGACY, 178, &adev->gfx.kiq.irq);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index fbb9d20..b7094c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -870,19 +870,6 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   
>   	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA10:
> -	case CHIP_RAVEN:
> -		adev->gfx.mec.num_mec = 2;
> -		break;
> -	default:
> -		adev->gfx.mec.num_mec = 1;
> -		break;
> -	}
> -
> -	adev->gfx.mec.num_pipe_per_mec = 4;
> -	adev->gfx.mec.num_queue_per_pipe = 8;
> -
>   	/* take ownership of the relevant compute queues */
>   	amdgpu_gfx_compute_queue_acquire(adev);
>   	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
> @@ -1393,6 +1380,19 @@ static int gfx_v9_0_sw_init(void *handle)
>   	struct amdgpu_kiq *kiq;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA10:
> +	case CHIP_RAVEN:
> +		adev->gfx.mec.num_mec = 2;
> +		break;
> +	default:
> +		adev->gfx.mec.num_mec = 1;
> +		break;
> +	}
> +
> +	adev->gfx.mec.num_pipe_per_mec = 4;
> +	adev->gfx.mec.num_queue_per_pipe = 8;
> +
>   	/* KIQ event */
>   	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_GRBM_CP, 178, &adev->gfx.kiq.irq);
>   	if (r)


--------------2FE7E9D7BDA7F976E0ABE0BD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Reviewed-by: Alex Xie <a class="moz-txt-link-rfc2396E"
      href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    <br>
    <div class="moz-cite-prefix">On 2017-06-07 03:34 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1496864097-4322-5-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">This will allow us to share more mec code.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 30 +++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 38 +++++++++++++++++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 26 ++++++++++++------------
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index d80cf72..e30c7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2817,21 +2817,6 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 
 	bitmap_zero(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
-	switch (adev-&gt;asic_type) {
-	case CHIP_KAVERI:
-		adev-&gt;gfx.mec.num_mec = 2;
-		break;
-	case CHIP_BONAIRE:
-	case CHIP_HAWAII:
-	case CHIP_KABINI:
-	case CHIP_MULLINS:
-	default:
-		adev-&gt;gfx.mec.num_mec = 1;
-		break;
-	}
-	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
-	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
-
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
 
@@ -4723,6 +4708,21 @@ static int gfx_v7_0_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i, j, k, r, ring_id;
 
+	switch (adev-&gt;asic_type) {
+	case CHIP_KAVERI:
+		adev-&gt;gfx.mec.num_mec = 2;
+		break;
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+	default:
+		adev-&gt;gfx.mec.num_mec = 1;
+		break;
+	}
+	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
+	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_LEGACY, 181, &amp;adev-&gt;gfx.eop_irq);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8a9d35a..97d39369 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1387,25 +1387,6 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 
 	bitmap_zero(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
-	switch (adev-&gt;asic_type) {
-	case CHIP_FIJI:
-	case CHIP_TONGA:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-	case CHIP_POLARIS10:
-	case CHIP_CARRIZO:
-		adev-&gt;gfx.mec.num_mec = 2;
-		break;
-	case CHIP_TOPAZ:
-	case CHIP_STONEY:
-	default:
-		adev-&gt;gfx.mec.num_mec = 1;
-		break;
-	}
-
-	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
-	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
-
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
 
@@ -2009,6 +1990,25 @@ static int gfx_v8_0_sw_init(void *handle)
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	switch (adev-&gt;asic_type) {
+	case CHIP_FIJI:
+	case CHIP_TONGA:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_POLARIS10:
+	case CHIP_CARRIZO:
+		adev-&gt;gfx.mec.num_mec = 2;
+		break;
+	case CHIP_TOPAZ:
+	case CHIP_STONEY:
+	default:
+		adev-&gt;gfx.mec.num_mec = 1;
+		break;
+	}
+
+	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
+	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
+
 	/* KIQ event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_LEGACY, 178, &amp;adev-&gt;gfx.kiq.irq);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fbb9d20..b7094c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -870,19 +870,6 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 
 	bitmap_zero(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
-	switch (adev-&gt;asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_RAVEN:
-		adev-&gt;gfx.mec.num_mec = 2;
-		break;
-	default:
-		adev-&gt;gfx.mec.num_mec = 1;
-		break;
-	}
-
-	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
-	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
-
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
 	mec_hpd_size = adev-&gt;gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
@@ -1393,6 +1380,19 @@ static int gfx_v9_0_sw_init(void *handle)
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	switch (adev-&gt;asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_RAVEN:
+		adev-&gt;gfx.mec.num_mec = 2;
+		break;
+	default:
+		adev-&gt;gfx.mec.num_mec = 1;
+		break;
+	}
+
+	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
+	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
+
 	/* KIQ event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_GRBM_CP, 178, &amp;adev-&gt;gfx.kiq.irq);
 	if (r)
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------2FE7E9D7BDA7F976E0ABE0BD--

--===============1327028372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1327028372==--
