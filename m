From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: wait to fetch the vbios until after common
 init
Date: Mon, 17 Jun 2019 19:44:44 +0200
Message-ID: <0c9fa7da-92c1-953a-0ca9-5054ac2ebc92@gmail.com>
References: <20190617144500.29491-1-alexander.deucher@amd.com>
 <BN6PR12MB161858B2EF2FDE6983B8AF8085EB0@BN6PR12MB1618.namprd12.prod.outlook.com>
 <BN6PR12MB1809772C53A7C9BB535D0012F7EB0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1618690F5B4843CD5E0CC31085EB0@BN6PR12MB1618.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0829768532=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1618690F5B4843CD5E0CC31085EB0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0829768532==
Content-Type: multipart/alternative;
 boundary="------------C2F865CC793A51507E42F081"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C2F865CC793A51507E42F081
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

A quick guide to the different tags:

Signed-off-by: I'm somehow responsible that the code is in the mainline 
tree. E.g. either the Author of a patch or some maintainer who forwarded 
the stuff to Linus.
Tested-by: I tested the code and found it working good.
Reviewed-by: I'm familiar with both the code and the hardware and judged 
that this looks like it should work as intended.
Acked-by: It looks good to me in general, but I'm not familiar with 
either the code or the hardware to judge if that is correct or not. 
Usually used to note general agreement to a design or piece of code 
without looking to deeply into it.

NAK means a fundamental disagreement on how a piece of code implements 
something and what a reviewer things is the right thing to do. It is 
something which needs to sorted out before some code can be committed.

A NAK does NOT mean general rejection, but rather that you need to 
retreat and start discussion things on a higher level.

Christian.

Am 17.06.19 um 17:26 schrieb Russell, Kent:
>
> Thanks, I need to get familiar with all of the tags 😊
>
> Kent
>
> *From:* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Monday, June 17, 2019 11:24 AM
> *To:* Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; Alex Deucher 
> <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amdgpu: wait to fetch the vbios until after 
> common init
>
> I'll make that a tested-by.  Thanks!
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Russell, Kent
> *Sent:* Monday, June 17, 2019 11:14 AM
> *To:* Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* Deucher, Alexander
> *Subject:* RE: [PATCH] drm/amdgpu: wait to fetch the vbios until after 
> common init
>
> This also worked. I don't think that I'm qualified enough to RB it, 
> but you can add my
>
> Verified-By: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org 
> <mailto:kent.russell-5C7GfCeVMHo@public.gmane.org>>
>
>  Kent
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On Behalf Of Alex Deucher
> Sent: Monday, June 17, 2019 10:45 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org 
> <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
> Subject: [PATCH] drm/amdgpu: wait to fetch the vbios until after 
> common init
>
> We need the asic_funcs set for the get rom callbacks in some cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org 
> <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4a836db1000f..e26303bc567e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1534,17 +1534,6 @@ static int amdgpu_device_ip_early_init(struct 
> amdgpu_device *adev)
>          if (amdgpu_sriov_vf(adev))
>                  adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>
> -       /* Read BIOS */
> -       if (!amdgpu_get_bios(adev))
> -               return -EINVAL;
> -
> -       r = amdgpu_atombios_init(adev);
> -       if (r) {
> -               dev_err(adev->dev, "amdgpu_atombios_init failed\n");
> -               amdgpu_vf_error_put(adev, 
> AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
> -               return r;
> -       }
> -
>          for (i = 0; i < adev->num_ip_blocks; i++) {
>                  if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
>                          DRM_ERROR("disabled ip block: %d <%s>\n", @@ 
> -1566,6 +1555,19 @@ static int amdgpu_device_ip_early_init(struct 
> amdgpu_device *adev)
> adev->ip_blocks[i].status.valid = true;
>                          }
>                  }
> +               /* get the vbios after the asic_funcs are set up */
> +               if (adev->ip_blocks[i].version->type == 
> AMD_IP_BLOCK_TYPE_COMMON) {
> +                       /* Read BIOS */
> +                       if (!amdgpu_get_bios(adev))
> +                               return -EINVAL;
> +
> +                       r = amdgpu_atombios_init(adev);
> +                       if (r) {
> +                               dev_err(adev->dev, 
> "amdgpu_atombios_init failed\n");
> +                               amdgpu_vf_error_put(adev, 
> AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
> +                               return r;
> +                       }
> +               }
>          }
>
>          adev->cg_flags &= amdgpu_cg_mask;
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------C2F865CC793A51507E42F081
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">A quick guide to the different tags:<br>
      <br>
      Signed-off-by: I'm somehow responsible that the code is in the
      mainline tree. E.g. either the Author of a patch or some
      maintainer who forwarded the stuff to Linus.<br>
      Tested-by: I tested the code and found it working good.<br>
      Reviewed-by: I'm familiar with both the code and the hardware and
      judged that this looks like it should work as intended.<br>
      Acked-by: It looks good to me in general, but I'm not familiar
      with either the code or the hardware to judge if that is correct
      or not. Usually used to note general agreement to a design or
      piece of code without looking to deeply into it.<br>
      <br>
      NAK means a fundamental disagreement on how a piece of code
      implements something and what a reviewer things is the right thing
      to do. It is something which needs to sorted out before some code
      can be committed.<br>
      <br>
      A NAK does NOT mean general rejection, but rather that you need to
      retreat and start discussion things on a higher level.<br>
      <br>
      Christian.<br>
      <br>
      Am 17.06.19 um 17:26 schrieb Russell, Kent:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1618690F5B4843CD5E0CC31085EB0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
        <p class="MsoNormal">Thanks, I need to get familiar with all of
          the tags <span style="font-family:&quot;Segoe UI
            Emoji&quot;,sans-serif">
            😊</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Kent<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a> <br>
              <b>Sent:</b> Monday, June 17, 2019 11:24 AM<br>
              <b>To:</b> Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">&lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: wait to fetch the
              vbios until after common init<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;color:black">I'll make that a
              tested-by.  Thanks!<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
        </div>
        <div class="MsoNormal" style="text-align:center" align="center">
          <hr width="98%" size="2" align="center">
        </div>
        <div id="divRplyFwdMsg">
          <p class="MsoNormal"><b><span style="color:black">From:</span></b><span
              style="color:black"> Russell, Kent<br>
              <b>Sent:</b> Monday, June 17, 2019 11:14 AM<br>
              <b>To:</b> Alex Deucher; <a
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Deucher, Alexander<br>
              <b>Subject:</b> RE: [PATCH] drm/amdgpu: wait to fetch the
              vbios until after common init</span>
            <o:p></o:p></p>
          <div>
            <p class="MsoNormal"> <o:p></o:p></p>
          </div>
        </div>
        <div>
          <div>
            <p class="MsoNormal">This also worked. I don't think that
              I'm qualified enough to RB it, but you can add my<br>
              <br>
              Verified-By: Kent Russell &lt;<a
                href="mailto:kent.russell-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">kent.russell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              <br>
               Kent<br>
              <br>
              -----Original Message-----<br>
              From: amd-gfx &lt;<a
                href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
              On Behalf Of Alex Deucher<br>
              Sent: Monday, June 17, 2019 10:45 AM<br>
              To: <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Cc: Deucher, Alexander &lt;<a
                href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              Subject: [PATCH] drm/amdgpu: wait to fetch the vbios until
              after common init<br>
              <br>
              We need the asic_funcs set for the get rom callbacks in
              some cases.<br>
              <br>
              Signed-off-by: Alex Deucher &lt;<a
                href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24
              ++++++++++++----------<br>
               1 file changed, 13 insertions(+), 11 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              index 4a836db1000f..e26303bc567e 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              @@ -1534,17 +1534,6 @@ static int
              amdgpu_device_ip_early_init(struct amdgpu_device *adev)<br>
                       if (amdgpu_sriov_vf(adev))<br>
                               adev-&gt;pm.pp_feature &amp;=
              ~PP_GFXOFF_MASK;<br>
               <br>
              -       /* Read BIOS */<br>
              -       if (!amdgpu_get_bios(adev))<br>
              -               return -EINVAL;<br>
              -<br>
              -       r = amdgpu_atombios_init(adev);<br>
              -       if (r) {<br>
              -               dev_err(adev-&gt;dev,
              "amdgpu_atombios_init failed\n");<br>
              -               amdgpu_vf_error_put(adev,
              AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);<br>
              -               return r;<br>
              -       }<br>
              -<br>
                       for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++) {<br>
                               if ((amdgpu_ip_block_mask &amp; (1
              &lt;&lt; i)) == 0) {<br>
                                       DRM_ERROR("disabled ip block: %d
              &lt;%s&gt;\n", @@ -1566,6 +1555,19 @@ static int
              amdgpu_device_ip_early_init(struct amdgpu_device *adev)<br>
                                              
              adev-&gt;ip_blocks[i].status.valid = true;<br>
                                       }<br>
                               }<br>
              +               /* get the vbios after the asic_funcs are
              set up */<br>
              +               if (adev-&gt;ip_blocks[i].version-&gt;type
              == AMD_IP_BLOCK_TYPE_COMMON) {<br>
              +                       /* Read BIOS */<br>
              +                       if (!amdgpu_get_bios(adev))<br>
              +                               return -EINVAL;<br>
              +<br>
              +                       r = amdgpu_atombios_init(adev);<br>
              +                       if (r) {<br>
              +                               dev_err(adev-&gt;dev,
              "amdgpu_atombios_init failed\n");<br>
              +                               amdgpu_vf_error_put(adev,
              AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);<br>
              +                               return r;<br>
              +                       }<br>
              +               }<br>
                       }<br>
               <br>
                       adev-&gt;cg_flags &amp;= amdgpu_cg_mask;<br>
              --<br>
              2.20.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C2F865CC793A51507E42F081--

--===============0829768532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0829768532==--
