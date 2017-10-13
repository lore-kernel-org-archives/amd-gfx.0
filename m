From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/6] drm/amd/display: Use DRM new-style object
 iterators.
Date: Fri, 13 Oct 2017 11:03:23 -0400
Message-ID: <6580524b-7742-f8b8-af69-d08821a4e8d6@amd.com>
References: <1507842911-16975-1-git-send-email-sunpeng.li@amd.com>
 <1507842911-16975-2-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0677257467=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507842911-16975-2-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: sunpeng.li-5C7GfCeVMHo@public.gmane.org, airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0677257467==
Content-Type: multipart/alternative;
 boundary="------------A741F8C606EA77D65319AEA4"

This is a multi-part message in MIME format.
--------------A741F8C606EA77D65319AEA4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2017 05:15 PM, sunpeng.li-5C7GfCeVMHo@public.gmane.org wrote:
> From: "Leo (Sunpeng) Li"<sunpeng.li-5C7GfCeVMHo@public.gmane.org>
>
> Use the correct for_each_new/old_* iterators instead of for_each_*
>
> List of affected functions:
>
> amdgpu_dm_find_first_crtc_matching_connector: use for_each_new
>      - Old from_state_var flag was always choosing the new state
>
> amdgpu_dm_display_resume: use for_each_new
>      - drm_atomic_helper_duplicate_state is called during suspend to
>        cache the state
>      - It sets 'state' within the state triplet to 'new_state'

It seems to me you missed that one.

Thanks,
Andrey

>
> amdgpu_dm_commit_planes: use for_each_old
>      - Called after the state was swapped (via atomic commit tail)
>
> amdgpu_dm_atomic_commit: use for_each_new
>      - Called before the state is swapped
>
> amdgpu_dm_atomic_commit_tail: use for_each_old
>      - Called after the state was swapped
>
> dm_update_crtcs_state: use for_each_new
>      - Called before the state is swapped (via atomic check)
>
> amdgpu_dm_atomic_check: use for_each_new
>      - Called before the state is swapped
>
> v2: Split out typo fixes to a new patch.
>
> Signed-off-by: Leo (Sunpeng) Li<sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++---------------
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +--
>   2 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9bfe1f9..cc024ab 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -570,23 +570,15 @@ static int dm_suspend(void *handle)
>   
>   struct amdgpu_dm_connector *amdgpu_dm_find_first_crct_matching_connector(
>   	struct drm_atomic_state *state,
> -	struct drm_crtc *crtc,
> -	bool from_state_var)
> +	struct drm_crtc *crtc)
>   {
>   	uint32_t i;
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	struct drm_crtc *crtc_from_state;
>   
> -	for_each_new_connector_in_state(
> -		state,
> -		connector,
> -		conn_state,
> -		i) {
> -		crtc_from_state =
> -			from_state_var ?
> -				conn_state->crtc :
> -				connector->state->crtc;
> +	for_each_new_connector_in_state(state, connector, conn_state, i) {
> +		crtc_from_state = conn_state->crtc;
>   
>   		if (crtc_from_state == crtc)
>   			return to_amdgpu_dm_connector(connector);
> @@ -3890,7 +3882,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   	unsigned long flags;
>   
>   	/* update planes when needed */
> -	for_each_new_plane_in_state(state, plane, old_plane_state, i) {
> +	for_each_old_plane_in_state(state, plane, old_plane_state, i) {
>   		struct drm_plane_state *plane_state = plane->state;
>   		struct drm_crtc *crtc = plane_state->crtc;
>   		struct drm_framebuffer *fb = plane_state->fb;
> @@ -4024,7 +4016,7 @@ void amdgpu_dm_atomic_commit_tail(
>   	dm_state = to_dm_atomic_state(state);
>   
>   	/* update changed items */
> -	for_each_new_crtc_in_state(state, crtc, old_crtc_state, i) {
> +	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   		struct drm_crtc_state *new_state = crtc->state;
>   
> @@ -4113,11 +4105,9 @@ void amdgpu_dm_atomic_commit_tail(
>   			new_acrtc_state = to_dm_crtc_state(new_crtcs[i]->base.state);
>   
>   			new_stream = new_acrtc_state->stream;
> -			aconnector =
> -				amdgpu_dm_find_first_crct_matching_connector(
> +			aconnector = amdgpu_dm_find_first_crct_matching_connector(
>   					state,
> -					&new_crtcs[i]->base,
> -					false);
> +					&new_crtcs[i]->base);
>   			if (!aconnector) {
>   				DRM_DEBUG_DRIVER("Atomic commit: Failed to find connector for acrtc id:%d "
>   					 "skipping freesync init\n",
> @@ -4151,7 +4141,7 @@ void amdgpu_dm_atomic_commit_tail(
>   	}
>   
>   	/* Handle scaling and undersacn changes*/
> -	for_each_new_connector_in_state(state, connector, old_conn_state, i) {
> +	for_each_old_connector_in_state(state, connector, old_conn_state, i) {
>   		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>   		struct dm_connector_state *con_new_state =
>   				to_dm_connector_state(aconnector->base.state);
> @@ -4205,7 +4195,7 @@ void amdgpu_dm_atomic_commit_tail(
>   	}
>   
>   	/* update planes when needed per crtc*/
> -	for_each_new_crtc_in_state(state, pcrtc, old_crtc_state, j) {
> +	for_each_old_crtc_in_state(state, pcrtc, old_crtc_state, j) {
>   		new_acrtc_state = to_dm_crtc_state(pcrtc->state);
>   
>   		if (new_acrtc_state->stream)
> @@ -4218,7 +4208,7 @@ void amdgpu_dm_atomic_commit_tail(
>   	 * mark consumed event for drm_atomic_helper_commit_hw_done
>   	 */
>   	spin_lock_irqsave(&adev->ddev->event_lock, flags);
> -	for_each_new_crtc_in_state(state, crtc, old_crtc_state, i) {
> +	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   
>   		if (acrtc->base.state->event)
> @@ -4402,7 +4392,7 @@ static int dm_update_crtcs_state(
>   		new_acrtc_state = to_dm_crtc_state(crtc_state);
>   		acrtc = to_amdgpu_crtc(crtc);
>   
> -		aconnector = amdgpu_dm_find_first_crct_matching_connector(state, crtc, true);
> +		aconnector = amdgpu_dm_find_first_crct_matching_connector(state, crtc);
>   
>   		/* TODO This hack should go away */
>   		if (aconnector) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 630e6cd..1c55a0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -228,8 +228,7 @@ void amdgpu_dm_update_connector_after_detect(
>   
>   struct amdgpu_dm_connector *amdgpu_dm_find_first_crct_matching_connector(
>   	struct drm_atomic_state *state,
> -	struct drm_crtc *crtc,
> -	bool from_state_var);
> +	struct drm_crtc *crtc);
>   
>   
>   struct amdgpu_framebuffer;
> -- 2.7.4 _______________________________________________ amd-gfx 
> mailing list amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------A741F8C606EA77D65319AEA4
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
    <div class="moz-cite-prefix">On 10/12/2017 05:15 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a> wrote:<br>
    </div>
    <blockquote
      cite="mid:1507842911-16975-2-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">From: "Leo (Sunpeng) Li" <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">&lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;</a>

Use the correct for_each_new/old_* iterators instead of for_each_*

List of affected functions:

amdgpu_dm_find_first_crtc_matching_connector: use for_each_new
    - Old from_state_var flag was always choosing the new state

amdgpu_dm_display_resume: use for_each_new
    - drm_atomic_helper_duplicate_state is called during suspend to
      cache the state
    - It sets 'state' within the state triplet to 'new_state'</pre>
      </div>
    </blockquote>
    <br>
    It seems to me you missed that one.<br>
    <br>
    Thanks,<br>
    Andrey<br>
    <br>
    <blockquote
      cite="mid:1507842911-16975-2-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">

amdgpu_dm_commit_planes: use for_each_old
    - Called after the state was swapped (via atomic commit tail)

amdgpu_dm_atomic_commit: use for_each_new
    - Called before the state is swapped

amdgpu_dm_atomic_commit_tail: use for_each_old
    - Called after the state was swapped

dm_update_crtcs_state: use for_each_new
    - Called before the state is swapped (via atomic check)

amdgpu_dm_atomic_check: use for_each_new
    - Called before the state is swapped

v2: Split out typo fixes to a new patch.

Signed-off-by: Leo (Sunpeng) Li <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">&lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++---------------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +--
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9bfe1f9..cc024ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -570,23 +570,15 @@ static int dm_suspend(void *handle)
 
 struct amdgpu_dm_connector *amdgpu_dm_find_first_crct_matching_connector(
 	struct drm_atomic_state *state,
-	struct drm_crtc *crtc,
-	bool from_state_var)
+	struct drm_crtc *crtc)
 {
 	uint32_t i;
 	struct drm_connector_state *conn_state;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc_from_state;
 
-	for_each_new_connector_in_state(
-		state,
-		connector,
-		conn_state,
-		i) {
-		crtc_from_state =
-			from_state_var ?
-				conn_state-&gt;crtc :
-				connector-&gt;state-&gt;crtc;
+	for_each_new_connector_in_state(state, connector, conn_state, i) {
+		crtc_from_state = conn_state-&gt;crtc;
 
 		if (crtc_from_state == crtc)
 			return to_amdgpu_dm_connector(connector);
@@ -3890,7 +3882,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	unsigned long flags;
 
 	/* update planes when needed */
-	for_each_new_plane_in_state(state, plane, old_plane_state, i) {
+	for_each_old_plane_in_state(state, plane, old_plane_state, i) {
 		struct drm_plane_state *plane_state = plane-&gt;state;
 		struct drm_crtc *crtc = plane_state-&gt;crtc;
 		struct drm_framebuffer *fb = plane_state-&gt;fb;
@@ -4024,7 +4016,7 @@ void amdgpu_dm_atomic_commit_tail(
 	dm_state = to_dm_atomic_state(state);
 
 	/* update changed items */
-	for_each_new_crtc_in_state(state, crtc, old_crtc_state, i) {
+	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 		struct drm_crtc_state *new_state = crtc-&gt;state;
 
@@ -4113,11 +4105,9 @@ void amdgpu_dm_atomic_commit_tail(
 			new_acrtc_state = to_dm_crtc_state(new_crtcs[i]-&gt;base.state);
 
 			new_stream = new_acrtc_state-&gt;stream;
-			aconnector =
-				amdgpu_dm_find_first_crct_matching_connector(
+			aconnector = amdgpu_dm_find_first_crct_matching_connector(
 					state,
-					&amp;new_crtcs[i]-&gt;base,
-					false);
+					&amp;new_crtcs[i]-&gt;base);
 			if (!aconnector) {
 				DRM_DEBUG_DRIVER("Atomic commit: Failed to find connector for acrtc id:%d "
 					 "skipping freesync init\n",
@@ -4151,7 +4141,7 @@ void amdgpu_dm_atomic_commit_tail(
 	}
 
 	/* Handle scaling and undersacn changes*/
-	for_each_new_connector_in_state(state, connector, old_conn_state, i) {
+	for_each_old_connector_in_state(state, connector, old_conn_state, i) {
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 		struct dm_connector_state *con_new_state =
 				to_dm_connector_state(aconnector-&gt;base.state);
@@ -4205,7 +4195,7 @@ void amdgpu_dm_atomic_commit_tail(
 	}
 
 	/* update planes when needed per crtc*/
-	for_each_new_crtc_in_state(state, pcrtc, old_crtc_state, j) {
+	for_each_old_crtc_in_state(state, pcrtc, old_crtc_state, j) {
 		new_acrtc_state = to_dm_crtc_state(pcrtc-&gt;state);
 
 		if (new_acrtc_state-&gt;stream)
@@ -4218,7 +4208,7 @@ void amdgpu_dm_atomic_commit_tail(
 	 * mark consumed event for drm_atomic_helper_commit_hw_done
 	 */
 	spin_lock_irqsave(&amp;adev-&gt;ddev-&gt;event_lock, flags);
-	for_each_new_crtc_in_state(state, crtc, old_crtc_state, i) {
+	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 		if (acrtc-&gt;base.state-&gt;event)
@@ -4402,7 +4392,7 @@ static int dm_update_crtcs_state(
 		new_acrtc_state = to_dm_crtc_state(crtc_state);
 		acrtc = to_amdgpu_crtc(crtc);
 
-		aconnector = amdgpu_dm_find_first_crct_matching_connector(state, crtc, true);
+		aconnector = amdgpu_dm_find_first_crct_matching_connector(state, crtc);
 
 		/* TODO This hack should go away */
 		if (aconnector) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 630e6cd..1c55a0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -228,8 +228,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 struct amdgpu_dm_connector *amdgpu_dm_find_first_crct_matching_connector(
 	struct drm_atomic_state *state,
-	struct drm_crtc *crtc,
-	bool from_state_var);
+	struct drm_crtc *crtc);
 
 
 struct amdgpu_framebuffer;
<div class="moz-txt-sig">-- 
2.7.4

_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</div></pre>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------A741F8C606EA77D65319AEA4--

--===============0677257467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0677257467==--
