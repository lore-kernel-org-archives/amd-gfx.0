From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: for sriov timeout is still enforced on
 compute rings
Date: Tue, 27 Mar 2018 09:51:51 +0200
Message-ID: <32b69fa9-c0be-db27-03a9-97eb3585083e@gmail.com>
References: <1522133191-31247-1-git-send-email-evan.quan@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0891237224=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522133191-31247-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Monk.Liu-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--===============0891237224==
Content-Type: multipart/alternative;
 boundary="------------9A6905CA5240D3BA4ACF5A87"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9A6905CA5240D3BA4ACF5A87
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.03.2018 um 08:46 schrieb Evan Quan:
> Sriov still wants these error messags on timeout. So, for sriov
> use case, the timeout setting on compute rings is kept.
>
> Change-Id: Id0af6959a8023c8d683ff680de7c583f84cfeab3
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 455a81e..2cc5a75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -435,7 +435,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   	if (ring->funcs->type != AMDGPU_RING_TYPE_KIQ) {
>   		r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>   				   num_hw_submission, amdgpu_job_hang_limit,
> -				   (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ?
> +				   /* for non-sriov case, no timeout enforce on compute ring */
> +				   ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) && !amdgpu_sriov_vf(ring->adev)) ?

This starts to look a bit messy, can you add a local variable and 
separate the exceptions, e.g. something like:

long timeout = msecs_to_jiffies(amdgpu_lockup_timeout);

if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) && 
!amdgpu_sriov_vf(ring->adev))
     timeout = MAX_SCHEDULE_TIMEOUT;

....

Apart from that the patch looks good to me,
Christian.

>   				   MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(amdgpu_lockup_timeout),
>   				   ring->name);
>   		if (r) {


--------------9A6905CA5240D3BA4ACF5A87
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 27.03.2018 um 08:46 schrieb Evan
      Quan:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1522133191-31247-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Sriov still wants these error messags on timeout. So, for sriov
use case, the timeout setting on compute rings is kept.

Change-Id: Id0af6959a8023c8d683ff680de7c583f84cfeab3
Signed-off-by: Evan Quan <a class="moz-txt-link-rfc2396E" href="mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">&lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 455a81e..2cc5a75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -435,7 +435,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 	if (ring-&gt;funcs-&gt;type != AMDGPU_RING_TYPE_KIQ) {
 		r = drm_sched_init(&amp;ring-&gt;sched, &amp;amdgpu_sched_ops,
 				   num_hw_submission, amdgpu_job_hang_limit,
-				   (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_COMPUTE) ?
+				   /* for non-sriov case, no timeout enforce on compute ring */
+				   ((ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_COMPUTE) &amp;&amp; !amdgpu_sriov_vf(ring-&gt;adev)) ?</pre>
    </blockquote>
    <br>
    This starts to look a bit messy, can you add a local variable and
    separate the exceptions, e.g. something like:<br>
    <br>
    long timeout = <span class="pl-c1">msecs_to_jiffies</span>(amdgpu_lockup_timeout);<br>
    <br>
    if (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_COMPUTE) &amp;&amp;
    !amdgpu_sriov_vf(ring-&gt;adev))<br>
        timeout = MAX_SCHEDULE_TIMEOUT;<br>
    <br>
    ....<br>
    <br>
    Apart from that the patch looks good to me,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1522133191-31247-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org">
      <pre wrap=""> 				   MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(amdgpu_lockup_timeout),
 				   ring-&gt;name);
 		if (r) {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9A6905CA5240D3BA4ACF5A87--

--===============0891237224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0891237224==--
