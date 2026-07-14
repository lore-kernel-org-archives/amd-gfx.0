Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D68BC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 16:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1142E10EDE1;
	Tue, 14 Jul 2026 16:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VI4P2p2d";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9500E10EDE1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 16:06:54 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso12450665ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045214; cv=none;
 d=google.com; s=arc-20260327;
 b=OUMKOjCg3YhZ5p6Iun+3kd2jx9YiUnbBxMp37RX10kjqClFECda2iWn7rlCIMJh4e0
 AdNiNk70Fwuet3PzrGjo4X+3ojZy4mY51WQMJrpk4Tfc2mvGuVOkny/iAGrdSOJ7Xy6+
 nosvB/KgqgJOU2MXRxW++iczTRtix0+7OBAf67s7jcXkcnoDcxheumD3qBgypFfPDr+q
 4S3uKUDl5NF5/AJEL+CykJWi3TRzdYcCW8Yd2Lecgiffdiy6bXxebmTYXnz+oZ4GfCec
 LXcxHENeremmcJ3Wl5p1D/X1v535UeHcK5FTtFUsjUhCKCESwY+jm6Lv0c+gHd0HMjap
 qPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CWAVCJ1HsGO85iHwY2inQ9WtMD2v1rUjV9gVG+BMN7A=;
 fh=P046pYA4XqzknrYfp7+brb3GFhObpTLRV0lbJCZULsk=;
 b=nZE1i5oyVgkNr33shqwr79L8oTF9BMgunm4+M0zlWOXpf+bWxnUpJXu+Sg4MrgoDgX
 cZyH5e92Zo2hOmK5liLn6XU23pC52a8adWpdvpMYA5bT8i7gCE+mrjaC+rT+7d4dUJEt
 4UBMatJC/NC8gKEX/tv6TPXwYiyhX0CKXBXTcyNinhAWRAvdPCGIPsfzgT4bpd1t9OZX
 usyUJS0LWyW3Xg/KW0oedEDUOifqRGKl+XPgL6a8MbOopaopOJF+uvDZzt2w7YtFP4C+
 XESrvCkTlBDVP3L/sUDaXzkFzPU55I+gJrZ//VJNe/CbneLOMOAicdOTkGyNihh3e/W/
 C90w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784045214; x=1784650014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CWAVCJ1HsGO85iHwY2inQ9WtMD2v1rUjV9gVG+BMN7A=;
 b=VI4P2p2d58fSuXfzjmR0wyb1FSDz4c7nCo4g5VXNcdwjSIg2Eo88Ke+RM79aEhL4WR
 6500qi/brsqz/gPFqeiiNwWgo0PqNILSBjC+Gax6Cxr5TEuVrWjmjyW4RUIlaPhCXpi3
 x+or7fXnbMiowv6T+oBES3oTVW5jbprxVup834Ix2NOKAq7TpLXp4xMrN1WX83JORRLu
 GezEhiPmmTN3S8Xnvoz+zoWfW7eZl0eeDcfhMzPveexbPHyrM/mvrL50T+aW5vxvzhqq
 3S0+RLqwM4SUTxT7abhMx4NL2zx9QoGT8wVdh/1MlpUcVRz9HikjzF5XOOvyegLTeQR7
 vaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784045214; x=1784650014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CWAVCJ1HsGO85iHwY2inQ9WtMD2v1rUjV9gVG+BMN7A=;
 b=B03pUAsW9hXzdkCmlvgqwbN0WAXD06l9UVkDmtjlMxHzq2gaA62V+g8mihnQHOnQ2F
 GZC4DIEwRed7Dp22/Qp53KOc+g5EZvfWsO8MOQdDNr5sP41pRVR1WQTsWExWaeik58Fc
 SHI8/xjsGNFG7zp6cEFcEg6m8QGgCmRGkcCBrsRJNAXp5c4ASLeiRNP+gb5OuSBW479n
 jvDbnFwlJkxAoRAO/ZnyV0Ht7dQLS9ln669mbvMM2gPadPc6uHCKLbuBr6ig7l0J+tVz
 Sjp/Q2wddGHiL0wu276AhXgyWHegJbI6tfN92qwORpbKbfcUBKm9i8gCH1VFpelPe1Di
 G7lg==
X-Gm-Message-State: AOJu0YzJSekmJubejOqeLAqChankveU5HtKrbXw/sj/tSuxEgZrGIg3t
 wVEBPO1ui7MdBBI3jrKrHHj0qoiO+FKyo96ocgoGIT78NdYBO9vMlICXa88qQktST0SeXA6JyOW
 1HQoRr44mBBcDW+JWxDuf/E79sDQ2x2lASA==
X-Gm-Gg: AfdE7cnFm1IpjZEVSpN+k6KH3n8C7mtIMhpfAl9Acw+SnICYHd9UcPHlc+WhHpTlpK/
 loEhoY6/c+Xq/lTCNIxaf6uS/Wd0Dvl5qO8fxp9FEsnHa9i7bxlBV+vSf2BRxsQgnV10nSfsq80
 ln1/2t7o07KACtHoE/qpuusOqc/0yzQahhc1lrF8aIGFReHlK0aQ/ori0sNJR8tcqyFO7g7C5G6
 YvXSodnC6l7DYGu/MQmxGsE1nflLnyZlRCGNbYEXmsDGOmdUdL7I4Hmk3woTFxia0T/csK0xUkc
 pyDW0lQ5MYzjRuE4poB8ncimEwYSQyhyVn2aXtIrPE63nalFP89UirlQCfgecttXWMx9DQ==
X-Received: by 2002:a17:903:2ca:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2ce9f159a12mr109833655ad.3.1784045213990; Tue, 14 Jul 2026
 09:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260713195313.1739762-1-mario.limonciello@amd.com>
In-Reply-To: <20260713195313.1739762-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 12:06:41 -0400
X-Gm-Features: AUfX_mzxRXeVjkyfKXlK_SVcrCbcntCEv-cBIINuGT_KBKhpPyo9-k1LgVcBS6M
Message-ID: <CADnq5_OBoBLeK+WvSez+A97NvNVDJP6VWocRxezeC5dZ9oLTXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Create a device link between APU display and
 XHCI devices
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Aaron Ma <aaron.ma@canonical.com>,
 mrh@frame.work
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

On Mon, Jul 13, 2026 at 4:19=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some AMD APU multi-function devices expose an integrated USB xHCI
> controller. In some circumstances (such as larger VRAM), the PM core
> can resume can fail when the xHCI controller is resuming in parallel
> with the GPU/display function.
>
> On affected systems, the xHCI controller can complete pci_pm_resume
> and start resuming USB devices while the GPU is still in its much
> longer resume path. This race condition leads to USB device resume
> failures followed by:
>
>   xhci_hcd ...: xHCI host not responding to stop endpoint command
>   xhci_hcd ...: HC died; cleaning up
>
> Create a device link from any xHCI controller sharing the same PCIe
> root port as the APU display function. The link uses DL_FLAG_STATELESS
> and DL_FLAG_PM_RUNTIME to ensure the GPU completes its resume before
> the xHCI controller begins resuming USB devices.
>
> This device link is done specifically in amdgpu so that if the
> platform firmware has been modified such that this issue doesn't happen
> the version can be detected and the workaround skipped.
>
> Suggested-by: Aaron Ma <aaron.ma@canonical.com>
> Reported-by: mrh@frame.work
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 +++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 11 +++++
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 45 +++++++++++++++++++
>  3 files changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 4314dff4ac996..c1ceec7a1986b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1366,6 +1366,14 @@ static void smu_feature_cap_init(struct smu_contex=
t *smu)
>         bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT);
>  }
>
> +static int smu_set_power_dep(struct smu_context *smu, bool enable)
> +{
> +       if (!smu->ppt_funcs->set_power_dep)
> +               return 0;
> +
> +       return smu->ppt_funcs->set_power_dep(smu, enable);
> +}
> +
>  static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -1427,6 +1435,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
>         if (!smu->ppt_funcs->get_fan_control_mode)
>                 smu->adev->pm.no_fan =3D true;
>
> +       smu_set_power_dep(smu, true);
> +
>         return 0;
>  }
>
> @@ -1449,6 +1459,8 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_b=
lock)
>
>         smu_fini_microcode(smu);
>
> +       smu_set_power_dep(smu, false);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f8fd93999617d..7ea7c4a5279be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -749,6 +749,9 @@ struct smu_context {
>         bool pm_enabled;
>         bool is_apu;
>
> +       /* Power dependency link from an integrated xHCI controller to th=
e GPU */
> +       struct device_link              *usb_power_link;
> +
>         uint32_t smc_driver_if_version;
>         uint32_t smc_fw_if_version;
>         uint32_t smc_fw_version;
> @@ -1618,6 +1621,14 @@ struct pptable_funcs {
>          */
>         int (*ras_send_msg)(struct smu_context *smu,
>                             enum smu_message_type msg, uint32_t param, ui=
nt32_t *read_arg);
> +
> +       /**
> +        * @set_power_dep: Create or destroy a power dependency link
> +        * from an integrated xHCI controller to the GPU so that the GPU =
is
> +        * resumed before the USB controller during PM resume. @enable is=
 true
> +        * to create the link and false to tear it down.
> +        */
> +       int (*set_power_dep)(struct smu_context *smu, bool enable);
>  };
>
>  typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a3..2abdfef8644e0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1701,6 +1701,50 @@ static int smu_v14_0_0_restore_user_od_settings(st=
ruct smu_context *smu)
>         return 0;
>  }
>
> +/*
> + * Link any xHCI controller sharing the GPU's PCIe root port as a consum=
er
> + * of the GPU so the GPU resumes first, avoiding an xHCI resume race.
> + */
> +static int smu_v14_0_0_set_power_dep(struct smu_context *smu, bool enabl=
e)
> +{
> +       struct amdgpu_device *adev =3D smu->adev;
> +       struct pci_dev *gpu_pdev =3D adev->pdev;
> +       struct pci_dev *root_port, *usb_pdev =3D NULL;
> +       struct device_link *link;
> +
> +       if (!enable) {
> +               if (smu->usb_power_link) {
> +                       device_link_del(smu->usb_power_link);
> +                       smu->usb_power_link =3D NULL;
> +               }
> +               return 0;
> +       }
> +
> +       root_port =3D pcie_find_root_port(gpu_pdev);
> +       while ((usb_pdev =3D pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, usb=
_pdev))) {
> +               struct pci_dev *usb_root;
> +
> +               usb_root =3D pcie_find_root_port(usb_pdev);
> +               if (usb_root !=3D root_port)
> +                       continue;
> +
> +               /* Create device link: USB (consumer) depends on GPU (sup=
plier) */
> +               link =3D device_link_add(&usb_pdev->dev, &gpu_pdev->dev,
> +                                      DL_FLAG_STATELESS | DL_FLAG_PM_RUN=
TIME);
> +               if (link) {
> +                       smu->usb_power_link =3D link;
> +                       drm_info(adev_to_drm(adev), "USB controller %s D0=
 power state depends on %s\n",
> +                                pci_name(usb_pdev), pci_name(gpu_pdev));
> +                       /* Only create one link for the first USB control=
ler found */
> +                       break;
> +               }
> +       }
> +
> +       pci_dev_put(usb_pdev);
> +
> +       return 0;
> +}
> +
>  static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
>         .check_fw_status =3D smu_v14_0_check_fw_status,
>         .check_fw_version =3D smu_cmn_check_fw_version,
> @@ -1734,6 +1778,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_f=
uncs =3D {
>         .dpm_set_umsch_mm_enable =3D smu_v14_0_0_set_umsch_mm_enable,
>         .get_dpm_clock_table =3D smu_v14_0_common_get_dpm_table,
>         .set_mall_enable =3D smu_v14_0_common_set_mall_enable,
> +       .set_power_dep =3D smu_v14_0_0_set_power_dep,
>  };
>
>  static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
> --
> 2.43.0
>
