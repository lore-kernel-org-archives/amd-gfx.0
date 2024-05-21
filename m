Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAA5C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7007510ECBD;
	Tue, 21 May 2024 14:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZGwgU63";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFDB10ED0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 14:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERUGX4/krztgZkjQDfqCsExpkCGh6M7UEl2OGOmcU7yx2S8BWgnCQeiAnxfxBekXMrv1L6Qcl45+E2xi+OgOGARSjPFBxYb4QH22E3KNm1+FZD3+geG6ztHPm6mjIgGow5YSTM97z6nV71q26a8ePNyrAIcYDMC2EBF1U9BwqJbTBThKpc3AD7mPROYXfo0cJlLUNGAC9rcA71gowdy7L7dpjvY+mNVUr1lqsYVVYlzn6eC8EF1+ONJFe+f1sxrkTYVk14YSF5Te6d1w27e4YRrbPEUSablEIuLE35vBDQUl6Ri2ZMicni08oklN2bxbPEHABfSJY4oqsS7CrYPkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjv8a3UKKjoaUKcvWIkSO9iZ5M6KdGzjgL5fspkBbNA=;
 b=JeZRFRLm7EO8X4VLV3lddB+799F05O2M0/43wAYC/yw9HAfvYY6OOjOdoPyUfC2gV/x9bJyuCArlcbhtb1NsNfal5SInS00axtdpr1xZs2RxV1VDLXWZ8DzitxMraeHvtvrctw/xCeMyI3nCY6U280cVuFwBTg+3z/nv5KJaCSau4V+8A5g6cMqK4FeWNDnpHyfdSQ1zmva6/aMWbbbxtuA/iY0ZiPOT2+VfjLAw10Sv4D8QBK1UwnP3nTCoVg0w22xQn1RXUlWjCZ22O6+RXarBLZjTThjZUvUo2mnjGChnRuQDBFNoGmU4lJol5nP92UKhnqwFnpSs4PCih5ANdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjv8a3UKKjoaUKcvWIkSO9iZ5M6KdGzjgL5fspkBbNA=;
 b=fZGwgU63nIW0mcpK2JC+NHho9b7gYzK95VY362Oo8gCX/eHtOr47XL/37fKvN3VILxOm9psEUd1yvSa5kz2Aqu5zwDEF+ERrt6DSUP5YRhB1VxBNJDCvKAnrWxmr9ddbd1JynQjuVXgAFhDA4G3BTJJPwcpkEwhNWoEY8P72UcM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 14:41:51 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:41:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>
Subject: Re: [PATCH 3/4 V3] drm/amdgpu: fix invadate operation for pg_flags
Thread-Topic: [PATCH 3/4 V3] drm/amdgpu: fix invadate operation for pg_flags
Thread-Index: AQHaq07vBetw8X7DWEWSrjyKe3257bGhw2eq
Date: Tue, 21 May 2024 14:41:51 +0000
Message-ID: <BL1PR12MB5144A85B9AC5EC30E61F3DDDF7EA2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240521071715.371468-1-jesse.zhang@amd.com>
In-Reply-To: <20240521071715.371468-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T14:41:51.618Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8227:EE_
x-ms-office365-filtering-correlation-id: d3ca577d-608c-4fcd-1ddb-08dc79a42734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?D/xYG45+cwxskRTvtoqhlztxjBcDKXoPslif5BW3vlVUcDx505AoM3ve2gI2?=
 =?us-ascii?Q?dB0fy7gKw9NSwams2Cu7950jElvN5hHUnxyjtwhCpldmerdp2fVXZ9Q+FD4E?=
 =?us-ascii?Q?akLIwzAmvtd3iKs69eor7jEC613jxXT0KsglT2O5Hh5TxKNQdJ1t8Hk4C0j/?=
 =?us-ascii?Q?xPLnlhsszzflwIE/Gf8vtZVt8Y/jqTJHe/KIx1jfuSH1gomCT0rL3GVG+y5C?=
 =?us-ascii?Q?aWuh+m/nIp84vMT7pc8Xj7hM2Za/55Yi+vcAWZp0g+XI1TSC/DI9sHMMB6u9?=
 =?us-ascii?Q?l3CiG70l4hAq3P6KjjpoZOMZ6Rfmtm60oEzs4a7eJa1Rs33D44jEOCh8BWGx?=
 =?us-ascii?Q?0qCEc2kH6yUSRLBNSAp2jcdTc78uCIpzvaVdOdyxlfZMVSg40LwwFEZgLYKV?=
 =?us-ascii?Q?LvgEF2pE2PhEzs2xENXE1I9cuFPGsCIgrxyxeKXPQ7m3PH88YrJ1Y+RFKcAV?=
 =?us-ascii?Q?HweTD6v9RExIbSqBPQgE9ZkApB13lHJjuJU899So2tz7VK3WTn1CRiPBHE/g?=
 =?us-ascii?Q?KHtCk5PQt5Ogt8V2IBSMTrk6yNxGDKkIKkIni/Q7MTUdaKcaFuQC1tjJJnvv?=
 =?us-ascii?Q?5mNWQEiT5y2GrkenGruFbLXhuP6LUUJdLSE73Dqf2vpVLLprGLDdJfmuHrHU?=
 =?us-ascii?Q?2wBd67Waf1k1l+m3ZcVxkn+z1oR9j2WI/AU3QSczIACFkvd5s6f2YWaaXFrM?=
 =?us-ascii?Q?L1MaC4NqfWGoVWOcuFmvVAg/4ZfceIT5qf/sR6CX6wuUdzO9W6rkeEO3DNdA?=
 =?us-ascii?Q?oQTh8dmT5YhmFwzJVghnujhJjXm8fYtin60YKvWpouqwD7odN5w1eNBwgdDi?=
 =?us-ascii?Q?RRDPoAAihlJ3Vazo6ogRGTjbI0ps6gv5aFCqg8MJ5I8H6SIzffT1Hs547sov?=
 =?us-ascii?Q?hr7LJYNkLxMm8AhrAvyqGc26EGPvKkyB1LgrgAazYstTTrRvc84D+zXcmke3?=
 =?us-ascii?Q?Mli3atULHhJ8DTiPm+s6XFSyNCOZW5UAxcEfihzuE9X+vSLUghCco/HyHjbl?=
 =?us-ascii?Q?iyl+HP3CMMlOZMP/VbC7ZcwzZonTJVFnLCe5yD8LD7svjzo4EDIriOwcU3s5?=
 =?us-ascii?Q?HMwiKTmMP/JKk91U4Wl+TSCQNdOAO9wphXKXanahcfftI0eEatYWXz+W1lKN?=
 =?us-ascii?Q?RKb0yMgniqE85HlJJcOC+I2LdqnDq9iJaEvFs8NV6RzHxrUFNDaN842Ueynf?=
 =?us-ascii?Q?asJD7fe8bFI9hxBIRc3oydAcmwmJ8GCSUIb5sZ0olvSkLbrxunKctQfH0IYk?=
 =?us-ascii?Q?1pU72O5h4GZ1xwmvP9HwSPbH1nJg6m1iUfdvlmRFJ/LBfKoKRyhY8KiYEw0S?=
 =?us-ascii?Q?Dml3GHwHe6hpakpvwFZcTP7tQjTG+iYySSsxcjbAs/FvRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pY5G88d0ojPK320ekClSAAGuWgyKn6kuiyPy73q6wuKtNQpi1bYKmg5VrIab?=
 =?us-ascii?Q?lTau996anM4iNoJmfpBGSmzFK26Dj9Ad35z3pqGG/0HHlmI9NkpfVGZNCBsh?=
 =?us-ascii?Q?PyDOC7BQfjKU5vlDlO1rC9kJPZYDUTso3lhoFqpyYLT1tqH4JS9xAXWY3npe?=
 =?us-ascii?Q?1fkrpAaqx+V3Ch95Bqiz7hxzHnwVpSe/2HrgypHv04YFzrOQf6/G8CNoBuuS?=
 =?us-ascii?Q?MLoqsse2H0jWGGkZMBaAGJ4bQsgGn/m3aoDfK1IDgphQVnNzJIthR3zYHoiJ?=
 =?us-ascii?Q?7SyTkuDKMssgi1SqVp/8u/LXpxXLebq/Dr/nxUQit4aW9LcaK/2ypFJTPY0c?=
 =?us-ascii?Q?OEppNnybZexOtEBBtrifoUpze/IzdsoLJnmta0zEek41V2kHcvZWiGT+KBc4?=
 =?us-ascii?Q?agi7vzFYoisRTLb1GQ5IRkX2TuoyqSAfJeK8jCTYmQeTIcjyJpD1feDlg3TZ?=
 =?us-ascii?Q?wbbE9QV434ZBo/gM4/zeE/a9lFnRSMsulYoU476jbtBaDWsbf8yPn4TmswPi?=
 =?us-ascii?Q?1J6uq4LzRkuNyERX3SPyeRB2ZtDhBsKT69W6MzwSS8Nym4H1yYM1m7e2EFQN?=
 =?us-ascii?Q?e4KnvWBNx2tvtKiHRsOjCHgqpfhqgWJ/f9G3zuX8FSF7AXB/h3gO1KNUKG9g?=
 =?us-ascii?Q?ry702MubyTCXKYBNe77vr8vOwwRqWm/FhKuUxhXbEZyvcDHjXyQbbDRLVcYr?=
 =?us-ascii?Q?4y+wHe3FSCTTnDkN6McRWn2P/3aC7j08YuM7t59GXIDGzDYE6DTmtBR8zfap?=
 =?us-ascii?Q?1zxINnHYKwsYxZMumrVcJnzzMvSVVIrRZQwzWyG6/Y7vxjZ81BIqWth/avOm?=
 =?us-ascii?Q?czmggwSjvBRQFvnw/WeV8CiQ9MAaWfdJo7aMKngQeytueUkJuSwotgaVS0m4?=
 =?us-ascii?Q?dpQreMzvrBspLRhIlPbZZbaT3T1oxCUrenoTlqAFX6icWqGro/nhCTHnUchk?=
 =?us-ascii?Q?bhjnSf8rYisz++9lVA3YeObTKqhttCX1bPNsKAkA/GNkxxCHEdItUMgSYpID?=
 =?us-ascii?Q?pzLYAkpttzHrPnfuwXKK9VGTxzZkwA53ZELHrdM3gle+4EjEU+OemEt2uVkb?=
 =?us-ascii?Q?btq9mKAeeRk1Sxb/cF5ZOEZXFge5fXKOilHzOJZhVUmkC9Qlanjqdw+EV6XC?=
 =?us-ascii?Q?fqG5oBIEDZHMba0MAZddjB0C5TAO565gg/cnBgDh/0tTP+yQmnxuusRUWW8D?=
 =?us-ascii?Q?C+3nxuh85HidNotbICLtfyLDlvi6zKFS/3cYlo7esj8FFlS5lrh1smYY9+8y?=
 =?us-ascii?Q?T6tt2Jeq7sSTNckkngEgb/TKwG+EBKgUH4JFB8RwWQ61iCJQVVEMyiroOoQD?=
 =?us-ascii?Q?go7VS4pTFJrTG2bHX0Pp8gMFI9frmCaBjcc7xyLyMaiJpoe7loiRFOMGyYYt?=
 =?us-ascii?Q?aFa5fnUzvl1cNjkYTdZ6sbXK8agiQMeGn8gjAhIxtk3hs6vN7S+yhT2lbu0P?=
 =?us-ascii?Q?4vsHFm4Nb+UkuEIOcjyGQwKeAasGSKTojP+I9W+88h76OpMJlU7gFQRtfWsI?=
 =?us-ascii?Q?EWzN6aJStZq63eg8SL+/D5+X8xTwn3UDL44sQhf7FYPqEOhvQUrDeODwuqMf?=
 =?us-ascii?Q?yTF84pGO+HIF97WqnYw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A85B9AC5EC30E61F3DDDF7EA2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ca577d-608c-4fcd-1ddb-08dc79a42734
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 14:41:51.8897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5EU9r8vbIEW9t6Nv8qLUpueKHt1URIlk/3gbHGgVRGl211oe1jk8Q66pjOSw3eA6gCdMB1LrYE5zhZZlUvExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
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

--_000_BL1PR12MB5144A85B9AC5EC30E61F3DDDF7EA2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Tuesday, May 21, 2024 3:17 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4 V3] drm/amdgpu: fix invadate operation for pg_flags

Since the type of pg_flags is u32, adev->pg_flags >> 16 >> 16 is 0
regardless of the values of its operands.

So removing the operations upper_32_bits and lower_32_bits.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index ac0ba8b8c1aa..0e1a11b6b989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -918,7 +918,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,

         /* rev=3D=3D1 */
         config[no_regs++] =3D adev->rev_id;
-       config[no_regs++] =3D lower_32_bits(adev->pg_flags);
+       config[no_regs++] =3D adev->pg_flags;
         config[no_regs++] =3D lower_32_bits(adev->cg_flags);

         /* rev=3D=3D2 */
@@ -935,7 +935,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,
         config[no_regs++] =3D adev->flags & AMD_IS_APU ? 1 : 0;

         /* rev=3D=3D5 PG/CG flag upper 32bit */
-       config[no_regs++] =3D upper_32_bits(adev->pg_flags);
+       config[no_regs++] =3D 0;
         config[no_regs++] =3D upper_32_bits(adev->cg_flags);

         while (size && (*pos < no_regs * 4)) {
--
2.25.1


--_000_BL1PR12MB5144A85B9AC5EC30E61F3DDDF7EA2BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jesse Zhang &lt;jesse=
.zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 21, 2024 3:17 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&=
gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Zhang, Jesse(Jie) &lt;J=
esse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/4 V3] drm/amdgpu: fix invadate operation for pg_fl=
ags</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since the type of pg_flags is u32, adev-&gt;pg_fla=
gs &gt;&gt; 16 &gt;&gt; 16 is 0<br>
regardless of the values of its operands.<br>
<br>
So removing the operations upper_32_bits and lower_32_bits.<br>
<br>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
Suggested-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index ac0ba8b8c1aa..0e1a11b6b989 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -918,7 +918,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rev=3D=3D1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;rev_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D lower_32_bits(a=
dev-&gt;pg_flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev-&gt;pg_fla=
gs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D lowe=
r_32_bits(adev-&gt;cg_flags);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rev=3D=3D2 */<br>
@@ -935,7 +935,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct fi=
le *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D adev=
-&gt;flags &amp; AMD_IS_APU ? 1 : 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rev=3D=3D5 PG/CG flag u=
pper 32bit */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D upper_32_bits(a=
dev-&gt;pg_flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs++] =3D uppe=
r_32_bits(adev-&gt;cg_flags);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (size &amp;&amp; (*p=
os &lt; no_regs * 4)) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A85B9AC5EC30E61F3DDDF7EA2BL1PR12MB5144namp_--
