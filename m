From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: Deinitialize vamgr_high{,_32}
Date: Tue, 1 May 2018 07:20:22 -0400
Message-ID: <f07e3906-72f1-ee3e-b2e2-0f25c44e5fcc@amd.com>
References: <20180427144445.21127-1-michel@daenzer.net>
 <dc7c9c89-d301-cbd8-1d13-501ce0609b07@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147899930=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dc7c9c89-d301-cbd8-1d13-501ce0609b07-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0147899930==
Content-Type: multipart/alternative;
 boundary="------------A46D7CDD5CA709A700FC02D1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A46D7CDD5CA709A700FC02D1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Andrey


On 05/01/2018 04:03 AM, Michel Dänzer wrote:
> On 2018-04-27 04:44 PM, Michel Dänzer wrote:
>> From: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>
>> Fixes memory leaks.
>>
>> Signed-off-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   amdgpu/amdgpu_device.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c
>> index d81efcf8..983b19ab 100644
>> --- a/amdgpu/amdgpu_device.c
>> +++ b/amdgpu/amdgpu_device.c
>> @@ -128,6 +128,8 @@ static void amdgpu_device_free_internal(amdgpu_device_handle dev)
>>   {
>>   	amdgpu_vamgr_deinit(&dev->vamgr_32);
>>   	amdgpu_vamgr_deinit(&dev->vamgr);
>> +	amdgpu_vamgr_deinit(&dev->vamgr_high_32);
>> +	amdgpu_vamgr_deinit(&dev->vamgr_high);
>>   	util_hash_table_destroy(dev->bo_flink_names);
>>   	util_hash_table_destroy(dev->bo_handles);
>>   	pthread_mutex_destroy(&dev->bo_table_mutex);
>>
> Any reviews? Without negative feedback, I'll push this tomorrow.
>
>


--------------A46D7CDD5CA709A700FC02D1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E"
        href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      <br>
      Andrey
    </p>
    <br>
    <div class="moz-cite-prefix">On 05/01/2018 04:03 AM, Michel Dänzer
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:dc7c9c89-d301-cbd8-1d13-501ce0609b07-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">On 2018-04-27 04:44 PM, Michel Dänzer wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">From: Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a>

Fixes memory leaks.

Signed-off-by: Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c
index d81efcf8..983b19ab 100644
--- a/amdgpu/amdgpu_device.c
+++ b/amdgpu/amdgpu_device.c
@@ -128,6 +128,8 @@ static void amdgpu_device_free_internal(amdgpu_device_handle dev)
 {
 	amdgpu_vamgr_deinit(&amp;dev-&gt;vamgr_32);
 	amdgpu_vamgr_deinit(&amp;dev-&gt;vamgr);
+	amdgpu_vamgr_deinit(&amp;dev-&gt;vamgr_high_32);
+	amdgpu_vamgr_deinit(&amp;dev-&gt;vamgr_high);
 	util_hash_table_destroy(dev-&gt;bo_flink_names);
 	util_hash_table_destroy(dev-&gt;bo_handles);
 	pthread_mutex_destroy(&amp;dev-&gt;bo_table_mutex);

</pre>
      </blockquote>
      <pre wrap="">
Any reviews? Without negative feedback, I'll push this tomorrow.


</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------A46D7CDD5CA709A700FC02D1--

--===============0147899930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0147899930==--
