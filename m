Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27453F531F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 06:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A94810E568;
	Tue, 14 Apr 2026 06:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XcEWU/h6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7455110E568
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 06:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxEBkZXzNkJUryPv9GNpeZFg9PoIfGYyFZmTiV2lbYnfW9KCmQlh/lu/oK0u/FELZTCeblnGdmhEIKbrgRPktRNc+DpMlfDsYYMADYsU0XXHgvR/ZKgaJ4OWlfSMiC4qNlFI3xz7c4QRl4nfychO3xzPNohTTPG2gaPbaoCUq7NN1tHe9mCvz9WYJSVS7nge06A27oV57nQgI2RU2Xnm2joyZKwEHh8beT3caPuSRbNEEnsMByG/yJLV+tUlM/5hvGkhiP14lJUpRhe0ZwORc43sV1ObYLjdwlDIS909Z2taDnMDxyDD/Gc3gtZHgEBqPHgjyiaFld0EzncPQQF2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8M5pD9P/9I+IIaJeMV1hXMee7b5QMzG5Csz/qVLtjA=;
 b=clY6diTl/V28IZ0FRafBD01MHsUCv+AfOvEac77NDk0WfzDFlfHFoTFg1dGS4030izd+tueBI3blAOKtG3ACBHnY4D31BIZoiKqv7WJRsGFcXIarwEERRr5Cf9asaPhnljzn/XrtjR0Ia1piF3Qla+h2YQ2sz6GylredE+4vUco1gr9L9efHIR48qTaDfuO+NEVlztOSIVm8cWO1bgDdDmITjiZqBq0g5+ZLJp1OmshVAPrgpWAHkQzLHrFbclJfI6ut8obJMaZViMPwA0TUfTX0pBydooMsIIpTVwkn8eb+ibs71xNBSAo6phIikqNGqu7jRAL2JhWgW0gG6J0Dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8M5pD9P/9I+IIaJeMV1hXMee7b5QMzG5Csz/qVLtjA=;
 b=XcEWU/h6uZPM1cEo7GTPMsLWKMnV3F2dxcnYlHKU6cCmwtexRiDpLVFzIRNANMqYqgRur178fvOkDVUUbJfO+GwzjHhqCSP5V0hEkg7yDgr3cOjwSJx4i07vbp+NqhLVvUFpb8crE+nFgKxT19lzmNGb7cswGr2A1FAgCB+GpvE=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Tue, 14 Apr 2026 06:09:06 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 06:09:05 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Guttula, Suresh"
 <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: smu: add unified metrics table support
 for SMU 15.0.0
Thread-Topic: [PATCH 1/3] drm/amdgpu: smu: add unified metrics table support
 for SMU 15.0.0
Thread-Index: AQHcyzO60JMnAVIXiUC+rBthUJaF5LXeETmg
Date: Tue, 14 Apr 2026 06:09:05 +0000
Message-ID: <DM6PR12MB29727ED11E20EBBBBFA73D9D82252@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-14T05:59:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DM6PR12MB4092:EE_
x-ms-office365-filtering-correlation-id: 6970e828-9326-4214-22d7-08de99ec5567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: FCRK6yhvor4u7jcqsvoDBIwkhyh11j2EcmkSMNZL/7MYPcrsv38DkXY3iaLzfFpMHhF41QyL6hCBPT++8CQUFhNERjWyBG6JjiQVpRQ4IzaAuS2Ij1PtOnXBxVeD5JkyDaAPHY8YfrgfKFIIB9ZUxbOZe7DocbUy/fDGZmBTSS23vPKbhKsCDmfYdtQmHMA2uSMhQ60Lmg84TPOwn0oq71e9yWn2ibpPg31LPvE/eo5cScU1ixo5eGBYc0Wf7RBq/d6kb7wgB2twbRuCVODwyNbtdyjc/R9uHuhGR8quk+P1Z2mHT0GsJ5SYUyq/ItcDygvv9H6CkLycUN6lF7Bk/OJvInsE0/XUHdO48DJyAArNX/20WRutyB5iD04+vAzNjfNZPgJYec04yyNKffCsS+2SdeOJNYF5NikBcnl7+6yQ7aNn00k0HhNhtBIiLTkNG1tUfq7pj9Ih4AADqMfxfOHUNnJ8xyPmQywFIzGIHrD8FV4roqf0+jX6ABiIvgSQ/Vvvqxm9mfusRjnbcBIpeDalj5BaAV6i07munpQxEJF1ZkXuC+7jwGcfLk5AnMs8KZnqWE9xH6NNom0EBxP2jzEKcYSBY0Y5ORih8tFVjODrfs8WBf8+m316cpfG6VtngkCl2ejv1IZjdcs8Y2ncb3PuVKyUv8s7/O7IawmbXQVeSUbCcQZ2aFishYZA3CJeE+5LGlcHjNCmSTFDOYUKJWiQinKAAEm4EKhNkV4le8C70GcFg4SZXpQIf+ogsyvRikX0B7oV07qL0XAykPCXGx6lqAml8Nw2l2r+S1BLX3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gz1I+2kz/62Y/6zDD06WyLVMVHbAxrOPO4tBlr/NkDSfwl2wnZbvqktw9KG7?=
 =?us-ascii?Q?8oH1PevqI3I5KEdLfZUGXZ4xKRN7StEmmrdwDSCXoRuH6GOhNzPOTyu6rDB0?=
 =?us-ascii?Q?wJ1gECiv2MiP1nPTVXNIey0nS6IXH18FNVmVyZl2MNd0j0ZRexL/Ieuo7Aum?=
 =?us-ascii?Q?TeGoWwRYfyDxygwCc9MVvACd0jnFUkAVywPUPTF6xVbDc6z46IoZhNLF1aBq?=
 =?us-ascii?Q?8ZKXrZuSs5usxt/BK79SJrbZWm9bqnC5VT2A+o/AtZX/qaXIip0EJ7exMrlx?=
 =?us-ascii?Q?tDzUZZlytUMktIFYo+s96qdcgmI4gnpd63+b2SAGSm8tsGSFytijEbqfJZck?=
 =?us-ascii?Q?OTOb1y4YgUn6r4D5AvyrqaQt9vT6+k/ymzk3T5Ui/BiM3eX27nG1dJmih8S+?=
 =?us-ascii?Q?ZEf7aQHCXcrLU2Ay4vvNyoN1FaENEwq+WNhSmo6xSv4P/+4TAQfJgJu7VUMD?=
 =?us-ascii?Q?uYTXjEAVtOu1JabB8N5McrB4vQfRg6GIIZ4YwAXoWMBoWFjA83NcsEzTliT9?=
 =?us-ascii?Q?yFhxbTCPPen7cBDjKe6krF+iQDl6RsRd2Hi03xh9JkXMX20uriyjlbMNpOju?=
 =?us-ascii?Q?1bWqKWS6O/tw58u8NcW99C8tEzFhGGm+QnZy+qsTwBGBau3t8G92L7yRoyKc?=
 =?us-ascii?Q?mu4UiwNI7R0da8lLkb6h1Rc3itabLQstJMlXSBTv6wa94Pv9pXJ1HLNvSV0t?=
 =?us-ascii?Q?LsS+KixLdO30m0RCDHdFdk4QG0i9EuN7QCWObjwCyADsJLUtGsZsnsN6IOmy?=
 =?us-ascii?Q?V3KAEmu4cP4DQHg9lnxDd5lBskXVu2BVzKpZ22XyuKzmrXRRmFLkCTm2/HHz?=
 =?us-ascii?Q?dSfXT+FH4QiJyCnEc8KeCGz3/Eo++WPBALo8FqkvFW8hkyITZtzveKceIxON?=
 =?us-ascii?Q?E1BPOlXr8bQ5C886bwcBvKHuH/KbMvZ1ZAjbV1FqwIqRC5njOG1NLr/BMkwX?=
 =?us-ascii?Q?jLu1PLQEJ2su5TNJNCMi8Mt8FyspnUoHFADTCcWE/KYWIE7xaUDrpGg8nqTN?=
 =?us-ascii?Q?HQxEn0gEoh3xcLRrZsKtPoL2G8f4kyfyBcS8IQrqhDP3T0o1PSIaFqkaLoXy?=
 =?us-ascii?Q?C0UAYfitTTNwZsu1swfQWgkJvPkk6buFPe1zPHcgpMZjxmJel+BFIMoYOOk4?=
 =?us-ascii?Q?HS81bdqOyuv3pFu7tK8e4/CUq3YOWfhOqVtbuP1+cPAgncw0YQfnKpCNiyvy?=
 =?us-ascii?Q?3aqxn2TXbALmV3ALrvfvNISdZR8i5Mnw+P+ugQbkMhAtLZQLvPCKK99JTOfu?=
 =?us-ascii?Q?CGPoBZdR2NspKdfgvg0bWwl93/DhArn87dtQhhbvrfoURSWFSVJOS/uAFsS3?=
 =?us-ascii?Q?16Ox/483uowaU8Dg18LcyKlJHFpy/tCc9pXVWzGdg6hZWwwrdcVVb1jK+ZVc?=
 =?us-ascii?Q?eXup9u0OnSHvgTfGZlTWS1FGGBnsDcniQZ6HWwKvazF2dsHMTKLiROWEp/0L?=
 =?us-ascii?Q?qssNyXUzju8Q49LXc4OSTbfJaWrJtW7RzpMmUenEdKMq13bo9OOIlecAPu7s?=
 =?us-ascii?Q?WnP2bH6TEtYfbskrnJNOz5olLrzw7sCDH9BuO7s2strP5OZO3j1FmuzFUOx+?=
 =?us-ascii?Q?oH3BfaZ/9357tRVt8DfbcAEs5K0It2YvrASdVFr+WR5etFOfcCltiH2pHI3J?=
 =?us-ascii?Q?QrftYpPr/rxUDzj7cB+QU429RZPopA3WcQMIpjYe0osCwAXyBzv++oXEzcmQ?=
 =?us-ascii?Q?hN1CdaTrEYQPgIX1uZZArwcy+vQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6970e828-9326-4214-22d7-08de99ec5567
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 06:09:05.6939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pogPrwP361TvGC6V/nwTh+PhpFWIQ2NnFwvxYBlCRWGUhsWnYOETGZkzCwHZ9BoS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramaling=
eswara Reddy, Kanala
Sent: Monday, April 13, 2026 18:52
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org; Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Guttula, Suresh <=
Suresh.Guttula@amd.com>
Cc: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: smu: add unified metrics table support for=
 SMU 15.0.0

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

SMU 15.0.0 reports metric values in an accumulated form and no longer provi=
des pre-averaged metrics. Introduce support for the new unified metrics tab=
le and prepare the driver to compute average values in

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd=
.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 102 +++++++--  .../drm/amd=
/pm/swsmu/smu15/smu_v15_0_0_ppt.h  | 198 +++++++++++++++++-
 4 files changed, 289 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
index bf216f83e689..9f627b5fef5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
@@ -100,7 +100,10 @@
 #define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
 #define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
 #define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
-#define PPSMC_Message_Count                     0x22 ///< Total number of =
PPSMC messages
+#define PPSMC_MSG_GetMetricsTableVersion        0x22
+#define PPSMC_MSG_GetMetricsTableLogSample      0x23
+#define PPSMC_MSG_GetMetricsTableLogDramAddr    0x24
+#define PPSMC_Message_Count                     0x25 ///< Total number of =
PPSMC messages
 /** @}*/

 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 636ff90923d9..e1b92d2dbc59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -295,6 +295,9 @@
        __SMU_DUMMY_MAP(GetSmartShiftStatus), \
        __SMU_DUMMY_MAP(EnableLSdma), \
        __SMU_DUMMY_MAP(DisableLSdma), \
+       __SMU_DUMMY_MAP(GetMetricsTableVersion), \
+       __SMU_DUMMY_MAP(GetMetricsTableLogSample), \
+       __SMU_DUMMY_MAP(GetMetricsTableLogDramAddr), \
        __SMU_DUMMY_MAP(InitializeGfx), \
        __SMU_DUMMY_MAP(SetSoftMaxFclk), \
        __SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 9a4a5f482e75..a280506f43fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -119,6 +119,9 @@ static struct cmn2asic_msg_mapping smu_v15_0_0_message_=
map[SMU_MSG_MAX_COUNT] =3D
        MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,    =
                     1),
        MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,   =
                     1),
        MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,   =
                     1),
+       MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVe=
rsion,               1),
+       MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLo=
gSample,             1),
+       MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLo=
gDramAddr,   1),
 };

 static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_CO=
UNT] =3D { @@ -170,10 +173,10 @@ static int smu_v15_0_0_init_smc_tables(str=
uct smu_context *smu)
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
        SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
+sizeof(SMU_15_0_0_MetricsTable_t),
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);

-       smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t), GFP_KERN=
EL);
+       smu_table->metrics_table =3D kzalloc(sizeof(SMU_15_0_0_MetricsTable=
_t),
+GFP_KERNEL);
        if (!smu_table->metrics_table)
                goto err0_out;
        smu_table->metrics_time =3D 0;
@@ -299,7 +302,7 @@ static int smu_v15_0_0_set_default_dpm_tables(struct sm=
u_context *smu)
                                    smu_table->clocks_table, false);  }

-static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
                                                        void *metrics_table=
,
                                                        bool bypass_cache)
 {
@@ -329,34 +332,90 @@ static int smu_v15_0_0_get_metrics_table(struct smu_c=
ontext *smu,
        return 0;
 }

+
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+                                       SMU_15_0_0_MetricsTable_t *metrics)=
 {
+       uint64_t addr;
+       void __iomem *cpu_addr;
+       struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
+       int ret, table_size;
+
+       struct smu_msg_args args =3D {
+               .msg =3D SMU_MSG_GetMetricsTableLogDramAddr,
+               .num_args =3D 0,
+               .num_out_args =3D 3,
+       };
[kevin]:
Please add the pmfw version, or check if the version is compatible with the=
 old pmfw here.
+
+       ret =3D ctl->ops->send_msg(ctl, &args);
+
+       if (ret)
+               return ret;
+
+       addr =3D ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
+       table_size =3D args.out_args[2];
+
+       cpu_addr =3D ioremap_wc(addr, metrics->table_size);
[kevin]:
1. please add null pointer check before use it.
2. missing iounmap() here?
+
+       args.msg =3D SMU_MSG_GetMetricsTableLogSample;
+       args.num_args =3D 0;
+       args.num_out_args =3D 0;
+
+       ret =3D ctl->ops->send_msg(ctl, &args);
+       if (!ret) {
+               amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush befo=
re copy?
+               memcpy(metrics, cpu_addr, table_size);
[kevin]:
Please add safe check to ensure the table_size is less than metrics->table_=
size before call memcpy().

Best Regards,
Kevin
+       }
+       return ret;
+}
+
+#define get_diff(a, b) \
+       (a > b ? ((0xFFFFFFFF - a) + b + 1) : (b - a))
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
                                            MetricsMember_t member,
                                            uint32_t *value)
 {
        struct smu_table_context *smu_table =3D &smu->smu_table;
+       SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;
+//TBD

-       SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;
-       int ret =3D 0;
+       SMU_15_0_0_MetricsTable_t prev_metrics;
+       int ret, counter, val;

-       ret =3D smu_v15_0_0_get_metrics_table(smu, NULL, false);
+       memcpy(&prev_metrics, smu_table->metrics_table,
+                       sizeof(SMU_15_0_0_MetricsTable_t));
+       ret =3D smu_v15_0_0_get_metrics_table(smu,
+                       (SMU_15_0_0_MetricsTable_t *)smu_table->metrics_tab=
le);
        if (ret)
                return ret;

        switch (member) {
        case METRICS_AVERAGE_GFXCLK:
-               *value =3D metrics->GfxclkFrequency;
+               counter =3D get_diff(prev_metrics.IOD.AccumulationCounter,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
+               val =3D get_diff(prev_metrics.IOD.GfxclkFreqEffAcc,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GfxclkFreqEffAcc);
+               *value =3D counter ? (val/counter)*1024 : 0;
                break;
        case METRICS_AVERAGE_SOCCLK:
-               *value =3D metrics->SocclkFrequency;
+               counter =3D get_diff(prev_metrics.IOD.AccumulationCounter,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
+               val =3D get_diff(prev_metrics.IOD.SocclkFreqEffAcc,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.SocclkFreqEffAcc);
+               *value =3D counter ? (val/counter)*1024 : 0;
                break;
        case METRICS_AVERAGE_VCLK:
-               *value =3D metrics->VclkFrequency;
+               *value =3D 0;//metrics->VclkFrequency;
                break;
        case METRICS_AVERAGE_DCLK:
                *value =3D 0;
                break;
        case METRICS_AVERAGE_UCLK:
-               *value =3D metrics->MemclkFrequency;
+               counter =3D get_diff(prev_metrics.IOD.AccumulationCounter,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
+               val =3D get_diff(prev_metrics.IOD.MemclkFreqEffAcc,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.MemclkFreqEffAcc);
+               *value =3D counter ? (val/counter)*1024 : 0;
                break;
        case METRICS_AVERAGE_FCLK:
                *value =3D metrics->FclkFrequency;
@@ -368,18 +427,27 @@ static int smu_v15_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                *value =3D metrics->NpuclkFrequency;
                break;
        case METRICS_AVERAGE_GFXACTIVITY:
-               if ((smu->smc_fw_version > 0x5d4600))
-                       *value =3D metrics->GfxActivity;
-               else
-                       *value =3D metrics->GfxActivity / 100;
+               counter =3D get_diff(prev_metrics.IOD.AccumulationCounter,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
+               val =3D get_diff(prev_metrics.IOD.GfxBusyAcc,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GfxBusyAcc);
+               *value =3D counter ? (val/counter)*1024 : 0;
                break;
        case METRICS_AVERAGE_VCNACTIVITY:
                *value =3D metrics->VcnActivity / 100;
                break;
        case METRICS_AVERAGE_SOCKETPOWER:
+               counter =3D get_diff(prev_metrics.IOD.AccumulationCounter,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
+               val =3D get_diff(prev_metrics.IOD.ApuPowerAcc,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.ApuPowerAcc);
+               *value =3D counter ? (val/counter)*1024 : 0;
        case METRICS_CURR_SOCKETPOWER:
-               *value =3D (metrics->SocketPower / 1000 << 8) +
-               (metrics->SocketPower % 1000 / 10);
+               counter =3D get_diff(prev_metrics.IOD.AccumulationCounter,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
+               val =3D get_diff(prev_metrics.IOD.SystemPowerAcc,
+                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.SystemPowerAcc);
+               *value =3D counter ? (val/counter)*1024 : 0;
                break;
        case METRICS_TEMPERATURE_EDGE:
                *value =3D metrics->GfxTemperature / 100 * @@ -637,7 +705,7=
 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
        SmuMetrics_t metrics;
        int ret =3D 0;

-       ret =3D smu_v15_0_0_get_metrics_table(smu, &metrics, false);
+       ret =3D smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 8365b9fea77e..b3dc6ccdddaf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,202 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__

+#pragma pack(push, 1)
+
+typedef struct {
+       uint32_t AccumulationCounter;
+
+       //SET_VOLTAGES
+       uint64_t VDDCR_SetVoltage;
+       uint64_t VDDCR_SOC_SetVoltage;
+       uint64_t VDDCR_NPU_SetVoltage;
+       uint64_t VDDCR_LP_SetVoltage;
+       uint64_t VDDCR_GFX_SetVoltage;
+       uint64_t VDD_MISC_SetVoltage;
+
+       //TELEMETRY_VOLTAGES
+       uint64_t VDDCR_TelemetryVoltage;
+       uint64_t VDDCR_SOC_TelemetryVoltage;
+       uint64_t VDDCR_NPU_TelemetryVoltage;
+       uint64_t VDDCR_LP_TelemetryVoltage;
+       uint64_t VDDCR_GFX_TelemetryVoltage;
+       uint64_t VDD_MISC_TelemetryVoltage;
+
+       //TELEMETRY_POWERS
+       uint64_t VDDCR_TelemetryPower;
+       uint64_t VDDCR_SOC_TelemetryPower;
+       uint64_t VDDCR_NPU_TelemetryPower;
+       uint64_t VDDCR_LP_TelemetryPower;
+       uint64_t VDDCR_GFX_TelemetryPower;
+       uint64_t VDD_MISC_TelemetryPower;
+
+       //THROTTLERS
+       uint32_t fPPT_FusedLimit;
+       uint32_t fPPT_MaxIrmLimit;
+       uint32_t fPPT_MaxPboLimit; // Inst | Fast PPT MaxPboLimit (W)
+       uint32_t fPPT_Limit;
+       uint64_t fPPT_ValueAcc;
+       uint32_t fPPT_ResidencyAcc; // Acc | Fast PPT Residency Active
+
+       uint32_t sPPT_FusedLimit;
+       uint32_t sPPT_MaxIrmLimit;
+       uint32_t sPPT_MaxPboLimit;
+       uint32_t sPPT_Limit;
+       uint64_t sPPT_ValueAcc;
+       uint32_t sPPT_ResidencyAcc;
+
+       uint32_t SPL_FusedLimit;
+       uint32_t SPL_MaxIrmLimit;
+       uint32_t SPL_MaxPboLimit;
+       uint32_t SPL_Limit;
+       uint64_t SPL_ValueAcc;
+       uint32_t SPL_ResidencyAcc;
+
+       uint32_t TDC_VDDCR_FusedLimit;
+       uint32_t TDC_VDDCR_MaxIrmLimit;
+       uint32_t TDC_VDDCR_MaxPboLimit;
+       uint32_t TDC_VDDCR_Limit;
+       uint64_t TDC_VDDCR_ValueAcc;
+       uint32_t TDC_VDDCR_ResidencyAcc;
+
+       uint32_t TDC_VDDCR_SOC_FusedLimit;
+       uint32_t TDC_VDDCR_SOC_MaxIrmLimit;
+       uint32_t TDC_VDDCR_SOC_MaxPboLimit;
+       uint32_t TDC_VDDCR_SOC_Limit;
+       uint64_t TDC_VDDCR_SOC_ValueAcc;
+       uint32_t TDC_VDDCR_SOC_ResidencyAcc;
+
+       uint32_t TDC_VDDCR_NPU_FusedLimit;
+       uint32_t TDC_VDDCR_NPU_MaxIrmLimit;
+       uint32_t TDC_VDDCR_NPU_MaxPboLimit;
+       uint32_t TDC_VDDCR_NPU_Limit;
+       uint64_t TDC_VDDCR_NPU_ValueAcc;
+       uint32_t TDC_VDDCR_NPU_ResidencyAcc;
+
+       uint32_t TDC_VDDCR_LP_FusedLimit;
+       uint32_t TDC_VDDCR_LP_MaxIrmLimit;
+       uint32_t TDC_VDDCR_LP_MaxPboLimit;
+       uint32_t TDC_VDDCR_LP_Limit;
+       uint64_t TDC_VDDCR_LP_ValueAcc;
+       uint32_t TDC_VDDCR_LP_ResidencyAcc;
+
+       uint32_t TDC_VDDCR_GFX_FusedLimit;
+       uint32_t TDC_VDDCR_GFX_MaxIrmLimit;
+       uint32_t TDC_VDDCR_GFX_MaxPboLimit;
+       uint32_t TDC_VDDCR_GFX_Limit;
+       uint64_t TDC_VDDCR_GFX_ValueAcc;
+       uint32_t TDC_VDDCR_GFX_ResidencyAcc;
+
+       uint32_t EDC_VDDCR_FusedLimit;
+       uint32_t EDC_VDDCR_MaxIrmLimit;
+       uint32_t EDC_VDDCR_MaxPboLimit;
+       uint32_t EDC_VDDCR_Limit;
+
+       uint32_t THM_FusedLimit;
+       uint32_t THM_Limit;
+       uint64_t THM_ValueAcc;
+       uint32_t THM_ResidencyAcc;
+       uint32_t PROCHOT_ResidencyAcc;
+       uint64_t GFX_TempAcc;
+       uint64_t SOC_TempAcc;
+       uint32_t P3T_FusedLimit;
+       uint64_t P3T_ValueAcc;
+
+       //POWER
+       uint64_t SystemPowerAcc;
+       uint64_t ApuPowerAcc;
+       uint64_t dGpuPowerAcc;
+       uint64_t NpuPowerAcc;
+
+       //FREQUENCIES
+       uint64_t FclkFreqEffAcc;
+       uint64_t MemclkFreqEffAcc;
+       uint64_t LclkFreqEffAcc;
+       uint64_t GfxclkFreqEffAcc;
+       uint64_t SocclkFreqEffAcc;
+       uint64_t VclkFreqEffAcc;
+       uint64_t VpeclkFreqEffAcc;
+       uint64_t AieclkFreqEffAcc;
+       uint64_t NpuhclkFreqEffAcc;
+
+       //BANDWIDTH
+       uint64_t DramReadBandwidth;
+       uint64_t DramWriteBandwidth;
+
+       //ACTIVITY MONITORS
+       uint64_t GfxBusyAcc;
+       uint64_t VcnBusyAcc;
+       uint64_t NpuBusyAcc[3];
+
+       //STT
+       uint32_t STT_MinLimit;
+       uint64_t STT_APU_HotSpotTempAcc;
+       uint64_t STT_HS2_HotSpotTempAcc;
+       uint32_t STT_APU_Temp_Limit;
+       uint64_t STT_APU_SkinTempAcc;
+
+       //RESIDENCIES
+       uint64_t CpuOffResidency_CCX0;
+       uint64_t CpuOffResidency_CCX1;
+       uint64_t CpuOffResidency_CCX2;
+       uint64_t CpuOffResidency_CCX3;
+
+       //DFPSTATES
+       uint32_t FclkFreqTable[8];
+       uint32_t UclkFreqTable[8];
+       uint32_t DdrRateTable[8];
+       uint8_t  DfPstate_Source[8];  //(0=3Dnot_trained; 1=3Dfused; 2=3DEX=
PO)
+
+       //SYSTEM
+       uint8_t  GfxDisabled;
+       uint8_t  spare2[3];
+       uint32_t GfxClk_Fmax;
+       uint8_t  CClk_CoreFuseEnable[4][12];
+       uint8_t  CClk_CoreEnabled[4][12];
+       uint32_t CClk_Fmax[4][12];
+
+       //OVERCLOCK CAPABLE
+       uint8_t CpuPreciseAndDirectOverClockingCapable;
+       uint8_t GfxPreciseAndDirectOverClockingCapable;
+       uint8_t PboBasicOverClockingCapable;
+       uint8_t PboAdvancedOverClockingCapable;
+       uint8_t PboNitroOverClockingCapable;
+       uint8_t MemoryAndFabricOverClockingCapable;
+       uint8_t MiscOverClockingCapable;
+       uint8_t ExtremeColdOverclockingCapable;
+       uint8_t DownConfigControlCapable;
+       uint8_t spare0[3];
+
+       //OVERCLOCK STATUS
+       uint32_t FIT_LimitScalar;
+       uint8_t  LN2Enabled;
+       uint8_t  CpuPreciseAndDirectOcEnabled;
+       uint8_t  GfxPreciseAndDirectOcEnabled;
+       uint8_t  spare1[2];
+       int8_t   PsmGuardband[5][5][3]; //Curve shaper (5 avfs guardband ty=
pes
+                //[CCD0/CCD1/CLASSIC/DENSE/LP] * 5 frequency points * 3 te=
mperature points)
+       int32_t  CorePowerLimitOffset;
+       uint32_t MaxFreqOffset[5]; //5 avfs guardband types
+[CCD0/CCD1/CLASSIC/DENSE/LP]
+
+       //per-core PSM margin (curve optimizer) } MetricsTable_IOD_t;
+
+typedef struct {
+       uint64_t Core_C0[12];
+       uint64_t Core_CC6[12];
+       uint64_t Core_FREQ[12];
+       uint64_t Core_FREQEFF[12];
+       uint64_t Core_TEMP[12];
+       uint64_t Core_POWER[12];
+} MetricsTable_CCX_t;
+
+typedef struct {
+       uint32_t table_size;
+       MetricsTable_IOD_t IOD;
+       MetricsTable_CCX_t CCX[4];
+} SMU_15_0_0_MetricsTable_t;
+
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);

-#endif
\ No newline at end of file
+#endif
--
2.53.0

