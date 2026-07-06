Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6622C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 05:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7043010E751;
	Mon,  6 Jul 2026 05:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EzKl7RPv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9204E10E751
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 05:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zECLKu/3uSFrU2sJK8LXGQ2278jDteUD5NjVmYTGaxqdfTv627nWFO7vWOC5M8omIgRFAUrxeaQH3mOY+i1o1fk2rcaqsCCwMosEBVbb71JYzhJP10oSZMfJ9+Nq0H76nXqjJsGROGmNyR3Yik6UxYfSPWRvnsIlP60oBhscji2wR2s0Ytc+/6oInwDVQsop/kTlYCCuOrxlkGcfqxodFmKlJXQVMBOIyVkFQGBVI9uTbgnuZyiGCUZDWxfXaPcXdlvTv/9oXXT0DQnMYCZIYiAk3myXvvkLHpILwH7Wu1kDf24J2gtPpefN6xWa+Akcr7bAkA3fppEtwdVWtlBehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIbRMNGg8aeIJ2Mtlvwge8ClO9H9AbYJV8TRRVFFbm8=;
 b=j5K9xvQ/JOx3ENR3hGNi6gxhAe/RN559GMjmEFQD8qhA9u+nBNSpalKfgv1ZHEtcb8/6pKRgEXXWh2qIwYXDtCdj6haGnm3JQ+YVUsRj7ROJijr7wr8By1Qr/DxeAKWHFQ/LT0wU+EY+JZtZ0kzYy+Xzm4C8oa1994erAnHmNja+UvVnUMyD8FmBMTKPeEFGcCpGqXnjXDuuv3QgbcRyRkrylTdwG/oPjDPu6KAX/Vq4eUxxL1ajDmeYj4eikzyZ9Fz8OPZqpoYfne/Z9iHAd/sLHCg0y6XJodYoeIaEFloMFT/ogYKqLZxL8oBZDf3syfDekFr1mojzhCiivfNhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIbRMNGg8aeIJ2Mtlvwge8ClO9H9AbYJV8TRRVFFbm8=;
 b=EzKl7RPvEURK+SOpyr0nxHWfNNW0bitxEPxvr8r9ThJDTqGt9laa7og/lGVtFQ9bhO1P6BH4NtskBL3kUqdCKeoolCt5aI8+SJVbZwQ/gxJ+9558z68zdGEmZ4Vqx4qgzxcJGbFcci/sKNK3EqyPxNzNgwQ3jOcpBEIGdcw7uNE=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 05:42:31 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:42:31 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix smu14 power limit range calculation
Thread-Topic: [PATCH] drm/amd/pm: fix smu14 power limit range calculation
Thread-Index: AQHdDOgh5sPUZbMkHU6TJMrCgZQlpbZf+n5w
Date: Mon, 6 Jul 2026 05:42:31 +0000
Message-ID: <MW4PR12MB680335FF3E056E58A5DB63368EF12@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260706013807.1051660-1-kevinyang.wang@amd.com>
In-Reply-To: <20260706013807.1051660-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-06T05:41:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|IA1PR12MB7543:EE_
x-ms-office365-filtering-correlation-id: 1a0202af-78d6-4d89-d75d-08dedb215fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|38070700021|18002099003|22082099003|56012099006|6133799003;
x-microsoft-antispam-message-info: SwQ26WroRRK9KVa70gT2o78WnbFAh9M/wA4WdCvUfbhBWwDc0r6TJbXbHvO2w0GTNrIRwI9jYVezDoLr5oGZf7jaNK0FBHl5NDAdydSdgpp9rpvnWjTpDXHysc4pFHqnXle2kobAyzTkPJvSuwK6OoYlfA8Faa0nyRpEERoshPQPoswI0Y4oIRwCWB4ebYvghhWcsRswpbOqPCcycNE1vGrjOQigrD92IWm+8R1rPL1BrV5TSAJg8180dv4olziDMy7bQbs1jiw7Kb9PPBILNif1DRk3B9mChbe7e4+3EIWBVYk+qN9wvqyw6fO3dTOpkHUyBf+b9I1Upn0W0Lv0b7+KM9f0Am/anrpaD8YDXjtDwRb9A8dNNwegqkHFZ8haHbTWDAQFFoY8EEXrAFDkXO8+sYb2pEZKnyL0huYB+MW5A3nzMckQvVf3Q/Nc/zMzNny1eBXVfMn2vJDi+8xxWWYlx4JONGhO+VGaecloRabtbZWoqXXnZ/TEu2sHIv+2zLBAC/rpYadh4Q3YuHn8HNBLscDjDC9FtGVRoqvBdf+79CPF1ziKyi9107O7/TCkWXMEPVtk/Pz0nuYdWkjVhgMKoYBuj7GvuSryd6GOb3i8vRG9UxzygWOc5klTX3GS7pwHiVRHfFULCmdgzshPO8u7Xe3PXTZndI0IM+36eUK0+i5tE9ToZ65kXR16Cuhk/qH3iBkhgDsshR31T5gf26OQD8F8KqGI1l9vOFVnZV0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(38070700021)(18002099003)(22082099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zpFytKD/tsCyq0CG/Z02GWK3K4bvvVeNlCoTbzya3BY7hNoeoq9SrKU5bMNz?=
 =?us-ascii?Q?do9hgm5Jsw+hxB4XBhiWduuF2t6TTo1hpQKDF8ikrj5Sk8XuN55DYppr5RTA?=
 =?us-ascii?Q?WA0AXLpOHk1De1pC8U7FWcXmExvyHV7OcY3h5y2UKPDwnKqgUXaN3LaFcKID?=
 =?us-ascii?Q?zjPNn3RwSM2LE7kNm5tPQYKpRb+x98DthaaNmM4Au0rBDz/Ge6AidT35SPVZ?=
 =?us-ascii?Q?9ftt7eNJ6vCTX1kgMri+Wu/6a5cOPZ81cgJKY8KGhVq+cxr3A/hXR+/nPuBB?=
 =?us-ascii?Q?X4iv4RlbFJ8Zmuh/ZtA3b00vVxGLZfjQYuR9p0fjAmvN+03S1bL/MTaxBQ4J?=
 =?us-ascii?Q?K71HsfCxGhaZwMpgU7lyHitSTsUijFl9e1eSTb0DaX2VfDBBgQR6yJmWXhoH?=
 =?us-ascii?Q?HBt0cJnJDG97bztMvFqbKU4VPRuXai0cZ814JvQqm7Wk/zSGtUltohknj0h7?=
 =?us-ascii?Q?I9RWOrgKZCNI+sLT14Q8di+ueT1SmCwN9rfju68H5xhTEsNBlDG4zNehsHUd?=
 =?us-ascii?Q?XqGdiHlOpOWLVTqu1bS37C6/UqQjJbJnjcgo0Dl3KUMISiAxd9QjzXbakeXA?=
 =?us-ascii?Q?cUCnp63pMkzhl3Qp4A4nzr620F+pMfsFUDolODbE/buQDW6PBGNFTBrruDim?=
 =?us-ascii?Q?sDJy+Btpf2NYarh8H99ukHNwUz3nc3AlmpxuOhm7eSGjcyCEXueY58FZwBQZ?=
 =?us-ascii?Q?3JGYgQSbdcndLKi3wMt7wm8KW/uGHZYLCRRt5z+Wwpu2ursqCKcduyT12HHR?=
 =?us-ascii?Q?zvETC6XjYbW/pTTBaNrP0XIGViNWR6dqgGqRbSag1MHZyzxyIDgLr5eN5nao?=
 =?us-ascii?Q?6GtsW9tkTCM2ooq41kYs8e0v5GsHh31xmjBJqViZ6LaYwCWJWns9CBvhGcNR?=
 =?us-ascii?Q?awvZvjZhkcliHimWHIIAf6x6dz1jYppcKq7m9R9pjVIMLHZtUGLg/3YYmrN3?=
 =?us-ascii?Q?tEpEbKg4ebFDKLOML6n1Qtd+5CPCfm3iXfQ8g9E8cn+hOVaKOX0aa5RurLzf?=
 =?us-ascii?Q?81KLsMeaqKygoFO3QhHigMDPG4LFUGx0Q55LjYu43JOcNF3L5P5KSvkKek9N?=
 =?us-ascii?Q?R91fSTers1IpHDWCisMCe+U6LJZw56uFHzcg+wRYKA3tldTLF9LEZ3Cq1bp9?=
 =?us-ascii?Q?xfENoo0MaUbj+0R0PGdhc3v9D8JfHcABbHf208lA1lqg5sTYRZnyQ8tZhQOr?=
 =?us-ascii?Q?WOMIM3+3vp590uJ7ZTBtZK8/+yO0ZxqdylDMVPNRjgn4FvbkNCETPxyJ80mG?=
 =?us-ascii?Q?SjN3Ya6RbC96jevx0WsFZqZZ3fEtk6+ccTls2d+W6BZt0tl0WxcS6mK3k9Bs?=
 =?us-ascii?Q?2JyFs+wcsFZpdyHiZGeTyp3daBN4KPSscw14jtVboh6a4GLtIpw8wZIeDvDU?=
 =?us-ascii?Q?vE4coHuWLnTKVGgDuTrMRLNqMFH3GUiMezt2Blqdh9QE+1AfzeoL9bY0UAbA?=
 =?us-ascii?Q?mxUnaoEa0pVYdYxYpVt337W1+JcfV5xSrropfdnSfXpw1kOYAQb7OMNw6smy?=
 =?us-ascii?Q?2KeqoIADnbO20kxNmONqF4HgUxKNTQooazeEK/AsjATpyGizyMBASnj0w9z5?=
 =?us-ascii?Q?qb0LwL7brTaqNNLPupMK6wLs18uE/z0+btF40EStcwOakBH0DsfHkoUyJGNB?=
 =?us-ascii?Q?ewx18IelaTyejHgwev9A7K2AVuAEiYOtFnf0/j08tUcuiIyCTCefV/KdAa7A?=
 =?us-ascii?Q?wUptxVtt33kBjYFXuLpp8/MhwHnhzXL2eeTl950HtTDAR28R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0202af-78d6-4d89-d75d-08dedb215fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:42:31.7603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3WFj7NqEyVmOGMnIQfR1VzoloyqXGuGhDtKjD37zeQD8s7YGgJNA3p/AeC69VPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, July 6, 2026 9:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu14 power limit range calculation

SMU14 derives the default PPT limit from SocketPowerLimitAc/Dc, but MsgLimi=
ts.Power may expose a different firmware limit for the same PPT0 throttler.=
 Using those values independently as fixed min/max bases can report an inco=
rrect configurable power range.

Keep the socket power limit as the default value and as the fallback for cu=
rrent-limit queries. Calculate the reported range from both firmware values=
 instead, using the lower value as the minimum base and the higher value as=
 the maximum base before applying OD percentages.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index edc5140f6ab6..b8584a1e6bcc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1622,19 +1622,23 @@ static int smu_v14_0_2_get_power_limit(struct smu_c=
ontext *smu,
                table_context->power_play_table;
        PPTable_t *pptable =3D table_context->driver_pptable;
        CustomSkuTable_t *skutable =3D &pptable->CustomSkuTable;
-       int16_t od_percent_upper =3D 0, od_percent_lower =3D 0;
+       uint32_t pp_limit =3D smu->adev->pm.ac_power ?
+               skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
+               skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
        uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power[PPT_THROTT=
LER_PPT0][POWER_SOURCE_AC];
-       uint32_t power_limit;
+       uint32_t min_limit =3D min_t(uint32_t, pp_limit, msg_limit);
+       uint32_t max_limit =3D max_t(uint32_t, pp_limit, msg_limit);
+       int16_t od_percent_upper =3D 0, od_percent_lower =3D 0;
+       int ret;

-       if (smu_v14_0_get_current_power_limit(smu, &power_limit))
-               power_limit =3D smu->adev->pm.ac_power ?
-                             skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
-                             skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
+       if (current_power_limit) {
+               ret =3D smu_v14_0_get_current_power_limit(smu, current_powe=
r_limit);
+               if (ret)
+                       *current_power_limit =3D pp_limit;
+       }

-       if (current_power_limit)
-               *current_power_limit =3D power_limit;
        if (default_power_limit)
-               *default_power_limit =3D power_limit;
+               *default_power_limit =3D pp_limit;

        if (powerplay_table) {
                if (smu->od_enabled &&
@@ -1648,15 +1652,15 @@ static int smu_v14_0_2_get_power_limit(struct smu_c=
ontext *smu,
        }

        dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
-                                       od_percent_upper, od_percent_lower,=
 power_limit);
+                                       od_percent_upper, od_percent_lower,=
 pp_limit);

        if (max_power_limit) {
-               *max_power_limit =3D msg_limit * (100 + od_percent_upper);
+               *max_power_limit =3D max_limit * (100 + od_percent_upper);
                *max_power_limit /=3D 100;
        }

        if (min_power_limit) {
-               *min_power_limit =3D power_limit * (100 + od_percent_lower)=
;
+               *min_power_limit =3D min_limit * (100 + od_percent_lower);
                *min_power_limit /=3D 100;
        }

--
2.47.3

