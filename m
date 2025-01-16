Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31D9C02187
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 15:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04E610E1E7;
	Thu, 16 Jan 2025 15:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lManEm+7";
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D059510E9A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 15:04:50 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f2f5e91393so225734a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737039890; x=1737644690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKAmwHeJcvm8+LKCQlFEtb5GWBuolrYMJsPobnAQIcE=;
 b=lManEm+78zSBpMTWuVCzE5mdwfchw5nPEctVyPdWHheRo0JTTwtIaICz/buyKWBNil
 61ECAFdplxDZVzdqy1ReAaW5juGucSfh0478/sioLwArtCjaB0t5cK3Iif0YASdDlEMY
 TgNDLWVsbGP09dl25+hGiywvo6Y5iZ+6RHwtF+ZjlQWOrv+YHsFEsC0nS+YyTFyax51T
 MgWcGW4UYUyRb2+dzY+JIf9rkmUj55ofZRlh/PahwoV+MEMt/xqDxu/nJ0B5Wc/vOHHc
 KzxuNOuvzID02ehgQZTRoUVCqlXJKA8+W4I4y1OtkfK6leIz5a3Awcr96FkQQ/UaXJi7
 k3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039890; x=1737644690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKAmwHeJcvm8+LKCQlFEtb5GWBuolrYMJsPobnAQIcE=;
 b=vXtfWujfRxbhoqcnxGtt6TwQykx1A2yJysqjYoIJAbh6OqKG9yJd1xgv6+8il6PmcP
 03LBgaGZXnyoUHEcyR1uyBi+9PFBWfASTN8Q9IrtwziFRd+TPwGMFKQjc7atJLpTCw/c
 FtZpxCEW/gpl0yDId4dtyvJiWmTJ0Dg1XX1VLAv/2DrHukxNRT3tQD+yNhCZzJLBwSme
 EUrcnFtCWAW3rxhyvPNViQqaaxJQ4/rnRL5+086H3OGS+8RLPNXBOtsSphWUQfEsLn12
 n0PvQME1+St4v58CGHWVBwHmSWiw70nQzgOHS3HwoVzc926Kvh/G/9UA+5BpOqi5KmkX
 WVTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtY+fFtLJSLREZjE4qyytwyan7XDlovLUcpW0JdTbzTUFI/XUMfQeiyjaBscaxiVZDMESJLEt@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4SD7zch8+5KLCkr9KtXtgQ+80JCM+nznwc0E5EfQlJjrUgAYA
 181EwMSzFDbQkTVJ2rv4IVcrzTOJhN6YZDAW7TU8njas0QYhkOoH+T0eY2OXbbIDOmQylld4veN
 iPHd4s2k3kRf82RUwroOURwgpf7Q=
X-Gm-Gg: ASbGncu4/OQ7PO88GHuBJamtKnP3tuP1QWbwcCcdnhEQJewnPJ/4WjvipAeJavX3fWf
 5hlu0AUe4Ue4YzJEAFmLm4Dv8pDT2sdlbi25YQw==
X-Google-Smtp-Source: AGHT+IF9Y7mivpNhdSgSLP78ohucqzOGiFoL5pyD25dbVaXlh8b56+nMhgcOWFY/d998bGFkcBGo/Rx/vnnEjQEe91M=
X-Received: by 2002:a17:90a:da88:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2f548f2449fmr17344247a91.4.1737039890199; Thu, 16 Jan 2025
 07:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20250115162820.637642-1-alexander.deucher@amd.com>
 <DS7PR12MB6071331E7301973B4F53604D8E1A2@DS7PR12MB6071.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6071331E7301973B4F53604D8E1A2@DS7PR12MB6071.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 10:04:38 -0500
X-Gm-Features: AbW1kvagH1WQANWqeKOdIwfJiVcWwBpbI5FUQ6tw2lxTcTtaPrboMhN7yUqT8Ys
Message-ID: <CADnq5_NfgXRM0OOeYfDA1P_=0PigKTLwbZz3BwpFjAtgrT3TSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: Add SMUv13.0.12 PMFW headers
To: "Kamal, Asad" <Asad.Kamal@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
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

On Thu, Jan 16, 2025 at 8:02=E2=80=AFAM Kamal, Asad <Asad.Kamal@amd.com> wr=
ote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi @Deucher, Alexander,
>
> Please hold on to this series, we are currently working on a refined vers=
ion, this current series will be dropped.

Sure.  thanks.

Alex

>
> Thanks & Regards
> Asad
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Wednesday, January 15, 2025 9:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kamal, Asad <Asad.Kamal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; D=
eucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: Add SMUv13.0.12 PMFW headers
>
> From: Asad Kamal <asad.kamal@amd.com>
>
> Add pmfw headers for smuv13.0.12 to pmfw version 86.24.0
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 248 ++++++++++++++++++
>  1 file changed, 248 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12=
_pmfw.h
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h=
 b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
> new file mode 100644
> index 0000000000000..859e7a3813bb5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
> @@ -0,0 +1,248 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef SMU_13_0_12_PMFW_H
> +#define SMU_13_0_12_PMFW_H
> +
> +#define NUM_VCLK_DPM_LEVELS   4
> +#define NUM_DCLK_DPM_LEVELS   4
> +#define NUM_SOCCLK_DPM_LEVELS 4
> +#define NUM_LCLK_DPM_LEVELS   4
> +#define NUM_UCLK_DPM_LEVELS   4
> +#define NUM_FCLK_DPM_LEVELS   4
> +#define NUM_XGMI_DPM_LEVELS   2
> +#define NUM_CXL_BITRATES      4
> +#define NUM_PCIE_BITRATES     4
> +#define NUM_XGMI_BITRATES     4
> +#define NUM_XGMI_WIDTHS       3
> +#define NUM_TDP_GROUPS        4
> +#define NUM_SOC_P2S_TABLES    6
> +#define NUM_GFX_P2S_TABLES    8
> +#define NUM_PSM_DIDT_THRESHOLDS 3
> +
> +typedef enum {
> +/*0*/   FEATURE_DATA_CALCULATION            =3D 0,
> +/*1*/   FEATURE_DPM_FCLK                    =3D 1,
> +/*2*/   FEATURE_DPM_GFXCLK                  =3D 2,
> +/*3*/   FEATURE_DPM_LCLK                    =3D 3,
> +/*4*/   FEATURE_DPM_SOCCLK                  =3D 4,
> +/*5*/   FEATURE_DPM_UCLK                    =3D 5,
> +/*6*/   FEATURE_DPM_VCN                     =3D 6,
> +/*7*/   FEATURE_DPM_XGMI                    =3D 7,
> +/*8*/   FEATURE_DS_FCLK                     =3D 8,
> +/*9*/   FEATURE_DS_GFXCLK                   =3D 9,
> +/*10*/  FEATURE_DS_LCLK                     =3D 10,
> +/*11*/  FEATURE_DS_MP0CLK                   =3D 11,
> +/*12*/  FEATURE_DS_MP1CLK                   =3D 12,
> +/*13*/  FEATURE_DS_MPIOCLK                  =3D 13,
> +/*14*/  FEATURE_DS_SOCCLK                   =3D 14,
> +/*15*/  FEATURE_DS_VCN                      =3D 15,
> +/*16*/  FEATURE_APCC_DFLL                   =3D 16,
> +/*17*/  FEATURE_APCC_PLUS                   =3D 17,
> +/*18*/  FEATURE_PPT                         =3D 18,
> +/*19*/  FEATURE_TDC                         =3D 19,
> +/*20*/  FEATURE_THERMAL                     =3D 20,
> +/*21*/  FEATURE_SOC_PCC                     =3D 21,
> +/*22*/  FEATURE_PROCHOT                     =3D 22,
> +/*23*/  FEATURE_FDD_AID_HBM                 =3D 23,
> +/*24*/  FEATURE_FDD_AID_SOC                 =3D 24,
> +/*25*/  FEATURE_FDD_XCD_EDC                 =3D 25,
> +/*26*/  FEATURE_FDD_XCD_XVMIN               =3D 26,
> +/*27*/  FEATURE_FW_CTF                      =3D 27,
> +/*28*/  FEATURE_SMU_CG                      =3D 28,
> +/*29*/  FEATURE_PSI7                        =3D 29,
> +/*30*/  FEATURE_XGMI_PER_LINK_PWR_DOWN      =3D 30,
> +/*31*/  FEATURE_SOC_DC_RTC                  =3D 31,
> +/*32*/  FEATURE_GFX_DC_RTC                  =3D 32,
> +/*33*/  FEATURE_DVM_MIN_PSM                 =3D 33,
> +/*34*/  FEATURE_PRC                         =3D 34,
> +/*35*/  FEATURE_PSM_SQ_THROTTLER            =3D 35,
> +/*36*/  FEATURE_PIT                         =3D 36,
> +/*37*/  FEATURE_DVO                         =3D 37,
> +/*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       =3D 38,
> +
> +/*39*/  NUM_FEATURES                        =3D 39
> +} FEATURE_LIST_e;
> +
> +//enum for MPIO PCIe gen speed msgs
> +typedef enum {
> +  PCIE_LINK_SPEED_INDEX_TABLE_GEN1,
> +  PCIE_LINK_SPEED_INDEX_TABLE_GEN2,
> +  PCIE_LINK_SPEED_INDEX_TABLE_GEN3,
> +  PCIE_LINK_SPEED_INDEX_TABLE_GEN4,
> +  PCIE_LINK_SPEED_INDEX_TABLE_GEN4_ESM,
> +  PCIE_LINK_SPEED_INDEX_TABLE_GEN5,
> +  PCIE_LINK_SPEED_INDEX_TABLE_COUNT
> +} PCIE_LINK_SPEED_INDEX_TABLE_e;
> +
> +typedef enum {
> +  GFX_GUARDBAND_OFFSET_0,
> +  GFX_GUARDBAND_OFFSET_1,
> +  GFX_GUARDBAND_OFFSET_2,
> +  GFX_GUARDBAND_OFFSET_3,
> +  GFX_GUARDBAND_OFFSET_4,
> +  GFX_GUARDBAND_OFFSET_5,
> +  GFX_GUARDBAND_OFFSET_6,
> +  GFX_GUARDBAND_OFFSET_7,
> +  GFX_GUARDBAND_OFFSET_COUNT
> +} GFX_GUARDBAND_OFFSET_e;
> +
> +typedef enum {
> +  GFX_DVM_MARGINHI_0,
> +  GFX_DVM_MARGINHI_1,
> +  GFX_DVM_MARGINHI_2,
> +  GFX_DVM_MARGINHI_3,
> +  GFX_DVM_MARGINHI_4,
> +  GFX_DVM_MARGINHI_5,
> +  GFX_DVM_MARGINHI_6,
> +  GFX_DVM_MARGINHI_7,
> +  GFX_DVM_MARGINLO_0,
> +  GFX_DVM_MARGINLO_1,
> +  GFX_DVM_MARGINLO_2,
> +  GFX_DVM_MARGINLO_3,
> +  GFX_DVM_MARGINLO_4,
> +  GFX_DVM_MARGINLO_5,
> +  GFX_DVM_MARGINLO_6,
> +  GFX_DVM_MARGINLO_7,
> +  GFX_DVM_MARGIN_COUNT
> +} GFX_DVM_MARGIN_e;
> +
> +#define SMU_METRICS_TABLE_VERSION 0xF
> +
> +typedef struct __attribute__((packed, aligned(4))) {
> +  uint64_t AccumulationCounter;
> +
> +  //TEMPERATURE
> +  uint32_t MaxSocketTemperature;
> +  uint32_t MaxVrTemperature;
> +  uint32_t MaxHbmTemperature;
> +  uint64_t MaxSocketTemperatureAcc;
> +  uint64_t MaxVrTemperatureAcc;
> +  uint64_t MaxHbmTemperatureAcc;
> +
> +  //POWER
> +  uint32_t SocketPowerLimit;
> +  uint32_t MaxSocketPowerLimit;
> +  uint32_t SocketPower;
> +
> +  //ENERGY
> +  uint64_t Timestamp;
> +  uint64_t SocketEnergyAcc;
> +  uint64_t CcdEnergyAcc;
> +  uint64_t XcdEnergyAcc;
> +  uint64_t AidEnergyAcc;
> +  uint64_t HbmEnergyAcc;
> +
> +  //FREQUENCY
> +  uint32_t GfxclkFrequencyLimit;
> +  uint32_t FclkFrequency;
> +  uint32_t UclkFrequency;
> +  uint32_t SocclkFrequency[4];
> +  uint32_t VclkFrequency[4];
> +  uint32_t DclkFrequency[4];
> +  uint32_t LclkFrequency[4];
> +  uint64_t GfxclkFrequencyAcc[8];
> +
> +  //FREQUENCY RANGE
> +  uint32_t MaxGfxclkFrequency;
> +  uint32_t MinGfxclkFrequency;
> +  uint32_t FclkFrequencyTable[4];
> +  uint32_t UclkFrequencyTable[4];
> +  uint32_t SocclkFrequencyTable[4];
> +  uint32_t VclkFrequencyTable[4];
> +  uint32_t DclkFrequencyTable[4];
> +  uint32_t LclkFrequencyTable[4];
> +  uint32_t MaxLclkDpmRange;
> +  uint32_t MinLclkDpmRange;
> +
> +  //XGMI
> +  uint32_t XgmiWidth;
> +  uint32_t XgmiBitrate;
> +  uint64_t XgmiReadBandwidthAcc[8];
> +  uint64_t XgmiWriteBandwidthAcc[8];
> +
> +  //ACTIVITY
> +  uint32_t SocketGfxBusy;
> +  uint32_t DramBandwidthUtilization;
> +  uint64_t SocketC0ResidencyAcc;
> +  uint64_t SocketGfxBusyAcc;
> +  uint64_t DramBandwidthAcc;
> +  uint32_t MaxDramBandwidth;
> +  uint64_t DramBandwidthUtilizationAcc;  uint64_t PcieBandwidthAcc[4];
> +
> +  //THROTTLERS
> +  uint32_t ProchotResidencyAcc;
> +  uint32_t PptResidencyAcc;
> +  uint32_t SocketThmResidencyAcc;
> +  uint32_t VrThmResidencyAcc;
> +  uint32_t HbmThmResidencyAcc;
> +  uint32_t GfxLockXCDMak;
> +
> +  // New Items at end to maintain driver compatibility  uint32_t
> + GfxclkFrequency[8];
> +
> +  //PSNs
> +  uint64_t PublicSerialNumber_AID[4];
> +  uint64_t PublicSerialNumber_XCD[8];
> +
> +  //XGMI Data tranfser size
> +  uint64_t XgmiReadDataSizeAcc[8];//in KByte  uint64_t
> + XgmiWriteDataSizeAcc[8];//in KByte
> +
> +  //PCIE BW Data and error count
> +  uint32_t PcieBandwidth[4];
> +  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is =
accumulated
> +  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is =
accumulated
> +  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is =
accumulated
> +  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is =
accumulated
> +  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is =
accumulated
> +
> +  // VCN/JPEG ACTIVITY
> +  uint32_t VcnBusy[4];
> +  uint32_t JpegBusy[32];
> +
> +  // PCIE LINK Speed and width
> +  uint32_t PCIeLinkSpeed;
> +  uint32_t PCIeLinkWidth;
> +
> +  // PER XCD ACTIVITY
> +  uint32_t GfxBusy[8];
> +  uint64_t GfxBusyAcc[8];
> +
> +  //PCIE BW Data and error count
> +  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is =
accumulated
> +
> +  //Total App Clock Counter
> +  uint64_t GfxclkBelowHostLimitAcc[8];
> +} MetricsTable_t;
> +
> +#define SMU_VF_METRICS_TABLE_VERSION 0x3
> +
> +typedef struct __attribute__((packed, aligned(4))) {
> +  uint32_t AccumulationCounter;
> +  uint32_t InstGfxclk_TargFreq;
> +  uint64_t AccGfxclk_TargFreq;
> +  uint64_t AccGfxRsmuDpm_Busy;
> +} VfMetricsTable_t;
> +
> +#endif
> --
> 2.47.1
>
