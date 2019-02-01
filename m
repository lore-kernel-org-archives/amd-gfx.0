From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add override pcie parameters for
 Vega20 (v2)
Date: Fri, 1 Feb 2019 17:53:01 -0500
Message-ID: <CADnq5_Oo8E_qkrhPN0uus1bMj6HzEJB1TP0G=2U32H-qAJyPxg@mail.gmail.com>
References: <1549055816-12976-1-git-send-email-Harish.Kasiviswanathan@amd.com>
 <1549055816-12976-2-git-send-email-Harish.Kasiviswanathan@amd.com>
 <CADnq5_O5BcdjYyAx8_aj1PncKNbhVJwZF67sUyFKOrS9x_xLwg@mail.gmail.com>
 <BYAPR12MB338437F11284DF95CE3ACF9A8C920@BYAPR12MB3384.namprd12.prod.outlook.com>
 <CADnq5_PNDssVY0x5X4=ROhmh5naOd83dSTeKe++yNJU=b6+u7Q@mail.gmail.com>
 <BYAPR12MB338407B3190B9A7E85DF3DE08C920@BYAPR12MB3384.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0197448397=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB338407B3190B9A7E85DF3DE08C920-ZGDeBxoHBPn6x/DOKSkw2AdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Colin" <Colin.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Xi,
 Sheldon" <Sheldon.Xi-5C7GfCeVMHo@public.gmane.org>

--===============0197448397==
Content-Type: multipart/alternative; boundary="000000000000f6f7720580dd0122"

--000000000000f6f7720580dd0122
Content-Type: text/plain; charset="UTF-8"

Right.  we have the max gen and width supported by the card and the
platform in already in the driver thanks to amdgpu_device_get_pcie_info()
so we just need to use the platform gen caps to limit the max pcie gen in
dpm1.  You don't want to use the current status because that might have
been changed by sw at some point.  The asic caps are defined by
CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN* while the platform caps are defined
by CAIL_PCIE_LINK_SPEED_SUPPORT_GEN*.  I think the original code was
correct.  What you may have been running into was a bug in
pcie_get_speed_cap() that recently got fixed:

commit f1f90e254e46e0a14220e4090041f68256fbe297
Author: Mikulas Patocka <mpatocka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Nov 26 10:37:13 2018 -0600

    PCI: Fix incorrect value returned from pcie_get_speed_cap()

    The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks.  We must
mask
    the register and compare it against them.

    This fixes errors like this:

      amdgpu: [powerplay] failed to send message 261 ret is 0

    when a PCIe-v3 card is plugged into a PCIe-v1 slot, because the slot is
    being incorrectly reported as PCIe-v3 capable.

    6cf57be0f78e, which appeared in v4.17, added pcie_get_speed_cap() with
the
    incorrect test of PCI_EXP_LNKCAP_SLS as a bitmask.  5d9a63304032, which
    appeared in v4.19, changed amdgpu to use pcie_get_speed_cap(), so the
    amdgpu bug reports below are regressions in v4.19.

    Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max
supported link speed")
    Fixes: 5d9a63304032 ("drm/amdgpu: use pcie functions for link width and
speed")
    Link: https://bugs.freedesktop.org/show_bug.cgi?id=108704
    Link: https://bugs.freedesktop.org/show_bug.cgi?id=108778
    Signed-off-by: Mikulas Patocka <mpatocka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
    [bhelgaas: update comment, remove use of PCI_EXP_LNKCAP_SLS_8_0GB and
    PCI_EXP_LNKCAP_SLS_16_0GB since those should be covered by
PCI_EXP_LNKCAP2,
    remove test of PCI_EXP_LNKCAP for zero, since that register is required]
    Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
    Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
    Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org      # v4.17+


On Fri, Feb 1, 2019 at 5:43 PM Kasiviswanathan, Harish <
Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org> wrote:

> Let me explain the problem. I also adding Colin & Sheldon from the SMU
> team.
>
>
> Currently, PPTable entries (inside VBIOS) reflects ASIC capabilities and
> not the system capabilities. So if we put Gen4 capable Vega20 in a system
> that supports only Gen3, the PPTable has Gen4 for DPM 1 (higher DPM state).
> Later on when SMU wants to switch to DPM1 it fails since Gen4 is not
> supported. SMU however, doesn't fall back to Gen3 but instead to Gen0. This
> is causing a performance issue.
>
>
> As I understand, this override is required only for the higher DPM state.
>
> Best Regards,
> Harish
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, February 1, 2019 5:34 PM
> *To:* Kasiviswanathan, Harish
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/powerplay: add override pcie parameters
> for Vega20 (v2)
>
> Do we actually need the current status?  We have the caps of the platform
> and the device.  For the lowest dpm state, we generally want the lowest
> common gen and then the highest common gen for the highest dpm state.  If
> we use the current status, we will mostly likely end up with the highest
> gen in the lowest dpm state because generally the highest gen is negotiated
> at power up.
>
> Alex
>
> On Fri, Feb 1, 2019 at 5:28 PM Kasiviswanathan, Harish <
> Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Thanks Alex. I saw that function. It gets caps. The function requires link
> status (PCI_EXP_LNKSTA), the value negotiated.
>
>
> > I'd rather not access pci config space from the powerplay code because
> it doesn't work under virtualization.
> [HK] I will then modify amdgpu_device_get_pcie_info() to read
> "PCI_EXP_LINKSTA" and store that information for future use.
>
> Best Regards,
> Harish
>
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, February 1, 2019 5:09 PM
> *To:* Kasiviswanathan, Harish
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/powerplay: add override pcie parameters
> for Vega20 (v2)
>
> On Fri, Feb 1, 2019 at 4:17 PM Kasiviswanathan, Harish
> <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org> wrote:
> >
> > v2: Use PCIe link status instead of link capability
> >     Send override message after SMU enable features
> >
> > Change-Id: Iea2a1ac595cf63a9528ff1e9a6955d14d8c3a6d5
> > Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 93
> +++++++++++++++-------
> >  1 file changed, 64 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > index da022ca..d166f8c 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > @@ -771,40 +771,75 @@ static int vega20_init_smc_table(struct pp_hwmgr
> *hwmgr)
> >         return 0;
> >  }
> >
> > +/*
> > + * Override PCIe link speed and link width for DPM Level 1. PPTable
> entries
> > + * reflect the ASIC capabilities and not the system capabilities. For
> e.g.
> > + * Vega20 board in a PCI Gen3 system. In this case, when SMU's tries to
> switch
> > + * to DPM1, it fails as system doesn't support Gen4.
> > + */
> >  static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
> >  {
> >         struct amdgpu_device *adev = (struct amdgpu_device
> *)(hwmgr->adev);
> > -       uint32_t pcie_speed = 0, pcie_width = 0, pcie_arg;
> > +       uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg;
> >         int ret;
> > +       uint16_t lnkstat;
> > +
> > +       pcie_capability_read_word(adev->pdev, PCI_EXP_LNKSTA, &lnkstat);
> >
> > -       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
> > -               pcie_speed = 16;
> > -       else if (adev->pm.pcie_gen_mask &
> CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
> > -               pcie_speed = 8;
> > -       else if (adev->pm.pcie_gen_mask &
> CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
> > -               pcie_speed = 5;
> > -       else if (adev->pm.pcie_gen_mask &
> CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
> > -               pcie_speed = 2;
> > -
> > -       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32)
> > -               pcie_width = 32;
> > -       else if (adev->pm.pcie_mlw_mask &
> CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
> > -               pcie_width = 16;
> > -       else if (adev->pm.pcie_mlw_mask &
> CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
> > -               pcie_width = 12;
> > -       else if (adev->pm.pcie_mlw_mask &
> CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
> > -               pcie_width = 8;
> > -       else if (adev->pm.pcie_mlw_mask &
> CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
> > +       switch (lnkstat & PCI_EXP_LNKSTA_CLS) {
> > +       case PCI_EXP_LNKSTA_CLS_2_5GB:
> > +               pcie_gen = 0;
> > +               break;
> > +       case PCI_EXP_LNKSTA_CLS_5_0GB:
> > +               pcie_gen = 1;
> > +               break;
> > +       case PCI_EXP_LNKSTA_CLS_8_0GB:
> > +               pcie_gen = 2;
> > +               break;
> > +       case PCI_EXP_LNKSTA_CLS_16_0GB:
> > +               pcie_gen = 3;
> > +               break;
> > +       default:
> > +               pr_warn("Unknown PCI link speed %x\n",
> > +                       lnkstat & PCI_EXP_LNKSTA_CLS);
> > +       }
> > +
> > +
> > +       switch ((lnkstat & PCI_EXP_LNKSTA_NLW) >>
> PCI_EXP_LNKSTA_NLW_SHIFT) {
> > +       case 32:
> > +               pcie_width = 7;
> > +               break;
> > +       case 16:
> > +               pcie_width = 6;
> > +               break;
> > +       case 12:
> > +               pcie_width = 5;
> > +               break;
> > +       case 8:
> >                 pcie_width = 4;
> > -       else if (adev->pm.pcie_mlw_mask &
> CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
> > +               break;
> > +       case 4:
> > +               pcie_width = 3;
> > +               break;
> > +       case 2:
> >                 pcie_width = 2;
> > -       else if (adev->pm.pcie_mlw_mask &
> CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
> > +               break;
> > +       case 1:
> >                 pcie_width = 1;
> > +               break;
> > +       default:
> > +               pr_warn("Unknown PCI link width %x\n",
> > +                       lnkstat & PCI_EXP_LNKSTA_CLS);
> > +       }
> >
>
> We already get the link caps for both the device and the platform in
> amdgpu_device_get_pcie_info().  Is that info not adequate?  I'd rather
> not access pci config space from the powerplay code because it doesn't
> work under virtualization.
>
> Alex
>
> > -       pcie_arg = pcie_width | (pcie_speed << 8);
> > -
> > +       /* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
> > +        * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
> > +        * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
> > +        */
> > +       smu_pcie_arg = (1 << 16) | (pcie_gen << 8) | pcie_width;
> >         ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> > -                       PPSMC_MSG_OverridePcieParameters, pcie_arg);
> > +                       PPSMC_MSG_OverridePcieParameters, smu_pcie_arg);
> > +
> >         PP_ASSERT_WITH_CODE(!ret,
> >                 "[OverridePcieParameters] Attempt to override pcie
> params failed!",
> >                 return ret);
> > @@ -1611,11 +1646,6 @@ static int vega20_enable_dpm_tasks(struct
> pp_hwmgr *hwmgr)
> >                         "[EnableDPMTasks] Failed to initialize SMC
> table!",
> >                         return result);
> >
> > -       result = vega20_override_pcie_parameters(hwmgr);
> > -       PP_ASSERT_WITH_CODE(!result,
> > -                       "[EnableDPMTasks] Failed to override pcie
> parameters!",
> > -                       return result);
> > -
> >         result = vega20_run_btc(hwmgr);
> >         PP_ASSERT_WITH_CODE(!result,
> >                         "[EnableDPMTasks] Failed to run btc!",
> > @@ -1631,6 +1661,11 @@ static int vega20_enable_dpm_tasks(struct
> pp_hwmgr *hwmgr)
> >                         "[EnableDPMTasks] Failed to enable all smu
> features!",
> >                         return result);
> >
> > +       result = vega20_override_pcie_parameters(hwmgr);
> > +       PP_ASSERT_WITH_CODE(!result,
> > +                       "[EnableDPMTasks] Failed to override pcie
> parameters!",
> > +                       return result);
> > +
> >         result = vega20_notify_smc_display_change(hwmgr);
> >         PP_ASSERT_WITH_CODE(!result,
> >                         "[EnableDPMTasks] Failed to notify smc display
> change!",
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx
> Archives.. Using amd-gfx: To post a message to all the list members, send
> email to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or
> change your existing subscription, in the sections below.
>
>

--000000000000f6f7720580dd0122
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Right.=C2=A0 we have the m=
ax gen and width supported by the card and the platform in already in the d=
river thanks to amdgpu_device_get_pcie_info() so we just need to use the pl=
atform gen caps to limit the max pcie gen in dpm1.=C2=A0 You don&#39;t want=
 to use the current status because that might have been changed by sw at so=
me point.=C2=A0 The asic caps are defined by CAIL_ASIC_PCIE_LINK_SPEED_SUPP=
ORT_GEN* while the platform caps are defined by CAIL_PCIE_LINK_SPEED_SUPPOR=
T_GEN*.=C2=A0 I think the original code was correct.=C2=A0 What you may hav=
e been running into was a bug in pcie_get_speed_cap() that recently got fix=
ed:</div><div><br></div><div>commit f1f90e254e46e0a14220e4090041f68256fbe29=
7<br>Author: Mikulas Patocka &lt;<a href=3D"mailto:mpatocka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mpa=
tocka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>Date:=C2=A0=C2=A0 Mon Nov 26 10:37:13 2018 -060=
0<br><br>=C2=A0=C2=A0=C2=A0 PCI: Fix incorrect value returned from pcie_get=
_speed_cap()<br>=C2=A0=C2=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0 The macros PCI_EX=
P_LNKCAP_SLS_*GB are values, not bit masks.=C2=A0 We must mask<br>=C2=A0=C2=
=A0=C2=A0 the register and compare it against them.<br>=C2=A0=C2=A0=C2=A0 <=
br>=C2=A0=C2=A0=C2=A0 This fixes errors like this:<br>=C2=A0=C2=A0=C2=A0 <b=
r>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu: [powerplay] failed to send message=
 261 ret is 0<br>=C2=A0=C2=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0 when a PCIe-v3 c=
ard is plugged into a PCIe-v1 slot, because the slot is<br>=C2=A0=C2=A0=C2=
=A0 being incorrectly reported as PCIe-v3 capable.<br>=C2=A0=C2=A0=C2=A0 <b=
r>=C2=A0=C2=A0=C2=A0 6cf57be0f78e, which appeared in v4.17, added pcie_get_=
speed_cap() with the<br>=C2=A0=C2=A0=C2=A0 incorrect test of PCI_EXP_LNKCAP=
_SLS as a bitmask.=C2=A0 5d9a63304032, which<br>=C2=A0=C2=A0=C2=A0 appeared=
 in v4.19, changed amdgpu to use pcie_get_speed_cap(), so the<br>=C2=A0=C2=
=A0=C2=A0 amdgpu bug reports below are regressions in v4.19.<br>=C2=A0=C2=
=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0 Fixes: 6cf57be0f78e (&quot;PCI: Add pcie_g=
et_speed_cap() to find max supported link speed&quot;)<br>=C2=A0=C2=A0=C2=
=A0 Fixes: 5d9a63304032 (&quot;drm/amdgpu: use pcie functions for link widt=
h and speed&quot;)<br>=C2=A0=C2=A0=C2=A0 Link: <a href=3D"https://bugs.free=
desktop.org/show_bug.cgi?id=3D108704">https://bugs.freedesktop.org/show_bug=
.cgi?id=3D108704</a><br>=C2=A0=C2=A0=C2=A0 Link: <a href=3D"https://bugs.fr=
eedesktop.org/show_bug.cgi?id=3D108778">https://bugs.freedesktop.org/show_b=
ug.cgi?id=3D108778</a><br>=C2=A0=C2=A0=C2=A0 Signed-off-by: Mikulas Patocka=
 &lt;<a href=3D"mailto:mpatocka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mpatocka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>=
=C2=A0=C2=A0=C2=A0 [bhelgaas: update comment, remove use of PCI_EXP_LNKCAP_=
SLS_8_0GB and<br>=C2=A0=C2=A0=C2=A0 PCI_EXP_LNKCAP_SLS_16_0GB since those s=
hould be covered by PCI_EXP_LNKCAP2,<br>=C2=A0=C2=A0=C2=A0 remove test of P=
CI_EXP_LNKCAP for zero, since that register is required]<br>=C2=A0=C2=A0=C2=
=A0 Signed-off-by: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org"=
>bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt;<br>=C2=A0=C2=A0=C2=A0 Acked-by: Alex Deucher &=
lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</=
a>&gt;<br>=C2=A0=C2=A0=C2=A0 Cc: <a href=3D"mailto:stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # v4.17+<br><br></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Fri, Feb 1, 2019 at 5:43 PM Kasiviswanathan, Harish &lt;<a href=3D"mailto:=
Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org">Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"gmail-m_3154020805083033663divtagdefaultwrapper" style=3D"font-s=
ize:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif" dir=3D"=
ltr">
<p style=3D"margin-top:0px;margin-bottom:0px">Let me explain the problem. I=
 also adding Colin &amp; Sheldon from the SMU team.</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px">Currently, <font size=3D"2"><=
span style=3D"font-size:11pt">PPTable entries (inside VBIOS) reflects ASIC =
capabilities and not the system capabilities.</span></font> So if we put Ge=
n4 capable Vega20 in a system that supports
 only Gen3, the PPTable has Gen4 for DPM 1 (higher DPM state). Later on whe=
n SMU wants to switch to DPM1 it fails since Gen4 is not supported. SMU how=
ever, doesn&#39;t fall back to Gen3 but instead to Gen0. This is causing a =
performance issue.</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px">As I understand, this overrid=
e is required only for the higher DPM state.<br>
</p>
<div><br>
</div>
<div>Best Regards,</div>
<div>Harish</div>
<div><br>
</div>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_3154020805083033663divRplyFwdMsg" dir=3D"ltr"><font styl=
e=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From=
:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_=
blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, February 1, 2019 5:34 PM<br>
<b>To:</b> Kasiviswanathan, Harish<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: add override pcie parameters=
 for Vega20 (v2)</font>
<div>=C2=A0</div>
</div>
<div>
<div dir=3D"ltr">
<div>Do we actually need the current status?=C2=A0 We have the caps of the =
platform and the device.=C2=A0 For the lowest dpm state, we generally want =
the lowest common gen and then the highest common gen for the highest dpm s=
tate.=C2=A0 If we use the current status, we will
 mostly likely end up with the highest gen in the lowest dpm state because =
generally the highest gen is negotiated at power up.</div>
<div><br>
</div>
<div>Alex<br>
</div>
<br>
<div class=3D"gmail-m_3154020805083033663x_gmail_quote">
<div dir=3D"ltr" class=3D"gmail-m_3154020805083033663x_gmail_attr">On Fri, =
Feb 1, 2019 at 5:28 PM Kasiviswanathan, Harish &lt;<a href=3D"mailto:Harish=
.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org" id=3D"gmail-m_3154020805083033663LPlnk390754" cla=
ss=3D"gmail-m_3154020805083033663OWAAutoLink" target=3D"_blank">Harish.Kasi=
viswanathan-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail-m_3154020805083033663x_gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<div dir=3D"ltr">
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286divtagdef=
aultwrapper" dir=3D"ltr" style=3D"font-size:12pt;color:rgb(0,0,0);font-fami=
ly:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px;margin-bottom:0px">Thanks Alex. I saw that funct=
ion. It gets caps. The function requires link status (<font size=3D"2"><spa=
n style=3D"font-size:11pt">PCI_EXP_LNKSTA</span></font>), the value negotia=
ted.
<br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><br>
</p>
<p style=3D"margin-top:0px;margin-bottom:0px"><font size=3D"2"><span style=
=3D"font-size:11pt">&gt; I&#39;d rather not access pci config space from th=
e powerplay code because it doesn&#39;t work under virtualization.</span></=
font><br>
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
<hr style=3D"display:inline-block;width:98%">
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286divRplyFw=
dMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-seri=
f" color=3D"#000000"><b>From:</b> Alex Deucher &lt;<a href=3D"mailto:alexde=
ucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" id=3D"gmail-m_3154020805083033663LPlnk97574" class=3D"gmai=
l-m_3154020805083033663OWAAutoLink" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
</a>&gt;<br>
<b>Sent:</b> Friday, February 1, 2019 5:09 PM<br>
<b>To:</b> Kasiviswanathan, Harish<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"gmail-m_3=
154020805083033663LPlnk857262" class=3D"gmail-m_3154020805083033663OWAAutoL=
ink" target=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: add override pcie parameters=
 for Vega20 (v2)</font>
<div>=C2=A0</div>
</div>
<div class=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286BodyFr=
agment"><font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286PlainT=
ext">On Fri, Feb 1, 2019 at 4:17 PM Kasiviswanathan, Harish<br>
&lt;<a href=3D"mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org" id=3D"gmail-m_3154020=
805083033663LPlnk596173" class=3D"gmail-m_3154020805083033663OWAAutoLink" t=
arget=3D"_blank">Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; v2: Use PCIe link status instead of link capability<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 Send override message after SMU enable feature=
s<br>
&gt;<br>
&gt; Change-Id: Iea2a1ac595cf63a9528ff1e9a6955d14d8c3a6d5<br>
&gt; Signed-off-by: Harish Kasiviswanathan &lt;<a href=3D"mailto:Harish.Kas=
iviswanathan-5C7GfCeVMHo@public.gmane.org" id=3D"gmail-m_3154020805083033663LPlnk870253" class=
=3D"gmail-m_3154020805083033663OWAAutoLink" target=3D"_blank">Harish.Kasivi=
swanathan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 93 ++++++++=
+++++++-------<br>
&gt;=C2=A0 1 file changed, 64 insertions(+), 29 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index da022ca..d166f8c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; @@ -771,40 +771,75 @@ static int vega20_init_smc_table(struct pp_hwmgr=
 *hwmgr)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/*<br>
&gt; + * Override PCIe link speed and link width for DPM Level 1. PPTable e=
ntries<br>
&gt; + * reflect the ASIC capabilities and not the system capabilities. For=
 e.g.<br>
&gt; + * Vega20 board in a PCI Gen3 system. In this case, when SMU&#39;s tr=
ies to switch<br>
&gt; + * to DPM1, it fails as system doesn&#39;t support Gen4.<br>
&gt; + */<br>
&gt;=C2=A0 static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmg=
r)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *=
adev =3D (struct amdgpu_device *)(hwmgr-&gt;adev);<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pcie_speed =3D 0, pcie_=
width =3D 0, pcie_arg;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pcie_gen =3D 0, pcie_wi=
dth =3D 0, smu_pcie_arg;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t lnkstat;<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_capability_read_word(adev-&=
gt;pdev, PCI_EXP_LNKSTA, &amp;lnkstat);<br>
&gt;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev-&gt;pm.pcie_gen_mask &a=
mp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_speed =3D 16;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_gen_ma=
sk &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_speed =3D 8;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_gen_ma=
sk &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_speed =3D 5;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_gen_ma=
sk &amp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_speed =3D 2;<br>
&gt; -<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X32)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 32;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 16;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 12;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 8;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (lnkstat &amp; PCI_EXP_LN=
KSTA_CLS) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCI_EXP_LNKSTA_CLS_2_5GB:<b=
r>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_gen =3D 0;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCI_EXP_LNKSTA_CLS_5_0GB:<b=
r>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_gen =3D 1;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCI_EXP_LNKSTA_CLS_8_0GB:<b=
r>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_gen =3D 2;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCI_EXP_LNKSTA_CLS_16_0GB:<=
br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_gen =3D 3;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_warn(&quot;Unknown PCI link speed %x\n&quot;,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lnkstat &am=
p; PCI_EXP_LNKSTA_CLS);<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch ((lnkstat &amp; PCI_EXP_L=
NKSTA_NLW) &gt;&gt; PCI_EXP_LNKSTA_NLW_SHIFT) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 32:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 7;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 16:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 6;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 12:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 5;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 8:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_width =3D 4;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 4:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pcie_width =3D 3;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 2:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_width =3D 2;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev-&gt;pm.pcie_mlw_ma=
sk &amp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_width =3D 1;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_warn(&quot;Unknown PCI link width %x\n&quot;,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lnkstat &am=
p; PCI_EXP_LNKSTA_CLS);<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;<br>
<br>
We already get the link caps for both the device and the platform in<br>
amdgpu_device_get_pcie_info().=C2=A0 Is that info not adequate?=C2=A0 I&#39=
;d rather<br>
not access pci config space from the powerplay code because it doesn&#39;t<=
br>
work under virtualization.<br>
<br>
Alex<br>
<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_arg =3D pcie_width | (pcie_=
speed &lt;&lt; 8);<br>
&gt; -<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Bit 31:16: LCLK DPM level. 0 =
is DPM0, and 1 is DPM1<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 15:8:=C2=A0 PCIE GEN=
, 0 to 3 corresponds to GEN1 to GEN4<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 7:0:=C2=A0=C2=A0 PCI=
E lane width, 1 to 7 corresponds is x1 to x32<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smu_pcie_arg =3D (1 &lt;&lt; 16)=
 | (pcie_gen &lt;&lt; 8) | pcie_width;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D smum_send_msg_=
to_smc_with_parameter(hwmgr,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PPSMC_MSG_O=
verridePcieParameters, pcie_arg);<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PPSMC_MSG_O=
verridePcieParameters, smu_pcie_arg);<br>
&gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP_ASSERT_WITH_CODE(!r=
et,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;[OverridePcieParameters] Attempt to overr=
ide pcie params failed!&quot;,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret);<br>
&gt; @@ -1611,11 +1646,6 @@ static int vega20_enable_dpm_tasks(struct pp_hw=
mgr *hwmgr)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &quot;[EnableDPMTasks] Failed to initialize SMC table!&quot;,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return result);<br>
&gt;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D vega20_override_pcie_=
parameters(hwmgr);<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP_ASSERT_WITH_CODE(!result,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;[Enab=
leDPMTasks] Failed to override pcie parameters!&quot;,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return resu=
lt);<br>
&gt; -<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D vega20_run_=
btc(hwmgr);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP_ASSERT_WITH_CODE(!r=
esult,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &quot;[EnableDPMTasks] Failed to run btc!&quot;,<br>
&gt; @@ -1631,6 +1661,11 @@ static int vega20_enable_dpm_tasks(struct pp_hw=
mgr *hwmgr)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &quot;[EnableDPMTasks] Failed to enable all smu features!&quot;,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return result);<br>
&gt;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D vega20_override_pcie_=
parameters(hwmgr);<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP_ASSERT_WITH_CODE(!result,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;[Enab=
leDPMTasks] Failed to override pcie parameters!&quot;,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return resu=
lt);<br>
&gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D vega20_noti=
fy_smc_display_change(hwmgr);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP_ASSERT_WITH_CODE(!r=
esult,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &quot;[EnableDPMTasks] Failed to notify smc display change!&quot;,<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"gmail-m_3154020=
805083033663LPlnk901207" class=3D"gmail-m_3154020805083033663OWAAutoLink" t=
arget=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"gmail-m_3154020805083033663LPlnk961930" class=3D"gmail-m_31540208050830=
33663x_gmail-m_329555177500593286OWAAutoLink gmail-m_3154020805083033663OWA=
AutoLink" target=3D"_blank">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286LPBorder_=
GT_15490596973030.8109052536501797" style=3D"margin-bottom:20px;overflow:au=
to;width:100%;text-indent:0px">
<table id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286LPConta=
iner_15490596973000.9760548684631369" style=3D"width:90%;background-color:r=
gb(255,255,255);overflow:auto;padding-top:20px;padding-bottom:20px;margin-t=
op:20px;border-top:1px dotted rgb(200,200,200);border-bottom:1px dotted rgb=
(200,200,200)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286TextCell_1=
5490596973010.8841707630863909" colspan=3D"2" style=3D"vertical-align:top;p=
adding:0px;display:table-cell">
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286LPRemoveP=
reviewContainer_15490596973010.5097834543649797">
</div>
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286LPTitle_1=
5490596973010.6766157293160253" style=3D"color:rgb(0,120,215);font-weight:4=
00;font-size:21px;font-family:&quot;wf_segoe-ui_light&quot;,&quot;Segoe UI =
Light&quot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&=
quot;,Tahoma,Arial,sans-serif;line-height:21px">
<a id=3D"gmail-m_3154020805083033663LPlnk508294" href=3D"https://lists.free=
desktop.org/mailman/listinfo/amd-gfx" style=3D"text-decoration:none" class=
=3D"gmail-m_3154020805083033663OWAAutoLink" target=3D"_blank">amd-gfx Info =
Page - freedesktop.org</a></div>
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286LPMetadat=
a_15490596973020.9257698477379372" style=3D"margin:10px 0px 16px;color:rgb(=
102,102,102);font-weight:400;font-family:&quot;wf_segoe-ui_normal&quot;,&qu=
ot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size:14=
px;line-height:14px">
<a href=3D"http://lists.freedesktop.org" id=3D"gmail-m_3154020805083033663L=
Plnk237919" class=3D"gmail-m_3154020805083033663OWAAutoLink" target=3D"_bla=
nk">lists.freedesktop.org</a></div>
<div id=3D"gmail-m_3154020805083033663x_gmail-m_329555177500593286LPDescrip=
tion_15490596973020.8919956792568361" style=3D"display:block;color:rgb(102,=
102,102);font-weight:400;font-family:&quot;wf_segoe-ui_normal&quot;,&quot;S=
egoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;l=
ine-height:20px;max-height:100px;overflow:hidden">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"gmail-m_315402080508=
3033663LPlnk852842" class=3D"gmail-m_3154020805083033663OWAAutoLink" target=
=3D"_blank">
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
</div>

</blockquote></div></div></div></div></div></div></div></div>

--000000000000f6f7720580dd0122--

--===============0197448397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0197448397==--
