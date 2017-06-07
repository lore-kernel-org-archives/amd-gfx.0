From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix mec queue policy on single MEC asics
Date: Wed, 7 Jun 2017 15:30:08 -0400
Message-ID: <fd4ad0c3-ba0f-efe8-3211-1d322f1dee7e@amd.com>
References: <1496848229-12761-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0933074935=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496848229-12761-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============0933074935==
Content-Type: multipart/alternative;
 boundary="------------1E49245988208046CAAACE5E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1E49245988208046CAAACE5E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex

I agree that we revert the change for single MEC for the time being.

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 11:10 AM, Alex Deucher wrote:
> Fixes hangs on single MEC asics.
>
> Fixes: 2ed286fb434 (drm/amdgpu: new queue policy, take first 2 queues of each pipe v2)
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12 +++++++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 +++++++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++++++++---
>   3 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 4c04e9d..862bc72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2825,9 +2825,15 @@ static void gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
>   		if (mec >= adev->gfx.mec.num_mec)
>   			break;
>   
> -		/* policy: amdgpu owns the first two queues of the first MEC */
> -		if (mec == 0 && queue < 2)
> -			set_bit(i, adev->gfx.mec.queue_bitmap);
> +		if (adev->gfx.mec.num_mec > 1) {
> +			/* policy: amdgpu owns the first two queues of the first MEC */
> +			if (mec == 0 && queue < 2)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		} else {
> +			/* policy: amdgpu owns all queues in the first pipe */
> +			if (mec == 0 && pipe == 0)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		}
>   	}
>   
>   	/* update the number of active compute rings */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index ad2e0bb..1370b39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1464,9 +1464,15 @@ static void gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
>   		if (mec >= adev->gfx.mec.num_mec)
>   			break;
>   
> -		/* policy: amdgpu owns the first two queues of the first MEC */
> -		if (mec == 0 && queue < 2)
> -			set_bit(i, adev->gfx.mec.queue_bitmap);
> +		if (adev->gfx.mec.num_mec > 1) {
> +			/* policy: amdgpu owns the first two queues of the first MEC */
> +			if (mec == 0 && queue < 2)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		} else {
> +			/* policy: amdgpu owns all queues in the first pipe */
> +			if (mec == 0 && pipe == 0)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		}
>   	}
>   
>   	/* update the number of active compute rings */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index cf15a350..9d675b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -873,9 +873,15 @@ static void gfx_v9_0_compute_queue_acquire(struct amdgpu_device *adev)
>   		if (mec >= adev->gfx.mec.num_mec)
>   			break;
>   
> -		/* policy: amdgpu owns the first two queues of the first MEC */
> -		if (mec == 0 && queue < 2)
> -			set_bit(i, adev->gfx.mec.queue_bitmap);
> +		if (adev->gfx.mec.num_mec > 1) {
> +			/* policy: amdgpu owns the first two queues of the first MEC */
> +			if (mec == 0 && queue < 2)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		} else {
> +			/* policy: amdgpu owns all queues in the first pipe */
> +			if (mec == 0 && pipe == 0)
> +				set_bit(i, adev->gfx.mec.queue_bitmap);
> +		}
>   	}
>   
>   	/* update the number of active compute rings */


--------------1E49245988208046CAAACE5E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Alex</p>
    <p>I agree that we revert the change for single MEC for the time
      being.<br>
    </p>
    <p>Reviewed-by: Alex Xie <a class="moz-txt-link-rfc2396E"
        href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
    <br>
    <div class="moz-cite-prefix">On 2017-06-07 11:10 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1496848229-12761-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Fixes hangs on single MEC asics.

Fixes: 2ed286fb434 (drm/amdgpu: new queue policy, take first 2 queues of each pipe v2)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++++++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 4c04e9d..862bc72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2825,9 +2825,15 @@ static void gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
 		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
 			break;
 
-		/* policy: amdgpu owns the first two queues of the first MEC */
-		if (mec == 0 &amp;&amp; queue &lt; 2)
-			set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
+			/* policy: amdgpu owns the first two queues of the first MEC */
+			if (mec == 0 &amp;&amp; queue &lt; 2)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		} else {
+			/* policy: amdgpu owns all queues in the first pipe */
+			if (mec == 0 &amp;&amp; pipe == 0)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		}
 	}
 
 	/* update the number of active compute rings */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ad2e0bb..1370b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1464,9 +1464,15 @@ static void gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
 		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
 			break;
 
-		/* policy: amdgpu owns the first two queues of the first MEC */
-		if (mec == 0 &amp;&amp; queue &lt; 2)
-			set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
+			/* policy: amdgpu owns the first two queues of the first MEC */
+			if (mec == 0 &amp;&amp; queue &lt; 2)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		} else {
+			/* policy: amdgpu owns all queues in the first pipe */
+			if (mec == 0 &amp;&amp; pipe == 0)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		}
 	}
 
 	/* update the number of active compute rings */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index cf15a350..9d675b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -873,9 +873,15 @@ static void gfx_v9_0_compute_queue_acquire(struct amdgpu_device *adev)
 		if (mec &gt;= adev-&gt;gfx.mec.num_mec)
 			break;
 
-		/* policy: amdgpu owns the first two queues of the first MEC */
-		if (mec == 0 &amp;&amp; queue &lt; 2)
-			set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		if (adev-&gt;gfx.mec.num_mec &gt; 1) {
+			/* policy: amdgpu owns the first two queues of the first MEC */
+			if (mec == 0 &amp;&amp; queue &lt; 2)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		} else {
+			/* policy: amdgpu owns all queues in the first pipe */
+			if (mec == 0 &amp;&amp; pipe == 0)
+				set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
+		}
 	}
 
 	/* update the number of active compute rings */
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------1E49245988208046CAAACE5E--

--===============0933074935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0933074935==--
