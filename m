From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: remove usage of legacy_cursor_update
Date: Fri, 24 Nov 2017 17:00:06 -0500
Message-ID: <53723683-0ea7-1738-e209-8d382fe275f4@amd.com>
References: <BN6PR12MB1826D81F6C6FF778A79C6754F2210@BN6PR12MB1826.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0967464367=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1826D81F6C6FF778A79C6754F2210-/b2+HYfkarSCndJ3FSsNdQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0967464367==
Content-Type: multipart/alternative;
 boundary="------------39E1E368F57AB7EDDC6EA15B"

This is a multi-part message in MIME format.
--------------39E1E368F57AB7EDDC6EA15B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2017-11-23 01:16 AM, S, Shirish wrote:
> From: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
>
> Currently the atomic check code uses legacy_cursor_update to differnetiate if the cursor plane is being requested by the user, which is not required as we shall be updating plane only if modeset is requested/required.
>
> Have tested cursor plane and underlay get updated seamlessly, without any lag or frame drops.
>
> Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++----------------
>   1 file changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8638f1c..2df2e32 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4752,8 +4752,6 @@ static int dm_update_planes_state(struct dc *dc,  static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   				  struct drm_atomic_state *state)
>   {
> -	int i;
> -	int ret;
>   	struct amdgpu_device *adev = dev->dev_private;
>   	struct dc *dc = adev->dm.dc;
>   	struct dm_atomic_state *dm_state = to_dm_atomic_state(state); @@ -4761,6 +4759,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	struct drm_connector_state *old_con_state, *new_con_state;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	int ret, i;
>   
>   	/*
>   	 * This bool will be set for true for any modeset/reset @@ -4772,36 +4771,20 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	if (ret)
>   		goto fail;
>   
> -	/*
> -	 * legacy_cursor_update should be made false for SoC's having
> -	 * a dedicated hardware plane for cursor in amdgpu_dm_atomic_commit(),
> -	 * otherwise for software cursor plane,
> -	 * we should not add it to list of affected planes.
> -	 */
> -	if (state->legacy_cursor_update) {
> -		for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
> -			if (new_crtc_state->color_mgmt_changed) {
> -				ret = drm_atomic_add_affected_planes(state, crtc);

I don't even understand this, why even bundle together cursor updates 
and gamma settings...

Change is Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Thanks,
Andrey

> -				if (ret)
> -					goto fail;
> -			}
> -		}
> -	} else {
> -		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -			if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
> -				continue;
> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> +		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
> +			continue;
>   
> -			if (!new_crtc_state->enable)
> -				continue;
> +		if (!new_crtc_state->enable)
> +			continue;
>   
> -			ret = drm_atomic_add_affected_connectors(state, crtc);
> -			if (ret)
> -				return ret;
> +		ret = drm_atomic_add_affected_connectors(state, crtc);
> +		if (ret)
> +			return ret;
>   
> -			ret = drm_atomic_add_affected_planes(state, crtc);
> -			if (ret)
> -				goto fail;
> -		}
> +		ret = drm_atomic_add_affected_planes(state, crtc);
> +		if (ret)
> +			goto fail;
>   	}
>   
>   	dm_state->context = dc_create_state();
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------39E1E368F57AB7EDDC6EA15B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2017-11-23 01:16 AM, S, Shirish
      wrote:<br>
    </div>
    <blockquote
cite="mid:BN6PR12MB1826D81F6C6FF778A79C6754F2210-/b2+HYfkarSCndJ3FSsNdQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <pre wrap="">
From: Shirish S <a class="moz-txt-link-rfc2396E" href="mailto:shirish.s-5C7GfCeVMHo@public.gmane.org">&lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;</a>

Currently the atomic check code uses legacy_cursor_update to differnetiate if the cursor plane is being requested by the user, which is not required as we shall be updating plane only if modeset is requested/required.

Have tested cursor plane and underlay get updated seamlessly, without any lag or frame drops.

Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E" href="mailto:shirish.s-5C7GfCeVMHo@public.gmane.org">&lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;</a>
Reviewed-by: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++----------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8638f1c..2df2e32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4752,8 +4752,6 @@ static int dm_update_planes_state(struct dc *dc,  static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state)
 {
-	int i;
-	int ret;
 	struct amdgpu_device *adev = dev-&gt;dev_private;
 	struct dc *dc = adev-&gt;dm.dc;
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(state); @@ -4761,6 +4759,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	int ret, i;
 
 	/*
 	 * This bool will be set for true for any modeset/reset @@ -4772,36 +4771,20 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
-	/*
-	 * legacy_cursor_update should be made false for SoC's having
-	 * a dedicated hardware plane for cursor in amdgpu_dm_atomic_commit(),
-	 * otherwise for software cursor plane,
-	 * we should not add it to list of affected planes.
-	 */
-	if (state-&gt;legacy_cursor_update) {
-		for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
-			if (new_crtc_state-&gt;color_mgmt_changed) {
-				ret = drm_atomic_add_affected_planes(state, crtc);</pre>
    </blockquote>
    <br>
    I don't even understand this, why even bundle together cursor
    updates and gamma settings...<br>
    <br>
    Change is Reviewed-by: Andrey Grodzovsky <a
      class="moz-txt-link-rfc2396E"
      href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    <br>
    Thanks,<br>
    Andrey<br>
    <br>
    <blockquote
cite="mid:BN6PR12MB1826D81F6C6FF778A79C6754F2210-/b2+HYfkarSCndJ3FSsNdQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <pre wrap="">
-				if (ret)
-					goto fail;
-			}
-		}
-	} else {
-		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-			if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
-				continue;
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
 
-			if (!new_crtc_state-&gt;enable)
-				continue;
+		if (!new_crtc_state-&gt;enable)
+			continue;
 
-			ret = drm_atomic_add_affected_connectors(state, crtc);
-			if (ret)
-				return ret;
+		ret = drm_atomic_add_affected_connectors(state, crtc);
+		if (ret)
+			return ret;
 
-			ret = drm_atomic_add_affected_planes(state, crtc);
-			if (ret)
-				goto fail;
-		}
+		ret = drm_atomic_add_affected_planes(state, crtc);
+		if (ret)
+			goto fail;
 	}
 
 	dm_state-&gt;context = dc_create_state();
--
2.7.4

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------39E1E368F57AB7EDDC6EA15B--

--===============0967464367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0967464367==--
