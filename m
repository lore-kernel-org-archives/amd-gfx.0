Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB47C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C13206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="18FbAoJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C13206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F4589BB3;
	Fri, 27 Mar 2020 13:51:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01EC89BB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsH9Ux4ccF8Z67o/jkTZR7eoln2iqDGHkhpahatI4/wn9dWrTXEMxDy6RgFf25n9N1FqPa4AqQZlCHOIJ6dzTQswQpeo9dIt6Zvz/I7zb3LNiM8ym8ZSZVC0TERLbBFlSswvJycysHXIlj6gaLmBlTDPDuT40jEJB8zm5gZPb70EWrFNw7cyy9Qk57x6NAEKA7992jh3CK3dUO0IvWq2d3xoV5o5yXZp38m68QfBpxkQl1C4QPUx5n2fN5T/2IdAuERaJ6KrQKOWzSeZrT7oo2U3uDyTEm8m+QGFrg0AFtkOJgPgw9JorZgxskFazi3WjeCApvFXL3ldYVsKKcUa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLDPM89e3Xz6CvahELYtY5Hw/G5JW3Ggjl1qW3F2aEw=;
 b=mED0fDlxmzlHRjfs8I76PtjGm2TXZSZmtnQzbfZgoLtRD4EGKHpH0d8aiPphhrkiSaJRpolyalvi9NCN/9Wk2a5M2AOgJkYStKPvEKOTUmfokAIeTp6xS8iIFmrEenD4ax13JAhrMxPJGcaVSs14SolcmSiw6q4knefm6EhnIXPuRx9Lqp/zzHsnhXJK0UY/HWqAhPPAlXDpr5JeZ8dPOb6cCnF2ECeLKBWBXnTIgE1Ml/sdvox8xjtCJALU8RwRZuWQ89npjgCVZac2JcaTarLpTs+hjivYR5lqeQnE/X32DeOCU7cA26eezxoIppT7O3ilz16ANQz+qvJ0Nq/G4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLDPM89e3Xz6CvahELYtY5Hw/G5JW3Ggjl1qW3F2aEw=;
 b=18FbAoJGadMoQrNw5Ipl4nldDFVUoeh4eEMq81IxlSDXTsKSi6eSy2uwLye04hRKudVrHWWEeFDZIZbt9qFt7S+djxFXTaOTkry3Qv38iyWJC2ksw0QXtFKTx+YhaaDnSMDZGyESteLDWFap8+1x7sdwyMHMtWwUQAdYr21rOnQ=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 13:51:13 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::d93f:b1ab:5d38:f931]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::d93f:b1ab:5d38:f931%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 13:51:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Include headers for PWR and SMUIO
 registers
Thread-Topic: [PATCH] drm/amd/amdgpu: Include headers for PWR and SMUIO
 registers
Thread-Index: AQHWBD4GpADZEQTeSkKBAaYoucF5+KhcdP9J
Date: Fri, 27 Mar 2020 13:51:13 +0000
Message-ID: <MW3PR12MB44910D2AFF06891669167D57F7CC0@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20200327134428.820160-1-tom.stdenis@amd.com>
In-Reply-To: <20200327134428.820160-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-27T13:51:12.891Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bebd331-e428-40f6-ac59-08d7d255ea0b
x-ms-traffictypediagnostic: MW3PR12MB4396:|MW3PR12MB4396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4396BFC9A7C13AE5DDA7F2AEF7CC0@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(81156014)(186003)(86362001)(52536014)(5660300002)(110136005)(26005)(81166006)(8676002)(6506007)(53546011)(2906002)(7696005)(66476007)(66446008)(19627405001)(66556008)(966005)(66946007)(55016002)(8936002)(64756008)(316002)(71200400001)(478600001)(76116006)(33656002)(45080400002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW3PR12MB4396;
 H:MW3PR12MB4491.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/A+/t+y6wP1VJE5fYlEdWkHdopPHylIoP9p0Vs7TirdAoovLJe9c5YJdEWBtl2TjTw6GWSmQGCxVCOm184vEoZ/WImQkCvIEwEpTYm6BMgHwPiPMaIkFd3cOcOLSZoXoPEJAVZevBpXnNfbY4iWTZ9UTFkmijp0KiuuUX9ArvjczN8MLVMNPflzBWL1anZ3vAtvdQVbGblJnxWwN4kR/B+KZu/8vNoiCer+h9AaPQRTiI5wBLoGvb8E5VCDRfuAOnjAKudRQQZlKxUcvsyViirqlM6DfXBMnueyjwqHjAhyO//nEC5MZbKlXYkgl6FBCPxxYcfo13VceDjP/PzZm9ebRMK0w5aXfagkwP3j3UuJJlTOosnxWaB7r6o/sqU3PdOc5hYg+lO4vrHdw4RvE0OQ2rHlcKt4LsCHVPQxU7AON2Ih6ZtWsia1G+TbEs/BHCqAILvka9+UHObCeOndZKN1hlCVrDsuGzFlRRnR8Jw=
x-ms-exchange-antispam-messagedata: eOJfNNrEvxEXZXefaJfo8uyCcG0hwsoouAyaacFmd+hNTzEefyc/C5q64Cio3OCSiDmp99PX3gN46nd3shBniq80Kl/g6v7NYtcVbAAT/Yn/BEQHbPWC4MBj+2PGaGlwE7IbtP/kRaNQVIusdUoOUQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bebd331-e428-40f6-ac59-08d7d255ea0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 13:51:13.5188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TArbbzKk/BTmP4N17AGXDGf9CKith0QgAfNelk1/hs1Ov0IqjubT7uS80FI1fvd02Wdv+iTqHau7xXfKGGTwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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
Content-Type: multipart/mixed; boundary="===============0343518870=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0343518870==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB44910D2AFF06891669167D57F7CC0MW3PR12MB4491namp_"

--_000_MW3PR12MB44910D2AFF06891669167D57F7CC0MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Friday, March 27, 2020 9:44 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Include headers for PWR and SMUIO register=
s

Clean up the smu10, smu12, and gfx9 drivers to use headers for
registers instead of hardcoding in the C source files.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 10 +++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  9 ++-------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c         | 12 +++++++-----
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 7d98dc1d452e..619dc0f8071f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -50,18 +50,14 @@

 #include "gfx_v9_4.h"

+#include "asic_reg/pwr/pwr_10_0_offset.h"
+#include "asic_reg/pwr/pwr_10_0_sh_mask.h"
+
 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L

-#define mmPWR_MISC_CNTL_STATUS                                 0x0183
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                0
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT       0x0
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT         0x1
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK         0x00000001L
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK           0x00000006L
-
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 689072a312a7..69afdd24a0f0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -36,6 +36,8 @@
 #include "power_state.h"
 #include "soc15_common.h"
 #include "smu10.h"
+#include "asic_reg/pwr/pwr_10_0_offset.h"
+#include "asic_reg/pwr/pwr_10_0_sh_mask.h"

 #define SMU10_MAX_DEEPSLEEP_DIVIDER_ID     5
 #define SMU10_MINIMUM_ENGINE_CLOCK         800   /* 8Mhz, the low boundary=
 of engine clock allowed on this chip */
@@ -43,13 +45,6 @@
 #define SMU10_DISPCLK_BYPASS_THRESHOLD     10000 /* 100Mhz */
 #define SMC_RAM_END                     0x40000

-#define mmPWR_MISC_CNTL_STATUS                                 0x0183
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                0
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT       0x0
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT         0x1
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK         0x00000001L
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK           0x00000006L
-
 static const unsigned long SMU10_Magic =3D (unsigned long) PHM_Rv_Magic;


diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c
index 169ebdad87b8..4fc68d4600e0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -32,13 +32,15 @@

 #include "asic_reg/mp/mp_12_0_0_offset.h"
 #include "asic_reg/mp/mp_12_0_0_sh_mask.h"
+#include "asic_reg/smuio/smuio_12_0_0_offset.h"
+#include "asic_reg/smuio/smuio_12_0_0_sh_mask.h"

-#define smnMP1_FIRMWARE_FLAGS                                0x3010024
+// because some SMU12 based ASICs use older ip offset tables
+// we should undefine this register from the smuio12 header
+// to prevent confusion down the road
+#undef mmPWR_MISC_CNTL_STATUS

-#define mmSMUIO_GFX_MISC_CNTL                                0x00c8
-#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                       0
-#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK          0x00000006L
-#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT        0x1
+#define smnMP1_FIRMWARE_FLAGS                                0x3010024

 int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
                                               uint16_t msg)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C63d58f7ec8114ef86c9108d7d254ff6b%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637209135495314070&amp;sdata=3DitPgDOvpUPrdr5IwY0H=
tIb5McGA7v%2Bim7d4XeGJ5%2BiQ%3D&amp;reserved=3D0

--_000_MW3PR12MB44910D2AFF06891669167D57F7CC0MW3PR12MB4491namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Friday, March 27, 2020 9:44 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Include headers for PWR and SMUIO r=
egisters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Clean up the smu10, smu12, and gfx9 drivers to use=
 headers for<br>
registers instead of hardcoding in the C source files.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 &#43;&#43;&#43;-------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |&nbsp; 9 &#43;&#43=
;-------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; | 12 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;3 files changed, 12 insertions(&#43;), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 7d98dc1d452e..619dc0f8071f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -50,18 &#43;50,14 @@<br>
&nbsp;<br>
&nbsp;#include &quot;gfx_v9_4.h&quot;<br>
&nbsp;<br>
&#43;#include &quot;asic_reg/pwr/pwr_10_0_offset.h&quot;<br>
&#43;#include &quot;asic_reg/pwr/pwr_10_0_sh_mask.h&quot;<br>
&#43;<br>
&nbsp;#define GFX9_NUM_GFX_RINGS&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&nbsp;#define GFX9_MEC_HPD_SIZE 4096<br>
&nbsp;#define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L<br>
&nbsp;#define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L<br>
&nbsp;<br>
-#define mmPWR_MISC_CNTL_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x0183<br>
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
-<br>
&nbsp;#define mmGCEA_PROBE_MAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x070c<br>
&nbsp;#define mmGCEA_PROBE_MAP_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index 689072a312a7..69afdd24a0f0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -36,6 &#43;36,8 @@<br>
&nbsp;#include &quot;power_state.h&quot;<br>
&nbsp;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;smu10.h&quot;<br>
&#43;#include &quot;asic_reg/pwr/pwr_10_0_offset.h&quot;<br>
&#43;#include &quot;asic_reg/pwr/pwr_10_0_sh_mask.h&quot;<br>
&nbsp;<br>
&nbsp;#define SMU10_MAX_DEEPSLEEP_DIVIDER_ID&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
&nbsp;#define SMU10_MINIMUM_ENGINE_CLOCK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 800&nbsp;&nbsp; /* 8Mhz, the low boundary of engine clock all=
owed on this chip */<br>
@@ -43,13 &#43;45,6 @@<br>
&nbsp;#define SMU10_DISPCLK_BYPASS_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp; 10000 =
/* 100Mhz */<br>
&nbsp;#define SMC_RAM_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40=
000<br>
&nbsp;<br>
-#define mmPWR_MISC_CNTL_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x0183<br>
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
-<br>
&nbsp;static const unsigned long SMU10_Magic =3D (unsigned long) PHM_Rv_Mag=
ic;<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c<br>
index 169ebdad87b8..4fc68d4600e0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
@@ -32,13 &#43;32,15 @@<br>
&nbsp;<br>
&nbsp;#include &quot;asic_reg/mp/mp_12_0_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_12_0_0_sh_mask.h&quot;<br>
&#43;#include &quot;asic_reg/smuio/smuio_12_0_0_offset.h&quot;<br>
&#43;#include &quot;asic_reg/smuio/smuio_12_0_0_sh_mask.h&quot;<br>
&nbsp;<br>
-#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x301002=
4<br>
&#43;// because some SMU12 based ASICs use older ip offset tables<br>
&#43;// we should undefine this register from the smuio12 header<br>
&#43;// to prevent confusion down the road<br>
&#43;#undef mmPWR_MISC_CNTL_STATUS<br>
&nbsp;<br>
-#define mmSMUIO_GFX_MISC_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00c8<b=
r>
-#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0<br>
-#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
-#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x1<br>
&#43;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x30=
10024<br>
&nbsp;<br>
&nbsp;int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg)<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C63d58f7ec8114ef86c9108d7d254ff6b%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637209135495314070&amp;amp;sdata=3D=
itPgDOvpUPrdr5IwY0HtIb5McGA7v%2Bim7d4XeGJ5%2BiQ%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C63d58f7ec8114ef86c9108d7d254ff6b%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637209135495314070&amp;amp;sdata=3DitPgDOvpUPrdr=
5IwY0HtIb5McGA7v%2Bim7d4XeGJ5%2BiQ%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44910D2AFF06891669167D57F7CC0MW3PR12MB4491namp_--

--===============0343518870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0343518870==--
