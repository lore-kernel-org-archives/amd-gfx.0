Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F30CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 06:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D1210EA7B;
	Tue, 19 May 2026 06:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQrgqqO2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB4510EA7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKcawLHekwKBymp43b5LfLUE2Q0QbuiwgUMCVmKMEn0eI9w25ttFd/vDMmdwS8VZ74udQL7NuNZyf6+cTgoMRVpO85ZCgh5mIv5G4WSxI7NP5hYqf03CwjhN/xLu5AdslUd2VfsvVAfSt770b5/9MKNwboaVnWYFQPlcH3SPcsZemojQd8vZ6M87xmzNkIROl9TVSJUskbEoFBfaMJ8OGlekZydsSJ1FnFgrIly6lksRV8mwRilJioo4EqgWMEaPjB1gpnHai+1c8CzBT91HA38aQe/BSAJfIumdwtEMKRBpqTl1NCusx0pKtF1jYrN0m96KK480ci2tmE4kFZsJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q60QNZW26a6jxpXQwo54e9mTZQEjwq1lh+fJE+UWwpw=;
 b=HWcEE8R4GN2N1BgC9kMK9ql8Mn54ne7/Z04GSK0bCXOJCFwljRe1r6Hc5HGi/6BON3g37KzDcK1gmUxZY3Wt+egJi5+WZTJfnRnbnoqPKUNlebD7bhAjUcZnLi06lx855JmwhLRxJYfGvO6HiT6XZv5eXo19NjG3D/26qnPMkbmzwpt8v25fXyMxEXupyMnLiJkMvnYYbjmuTfsKHkCAtx5KtyoQdc+4tpYm7X5lJL+3s4Iavd6fipe1X7GpNeAJLU6K3Cjaysb+qkCBg9eWbdzFXr/HX8I6qBCjNgXEpjpFDrRbXiogNPiZ8voLg9zBMF5ZiHFVOzlIY9UnOAA38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q60QNZW26a6jxpXQwo54e9mTZQEjwq1lh+fJE+UWwpw=;
 b=VQrgqqO27JGqVgV25JN+fwjIAfTPGV4IIaVwZlBPYc+BumKxf3D0FGDo0smsMi96aTCjmfj3yqMI06ZSAl7R4RC4HPiwdW7YEZl2bm/zhcsMQ46bvEkyuh/+c2lmmK8d4x65L6oVy2LIqihlAMaU6+8vWHidILpCbyNNpHeeXJ8=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 06:18:55 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 06:18:54 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix smu13 power limit default/cap calculation
Thread-Topic: [PATCH] drm/amd/pm: fix smu13 power limit default/cap calculation
Thread-Index: AQHc50aTidOXD48KpkmAV1XpBmtzXbYU3w5Q
Date: Tue, 19 May 2026 06:18:54 +0000
Message-ID: <MW4PR12MB68039CFC203F44150D6461128E002@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260519041822.552663-1-kevinyang.wang@amd.com>
In-Reply-To: <20260519041822.552663-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T06:14:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|IA1PR12MB6307:EE_
x-ms-office365-filtering-correlation-id: 77886153-60a8-4afc-1e38-08deb56e8102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799003|38070700021;
x-microsoft-antispam-message-info: Iv4lnNowHLJQsv+czwfgZJvcDRbPLtytpI/gADDiLkscVvu+jdLW8Lc/PoRcqr3iQYwFm+THBMiJA/ZUtZsEq0ODxkNkpUFHD4LinXjRvDqTJykFOrZeGkxVtHCFEvU2y2022g0JiT5HS/H57m+hASA0q6FGSRzsfVnMgD164IpxDQ9SSW/cJXg+VV2gD8SDtMhU5YL+A2R7H5hLxjugDMG3JC9ZwZR1hFeEvwQNIdDgvB6yhfi9kiWTsEWjdbYHoAvHLpwtuzFWp4UMHpObzhYJPpjaRPS8sBle8Obd4vVVNOzoNh9n3kpMqwu7sXTzi9YhY7FK7QI2tbqSetMh7b89ZbUq7I8yWMxpLg+S9rbsLWYYFxfAn4h6/9PEzE/egcPhzVDZH5q09MCGCiO9h+eMn/yHr25kjrl/+uWwAZzACYChDoN6uanubWN0dtYP9uBrY6ClKEpDCJNOfF9ZvrD1xThI/s4YHfk6WPp91vHxvigl6stRleguU4wPYCJUtl8ki7r7gVIULNzeRSXedHMu7o4NidFUaPl6ge0UI7TYACC2dmZlQuKTcaJdUIG+sN0N/zN3bkIa7uykcGvUSsJb0IzPHMhbc5rFZ7QAU03xoGYKKe+GVs3GNDDXu4J2sggwMHG3foMwjYag2E2qKG5tCbCr5Oz1cJptL890R8ATnWO/qG5O0/PINp7r43UYuKfriUaim0Qy2w131O2wkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7hcwoh+HLM5//eA2huVBSC5KbleL9AyZkVT9ofcgiPUjV7wa8WG5APurdNVg?=
 =?us-ascii?Q?AXu5THQI4CklN+XnkyLFZleTK38JXmm01/XneSu2TV3RbcLovHh8ZBMeHVrK?=
 =?us-ascii?Q?IyXWtVBCIJO7DyN9rpkUmp+bPdBgF98Mc+hQrneexVfgIHmkPHin1G+tqkFX?=
 =?us-ascii?Q?w/ntBKuPyUxg6OQSxVdv50mFFP9iAqeMq0egSrDZX1iS2pL1pGYV4oWy+4R8?=
 =?us-ascii?Q?YMkjAAx54BSvHZXu1+lpZ5yMnDLkAz2Oi57wlRNZzHAbiKWDXvMXhi9leWEh?=
 =?us-ascii?Q?k2JzR4O0fAnj/PSSLzQRVx0IPNDlX65vfEFGRT5xnrjdvLwWcnqRXu5gNcls?=
 =?us-ascii?Q?jk5I7+nHDG/pQqZclU/ZNJmmsa6TsC0RsbSNNMQXZ8wU7zgFG+N/OBueLDlM?=
 =?us-ascii?Q?ripqS8yhu9NNgsZrqqU4/y7h4O+cV3hnuyztFF9G/qWkAAWQjbKQxl3AnIxC?=
 =?us-ascii?Q?tzc1tmJ3j7nLgr70KTUxT9t09231PxXJ2SC3LRGj4Ln6mC6rIgqqEAHG8dhT?=
 =?us-ascii?Q?4/HkLjwEgnqfwjLFebERqnmL8Uhdh6964bLgB0CPvVIfkxUL3MaQUPYW6mFv?=
 =?us-ascii?Q?sm925pMMva/j+fVn7ctTxFCj7/ukF3C2qZO0+HVCbz6YJnHpphwZpNDgFDzo?=
 =?us-ascii?Q?E6xR9TIx4l84s2ndVV4N+ZZJ5M7fKYgvrlDjTbWnHzZJTDOGx38vgCGqC5ci?=
 =?us-ascii?Q?UpVd1OEsFtAgg/gZ3jnEBqunnCmtlnouwcbqg7GYGJX7IwPB/I1DeHdVmlh9?=
 =?us-ascii?Q?Tl5NkFhQhQvHQNB/6Ys4APJjm+PfHlL0YS9+qrh1GOD/rENXP9lV7ZTTYIEA?=
 =?us-ascii?Q?R79fVGZCG1gjpTqxZvN824Dt7o8Vyobqm3ondakuoekWN2Gwry7O3nDV1l3x?=
 =?us-ascii?Q?jxNVBCzB12+1X+98mtgliRUKP5ESgIfOe6DqkGR6pgHkcDdUL/dG2hsSXqCw?=
 =?us-ascii?Q?GIhKHb5VEsimxxwPBHJ/Gp15mAFA/le9gIQG7cOEBh1TQZGbOwWz2aJoDRfY?=
 =?us-ascii?Q?8HoAKWF+Fmm+8hXUZA295upUVKvFNC2R3W+cxEmRc2rQ+VASNvc/y2wq81fG?=
 =?us-ascii?Q?rDtguaVi6CCxiy89bxAHaCptf5tVkyXl2C7aCHEKcFBxFTdGMnEI0r9miStZ?=
 =?us-ascii?Q?tAPcBNJdWpUy8lnpxVRMBjAFNipDpTxoLirUam46gzISwN0kZ0paT2MqzmJF?=
 =?us-ascii?Q?yxScUclTWI9GlggOUdipH+xBZtB2V1cBXF8MFYX3t3fqPBGl+MfnOF35fFFL?=
 =?us-ascii?Q?6x2ybIQx7E7ji/F0VMLtkDKiKQszgmObLSWrIM+fcrfxQcjii6YEm2OFK+qu?=
 =?us-ascii?Q?TqgQWz9cvWA5hgvYPVhJ6TxxvTcADFvBCL5eYYAoEYgrbzBlmxiQS8Yumcxq?=
 =?us-ascii?Q?a1ifh0lRBLK+q6NqMW2H4gTtlw7dYD5ZaOcCKLqusUvBeT6NPtZj43aztOyt?=
 =?us-ascii?Q?ld6zx7CIAiSYCvC/zBqAglDU4Yj3nDWqcyqchPYadmd9LXVm4MUstPCibfIP?=
 =?us-ascii?Q?6cOPgCB6FUjaUXRg/4CgO8Znf1MegINda4cG+qyAKTxJpr5IvwNGsFmAlcGM?=
 =?us-ascii?Q?4YBgzU2E8od4p9ekXvviNfK0WlXI6oMNcBwLl66D6doiOcLbFDpNn9XSPafx?=
 =?us-ascii?Q?icxxp9BNhi54J+vLjh34xPT2LC7+Dpz1VF7CCmCsNylnGXLGiLkKkRyAR07H?=
 =?us-ascii?Q?HzvkMza8pj/B/WgJqDCRznV0poAFzdASLvAOJJzF5K7MixKR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77886153-60a8-4afc-1e38-08deb56e8102
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 06:18:54.8012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WeBPRu3gRuZnuRNWX1GyrjSQ0M/ul5+tO0SKL36e+6naM3yW2eg5APsFGnurZycY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

msg_limit is still valid, but it's ok to set max_power_limit based on the d=
efault limit.
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, May 19, 2026 12:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu13 power limit default/cap calculation

smu_v13_0_0_get_power_limit() and smu_v13_0_7_get_power_limit() mix runtime=
 power_limit with PP table limits when reporting default/min/max.

When current power limit query succeeds, default_power_limit was set to the=
 runtime value instead of the PP table default, and min/max could be derive=
d from inconsistent bases (MsgLimits/runtime), leading to incorrect cap inf=
o.

Use SocketPowerLimitAc/Dc as the PP default base (pp_limit), keep current_p=
ower_limit as runtime value, and derive min/max from pp_limit with OD perce=
ntages.

closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5227

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 32 +++++++++++--------  ..=
./drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 32 +++++++++++--------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 30d9cfac0d89..9e74a5c4be43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2391,28 +2391,32 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct=
 smu_context *smu)  }

 static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
-                                               uint32_t *current_power_lim=
it,
-                                               uint32_t *default_power_lim=
it,
-                                               uint32_t *max_power_limit,
-                                               uint32_t *min_power_limit)
+                                      uint32_t *current_power_limit,
+                                      uint32_t *default_power_limit,
+                                      uint32_t *max_power_limit,
+                                      uint32_t *min_power_limit)
 {
        struct smu_table_context *table_context =3D &smu->smu_table;
        struct smu_13_0_0_powerplay_table *powerplay_table =3D
                (struct smu_13_0_0_powerplay_table *)table_context->power_p=
lay_table;
        PPTable_t *pptable =3D table_context->driver_pptable;
        SkuTable_t *skutable =3D &pptable->SkuTable;
-       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =3D =
0;
-       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PPT0=
][POWER_SOURCE_AC];
-
-       if (smu_v13_0_get_current_power_limit(smu, &power_limit))
-               power_limit =3D smu->adev->pm.ac_power ?
+       uint32_t pp_limit =3D smu->adev->pm.ac_power ?
                              skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
                              skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
+       uint32_t power_limit =3D 0, od_percent_upper =3D 0, od_percent_lowe=
r =3D 0;
+       int ret;
+
+       if (current_power_limit) {
+               ret =3D smu_v13_0_get_current_power_limit(smu, &power_limit=
);
+               if (ret)
+                       power_limit =3D pp_limit;

-       if (current_power_limit)
                *current_power_limit =3D power_limit;
+       }
+
        if (default_power_limit)
-               *default_power_limit =3D power_limit;
+               *default_power_limit =3D pp_limit;

        if (powerplay_table) {
                if (smu->od_enabled &&
@@ -2426,15 +2430,15 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
        }

        dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
-                                       od_percent_upper, od_percent_lower,=
 power_limit);
+               od_percent_upper, od_percent_lower, pp_limit);

        if (max_power_limit) {
-               *max_power_limit =3D msg_limit * (100 + od_percent_upper);
+               *max_power_limit =3D pp_limit * (100 + od_percent_upper);
                *max_power_limit /=3D 100;
        }

        if (min_power_limit) {
-               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit =3D pp_limit * (100 - od_percent_lower);
                *min_power_limit /=3D 100;
        }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d253ce367476..481908913dde 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2373,28 +2373,32 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct=
 smu_context *smu)  }

 static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
-                                               uint32_t *current_power_lim=
it,
-                                               uint32_t *default_power_lim=
it,
-                                               uint32_t *max_power_limit,
-                                               uint32_t *min_power_limit)
+                                      uint32_t *current_power_limit,
+                                      uint32_t *default_power_limit,
+                                      uint32_t *max_power_limit,
+                                      uint32_t *min_power_limit)
 {
        struct smu_table_context *table_context =3D &smu->smu_table;
        struct smu_13_0_7_powerplay_table *powerplay_table =3D
                (struct smu_13_0_7_powerplay_table *)table_context->power_p=
lay_table;
        PPTable_t *pptable =3D table_context->driver_pptable;
        SkuTable_t *skutable =3D &pptable->SkuTable;
-       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =3D =
0;
-       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PPT0=
][POWER_SOURCE_AC];
-
-       if (smu_v13_0_get_current_power_limit(smu, &power_limit))
-               power_limit =3D smu->adev->pm.ac_power ?
+       uint32_t pp_limit =3D smu->adev->pm.ac_power ?
                              skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
                              skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
+       uint32_t power_limit =3D 0, od_percent_upper =3D 0, od_percent_lowe=
r =3D 0;
+       int ret;
+
+       if (current_power_limit) {
+               ret =3D smu_v13_0_get_current_power_limit(smu, &power_limit=
);
+               if (ret)
+                       power_limit =3D pp_limit;

-       if (current_power_limit)
                *current_power_limit =3D power_limit;
+       }
+
        if (default_power_limit)
-               *default_power_limit =3D power_limit;
+               *default_power_limit =3D pp_limit;

        if (powerplay_table) {
                if (smu->od_enabled &&
@@ -2408,15 +2412,15 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
        }

        dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
-                                       od_percent_upper, od_percent_lower,=
 power_limit);
+               od_percent_upper, od_percent_lower, pp_limit);

        if (max_power_limit) {
-               *max_power_limit =3D msg_limit * (100 + od_percent_upper);
+               *max_power_limit =3D pp_limit * (100 + od_percent_upper);
                *max_power_limit /=3D 100;
        }

        if (min_power_limit) {
-               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit =3D pp_limit * (100 - od_percent_lower);
                *min_power_limit /=3D 100;
        }

--
2.47.3

