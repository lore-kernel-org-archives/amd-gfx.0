Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD54C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 01:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F207110E423;
	Tue, 20 Aug 2024 01:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X10Es4o7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B26010E423
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 01:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoI6JThvRaPf7w2nh9GRoEWMZ6Km0s43jBXQjpVK7YoImsx8qe7Tl+NKoFagLSa43ilqVnA6Wu+Jr3zdvHt59+xNJNY+lMEnQKv5YjlcNYkvxuijr7+dv3hTSdpMRYcwiPXMfdbsfgC6+90Q6GYjoMRgofvOOdZgFND2GjEjDsoApYwKd6iCsLkWcHZEOxHaBgurTUpZdQS80R9vW9AZ13d77/rQCPOGrCBc0azycmHPLLkuhIWDpG8TbBL1rYvNe+htAWZGPVYxlN/KmyQXLirzF0ZVy6SWLMr3/KICiDzvu3wl6MU4SJokoOc6LUvv+Yzm9RjbtipDBHkhKJmtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XHG1KHIinvTRQrxZ2LZdfB0CQUE0Htp1LM73Sw6t00=;
 b=HHO0Et72qIxO0c84QSVaxAcQyOj101sK4Fn7Lw4wjlmUzWDhNpXXjNHmjv20MhiU3tTIv+WKqGSejpEnlKlGWaaG+dbox2EAl+S/85xy3wVFV1w0n7BmPDWvsW2XtzN9EAj5WZANTZA0yQTL9XYdOi42A+Xh0KfyA+x/Qpubm4u1W5xizfmODYAAN5Vjm6v+QKkvpMXZlLzn5RvnBf9TQP2QDUiQsb/fEYhSTzSi9OTNo9GjcYOOiI4y0p6xB3u6oaIF481LOd7l0vOUgro0brDnvXFQme+PFWumRjSePMsUnx4hlqwWhnpYZZseEl0zziCe83LPWiCG/CE1/KrSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XHG1KHIinvTRQrxZ2LZdfB0CQUE0Htp1LM73Sw6t00=;
 b=X10Es4o7VhFCKS+8E0dr/tBod2hf29DqiDHTr8uqIqBqdUUjuUM8dTLQh7PJb0Ju15oyt/1d15QuYu7ZY9CksdV3CUbxfw0EYtkf6B/s5Fqk2OI/mOZJBX/xw19HFNjroUBOomnv8pzMifkqaorJMLr8fObM+XwR8d7TJbjkwKI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 01:33:35 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 01:33:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update message interface for smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update message interface for smu v14.0.2/3
Thread-Index: AQHa8pwwIiH6nQJ3jEGz/KeTvlya6bIvXIX3
Date: Tue, 20 Aug 2024 01:33:34 +0000
Message-ID: <PH7PR12MB5997807A53A091F4E4B79A8A828D2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240820005844.277280-1-kenneth.feng@amd.com>
In-Reply-To: <20240820005844.277280-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T01:32:50.7785276Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB6686:EE_
x-ms-office365-filtering-correlation-id: b8249d2c-9d09-4d8d-ec92-08dcc0b81ba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jxq+VGsMVx32Bb32zJ82JCvED5Wah3IhXlw5+XS0rV7502LZeUWtg6K+m8lX?=
 =?us-ascii?Q?l1FSowZBgo21Rhot1UisPywnQBMAoeYVpNfQurpBEE0VMq4MSFievgy1Yl1O?=
 =?us-ascii?Q?e8YFcSmK0LaG/NusCTcrjILl7Zgigt4qIgiKy2aOtfSG+UpkRI00vShrp9vQ?=
 =?us-ascii?Q?fvqmwC1+XqXsreoUtWg+rh0ps6h6sXU9rAjZUBtoyAtLo2t9Ley3m4cMzJ68?=
 =?us-ascii?Q?wmaLtO+XxRi1X28h8sXhZC+DWpHjjiRUgZ8zIjKM1D4DjJX1YnfXQgqEbkA4?=
 =?us-ascii?Q?bIxoNmxhzgdhDcPfD8OX3B33kiSX6GJAstsM9ujtuFT9ZN4gXv26uSMIVQQu?=
 =?us-ascii?Q?tFIMR2An/VZgwh/7J2ra2P3+2M9QVEp4bbeXHnJNjFSeWxyz4i5pLfzXL/PR?=
 =?us-ascii?Q?PHEqGRFIA1hzHT2834i0//pQqJntWb/KAc5TS8n1zp5DE3O3GvmqxAqHOnRi?=
 =?us-ascii?Q?KsllybiO59ihdzBhs+Aq7xfvaslXCX18+hJo+oGgkXUo+AasN8YW6CFjs1Rj?=
 =?us-ascii?Q?PHBz37xQjcrvnhUIju0ppM0ZvKRXhT4xvF17syf6nD4AF6FSleFhtuIowqMX?=
 =?us-ascii?Q?eP3rCmx1D1/AAMfZYoQm4Wj9W39mbJfRMorbmULwAh6XVX5ShM7E7aQF2HQK?=
 =?us-ascii?Q?EqebD2X6aKlaWGPyOdAyiX105zw34mhFPWV27Whq5iqjeoNUqD6o4aW1FLKl?=
 =?us-ascii?Q?pAgCF6XHdzgp1DkTqFybc8LJ4qIpUIjZ6tEkZECCrvbi7AjZoxmuOnS8dH81?=
 =?us-ascii?Q?VvbKzaWJ2yI4QZNJY0TyW1roymcJeHJKDVj3VR99zivtfm/Wdwvc82kfYHuA?=
 =?us-ascii?Q?+sW2JUBH/Mc3Z7aFKsHcHE9fFOBjZjrGtMT6U2gb4HWaPYifR3dc+8xwKl/S?=
 =?us-ascii?Q?D1aMt8YR4YPgEDfx0v1PLViBNtFS3Yikx6YFX40gpnVCCCVRiXGxXEvwPJQ5?=
 =?us-ascii?Q?Lts34wgBNAzIucTAm4WBFYTt28nERSE0iX9jNguf5oI/VQeEf1NqaXPvE1S+?=
 =?us-ascii?Q?kIjO7MdyOVNEr/SbnLIUSHbJNVoYFJ7wLsUG6X6iY5KxVGRxV71+4ne7YUTW?=
 =?us-ascii?Q?JfOfjSQqN3ed/AOiXwRpqPSk0TIi0ObrfqrZAO6qVPxo3/YZmm9KGvIipQzF?=
 =?us-ascii?Q?GjrdVKuIWCk2584UTtApRIvwqa+UwirjaKHsLog6kHaXrEEPlmEmPXAJAfgd?=
 =?us-ascii?Q?xEVeNWXc9bnIf1N8rySO1keKfVbzXs33yeLJTXgd9QbQO2fERa/xpcpz2RIa?=
 =?us-ascii?Q?WE6xilvlxzxLlKuY93zHk9CTCj4TWUQHbIRYNHB7x/ZOeRC9xvWwMvHUhDeX?=
 =?us-ascii?Q?cqRP101ffFz83BqcKB2kTkW1AtVe4QFmQWE9V1tc7my0vqowBTTwijh15kfz?=
 =?us-ascii?Q?yOC3w98tmoDtfwf8NUrRk7u7isHoaLE+6I681T1ZVakdGSvOoA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?84kelRvv48mrqUOihgV+dyf6qD9HC/mYw60j6t5+SHjszi/3Rmz5YJPFyQPL?=
 =?us-ascii?Q?dzqjniRNiOZJylJ0fFKzBuclwJNEgrvl1ZJtH4s5hCWiVlc0/e6C6BuUG9B8?=
 =?us-ascii?Q?RkRJ6nbi0FfHkKxKJmoh4bSLOCKiodXoYquhATc7/59ifkq90+FreIuafvZ4?=
 =?us-ascii?Q?xVTtdZq07ZKqKBp7lcp37chH2ob8XmF0Oj4PL5WkEjN6HwkkkROYHnCvLKG7?=
 =?us-ascii?Q?NG0DvxFfZS35sextT1XJPkAdObdz4BF1zysBM8VvevQyoHxrkemz3hLe+orw?=
 =?us-ascii?Q?+Qrt9FSC6i0T86sZIMRY4NSh6M4bv8DdjErjl/fH8qD1CADdFGTGp9ww3N7B?=
 =?us-ascii?Q?/4UcI3Aqkqe+d2VEW3Eunf4R7SU150VkEImsnRZTbvraflsh0FBTKwDLL1oT?=
 =?us-ascii?Q?EM+9f+f5l5psQQHN42SOjzW3mUYa8z4TOB9F3SVgu0ygaK6Lv7tc7MO2B9ot?=
 =?us-ascii?Q?f9gYz8wLwongWKAdIxtEnvoEz1ustj47yBtnr3QdOutLtCTbZDIv7CXuUmw7?=
 =?us-ascii?Q?/0BKqpJ7kvYkMOiAKOR8Tw1Ha080og81ddjGFIK8K3ldHEiAvnRgRAbkFf4p?=
 =?us-ascii?Q?uGhTQBDgo5BQe8oIulbgPUH8IKhfBd6szcL6KjJ3tvvYUgwFni5JsFJQlQ2t?=
 =?us-ascii?Q?SU1sFzq9IV5modUcYPEhGS60QhKDkUIhrRDR92WX5Zdxss6xqnUwkahLj8KE?=
 =?us-ascii?Q?NLYviZ1vjEcJUnaEN5KSopRGYxt1C/HDbML/Za7K3PxruGxyg8F7+tAhAr8h?=
 =?us-ascii?Q?ZL2i0/d0gmaz7RvKdpGRwKs53vea1UPg7/pNe3H4yPpkoulKBJSjAwQGCews?=
 =?us-ascii?Q?iYl8+kKikz6sEsSAUCgJEwyl/OWXlI9YcrQsnsFnaJQBkPEM1BfXPgT+wpPr?=
 =?us-ascii?Q?MD3P8ClJjgDQYDegYoMG2KqB1eH/XrCX7xI7n6bgnMHSkZTP0FJJkAFkr578?=
 =?us-ascii?Q?xgXKHVcYZBRAf0yTUbrWCqC8TGiUS98gVHTvAo4cS2wHqMzmAzgnS/FuDf8P?=
 =?us-ascii?Q?gLIU/BZjSCA/el0xT5BLdjVnWy5tmOidTIGDflGng3g+Ynv8Fgj9uBB/U58K?=
 =?us-ascii?Q?cm7YPlzEqKN68n4Drrsg0OuAwUiSCx46fqWTl7NdjPdm8gUz3pv7uUVXg/ce?=
 =?us-ascii?Q?ZerpiQnpNxxPnWvuag4EsJ0Z/j9zp5ro1AS4Uh/TytZcaZveugaQXiRSyQ/9?=
 =?us-ascii?Q?dEwh35TTODpenMoHPfggiGCSMadMCNSljweRmyOve5ijKqh5YPAG+f4LK77B?=
 =?us-ascii?Q?GX+hhEHC5hQPeL5rZaWH22SeBtYmgiERRxi2Se5qvFRzupLqmBPUELHU41I+?=
 =?us-ascii?Q?3Zb+9Pg8Rp8H9rVfRoQbUodIx/OnrJupIoFNnjmDR52xuxe85dQKuNWSqpXe?=
 =?us-ascii?Q?nVHAijl333zM3+OsngMmOwFDcOKvp092IrbhjYCoayCRrCCGvOatl/S8RVFD?=
 =?us-ascii?Q?AhmUYd2nvf79lCW/sg2d7wNd9AcSNqsqPhy8fHXVsVzXPD4b6P4y5Gg9kTLR?=
 =?us-ascii?Q?IxNp4m5qRb+Hhj0ormPZWP9Kh6BQp4ZiSBWvCXaLw+TDFvVSfuWIXbytWLe9?=
 =?us-ascii?Q?F0c0hHWA8ivWpCeEh4nMPC4cqmXzTxU3H/BfPPRJKdQF4Gk/wos0UlAzqxk2?=
 =?us-ascii?Q?lCq4jMgPzUDe81hOGHMx1eoq0jZARes4xomHJhYCE838?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997807A53A091F4E4B79A8A828D2PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8249d2c-9d09-4d8d-ec92-08dcc0b81ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 01:33:35.0045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmmHMiGcIPru0qpTHUgkQEtAaSsdOLJAZ1ztoxJ/8f/uBdebhNV0Cs7PjJwxdX32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

--_000_PH7PR12MB5997807A53A091F4E4B79A8A828D2PH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Tuesday, August 20, 2024 08:59
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: update message interface for smu v14.0.2/3

update message interface for smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h   | 18 ++++++++++++++----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  1 -
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
index de2e442281ff..87ca5ceb1ece 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
@@ -92,7 +92,6 @@

 //Resets
 #define PPSMC_MSG_PrepareMp1ForUnload            0x2E
-#define PPSMC_MSG_Mode1Reset                     0x2F

 //Set SystemVirtual DramAddrHigh
 #define PPSMC_MSG_SetSystemVirtualDramAddrHigh   0x30
@@ -119,11 +118,12 @@

 //STB to dram log
 #define PPSMC_MSG_DumpSTBtoDram                  0x3D
-#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh    0x3E
-#define PPSMC_MSG_STBtoDramLogSetDramAddrLow     0x3F
+#define PPSMC_MSG_STBtoDramLogSetDramAddress     0x3E
+#define PPSMC_MSG_DummyUndefined                 0x3F
 #define PPSMC_MSG_STBtoDramLogSetDramSize        0x40
 #define PPSMC_MSG_SetOBMTraceBufferLogging       0x41

+#define PPSMC_MSG_UseProfilingMode               0x42
 #define PPSMC_MSG_AllowGfxDcs                    0x43
 #define PPSMC_MSG_DisallowGfxDcs                 0x44
 #define PPSMC_MSG_EnableAudioStutterWA           0x45
@@ -135,6 +135,16 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4B
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4C
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4D
+#define PPSMC_MSG_EnableShadowDpm                0x4E
 #define PPSMC_MSG_Mode3Reset                     0x4F
-#define PPSMC_Message_Count                      0x50
+#define PPSMC_MSG_SetDriverDramAddr              0x50
+#define PPSMC_MSG_SetToolsDramAddr               0x51
+#define PPSMC_MSG_TransferTableSmu2DramWithAddr  0x52
+#define PPSMC_MSG_TransferTableDram2SmuWithAddr  0x53
+#define PPSMC_MSG_GetAllRunningSmuFeatures       0x54
+#define PPSMC_MSG_GetSvi3Voltage                 0x55
+#define PPSMC_MSG_UpdatePolicy                   0x56
+#define PPSMC_MSG_ExtPwrConnSupport              0x57
+#define PPSMC_MSG_PreloadSwPstateForUclkOverDrive         0x58
+#define PPSMC_Message_Count                      0x59
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5913f9c60fe0..e000ac7b4c0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -127,7 +127,6 @@ static struct cmn2asic_msg_mapping smu_v14_0_2_message_=
map[SMU_MSG_MAX_COUNT] =3D
         MSG_MAP(SetMGpuFanBoostLimitRpm,        PPSMC_MSG_SetMGpuFanBoostL=
imitRpm,     0),
         MSG_MAP(GetPptLimit,                    PPSMC_MSG_GetPptLimit,    =
             0),
         MSG_MAP(NotifyPowerSource,              PPSMC_MSG_NotifyPowerSourc=
e,           0),
-       MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,      =
            0),
         MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnl=
oad,         0),
         MSG_MAP(DFCstateControl,                PPSMC_MSG_SetExternalClien=
tDfCstateAllow, 0),
         MSG_MAP(ArmD3,                          PPSMC_MSG_ArmD3,          =
             0),
--
2.34.1


--_000_PH7PR12MB5997807A53A091F4E4B79A8A828D2PH7PR12MB5997namp_
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
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 20, 2024 08:59<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Feng, Kenneth =
&lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: update message interface for smu v14.0.=
2/3
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">update message interface for smu v14.0.2/3<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;.../pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h&nbsp;&nbsp; | 18 +++++++=
+++++++----<br>
&nbsp;.../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c&nbsp;&nbsp; |&nbsp; 1 -<=
br>
&nbsp;2 files changed, 14 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h<br>
index de2e442281ff..87ca5ceb1ece 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h<br>
@@ -92,7 +92,6 @@<br>
&nbsp;<br>
&nbsp;//Resets<br>
&nbsp;#define PPSMC_MSG_PrepareMp1ForUnload&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2E<br>
-#define PPSMC_MSG_Mode1Reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x2F<br>
&nbsp;<br>
&nbsp;//Set SystemVirtual DramAddrHigh<br>
&nbsp;#define PPSMC_MSG_SetSystemVirtualDramAddrHigh&nbsp;&nbsp; 0x30<br>
@@ -119,11 +118,12 @@<br>
&nbsp;<br>
&nbsp;//STB to dram log<br>
&nbsp;#define PPSMC_MSG_DumpSTBtoDram&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3D<br>
-#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh&nbsp;&nbsp;&nbsp; 0x3E<br>
-#define PPSMC_MSG_STBtoDramLogSetDramAddrLow&nbsp;&nbsp;&nbsp;&nbsp; 0x3F<=
br>
+#define PPSMC_MSG_STBtoDramLogSetDramAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x3E<=
br>
+#define PPSMC_MSG_DummyUndefined&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3F<br>
&nbsp;#define PPSMC_MSG_STBtoDramLogSetDramSize&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x40<br>
&nbsp;#define PPSMC_MSG_SetOBMTraceBufferLogging&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x41<br>
&nbsp;<br>
+#define PPSMC_MSG_UseProfilingMode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x42<br>
&nbsp;#define PPSMC_MSG_AllowGfxDcs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x43<br>
&nbsp;#define PPSMC_MSG_DisallowGfxDcs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x44<br>
&nbsp;#define PPSMC_MSG_EnableAudioStutterWA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x45<br>
@@ -135,6 +135,16 @@<br>
&nbsp;#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4B<br>
&nbsp;#define PPSMC_MSG_SetPriorityDeltaGain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4C<br>
&nbsp;#define PPSMC_MSG_AllowIHHostInterrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4D<br>
+#define PPSMC_MSG_EnableShadowDpm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4E<br>
&nbsp;#define PPSMC_MSG_Mode3Reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x4F<br>
-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x50<br>
+#define PPSMC_MSG_SetDriverDramAddr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x50<br>
+#define PPSMC_MSG_SetToolsDramAddr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x51<br>
+#define PPSMC_MSG_TransferTableSmu2DramWithAddr&nbsp; 0x52<br>
+#define PPSMC_MSG_TransferTableDram2SmuWithAddr&nbsp; 0x53<br>
+#define PPSMC_MSG_GetAllRunningSmuFeatures&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x54<br>
+#define PPSMC_MSG_GetSvi3Voltage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x55<br>
+#define PPSMC_MSG_UpdatePolicy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56<br>
+#define PPSMC_MSG_ExtPwrConnSupport&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x57<br>
+#define PPSMC_MSG_PreloadSwPstateForUclkOverDrive&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x58<br>
+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x59<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
index 5913f9c60fe0..e000ac7b4c0e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
@@ -127,7 +127,6 @@ static struct cmn2asic_msg_mapping smu_v14_0_2_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetMGpuFanBoostLim=
itRpm,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetMGpuFanBoostL=
imitRpm,&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetPptLimit,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(NotifyPowerSource,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PPSMC_MSG_NotifyPowerSource,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(Mode1Reset,&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Mode1Reset,&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnloa=
d,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_PrepareMp1ForUnload,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DFCstateControl,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_SetExternalClientDfCstateAllow, 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ArmD3,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_A=
rmD3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB5997807A53A091F4E4B79A8A828D2PH7PR12MB5997namp_--
