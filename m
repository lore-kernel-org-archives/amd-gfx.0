Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E76C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 17:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874DB2087C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 17:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CY2vIjGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874DB2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A016E409;
	Thu, 27 Aug 2020 17:19:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D3D6E409
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 17:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNIrkra/XLv7RZKXN66ljzdzz8Cm6F6kfQvO25uAp6gDZyIlaCxrnwsB/XMeyKvveNqAWhZY92Xs1EGkTwQaLK+Ujs3IanTz37sh4/IAwKPevRpIFxLXmfXSk2sE5Tt/q7Gs3D/83YQFtPQgNl5R6iBHyZGE94SADsTPU1/LyuJ9z0s+A14OAFCVb7gCvoMNoAO1N91gV9Hmh2ti/Rto94QyEcfgc7YBk+gQ2ZW7IB1w5KzY04+8XNmYW/kJcqku9J89+UBVCZUrUEGmPXOsxyT0xtkcqdryUZITYrWj1c8rEuFfGVa6HZoi2F9XBVGcwtb246w5onb+0Fg6q6gr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmnsO117J0t5Pr83m7tk9imZ00vas1MspKU/05xL/WM=;
 b=H+KPRNlCofM6JKNj0wszCgR7pcuRcYLk8O9VjrUnblAvcuMfPzs5PfYRNQV1eSxLgjhxOL8GcDJpk3Um2sguEFVa2eFxpnjq+gXVBIg49VzHPNZUCYbpUfDZdIr8OewPW21E+E5zUdDvgBZZ5eYQPPL/q3u6716/1wz8MIkgV3hLSvWSYGr1BjOjtwIbdbMu3kH3fo/vww4au9BKFcS75fbiZyXJfbbB9A+BhQuEPJ1ctlxJqS3pPQAO0+J/CbRSdGkkEpknP35b/PnLcKrx3Z2129DksEgOpKuVI4FoaBUss/kp378clHAcvgTkqXlHIX3DdIjckNUIU6pbdIUw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmnsO117J0t5Pr83m7tk9imZ00vas1MspKU/05xL/WM=;
 b=CY2vIjGbjTQKDJYmndbb/wEjr3hWVecLxPtAdkRO+c5842sYZPVKBL8BEiUe1qRUqBzUv/mIv3T4RU43xDJDc4IZcoJpjX+xkTIo1mukLUQF79IPct+tcBQ8vSNv0kuVkeB7LDcErbxBqJ4nR6ahDGMiZ/Yz80lPihImc5a7C4E=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 27 Aug
 2020 17:19:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 17:19:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix compiler warnings
Thread-Topic: [PATCH 1/1] drm/amdgpu: fix compiler warnings
Thread-Index: AQHWfIpa1GOuYB7Vlku2U+KRJk37vqlMMz9n
Date: Thu, 27 Aug 2020 17:19:16 +0000
Message-ID: <MN2PR12MB448898827FF2DDC2D1A5ABDAF7550@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200827155824.123589-1-nirmoy.das@amd.com>
In-Reply-To: <20200827155824.123589-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T17:19:16.138Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.203.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae0fd805-08f1-4258-4806-08d84aad53b5
x-ms-traffictypediagnostic: BL0PR12MB2403:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2403C967AB5981EF7FC5A8C2F7550@BL0PR12MB2403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTOdJP9Nix2P4HErztoK/4Gew5YN2dvBqfp5itw3wAF7Z6jdLVi6ljgvAwNULWu044ulP8bk64CTjXwqR2D0mozeZqAmrEoMmLrl/n7PkhtGbHUGrSTj9dfC1VHSFPz58ItWY7X5D+iEuK6NqzVD/MtRZEKDeT/UTgvqrFkrRnHiRyQ22mNDs/IqwY9QiL3Q5t0PA4wO7mx57CdaFU94m1HIGwG/L2LOiCwWG6F0qzbNPzYwN0Nqac0dNEhlCFXIMbFWiNFvE4uCq1m2gjP4CHxI3aC+4/aKyMYXpvFA2GmVUNYU9jZ6NfVYdOi3ZiI7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(186003)(8936002)(53546011)(26005)(86362001)(66446008)(71200400001)(66946007)(64756008)(7696005)(66476007)(33656002)(52536014)(316002)(66556008)(2906002)(83380400001)(76116006)(110136005)(5660300002)(6506007)(8676002)(19627405001)(478600001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: O1FHajHL204y96BbMRtfYz55B7EWJGRju4YjVUhqtEyK3OwCCcfrdm0IezD3gfqJdjZlLGv+yqmcWtHlzZT0zrtrELFMD9/g+oOtG+tgSvatHEqo3H1ruBqxLT8tSCwX75CyvORaLbFX03Rp9OFLvd476eO/tGZonONJ6C/qJ87A3qQZnZbli7U1jEqpW1F6IWPQZIlF+mObvrZzPGdf+gmeysPeJohEisM9/GnjJr4RZawX/Oldgz8H6XT9sp/DkmC+B8qKQKXAKwS0SXsXpSk/ogBGc3gVCMCoQvW85OzXBXyjjxA9qF7ePg0WRfdN2lVZpudQbnme9rXIgySOjcQV+YIT0gOSmOBV5JJx9rWc8DZ2NFbykBxhbXuw3+TClxiqnPXxG8YQsA1v9Jq1ODzhPRXsIEMdPxEEY2XKT1NFa9EySUF0Enm85aDCq11cgRQhpgwKoCGdSWSu0+0UjhSNfF3URY2GlYYwDNndTyGg5M1c4JyK7+oVxwtkDXVi8kIShopgeMwxrbS5wt8az0MYafOZgHv08QIMfFFU+iygSlCLB5qOUWRA4cusQ+SCy250IVZjrsoM0uzuHw4p2hAwl69VjLJOQhnC14bsa5YKLFaYhPzZQ9x0N/REfXEJqE0d+jPmV1Brk9elkboEXw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0fd805-08f1-4258-4806-08d84aad53b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 17:19:16.6166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nhn2KUCglWPlMHIjYFwYUhzuO54/SDK0mNe+PGFy5o5pAwfyFESOIaX6DrMerT6CHpUNDOeYvyGTP4BMcHOp8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
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
Content-Type: multipart/mixed; boundary="===============0020733537=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0020733537==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448898827FF2DDC2D1A5ABDAF7550MN2PR12MB4488namp_"

--_000_MN2PR12MB448898827FF2DDC2D1A5ABDAF7550MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Thursday, August 27, 2020 11:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das=
@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: fix compiler warnings

Fixes below compiler warnings:
 CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:381:1: warning: =91static=92 is =
not at beginning of declaration [-Wold-style-declaration]
  381 | void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, =
uint32_t reg, uint32_t v, uint32_t acc_flags)
      | ^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:381:1: warning: =91inline=92 is =
not at beginning of declaration [-Wold-style-declaration]
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function =91amdgpu_device_fi=
ni=92:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3381:6: warning: variable =91r=
=92 set but not used [-Wunused-but-set-variable]
 3381 |  int r;
      |      ^

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 696a61cc3ac6..6518e444bead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -378,7 +378,9 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32=
_t offset, uint8_t value)
                 BUG();
 }

-void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_=
t reg, uint32_t v, uint32_t acc_flags)
+static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
+                                      uint32_t reg, uint32_t v,
+                                      uint32_t acc_flags)
 {
         trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);

@@ -3378,8 +3380,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
  */
 void amdgpu_device_fini(struct amdgpu_device *adev)
 {
-       int r;
-
         dev_info(adev->dev, "amdgpu: finishing device.\n");
         flush_delayed_work(&adev->delayed_init_work);
         adev->shutdown =3D true;
@@ -3402,7 +3402,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
         if (adev->pm_sysfs_en)
                 amdgpu_pm_sysfs_fini(adev);
         amdgpu_fbdev_fini(adev);
-       r =3D amdgpu_device_ip_fini(adev);
+       amdgpu_device_ip_fini(adev);
         release_firmware(adev->firmware.gpu_info_fw);
         adev->firmware.gpu_info_fw =3D NULL;
         adev->accel_working =3D false;
--
2.28.0


--_000_MN2PR12MB448898827FF2DDC2D1A5ABDAF7550MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Das, Nirmoy &lt;Nirmo=
y.Das@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 27, 2020 11:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Das, Nirmo=
y &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: fix compiler warnings</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes below compiler warnings:<br>
&nbsp;CC [M]&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.o<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:381:1: warning: =91static=92 is =
not at beginning of declaration [-Wold-style-declaration]<br>
&nbsp; 381 | void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *a=
dev, uint32_t reg, uint32_t v, uint32_t acc_flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | ^~~~<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:381:1: warning: =91inline=92 is =
not at beginning of declaration [-Wold-style-declaration]<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function =91amdgpu_device_fi=
ni=92:<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3381:6: warning: variable =91r=
=92 set but not used [-Wunused-but-set-variable]<br>
&nbsp;3381 |&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 696a61cc3ac6..6518e444bead 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -378,7 +378,9 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32=
_t offset, uint8_t value)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
&nbsp;}<br>
&nbsp;<br>
-void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_=
t reg, uint32_t v, uint32_t acc_flags)<br>
+static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t reg, uint32_t v,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t acc_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_mm_wreg(adev-=
&gt;pdev-&gt;device, reg, v);<br>
&nbsp;<br>
@@ -3378,8 +3380,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp; */<br>
&nbsp;void amdgpu_device_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;amdgpu: finishing device.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;ad=
ev-&gt;delayed_init_work);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;shutdown =3D true=
;<br>
@@ -3402,7 +3402,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm_sysfs_en)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_pm_sysfs_fini(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fbdev_fini(adev);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_fini(adev);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_fini(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;=
firmware.gpu_info_fw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.gpu_info=
_fw =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D=
 false;<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448898827FF2DDC2D1A5ABDAF7550MN2PR12MB4488namp_--

--===============0020733537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0020733537==--
