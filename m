From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Changes for enabling ATS support from PTE
Date: Wed, 26 Jul 2017 11:41:53 +0200
Message-ID: <52c19148-09d5-0d02-a8f0-6b3e93a9f288@vodafone.de>
References: <69a3e55f-a311-5827-10a2-1cac8b0a1ee3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268688450=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <69a3e55f-a311-5827-10a2-1cac8b0a1ee3-5C7GfCeVMHo@public.gmane.org>
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
To: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0268688450==
Content-Type: multipart/alternative;
 boundary="------------43ECB6972105DEB5BDB93793"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------43ECB6972105DEB5BDB93793
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yong,

looks pretty good to me, but still quite a few comments.

First of all please send the patches directly to the mailing list using 
"git send-email" and not as attachment.

Patch #1:
> +
> +	switch (word_size) {
> +	case 4:
> +		num_dw = num_loops * adev->mman.buffer_funcs->fill_num_dw;
> +		break;
> +	case 8: /* 10 double words for each SDMA_OP_PTEPDE cmd */
> +		num_dw = num_loops * 10;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
That is to complicated, we don't use the 32bit pattern during the fill 
anyway. So just change that to a 64bit pattern and always use the 
amdgpu_vm_set_pte_pde() function.

Patch #2:
> +/* Flag that supports ATS through PTE on GFX9 */
> +#define AMDGPU_GEM_CLEAR_PTE_WITH_ATS_SUPPORT	(1 << 6)
NAK to that approach, GEM flags are visible to userspace.

Instead add the pattern to use for the clear to 
amdgpu_bo_create()/amdgpu_bo_create_restricted().

>   	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
>   	bool                    use_cpu_for_update;
>   
> -	/* Whether this is a Compute or GFX Context */
> -	int			vm_context;
> +	/* flags indicating the properties of VM context */
> +	int			vm_context_flags;
Either merge use_cpu_for_update into the flags as well or use a separate 
boolean for this (I prefer the later).

If you want to merge drop the "vm_context_" prefix in the name, just 
flags should be sufficient.

Regards,
Christian.

Am 26.07.2017 um 00:48 schrieb Yong Zhao:
> Hi there,
>
> Attached are two patches made to amdgpu in order to support ATS on 
> Raven. Please review them.
>
> Regards,
>
> Yong
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------43ECB6972105DEB5BDB93793
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Yong,<br>
      <br>
      looks pretty good to me, but still quite a few comments.<br>
      <br>
      First of all please send the patches directly to the mailing list
      using "git send-email" and not as attachment.<br>
      <br>
      Patch #1:<br>
      <blockquote type="cite">
        <pre wrap="">+
+	switch (word_size) {
+	case 4:
+		num_dw = num_loops * adev-&gt;mman.buffer_funcs-&gt;fill_num_dw;
+		break;
+	case 8: /* 10 double words for each SDMA_OP_PTEPDE cmd */
+		num_dw = num_loops * 10;
+		break;
+	default:
+		return -EINVAL;
+	}</pre>
      </blockquote>
      That is to complicated, we don't use the 32bit pattern during the
      fill anyway. So just change that to a 64bit pattern and always use
      the amdgpu_vm_set_pte_pde() function.<br>
      <br>
      Patch #2:<br>
      <blockquote type="cite">
        <pre wrap="">+/* Flag that supports ATS through PTE on GFX9 */
+#define AMDGPU_GEM_CLEAR_PTE_WITH_ATS_SUPPORT	(1 &lt;&lt; 6)</pre>
      </blockquote>
      NAK to that approach, GEM flags are visible to userspace.<br>
      <br>
      Instead add the pattern to use for the clear to
      amdgpu_bo_create()/amdgpu_bo_create_restricted().<br>
      <br>
      <blockquote type="cite">
        <pre wrap=""> 	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
 	bool                    use_cpu_for_update;
 
-	/* Whether this is a Compute or GFX Context */
-	int			vm_context;
+	/* flags indicating the properties of VM context */
+	int			vm_context_flags;</pre>
      </blockquote>
      Either merge use_cpu_for_update into the flags as well or use a
      separate boolean for this (I prefer the later).<br>
      <br>
      If you want to merge drop the "vm_context_" prefix in the name,
      just flags should be sufficient.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 26.07.2017 um 00:48 schrieb Yong Zhao:<br>
    </div>
    <blockquote type="cite"
      cite="mid:69a3e55f-a311-5827-10a2-1cac8b0a1ee3-5C7GfCeVMHo@public.gmane.org">Hi there,
      <br>
      <br>
      Attached are two patches made to amdgpu in order to support ATS on
      Raven. Please review them.
      <br>
      <br>
      Regards,
      <br>
      <br>
      Yong
      <br>
      <br>
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

--------------43ECB6972105DEB5BDB93793--

--===============0268688450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0268688450==--
