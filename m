Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280B6C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 03:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB86710E416;
	Tue, 11 Feb 2025 03:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GuU5icqU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1959E10E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 03:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy1ScBgwHPQFezm36epv2hucY1NMFbo1yOMDVeh2SlinbW9cy2qMBWhACUUdDAQxQL1WrgD6P6z21H9TYBO7G0XfHV1dKJc+XUXd7zLbsKX6pseEfmRI4b99PLBA6Z1QmpIj/tFJsHTOUVbIqlhebWmiOOdNcIh5kqD/x5/6CQom/SU49bJwoo3IGoHWakPi9TgXWqZN85SaOz6kge9vx1MpAcXjTXAHztp57kSh1HF+WXIk920SrISi74v6EXyWJhy4deqHh4BafmfCrBetZTUCd/X5AAolTOFP4iiyPOGPDuwUq2oav6EJLmRYAT4hHPUjsBcWZq9CqhmOAUA4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8X2cjqQC64DeLG+RQzxpADDEywkJWmk0iVQAYWZLho=;
 b=eKurADTQHbVM0hFWoz3ty69f8Zsxlwmgx+9XlIZBHgZu20GGwTiGchc65BzCBv2rg9h3OSv+fztRC+WL0bdQuDGq0UAzb4PVTguYbesFH6AOJZxHTQg3r0p9VLDOxt0YpYtT8/PKt76hU5YYfteM8JTnfRbuSKG4bZaeabhVhXZKF/wPEnyQCwM9wP9GVmg+/GRQh+V5Enr+S2TR9f7+QyTSdBMYnBlzJtQDmlyaENlsmUx7rHR537TML4LBC/JLxCdVlJDRte3E8n0VcFfNcBCPyJrFbAvGYWU+vXchVY43qUkviuGd6yBouTCBIFBZX/0MJgb1zJM8OBFvTPzZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8X2cjqQC64DeLG+RQzxpADDEywkJWmk0iVQAYWZLho=;
 b=GuU5icqUc1g8TB1qbkllbD/SaNwS2NnyXrzbWdKmu30KLyn/l21bNj17gREOSa/fFUPryQN4wPqBVhM2awWHCeGjywGG2M5AGU4PUIp/xUJHaTqVZxJ63v6aBpN0Koy+xXf2VerKHdvYU8aHgQTOutGB9SzImqWpgKgqrVnRuLM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 03:57:46 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:57:45 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy
Thread-Topic: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy
Thread-Index: AQHbe5IcesCMCXoyIku9DhunwI60WrNBevlw
Date: Tue, 11 Feb 2025 03:57:45 +0000
Message-ID: <PH7PR12MB599710F422CE043C7B199B2482FD2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250210080149.275167-1-asad.kamal@amd.com>
In-Reply-To: <20250210080149.275167-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4a768826-32e1-426d-b6c1-94bc6f863503;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T03:57:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ2PR12MB7894:EE_
x-ms-office365-filtering-correlation-id: 7b226042-84e6-4d6c-a52a-08dd4a503e17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hpuG+mmkcD8euevZhKuqRbrXyxx9LDj28r9eOWORc9WVq9dXR+KHoYZOZhok?=
 =?us-ascii?Q?nWjN08G/sE/IletQKBBh6xXs1yTwLBIkzWKCrzPd3Fw5df6jhCWOTMLhEaNz?=
 =?us-ascii?Q?ge62CZAPMapGhQLcFYSxygW626qzKdAdugWejyT+ECXurVJobiD2Zf34Yc5g?=
 =?us-ascii?Q?gVbyL5mwGcapHXQyC+SVnGZGz11h7/pOaloujCJ7ZopaDQK7N3RhFrYLo1m3?=
 =?us-ascii?Q?9Gznkk2PYPdmUakVGqx6mfA0P9wGMvHrhZmpS3bLIcQnKyockXHxuyF7hnGP?=
 =?us-ascii?Q?VfdabjxrHKzLLnTATOzZHZNGfWGPcQXrWd8uyolEQBVcc1IOcerElL0B09+X?=
 =?us-ascii?Q?ax4e0ia5c4R9ocISGi8Ho4ktMzHJILcLX4RNhBZTV0NeVht4K9EVQ9rQ1M54?=
 =?us-ascii?Q?M4Taw2Jutao9zKk/275pbDeGbdfebRgRA93SHno1LDvK2ERD5h3fRSRVZVUO?=
 =?us-ascii?Q?VBR7S1N9Qljq4SoUfuXw7o8h6hjTYdFHD0ypZWtU7gg5CuZ++aK8LRPBKOcT?=
 =?us-ascii?Q?tc5lfIo6ri/OhCVsXVsNh61LzgkSBWd7wxpXxG7vmW1mxSk6fa3siRbuwQre?=
 =?us-ascii?Q?h7+pGDYaR+2J+54bn/ZyxzgPJhRBkNBnRmI+lZFmbmRcI2Lc8zbLMoSTNcDL?=
 =?us-ascii?Q?/85epCtni8icUYUfIX8spCYA98Wk2jj3+604iVB6WpIVZXAghs5U1XmKdw0P?=
 =?us-ascii?Q?tm4h3a81LEroLxLoHd2abptNouX3Vv7BP983O1MVDCLGoMXI0Ue3oO41k+6e?=
 =?us-ascii?Q?TNtmfS3/phLfUkwmaDFUTefNO/nt4BQh3u5w2ov5QMX9X5gJSNmcv1zB0cL1?=
 =?us-ascii?Q?NlHGLAqZvm5lNheEr2i9ARKV15UK+ccxYKqeZj8dMLZ5LSGrtaLGyBHxx8ye?=
 =?us-ascii?Q?l0o1glRnxOMaC+JfXs8iuYdPkzA0KgSUGwF0A857/3GKDgLmv54O0fRhccgm?=
 =?us-ascii?Q?gguJpHXfLukRo1irJTQ6UyY+AN28tFYSampSi1AMFC5yYRmI1O32HeMaxvNA?=
 =?us-ascii?Q?1OOk5hUe6plsfFkzKcnSdxj0gf14cLBquWDSB7lHcUxe5IrqsKlJqhXkFxH1?=
 =?us-ascii?Q?wyAcfjt6pDZpQ4n/ClRVoli83ZsTaRxuXG5dMOEGH0nJL6HgplrNdVmDyidO?=
 =?us-ascii?Q?dgtCgSJ9eUkL44d39iH9YxyZfaOcAFTEgIe2Nlp/9AM4GhHwhHVct73OXnWb?=
 =?us-ascii?Q?nvBbzUvl//k5m9uVWaezhsTUClyxYUuEszW/iWehLTuxq2YOtom1P9CZOTWq?=
 =?us-ascii?Q?YVWGHvDoXpCEb33sqsnR14Wc5DUkuVg30sN6FpcW21Yk0XBGe54Zy/bZkOk0?=
 =?us-ascii?Q?i8KuccWWOAi1dfGPSrTWihuL24uz7vSbdayHDdpmB2wJU+irUbV4doMyiryI?=
 =?us-ascii?Q?bxl1KTVoWv6LrgA5u30RXa9qnX/Kvg/AQ7aVCECg8rv8yJE6DzsS7iebjt5O?=
 =?us-ascii?Q?ufP1f+gOefeHKK34zqH72oftF+71tYq+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GF1sTUdRz8elK6ZfzTM8K54P/4F4Ce4S8S4Uhn2Ob4lu1//gyFrPvsIeeDp1?=
 =?us-ascii?Q?mviy9BCiNJxkMK+K1KVkPkBAhfhv8GTbvazcagSlsrBB8E4pPQM8R+PxzVsu?=
 =?us-ascii?Q?hSNsAcPGJaALn7x5lrEbxdUK9HQSMVriTEcQNT30RaVyw49FMBN9RJVMMfoB?=
 =?us-ascii?Q?pY9Gai+YkBXNoFKIZxw0RGpQyGG/+OxYt2/Dm/+HDG9kZH0Ejt0NuaOV71ev?=
 =?us-ascii?Q?25FPTFss2i+V/w9Q9VHvdBjn0gnoYDI53FlAkaipKv4i6cvG4qOpn2k6OyC8?=
 =?us-ascii?Q?yCtpF9cCUEUbiGA2dVNsdiBuvfb/hzmijIo4YzxHkcfJBc3/ECqztD7XEl4Q?=
 =?us-ascii?Q?S9hVQmdkJNKEo9v78GuwIrSBqH5+jEc+8cynJ00a07aU8Y8U0VWKhUq9xOyK?=
 =?us-ascii?Q?mEfg92NGg97YrgiG/fGRuxGUZBO1qXmOR5X3Y15drSxZWMNElh/EnB8Iy8uJ?=
 =?us-ascii?Q?xJuzpTJ8/R83ffp5DF57/K57n8rGZYF/7uSQFbuNRw8AbfBdpfbpPhVq1vmp?=
 =?us-ascii?Q?9SirVdtvmXziFqMw9Uim2w36n2rfZnZORKW71p6C1Fz0E/P6M+5pAaLob05J?=
 =?us-ascii?Q?ESL5lrvLeyT/0XdNciXny9QVhk0LoLCqVtwKPTnLOWLG8tAV4qav+or39Yai?=
 =?us-ascii?Q?yo43F8ylg7itlpmJQIn2xm3dwsGJoqQS0B7dEJwemAfIfhMOohIKgJYYEqAh?=
 =?us-ascii?Q?ARNG+AbXtSQaPUTFHJdptfDwTIHr7+kXLI1dsWJjnmy0dMVpagQ1u9y0tVDH?=
 =?us-ascii?Q?07YF5fOm1qn05/dUBkefR70HULyat5tVWjK/eajLBHoaaehMQlkxvj5NRCdL?=
 =?us-ascii?Q?aqSG8e0Z6GsMMJqNp/IDRTvmgP3Da9SJuRjzN+akOn79Ut8mGXSwkzm6qjn/?=
 =?us-ascii?Q?k25KU2c6nl+QsG01ECHZ8AZuU+v2C566CCDS1OF61/6IfnXwV3HuMmZHMpJ1?=
 =?us-ascii?Q?sWNZBNoHb1fsi/qZMiM8F4DnfwxCWePmNLY2C/o2vkDEZ9Aez76thRIbkxLO?=
 =?us-ascii?Q?54PBPF95JgZWOCAHJcNMUbVE+hFUMJt29INsgSJG3q+05fx3Kr+EYTER82fh?=
 =?us-ascii?Q?Lwv6Tfa7fweb8XbgepClCQujOVex9odQh704mY7guN/pAHdDQI39GBS0sYfm?=
 =?us-ascii?Q?6euXeYOTbrIP+yH14YeWgpBvE698y05IFS21wnCR7olVtAend6NXSsyIsVbR?=
 =?us-ascii?Q?FwSizT1ENzsdM1DcKZrh/xYoH5rwM6O3KPUo0TALt2RHKd7vzWe4oAuZxDGe?=
 =?us-ascii?Q?Qo6rPgBDF7GFohcEyzgdWFGELGb8l3ZnUxGoaYwHnn3jkM7RMtcKQw1WN3qb?=
 =?us-ascii?Q?wkWhlxQDnM+2j7uT3KbWcptmsSt2Xdq+jTC49Strk0vgj60tCSPoC+j5kLlp?=
 =?us-ascii?Q?TBdiZiXRWZTTChA2WVhsoOcD4lqbAbwlyqeAQNbJFxr4+WnAHDaEXYCGXk8x?=
 =?us-ascii?Q?Wuf5gL7rVClQc7n98KsJX0lwl34eVnvLa94AWdHDoZK3btxW2sbhvg3URMJ4?=
 =?us-ascii?Q?4Y9paMpsRCcBF2yY79zh2pZDjivzKqqPXKP3A+RrFqv97BYQ9Ieko4vnKAEV?=
 =?us-ascii?Q?1Ri2I6WGUc854tBdePY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b226042-84e6-4d6c-a52a-08dd4a503e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 03:57:45.5415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pFM7S1c+iddUYq66HdszZqzZBe3oE+HLnxWzmCGY+qpZsEjIo5IZUKbqQiB6al4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad Kam=
al
Sent: Monday, February 10, 2025 16:02
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy

Rename pmfw message SelectPstatePolicy to SetThrottlingPolicy as per pmfw i=
nterface header for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 147bfb12fd75..288b2576432b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,7 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_Message_Count                         0x4E

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index e4cd6a0d13da..9ccd5a1986d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -273,7 +273,7 @@
        __SMU_DUMMY_MAP(GetMetricsVersion), \
        __SMU_DUMMY_MAP(EnableUCLKShadow), \
        __SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
-       __SMU_DUMMY_MAP(SelectPstatePolicy), \
+       __SMU_DUMMY_MAP(SetThrottlingPolicy), \
        __SMU_DUMMY_MAP(MALLPowerController), \
        __SMU_DUMMY_MAP(MALLPowerState), \
        __SMU_DUMMY_MAP(ResetSDMA),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d645387beaa4..3fa671f4981c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -192,7 +192,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDum=
pDW,                 SMU_MSG_RAS_PRI),
        MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMo=
de,                  0),
        MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),
-       MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstate=
Policy,              0),
+       MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlin=
gPolicy,             0),
        MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,  =
                     0),
 };

@@ -584,7 +584,7 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct =
smu_context *smu,
                return -EINVAL;
        }

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SelectPstatePo=
licy,
+       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+SMU_MSG_SetThrottlingPolicy,
                                              param, NULL);

        if (ret)
--
2.46.0

