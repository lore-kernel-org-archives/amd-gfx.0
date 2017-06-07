From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/amdgpu: move mec queue helpers to amdgpu_gfx.h
Date: Wed, 7 Jun 2017 17:58:59 -0400
Message-ID: <a75a590d-2533-c818-739d-33e558a7c135@amd.com>
References: <1496864097-4322-1-git-send-email-alexander.deucher@amd.com>
 <1496864097-4322-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1730688203=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496864097-4322-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1730688203==
Content-Type: multipart/alternative;
 boundary="------------E21BAD292438B2D8562501FD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E21BAD292438B2D8562501FD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 03:34 PM, Alex Deucher wrote:
> They are gfx related, not general helpers.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 30 ------------------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  9 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 30 ++++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
>   6 files changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ef34ff2..3308e62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1831,36 +1831,6 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
>   		return NULL;
>   }
>   
> -static inline int amdgpu_queue_to_bit(struct amdgpu_device *adev,
> -				      int mec, int pipe, int queue)
> -{
> -	int bit = 0;
> -
> -	bit += mec * adev->gfx.mec.num_pipe_per_mec
> -		* adev->gfx.mec.num_queue_per_pipe;
> -	bit += pipe * adev->gfx.mec.num_queue_per_pipe;
> -	bit += queue;
> -
> -	return bit;
> -}
> -
> -static inline void amdgpu_bit_to_queue(struct amdgpu_device *adev, int bit,
> -				       int *mec, int *pipe, int *queue)
> -{
> -	*queue = bit % adev->gfx.mec.num_queue_per_pipe;
> -	*pipe = (bit / adev->gfx.mec.num_queue_per_pipe)
> -		% adev->gfx.mec.num_pipe_per_mec;
> -	*mec = (bit / adev->gfx.mec.num_queue_per_pipe)
> -	       / adev->gfx.mec.num_pipe_per_mec;
> -
> -}
> -static inline bool amdgpu_is_mec_queue_enabled(struct amdgpu_device *adev,
> -					       int mec, int pipe, int queue)
> -{
> -	return test_bit(amdgpu_queue_to_bit(adev, mec, pipe, queue),
> -			adev->gfx.mec.queue_bitmap);
> -}
> -
>   /*
>    * ASICs macro.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 339e8cd..5f8ada1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -24,6 +24,7 @@
>   #include "amd_shared.h"
>   #include <drm/drmP.h>
>   #include "amdgpu.h"
> +#include "amdgpu_gfx.h"
>   #include <linux/module.h>
>   
>   const struct kfd2kgd_calls *kfd2kgd;
> @@ -113,10 +114,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   
>   		/* remove the KIQ bit as well */
>   		if (adev->gfx.kiq.ring.ready)
> -			clear_bit(amdgpu_queue_to_bit(adev,
> -						      adev->gfx.kiq.ring.me - 1,
> -						      adev->gfx.kiq.ring.pipe,
> -						      adev->gfx.kiq.ring.queue),
> +			clear_bit(amdgpu_gfx_queue_to_bit(adev,
> +							  adev->gfx.kiq.ring.me - 1,
> +							  adev->gfx.kiq.ring.pipe,
> +							  adev->gfx.kiq.ring.queue),
>   				  gpu_resources.queue_bitmap);
>   
>   		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 9b9ea6e..fa20438 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -45,4 +45,34 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
>   	return (u32)((1ULL << bit_width) - 1);
>   }
>   
> +static inline int amdgpu_gfx_queue_to_bit(struct amdgpu_device *adev,
> +					  int mec, int pipe, int queue)
> +{
> +	int bit = 0;
> +
> +	bit += mec * adev->gfx.mec.num_pipe_per_mec
> +		* adev->gfx.mec.num_queue_per_pipe;
> +	bit += pipe * adev->gfx.mec.num_queue_per_pipe;
> +	bit += queue;
> +
> +	return bit;
> +}
> +
> +static inline void amdgpu_gfx_bit_to_queue(struct amdgpu_device *adev, int bit,
> +					   int *mec, int *pipe, int *queue)
> +{
> +	*queue = bit % adev->gfx.mec.num_queue_per_pipe;
> +	*pipe = (bit / adev->gfx.mec.num_queue_per_pipe)
> +		% adev->gfx.mec.num_pipe_per_mec;
> +	*mec = (bit / adev->gfx.mec.num_queue_per_pipe)
> +	       / adev->gfx.mec.num_pipe_per_mec;
> +
> +}
> +static inline bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
> +						   int mec, int pipe, int queue)
> +{
> +	return test_bit(amdgpu_gfx_queue_to_bit(adev, mec, pipe, queue),
> +			adev->gfx.mec.queue_bitmap);
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 6ffb2da..d80cf72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4776,7 +4776,7 @@ static int gfx_v7_0_sw_init(void *handle)
>   	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>   		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
>   			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_is_mec_queue_enabled(adev, i, k, j))
> +				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
>   					continue;
>   
>   				r = gfx_v7_0_compute_ring_init(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8d39e7d..fc8e03b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1393,7 +1393,7 @@ static int gfx_v8_0_kiq_acquire(struct amdgpu_device *adev,
>   		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
>   			continue;
>   
> -		amdgpu_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
> +		amdgpu_gfx_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
>   
>   		/* Using pipes 2/3 from MEC 2 seems cause problems */
>   		if (mec == 1 && pipe > 1)
> @@ -2178,7 +2178,7 @@ static int gfx_v8_0_sw_init(void *handle)
>   	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>   		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
>   			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_is_mec_queue_enabled(adev, i, k, j))
> +				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
>   					continue;
>   
>   				r = gfx_v8_0_compute_ring_init(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4c47754f..6d30476 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1015,7 +1015,7 @@ static int gfx_v9_0_kiq_acquire(struct amdgpu_device *adev,
>   		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
>   			continue;
>   
> -		amdgpu_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
> +		amdgpu_gfx_bit_to_queue(adev, queue_bit, &mec, &pipe, &queue);
>   
>   		/* Using pipes 2/3 from MEC 2 seems cause problems */
>   		if (mec == 1 && pipe > 1)
> @@ -1556,7 +1556,7 @@ static int gfx_v9_0_sw_init(void *handle)
>   	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>   		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
>   			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_is_mec_queue_enabled(adev, i, k, j))
> +				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
>   					continue;
>   
>   				r = gfx_v9_0_compute_ring_init(adev,


--------------E21BAD292438B2D8562501FD
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
      cite="mid:1496864097-4322-3-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">They are gfx related, not general helpers.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 30 ------------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
 6 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef34ff2..3308e62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1831,36 +1831,6 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
 		return NULL;
 }
 
-static inline int amdgpu_queue_to_bit(struct amdgpu_device *adev,
-				      int mec, int pipe, int queue)
-{
-	int bit = 0;
-
-	bit += mec * adev-&gt;gfx.mec.num_pipe_per_mec
-		* adev-&gt;gfx.mec.num_queue_per_pipe;
-	bit += pipe * adev-&gt;gfx.mec.num_queue_per_pipe;
-	bit += queue;
-
-	return bit;
-}
-
-static inline void amdgpu_bit_to_queue(struct amdgpu_device *adev, int bit,
-				       int *mec, int *pipe, int *queue)
-{
-	*queue = bit % adev-&gt;gfx.mec.num_queue_per_pipe;
-	*pipe = (bit / adev-&gt;gfx.mec.num_queue_per_pipe)
-		% adev-&gt;gfx.mec.num_pipe_per_mec;
-	*mec = (bit / adev-&gt;gfx.mec.num_queue_per_pipe)
-	       / adev-&gt;gfx.mec.num_pipe_per_mec;
-
-}
-static inline bool amdgpu_is_mec_queue_enabled(struct amdgpu_device *adev,
-					       int mec, int pipe, int queue)
-{
-	return test_bit(amdgpu_queue_to_bit(adev, mec, pipe, queue),
-			adev-&gt;gfx.mec.queue_bitmap);
-}
-
 /*
  * ASICs macro.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 339e8cd..5f8ada1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -24,6 +24,7 @@
 #include "amd_shared.h"
 #include &lt;drm/drmP.h&gt;
 #include "amdgpu.h"
+#include "amdgpu_gfx.h"
 #include &lt;linux/module.h&gt;
 
 const struct kfd2kgd_calls *kfd2kgd;
@@ -113,10 +114,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		/* remove the KIQ bit as well */
 		if (adev-&gt;gfx.kiq.ring.ready)
-			clear_bit(amdgpu_queue_to_bit(adev,
-						      adev-&gt;gfx.kiq.ring.me - 1,
-						      adev-&gt;gfx.kiq.ring.pipe,
-						      adev-&gt;gfx.kiq.ring.queue),
+			clear_bit(amdgpu_gfx_queue_to_bit(adev,
+							  adev-&gt;gfx.kiq.ring.me - 1,
+							  adev-&gt;gfx.kiq.ring.pipe,
+							  adev-&gt;gfx.kiq.ring.queue),
 				  gpu_resources.queue_bitmap);
 
 		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9b9ea6e..fa20438 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -45,4 +45,34 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 	return (u32)((1ULL &lt;&lt; bit_width) - 1);
 }
 
+static inline int amdgpu_gfx_queue_to_bit(struct amdgpu_device *adev,
+					  int mec, int pipe, int queue)
+{
+	int bit = 0;
+
+	bit += mec * adev-&gt;gfx.mec.num_pipe_per_mec
+		* adev-&gt;gfx.mec.num_queue_per_pipe;
+	bit += pipe * adev-&gt;gfx.mec.num_queue_per_pipe;
+	bit += queue;
+
+	return bit;
+}
+
+static inline void amdgpu_gfx_bit_to_queue(struct amdgpu_device *adev, int bit,
+					   int *mec, int *pipe, int *queue)
+{
+	*queue = bit % adev-&gt;gfx.mec.num_queue_per_pipe;
+	*pipe = (bit / adev-&gt;gfx.mec.num_queue_per_pipe)
+		% adev-&gt;gfx.mec.num_pipe_per_mec;
+	*mec = (bit / adev-&gt;gfx.mec.num_queue_per_pipe)
+	       / adev-&gt;gfx.mec.num_pipe_per_mec;
+
+}
+static inline bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
+						   int mec, int pipe, int queue)
+{
+	return test_bit(amdgpu_gfx_queue_to_bit(adev, mec, pipe, queue),
+			adev-&gt;gfx.mec.queue_bitmap);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 6ffb2da..d80cf72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4776,7 +4776,7 @@ static int gfx_v7_0_sw_init(void *handle)
 	for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; ++i) {
 		for (j = 0; j &lt; adev-&gt;gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k &lt; adev-&gt;gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_is_mec_queue_enabled(adev, i, k, j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
 					continue;
 
 				r = gfx_v7_0_compute_ring_init(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8d39e7d..fc8e03b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1393,7 +1393,7 @@ static int gfx_v8_0_kiq_acquire(struct amdgpu_device *adev,
 		if (test_bit(queue_bit, adev-&gt;gfx.mec.queue_bitmap))
 			continue;
 
-		amdgpu_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
+		amdgpu_gfx_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
 
 		/* Using pipes 2/3 from MEC 2 seems cause problems */
 		if (mec == 1 &amp;&amp; pipe &gt; 1)
@@ -2178,7 +2178,7 @@ static int gfx_v8_0_sw_init(void *handle)
 	for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; ++i) {
 		for (j = 0; j &lt; adev-&gt;gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k &lt; adev-&gt;gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_is_mec_queue_enabled(adev, i, k, j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
 					continue;
 
 				r = gfx_v8_0_compute_ring_init(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4c47754f..6d30476 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1015,7 +1015,7 @@ static int gfx_v9_0_kiq_acquire(struct amdgpu_device *adev,
 		if (test_bit(queue_bit, adev-&gt;gfx.mec.queue_bitmap))
 			continue;
 
-		amdgpu_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
+		amdgpu_gfx_bit_to_queue(adev, queue_bit, &amp;mec, &amp;pipe, &amp;queue);
 
 		/* Using pipes 2/3 from MEC 2 seems cause problems */
 		if (mec == 1 &amp;&amp; pipe &gt; 1)
@@ -1556,7 +1556,7 @@ static int gfx_v9_0_sw_init(void *handle)
 	for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; ++i) {
 		for (j = 0; j &lt; adev-&gt;gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k &lt; adev-&gt;gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_is_mec_queue_enabled(adev, i, k, j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
 					continue;
 
 				r = gfx_v9_0_compute_ring_init(adev,
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------E21BAD292438B2D8562501FD--

--===============1730688203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1730688203==--
