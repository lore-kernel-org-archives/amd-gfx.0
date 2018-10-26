From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM leaf walking
Date: Fri, 26 Oct 2018 09:34:01 +0200
Message-ID: <c3a525d1-2537-f561-5bd1-5b862a0d3e3c@gmail.com>
References: <20181025143804.1698-1-christian.koenig@amd.com>
 <BN6PR12MB180949222B5967C8A2DD147DF7F70@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BYAPR12MB2775292DA22A6D78872926DDFBF70@BYAPR12MB2775.namprd12.prod.outlook.com>
 <BYAPR12MB2775D822132203F5E206128EFBF70@BYAPR12MB2775.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1045644249=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2775D822132203F5E206128EFBF70-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1045644249==
Content-Type: multipart/alternative;
 boundary="------------92F8838C55850B1200693B7D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------92F8838C55850B1200693B7D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, that came to my mind as well.

But this is the only case where we would use the return value and not 
use cursor->pfn as criteria to abort.

So to be consistent I rather don't want to do this,
Christian.

Am 25.10.18 um 17:43 schrieb Zhu, Rex:
>
> How about add a return value for the function amdgpu_vm_pt_next?
>
> And change the code as:
>
>      ret = amdgpu_vm_pt_next(adev, cursor);
> -       while (amdgpu_vm_pt_descendant(adev, cursor));
> +       if (!ret)
> +               while (amdgpu_vm_pt_descendant(adev, cursor));
>
> Best Regards
>
> Rex
>
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> *On Behalf Of 
> *Zhu, Rex
> *Sent:* Thursday, October 25, 2018 11:34 PM
> *To:* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: [PATCH] drm/amdgpu: fix VM leaf walking
>
> Patch is Tested-by:  Rex Zhu Rex.Zhu-5C7GfCeVMHo@public.gmane.org <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> Regards
>
> Rex
>
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> *On Behalf Of 
> *Deucher, Alexander
> *Sent:* Thursday, October 25, 2018 11:08 PM
> *To:* Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH] drm/amdgpu: fix VM leaf walking
>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org 
> <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>>
>
> ------------------------------------------------------------------------
>
> *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of Christian 
> König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> *Sent:* Thursday, October 25, 2018 10:38 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* [PATCH] drm/amdgpu: fix VM leaf walking
>
> Make sure we don't try to go down further after the leave walk already
> ended. This fixes a crash with a new VM test.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org 
> <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db0cbf8d219d..352b30409060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -542,7 +542,8 @@ static void amdgpu_vm_pt_next_leaf(struct 
> amdgpu_device *adev,
>                                     struct amdgpu_vm_pt_cursor *cursor)
>  {
>          amdgpu_vm_pt_next(adev, cursor);
> -       while (amdgpu_vm_pt_descendant(adev, cursor));
> +       if (cursor->pfn != ~0ll)
> +               while (amdgpu_vm_pt_descendant(adev, cursor));
>  }
>
>  /**
> -- 
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------92F8838C55850B1200693B7D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, that came to my mind as well.<br>
      <br>
      But this is the only case where we would use the return value and
      not use cursor-&gt;pfn as criteria to abort.<br>
      <br>
      So to be consistent I rather don't want to do this,<br>
      Christian.<br>
      <br>
      Am 25.10.18 um 17:43 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB2775D822132203F5E206128EFBF70-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:black">How about add a
            return value for the function amdgpu_vm_pt_next?<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:black">And change the
            code as:<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:black">    <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:black">     ret =
            amdgpu_vm_pt_next(adev, cursor);<br>
            -       while (amdgpu_vm_pt_descendant(adev, cursor));<br>
            +       if (!ret)<br>
            +               while (amdgpu_vm_pt_descendant(adev,
            cursor));</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Best Regards<o:p></o:p></p>
        <p class="MsoNormal">Rex<o:p></o:p></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                <b>On Behalf Of </b>Zhu, Rex<br>
                <b>Sent:</b> Thursday, October 25, 2018 11:34 PM<br>
                <b>To:</b> Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> RE: [PATCH] drm/amdgpu: fix VM leaf
                walking<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Patch is Tested-by:  Rex Zhu <a
              href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">
              Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a><o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Regards<o:p></o:p></p>
          <p class="MsoNormal">Rex<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> amd-gfx &lt;<a
                    href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                  <b>On Behalf Of </b>Deucher, Alexander<br>
                  <b>Sent:</b> Thursday, October 25, 2018 11:08 PM<br>
                  <b>To:</b> Christian König &lt;<a
                    href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                    moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;;
                  <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix VM leaf
                  walking<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p> </o:p></p>
            <div id="divtagdefaultwrapper">
              <p><span style="font-size:12.0pt;color:black">Acked-by:
                  Alex Deucher &lt;<a
                    href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
              <div>
                <div class="MsoNormal" style="text-align:center"
                  align="center"><span
                    style="font-size:12.0pt;color:black">
                    <hr width="98%" size="3" align="center">
                  </span></div>
                <div id="divRplyFwdMsg">
                  <p class="MsoNormal"><b><span style="color:black">From:</span></b><span
                      style="color:black"> amd-gfx &lt;<a
                        href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                      on behalf of Christian König &lt;<a
                        href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                        moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                      <b>Sent:</b> Thursday, October 25, 2018 10:38 AM<br>
                      <b>To:</b> <a
                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>Subject:</b> [PATCH] drm/amdgpu: fix VM leaf
                      walking</span><span
                      style="font-size:12.0pt;color:black">
                      <o:p></o:p></span></p>
                  <div>
                    <p class="MsoNormal"><span
                        style="font-size:12.0pt;color:black"> <o:p></o:p></span></p>
                  </div>
                </div>
                <div>
                  <div>
                    <p class="MsoNormal"><span style="color:black">Make
                        sure we don't try to go down further after the
                        leave walk already<br>
                        ended. This fixes a crash with a new VM test.<br>
                        <br>
                        Signed-off-by: Christian König &lt;<a
                          href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                        ---<br>
                         drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-<br>
                         1 file changed, 2 insertions(+), 1 deletion(-)<br>
                        <br>
                        diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                        index db0cbf8d219d..352b30409060 100644<br>
                        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                        @@ -542,7 +542,8 @@ static void
                        amdgpu_vm_pt_next_leaf(struct amdgpu_device
                        *adev,<br>
                                                            struct
                        amdgpu_vm_pt_cursor *cursor)<br>
                         {<br>
                                 amdgpu_vm_pt_next(adev, cursor);<br>
                        -       while (amdgpu_vm_pt_descendant(adev,
                        cursor));<br>
                        +       if (cursor-&gt;pfn != ~0ll)<br>
                        +               while
                        (amdgpu_vm_pt_descendant(adev, cursor));<br>
                         }<br>
                         <br>
                         /**<br>
                        -- <br>
                        2.17.1<br>
                        <br>
                        _______________________________________________<br>
                        amd-gfx mailing list<br>
                        <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                        <a
                          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                          moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------92F8838C55850B1200693B7D--

--===============1045644249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1045644249==--
