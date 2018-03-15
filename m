From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Improve documentation of bo_ptr in
 amdgpu_bo_create_kernel
Date: Thu, 15 Mar 2018 12:19:44 -0400
Message-ID: <32eb92c9-2e79-cb1a-7757-825183be8365@amd.com>
References: <992da07d-1f19-3a1d-c065-10824871f756@gmail.com>
 <1521130511-10816-1-git-send-email-andrey.grodzovsky@amd.com>
 <BN6PR12MB1652922737FD3A6CBA7EA323F7D00@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1494165906=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652922737FD3A6CBA7EA323F7D00-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1494165906==
Content-Type: multipart/alternative;
 boundary="------------49FA135C9F39A3A0E3408DBC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------49FA135C9F39A3A0E3408DBC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

That explains the merge conflict that surprised me :)


Thanks,

Andrey


On 03/15/2018 12:18 PM, Deucher, Alexander wrote:
>
> For the series:
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> I think Rex already applied the second one.
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, March 15, 2018 12:15 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; 
> Zhu, Rex
> *Cc:* Grodzovsky, Andrey
> *Subject:* [PATCH v2 1/2] drm/amdgpu: Improve documentation of bo_ptr 
> in amdgpu_bo_create_kernel
> and amdgpu_bo_create_reserved.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 48e0115..ac1fa33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -171,13 +171,15 @@ void amdgpu_ttm_placement_from_domain(struct 
> amdgpu_bo *abo, u32 domain)
>   * @size: size for the new BO
>   * @align: alignment for the new BO
>   * @domain: where to place it
> - * @bo_ptr: resulting BO
> + * @bo_ptr: used to initialize BOs in structures
>   * @gpu_addr: GPU addr of the pinned BO
>   * @cpu_addr: optional CPU address mapping
>   *
>   * Allocates and pins a BO for kernel internal use, and returns it still
>   * reserved.
>   *
> + * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
> + *
>   * Returns 0 on success, negative error code otherwise.
>   */
>  int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
> @@ -240,12 +242,14 @@ int amdgpu_bo_create_reserved(struct 
> amdgpu_device *adev,
>   * @size: size for the new BO
>   * @align: alignment for the new BO
>   * @domain: where to place it
> - * @bo_ptr: resulting BO
> + * @bo_ptr:  used to initialize BOs in structures
>   * @gpu_addr: GPU addr of the pinned BO
>   * @cpu_addr: optional CPU address mapping
>   *
>   * Allocates and pins a BO for kernel internal use.
>   *
> + * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
> + *
>   * Returns 0 on success, negative error code otherwise.
>   */
>  int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> -- 
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------49FA135C9F39A3A0E3408DBC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>That explains the merge conflict that surprised me :)</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 03/15/2018 12:18 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652922737FD3A6CBA7EA323F7D00-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
        rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
        &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,
        &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
        Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">For the series:<br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Reviewed-by: Alex
          Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
        I think Rex already applied the second one.<br>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Andrey Grodzovsky
              <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Thursday, March 15, 2018 12:15 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>; Zhu, Rex<br>
              <b>Cc:</b> Grodzovsky, Andrey<br>
              <b>Subject:</b> [PATCH v2 1/2] drm/amdgpu: Improve
              documentation of bo_ptr in amdgpu_bo_create_kernel</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">and amdgpu_bo_create_reserved.<br>
                  <br>
                  Signed-off-by: Andrey Grodzovsky
                  <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8
                  ++++++--<br>
                   1 file changed, 6 insertions(+), 2 deletions(-)<br>
                  <br>
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                  index 48e0115..ac1fa33 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                  @@ -171,13 +171,15 @@ void
                  amdgpu_ttm_placement_from_domain(struct amdgpu_bo
                  *abo, u32 domain)<br>
                    * @size: size for the new BO<br>
                    * @align: alignment for the new BO<br>
                    * @domain: where to place it<br>
                  - * @bo_ptr: resulting BO<br>
                  + * @bo_ptr: used to initialize BOs in structures<br>
                    * @gpu_addr: GPU addr of the pinned BO<br>
                    * @cpu_addr: optional CPU address mapping<br>
                    *<br>
                    * Allocates and pins a BO for kernel internal use,
                  and returns it still<br>
                    * reserved.<br>
                    *<br>
                  + * Note: For bo_ptr new BO is only created if bo_ptr
                  points to NULL.<br>
                  + *<br>
                    * Returns 0 on success, negative error code
                  otherwise.<br>
                    */<br>
                   int amdgpu_bo_create_reserved(struct amdgpu_device
                  *adev,<br>
                  @@ -240,12 +242,14 @@ int
                  amdgpu_bo_create_reserved(struct amdgpu_device *adev,<br>
                    * @size: size for the new BO<br>
                    * @align: alignment for the new BO<br>
                    * @domain: where to place it<br>
                  - * @bo_ptr: resulting BO<br>
                  + * @bo_ptr:  used to initialize BOs in structures<br>
                    * @gpu_addr: GPU addr of the pinned BO<br>
                    * @cpu_addr: optional CPU address mapping<br>
                    *<br>
                    * Allocates and pins a BO for kernel internal use.<br>
                    *<br>
                  + * Note: For bo_ptr new BO is only created if bo_ptr
                  points to NULL.<br>
                  + *<br>
                    * Returns 0 on success, negative error code
                  otherwise.<br>
                    */<br>
                   int amdgpu_bo_create_kernel(struct amdgpu_device
                  *adev,<br>
                  -- <br>
                  2.7.4<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk582111" previewremoved="true"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------49FA135C9F39A3A0E3408DBC--

--===============1494165906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1494165906==--
