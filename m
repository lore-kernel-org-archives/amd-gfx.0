From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: Don't print error when bo_pin is
 interrupted
Date: Fri, 27 Oct 2017 10:27:15 -0400
Message-ID: <a300fecf-453f-eea5-ce06-37616c6199b7@amd.com>
References: <20171026200801.14662-1-harry.wentland@amd.com>
 <ff616ee9-0e16-5278-1169-b75b61db6141@amd.com>
 <28547400-b0f2-d3b0-2f9d-14749a479257@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1740291720=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <28547400-b0f2-d3b0-2f9d-14749a479257-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org

This is a multi-part message in MIME format.
--===============1740291720==
Content-Type: multipart/alternative;
 boundary="------------8F528C552C4A5DECC47C4EE4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8F528C552C4A5DECC47C4EE4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi Christian,

thanks for clarifying the semantics. I wasn't fully clear on that. What you say makes sense. I'll respin the patch.

Harry

On 2017-10-27 03:46 AM, Christian König wrote:
> Hi Harry,
>
> actually it's best practice that you only ignore ERESTARTSYS here, see other code in the driver as well.
>
> EINTR means that the IOCTL was interrupted and can't be restarted because of some problem.
>
> EAGAIN mean the we can't do this operation right now, but might be able to do it at some point in the future.
>
> Both sound like a good idea to note to the user.
>
> Regards,
> Christian.
>
> Am 26.10.2017 um 22:16 schrieb Andrey Grodzovsky:
>>
>>
>>
>> On 2017-10-26 04:08 PM, Harry Wentland wrote:
>>> v2: Also don't print for ERESTARTSYS or EAGAIN
>>>
>>> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>>
>> Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>>
>> Thanks,
>> Andrey
>>
>>> ---
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index cf15701f208d..4401f0fb3f02 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -2944,7 +2944,8 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>  	amdgpu_bo_unreserve(rbo);
>>>  
>>>  	if (unlikely(r != 0)) {
>>> -		DRM_ERROR("Failed to pin framebuffer\n");
>>> +		if (!(r == -EINTR || r == -ERESTARTSYS || r == EAGAIN))
>>> +			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>>>  		return r;
>>>  	}
>>>  
>>
>


--------------8F528C552C4A5DECC47C4EE4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi Christian,<br>
    <br>
    thanks for clarifying the semantics. I wasn't fully clear on that.
    What you say makes sense. I'll respin the patch.<br>
    <br>
    Harry<br>
    <br>
    <div class="moz-cite-prefix">On 2017-10-27 03:46 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:28547400-b0f2-d3b0-2f9d-14749a479257-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <div class="moz-cite-prefix">Hi Harry,<br>
        <br>
        actually it's best practice that you only ignore ERESTARTSYS
        here, see other code in the driver as well.<br>
        <br>
        EINTR means that the IOCTL was interrupted and can't be
        restarted because of some problem.<br>
        <br>
        EAGAIN mean the we can't do this operation right now, but might
        be able to do it at some point in the future.<br>
        <br>
        Both sound like a good idea to note to the user.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 26.10.2017 um 22:16 schrieb Andrey Grodzovsky:<br>
      </div>
      <blockquote type="cite"
        cite="mid:ff616ee9-0e16-5278-1169-b75b61db6141-5C7GfCeVMHo@public.gmane.org">
        <p><br>
        </p>
        <br>
        <div class="moz-cite-prefix">On 2017-10-26 04:08 PM, Harry
          Wentland wrote:<br>
        </div>
        <blockquote
          cite="mid:20171026200801.14662-1-harry.wentland-5C7GfCeVMHo@public.gmane.org"
          type="cite">
          <pre wrap="">v2: Also don't print for ERESTARTSYS or EAGAIN

Signed-off-by: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
        </blockquote>
        <br>
        <pre wrap="">Reviewed-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
        <br>
        Thanks,<br>
        Andrey<br>
        <br>
        <blockquote
          cite="mid:20171026200801.14662-1-harry.wentland-5C7GfCeVMHo@public.gmane.org"
          type="cite">
          <pre wrap="">---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cf15701f208d..4401f0fb3f02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2944,7 +2944,8 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	amdgpu_bo_unreserve(rbo);
 
 	if (unlikely(r != 0)) {
-		DRM_ERROR("Failed to pin framebuffer\n");
+		if (!(r == -EINTR || r == -ERESTARTSYS || r == EAGAIN))
+			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
 		return r;
 	}
 
</pre>
        </blockquote>
        <br>
      </blockquote>
      <p><br>
      </p>
    </blockquote>
    <br>
  </body>
</html>

--------------8F528C552C4A5DECC47C4EE4--

--===============1740291720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1740291720==--
