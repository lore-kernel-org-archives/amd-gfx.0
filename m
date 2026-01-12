Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090FEC9EC90
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 13:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9044810E0E6;
	Mon, 12 Jan 2026 13:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WtE98vEA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B3210E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 13:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3BuqRPRSbnJ+iZlsq93DqREBnRxXNLJaAIO1y84izghL57xyzmI6qjYYHdYQ2AIK9Dm/bu9ggJHYK8mIRxbzveuHP43n34egZf+pWso0ShFHdHAwHi0VA7Q3P3oGcSacjvFfWaYOc3uVFnxFqKSl9umDbqfdn+Ptm2dEnwaTkSHeyCFapvs3pr+urbjPqp1cUUJJvXDHMkFaZ4VtvMIyLdNxtto32NuUc5WSVtae/tfUlL7H/yyzuitSAcaN4rKYBfqa+8s/24SNHspkE1lzi6zW6W/WtzL4QLr6SsDbzFdxx8LZNwY6+rrW3v6Hqaa/h5UO7ucaJKxUOQJecrcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLMa3HYRIFpxeamU5JSVn7oGts+wIGqEuoVyTnkjliA=;
 b=O/CJ5OaRyc64YJl9NU5d17gXwAe7hnh1dAC7uaAfsT+hxt+z8JnQmO/yxK9c6hUg9vvBi67+M8iNNCgK04QG5LoypcAcHn2HcJRxmqrIcOoRbFupRqnMtXqpywbRhwI24n/2ZPi4y+/rHtR+YVZfWXdFT7ooPliX2/jCc3xVgMvqqvi9PwRiXu2DH0Md66H7nwUcQe7WP6NerE5V30i5hH1zz7/esl/QA0RfLJmfhvdDHJGbr6bkOnOu+sQSbS05NhAuVaqe6RUvrgpXDxG1FQ7y5ZBiw0KkeJTcCXXR7yqxBI5fI9umv011Y3Jc+NLUdokLkgoKNjj+sYPZp/q5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLMa3HYRIFpxeamU5JSVn7oGts+wIGqEuoVyTnkjliA=;
 b=WtE98vEAlMLPHsOSm0k5XwnW+FP3cnKKfH9HGcZZS3orYWbWEKmwQbUtxxI1WA3Wlx7RZMhnLITVDaJXzvgtCZr2Ike01yrpZ62bdtoV+cnntv7r15zJcGXtoWSZYIn0wkBRzUQ5RTsyjoXGRRV1UeLNzAuQWNDzQbQe3HbE2+s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 12 Jan
 2026 13:32:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:32:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: Deprecate print_clk_levels callback
Thread-Topic: [PATCH 2/2] drm/amd/pm: Deprecate print_clk_levels callback
Thread-Index: AQHcg8KuYXiJX3vLW0q6mSArW8ReVLVOiE8Q
Date: Mon, 12 Jan 2026 13:32:57 +0000
Message-ID: <BN9PR12MB5257A99044062159865496A0FC81A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260112125442.198976-1-lijo.lazar@amd.com>
 <20260112125442.198976-2-lijo.lazar@amd.com>
In-Reply-To: <20260112125442.198976-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-12T13:32:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4434:EE_
x-ms-office365-filtering-correlation-id: f23c5a79-aedd-4d00-066c-08de51df193b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AllIFmd2OxuA7zi/K5TsaHQKU67vISR2lS3/Ik4aQ1SIv8DqKz5YudbBJyt1?=
 =?us-ascii?Q?DWwnr/8lCjPFZs6gbWf4R1CHu5XXXkifaAvzpDGTiI3Aq0G5eMlMpH10qduo?=
 =?us-ascii?Q?HSMuQ1CRJfDswNVUVtameMaq5vlZCtgGazjQe1R+yjMFqRWYa0IS3Mg3lamF?=
 =?us-ascii?Q?q8xVEKNY36dmnYT+n4J1apIdzeYGJ6aKD6JGFtwafevzBLipv00v6+p6D6uc?=
 =?us-ascii?Q?4cEfSqZeJqMqFeKF9XwPHQtjymRkqQsZFzC7c891N6Xem/9QInGBpz+BJHGy?=
 =?us-ascii?Q?EvM3LOgIVcXSsZm5LQ7ftyks2371cDPTcVaz+ge9wT3OXUg11goX2mJiwU2L?=
 =?us-ascii?Q?hRiTUD8uQUesviiIcWe2d3YgGGK+UWzl8H0lgf9Nfg/AURLAc8xWX0asWaf7?=
 =?us-ascii?Q?rUDZMGrkKW5rzx9TbY8Yomxdqr2JSpVSDQEbkMAxeL1qXIFxQV27NJzDP9cP?=
 =?us-ascii?Q?6VRddIg6taaEDBQZn4j0a/HyiVtQRRnxFea43+Kd7M8deg+9O8k6+4MYzLpV?=
 =?us-ascii?Q?NJia2GF5PAoMQdO748v0lsD5AufSm8GSU6/M1NtMGC7bpbdydDkmO4u/Oneb?=
 =?us-ascii?Q?Fp9MlC2rL7DgOiDgZm2VL4gYO+Bq7UnGYdqZrDevxfBD/lS7x/ioCHvOE0Bf?=
 =?us-ascii?Q?6hF4KErB8p1ButIGkZTjRakg5As945+n182Sm4EYtWPnwHoJ6HLqK9K/vnX9?=
 =?us-ascii?Q?WsVWksWbVKYUEuqlplAB54Vgk2DBdGd9MF04xfcULivkgstpgv0Z3QoQiqGv?=
 =?us-ascii?Q?10FRxMAWTrK1YgT/ZH9koZp2o7d6RD2FOM5DL9j5djJ7JFFr9cqaeaSPDMsa?=
 =?us-ascii?Q?7or5Yq7tZ1iB9p6xqEIU6ODTb0gBqrfSvqt+8jsYYya4fmLI2zjf2Fw9Tnvg?=
 =?us-ascii?Q?cC+V4xvUaOlFtiGayCcOTxHFRZRj+Mf3EgnMR73wuMkjSWL698RioP+N3nq9?=
 =?us-ascii?Q?XumdJNjguIn/MhEPRHwBuRtsypXR9LQsPkFKz7lXXxclgfNdrBJlEZs0w2g3?=
 =?us-ascii?Q?uxUsHL8JphN2Mszq3uMZ7fIuOzKoWOWqQmHtJ7shis15VJRCsbhBnxC4/kz/?=
 =?us-ascii?Q?thzMN+C4J3tHLEcNV9R36Jp1Ag9JprRY+hX/d1E+zvYZkKDgzOdP3Q48kK7K?=
 =?us-ascii?Q?nSKdNTS8OXF9LM4oBPD2qx/Gp8lN2PGrHzl6hImVm3D1aCX6rxuV0RLZQno6?=
 =?us-ascii?Q?kpyr7/evd+zzrUy5defSeq8LbDyOcghTWnxoQ6U02jzMANpUPiyqLDx/JH9b?=
 =?us-ascii?Q?ASUy8AARQ7Ck6/hNA15jtRlzyRVqck0rpgJlN8TyWxVfZcDTz2oJvzdtwYk0?=
 =?us-ascii?Q?1ML77R0LuKtzjEHFLNuaMap1pa57I1J84heqHSWM3BUtsjm5OcDWSBHPwXAr?=
 =?us-ascii?Q?3Z1VRINTLYipL83XtSCAxJ2ifKfZ32bumqUSDsVnFYPnCV0p3HhPEDdGyuh/?=
 =?us-ascii?Q?dJAmBPc9ks3apoWYMwPkla9UHbxQ/u8O4iJIZUI+n44oAis/aXF43aOixIer?=
 =?us-ascii?Q?p4TNiJtBAamm9DH16zOXdp3aLLkzwbx+75T1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eF+g10j7n00NI6uCbZ6ZHORuNSHaDcqFGkN1NbKYN0fqKp3Se8XRGb3pLxEK?=
 =?us-ascii?Q?NVyVlxr6C0hCcPkQ5kEDLLL3du6/HzD5UYmJG8qMHvySFozOqEtxK3S1g5mb?=
 =?us-ascii?Q?XVCny8yqJaL9xbtWMtjfRXBI3GkOMw5uEf0IkdFXKZ5/0BtTRrzOx41M30f3?=
 =?us-ascii?Q?sOwYHbhE86ncW7p8mHAAfQL8oIJkUc4M5GaAjN5c2Z+vcI+ANH0saNQ8dJzs?=
 =?us-ascii?Q?9Dehdngsg0/Y81PfuOCjDp186b5JK0IlIkNzMWVrbJAYOKHty71cBcTv+xw0?=
 =?us-ascii?Q?ZhaNq+NBfxkuhmI4r8gSJKwqvV7RgwLh7ms8Hh9IA1lQKB4rBqtDbE2uH3gx?=
 =?us-ascii?Q?06OZx3iDrcgsy9mTORc+b8jRBhXQABUv0wvNcolW/BcCERkn0Ljn7bPXP/sW?=
 =?us-ascii?Q?lW6Y9sOcgtYm2k1Ziuyb4BVt3hSNDZDamBivxtFI4v4KIwb4PGlqk4DkxyuQ?=
 =?us-ascii?Q?tDZrOLcbnpZNOKgJqqWehcpS7hxlIvtQXPCU58s8X5b/SEXtpwxPfmvGh3ek?=
 =?us-ascii?Q?AtjjG8pHaimoZJiAQefw6vXXFv6yBkponJPuRauBYDfm2lUSmE7ClTx4Bp2d?=
 =?us-ascii?Q?f5lmrJ+tVwMyqx4K88fjHqU3i1pclnkVzDjyAoZZYiRVX6KFXoDUtBfiSn96?=
 =?us-ascii?Q?mv0PjeuM6vpFbDWLGh/604t1ASs30BP0EoktzT3woll1K50Re3aRDt0cEYyI?=
 =?us-ascii?Q?zmVjF6LMCFQf3K/CpmiSC3kOUooxZP1DI9HOUGcMKb8jT8mLwHEOIjFAQwbr?=
 =?us-ascii?Q?VumYws3T7Rj3eDpThSieYx7vNIHfqWF6I/CCZnJGIwjPPgzcw4tVPoBFswPb?=
 =?us-ascii?Q?e6TMAJMKmvjfiowmJXTRlzoKdn73sUrthcjHPDVxl+5w4IuMG5wptBMzcwhY?=
 =?us-ascii?Q?djaOpjz2DUJmeDJ4zxM5aoApJLy/q8hTJBuUgfbDJSMAFmgd1UzeihI5+u00?=
 =?us-ascii?Q?zYDS42UkFYzfaaPdc43FrRuKP6tJMKwE++V+Mg+GxFyP+vpCJj7wrhq4kRJ0?=
 =?us-ascii?Q?kXvLcSrfMF9i5zsYEBWIQYzWCuEEwD+9zU5uvJdTOH1bjgWSRAmsI3cx/ucC?=
 =?us-ascii?Q?DjQVoyEEs9bu/GJ6J3Kw/YdqwMKOx3c1eLWNaKzDBVczQM44i9OOYiVeMHi9?=
 =?us-ascii?Q?toFIGPM1Tn6/5qyKncGKEHBCiMQn053VAQzRq9YC7oBnk/KU0aRk54AMR1GB?=
 =?us-ascii?Q?iCP1vSRKe2j9zIAmh/66A0L8Q35qeQDzp5nYP6pCVd877oFYsSGGD2KqL9EJ?=
 =?us-ascii?Q?ko7MbJ6fUEYYXDoFrLIz1/n3PY63Vl08xTtnCcPpKvCTEEDxUdgckq+Roih8?=
 =?us-ascii?Q?cOf3/AhTu2gqlVPNlkQoEkQ7yMvm16zasWROYJKUdypxFW7Kgaj/IRLeToHY?=
 =?us-ascii?Q?OR/f8YDY1ICti5ymBD95NBjE97f74/qotsw2W+JLR7Q2tPDYaQsO5XZod99w?=
 =?us-ascii?Q?6FX79wNVywRIPYj9E5Hwdl7NiQS5mIQZU2ccbPCiXlaG8iDta6BUFPQt20ob?=
 =?us-ascii?Q?+SSYGsS7nS+fYYJzugykcBrr0yQPJDmAlXzGqZjQ9Lii55ySOn1rKC6d1XND?=
 =?us-ascii?Q?EmXNxkq6QVf74jGU9+sOwA28FRmW2Rl//CyLb8EPVq7yAniP2CK6rnK+cMp4?=
 =?us-ascii?Q?XbAXxQIzOe0I2yc2BXThAhpwBEOKvOLXZsV92sr0IxIJHm+kwVxRY8tfqtsz?=
 =?us-ascii?Q?HYdHeQmar0L1OAytWNne9/WY51VtYtU5MaVtFw6GPOXSnSou?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23c5a79-aedd-4d00-066c-08de51df193b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 13:32:57.5713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bwMUpOIztsWnq3Hnq/4Qk5toFRvZeN4J+lfEyRYsrBDoerkbNu13ChyO3Ts1ie0TeW2Iu718Ww70E2xxStlIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, January 12, 2026 20:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Deprecate print_clk_levels callback

Use emit_clk_levels instead. Also, remove the unused helper function for ge=
tting sysfs buffer offset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 13 -------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 3efd5cca3d09..1def04826f10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -829,15 +829,6 @@ struct pptable_funcs {
         */
        int (*populate_umd_state_clk)(struct smu_context *smu);

-       /**
-        * @print_clk_levels: Print DPM clock levels for a clock domain
-        *                    to buffer. Star current level.
-        *
-        * Used for sysfs interfaces.
-        * Return: Number of characters written to the buffer
-        */
-       int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type =
clk_type, char *buf);
-
        /**
         * @emit_clk_levels: Print DPM clock levels for a clock domain
         *                    to buffer using sysfs_emit_at. Star current l=
evel.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 4af587b42dda..92ad2ece7a36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -187,19 +187,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *smu)=
;  int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state);

-/*
- * Helper function to make sysfs_emit_at() happy. Align buf to
- * the current page boundary and record the offset.
- */
-static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset) -{
-       if (!*buf || !offset)
-               return;
-
-       *offset =3D offset_in_page(*buf);
-       *buf -=3D *offset;
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);  void smu_=
cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);  void smu_cmn_g=
eneric_plpd_policy_desc(struct smu_dpm_policy *policy);
--
2.49.0

