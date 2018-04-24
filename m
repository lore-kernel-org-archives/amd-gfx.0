From: "S, Shirish" <sshankar@amd.com>
Subject: Re: [PATCH] drm/amd/display: Disallow enabling CRTC without primary
 plane with FB
Date: Tue, 24 Apr 2018 18:23:29 +0530
Message-ID: <debcc150-b32b-7fab-1aec-ffad21dbffa1@amd.com>
References: <20180418202647.25532-1-harry.wentland@amd.com>
 <9e38b52d-9e9b-b4df-e5bb-9bda1862c18a@daenzer.net>
 <3c912b9f-6756-e585-c7a7-63170e752688@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0628497701=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <3c912b9f-6756-e585-c7a7-63170e752688@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc: Bhawanpreet.Lakha@amd.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Shirish.S@amd.com
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0628497701==
Content-Type: multipart/alternative;
 boundary="------------BB2016718FFD79E21001B271"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BB2016718FFD79E21001B271
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/19/2018 8:08 PM, Harry Wentland wrote:
> On 2018-04-19 03:43 AM, Michel Dänzer wrote:
>> [ Dropping stable@ (fixes with Cc: stable are picked up for stable
>> branches once they land in Linus' tree, there's no point sending them to
>> stable@ during review), adding dri-devel ]
>>
>> On 2018-04-18 10:26 PM, Harry Wentland wrote:
>>> The below commit
>>>
>>>      "drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2"
>>>
>>> introduces a slight behavioral change to rmfb. Instead of disabling a crtc
>>> when the primary plane is disabled, it now preserves it.
>>>
>>> Since DC is currently not equipped to handle this we need to fail such
>>> a commit, otherwise we might see a corrupted screen.
>> How does the caller react to failing such a commit?
> The caller (drm_atomic_remove_fb in this case) will retry with the old behavior and disable the CRTC.
>
> Harry
That's the fall back logic suggested in the patch that caused this issue.

This patch is  Reviewed-by: Shirish S <shirish.s@amd.com 
<mailto:harry.wentland@amd.com>>

Regards,

Shirish S

>>
>>> This is based on Shirish's previous approach but avoids adding all
>>> planes to the new atomic state which leads to a full update in DC for
>>> any commit, and is not what we intend.
>>>
>>> Theoretically DM should be able to deal with states with fully populated planes,
>>> even for simple updates, such as cursor updates. This should still be
>>> addressed in the future.
>>>
>>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 6f92a19bebd6..0bdc6b484bad 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4683,6 +4683,7 @@ static int dm_update_crtcs_state(struct amdgpu_display_manager *dm,
>>>   		struct amdgpu_dm_connector *aconnector = NULL;
>>>   		struct drm_connector_state *new_con_state = NULL;
>>>   		struct dm_connector_state *dm_conn_state = NULL;
>>> +		struct drm_plane_state *new_plane_state = NULL;
>>>   
>>>   		new_stream = NULL;
>>>   
>>> @@ -4690,6 +4691,13 @@ static int dm_update_crtcs_state(struct amdgpu_display_manager *dm,
>>>   		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>>   		acrtc = to_amdgpu_crtc(crtc);
>>>   
>>> +		new_plane_state = drm_atomic_get_new_plane_state(state, new_crtc_state->crtc->primary);
>>> +
>>> +		if (new_crtc_state->enable && new_plane_state && !new_plane_state->fb) {
>>> +			ret = -EINVAL;
>>> +			goto fail;
>>> +		}
>>> +
>>>   		aconnector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
>>>   
>>>   		/* TODO This hack should go away */
>>> @@ -4894,7 +4902,7 @@ static int dm_update_planes_state(struct dc *dc,
>>>   			if (!dm_old_crtc_state->stream)
>>>   				continue;
>>>   
>>> -			DRM_DEBUG_DRIVER("Disabling DRM plane: %d on DRM crtc %d\n",
>>> +			DRM_DEBUG_ATOMIC("Disabling DRM plane: %d on DRM crtc %d\n",
>>>   					plane->base.id, old_plane_crtc->base.id);
>>>   
>>>   			if (!dc_remove_plane_from_context(
>>>
>>


--------------BB2016718FFD79E21001B271
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 4/19/2018 8:08 PM, Harry Wentland
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:3c912b9f-6756-e585-c7a7-63170e752688@amd.com">
      <pre wrap="">On 2018-04-19 03:43 AM, Michel Dänzer wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
[ Dropping stable@ (fixes with Cc: stable are picked up for stable
branches once they land in Linus' tree, there's no point sending them to
stable@ during review), adding dri-devel ]

On 2018-04-18 10:26 PM, Harry Wentland wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">The below commit

    "drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2"

introduces a slight behavioral change to rmfb. Instead of disabling a crtc
when the primary plane is disabled, it now preserves it.

Since DC is currently not equipped to handle this we need to fail such
a commit, otherwise we might see a corrupted screen.
</pre>
        </blockquote>
        <pre wrap="">
How does the caller react to failing such a commit?
</pre>
      </blockquote>
      <pre wrap="">
The caller (drm_atomic_remove_fb in this case) will retry with the old behavior and disable the CRTC.

Harry
</pre>
    </blockquote>
    That's the fall back logic suggested in the patch that caused this
    issue.<br>
    <!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
    <p class="MsoPlainText">This patch is  Reviewed-by: Shirish S &lt;<a
        href="mailto:harry.wentland@amd.com">shirish.s@amd.com</a>&gt;</p>
    <p class="MsoPlainText">Regards,</p>
    <p class="MsoPlainText">Shirish S<br>
    </p>
    <blockquote type="cite"
      cite="mid:3c912b9f-6756-e585-c7a7-63170e752688@amd.com">
      <blockquote type="cite">
        <pre wrap="">

</pre>
        <blockquote type="cite">
          <pre wrap="">This is based on Shirish's previous approach but avoids adding all
planes to the new atomic state which leads to a full update in DC for
any commit, and is not what we intend.

Theoretically DM should be able to deal with states with fully populated planes,
even for simple updates, such as cursor updates. This should still be
addressed in the future.

Signed-off-by: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland@amd.com">&lt;harry.wentland@amd.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f92a19bebd6..0bdc6b484bad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4683,6 +4683,7 @@ static int dm_update_crtcs_state(struct amdgpu_display_manager *dm,
 		struct amdgpu_dm_connector *aconnector = NULL;
 		struct drm_connector_state *new_con_state = NULL;
 		struct dm_connector_state *dm_conn_state = NULL;
+		struct drm_plane_state *new_plane_state = NULL;
 
 		new_stream = NULL;
 
@@ -4690,6 +4691,13 @@ static int dm_update_crtcs_state(struct amdgpu_display_manager *dm,
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		acrtc = to_amdgpu_crtc(crtc);
 
+		new_plane_state = drm_atomic_get_new_plane_state(state, new_crtc_state-&gt;crtc-&gt;primary);
+
+		if (new_crtc_state-&gt;enable &amp;&amp; new_plane_state &amp;&amp; !new_plane_state-&gt;fb) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		aconnector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
 
 		/* TODO This hack should go away */
@@ -4894,7 +4902,7 @@ static int dm_update_planes_state(struct dc *dc,
 			if (!dm_old_crtc_state-&gt;stream)
 				continue;
 
-			DRM_DEBUG_DRIVER("Disabling DRM plane: %d on DRM crtc %d\n",
+			DRM_DEBUG_ATOMIC("Disabling DRM plane: %d on DRM crtc %d\n",
 					plane-&gt;base.id, old_plane_crtc-&gt;base.id);
 
 			if (!dc_remove_plane_from_context(

</pre>
        </blockquote>
        <pre wrap="">

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------BB2016718FFD79E21001B271--

--===============0628497701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0628497701==--
