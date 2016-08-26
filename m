From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay:  Fix CZ SMU firmware load check
Date: Fri, 26 Aug 2016 14:55:30 +0000
Message-ID: <DM5PR12MB1132700B4E4DE0FC24A1A03DF7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160826143435.20415-1-tom.stdenis@amd.com>,
 <MWHPR12MB1694DD544FAF6B5246CC3717F7EC0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0889011786=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694DD544FAF6B5246CC3717F7EC0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0889011786==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132700B4E4DE0FC24A1A03DF7EC0DM5PR12MB1132namp_"

--_000_DM5PR12MB1132700B4E4DE0FC24A1A03DF7EC0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks.  I sent out a v2 where it adds a check to the load call as well.


Tom


________________________________
From: Deucher, Alexander
Sent: Friday, August 26, 2016 10:42
To: 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: RE: [PATCH] drm/amd/powerplay: Fix CZ SMU firmware load check



> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Tom St Denis
> Sent: Friday, August 26, 2016 10:35 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: StDenis, Tom
> Subject: [PATCH] drm/amd/powerplay: Fix CZ SMU firmware load check
>
> Remove an errant return in the middle of the check
> function as well as check for success in the start
> function.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
> index 87c023e518ab..654ffcf73769 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
> @@ -195,9 +195,6 @@ static int cz_check_fw_load_finish(struct pp_smumgr
> *smumgr,
>        if (smumgr =3D=3D NULL || smumgr->device =3D=3D NULL)
>                return -EINVAL;
>
> -     return cgs_read_register(smumgr->device,
> -                                     mmSMU_MP1_SRBM2P_ARG_0);
> -
>        cgs_write_register(smumgr->device, mmMP0PUB_IND_INDEX,
> index);
>
>        for (i =3D 0; i < smumgr->usec_timeout; i++) {
> @@ -276,7 +273,9 @@ static int cz_start_smu(struct pp_smumgr *smumgr)
>                fw_to_check &=3D ~(UCODE_ID_SDMA1_MASK |
> UCODE_ID_CP_MEC_JT2_MASK);
>
>        cz_request_smu_load_fw(smumgr);
> -     cz_check_fw_load_finish(smumgr, fw_to_check);
> +     ret =3D cz_check_fw_load_finish(smumgr, fw_to_check);
> +     if (ret)
> +             printk(KERN_ERR "[ powerplay] SMU firmware load
> failed\n");
>
>        ret =3D cz_load_mec_firmware(smumgr);
>        if (ret)
> --
> 2.9.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1132700B4E4DE0FC24A1A03DF7EC0DM5PR12MB1132namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Thanks. &nbsp;I sent out a v2 where it adds a check to the load call as =
well.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Friday, August 26, 2016 10:42<br>
<b>To:</b> 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: Fix CZ SMU firmware load che=
ck</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Tom St Denis<br>
&gt; Sent: Friday, August 26, 2016 10:35 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: StDenis, Tom<br>
&gt; Subject: [PATCH] drm/amd/powerplay: Fix CZ SMU firmware load check<br>
&gt; <br>
&gt; Remove an errant return in the middle of the check<br>
&gt; function as well as check for success in the start<br>
&gt; function.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c | 7 &#43;&#43;&=
#43;----<br>
&gt;&nbsp; 1 file changed, 3 insertions(&#43;), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
&gt; index 87c023e518ab..654ffcf73769 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
&gt; @@ -195,9 &#43;195,6 @@ static int cz_check_fw_load_finish(struct pp_s=
mumgr<br>
&gt; *smumgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr =3D=3D NULL || sm=
umgr-&gt;device =3D=3D NULL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(smumgr-&gt;device,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm=
SMU_MP1_SRBM2P_ARG_0);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(smumgr-&g=
t;device, mmMP0PUB_IND_INDEX,<br>
&gt; index);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; smumgr-=
&gt;usec_timeout; i&#43;&#43;) {<br>
&gt; @@ -276,7 &#43;273,9 @@ static int cz_start_smu(struct pp_smumgr *smum=
gr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_to_check &amp;=3D ~(UCODE_ID_SDMA1_MASK |<br>
&gt; UCODE_ID_CP_MEC_JT2_MASK);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_request_smu_load_fw(smumg=
r);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; cz_check_fw_load_finish(smumgr, fw_to_check)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_check_fw_load_finish(smumgr, =
fw_to_check);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; printk(KERN_ERR &quot;[ powerplay] SMU firmware load<br>
&gt; failed\n&quot;);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_load_mec_firmware=
(smumgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; --<br>
&gt; 2.9.2<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1132700B4E4DE0FC24A1A03DF7EC0DM5PR12MB1132namp_--

--===============0889011786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0889011786==--
