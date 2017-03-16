From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] amdgpu: add new VA operations CLEAR and REPLACE
Date: Thu, 16 Mar 2017 15:20:41 +0100
Message-ID: <6c9dce66-bc31-cd9a-8ea5-c3a2439d1cc6@amd.com>
References: <1489636601-31486-1-git-send-email-Jerry.Zhang@amd.com>
 <1489636601-31486-2-git-send-email-Jerry.Zhang@amd.com>
 <DM5PR12MB18189A8887495F5EB83831FEFF260@DM5PR12MB1818.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1148706738=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB18189A8887495F5EB83831FEFF260-2J9CzHegvk+QhrfEZJlvtAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1148706738==
Content-Type: multipart/alternative;
	boundary="------------7A6FC93E0E6D8E237C936549"

--------------7A6FC93E0E6D8E237C936549
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jerry,

fell free to use this patch internally, but the upstream copy of 
include/drm/amdgpu_drm.h should be updated when the kernel change land.

Emil usually points out how to do this correctly whenever we try to add 
changes manually.

Christian.

Am 16.03.2017 um 15:05 schrieb Zhang, Jerry:
> Hi Christian,
>
> May I get a RB for this patch?
>
> Regards,
> Jerry(Junwei Zhang)
>
> ________________________________________
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> Sent: Thursday, March 16, 2017 11:56
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhang, Jerry
> Subject: [PATCH 1/4] amdgpu: add new VA operations CLEAR and REPLACE
>
> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> ---
>  include/drm/amdgpu_drm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 69a7340..34f8282 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -410,6 +410,8 @@ struct drm_amdgpu_gem_op {
>
>  #define AMDGPU_VA_OP_MAP                       1
>  #define AMDGPU_VA_OP_UNMAP                     2
> +#define AMDGPU_VA_OP_CLEAR                     3
> +#define AMDGPU_VA_OP_REPLACE                   4
>
>  /* Delay the page table update till the next CS */
>  #define AMDGPU_VM_DELAY_UPDATE         (1 << 0)
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------7A6FC93E0E6D8E237C936549
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Jerry,<br>
      <br>
      fell free to use this patch internally, but the upstream copy of
      include/drm/amdgpu_drm.h should be updated when the kernel change
      land.<br>
      <br>
      Emil usually points out how to do this correctly whenever we try
      to add changes manually.<br>
      <br>
      Christian.<br>
      <br>
      Am 16.03.2017 um 15:05 schrieb Zhang, Jerry:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB18189A8887495F5EB83831FEFF260-2J9CzHegvk+QhrfEZJlvtAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Hi Christian,<br>
            <br>
            May I get a RB for this patch?<br>
            <br>
            Regards,<br>
            Jerry(Junwei Zhang)<br>
            <br>
            ________________________________________<br>
            From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
            on behalf of Junwei Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            Sent: Thursday, March 16, 2017 11:56<br>
            To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            Cc: Zhang, Jerry<br>
            Subject: [PATCH 1/4] amdgpu: add new VA operations CLEAR and
            REPLACE<br>
            <br>
            Signed-off-by: Junwei Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            ---<br>
             include/drm/amdgpu_drm.h | 2 ++<br>
             1 file changed, 2 insertions(+)<br>
            <br>
            diff --git a/include/drm/amdgpu_drm.h
            b/include/drm/amdgpu_drm.h<br>
            index 69a7340..34f8282 100644<br>
            --- a/include/drm/amdgpu_drm.h<br>
            +++ b/include/drm/amdgpu_drm.h<br>
            @@ -410,6 +410,8 @@ struct drm_amdgpu_gem_op {<br>
            <br>
             #define AMDGPU_VA_OP_MAP                       1<br>
             #define AMDGPU_VA_OP_UNMAP                     2<br>
            +#define AMDGPU_VA_OP_CLEAR                     3<br>
            +#define AMDGPU_VA_OP_REPLACE                   4<br>
            <br>
             /* Delay the page table update till the next CS */<br>
             #define AMDGPU_VM_DELAY_UPDATE         (1 &lt;&lt; 0)<br>
            --<br>
            1.9.1<br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------7A6FC93E0E6D8E237C936549--

--===============1148706738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1148706738==--
