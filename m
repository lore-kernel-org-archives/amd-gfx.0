Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98651C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552F12146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IFbtTzgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552F12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023826EA2C;
	Tue, 17 Dec 2019 15:12:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55D16EA2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 15:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obBk+5w4EGBIEWtKAuntV6CCC5l983zVIOVD8iNeZuc/ncqiJeSRoA+B2ufAfHx6rDHmCs9kPkBGQJeGMwj4bnBwQWk8vXK8HRipC+K2lCwTHMT6LYbfXDpaM0uxmdNHGgHhiSmlTKQThqs1gAiHnqNDqpVP4MNps8Z/RkITTzCYPGNoeEO5Hmbo/MGp2BMCzPoJkLndfNAHB0n2Y2V3v84FjVXLn949MDdA+P/lA6nIdVJyRtC6khpS3ewLaSrcJTO5j9LYaCHjS/aQhu0i/Ec3LuvBp51yuqdq/YeYvQ2AV7RCyVyn83FrYA/3t2V9Sq7VzhO8EhP0t9Tg3GSWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehaxWuxnSO+7TtCIfjkrkd4H3lJLV1/aepvmneYM0xg=;
 b=aoBki3Mtj0Ibfjh742VrRkTPMNLgoHfE7yaCdcdWHqJGLcqHuRbGC1nRvEgYVshn8PB+9D3vGcZHzkaLCxubcjqsqaY65eavJKCHKDVzhgmf5UL1HUoxDyFQkG0rKUPUuxPVZDIASrfGHrN+2irNpoCh4/jh83YEi4/XPELDn2pfGYDUh9lH/ApMVY9r9r8b1SuCzdm3FXdTN4VGr3f+Y7HlycFp5IR5/A9JSR+6/km8ACcoFeQ0TuJVfesrRKyIcqklmZXv3a6nZXBTcMi4d4cD+XJ3j8Cci6gClBsS7GPV+jbuEbA4eohrlCxwqiMVCU1PUvuOJkENCkfxliHOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehaxWuxnSO+7TtCIfjkrkd4H3lJLV1/aepvmneYM0xg=;
 b=IFbtTzgGAPFoL8IpSMzHrnspRVFVyuV3FN1ZE9bpntc2lVy8nzbGTvXnhuyCGj6wLv1e8Tc3BEzRGpeVgLOoEZEX9g5uUqqksEM05X3uahajMNATyjfsb2f6llRTnTpMHSAEAOw8WHlh6S5e1cUdKJXJe33BEzkW4kHiXoNgffw=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1871.namprd12.prod.outlook.com (10.175.51.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 15:12:43 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 15:12:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: move umc offset to one new header file for
 Arcturus
Thread-Topic: [PATCH] drm/amdgpu: move umc offset to one new header file for
 Arcturus
Thread-Index: AQHVtLnMh6537mJ0Vk6GnYgH6BiDyae+b0oQ
Date: Tue, 17 Dec 2019 15:12:43 +0000
Message-ID: <MWHPR12MB1358FE650C5B2786AAE18A8EF7500@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191217090817.12427-1-guchun.chen@amd.com>
In-Reply-To: <20191217090817.12427-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T15:12:42.764Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16a1506d-fe81-4116-861f-08d7830390e5
x-ms-traffictypediagnostic: MWHPR12MB1871:|MWHPR12MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB18711A0925DA90BC30F7B9D8F7500@MWHPR12MB1871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(186003)(8676002)(316002)(71200400001)(9686003)(110136005)(19627405001)(7696005)(81166006)(52536014)(53546011)(81156014)(6506007)(478600001)(66446008)(76116006)(64756008)(66556008)(8936002)(66476007)(5660300002)(66946007)(33656002)(2906002)(26005)(55016002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1871;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/bTB3ezWr9SaK4N0FwLB5zcNJSguZ43l7FFGPLp4f7MTDcJq4P/qHGyLwYk1ts+66SwQWse58lmn9W/D9+7uE4d6mxKCluYUUtElmeF+LmOuBqbe5fzoJGfuzOEtgAbXFq0CgojfPwcyamh+uJuF2/prB6OII/AmCX29TL67VODSfwx/Maq2AJQCk1AGuDHduIrif9mHMogyujadOw2rFbL88q19YIdHAlgraW6M1N9LY6A/dF79c5q65e1FvHjI1l8e0ISECNUCjxSaxRurl13LJXGjzcSoKHMLTXVzWooWBPQ7deLCeJz5foDnBoynzER0xyqCbrgglbkFJFGB8jINuX0ZTpaYplmkipOiwfo79WJatuwgZBoGJqm5JLMrkXtDBx+4hIJJNOoh5mSdtrmuuLV2Wmf/DwE3ZZGrZ3tbrthv+x/oKUEb1VL5bae
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a1506d-fe81-4116-861f-08d7830390e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 15:12:43.4046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHR2wnJneh10g2ZJE0dy4XpUF+2+F9dFT7sYiYnB5T/5Wa7Qe1aQu3xwg0C3RGatBIQtnKWwZXbnJngyVPXh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1871
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
Content-Type: multipart/mixed; boundary="===============0002894522=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0002894522==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1358FE650C5B2786AAE18A8EF7500MWHPR12MB1358namp_"

--_000_MWHPR12MB1358FE650C5B2786AAE18A8EF7500MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, December 17, 2019 4:08 AM
To: Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.free=
desktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: move umc offset to one new header file for Arc=
turus

Fixes: 9686563c4c42 drm/amdgpu: Added RAS UMC error query support for Arctu=
rus

Code refactor and no functional change.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c         | 17 +---------
 .../include/asic_reg/umc/umc_6_1_2_offset.h   | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offs=
et.h

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.c
index 515eb50cd0f8..5093965dbc24 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -28,17 +28,10 @@
 #include "rsmu/rsmu_0_0_2_sh_mask.h"
 #include "umc/umc_6_1_1_offset.h"
 #include "umc/umc_6_1_1_sh_mask.h"
+#include "umc/umc_6_1_2_offset.h"

 #define smnMCA_UMC0_MCUMC_ADDRT0        0x50f10

-/* UMC 6_1_2 register offsets */
-#define mmUMCCH0_0_EccErrCntSel_ARCT                 0x0360
-#define mmUMCCH0_0_EccErrCntSel_ARCT_BASE_IDX        1
-#define mmUMCCH0_0_EccErrCnt_ARCT                    0x0361
-#define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX           1
-#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT           0x03c2
-#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX  1
-
 /*
  * (addr / 256) * 8192, the higher 26 bits in ErrorAddr
  * is the index of 8KB block
@@ -105,7 +98,6 @@ static void umc_v6_1_query_correctable_error_count(struc=
t amdgpu_device *adev,

         if (adev->asic_type =3D=3D CHIP_ARCTURUS) {
                 /* UMC 6_1_2 registers */
-
                 ecc_err_cnt_sel_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel_A=
RCT);
                 ecc_err_cnt_addr =3D
@@ -114,7 +106,6 @@ static void umc_v6_1_query_correctable_error_count(stru=
ct amdgpu_device *adev,
                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STAT=
UST0_ARCT);
         } else {
                 /* UMC 6_1_1 registers */
-
                 ecc_err_cnt_sel_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel);
                 ecc_err_cnt_addr =3D
@@ -164,12 +155,10 @@ static void umc_v6_1_querry_uncorrectable_error_count=
(struct amdgpu_device *adev

         if (adev->asic_type =3D=3D CHIP_ARCTURUS) {
                 /* UMC 6_1_2 registers */
-
                 mc_umc_status_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STAT=
UST0_ARCT);
         } else {
                 /* UMC 6_1_1 registers */
-
                 mc_umc_status_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STAT=
UST0);
         }
@@ -211,12 +200,10 @@ static void umc_v6_1_query_error_address(struct amdgp=
u_device *adev,

         if (adev->asic_type =3D=3D CHIP_ARCTURUS) {
                 /* UMC 6_1_2 registers */
-
                 mc_umc_status_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STAT=
UST0_ARCT);
         } else {
                 /* UMC 6_1_1 registers */
-
                 mc_umc_status_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STAT=
UST0);
         }
@@ -282,14 +269,12 @@ static void umc_v6_1_err_cnt_init_per_channel(struct =
amdgpu_device *adev,

         if (adev->asic_type =3D=3D CHIP_ARCTURUS) {
                 /* UMC 6_1_2 registers */
-
                 ecc_err_cnt_sel_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel_A=
RCT);
                 ecc_err_cnt_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCnt_ARCT=
);
         } else {
                 /* UMC 6_1_1 registers */
-
                 ecc_err_cnt_sel_addr =3D
                         SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel);
                 ecc_err_cnt_addr =3D
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
new file mode 100644
index 000000000000..3e79a8056556
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2019  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABI=
LITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWA=
RE.
+ */
+#ifndef _umc_6_1_2_OFFSET_HEADER
+#define _umc_6_1_2_OFFSET_HEADER
+
+#define mmUMCCH0_0_EccErrCntSel_ARCT                                     0=
x0360
+#define mmUMCCH0_0_EccErrCntSel_ARCT_BASE_IDX                            1
+#define mmUMCCH0_0_EccErrCnt_ARCT                                        0=
x0361
+#define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX                               1
+#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT                               0=
x03c2
+#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX                      1
+
+#endif
+
--
2.17.1


--_000_MWHPR12MB1358FE650C5B2786AAE18A8EF7500MWHPR12MB1358namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 17, 2019 4:08 AM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; Zhang, Hawking &lt=
;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<=
br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: move umc offset to one new header file =
for Arcturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: 9686563c4c42 drm/amdgpu: Added RAS UMC erro=
r query support for Arcturus<br>
<br>
Code refactor and no functional change.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 17 &#43;---------<br>
&nbsp;.../include/asic_reg/umc/umc_6_1_2_offset.h&nbsp;&nbsp; | 32 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;<br>
&nbsp;2 files changed, 33 insertions(&#43;), 16 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2=
_offset.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.c<br>
index 515eb50cd0f8..5093965dbc24 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c<br>
@@ -28,17 &#43;28,10 @@<br>
&nbsp;#include &quot;rsmu/rsmu_0_0_2_sh_mask.h&quot;<br>
&nbsp;#include &quot;umc/umc_6_1_1_offset.h&quot;<br>
&nbsp;#include &quot;umc/umc_6_1_1_sh_mask.h&quot;<br>
&#43;#include &quot;umc/umc_6_1_2_offset.h&quot;<br>
&nbsp;<br>
&nbsp;#define smnMCA_UMC0_MCUMC_ADDRT0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x50f10<br>
&nbsp;<br>
-/* UMC 6_1_2 register offsets */<br>
-#define mmUMCCH0_0_EccErrCntSel_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0360<br>
-#define mmUMCCH0_0_EccErrCntSel_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 1<br>
-#define mmUMCCH0_0_EccErrCnt_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x0361<br>
-#define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
-#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03c2<br>
-#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX&nbsp; 1<br>
-<br>
&nbsp;/*<br>
&nbsp; * (addr / 256) * 8192, the higher 26 bits in ErrorAddr<br>
&nbsp; * is the index of 8KB block<br>
@@ -105,7 &#43;98,6 @@ static void umc_v6_1_query_correctable_error_count(s=
truct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_ARCTURUS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_2 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_sel_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_addr =3D<br>
@@ -114,7 &#43;106,6 @@ static void umc_v6_1_query_correctable_error_count(=
struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_1 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_sel_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_addr =3D<br>
@@ -164,12 &#43;155,10 @@ static void umc_v6_1_querry_uncorrectable_error_c=
ount(struct amdgpu_device *adev<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_ARCTURUS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_2 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mc_umc_status_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_1 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mc_umc_status_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -211,12 &#43;200,10 @@ static void umc_v6_1_query_error_address(struct a=
mdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_ARCTURUS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_2 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mc_umc_status_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_1 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mc_umc_status_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -282,14 &#43;269,12 @@ static void umc_v6_1_err_cnt_init_per_channel(str=
uct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_ARCTURUS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_2 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_sel_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCnt_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* UMC 6_1_1 registers */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_sel_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ecc_err_cnt_addr =3D<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h<br>
new file mode 100644<br>
index 000000000000..3e79a8056556<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset=
.h<br>
@@ -0,0 &#43;1,32 @@<br>
&#43;/*<br>
&#43; * Copyright (C) 2019&nbsp; Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded<br>
&#43; * in all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS<br>
&#43; * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER L=
IABILITY, WHETHER IN<br>
&#43; * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR I=
N<br>
&#43; * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SO=
FTWARE.<br>
&#43; */<br>
&#43;#ifndef _umc_6_1_2_OFFSET_HEADER<br>
&#43;#define _umc_6_1_2_OFFSET_HEADER<br>
&#43;<br>
&#43;#define mmUMCCH0_0_EccErrCntSel_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0360<br>
&#43;#define mmUMCCH0_0_EccErrCntSel_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&#43;#define mmUMCCH0_0_EccErrCnt_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0361<br>
&#43;#define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1<br>
&#43;#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x03c2<br>
&#43;#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&#43;<br>
&#43;#endif<br>
&#43;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB1358FE650C5B2786AAE18A8EF7500MWHPR12MB1358namp_--

--===============0002894522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0002894522==--
