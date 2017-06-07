From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: move gfx_v*_0_compute_queue_acquire to
 common code
Date: Wed, 7 Jun 2017 15:31:07 -0400
Message-ID: <91a1de32-cfd8-e416-c6dc-1af3c17eb7b9@amd.com>
References: <1496848229-12761-1-git-send-email-alexander.deucher@amd.com>
 <1496848229-12761-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1185083660=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496848229-12761-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1185083660==
Content-Type: multipart/alternative;
 boundary="------------84C8E645DA23B76DC0B1CFF4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------84C8E645DA23B76DC0B1CFF4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 11:10 AM, Alex Deucher wrote:
> Same function was duplicated in all gfx IP files.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 39 +--------------------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 39 +--------------------------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +--------------------------------
>   5 files changed, 42 insertions(+), 114 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1994335..51a9708 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -108,3 +108,40 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se, unsigned max_s
>   		p = next + 1;
>   	}
>   }
> +
> +void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
> +{
> +	int i, queue, pipe, mec;
> +
> +	/* policy for amdgpu compute queue ownership */
> +	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> +		queue = i % adev->gfx.mec.num_queue_per_pipe;
> +		pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> +			% adev->gfx.mec.num_pipe_per_mec;
> +		mec = (i / adev->gfx.mec.num_queue_per_pipe)
> +			/ adev->gfx.mec.num_pipe_per_mec;
> +
> +		/* we've run out of HW */
> +		if (mec >= adev->gfx.mec.num_mec)
> +			break;
> +
> +		if (adev->gfx.mec.num_mec > 1) {
> +			/* policy: amdgpu owns the first two queues of the first MEC */
> +			if (mec == 0 && queue < 2)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		} else {
> +			/* policy: amdgpu owns all queues in the first pipe */
> +			if (mec == 0 && pipe == 0)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		}
> +	}
> +
> +	/* update the number of active compute rings */
> +	adev->gfx.num_compute_rings =
> +		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> +
> +	/* If you hit this case and edited the policy, you probably just
> +	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> +	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> +		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 2d846ef..9b9ea6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -30,6 +30,8 @@ void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
>   void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
>   		unsigned max_sh);
>   
> +void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev);
> +
>   /**
>    * amdgpu_gfx_create_bitmask - create a bitmask
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 862bc72..6ffb2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2809,43 +2809,6 @@ static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
>   	}
>   }
>   
> -static void gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
> -{
> -	int i, queue, pipe, mec;
> -
> -	/* policy for amdgpu compute queue ownership */
> -	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> -		queue = i % adev->gfx.mec.num_queue_per_pipe;
> -		pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> -			% adev->gfx.mec.num_pipe_per_mec;
> -		mec = (i / adev->gfx.mec.num_queue_per_pipe)
> -			/ adev->gfx.mec.num_pipe_per_mec;
> -
> -		/* we've run out of HW */
> -		if (mec >= adev->gfx.mec.num_mec)
> -			break;
> -
> -		if (adev->gfx.mec.num_mec > 1) {
> -			/* policy: amdgpu owns the first two queues of the first MEC */
> -			if (mec == 0 && queue < 2)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		} else {
> -			/* policy: amdgpu owns all queues in the first pipe */
> -			if (mec == 0 && pipe == 0)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		}
> -	}
> -
> -	/* update the number of active compute rings */
> -	adev->gfx.num_compute_rings =
> -		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> -
> -	/* If you hit this case and edited the policy, you probably just
> -	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> -	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> -}
> -
>   static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
>   {
>   	int r;
> @@ -2870,7 +2833,7 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
>   	adev->gfx.mec.num_queue_per_pipe = 8;
>   
>   	/* take ownership of the relevant compute queues */
> -	gfx_v7_0_compute_queue_acquire(adev);
> +	amdgpu_gfx_compute_queue_acquire(adev);
>   
>   	/* allocate space for ALL pipes (even the ones we don't own) */
>   	mec_hpd_size = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 1370b39..cfa37f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1448,43 +1448,6 @@ static void gfx_v8_0_kiq_free_ring(struct amdgpu_ring *ring,
>   	amdgpu_ring_fini(ring);
>   }
>   
> -static void gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
> -{
> -	int i, queue, pipe, mec;
> -
> -	/* policy for amdgpu compute queue ownership */
> -	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> -		queue = i % adev->gfx.mec.num_queue_per_pipe;
> -		pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> -			% adev->gfx.mec.num_pipe_per_mec;
> -		mec = (i / adev->gfx.mec.num_queue_per_pipe)
> -			/ adev->gfx.mec.num_pipe_per_mec;
> -
> -		/* we've run out of HW */
> -		if (mec >= adev->gfx.mec.num_mec)
> -			break;
> -
> -		if (adev->gfx.mec.num_mec > 1) {
> -			/* policy: amdgpu owns the first two queues of the first MEC */
> -			if (mec == 0 && queue < 2)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		} else {
> -			/* policy: amdgpu owns all queues in the first pipe */
> -			if (mec == 0 && pipe == 0)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		}
> -	}
> -
> -	/* update the number of active compute rings */
> -	adev->gfx.num_compute_rings =
> -		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> -
> -	/* If you hit this case and edited the policy, you probably just
> -	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> -	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> -}
> -
>   static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   {
>   	int r;
> @@ -1513,7 +1476,7 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   	adev->gfx.mec.num_queue_per_pipe = 8;
>   
>   	/* take ownership of the relevant compute queues */
> -	gfx_v8_0_compute_queue_acquire(adev);
> +	amdgpu_gfx_compute_queue_acquire(adev);
>   
>   	mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 9d675b3..3ea0e71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -857,43 +857,6 @@ static void gfx_v9_0_mec_fini(struct amdgpu_device *adev)
>   	}
>   }
>   
> -static void gfx_v9_0_compute_queue_acquire(struct amdgpu_device *adev)
> -{
> -	int i, queue, pipe, mec;
> -
> -	/* policy for amdgpu compute queue ownership */
> -	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
> -		queue = i % adev->gfx.mec.num_queue_per_pipe;
> -		pipe = (i / adev->gfx.mec.num_queue_per_pipe)
> -			% adev->gfx.mec.num_pipe_per_mec;
> -		mec = (i / adev->gfx.mec.num_queue_per_pipe)
> -			/ adev->gfx.mec.num_pipe_per_mec;
> -
> -		/* we've run out of HW */
> -		if (mec >= adev->gfx.mec.num_mec)
> -			break;
> -
> -		if (adev->gfx.mec.num_mec > 1) {
> -			/* policy: amdgpu owns the first two queues of the first MEC */
> -			if (mec == 0 && queue < 2)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		} else {
> -			/* policy: amdgpu owns all queues in the first pipe */
> -			if (mec == 0 && pipe == 0)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> -		}
> -	}
> -
> -	/* update the number of active compute rings */
> -	adev->gfx.num_compute_rings =
> -		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> -
> -	/* If you hit this case and edited the policy, you probably just
> -	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> -	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> -}
> -
>   static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   {
>   	int r;
> @@ -920,7 +883,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   	adev->gfx.mec.num_queue_per_pipe = 8;
>   
>   	/* take ownership of the relevant compute queues */
> -	gfx_v9_0_compute_queue_acquire(adev);
> +	amdgpu_gfx_compute_queue_acquire(adev);
>   	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
>   
>   	if (adev->gfx.mec.hpd_eop_obj == NULL) {


--------------84C8E645DA23B76DC0B1CFF4
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
    <div class="moz-cite-prefix">On 2017-06-07 11:10 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1496848229-12761-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Same function was duplicated in all gfx IP files.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 39 +--------------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 39 +--------------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +--------------------------------
 5 files changed, 42 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1994335..51a9708 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -108,3 +108,40 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se, unsigned max_s
 		p = next + 1;
 	}
 }
+
+void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
+{
+	int i, queue, pipe, mec;
+
+	/* policy for amdgpu compute queue ownership */
+	for (i = 0; i &lt; AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
+		queue = i % adev-&gt;gfx.mec.num_queue_per_pipe;
+		pipe = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
+			% adev-&gt;gfx.mec.num_pipe_per_mec;
+		mec = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
+			/ adev-&gt;gfx.mec.num_pipe_per_mec;
+
+		/* we've run out of HW */
+		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
+			break;
+
+		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
+			/* policy: amdgpu owns the first two queues of the first MEC */
+			if (mec == 0 &amp;&amp; queue &lt; 2)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		} else {
+			/* policy: amdgpu owns all queues in the first pipe */
+			if (mec == 0 &amp;&amp; pipe == 0)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		}
+	}
+
+	/* update the number of active compute rings */
+	adev-&gt;gfx.num_compute_rings =
+		bitmap_weight(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+
+	/* If you hit this case and edited the policy, you probably just
+	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
+	if (WARN_ON(adev-&gt;gfx.num_compute_rings &gt; AMDGPU_MAX_COMPUTE_RINGS))
+		adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 2d846ef..9b9ea6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -30,6 +30,8 @@ void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
 		unsigned max_sh);
 
+void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev);
+
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 862bc72..6ffb2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2809,43 +2809,6 @@ static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
-{
-	int i, queue, pipe, mec;
-
-	/* policy for amdgpu compute queue ownership */
-	for (i = 0; i &lt; AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		queue = i % adev-&gt;gfx.mec.num_queue_per_pipe;
-		pipe = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
-			% adev-&gt;gfx.mec.num_pipe_per_mec;
-		mec = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
-			/ adev-&gt;gfx.mec.num_pipe_per_mec;
-
-		/* we've run out of HW */
-		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
-			break;
-
-		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
-			/* policy: amdgpu owns the first two queues of the first MEC */
-			if (mec == 0 &amp;&amp; queue &lt; 2)
-				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
-		} else {
-			/* policy: amdgpu owns all queues in the first pipe */
-			if (mec == 0 &amp;&amp; pipe == 0)
-				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
-		}
-	}
-
-	/* update the number of active compute rings */
-	adev-&gt;gfx.num_compute_rings =
-		bitmap_weight(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
-
-	/* If you hit this case and edited the policy, you probably just
-	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
-	if (WARN_ON(adev-&gt;gfx.num_compute_rings &gt; AMDGPU_MAX_COMPUTE_RINGS))
-		adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
-}
-
 static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -2870,7 +2833,7 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
 
 	/* take ownership of the relevant compute queues */
-	gfx_v7_0_compute_queue_acquire(adev);
+	amdgpu_gfx_compute_queue_acquire(adev);
 
 	/* allocate space for ALL pipes (even the ones we don't own) */
 	mec_hpd_size = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1370b39..cfa37f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1448,43 +1448,6 @@ static void gfx_v8_0_kiq_free_ring(struct amdgpu_ring *ring,
 	amdgpu_ring_fini(ring);
 }
 
-static void gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
-{
-	int i, queue, pipe, mec;
-
-	/* policy for amdgpu compute queue ownership */
-	for (i = 0; i &lt; AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		queue = i % adev-&gt;gfx.mec.num_queue_per_pipe;
-		pipe = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
-			% adev-&gt;gfx.mec.num_pipe_per_mec;
-		mec = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
-			/ adev-&gt;gfx.mec.num_pipe_per_mec;
-
-		/* we've run out of HW */
-		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
-			break;
-
-		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
-			/* policy: amdgpu owns the first two queues of the first MEC */
-			if (mec == 0 &amp;&amp; queue &lt; 2)
-				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
-		} else {
-			/* policy: amdgpu owns all queues in the first pipe */
-			if (mec == 0 &amp;&amp; pipe == 0)
-				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
-		}
-	}
-
-	/* update the number of active compute rings */
-	adev-&gt;gfx.num_compute_rings =
-		bitmap_weight(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
-
-	/* If you hit this case and edited the policy, you probably just
-	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
-	if (WARN_ON(adev-&gt;gfx.num_compute_rings &gt; AMDGPU_MAX_COMPUTE_RINGS))
-		adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
-}
-
 static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -1513,7 +1476,7 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
 
 	/* take ownership of the relevant compute queues */
-	gfx_v8_0_compute_queue_acquire(adev);
+	amdgpu_gfx_compute_queue_acquire(adev);
 
 	mec_hpd_size = adev-&gt;gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9d675b3..3ea0e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -857,43 +857,6 @@ static void gfx_v9_0_mec_fini(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v9_0_compute_queue_acquire(struct amdgpu_device *adev)
-{
-	int i, queue, pipe, mec;
-
-	/* policy for amdgpu compute queue ownership */
-	for (i = 0; i &lt; AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		queue = i % adev-&gt;gfx.mec.num_queue_per_pipe;
-		pipe = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
-			% adev-&gt;gfx.mec.num_pipe_per_mec;
-		mec = (i / adev-&gt;gfx.mec.num_queue_per_pipe)
-			/ adev-&gt;gfx.mec.num_pipe_per_mec;
-
-		/* we've run out of HW */
-		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
-			break;
-
-		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
-			/* policy: amdgpu owns the first two queues of the first MEC */
-			if (mec == 0 &amp;&amp; queue &lt; 2)
-				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
-		} else {
-			/* policy: amdgpu owns all queues in the first pipe */
-			if (mec == 0 &amp;&amp; pipe == 0)
-				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
-		}
-	}
-
-	/* update the number of active compute rings */
-	adev-&gt;gfx.num_compute_rings =
-		bitmap_weight(adev-&gt;gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
-
-	/* If you hit this case and edited the policy, you probably just
-	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
-	if (WARN_ON(adev-&gt;gfx.num_compute_rings &gt; AMDGPU_MAX_COMPUTE_RINGS))
-		adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
-}
-
 static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -920,7 +883,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
 
 	/* take ownership of the relevant compute queues */
-	gfx_v9_0_compute_queue_acquire(adev);
+	amdgpu_gfx_compute_queue_acquire(adev);
 	mec_hpd_size = adev-&gt;gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
 
 	if (adev-&gt;gfx.mec.hpd_eop_obj == NULL) {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------84C8E645DA23B76DC0B1CFF4--

--===============1185083660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1185083660==--
