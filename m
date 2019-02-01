From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add override pcie parameters for
 Vega20 (v2)
Date: Fri, 1 Feb 2019 22:43:54 +0000
Message-ID: <BYAPR12MB338407B3190B9A7E85DF3DE08C920@BYAPR12MB3384.namprd12.prod.outlook.com>
References: <1549055816-12976-1-git-send-email-Harish.Kasiviswanathan@amd.com>
 <1549055816-12976-2-git-send-email-Harish.Kasiviswanathan@amd.com>
 <CADnq5_O5BcdjYyAx8_aj1PncKNbhVJwZF67sUyFKOrS9x_xLwg@mail.gmail.com>
 <BYAPR12MB338437F11284DF95CE3ACF9A8C920@BYAPR12MB3384.namprd12.prod.outlook.com>,
 <CADnq5_PNDssVY0x5X4=ROhmh5naOd83dSTeKe++yNJU=b6+u7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0845498422=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PNDssVY0x5X4=ROhmh5naOd83dSTeKe++yNJU=b6+u7Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Li, Colin" <Colin.Li-5C7GfCeVMHo@public.gmane.org>, "Xi,
 Sheldon" <Sheldon.Xi-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0845498422==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB338407B3190B9A7E85DF3DE08C920BYAPR12MB3384namp_"

--_000_BYAPR12MB338407B3190B9A7E85DF3DE08C920BYAPR12MB3384namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Let me explain the problem. I also adding Colin & Sheldon from the SMU team=
.


Currently, PPTable entries (inside VBIOS) reflects ASIC capabilities and no=
t the system capabilities. So if we put Gen4 capable Vega20 in a system tha=
t supports only Gen3, the PPTable has Gen4 for DPM 1 (higher DPM state). La=
ter on when SMU wants to switch to DPM1 it fails since Gen4 is not supporte=
d. SMU however, doesn't fall back to Gen3 but instead to Gen0. This is caus=
ing a performance issue.


As I understand, this override is required only for the higher DPM state.

Best Regards,
Harish

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, February 1, 2019 5:34 PM
To: Kasiviswanathan, Harish
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerplay: add override pcie parameters for Ve=
ga20 (v2)

Do we actually need the current status?  We have the caps of the platform a=
nd the device.  For the lowest dpm state, we generally want the lowest comm=
on gen and then the highest common gen for the highest dpm state.  If we us=
e the current status, we will mostly likely end up with the highest gen in =
the lowest dpm state because generally the highest gen is negotiated at pow=
er up.

Alex

On Fri, Feb 1, 2019 at 5:28 PM Kasiviswanathan, Harish <Harish.Kasiviswanat=
han-5C7GfCeVMHo@public.gmane.org<mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>> wrote:

Thanks Alex. I saw that function. It gets caps. The function requires link =
status (PCI_EXP_LNKSTA), the value negotiated.


> I'd rather not access pci config space from the powerplay code because it=
 doesn't work under virtualization.

[HK] I will then modify amdgpu_device_get_pcie_info() to read "PCI_EXP_LINK=
STA" and store that information for future use.

Best Regards,
Harish


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, February 1, 2019 5:09 PM
To: Kasiviswanathan, Harish
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add override pcie parameters for Ve=
ga20 (v2)

On Fri, Feb 1, 2019 at 4:17 PM Kasiviswanathan, Harish
<Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org<mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>> wro=
te:
>
> v2: Use PCIe link status instead of link capability
>     Send override message after SMU enable features
>
> Change-Id: Iea2a1ac595cf63a9528ff1e9a6955d14d8c3a6d5
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org<mai=
lto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 93 +++++++++++++++-=
------
>  1 file changed, 64 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> index da022ca..d166f8c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> @@ -771,40 +771,75 @@ static int vega20_init_smc_table(struct pp_hwmgr *h=
wmgr)
>         return 0;
>  }
>
> +/*
> + * Override PCIe link speed and link width for DPM Level 1. PPTable entr=
ies
> + * reflect the ASIC capabilities and not the system capabilities. For e.=
g.
> + * Vega20 board in a PCI Gen3 system. In this case, when SMU's tries to =
switch
> + * to DPM1, it fails as system doesn't support Gen4.
> + */
>  static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->ad=
ev);
> -       uint32_t pcie_speed =3D 0, pcie_width =3D 0, pcie_arg;
> +       uint32_t pcie_gen =3D 0, pcie_width =3D 0, smu_pcie_arg;
>         int ret;
> +       uint16_t lnkstat;
> +
> +       pcie_capability_read_word(adev->pdev, PCI_EXP_LNKSTA, &lnkstat);
>
> -       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
> -               pcie_speed =3D 16;
> -       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GE=
N3)
> -               pcie_speed =3D 8;
> -       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GE=
N2)
> -               pcie_speed =3D 5;
> -       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GE=
N1)
> -               pcie_speed =3D 2;
> -
> -       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32)
> -               pcie_width =3D 32;
> -       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1=
6)
> -               pcie_width =3D 16;
> -       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1=
2)
> -               pcie_width =3D 12;
> -       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8=
)
> -               pcie_width =3D 8;
> -       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4=
)
> +       switch (lnkstat & PCI_EXP_LNKSTA_CLS) {
> +       case PCI_EXP_LNKSTA_CLS_2_5GB:
> +               pcie_gen =3D 0;
> +               break;
> +       case PCI_EXP_LNKSTA_CLS_5_0GB:
> +               pcie_gen =3D 1;
> +               break;
> +       case PCI_EXP_LNKSTA_CLS_8_0GB:
> +               pcie_gen =3D 2;
> +               break;
> +       case PCI_EXP_LNKSTA_CLS_16_0GB:
> +               pcie_gen =3D 3;
> +               break;
> +       default:
> +               pr_warn("Unknown PCI link speed %x\n",
> +                       lnkstat & PCI_EXP_LNKSTA_CLS);
> +       }
> +
> +
> +       switch ((lnkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIF=
T) {
> +       case 32:
> +               pcie_width =3D 7;
> +               break;
> +       case 16:
> +               pcie_width =3D 6;
> +               break;
> +       case 12:
> +               pcie_width =3D 5;
> +               break;
> +       case 8:
>                 pcie_width =3D 4;
> -       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2=
)
> +               break;
> +       case 4:
> +               pcie_width =3D 3;
> +               break;
> +       case 2:
>                 pcie_width =3D 2;
> -       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1=
)
> +               break;
> +       case 1:
>                 pcie_width =3D 1;
> +               break;
> +       default:
> +               pr_warn("Unknown PCI link width %x\n",
> +                       lnkstat & PCI_EXP_LNKSTA_CLS);
> +       }
>

We already get the link caps for both the device and the platform in
amdgpu_device_get_pcie_info().  Is that info not adequate?  I'd rather
not access pci config space from the powerplay code because it doesn't
work under virtualization.

Alex

> -       pcie_arg =3D pcie_width | (pcie_speed << 8);
> -
> +       /* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
> +        * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
> +        * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
> +        */
> +       smu_pcie_arg =3D (1 << 16) | (pcie_gen << 8) | pcie_width;
>         ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
> -                       PPSMC_MSG_OverridePcieParameters, pcie_arg);
> +                       PPSMC_MSG_OverridePcieParameters, smu_pcie_arg);
> +
>         PP_ASSERT_WITH_CODE(!ret,
>                 "[OverridePcieParameters] Attempt to override pcie params=
 failed!",
>                 return ret);
> @@ -1611,11 +1646,6 @@ static int vega20_enable_dpm_tasks(struct pp_hwmgr=
 *hwmgr)
>                         "[EnableDPMTasks] Failed to initialize SMC table!=
",
>                         return result);
>
> -       result =3D vega20_override_pcie_parameters(hwmgr);
> -       PP_ASSERT_WITH_CODE(!result,
> -                       "[EnableDPMTasks] Failed to override pcie paramet=
ers!",
> -                       return result);
> -
>         result =3D vega20_run_btc(hwmgr);
>         PP_ASSERT_WITH_CODE(!result,
>                         "[EnableDPMTasks] Failed to run btc!",
> @@ -1631,6 +1661,11 @@ static int vega20_enable_dpm_tasks(struct pp_hwmgr=
 *hwmgr)
>                         "[EnableDPMTasks] Failed to enable all smu featur=
es!",
>                         return result);
>
> +       result =3D vega20_override_pcie_parameters(hwmgr);
> +       PP_ASSERT_WITH_CODE(!result,
> +                       "[EnableDPMTasks] Failed to override pcie paramet=
ers!",
> +                       return result);
> +
>         result =3D vega20_notify_smc_display_change(hwmgr);
>         PP_ASSERT_WITH_CODE(!result,
>                         "[EnableDPMTasks] Failed to notify smc display ch=
ange!",
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org<http://lists.freedesktop.org>
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>. Yo=
u can subscribe to the list, or change your existing subscription, in the s=
ections below.



--_000_BYAPR12MB338407B3190B9A7E85DF3DE08C920BYAPR12MB3384namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Let me explain the problem. I als=
o adding Colin &amp; Sheldon from the SMU team.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Currently, <font size=3D"2"><span=
 style=3D"font-size:11pt;">PPTable entries (inside VBIOS) reflects ASIC cap=
abilities and not the system capabilities.</span></font> So if we put Gen4 =
capable Vega20 in a system that supports
 only Gen3, the PPTable has Gen4 for DPM 1 (higher DPM state). Later on whe=
n SMU wants to switch to DPM1 it fails since Gen4 is not supported. SMU how=
ever, doesn't fall back to Gen3 but instead to Gen0. This is causing a perf=
ormance issue.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">As I understand, this override is=
 required only for the higher DPM state.<br>
</p>
<div><br>
</div>
<div>Best Regards,</div>
<div>Harish</div>
<div><br>
</div>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, February 1, 2019 5:34 PM<br>
<b>To:</b> Kasiviswanathan, Harish<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: add override pcie parameters=
 for Vega20 (v2)</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Do we actually need the current status?&nbsp; We have the caps of the =
platform and the device.&nbsp; For the lowest dpm state, we generally want =
the lowest common gen and then the highest common gen for the highest dpm s=
tate.&nbsp; If we use the current status, we will
 mostly likely end up with the highest gen in the lowest dpm state because =
generally the highest gen is negotiated at power up.</div>
<div><br>
</div>
<div>Alex<br>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Fri, Feb 1, 2019 at 5:28 PM Kasi=
viswanathan, Harish &lt;<a href=3D"mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org" i=
d=3D"LPlnk390754" class=3D"OWAAutoLink" previewremoved=3D"true">Harish.Kasi=
viswanathan-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"x_gmail-m_329555177500593286divtagdefaultwrapper" dir=3D"ltr" st=
yle=3D"font-size:12pt; color:rgb(0,0,0); font-family:Calibri,Helvetica,sans=
-serif">
<p style=3D"margin-top:0px; margin-bottom:0px">Thanks Alex. I saw that func=
tion. It gets caps. The function requires link status (<font size=3D"2"><sp=
an style=3D"font-size:11pt">PCI_EXP_LNKSTA</span></font>), the value negoti=
ated.
<br>
</p>
<p style=3D"margin-top:0px; margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px; margin-bottom:0px"><font size=3D"2"><span style=
=3D"font-size:11pt">&gt; I'd rather not access pci config space from the po=
werplay code because it doesn't work under virtualization.</span></font><br=
>
</p>
<div>[HK] I will then modify <font size=3D"2"><span style=3D"font-size:11pt=
">amdgpu_device_get_pcie_info()</span></font> to read &quot;PCI_EXP_LINKSTA=
&quot; and store that information for future use.</div>
<div><br>
</div>
<div>Best Regards,</div>
<div>Harish</div>
<div><br>
</div>
<div><br>
</div>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_gmail-m_329555177500593286divRplyFwdMsg" dir=3D"ltr"><font sty=
le=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>Fro=
m:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank" id=3D"LPlnk97574" class=3D"OWAAutoLink" previewremoved=3D"true">ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, February 1, 2019 5:09 PM<br>
<b>To:</b> Kasiviswanathan, Harish<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k" id=3D"LPlnk857262" class=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: add override pcie parameters=
 for Vega20 (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_gmail-m_329555177500593286BodyFragment"><font size=3D"2"><s=
pan style=3D"font-size:11pt">
<div class=3D"x_gmail-m_329555177500593286PlainText">On Fri, Feb 1, 2019 at=
 4:17 PM Kasiviswanathan, Harish<br>
&lt;<a href=3D"mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" id=
=3D"LPlnk596173" class=3D"OWAAutoLink" previewremoved=3D"true">Harish.Kasiv=
iswanathan-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; v2: Use PCIe link status instead of link capability<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Send override message after SMU enable feature=
s<br>
&gt;<br>
&gt; Change-Id: Iea2a1ac595cf63a9528ff1e9a6955d14d8c3a6d5<br>
&gt; Signed-off-by: Harish Kasiviswanathan &lt;<a href=3D"mailto:Harish.Kas=
iviswanathan-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" id=3D"LPlnk870253" class=3D"OWAAuto=
Link" previewremoved=3D"true">Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 93 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<=
br>
&gt;&nbsp; 1 file changed, 64 insertions(&#43;), 29 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index da022ca..d166f8c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; @@ -771,40 &#43;771,75 @@ static int vega20_init_smc_table(struct pp_h=
wmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;/*<br>
&gt; &#43; * Override PCIe link speed and link width for DPM Level 1. PPTab=
le entries<br>
&gt; &#43; * reflect the ASIC capabilities and not the system capabilities.=
 For e.g.<br>
&gt; &#43; * Vega20 board in a PCI Gen3 system. In this case, when SMU's tr=
ies to switch<br>
&gt; &#43; * to DPM1, it fails as system doesn't support Gen4.<br>
&gt; &#43; */<br>
&gt;&nbsp; static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmg=
r)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D (struct amdgpu_device *)(hwmgr-&gt;adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_speed =3D 0, pcie_=
width =3D 0, pcie_arg;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_gen =3D 0, pci=
e_width =3D 0, smu_pcie_arg;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t lnkstat;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capability_read_word(ad=
ev-&gt;pdev, PCI_EXP_LNKSTA, &amp;lnkstat);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_gen_mask &a=
mp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_speed =3D 16;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_ma=
sk &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_speed =3D 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_ma=
sk &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_speed =3D 5;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_ma=
sk &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_speed =3D 2;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X32)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_width =3D 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_width =3D 16;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_width =3D 12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_width =3D 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (lnkstat &amp; PCI_EX=
P_LNKSTA_CLS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PCI_EXP_LNKSTA_CLS_2_5G=
B:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_gen =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PCI_EXP_LNKSTA_CLS_5_0G=
B:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_gen =3D 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PCI_EXP_LNKSTA_CLS_8_0G=
B:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_gen =3D 2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PCI_EXP_LNKSTA_CLS_16_0=
GB:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_gen =3D 3;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Unknown PCI link speed %x\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lnkstat=
 &amp; PCI_EXP_LNKSTA_CLS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch ((lnkstat &amp; PCI_E=
XP_LNKSTA_NLW) &gt;&gt; PCI_EXP_LNKSTA_NLW_SHIFT) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 32:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_width =3D 7;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 16:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_width =3D 6;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 12:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_width =3D 5;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 8:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pcie_width =3D 4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcie_width =3D 3;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pcie_width =3D 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pcie_width =3D 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Unknown PCI link width %x\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lnkstat=
 &amp; PCI_EXP_LNKSTA_CLS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
<br>
We already get the link caps for both the device and the platform in<br>
amdgpu_device_get_pcie_info().&nbsp; Is that info not adequate?&nbsp; I'd r=
ather<br>
not access pci config space from the powerplay code because it doesn't<br>
work under virtualization.<br>
<br>
Alex<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_arg =3D pcie_width | (pcie_=
speed &lt;&lt; 8);<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit 31:16: LCLK DPM level=
. 0 is DPM0, and 1 is DPM1<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Bit 15:8:&nbsp; PCIE=
 GEN, 0 to 3 corresponds to GEN1 to GEN4<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Bit 7:0:&nbsp;&nbsp;=
 PCIE lane width, 1 to 7 corresponds is x1 to x32<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_pcie_arg =3D (1 &lt;&lt;=
 16) | (pcie_gen &lt;&lt; 8) | pcie_width;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_=
to_smc_with_parameter(hwmgr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_O=
verridePcieParameters, pcie_arg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_M=
SG_OverridePcieParameters, smu_pcie_arg);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!r=
et,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[OverridePcieParameters] Attempt to overrid=
e pcie params failed!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; @@ -1611,11 &#43;1646,6 @@ static int vega20_enable_dpm_tasks(struct p=
p_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;[EnableDPMTasks] Failed to initialize SMC table!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn result);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega20_override_pcie_=
parameters(hwmgr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!result,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[Enab=
leDPMTasks] Failed to override pcie parameters!&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return resu=
lt);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega20_run_=
btc(hwmgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!r=
esult,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;[EnableDPMTasks] Failed to run btc!&quot;,<br>
&gt; @@ -1631,6 &#43;1661,11 @@ static int vega20_enable_dpm_tasks(struct p=
p_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;[EnableDPMTasks] Failed to enable all smu features!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn result);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega20_override_p=
cie_parameters(hwmgr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!result,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[=
EnableDPMTasks] Failed to override pcie parameters!&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
result);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega20_noti=
fy_smc_display_change(hwmgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!r=
esult,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;[EnableDPMTasks] Failed to notify smc display change!&quot;,<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=
=3D"LPlnk901207" class=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk961930" class=3D"x_gmail-m_329555177500593286OWAAutoLink OWAAutoLi=
nk" target=3D"_blank" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"x_gmail-m_329555177500593286LPBorder_GT_15490596973030.810905253=
6501797" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-inden=
t:0px">
<table id=3D"x_gmail-m_329555177500593286LPContainer_15490596973000.9760548=
684631369" style=3D"width:90%; background-color:rgb(255,255,255); overflow:=
auto; padding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1p=
x dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)" cells=
pacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"x_gmail-m_329555177500593286TextCell_15490596973010.8841707630863=
909" colspan=3D"2" style=3D"vertical-align:top; padding:0px; display:table-=
cell">
<div id=3D"x_gmail-m_329555177500593286LPRemovePreviewContainer_15490596973=
010.5097834543649797">
</div>
<div id=3D"x_gmail-m_329555177500593286LPTitle_15490596973010.6766157293160=
253" style=3D"color:rgb(0,120,215); font-weight:400; font-size:21px; font-f=
amily:&quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe =
WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-=
serif; line-height:21px">
<a id=3D"LPlnk508294" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" target=3D"_blank" style=3D"text-decoration:none" class=3D"OWAAut=
oLink" previewremoved=3D"true">amd-gfx Info Page - freedesktop.org</a></div=
>
<div id=3D"x_gmail-m_329555177500593286LPMetadata_15490596973020.9257698477=
379372" style=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight:=
400; font-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;=
Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank" id=3D"LPlnk23791=
9" class=3D"OWAAutoLink" previewremoved=3D"true">lists.freedesktop.org</a><=
/div>
<div id=3D"x_gmail-m_329555177500593286LPDescription_15490596973020.8919956=
792568361" style=3D"display:block; color:rgb(102,102,102); font-weight:400;=
 font-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size:14px; line-height:20px; max-h=
eight:100px; overflow:hidden">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"LP=
lnk852842" class=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>. You can subscribe to the list, or change=
 your existing subscription, in the sections below.</div>
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
</div>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB338407B3190B9A7E85DF3DE08C920BYAPR12MB3384namp_--

--===============0845498422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0845498422==--
