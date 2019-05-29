From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer
Date: Wed, 29 May 2019 09:53:53 +0200
Message-ID: <9a23918d-e301-a102-733f-31198495edc9@gmail.com>
References: <1559030775-19612-1-git-send-email-Emily.Deng@amd.com>
 <MWHPR12MB1326361E2C7ADE7523E3E7D48F1E0@MWHPR12MB1326.namprd12.prod.outlook.com>
 <MWHPR12MB1326C5856A40BB52D1BC34508F1F0@MWHPR12MB1326.namprd12.prod.outlook.com>
 <MWHPR12MB132656C894105F239387AE948F1F0@MWHPR12MB1326.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0356001149=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB132656C894105F239387AE948F1F0-Gy0DoCVfaSVaj5rVPFIlogdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0356001149==
Content-Type: multipart/alternative;
 boundary="------------43F55E95D4AB901E9A34429D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------43F55E95D4AB901E9A34429D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for the delay, your patch simply got stuck in the daily wave of mails.

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Regards,
Christian.

Am 29.05.19 um 05:07 schrieb Deng, Emily:
> Hi Christian,
>       I have reverted the before change as your suggestion, and sent this new patch, could you help to review this?
>
> Best wishes
> Emily Deng
>
>
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Deng,
>> Emily
>> Sent: Wednesday, May 29, 2019 10:52 AM
>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: RE: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer
>>
>> Ping......
>>
>> Best wishes
>> Emily Deng
>>
>>
>>
>>> -----Original Message-----
>>> From: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>> Sent: Tuesday, May 28, 2019 6:14 PM
>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Subject: RE: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer
>>>
>>> Ping ......
>>>
>>> Best wishes
>>> Emily Deng
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
>>>> Emily Deng
>>>> Sent: Tuesday, May 28, 2019 4:06 PM
>>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>>> Subject: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer
>>>>
>>>> As it will destroy clear_state_obj, and also will unpin it in the
>>>> gfx_v9_0_sw_fini, so don't need to call amdgpu_bo_free_kernel in
>>>> gfx_v9_0_sw_fini, or it will have unpin warning.
>>>>
>>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +---
>>>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> index c763733..cc5a382 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> @@ -1794,9 +1794,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>>>>
>>>> 	gfx_v9_0_mec_fini(adev);
>>>> 	gfx_v9_0_ngg_fini(adev);
>>>> -	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>>>> -				&adev->gfx.rlc.clear_state_gpu_addr,
>>>> -				(void **)&adev->gfx.rlc.cs_ptr);
>>>> +	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>>> 	if (adev->asic_type == CHIP_RAVEN) {
>>>> 		amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
>>>> 				&adev->gfx.rlc.cp_table_gpu_addr,
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------43F55E95D4AB901E9A34429D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Sorry for the delay, your patch simply
      got stuck in the daily wave of mails.<br>
      <br>
      Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 29.05.19 um 05:07 schrieb Deng, Emily:<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR12MB132656C894105F239387AE948F1F0-Gy0DoCVfaSVaj5rVPFIlogdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">Hi Christian,
     I have reverted the before change as your suggestion, and sent this new patch, could you help to review this?

Best wishes
Emily Deng



</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> On Behalf Of Deng,
Emily
Sent: Wednesday, May 29, 2019 10:52 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Subject: RE: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer

Ping......

Best wishes
Emily Deng



</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>
Sent: Tuesday, May 28, 2019 6:14 PM
To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Subject: RE: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer

Ping ......

Best wishes
Emily Deng



</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> On Behalf Of
Emily Deng
Sent: Tuesday, May 28, 2019 4:06 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Cc: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>
Subject: [PATCH] drm/amdgpu:Fix the unpin warning about csb buffer

As it will destroy clear_state_obj, and also will unpin it in the
gfx_v9_0_sw_fini, so don't need to call amdgpu_bo_free_kernel in
gfx_v9_0_sw_fini, or it will have unpin warning.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +---
1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c763733..cc5a382 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1794,9 +1794,7 @@ static int gfx_v9_0_sw_fini(void *handle)

	gfx_v9_0_mec_fini(adev);
	gfx_v9_0_ngg_fini(adev);
-	amdgpu_bo_free_kernel(&amp;adev-&gt;gfx.rlc.clear_state_obj,
-				&amp;adev-&gt;gfx.rlc.clear_state_gpu_addr,
-				(void **)&amp;adev-&gt;gfx.rlc.cs_ptr);
+	amdgpu_bo_unref(&amp;adev-&gt;gfx.rlc.clear_state_obj);
	if (adev-&gt;asic_type == CHIP_RAVEN) {
		amdgpu_bo_free_kernel(&amp;adev-&gt;gfx.rlc.cp_table_obj,
				&amp;adev-&gt;gfx.rlc.cp_table_gpu_addr,
--
2.7.4

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------43F55E95D4AB901E9A34429D--

--===============0356001149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0356001149==--
