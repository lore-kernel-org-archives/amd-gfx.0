From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven
Date: Mon, 18 Dec 2017 10:22:43 +0100
Message-ID: <e3d20771-df70-b9e5-345b-9914c54db292@gmail.com>
References: <1513269904-3385-1-git-send-email-yong.zhao@amd.com>
 <9ebd38b5-2b12-8797-65e5-3a920ce697aa@gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1837124146=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9ebd38b5-2b12-8797-65e5-3a920ce697aa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1837124146==
Content-Type: multipart/alternative;
 boundary="------------013FD6789C2BCDFE9F043FAF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------013FD6789C2BCDFE9F043FAF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The problem was a merge conflict.

No idea what exactly went wrong, but Yong ended up with a branch where 
the vm_size was always overwritten with the value 64.

So we can completely drop this patch and yes when an user overrides the 
vm_size value he/she should know what the consequences are.

Regards,
Christian.

Am 17.12.2017 um 00:21 schrieb Felix Kühling:
> Is there a way to override the VM size for KFD VMs only? Only they
> depend on ATS, so only they need to be forced to be 48-bits.
>
> On the other hand, it could be argued that a user who manually sets the
> VM size with a module parameter knows what they're doing. So let them
> break ATS.
>
> Regards,
>    Felix
>
>
> Am 14.12.2017 um 17:45 schrieb Yong Zhao:
>> Change-Id: Id522c1cbadb8c069720f4e64a31cff42cd014733
>> Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 709587d..93500e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2534,7 +2534,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t vm_size,
>>   	uint64_t tmp;
>>   
>>   	/* adjust vm size first */
>> -	if (amdgpu_vm_size != -1) {
>> +	if (amdgpu_vm_size != -1 && adev->asic_type != CHIP_RAVEN) {
>>   		unsigned max_size = 1 << (max_bits - 30);
>>   
>>   		vm_size = amdgpu_vm_size;
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------013FD6789C2BCDFE9F043FAF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The problem was a merge conflict.<br>
      <br>
      No idea what exactly went wrong, but Yong ended up with a branch
      where the vm_size was always overwritten with the value 64.<br>
      <br>
      So we can completely drop this patch and yes when an user
      overrides the vm_size value he/she should know what the
      consequences are.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 17.12.2017 um 00:21 schrieb Felix Kühling:<br>
    </div>
    <blockquote type="cite"
      cite="mid:9ebd38b5-2b12-8797-65e5-3a920ce697aa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <pre wrap="">Is there a way to override the VM size for KFD VMs only? Only they
depend on ATS, so only they need to be forced to be 48-bits.

On the other hand, it could be argued that a user who manually sets the
VM size with a module parameter knows what they're doing. So let them
break ATS.

Regards,
  Felix


Am 14.12.2017 um 17:45 schrieb Yong Zhao:
</pre>
      <blockquote type="cite">
        <pre wrap="">Change-Id: Id522c1cbadb8c069720f4e64a31cff42cd014733
Signed-off-by: Yong Zhao <a class="moz-txt-link-rfc2396E" href="mailto:yong.zhao-5C7GfCeVMHo@public.gmane.org">&lt;yong.zhao-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 709587d..93500e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2534,7 +2534,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t vm_size,
 	uint64_t tmp;
 
 	/* adjust vm size first */
-	if (amdgpu_vm_size != -1) {
+	if (amdgpu_vm_size != -1 &amp;&amp; adev-&gt;asic_type != CHIP_RAVEN) {
 		unsigned max_size = 1 &lt;&lt; (max_bits - 30);
 
 		vm_size = amdgpu_vm_size;
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
    <br>
  </body>
</html>

--------------013FD6789C2BCDFE9F043FAF--

--===============1837124146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1837124146==--
