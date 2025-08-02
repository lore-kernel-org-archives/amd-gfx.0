Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67DEC87FD2
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Aug 2025 04:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449BD10E066;
	Sat,  2 Aug 2025 04:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBDD1mSk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6A410E066
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Aug 2025 04:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBB0VQ7umO+lAi7Gs1ITpwJ4ncHlscJuxW68FxMYyO4dB2rblQUik5Bl9RkbJT/w/gionIHyqN0zBDEUX7gNgwaG46x2WXmA6hyROZGU/0IFHxebBUVb5slLTrjMX9Z1E8TJcgtPPfyO/STlRiBY/UH4aOOK89Lsg0Icwv6AVeLAe+LFuGf09MMsO9UdRv7/spEq/vOEwBzbTk4f611VK+H/HCd5TT53esYQDtLkrEsXfb9pcfMG4/86CgZPKxOacaPNmuVPs+D2vuT7bDuxVvDZiYJiEsvkK1ZAZMT2waOyOmScttQ65uYvZVVdOSRNldWPzHwAToDGu6XYg3SsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kerVWQb1ldQtp1VOWG6yw2UG8V+m9twcPGFLHI4nKN8=;
 b=ZVaP59Ay3Zx5qtqr0sX+8JM5nr34yUwWyYVftihzHh1iGQai6DIxn0jpaOQhC3+ByVtEf6DOnnC1oXX6QeW6W8asprH/aMuHWC+bsuYVF8nFblhZYUgcaFRiWeF7ZUNNBfVU3FNRQ8Kh2NX7jIYaQTO4k1yWFQ0vyrFc9q2Cy7BcyC9rLY9Vts7RI7R4FZcx7dkWwyOap9vCDfn+ExeVKHkPYL88CKcDLjQtRV5PYwxu8Mu1bZaz619PMczQfYv7TIXTtajjcrmYmtlpqBbTSa20Ld+Tb5qOCETrcZz60mSk93Fn6Cxeb76eILzcZYbDo5tj6A6kJ+PvRU/U0dQ1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kerVWQb1ldQtp1VOWG6yw2UG8V+m9twcPGFLHI4nKN8=;
 b=sBDD1mSk+gzHRrlIBtqZWcbtKolbzbg+PtcPgL2ZsaND+US5hbb5Xwbfj6qITVDXVvUMl5EFO0Wcs0n4OLPfr3CjDb0n/V+PM1otiqlDPWs+NYUMWktJ83CResodV3iqQTPvLFQ/iN1qBIos2n656kPuEfx8NeyPXU0u5DhmnSM=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Sat, 2 Aug
 2025 04:01:37 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8989.015; Sat, 2 Aug 2025
 04:01:37 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Allow static metrics table query in VF
Thread-Topic: [PATCH] drm/amd/pm: Allow static metrics table query in VF
Thread-Index: AQHcAxDHK/uBvJIgPkOOUisCsFH0k7ROvhqQ
Date: Sat, 2 Aug 2025 04:01:37 +0000
Message-ID: <DS7PR12MB6071AF8E72F62868BD8AA2AE8E21A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250801181850.1712440-1-lijo.lazar@amd.com>
In-Reply-To: <20250801181850.1712440-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-02T04:01:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN0PR12MB6293:EE_
x-ms-office365-filtering-correlation-id: f84a2dfc-449f-4fb6-50a7-08ddd179471c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bxpnvD0bhHOWGOzPuACcnYfCACRPT8P7reCJF2ulyhC2dCEqJRlkIzZBEhW7?=
 =?us-ascii?Q?uhWMWs6rkG4j7fN9iNr/HNr5opxDEHazL8jK4sWi8fWYLMwM44VJVNXZMegj?=
 =?us-ascii?Q?nMQOHnYSsVluzqjH10YfSdIqZS7xqQRSIuwTFWksbV9Bp0Ja1SNlRde0obUh?=
 =?us-ascii?Q?QBb69bGKPBTV9CBbvtD5Bk0VxHVsFKkY6gNJpZQnD3wpwY8lZ6pNMjtCfsoz?=
 =?us-ascii?Q?O+DHQCOxnGzaZpfElnJgMKQZOQ8QtajzVJdC7picDtq0Xj9BH79PSYKmXSnz?=
 =?us-ascii?Q?/0tHmpj67FW2iRKtWiiR94zqZ2nr2ku/GCLWHiSFBC6/JPvB7cYkh33Zo0Lm?=
 =?us-ascii?Q?Zc2mbLUKYH7Gn5gHaJDqBX73QQL/klwvL/5/dOHfPQle44CqHykO4MRRT+sY?=
 =?us-ascii?Q?ENSgN5IEo6YIhYwduwmZR0DYqqiAQhgXmFufWIVNMGXE5p1mRCe5n0h4C6Lb?=
 =?us-ascii?Q?fmP7rGYRdGhEwTBXBn5WFPbR2hWb7hrwIgASFAEzUeIaqJMsTpjwaLxEMB4j?=
 =?us-ascii?Q?NatbiAzgoHVbYEwuSBq+Q8+gnJWACa7k5yHnCJegNZaYn9kgOp1ZQlPVQ+kP?=
 =?us-ascii?Q?5swjTKb/QUpX3X1Mhlq+ABndud5J3FBXVLkUDJj961FPE8CeG6rBFPt/+oDu?=
 =?us-ascii?Q?VWboPZ+LFP20zHCq8nRJH33tB7BI0jdBxfvoZRFAL2GYqcusq3s883cK6BnN?=
 =?us-ascii?Q?CxLxlYWhXhFm3/iqHa3R1Geu/82pTCqONvAiBjBJDx4Adxqfe0YzzZc/uW7w?=
 =?us-ascii?Q?RQ8LZCw+P3G87JzkgUZCrTaP3dk0h6q1z6z3yP3vbWEBkV7PFok9NhiqlaVC?=
 =?us-ascii?Q?ur1MyOj3OeFt9jfi7M6zFvhkkyea8droeTKfZwBJ7VzwVN7qMUpA9/0gL79E?=
 =?us-ascii?Q?8kQ/4KjJGK4jvwa+Etd77yAzLoscGRXfN2A6V/x/8oxxEbTZ5ggRRRK7jxCQ?=
 =?us-ascii?Q?s/NIq+vNKJnzDJlMKJNnMlknRUmjXUfXruFr32DELazdyPIgz8wv1XPVzmLA?=
 =?us-ascii?Q?8tVRWLjTiB+XtzYp5uy+A0OctqCJRVDXC49bp1gVvCxS0t8B+TPnE4/hEYo+?=
 =?us-ascii?Q?X94a82qSN2+xCcmRWE7JLN18W3GYBMNgU3WA/PsmnLdA5mZnuH9wDfw1SCXU?=
 =?us-ascii?Q?6vZkOJWGf+fhvN+Xir1hQNdqaZzFj1PNshL41gslwblBxnevDNJT2AOMz8DN?=
 =?us-ascii?Q?rXCkrET5TBb9UjUxGgPOQLVCZP3PjeMRRrMHPruuNHllYcu+ZiMOUA9LnYm3?=
 =?us-ascii?Q?ZOVDGAQpIBu6UEXlJjk/Cb7DT5MYz88bJdXvoBSfQsTLYkNCi2LqMLp/Dc2g?=
 =?us-ascii?Q?sRgimWS9Rm+/H/wDhuzCx3A/zrSIX2/OZ6HLCCJaEcceQFTcyNo/Y2L749aS?=
 =?us-ascii?Q?pCng/yisS3n1Z7O3VfyJhC7iY1nAbFPWhmnCGIh/S/yz7sOnW1YmCo47nbvl?=
 =?us-ascii?Q?PKB3OICnvy0aB6l8uAokPqkXhySPy2dQk3FIBddhHb4Rz5sfP68r2A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YLyEbIs9pI+H5r8QbK5a22r+0MvIzwe2MnAd3s4LYk1jWw4bX73PYMDNHaQ8?=
 =?us-ascii?Q?VUtqtAsxbS1E3uL3YJFAQrrLQvxQ82lMYolvo9iWOG8VFnK7+tYsK1uXICy3?=
 =?us-ascii?Q?Hs4a+oC7f0xZ63xkMEY09I3wGbg2/6DUHfINc8STPta8Ie8X/EwUcCxyUKWs?=
 =?us-ascii?Q?pDKxKDbUUw6xB4PSIkrCMzMZpY0dzGXBTvbDef8NWzYLsTAk4ztQly8jjBUI?=
 =?us-ascii?Q?yARJ+Cb9qrh70YFFeuJ9/j1F1r66jQ0T8ZmdwxLWiftvSU1hKMxrEORfVbjD?=
 =?us-ascii?Q?L8MSP69lQ5+B+QGIiqray8Dl0I/hZ549JaQaFwIeIhA2+c7m7ufMsDgGED1i?=
 =?us-ascii?Q?sbThe6PRhgEnmt2EzRRyONUfLQUlQPe+1qWD2FEEUGHbUmJlgnmgU89OStQo?=
 =?us-ascii?Q?kL/QWKk8MCTtR/yIF0HLzBueurQiz3EOtFYRwUI0bHNy0J2rM/jx5HZ5c8XU?=
 =?us-ascii?Q?P71SgGbI6UtfMJoorPzLNwo28V3Kt1SPujYMBWGFg+8i4MwgD7pxPqW7N2XT?=
 =?us-ascii?Q?loYnV/Fi8Q/1pllHKzjdBFNoL1insiadfsZ0Yn/2gBDFmMYl6Nl8dIGeC7Kt?=
 =?us-ascii?Q?LhCdrKw3yki2RTgtNyrMBuRJUDXfVxzJW397GpkEJ6msoqhRwCnAYh/PMSx4?=
 =?us-ascii?Q?cYmECNbNu9Rhyt/qGs9iwNVq8qZNlmr7UiF7vDhnySkcb7kmMZ6tkzJo3xNC?=
 =?us-ascii?Q?9Q1Or/1keKMyrba0wLoUIYW6bK6/KJX8QhHQ5yU6wg2i0TdtGviUq4qk5TQn?=
 =?us-ascii?Q?CxrRG2b7KY88q4I1DnxD/5zsjJ/ezUEd5CWEfZprYT8ul0H+KyCA02Ja4QC5?=
 =?us-ascii?Q?Ap3kWHIKbdbpZbM4SSJ0uwZzQIM+KKhtDxk67QDstn0DEw6sXU99fy+oYffQ?=
 =?us-ascii?Q?nCzHYxjYIwKC4govnkU5iiDxrgkKQW7S3E7kLnIIrQl65pDMRYcSEStERlOw?=
 =?us-ascii?Q?OAZTIfQ/j2Z7e/W8CRks4+rhSQpFU4tKt+tsf0GTph1KAdKU/7rnZxYVbo9J?=
 =?us-ascii?Q?Ar+j6lOILCJganvTtA23L32rVXjbtaMXuUyMgTNv+fJFey2ID789qkJjdm42?=
 =?us-ascii?Q?mifG7SRZ58iIfOysOvO0CagFmkecKG+hB8bBKm0EhTlacb9jyQq2TfBVKm5b?=
 =?us-ascii?Q?t6vmCVGqXLVQXnHBVRNU0+MJ9JCSJSuK7ogVPcRsatKZ4UX3Jpu+mLSC4pc2?=
 =?us-ascii?Q?z19u19/vN+35pL9zqFCEs6HafdO2DHJlUp5DMJsrRLMaobJawGfO6hRzafmF?=
 =?us-ascii?Q?BEaJGsdKoXjr5PnEVr74+3CiIkoiC1wtwaik1pTMUT7Gn5CB7zTV7jHNmppm?=
 =?us-ascii?Q?jaB79C3gSpEzu82lHBkHnQrFexX1s6P0QFaibW8hyQFcD0nlKAo3XDebJDgM?=
 =?us-ascii?Q?p1m5ujvi0advhnd6LpiJK1aPFFuOi2R7a3RrV042THGphcEuJr/OlbtlPRyq?=
 =?us-ascii?Q?ubCJCxiP1Ks1zR85JpXexylXni1yNOTuGdFaWIKycOW7I/lQ8RenIthVNaU0?=
 =?us-ascii?Q?zZUKuL48PBCGEOpSQz9e2Ayp1GvlzgCZvR9ut3gljKKT9givJeerJru7N1ki?=
 =?us-ascii?Q?OIRC5/j0YgAdv8RzoVo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84a2dfc-449f-4fb6-50a7-08ddd179471c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2025 04:01:37.0636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIxU1Wcha69InOb4ir2Fs/kfoZHEm0PxoLwfEWjGeyR9IHBqRKr+9NhgfmRA73IXA8lpoRmf6/fxswLyLLYgBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 1, 2025 11:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Allow static metrics table query in VF

Allow statics metrics table to be queried on SMUv13.0.6 SOCs in VF mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..148941d7ba51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -177,7 +177,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlin=
gPolicy,             0),
        MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,  =
                     0),
        MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,   =
                    0),
-       MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMet=
ricsTable,           0),
+       MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMet=
ricsTable,           1),
 };

 // clang-format on
--
2.49.0

