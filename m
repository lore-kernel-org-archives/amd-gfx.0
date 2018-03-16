From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Improve documentation of bo_ptr in
 amdgpu_bo_create_kernel
Date: Fri, 16 Mar 2018 09:55:49 -0400
Message-ID: <2fd46a7a-7dd1-6cfb-cd72-d05086c4740d@amd.com>
References: <992da07d-1f19-3a1d-c065-10824871f756@gmail.com>
 <1521130511-10816-1-git-send-email-andrey.grodzovsky@amd.com>
 <BN6PR12MB1652922737FD3A6CBA7EA323F7D00@BN6PR12MB1652.namprd12.prod.outlook.com>
 <32eb92c9-2e79-cb1a-7757-825183be8365@amd.com>
 <CY4PR12MB1687399608EE02426B0AEF31FBD70@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0770333797=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687399608EE02426B0AEF31FBD70-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a multi-part message in MIME format.
--===============0770333797==
Content-Type: multipart/alternative;
 boundary="------------C0FD7CCCE7BDED415E682496"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C0FD7CCCE7BDED415E682496
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

NP, makes sense what you did.


Andrey


On 03/16/2018 01:44 AM, Zhu, Rex wrote:
>
> Hi Andrey,
>
> Sorry for the confusion.
>
> I just need to push a bunch of patches that conflict with  your patch.
>
> So apply your patch first.
>
> Best Regards
>
> Rex
>
> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On 
> Behalf Of *Andrey Grodzovsky
> *Sent:* Friday, March 16, 2018 12:20 AM
> *To:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; 
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Zhu, Rex
> *Subject:* Re: [PATCH v2 1/2] drm/amdgpu: Improve documentation of 
> bo_ptr in amdgpu_bo_create_kernel
>
> That explains the merge conflict that surprised me :)
>
> Thanks,
>
> Andrey
>
> On 03/15/2018 12:18 PM, Deucher, Alexander wrote:
>
>     For the series:
>
>     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>     <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>     I think Rex already applied the second one.
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andrey
>     Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>     <mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>     *Sent:* Thursday, March 15, 2018 12:15 PM
>     *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>;
>     ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Zhu, Rex
>     *Cc:* Grodzovsky, Andrey
>     *Subject:* [PATCH v2 1/2] drm/amdgpu: Improve documentation of
>     bo_ptr in amdgpu_bo_create_kernel
>
>     and amdgpu_bo_create_reserved.
>
>     Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>     <mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++++--
>      1 file changed, 6 insertions(+), 2 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     index 48e0115..ac1fa33 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     @@ -171,13 +171,15 @@ void amdgpu_ttm_placement_from_domain(struct
>     amdgpu_bo *abo, u32 domain)
>       * @size: size for the new BO
>       * @align: alignment for the new BO
>       * @domain: where to place it
>     - * @bo_ptr: resulting BO
>     + * @bo_ptr: used to initialize BOs in structures
>       * @gpu_addr: GPU addr of the pinned BO
>       * @cpu_addr: optional CPU address mapping
>       *
>       * Allocates and pins a BO for kernel internal use, and returns
>     it still
>       * reserved.
>       *
>     + * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
>     + *
>       * Returns 0 on success, negative error code otherwise.
>       */
>      int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>     @@ -240,12 +242,14 @@ int amdgpu_bo_create_reserved(struct
>     amdgpu_device *adev,
>       * @size: size for the new BO
>       * @align: alignment for the new BO
>       * @domain: where to place it
>     - * @bo_ptr: resulting BO
>     + * @bo_ptr:  used to initialize BOs in structures
>       * @gpu_addr: GPU addr of the pinned BO
>       * @cpu_addr: optional CPU address mapping
>       *
>       * Allocates and pins a BO for kernel internal use.
>       *
>     + * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
>     + *
>       * Returns 0 on success, negative error code otherwise.
>       */
>      int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>     -- 
>     2.7.4
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------C0FD7CCCE7BDED415E682496
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>NP, makes sense what you did.</p>
    <p><br>
    </p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 03/16/2018 01:44 AM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687399608EE02426B0AEF31FBD70-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 14 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;
	color:black;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:SimSun;
	color:black;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:SimSun;
	color:black;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Hi Andrey,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Sorry for the confusion.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">I just need to push a bunch of patches that
            conflict with  your patch.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">So apply your patch first.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Best Regards<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Rex<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #B5C4DF
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext"
                  lang="EN-US">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext"
                lang="EN-US"> amd-gfx
                [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                <b>On Behalf Of </b>Andrey Grodzovsky<br>
                <b>Sent:</b> Friday, March 16, 2018 12:20 AM<br>
                <b>To:</b> Deucher, Alexander;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>; Zhu, Rex<br>
                <b>Subject:</b> Re: [PATCH v2 1/2] drm/amdgpu: Improve
                documentation of bo_ptr in amdgpu_bo_create_kernel<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p><span lang="EN-US">That explains the merge conflict that
            surprised me :)<o:p></o:p></span></p>
        <p><span lang="EN-US"><o:p> </o:p></span></p>
        <p><span lang="EN-US">Thanks,<o:p></o:p></span></p>
        <p><span lang="EN-US">Andrey<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <p class="MsoNormal"><span lang="EN-US">On 03/15/2018 12:18
              PM, Deucher, Alexander wrote:<o:p></o:p></span></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <div id="divtagdefaultwrapper">
            <p><span
                style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                lang="EN-US">For the series:<o:p></o:p></span></p>
            <p><span
                style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                lang="EN-US">Reviewed-by: Alex Deucher
                <a href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                lang="EN-US">I think Rex already applied the second one.<br>
                <br>
                <o:p></o:p></span></p>
            <div>
              <div class="MsoNormal" style="text-align:center"
                align="center"><span
                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                  lang="EN-US">
                  <hr size="2" align="center" width="98%">
                </span></div>
              <div id="divRplyFwdMsg">
                <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                      lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                    lang="EN-US"> amd-gfx
                    <a
                      href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                    on behalf of Andrey Grodzovsky
                    <a href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Sent:</b> Thursday, March 15, 2018 12:15 PM<br>
                    <b>To:</b> <a
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                    <a href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>;
                    Zhu, Rex<br>
                    <b>Cc:</b> Grodzovsky, Andrey<br>
                    <b>Subject:</b> [PATCH v2 1/2] drm/amdgpu: Improve
                    documentation of bo_ptr in amdgpu_bo_create_kernel</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                    lang="EN-US">
                    <o:p></o:p></span></p>
                <div>
                  <p class="MsoNormal"><span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                      lang="EN-US"> <o:p></o:p></span></p>
                </div>
              </div>
              <div>
                <div>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"
                      lang="EN-US">and amdgpu_bo_create_reserved.<br>
                      <br>
                      Signed-off-by: Andrey Grodzovsky <a
                        href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
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
                        * Allocates and pins a BO for kernel internal
                      use, and returns it still<br>
                        * reserved.<br>
                        *<br>
                      + * Note: For bo_ptr new BO is only created if
                      bo_ptr points to NULL.<br>
                      + *<br>
                        * Returns 0 on success, negative error code
                      otherwise.<br>
                        */<br>
                       int amdgpu_bo_create_reserved(struct
                      amdgpu_device *adev,<br>
                      @@ -240,12 +242,14 @@ int
                      amdgpu_bo_create_reserved(struct amdgpu_device
                      *adev,<br>
                        * @size: size for the new BO<br>
                        * @align: alignment for the new BO<br>
                        * @domain: where to place it<br>
                      - * @bo_ptr: resulting BO<br>
                      + * @bo_ptr:  used to initialize BOs in structures<br>
                        * @gpu_addr: GPU addr of the pinned BO<br>
                        * @cpu_addr: optional CPU address mapping<br>
                        *<br>
                        * Allocates and pins a BO for kernel internal
                      use.<br>
                        *<br>
                      + * Note: For bo_ptr new BO is only created if
                      bo_ptr points to NULL.<br>
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
                      <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <a
                        href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                        id="LPlnk582111" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
                </div>
              </div>
            </div>
          </div>
        </blockquote>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C0FD7CCCE7BDED415E682496--

--===============0770333797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0770333797==--
