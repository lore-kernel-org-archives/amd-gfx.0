From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: vcn10 Add callback for
 emit_reg_write_reg_wait
Date: Tue, 1 May 2018 16:24:44 -0400
Message-ID: <8410399e-1417-4125-49ad-693cb8d95479@amd.com>
References: <20180501141800.15091-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1164254938=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180501141800.15091-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1164254938==
Content-Type: multipart/alternative;
 boundary="------------17389ECBC980A098D155B391"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------17389ECBC980A098D155B391
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Andrey


On 05/01/2018 10:18 AM, Tom St Denis wrote:
> The callback .emit_reg_write_reg_wait was missing for vcn decode
> which resulted in a kernel oops.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index d9a15338db7e..0501746b6c2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1109,6 +1109,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = vcn_v1_0_dec_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v1_0_dec_ring_emit_reg_wait,
> +	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>   };
>   
>   static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {


--------------17389ECBC980A098D155B391
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E"
        href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      <br>
      Andrey </p>
    <br>
    <div class="moz-cite-prefix">On 05/01/2018 10:18 AM, Tom St Denis
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180501141800.15091-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">The callback .emit_reg_write_reg_wait was missing for vcn decode
which resulted in a kernel oops.

Signed-off-by: Tom St Denis <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index d9a15338db7e..0501746b6c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1109,6 +1109,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.end_use = amdgpu_vcn_ring_end_use,
 	.emit_wreg = vcn_v1_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v1_0_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
 static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------17389ECBC980A098D155B391--

--===============1164254938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1164254938==--
