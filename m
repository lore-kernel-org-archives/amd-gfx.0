Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04994C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 08:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0AE10E72F;
	Thu, 31 Jul 2025 08:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZ7JDAsK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8408910E258
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 08:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td0eETDwyNx7zkE3scGqZRSopXWUMZDvT/f5n4gczYG3DSnhgbR07EzHDJSKTkqEQBvrahUTTYKP4I0lxyiGtm3yi31hQ7xdpeozbxzygmhli2VIuX6jDj1Lf1rSNGygzli/iiFUKTgS5fRFgsthgCd9eVQ9TyrlPBK7P+LiTT/XDnuvAVrq3ibS1NbqU6+3b5Se4kjJXImIsYH3yN2qtB5FjjM8zDa1U06oROeVty4FLV8ieg3ZmiTUfh47GR0L6f5rKU85fEO+AntzNKDBC30qxp516p9pdikT/pjjk2j0IOIk4q+suuNxMSLHN2VVU+GISjNW6dCjEHOPCXipjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z7NzMUTM9P/fCa/0MYXpQlo0b2uZwyaMsG2WgjF0SI=;
 b=nwHUhE/DKNn1gDX6h5PJjwMggP4Weuk7xIMMKJZ6HfUVa1LiCwkHqVHMP5yNZvHmFVwVL1VyM+T8YxHwqtgUElpitSu6igGwVamV9HqTpQcI1wqTyHkRjdaGTULyz+d36q4QuuhFLnpDoe56ndoGzB98IhG7ewo95El85V8RGTbxUOlGdcuaaa/xn7Kns14a32DKjAAwaU6LNAFbBtodWhZis+YGwJfNTvBXJnjS4m3Ub4hrwScD9KTvbxI3iqkpvjVLm0JQcIHo/8NIdZLyNTqyX6hD8tmgKLfV8phffMcVS1yRQMVClDBRxOvsMd5cBLxpxxGoGQpLzyJok8W8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z7NzMUTM9P/fCa/0MYXpQlo0b2uZwyaMsG2WgjF0SI=;
 b=BZ7JDAsKBb0YbJeF4CW91WdRxLDzE45+DR4LyZpS46ytBfHxHhF5TFOmCe7pG3IcnDwRv+QEibDJp/JdFeRmbx8qRzuurj3U+GcBWEQyoxg/9Mnjg3o2k90UWqyxdAmQvDnibgJYfQQI/XopQqbbs4lddzDFzTTa8pueg2PnV5k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 08:30:37 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 08:30:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Sun,
 Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
Thread-Index: AQHcAeG63+oeKV+lMkKUNDIbb6omVrRL5s4g
Date: Thu, 31 Jul 2025 08:30:36 +0000
Message-ID: <PH7PR12MB59975C7A637B78C04BAA82C48227A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250731060920.1694915-1-lijo.lazar@amd.com>
In-Reply-To: <20250731060920.1694915-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-31T08:29:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL3PR12MB6522:EE_
x-ms-office365-filtering-correlation-id: ae37474f-b3d3-4f2a-a2a1-08ddd00c8660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?J/OCVs9jcm0yv38zkRWggdJS3BTLB5dKsbNaHfnMq8Xp5FcE1AN4Tjd1d5hS?=
 =?us-ascii?Q?v6Q9MvWgjJCakEfojYiRRMZ3Cs71PP/zy4vmRlFqs//Ivb/KNrhLhjtFxvLH?=
 =?us-ascii?Q?3H86U3UbpuyiMdbxS8SP2VOqohI5Duz67A5emOuhqRLQ24ktxTIGbCCrrBTX?=
 =?us-ascii?Q?YnsDAzwtbxwuF3ROrrn6xiNKeyEzskQxslemE/42iNgrv9BfoewSiC6AWqlp?=
 =?us-ascii?Q?YlLXrYQb9SnkL0YF5AtDkofn+2Eh4CSgf3Hko0UKoCBUL4SOxqchaYKN7U6m?=
 =?us-ascii?Q?5sC/M+drhYrZVKMLUrUroAQi/0vsFe717OLrlzo5kEhf59RSMrAmQB9YKqG/?=
 =?us-ascii?Q?UsOvcGJHB/ykiagUZqXmAsUTymWo5JK8rhQgxjfBu3yKRfML6J4MXZLiQpCL?=
 =?us-ascii?Q?VJPZhl70yRFwWPGgFqQXQe1aS9HZ211gRJcKOcfAQFTBDs0dD/3O33ME0hzm?=
 =?us-ascii?Q?HyReC4WeFooVMNo77ehfbWqVCaroN8VSNVRiye64hHCGRpgIPsL5koGgXA9h?=
 =?us-ascii?Q?lIO2omQS6XQA3ygmvMxqmwhxirZkkVzuqZWacFf9sHbcYMTGua+RmzB9LBQI?=
 =?us-ascii?Q?0E44JzXMpQJh6sYxJUQBYHXvdBTssHwp4Ed1PAkF2mA0fBEEvHZEqGzUljMD?=
 =?us-ascii?Q?hCnwSZ26bFu2Ai2v9J7eEQKAYImUBbbHucbC90ZEryIaYKRGII8eGcv3gTAm?=
 =?us-ascii?Q?6ckAWlaEbLBprl7TE0t7SsVnXkK4bwCw+EFTr2cx+HPKTyVhxAsLI+fvWT1g?=
 =?us-ascii?Q?XVtMpXk8to9lJ/16iB9tKIabvQXRKI/06znFLfJbij1jS/odNX30F0bTzRkv?=
 =?us-ascii?Q?BOWvO4CCwrY+tABg2iMwpdY0/Y7som01QoA0g28Y9FXEsQ7BrFH4b0EgimFh?=
 =?us-ascii?Q?1Oh05T47SeKluCtB953aSsijThRpCmeee2swPz1lJE8VIzcLV96JnN9diZ4u?=
 =?us-ascii?Q?n6hSKsd/+BW9dIqhDZsayxFbaXGYj1mf430Jy2xSd+Q1uV2cXMEP7JFIVNw6?=
 =?us-ascii?Q?7vVkGeHGVkLAANgOK8VrGLG9AG/tdIPq+5cwgjeA+hEAX32hHJAnD2OttKde?=
 =?us-ascii?Q?96Uj9+f1ywyxsSY/byK72hGE7bY7H9Lr77ZKg7NY10PBHv8E6se17E1R5dqz?=
 =?us-ascii?Q?lIsup4mWyvTUxK1gJnwN2GzqzCwKFmJCzR2qdvovv56GniI8IkJHbReisa2n?=
 =?us-ascii?Q?/7Y8Rku0RTG9QtFqngggBkQwLom5dGTrxAs69FRwLmyWLHX6ytvuxezwEz4S?=
 =?us-ascii?Q?BhrNdVYXAh6U0rqg5NGIXx/kH3TfJJgeS5VL39PZ/hc7/vskrNmC3HaMnK6A?=
 =?us-ascii?Q?IvDGdeZNJDhA3MK24ysJOI8dGuLYb3gaWGaz4ikhXykgYHs2L4zUjZqLm4ug?=
 =?us-ascii?Q?Thl4oE+1FYE29WX0eO/wHXDzqHap4deLPKsG7O8hR9UCkL0g8y2Up8CEuhwt?=
 =?us-ascii?Q?kAW+5xJ5MdWwDLFiFjLGQpWsnOwQvz6x/qok4lpyrl2tGaV/IEa5tA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OgKtEZvFsau2OFQLV67JFa+vMMyd8EHjnLyvaC1epGCfBkRsLC37loaWgWVS?=
 =?us-ascii?Q?Q6BMkVWapcLL7NKS3mLuuhXRPATjI0j8ZkEjfQklHDKR6MKcttb3mg/d9t9O?=
 =?us-ascii?Q?R+wO6tKz2Lycvuwpn2KTiJKEq40usqI3Wv1oS7KS3KoPx2GzaK9cG8RWuGbM?=
 =?us-ascii?Q?XKce4XbMz4ht1FMyZLTKdqEPGNF/EhoK7V8+kAVODFwQgdhmHbm28TVEvTLA?=
 =?us-ascii?Q?Wbz+dPETDkAj5daRVs12lCR0Zxk3t+TlCuJecgFxd5x7IZIFatp+9CZw+wfm?=
 =?us-ascii?Q?bM2qR3iFXsvQp720t9n1Qg5yrfpcfmRlD8a5KoiHojieYBMD+ewP3P0L1Bac?=
 =?us-ascii?Q?JgzCa4OhOc9eaLbu9jXW757tFT6s90Og4ZUuHhTwdv31vUdO+Wne2gEyPV5b?=
 =?us-ascii?Q?gbzkGxBIoPjyAi+S4XjmPnkCOKHLu1jRyNwH3wlqEk5RVgn4+kiLHNaeDDLx?=
 =?us-ascii?Q?f5z/gxu4W3tOru7+DQk5rmoMblFJ3Hr0rBekdCuSzWrysZkz5W/fSJMQbQ1F?=
 =?us-ascii?Q?8KR7gQlUfeD1BWJKoKNrWsqc69unTPq4YGqeMjYltg1/2EO9SFEpoyLd6ytE?=
 =?us-ascii?Q?NgnwsSR8eDwpLm/V8MLvGaAJHCO8RVbkcaPIixeOtiAUcr8Z5OlIbhje79is?=
 =?us-ascii?Q?SdaidETI+10exgWGmCp6Tgsw4iNrMrAon2tzOGEQDGktJVZw2y+u40U2cFA7?=
 =?us-ascii?Q?uiJBKtL4FT6+8p+truY717k0OJJpMnEm/bDs8TI8tgQ5CG/z/VIh5jGPHs7e?=
 =?us-ascii?Q?byu4BdJcnZcTvnJzb41pxaEZEcC6uoHHS/2zfpsm/NuNRLeKBr2P7IQKKz8L?=
 =?us-ascii?Q?6Cn1F6Q/fh+yswwC5t9wl0TsMYsNBuRZrN39LjlzlQ1+IPNJ9XnjjoBIs/Ap?=
 =?us-ascii?Q?O2EEGrWDR90aMU6MtGOnujOD597NjhIC3/X+tb1ExO5a7Yjj84qmuAJO0VdP?=
 =?us-ascii?Q?kFn9ECA7ooatkeM5Vw0FIJje2LfTvlk9PUDInMgvN678LOXLCqzkvyCueJLu?=
 =?us-ascii?Q?bT5dpJlf/zqf+E59Gtyttcxb9U/lOwnIdYcECbuz7C7awE03tckl6JcE83kl?=
 =?us-ascii?Q?LRxTA41oAPB1a4CGTCo82ow3cUcTIo+xXfKeKCblB9f9s/MACYNR6tVz/RVG?=
 =?us-ascii?Q?Kcwjv+5bop8IYhYaBO2CFCxSS639elzeEVKi6xsj5gz/RlCxgYKKhAovhUVC?=
 =?us-ascii?Q?Wlcq0M8R6v2oEez3HoLGJ5G9LueMG0URC6jd5lZZpqDIfdF28zu+0MUKuLaL?=
 =?us-ascii?Q?59mrGcrtsQqXPQ+DzuATqeYh9IH/5ilLXlmBSc5H9Z89znqTY0jnC5rE5wBs?=
 =?us-ascii?Q?EE5shVp2B3YxPpwycHLS5eiZ0ao3U+lGykWwHlW2VH1Yj8qkWlFTseZfO8mT?=
 =?us-ascii?Q?UHRMEvwzjg0JKQePq+8A68BTwi0BoZ1t1I+8c3eo9YgKqHBJqRc/NaBnYm6m?=
 =?us-ascii?Q?j39pD9bZxmbdkvtCmNdW7flPiJP+2DX2DMp4+JGdVi+hCKo61wfXj3ekD8QE?=
 =?us-ascii?Q?G913KRvk8KEnQOdEO12OyQL4poX5QOUQn9r5DASqYDt8rT4U2nZF1LhgoLk7?=
 =?us-ascii?Q?YgFl10m3A1U30famyZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae37474f-b3d3-4f2a-a2a1-08ddd00c8660
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 08:30:36.8702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JqeDcIaPFQjndNl8Fu7wCq/ihPeaqWF6UEHFRe37cT7OI/Owk2buSqNa0uk2oA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

Patch looks good to me.

But I prefer to add a flag such as "link reset" to indicate that the respon=
se register may not accurately represent the execution status of msg.
And mark this flag in the necessary case (such as reset/flr). And the check=
 of the previous msg response can be ignored when the next msg is issued.

Additionally, this should belong to a global state of an SMU/PMFW, and it d=
oesn't seem very reasonable to bind it to a specific MSG.
What do you think?

Btw, the msg of GfxDriverReset/FLR both can cause the response register to =
be cleared.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, July 31, 2025 2:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Sun, Ce(Overlord) <Ce.Su=
n@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6

Certain messages will processed with high priority by PMFW even if it hasn'=
t responded to a previous message. Send the priority message regardless of =
the success/fail status of the previous message. Add support on SMUv13.0.6 =
and SMUv13.0.12

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 14 +++++++++-----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index d7a9e41820fa..aaf148591a98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -469,6 +469,7 @@ enum smu_feature_mask {
 /* Message category flags */
 #define SMU_MSG_VF_FLAG                        (1U << 0)
 #define SMU_MSG_RAS_PRI                        (1U << 1)
+#define SMU_MSG_HI_PRI                 (1U << 2)

 /* Firmware capability flags */
 #define SMU_FW_CAP_RAS_PRI             (1U << 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 02a455a31c25..17e0303f603b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -106,7 +106,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_=
map[SMU_MSG_MAX_COUNT] =3D
        MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqBy=
Index,               1),
        MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,=
                     0),
        MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,=
                     1),
-       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  SMU_MSG_RAS_PRI),
+       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
        MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDr=
amAddrHigh,          0),
        MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDr=
amAddrLow,           0),
        MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDr=
amSize,              0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..c22b3f646355 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -145,7 +145,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqBy=
Index,               1),
        MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,=
                     0),
        MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,=
                     1),
-       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  SMU_MSG_RAS_PRI),
+       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
        MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDr=
amAddrHigh,          0),
        MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDr=
amAddrLow,           0),
        MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDr=
amSize,              0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 59f9abd0f7b8..f1f5cd8c2cd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -256,11 +256,12 @@ static int __smu_cmn_ras_filter_msg(struct smu_contex=
t *smu,  {
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t flags, resp;
-       bool fed_status;
+       bool fed_status, pri;

        flags =3D __smu_cmn_get_msg_flags(smu, msg);
        *poll =3D true;

+       pri =3D !!(flags & SMU_MSG_HI_PRI);
        /* When there is RAS fatal error, FW won't process non-RAS priority
         * messages. Don't allow any messages other than RAS priority messa=
ges.
         */
@@ -272,15 +273,18 @@ static int __smu_cmn_ras_filter_msg(struct smu_contex=
t *smu,
                                smu_get_message_name(smu, msg));
                        return -EACCES;
                }
+       }

+       if (pri || fed_status) {
                /* FW will ignore non-priority messages when a RAS fatal er=
ror
-                * is detected. Hence it is possible that a previous messag=
e
-                * wouldn't have got response. Allow to continue without po=
lling
-                * for response status for priority messages.
+                * or reset condition is detected. Hence it is possible tha=
t a
+                * previous message wouldn't have got response. Allow to
+                * continue without polling for response status for priorit=
y
+                * messages.
                 */
                resp =3D RREG32(smu->resp_reg);
                dev_dbg(adev->dev,
-                       "Sending RAS priority message %s response status: %=
x",
+                       "Sending priority message %s response status: %x",
                        smu_get_message_name(smu, msg), resp);
                if (resp =3D=3D 0)
                        *poll =3D false;
--
2.49.0

