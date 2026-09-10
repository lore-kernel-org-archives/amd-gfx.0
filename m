Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E51BC79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2137810E5E6;
	Thu, 10 Sep 2026 13:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pE8QCnyx";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3D810E609
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:21:43 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-7911e4349d3so37767137.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789046502; cv=none;
 d=google.com; s=arc-20260327;
 b=iqu44sqAZv2oKkV2YR2FZHIO+NeWmncuiCiXkebMGRxuEgMpL56Ax5H3S8C1XwhbJb
 RrkzAYdPDBIPzCa/af3kBbK+wYRMQjrvrOgVCnDmp71DGHJB8J/mVQLtMgzwExEha3vu
 yKYlNlXh6HV140H0/m293r25gsNImRjpcAqxA2o+8lqyKK+bhuVfOQO7nQTphSesqmcO
 +xdlracxCd3avBJG4ieWUTHr6dFY4y7aGlervLroQ2LSqLwBkMvsSi4ZbtpyncEJebut
 DRU7fq7IiCO3LWqOy+u3GFsqm53cZQBeyKAh4XMpGJqQK5TUx8L6DdWXzF+nk1ceE1pI
 +tAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4PtIkSiFzV3sIf3d9NLRzTCK6vH+MbAiKicnmJs6k5U=;
 fh=agT33ZQArzRKybLk72WJhLVl++fIdNZ+GqfNO2i6x5s=;
 b=EfWbPGFDZR66g4E1fJan7pSn9oetrYcALFW1dam6YWlDJHQ3IDxngzZVqo/yyokWM/
 NJxj6TLO7J4SkSHCRXEPLhWXv1KzF7kMpvy7l5Q5pEKURrQU9polxnpnuOGj1p/jUqC6
 WGuVzAYBQKx/sr1b2TJW754mei0sVWZbTjTM0qE+o3kxLO7603ukJOoGbwEtrQRcuGVs
 hO9APJk/qgyOiKuqgwyqgmr4YvKdfC/puxVzARvZ8KbOMGL5QbOo/Ots8Z3An54f6/lt
 Zpa05D06q5MwVaB8Mwh6+NG6vY1TaYtK9B7zRkM+46Zej6grjVIR4gamyNYfMfnTrvgt
 ZWRg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789046502; x=1789651302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4PtIkSiFzV3sIf3d9NLRzTCK6vH+MbAiKicnmJs6k5U=;
 b=pE8QCnyxYJhXcnSphSQMlztmDd3WfPujtWuJl0q5VORS1pG1TL5pIA8MyVyIiOotpW
 bOTmmNikuQltgKf1N43xKQZSoKYv5N8wvFfDWzRD1nEb8D/tS4PNYFy4os+jrrj2BxwT
 AJ89nWXRZklsBtfCdbyNZhTHkTFph6YQ2oPBSgDvQgXxhpurLfgEHSR6OnjNA4B0XW1g
 ObdcgWKyF/ha0dDLmWnWwGt2s6uoR2bOsevtd1jsosy+s+kOPCDrmz/h1grC49WgUmge
 54sfuh+sHHYJACSuFx5ddt5KFW9QQ8nBfbXCPISBlJjyfh3aGEWGENj5ViDw037f04wB
 CGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046502; x=1789651302;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4PtIkSiFzV3sIf3d9NLRzTCK6vH+MbAiKicnmJs6k5U=;
 b=Vap6pxZQbjKfCasvXP6PHNYRGzESn0L5CpYtf8woH6Ss68Lv9u8QPdtn3asFDAuwOt
 +smxad+3tOesyiDpBaBfMTx9ERDDouOwzBugwR6G32CKg05hgLbQskikkw7TBW+hByl6
 gPMsG36oeqHwypqJyZQdpTQBf9Oxsns1Zp8Wx7zn/VpkCmUsSd7/kkB0O/PZpjT83JCn
 MbzNNhHqi2mB/fha0GAkc6dQ4nBZOHLveB9v3IEJ4ZfClYI5cu0MBJ+KrLCANkVs5IMc
 ykbeSCmDGnH+M28tpN3YC9LuGawDfuOsRwDmADDcM3PQ3D9Ge1t7RVlsMsOKqEEMRBdn
 dd0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBygXBe7ZyWLlwT+CGq1jRbVjio/cHyFGwV88M9OBb/R1n5FYNINmOFTNoZKdDrBIIpuiDTCIEIB@lists.freedesktop.org
X-Gm-Message-State: AFuF++nz84mjtq5hAqpOMx808ZE6D/3+Ag0QwBdQ3+2myDQLukP2yior
 6cTthJdKTVLw0+A2Nn/g/aXj6SFADSWHPqgKR8kM3/yAEiMHCTGLHmvwAZ6HpIC3W5jVxWuj4Sv
 MOAViHj4iD1o+ol2ZTY61+wntMlejo0NY/A==
X-Gm-Gg: AYBFou12yDMWhP7+O+fs/pgFqOOX26BA21lPlyclBvJYJSFDRt6IKW+wLgl6cihnb+Y
 l6O69ylSJlyodhcUCtlRDJnMSFx8i+uNe4UbZTBZDRRqAbWf8iZI/iPCu+oa+m4uWbdhgNv7mfr
 4ZS4IP+Y1eMAS1D0gcqNxR/itz4P3pzDwoI8BUPX//if27Fj0b6+Kxs4WVxIAH7MIJt1a3G/aI2
 Et8uEgS4aNFczoYGylFnpEqFLIh/tO42Cz0jshUz68T0Y2NlCdKuZ3x/ictmUwS1IlfQgY99ptA
 8jnT3w1IUDQQzPiF5o4ZVdNRpHhRtzMYjwAOOjjl8rySihmutKMc3/04UxStX0GrAL5rpl8sqf8
 pay3WCmI7o4UMwpD6kmrsH+SKqOFK7mOYMfOnQ+994A==
X-Received: by 2002:a67:cd93:0:b0:791:33c:9d1 with SMTP id
 ada2fe7eead31-791033c0c0amr737086137.1.1789046501887; 
 Thu, 10 Sep 2026 06:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
 <20260909123443.88228-1-ed@aicharmers.com>
 <MW4PR12MB6803AED9EAA4A98576CC3F428EBF2@MW4PR12MB6803.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB6803AED9EAA4A98576CC3F428EBF2@MW4PR12MB6803.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Sep 2026 09:21:28 -0400
X-Gm-Features: AcwNN1UTe8M1-odt2iCgqossMzi7ldu5z1-OWpaSUlQIWuMy4BqVW8_dndwx5H8
Message-ID: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Ed Schofield <ed@aicharmers.com>, 
 "atharvatiwarilinuxdev@gmail.com" <atharvatiwarilinuxdev@gmail.com>, 
 "062bel313@gmail.com" <062bel313@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Thu, Sep 10, 2026 at 6:40=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> AMD General
>
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>
> -----Original Message-----
> From: Ed Schofield <ed@aicharmers.com>
> Sent: Wednesday, September 9, 2026 8:35 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: atharvatiwarilinuxdev@gmail.com; 062bel313@gmail.com; amd-gfx@lists.f=
reedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Chr=
istian <Christian.Koenig@amd.com>; airlied@gmail.com; simona@ffwll.ch; dri-=
devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 1=
4
>
> Apple Navi 14 boards 1002:7340/106b:0218 (revision 0x41) and
> 1002:7340/106b:0219 can time out when EnableAllSmuFeatures includes UCLK =
DPM, leaving amdgpu without a DRM device.
>
> Exclude only UCLK DPM from the initial allowed features and enable it sep=
arately in the Navi post-init callback. On 0218, enabling UCLK just after E=
nableAllSmuFeatures or at the start of default DPM table setup still timed =
out. The earlier 0218-only patch passed ten warm boots with UCLK enabled in=
 post-init. The earliest safe point remains unknown.
>
> Check the enabled firmware bit, update the supported-feature bit and rebu=
ild the memory DPM table and sustainable clock limits before the UMC workar=
ound and UMD clock setup. Validate the PPT memory states that
> DCN20 consumes before post-init. Preserve both memory-voltage features an=
d honor PP_MCLK_DPM_MASK.
>
> Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi pos=
t-init implementation for 0218. Retain the revision restriction for
> 0218 and the revision-independent 0219 match from Atharva's proposal.
>
> The combined patch passed ten warm boots on 0218, with rendering and
> H.264 video decoding checks on every boot. Testing on 0219 is still pendi=
ng.
>
> Link: https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg14977=
0.html
> Link: https://github.com/t2linux/kernel/issues/19#issuecomment-5537823876
> Assisted-by: Codex:GPT-6
> Signed-off-by: Ed Schofield <ed@aicharmers.com>
> ---
> Changes since the 0218-only RFC:
> - Add the 0219 board match from Atharva's proposal, without a revision
>   restriction. Keep the 0218 match limited to revision 0x41.
> - Keep the Navi post-init implementation and clock-state updates from
>   the RFC. Atharva's proposal enabled UCLK at the end of smu_late_init().
> - Record the failed tests at the start of default DPM table setup and
>   ten successful warm boots of the combined patch on 0218.
>
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index f8ca5eb9a..d7cc41a5d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -60,6 +60,19 @@
>
>  static int navi10_init_ppt_limits(struct smu_context *smu);
>
> +static bool navi14_needs_late_uclk(struct amdgpu_device *adev) {
> +       struct pci_dev *pdev =3D adev->pdev;
> +
> +       return pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> +               pdev->device =3D=3D 0x7340 &&
> +               pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> +               ((pdev->subsystem_device =3D=3D 0x0218 &&
> +                 pdev->revision =3D=3D 0x41) ||
> +                pdev->subsystem_device =3D=3D 0x0219) &&
> +               (adev->pm.pp_feature & PP_MCLK_DPM_MASK); }
> +
>  static const struct smu_feature_bits navi10_dpm_features =3D {
>         .bits =3D {
>                 SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
> @@ -356,6 +369,11 @@ navi10_init_allowed_features(struct smu_context *smu=
)
>                 smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, F=
EATURE_MEM_MVDD_SCALING_BIT);
>         }
>
> +       /* These boards time out if EnableAllSmuFeatures includes UCLK DP=
M. */
> +       if (navi14_needs_late_uclk(adev))
> +               smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
> +                                          FEATURE_DPM_UCLK_BIT);
> +
>         if (is_asic_secure(smu) &&
>             (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0=
, 0)) &&
>             (adev->rev_id =3D=3D 0))
> @@ -470,6 +488,25 @@ static int navi10_store_powerplay_table(struct smu_c=
ontext *smu)
>         return 0;
>  }
>
> +/* DCN20 consumes these PPT states before the post-init UCLK enable. */
> +static int navi14_imac_check_uclk_states(struct smu_context *smu) {
> +       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
> +       unsigned int count, i;
> +
> +       if (!navi14_needs_late_uclk(smu->adev))
> +               return 0;
> +
> +       count =3D ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
> +       if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
> +               return -EINVAL;
> +       for (i =3D 0; i < count; i++) {
> +               if (!ppt->FreqTableUclk[i])
> +                       return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  static int navi10_setup_pptable(struct smu_context *smu)  {
>         int ret =3D 0;
> @@ -490,6 +527,10 @@ static int navi10_setup_pptable(struct smu_context *=
smu)
>         if (ret)
>                 return ret;
>
> +       ret =3D navi14_imac_check_uclk_states(smu);
> +       if (ret)
> +               return ret;
> +
>         return navi10_init_ppt_limits(smu);
>  }
>
> @@ -3219,6 +3260,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu=
_context *smu)
>                                                NULL);
>  }
>
> +/* Rebuild memory clocks before the UMC workaround and UMD clock setup.
> +*/ static int navi14_imac_late_uclk_enable(struct smu_context *smu) {
> +       struct smu_11_0_dpm_context *dpm =3D smu->smu_dpm.dpm_context;
> +       struct smu_dpm_table *table =3D &dpm->dpm_tables.uclk_table;
> +       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
> +       struct smu_feature_bits enabled;
> +       int ret;
> +
> +       if (!navi14_needs_late_uclk(smu->adev))
> +               return 0;
> +
> +       ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT=
, true);
> +       if (ret)
> +               return ret;
> +       ret =3D smu_cmn_get_enabled_mask(smu, &enabled);
> +       if (ret)
> +               return ret;
> +       if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
> +               return -EIO;
> +
> +       smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
> +                                FEATURE_DPM_UCLK_BIT);
> +       table->clk_type =3D SMU_UCLK;
> +       ret =3D smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
> +       if (ret)
> +               return ret;
> +       if (!table->count)
> +               return -EINVAL;
> +       if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
> +               table->flags |=3D SMU_DPM_TABLE_FINE_GRAINED;
> +
> +       return smu_v11_0_init_max_sustainable_clocks(smu);
> +}
> +
>  static int navi10_post_smu_init(struct smu_context *smu)  {
>         struct amdgpu_device *adev =3D smu->adev; @@ -3227,6 +3303,12 @@ =
static int navi10_post_smu_init(struct smu_context *smu)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> +       ret =3D navi14_imac_late_uclk_enable(smu);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n"=
, ret);
> +               return ret;
> +       }
> +
>         ret =3D navi10_run_umc_cdr_workaround(smu);
>         if (ret)
>                 dev_err(adev->dev, "Failed to apply umc cdr workaround!\n=
");
>
> base-commit: c22f9a61e288580824edbbc3ae5a29c9a338594f
> --
> 2.55.0
