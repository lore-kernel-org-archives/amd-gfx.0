From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add contiguous flag in ucode bo create
Date: Fri, 9 Jun 2017 16:51:17 +0200
Message-ID: <e4a9c390-5b0b-0d6e-33fa-4427aa7c6ee0@vodafone.de>
References: <1497009541-2635-1-git-send-email-horace.chen@amd.com>
 <4c9e08c4-0d9e-17b4-e3df-30e447c34ea0@vodafone.de>
 <MWHPR12MB1629B8FDE5C086109492DCB1E1CE0@MWHPR12MB1629.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1138457789=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1629B8FDE5C086109492DCB1E1CE0-Gy0DoCVfaSVXJjvGLpYL8gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Chen, Horace" <Horace.Chen-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1138457789==
Content-Type: multipart/alternative;
 boundary="------------151869F3377C4E29288C87FC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------151869F3377C4E29288C87FC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Horace,

yeah that looks good to me, feel free to add my reviewed-by line and 
push it.

Regards,
Christian.

Am 09.06.2017 um 15:45 schrieb Chen, Horace:
> Hi Christian,
>
> Sorry, it's my first time to submit code to the staging. I have done the fix.  Attached the fixed review.
> Thank you for the review.
>
> Regards,
> Horace.
>
> -----Original Message-----
> From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
> Sent: Friday, June 09, 2017 8:25 PM
> To: Chen, Horace; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Huang, Ray
> Subject: Re: [PATCH] drm/amdgpu: add contiguous flag in ucode bo create
>
> Am 09.06.2017 um 13:59 schrieb horchen:
>> Under VF environment, the ucode would be settled to the visible VRAM,
>> As it would be pinned to the visible VRAM, it's better to add
>> contiguous flag,otherwise it need to move gpu address during the pin
>> process. This movement is not necessary.
>>
>> Signed-off-by: horchen <horace.chen-5C7GfCeVMHo@public.gmane.org>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> index cd6d3d0..3b1ee05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> @@ -379,7 +379,8 @@ int amdgpu_ucode_init_bo(struct amdgpu_device
>> *adev)
>>    
>>    	err = amdgpu_bo_create(adev, adev->firmware.fw_size, PAGE_SIZE, true,
>>    				amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
>> -				0, NULL, NULL, bo);
>> +				amdgpu_sriov_vf(adev) ? AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS : 0,
>> +				NULL, NULL, bo);
> Mhm, did you missed my comment? You can add the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS unconditionally here, e.g. without checking amdgpu_sriov_vf(adev).
>
> With that fixed the patch is Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
>>    	if (err) {
>>    		dev_err(adev->dev, "(%d) Firmware buffer allocate failed\n", err);
>>    		goto failed;
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------151869F3377C4E29288C87FC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Horace,<br>
      <br>
      yeah that looks good to me, feel free to add my reviewed-by line
      and push it.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.06.2017 um 15:45 schrieb Chen, Horace:<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR12MB1629B8FDE5C086109492DCB1E1CE0-Gy0DoCVfaSVXJjvGLpYL8gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <pre wrap="">Hi Christian,

Sorry, it's my first time to submit code to the staging. I have done the fix.  Attached the fixed review.
Thank you for the review.

Regards,
Horace. 

-----Original Message-----
From: Christian König [<a class="moz-txt-link-freetext" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>] 
Sent: Friday, June 09, 2017 8:25 PM
To: Chen, Horace; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Cc: Huang, Ray
Subject: Re: [PATCH] drm/amdgpu: add contiguous flag in ucode bo create

Am 09.06.2017 um 13:59 schrieb horchen:
</pre>
      <blockquote type="cite">
        <pre wrap="">Under VF environment, the ucode would be settled to the visible VRAM, 
As it would be pinned to the visible VRAM, it's better to add 
contiguous flag,otherwise it need to move gpu address during the pin 
process. This movement is not necessary.

Signed-off-by: horchen <a class="moz-txt-link-rfc2396E" href="mailto:horace.chen-5C7GfCeVMHo@public.gmane.org">&lt;horace.chen-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index cd6d3d0..3b1ee05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -379,7 +379,8 @@ int amdgpu_ucode_init_bo(struct amdgpu_device 
*adev)
  
  	err = amdgpu_bo_create(adev, adev-&gt;firmware.fw_size, PAGE_SIZE, true,
  				amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
-				0, NULL, NULL, bo);
+				amdgpu_sriov_vf(adev) ? AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS : 0,
+				NULL, NULL, bo);
</pre>
      </blockquote>
      <pre wrap="">
Mhm, did you missed my comment? You can add the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS unconditionally here, e.g. without checking amdgpu_sriov_vf(adev).

With that fixed the patch is Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.

</pre>
      <blockquote type="cite">
        <pre wrap="">  	if (err) {
  		dev_err(adev-&gt;dev, "(%d) Firmware buffer allocate failed\n", err);
  		goto failed;
</pre>
      </blockquote>
      <pre wrap="">

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------151869F3377C4E29288C87FC--

--===============1138457789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1138457789==--
