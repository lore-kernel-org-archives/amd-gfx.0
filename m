From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add override pcie parameters for
 Vega20 (v2)
Date: Fri, 1 Feb 2019 22:28:46 +0000
Message-ID: <BYAPR12MB338437F11284DF95CE3ACF9A8C920@BYAPR12MB3384.namprd12.prod.outlook.com>
References: <1549055816-12976-1-git-send-email-Harish.Kasiviswanathan@amd.com>
 <1549055816-12976-2-git-send-email-Harish.Kasiviswanathan@amd.com>,
 <CADnq5_O5BcdjYyAx8_aj1PncKNbhVJwZF67sUyFKOrS9x_xLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457817761=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O5BcdjYyAx8_aj1PncKNbhVJwZF67sUyFKOrS9x_xLwg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1457817761==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB338437F11284DF95CE3ACF9A8C920BYAPR12MB3384namp_"

--_000_BYAPR12MB338437F11284DF95CE3ACF9A8C920BYAPR12MB3384namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks Alex. I saw that function. It gets caps. The function requires link =
status (PCI_EXP_LNKSTA), the value negotiated.


> I'd rather not access pci config space from the powerplay code because it=
 doesn't work under virtualization.

[HK] I will then modify amdgpu_device_get_pcie_info() to read "PCI_EXP_LINK=
STA" and store that information for future use.

Best Regards,
Harish


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, February 1, 2019 5:09 PM
To: Kasiviswanathan, Harish
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerplay: add override pcie parameters for Ve=
ga20 (v2)

On Fri, Feb 1, 2019 at 4:17 PM Kasiviswanathan, Harish
<Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org> wrote:
>
> v2: Use PCIe link status instead of link capability
>     Send override message after SMU enable features
>
> Change-Id: Iea2a1ac595cf63a9528ff1e9a6955d14d8c3a6d5
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
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
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BYAPR12MB338437F11284DF95CE3ACF9A8C920BYAPR12MB3384namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Thanks Alex. I saw that function.=
 It gets caps. The function requires link status (<font size=3D"2"><span st=
yle=3D"font-size:11pt;">PCI_EXP_LNKSTA</span></font>), the value negotiated=
.
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">&gt; I'd rather not access pci config space from the powerp=
lay code because it doesn't work under virtualization.</span></font><br>
</p>
<div>[HK] I will then modify <font size=3D"2"><span style=3D"font-size:11pt=
;">amdgpu_device_get_pcie_info()</span></font> to read &quot;PCI_EXP_LINKST=
A&quot; and store that information for future use.</div>
<div><br>
</div>
<div>Best Regards,</div>
<div>Harish</div>
<div><br>
</div>
<div><br>
</div>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, February 1, 2019 5:09 PM<br>
<b>To:</b> Kasiviswanathan, Harish<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: add override pcie parameters=
 for Vega20 (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Feb 1, 2019 at 4:17 PM Kasiviswanathan, Ha=
rish<br>
&lt;Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; v2: Use PCIe link status instead of link capability<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Send override message after SMU enable feature=
s<br>
&gt;<br>
&gt; Change-Id: Iea2a1ac595cf63a9528ff1e9a6955d14d8c3a6d5<br>
&gt; Signed-off-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.c=
om&gt;<br>
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
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk741395" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15490596973030.8109052536501797" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15490596973000.9760548684631369" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15490596973010.8841707630863909" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15490596973010.5097834543649797"></div>
<div id=3D"LPTitle_15490596973010.6766157293160253" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15490596973010.7296041712133615" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15490596973020.9257698477379372" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15490596973020.8919956792568361" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
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
</body>
</html>

--_000_BYAPR12MB338437F11284DF95CE3ACF9A8C920BYAPR12MB3384namp_--

--===============1457817761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1457817761==--
