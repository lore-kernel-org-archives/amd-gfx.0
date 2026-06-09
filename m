Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688F2CD8CB2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 17:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA31B10E346;
	Tue,  9 Jun 2026 17:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MyF+fGIe";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6E510E346
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 17:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFIUsFTbmvYS5lb18sebJ+D5c8TQL1CgnOXlTI5Dap5reM/zXcGYNdOyEuAH1mLj+UhpbEMRNQOi8uuv0KPFouhrNrA8Da7WaCfOLmlX4sc8xxXSDgaUZxy5kD5Oi9l1lqox9qO8Ns366dffeNJRoWK4RXskTvx3L9i8fgLqlZC3/FS08oiv4sK8wsfYjT+6dZaeH/E7+hLnlBHhRb4gjL7VNzoHu4eG6oWjTrHaxMi/1nwkkJIH4r5kesocjiX6Lzb8BufcC6/1wlb1fjsN5UB9MdBAdApbfzbinuh3Y2q4ZIq0w7OG8iBPFuiICNE1t5RbAMUvN+9gao0SNYqlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KALV6hM6yoswtKyQ7luEHGSSQ7WpZ03dEbLxV6LamYM=;
 b=Ds1QrCnn0ldrhKfjelb/wn0Xl/d2W19Tev2ChRqLGFGFCnNLEipG9VMudQ9oyG3W593bzwPIx1C72vYfkt1PELC30+AXFNRfvgR0ZgM4+cdYHgyKjK+eCGVq7c+gJ9lJjc/+P0NQ+Qihcw9ZYPQhCQftEEwW2vnwbLHZm3a4IEK0kHn46yDoSj+hM76ytEuP7m/sI71I+G16Y5XWnoLqMZXFf7qHwAXLY3pbSQCMGvEJu26/tNn23oCVnwlCU4W/41FZ0R7dRXql0uqllBxd6v+cJEXgnJC9yLCOFLFDPfJkO4wmmbDa3XQKZJzdo2k2PqgGnx6fzWTWOz7v6JlTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KALV6hM6yoswtKyQ7luEHGSSQ7WpZ03dEbLxV6LamYM=;
 b=MyF+fGIegLazUMzABGU7H1vDk53YfhkFwZbm/BxCbJj/kRQDIW3u+xd3H0k3sEmNUSqeg5uDLzBo9Yry1hQ+ZYWM64seUG1rbkTHGjIo5EMX4YxxkcD23FsjV0U8PzZZP40CXwfHzOLH1MVZnpHfgB1HVZb4U5//kNeutHr/kYY=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 17:01:53 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 17:01:52 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Lin, Amber" <Amber.Lin@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix reset event signal
Thread-Topic: [PATCH] drm/amdkfd: Fix reset event signal
Thread-Index: AQHc+C+eeUHGFGOKKE6j8E6b55K3q7Y2cstI
Date: Tue, 9 Jun 2026 17:01:52 +0000
Message-ID: <CH0PR12MB5372CC09465F647FC20348AFF41D2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260609164643.3815222-1-Amber.Lin@amd.com>
In-Reply-To: <20260609164643.3815222-1-Amber.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-09T17:01:15.8224421Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS0PR12MB6533:EE_
x-ms-office365-filtering-correlation-id: 77e2a87e-748e-415a-d573-08dec648cdc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: iw2zZt//vAAEmTb7jETEvcozgIQ5A4mleFVs72/qrH8bQdeclD3yId9aBi8NE5Ut68/Ua6Lay0Ops7Q4QPICRr+SX+CK8dj4kEP/TG8aD6y1nv/6FLxRySK5PWh7QVrigpBPayqo0tnMh1OUeVki/OMEcrQ+LQ7HC7R46SCyO2Ij9pHIaUemwfuTsGoFiECBPVTdu17OE2F7vXCyAlSJSQmh/Skc6pmfAXTzghka3VQW75TOtQp34tmdctQhEPGdiQkjm5oGznEJioDV5S2WshWXgVHYelBRKB4A5xhxSQg/L9Vokaf4LcnmWIK4n+k7hGb6r9h8/YE8hLj93M8NY+bNZxiEOS/ETI1tmaVNIV4tNcEesSio6InB4F/yC3e9aA2/iqQTzo2jcrfkJ8x6efzt+/ouW+ILZX2iG+UIWbt7DzSOgjrIotV/PZV5Ec3gpAM9sC1vfkfNbDVtsHyfGByWCl5m7DMG9kdunnnRA/kj/I6ULIeqg9ePHgMPtuqlWpzXSkT5ZYqLUCenYvtfGn/5HzR7JuktnibNPOSVFN3Cn7Ms1RGQXlP4BtndyhQdVYCGr//2ByEJcDqhfPy7IMf+d49yIJ7d2+sby7TtfiAlTrHdA4fPvKo3TqztK1Yk5Xf/i6/Ia4I3Hp+/I9FIxQSaWCXuAftlxtStBm3Gs9A9e0bDxkdlC1A97XEZKQ8zrkz/k+cjiEHvHCJ4wUQUjPGOH+fUYgQTPC10TibbVb/WfLVHW55Y3HNVqC1xVF4m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?huHD5AarE+H/OrjcYiVxf1DyOWbQkZ55Q13sVxFvPqIzKTPdB5rjg9+fKvPz?=
 =?us-ascii?Q?MfcnYrkH6KkwBnw50bvZXsoR+yVMb84p8FT3nrKqZQLuqBJKFU6yFnLj0F9X?=
 =?us-ascii?Q?xW9Wdd60AI+BAatsOGQ0upsPWRZEO1Dj5RvdtSce2T2oqgUC58Hp8w5Jpgg1?=
 =?us-ascii?Q?rWfcTbh4SUmmd8yw+6j/PJkJFQFEVhYfdPosisXJmspLIQGAyJjxOAhErxIe?=
 =?us-ascii?Q?RYRIw3wVEfKKDB7hDp0Jraf30H6VmePDF1pbZ8cnx0I5M45gFV9gDuNMk2L0?=
 =?us-ascii?Q?xYZ7WfnkgAIb5llZv+39dF9PpoMp8N2rEQJHspmuZ6bc1+s77TfmFe6TPyFv?=
 =?us-ascii?Q?3Qf3RxtT0U9rxFZ0O+MdOdHBQsuk6YC5hswJlj/OiwIX9Z2wLT163TdXaucu?=
 =?us-ascii?Q?TP2r614TsSM5+1E+4Kdr8W6mT0Riy3JNiNj2eQuBohB4dvsEk/vpSGtOFlOd?=
 =?us-ascii?Q?aEq9WeOU1iPJhRtmELwm8SnrNF4YYHIUi/i9TFhjfIXTwrJDaMJAgft2tuWP?=
 =?us-ascii?Q?eHCQiwj8pVBoDf3QDLQdNKSpVbNzINQ4NDNvQI1HVEic1g9zUh1ySUq+6gIp?=
 =?us-ascii?Q?x/GbaeeR32h4iXIPip84Zby/YGzG78DGIy4qCVJyhLGAm+6UXM7Q6KLF2GPS?=
 =?us-ascii?Q?Tu7T1Qszg3U/JWy4jecxiN0DZzvpvW4hrhfd4B4SHhGxmHGlTxaFo67pe3QC?=
 =?us-ascii?Q?xCHNmMqJWVIGQExZ6t3fOpFskHE+gpGF/pQ8SPujUyssR1EIvyyDPiB9LUuq?=
 =?us-ascii?Q?lRyDC2mZMUQ9SE2d9EJ9OD3qxTfsKASAiWU2SFU66SMTmagW2Yy6LBSfG+99?=
 =?us-ascii?Q?kYD8CC/J9+cMAroOvam9v9Awtmw8Rc9bU/gz7SSme8vougmgGLI/XQ02IpUy?=
 =?us-ascii?Q?aRBEEY5m0Xoye4DT35nUhh1uwTpF/mccAdxH1bA5sUncklZOfoODuePt22gv?=
 =?us-ascii?Q?DoiFUbe20kS0z8Gey751a9bqUTvdMtnR7m96CDk6YFkLcQQ1Zr2sRd8t8uj6?=
 =?us-ascii?Q?o1Gxd829CoMMH+ouhQpWPWp/+Njfwj7UJofoNcWyrwkjB3xboEwVxoE+j/qE?=
 =?us-ascii?Q?aqty37EsoMnq9jwiK7U/5Zn6kUmopEjmy4/hK+0n5x+gEp4UaClL7ePQJUrH?=
 =?us-ascii?Q?mE8L1INsW+VL6one8x9hXlYpo1S7QIYPZuGROv8DdF3tb/hjBUbgLEzFXEok?=
 =?us-ascii?Q?HeIW08Ls0F+xZz09y9xyvAGLmlUDPcMsLt4CXCpSVFdGRCofWb6XFxDRgF54?=
 =?us-ascii?Q?VLrBs9jz+c4bQAsDLXP0u1xX+SHGsH3Mk3hgL8c7vDbVh4+khE1Tkgf7JZDI?=
 =?us-ascii?Q?O89bMyuo6AFq3NaYxYNEmhVMCCjrqt7fkwwLq3b4HIUB2SRF6JOItbfVQvKx?=
 =?us-ascii?Q?j2D7bbF4/oP/tHO0fxWkIkCNTKlluuKkcr7rRh5Yx22fmp5LfCVjUp3Jr9v5?=
 =?us-ascii?Q?SBIreHwuU5gapGVq3kSfrwOW8lRFPxnpOWkLlMA14EpFV2hBTgtTJohWfMzr?=
 =?us-ascii?Q?4Een2HuhYqCdAUEtQ0zhbjMIyFl+ysooCrJJvJ9vqlQJBpBinxSgpbxAV3W6?=
 =?us-ascii?Q?+reri/yHt2yXhU4j19NA2eeAPEa1bid6G3wfRQUGVIaFus4o+2AiBsF55AHL?=
 =?us-ascii?Q?dRt78b/Dyxvk0GGlIDJHS+UCPS0Lb3RqaVhdW34eO9L+ObsdHxG4frhD7RSX?=
 =?us-ascii?Q?r/rRhZ32+jY1ylRAKr8xHlLlMv+vSCligCl9jI58ucJRtlwZdBJS52eM0XL5?=
 =?us-ascii?Q?n5YsJ6D9GQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5372CC09465F647FC20348AFF41D2CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e2a87e-748e-415a-d573-08dec648cdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 17:01:52.5588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQBEdtxLMnDh/9MGCFm1nu/8d7fKRhraED7VptSnzFnae3IwPRNZpA6NAlkS0U3fd17DqGiA9p2NfHtnG1f0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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

--_000_CH0PR12MB5372CC09465F647FC20348AFF41D2CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Looks good to me, you can add me as RB
Regards
Shaoyun.liu

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Lin, Amber <Amber.Lin@amd.com>
Sent: Tuesday, 09 June 2026 12:46:43
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Liu, Sha=
oyun <Shaoyun.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Fix reset event signal

During the KFD/KCQ coordination rework, bad queues not requiring reset
were combined into the rework and generated wrong reset signals to the
process. Fix it by adding the reset check.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1d12901d4823..828a7ce6eeca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -474,7 +474,11 @@ static int reset_queues_mes(struct device_queue_manage=
r *dqm, struct queue *q)
                 goto fail;

         dqm->detect_hang_count =3D num_hung;
-       kfd_signal_reset_event(dqm->dev);
+       /* When MES doesn't detect any queue hang, no reset happens. Don't =
signal reset
+        * event.
+        */
+       if (dqm->detect_hang_count)
+               kfd_signal_reset_event(dqm->dev);

 fail:
         dqm->detect_hang_count =3D 0;
--
2.43.0


--_000_CH0PR12MB5372CC09465F647FC20348AFF41D2CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, -apple-system, HelveticaNeue, sans-serif;=
font-size: 12pt">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Looks good to me, you can add me as RB</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Regards</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Shaoyun.liu</div>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" style=3D"font-family: Apt=
os, -apple-system, HelveticaNeue, sans-serif;font-size: 12pt" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, -apple=
-system, HelveticaNeue, sans-serif;font-size: 12pt">
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lin, Amber &lt;Amber.=
Lin@amd.com&gt;<br>
<b>Sent:</b> Tuesday, 09 June 2026 12:46:43<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;<br>
<b>Cc:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix reset event signal</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">During the KFD/KCQ coordination rework, bad queues=
 not requiring reset<br>
were combined into the rework and generated wrong reset signals to the<br>
process. Fix it by adding the reset check.<br>
<br>
Signed-off-by: Amber Lin &lt;Amber.Lin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 1d12901d4823..828a7ce6eeca 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -474,7 +474,11 @@ static int reset_queues_mes(struct device_queue_manage=
r *dqm, struct queue *q)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;detect_hang_count =
=3D num_hung;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_signal_reset_event(dqm-&gt;dev);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* When MES doesn't detect any queue =
hang, no reset happens. Don't signal reset<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * event.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;detect_hang_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_signal_reset_event(dqm-&gt;dev);<br>
&nbsp;<br>
&nbsp;fail:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;detect_hang_count =
=3D 0;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5372CC09465F647FC20348AFF41D2CH0PR12MB5372namp_--
