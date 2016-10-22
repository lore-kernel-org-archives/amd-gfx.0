From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use amdgpu_bo_[create|free]_kernel for wb
Date: Sat, 22 Oct 2016 19:45:44 +0200
Message-ID: <871ee1fe-fd9b-c442-64b5-1bacf669d870@vodafone.de>
References: <1477078293-23098-1-git-send-email-alexander.deucher@amd.com>
 <0851af1f-0e53-b0aa-10a7-432f6fad68dd@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1989252153=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0851af1f-0e53-b0aa-10a7-432f6fad68dd-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1989252153==
Content-Type: multipart/alternative;
 boundary="------------A34C319463E69BD51CB04021"

This is a multi-part message in MIME format.
--------------A34C319463E69BD51CB04021
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Am 22.10.2016 um 10:20 schrieb Edward O'Callaghan:
> Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>
> On 10/22/2016 06:31 AM, Alex Deucher wrote:
>> Rather than open coding it.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++------------------------
>>   1 file changed, 7 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b7b6542..314295f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -443,13 +443,9 @@ void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>>   static void amdgpu_wb_fini(struct amdgpu_device *adev)
>>   {
>>   	if (adev->wb.wb_obj) {
>> -		if (!amdgpu_bo_reserve(adev->wb.wb_obj, false)) {
>> -			amdgpu_bo_kunmap(adev->wb.wb_obj);
>> -			amdgpu_bo_unpin(adev->wb.wb_obj);
>> -			amdgpu_bo_unreserve(adev->wb.wb_obj);
>> -		}
>> -		amdgpu_bo_unref(&adev->wb.wb_obj);
>> -		adev->wb.wb = NULL;
>> +		amdgpu_bo_free_kernel(&adev->wb.wb_obj,
>> +				      &adev->wb.gpu_addr,
>> +				      (void **)&adev->wb.wb);
>>   		adev->wb.wb_obj = NULL;
>>   	}
>>   }
>> @@ -468,33 +464,14 @@ static int amdgpu_wb_init(struct amdgpu_device *adev)
>>   	int r;
>>   
>>   	if (adev->wb.wb_obj == NULL) {
>> -		r = amdgpu_bo_create(adev, AMDGPU_MAX_WB * 4, PAGE_SIZE, true,
>> -				     AMDGPU_GEM_DOMAIN_GTT, 0,  NULL, NULL,
>> -				     &adev->wb.wb_obj);
>> +		r = amdgpu_bo_create_kernel(adev, AMDGPU_MAX_WB * 4,
>> +					    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
>> +					    &adev->wb.wb_obj, &adev->wb.gpu_addr,
>> +					    (void **)&adev->wb.wb);
>>   		if (r) {
>>   			dev_warn(adev->dev, "(%d) create WB bo failed\n", r);
>>   			return r;
>>   		}
>> -		r = amdgpu_bo_reserve(adev->wb.wb_obj, false);
>> -		if (unlikely(r != 0)) {
>> -			amdgpu_wb_fini(adev);
>> -			return r;
>> -		}
>> -		r = amdgpu_bo_pin(adev->wb.wb_obj, AMDGPU_GEM_DOMAIN_GTT,
>> -				&adev->wb.gpu_addr);
>> -		if (r) {
>> -			amdgpu_bo_unreserve(adev->wb.wb_obj);
>> -			dev_warn(adev->dev, "(%d) pin WB bo failed\n", r);
>> -			amdgpu_wb_fini(adev);
>> -			return r;
>> -		}
>> -		r = amdgpu_bo_kmap(adev->wb.wb_obj, (void **)&adev->wb.wb);
>> -		amdgpu_bo_unreserve(adev->wb.wb_obj);
>> -		if (r) {
>> -			dev_warn(adev->dev, "(%d) map WB bo failed\n", r);
>> -			amdgpu_wb_fini(adev);
>> -			return r;
>> -		}
>>   
>>   		adev->wb.num_wb = AMDGPU_MAX_WB;
>>   		memset(&adev->wb.used, 0, sizeof(adev->wb.used));
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------A34C319463E69BD51CB04021
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Am 22.10.2016 um 10:20 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:0851af1f-0e53-b0aa-10a7-432f6fad68dd-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">Acked-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a>

On 10/22/2016 06:31 AM, Alex Deucher wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Rather than open coding it.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b7b6542..314295f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -443,13 +443,9 @@ void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 static void amdgpu_wb_fini(struct amdgpu_device *adev)
 {
 	if (adev-&gt;wb.wb_obj) {
-		if (!amdgpu_bo_reserve(adev-&gt;wb.wb_obj, false)) {
-			amdgpu_bo_kunmap(adev-&gt;wb.wb_obj);
-			amdgpu_bo_unpin(adev-&gt;wb.wb_obj);
-			amdgpu_bo_unreserve(adev-&gt;wb.wb_obj);
-		}
-		amdgpu_bo_unref(&amp;adev-&gt;wb.wb_obj);
-		adev-&gt;wb.wb = NULL;
+		amdgpu_bo_free_kernel(&amp;adev-&gt;wb.wb_obj,
+				      &amp;adev-&gt;wb.gpu_addr,
+				      (void **)&amp;adev-&gt;wb.wb);
 		adev-&gt;wb.wb_obj = NULL;
 	}
 }
@@ -468,33 +464,14 @@ static int amdgpu_wb_init(struct amdgpu_device *adev)
 	int r;
 
 	if (adev-&gt;wb.wb_obj == NULL) {
-		r = amdgpu_bo_create(adev, AMDGPU_MAX_WB * 4, PAGE_SIZE, true,
-				     AMDGPU_GEM_DOMAIN_GTT, 0,  NULL, NULL,
-				     &amp;adev-&gt;wb.wb_obj);
+		r = amdgpu_bo_create_kernel(adev, AMDGPU_MAX_WB * 4,
+					    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+					    &amp;adev-&gt;wb.wb_obj, &amp;adev-&gt;wb.gpu_addr,
+					    (void **)&amp;adev-&gt;wb.wb);
 		if (r) {
 			dev_warn(adev-&gt;dev, "(%d) create WB bo failed\n", r);
 			return r;
 		}
-		r = amdgpu_bo_reserve(adev-&gt;wb.wb_obj, false);
-		if (unlikely(r != 0)) {
-			amdgpu_wb_fini(adev);
-			return r;
-		}
-		r = amdgpu_bo_pin(adev-&gt;wb.wb_obj, AMDGPU_GEM_DOMAIN_GTT,
-				&amp;adev-&gt;wb.gpu_addr);
-		if (r) {
-			amdgpu_bo_unreserve(adev-&gt;wb.wb_obj);
-			dev_warn(adev-&gt;dev, "(%d) pin WB bo failed\n", r);
-			amdgpu_wb_fini(adev);
-			return r;
-		}
-		r = amdgpu_bo_kmap(adev-&gt;wb.wb_obj, (void **)&amp;adev-&gt;wb.wb);
-		amdgpu_bo_unreserve(adev-&gt;wb.wb_obj);
-		if (r) {
-			dev_warn(adev-&gt;dev, "(%d) map WB bo failed\n", r);
-			amdgpu_wb_fini(adev);
-			return r;
-		}
 
 		adev-&gt;wb.num_wb = AMDGPU_MAX_WB;
 		memset(&amp;adev-&gt;wb.used, 0, sizeof(adev-&gt;wb.used));

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

--------------A34C319463E69BD51CB04021--

--===============1989252153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1989252153==--
