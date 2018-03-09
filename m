From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
Date: Fri, 9 Mar 2018 12:02:41 -0500
Message-ID: <CADnq5_PK5K5OYG4HVxKa1wCk-MxtJNaxH83HF9F7RzxkaXai_g@mail.gmail.com>
References: <20180308205409.3203-1-alexander.deucher@amd.com>
 <20180308205409.3203-2-alexander.deucher@amd.com>
 <CY4PR12MB1687F2F0D4288F02D750C755FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <b6999bc4-1fae-c293-42f4-2929b08d1821@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0669354991=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b6999bc4-1fae-c293-42f4-2929b08d1821-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0669354991==
Content-Type: multipart/alternative; boundary="089e082f73cca40b4b0566fdc2c3"

--089e082f73cca40b4b0566fdc2c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 9, 2018 at 2:45 AM, Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi Rex,
>
> I think still initializing the PSP even when you don't need it for
> firmware upload sounds like a good idea to me.
>
> But take that with a grain of salt since I really on don't know that part
> of the hardware so well.
>

Right.  We need PSP for GPU resets among other things.  I also don't really
like the fact that we use the module parameter directly to determine
whether to load the PSP module or not, we should be using
adev->firmware.load_type, but that doesn't get set until later.  We should
probably just move that earlier in the common code rather than having it in
the soc files.  The problem with checking the module parameter is that that
param is gobal so if you you have multiple GPUs, you may get messed up.

Alex



>
> Christian.
>
>
> Am 09.03.2018 um 06:10 schrieb Zhu, Rex:
>
> Hi Alex,
>
>
> How about keep the firmware type checking in set_ip_blocks.
>
> and remove the same check code in psp module.
>
> also no need to change load type if psp load firmware failed in psp modul=
e.
>
>
> Please review the attached patch.
>
>
> Best Regards
>
> Rex
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deucher
> <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, March 9, 2018 4:54 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander
> *Subject:* [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
>
> We already handle the firmware loading type checks in the
> psp module directly, no need for an additional check.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8dc8b72ed49b..ecf58a68cf66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>                  amdgpu_device_ip_block_add(adev,
> &vega10_common_ip_block);
>                  amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
>                  amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> -               if (amdgpu_fw_load_type =3D=3D 2 || amdgpu_fw_load_type =
=3D=3D -1)
> -                       amdgpu_device_ip_block_add(adev,
> &psp_v3_1_ip_block);
> +               amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>                  if (!amdgpu_sriov_vf(adev))
>                          amdgpu_device_ip_block_add(adev,
> &amdgpu_pp_ip_block);
>                  if (adev->enable_virtual_display || amdgpu_sriov_vf(adev=
))
> --
> 2.13.6
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following
> form. Use of all freedesktop.org lists is subject to our Code of ...
>
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--089e082f73cca40b4b0566fdc2c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Mar 9, 2018 at 2:45 AM, Christian K=C3=B6nig <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"gmail-m_-4726930752337344039moz-cite-prefix">Hi Rex,<br>
      <br>
      I think still initializing the PSP even when you don&#39;t need it fo=
r
      firmware upload sounds like a good idea to me.<br>
      <br>
      But take that with a grain of salt since I really on don&#39;t know
      that part of the hardware so well.<span class=3D"gmail-HOEnZb"><font =
color=3D"#888888"><br></font></span></div></div></blockquote><div><br></div=
><div>Right.=C2=A0 We need PSP for GPU resets among other things.=C2=A0 I a=
lso don&#39;t really like the fact that we use the module parameter directl=
y to determine whether to load the PSP module or not, we should be using ad=
ev-&gt;firmware.load_type, but that doesn&#39;t get set until later.=C2=A0 =
We should probably just move that earlier in the common code rather than ha=
ving it in the soc files.=C2=A0 The problem with checking the module parame=
ter is that that param is gobal so if you you have multiple GPUs, you may g=
et messed up.<br><br></div><div>Alex<br></div><div><br>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF"><div cla=
ss=3D"gmail-m_-4726930752337344039moz-cite-prefix"><span class=3D"gmail-HOE=
nZb"><font color=3D"#888888">
      <br>
      Christian.</font></span><div><div class=3D"gmail-h5"><br>
      <br>
      Am 09.03.2018 um 06:10 schrieb Zhu, Rex:<br>
    </div></div></div><div><div class=3D"gmail-h5">
    <blockquote type=3D"cite">
     =20
     =20
      <div id=3D"gmail-m_-4726930752337344039divtagdefaultwrapper" style=3D=
"font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif" =
dir=3D"ltr">
        <p style=3D"margin-top:0px;margin-bottom:0px">Hi Alex,</p>
        <p style=3D"margin-top:0px;margin-bottom:0px"><br>
        </p>
        <p style=3D"margin-top:0px;margin-bottom:0px">How about keep the
          firmware type checking in
          <font size=3D"2"><span style=3D"font-size:11pt">set_ip_blocks</sp=
an></font>.</p>
        <p style=3D"margin-top:0px;margin-bottom:0px">and remove the same
          check code in psp module.</p>
        <p style=3D"margin-top:0px;margin-bottom:0px">also no need to chang=
e
          load type if psp load firmware failed in psp module.</p>
        <p style=3D"margin-top:0px;margin-bottom:0px"><br>
        </p>
        <p style=3D"margin-top:0px;margin-bottom:0px">Please review the
          attached patch.</p>
        <p style=3D"margin-top:0px;margin-bottom:0px"><br>
        </p>
        <p style=3D"margin-top:0px;margin-bottom:0px">Best Regards</p>
        <p style=3D"margin-top:0px;margin-bottom:0px">Rex<br>
        </p>
        <div style=3D"color:rgb(0,0,0)">
          <hr style=3D"display:inline-block;width:98%">
          <div id=3D"gmail-m_-4726930752337344039divRplyFwdMsg" dir=3D"ltr"=
><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#0000=
00"><b>From:</b>
              amd-gfx <a class=3D"gmail-m_-4726930752337344039moz-txt-link-=
rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_=
blank">&lt;amd-gfx-bounces@lists.<wbr>freedesktop.org&gt;</a> on
              behalf of Alex Deucher <a class=3D"gmail-m_-47269307523373440=
39moz-txt-link-rfc2396E" href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, March 9, 2018 4:54 AM<br>
              <b>To:</b> <a class=3D"gmail-m_-4726930752337344039moz-txt-li=
nk-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_bl=
ank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Deucher, Alexander<br>
              <b>Subject:</b> [PATCH 2/2] drm/amdgpu/soc15: always load
              the psp IP module</font>
            <div>=C2=A0</div>
          </div>
          <div class=3D"gmail-m_-4726930752337344039BodyFragment"><font siz=
e=3D"2"><span style=3D"font-size:11pt">
                <div class=3D"gmail-m_-4726930752337344039PlainText">We alr=
eady handle the firmware
                  loading type checks in the<br>
                  psp module directly, no need for an additional check.<br>
                  <br>
                  Signed-off-by: Alex Deucher
                  <a class=3D"gmail-m_-4726930752337344039moz-txt-link-rfc2=
396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">&lt;alexa=
nder.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                  =C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c | 3 +--<br>
                  =C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c
                  b/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
                  index 8dc8b72ed49b..ecf58a68cf66 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
                  @@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct
                  amdgpu_device *adev)<br>
                  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_ip_block_add(<wbr>ade=
v,
                  &amp;vega10_common_ip_block);<br>
                  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_ip_block_add(<wbr>ade=
v,
                  &amp;gmc_v9_0_ip_block);<br>
                  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_ip_block_add(<wbr>ade=
v,
                  &amp;vega10_ih_ip_block);<br>
                  -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_fw_load_type =3D=3D 2 ||
                  amdgpu_fw_load_type =3D=3D -1)<br>
                  -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
                  amdgpu_device_ip_block_add(<wbr>adev,
                  &amp;psp_v3_1_ip_block);<br>
                  +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_ip_block_add(<wbr>adev,
                  &amp;psp_v3_1_ip_block);<br>
                  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!amdgpu_sriov_vf(adev))<br>
                  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
                  amdgpu_device_ip_block_add(<wbr>adev,
                  &amp;amdgpu_pp_ip_block);<br>
                  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev-&gt;enable_virtual_display
                  || amdgpu_sriov_vf(adev))<br>
                  -- <br>
                  2.13.6<br>
                  <br>
                  ______________________________<wbr>_________________<br>
                  amd-gfx mailing list<br>
                  <a class=3D"gmail-m_-4726930752337344039moz-txt-link-abbr=
eviated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a id=3D"gmail-m_-4726930752337344039LPlnk123469" href=3D=
"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">=
https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
                  <div style=3D"margin-bottom:20px;overflow:auto;width:100%=
;text-indent:0px" id=3D"gmail-m_-4726930752337344039LPBorder_GT_15205709349=
260.10638474698232214">
                    <table style=3D"width:90%;background-color:rgb(255,255,=
255);overflow:auto;padding-top:20px;padding-bottom:20px;margin-top:20px;bor=
der-top:1px dotted rgb(200,200,200);border-bottom:1px dotted rgb(200,200,20=
0)" id=3D"gmail-m_-4726930752337344039LPContainer_15205709349240.2808290117=
558123" cellspacing=3D"0">
                      <tbody>
                        <tr style=3D"border-spacing:0px" valign=3D"top">
                          <td colspan=3D"2" style=3D"vertical-align:top;pad=
ding:0px;display:table-cell" id=3D"gmail-m_-4726930752337344039TextCell_152=
05709349240.5375816182761378">
                            <div id=3D"gmail-m_-4726930752337344039LPTitle_=
15205709349250.744041292827629">
                              <a href=3D"https://lists.freedesktop.org/mail=
man/listinfo/amd-gfx" style=3D"text-decoration:none" id=3D"gmail-m_-4726930=
752337344039LPUrlAnchor_15205709349250.5260705269625694" target=3D"_blank">=
amd-gfx Info Page
                                - freedesktop.org</a></div>
                            <div id=3D"gmail-m_-4726930752337344039LPMetada=
ta_15205709349250.4352603789039715">
                              <a href=3D"http://lists.freedesktop.org" targ=
et=3D"_blank">lists.freedesktop.org</a></div>
                            <div id=3D"gmail-m_-4726930752337344039LPDescri=
ption_15205709349260.4456905619796764">
                              Subscribing to amd-gfx: Subscribe to
                              amd-gfx by filling out the following form.
                              Use of all <a href=3D"http://freedesktop.org"=
 target=3D"_blank">freedesktop.org</a> lists is
                              subject to our Code of ...</div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
      <br>
      <fieldset class=3D"gmail-m_-4726930752337344039mimeAttachmentHeader">=
</fieldset>
      <br>
      <pre>______________________________<wbr>_________________
amd-gfx mailing list
<a class=3D"gmail-m_-4726930752337344039moz-txt-link-abbreviated" href=3D"m=
ailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org</a>
<a class=3D"gmail-m_-4726930752337344039moz-txt-link-freetext" href=3D"http=
s://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">https=
://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </div></div></div>

</blockquote></div><br></div></div>

--089e082f73cca40b4b0566fdc2c3--

--===============0669354991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0669354991==--
