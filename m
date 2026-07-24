Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090FDC531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 03:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED2410E63B;
	Fri, 24 Jul 2026 03:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cUi+bfLM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F92810E63B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 03:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0tBAnNCPmFesnBfZFYS5OHPVg6QhR4E2DjrIHVa0T8ho82nbBIi2+vKVR9JF9/+CMtLbCrcn1CLPfrH20TIwra1/LXIfjFKylBxYv44wMgO+x+CBL5gl/ry43+tetWezi4r3rmVGa6e4/B7Uw5D7J2rrIBeS6WQL9JOXfpOOcMgx1nGuM4ix7+GUkAc9JCeuKwr5KiGGYd8rFw10aTpJJAxLPhpmOsX4pfxJmFYY1T76nvmhZlNTynXmh9bH+c230aGRuoKWIC9LyUXJGXpYbhjyB55yTqe1FrdnU7f2/NbyT9g5VUqfCYvKM9V5L4PBe7E6c3JLjAKwCulA079+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyrcBJ2AqSMqQ0Khz05Fb27rWp5a9Wf6ayAXA3tDjnA=;
 b=wc/onY8PDMAIYN7BTlQb4TNBWVVNO9bZ8+jOkFkiSRsmz+itQSfd6g6BivDcdgZ05XXrxpyTjh/4nDf7++MYb9Q15xDtkChRJA3d2fhqi7Kf7u4r8VX2Bn1GO4zfDT12Z+6t5hGBzhN0W91rNB0AWUHLThfRq5OgogseFHV/6xkj2qf/k0Vj21IViaTpqglae6Vu2R+SxmKkNnEOBgPtEG5LGHC1JR2VMP2BI0FEelsWB6tl0f5/tO97SWF2kWWeXkNX9DsTFwQu1rZOXTU3CdIqFoEf8tufd8WbrjEcf3z63ziiqR/OksGtGx/XfZPyUc/8y6qsMne9wOe1jzGcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyrcBJ2AqSMqQ0Khz05Fb27rWp5a9Wf6ayAXA3tDjnA=;
 b=cUi+bfLMh005x/vBkWOxnl4g5k8yLnJi2guQWjIp50dx0xlO3ubw5DkoummQAHx5nxUK0snDH7wFw30JX3QajHQ7e/7YkAsA4mLmG3N1M/6HMgNuLllq3kgsJqBGadTrgG3A6nhWHsJhkmt7wpTeNCkXrrFpOy661zPDHZs7Rps=
Received: from IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:12:08 +0000
Received: from IA1PR12MB7661.namprd12.prod.outlook.com
 ([fe80::6e9a:f2bf:3d9a:2a3]) by IA1PR12MB7661.namprd12.prod.outlook.com
 ([fe80::6e9a:f2bf:3d9a:2a3%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:12:08 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix BO placement overflow with four domain
 bits
Thread-Topic: [PATCH] drm/amdgpu: fix BO placement overflow with four domain
 bits
Thread-Index: AQHdGPJexQqBCo/1DUSzy4LEGTH2QLZ8Akvw
Date: Fri, 24 Jul 2026 03:12:08 +0000
Message-ID: <IA1PR12MB7661DE87F8DE4F6AC41CC84D91CF2@IA1PR12MB7661.namprd12.prod.outlook.com>
References: <20260721092124.1967369-1-candice.li@amd.com>
In-Reply-To: <20260721092124.1967369-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com,Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T03:11:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7661:EE_|CH2PR12MB4231:EE_
x-ms-office365-filtering-correlation-id: e44776e0-d490-417f-4718-08dee9315892
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|38070700021|10067099003|56012099006|6133799003;
x-microsoft-antispam-message-info: HuFB84Scv1ctJ+Spn7uKm8cEue9sk+tqi3QMA3O2EcszZff7YbhgJtW9U/G8z7LJQ5wwMrp020MtE4FQDeukh8lDrPs2vVDvL+sIz5oCkN67qW3SdHvFrZQikPDPvbxqUGWXi9870sOwl3gyTttFHi/b33BLQPa0czzsF0Bl2ac8odkt90PP7rJneCqs6hxO7oEts3s0a1fu/wR5ZEeaRm0kbu6B1XxO6rEw7oNsRicYvAb/8kufz7IL0DGiqMwp7X4DMO+Q+hSE9Zrk6WtjZULh6Qlvomz8P24UXbSqHGSn7MUb3/vSnaVLakUiQOj8PcQejRdoG/wcHZz5mvMQJZP0lvTFFnigVSCDkex9iKfAhmjwgAp2AWk6tO7AgRZKmMjQyBalrnLzPOz8tNUsRPz0drzvT0XicCsR2uHK2YKMYxGuuYL2fBMaKvGknpJB+zrWJ2iP8AiySsXSIYLnIST5w8ox7ZIDGtFiPb1F03mQrKNlYfvEUAPW+6eIXtyz//RTZav/X0s+BxOZanJL8YBwmwaYyDVU/XPTIRpU4PV6barLPWvHCQ3JL5toBOYUInwE7mDZIn3grrhmBJubEvq+AoqH1WHsowkOAOvF3nhmt2BqeLzCsVOAIQev2IDj/CEUHT9hkjkIGZ4zEe93BFgTRCb67xg6OqXV8kO8s+xjux+ZMgqL4uEjwF8pgmu5/Z4jfqhGlZgRpPOzSMYRfA3CbzoxysZQYKHiRAs6IxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB7661.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(38070700021)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cwQz2aKlYpPswdDpxgOSQue/HDQhz2z3q40esBWJuxKxItk+DsozW+OF5sTb?=
 =?us-ascii?Q?4EOblvPlf9sOqr6XCapouLys//hKdzJvkxUfhdBRENqmm/kzqQoHIsy8UCfm?=
 =?us-ascii?Q?lvPSyMI4w0w3dmOMd6tMjaxcwTzp/iIzYILjglo/Yt/hwqyPGjY+oY7CSkJ3?=
 =?us-ascii?Q?ouFiDhaI3UQOWpb9AMXoG7YUkh5CW1T7RkCMHfYskf9P9qFocCc3QRHISltg?=
 =?us-ascii?Q?bqNpPF3xLEqachyn7dlG9pG/IK/cUSq7+XGAjRolRPAeUr1l1e4sc+v3Tq8C?=
 =?us-ascii?Q?wlNBfPZs3mugoTyc4mpmgkh9zFk4/7gDbZlcrw5TxeKVEehy982S2T3b8xgs?=
 =?us-ascii?Q?ahpmaWgJ1PHj1ATNc4YZL5q/1HLFsAVGWgP3s9X4KRJX1NA7BMKJbpE2foSk?=
 =?us-ascii?Q?f1H0nSOkoIck6hZRYeksskQ3TFbgiP4mLEnzA8gK0YxJukTuU1oBIZwCM2j0?=
 =?us-ascii?Q?hprVPqXG9gkzhxaM9obRk5CUfnnSxUPcvVHjC9Ryuw6LR4lrpl7rOMox2whh?=
 =?us-ascii?Q?DUnLfNrwXw3JRlCYA/NEX06Uybj9w4s8tUwUKkRAA15nSgLUqjpYhLS5UdoD?=
 =?us-ascii?Q?1DWtzBL6o9vTrJ/cWBpyAIIKta+zU36g9VpmZDmKJ2ADqRBd4IL0wfEDlvKi?=
 =?us-ascii?Q?TomEoFKWWafvqbm0ojRceEusk+F5A8StZagTyfjPwZjshT51K64Tw186xcNZ?=
 =?us-ascii?Q?F1fbAoSIQf8DIwDvFmdN77WWY9ZKiJFmzanMrkoSmGfkLOwmgTURTiQc0GXq?=
 =?us-ascii?Q?8zRBsNQsD2sOe5uIrAwUVMNKpLEQIjKXQkmTF+sgcaaLRi3seicNvS3MwV0A?=
 =?us-ascii?Q?Yowtzi07eWZOs8mJLpzowF67V9DX1p2GeQHpLXfO2U2Hy75JFi437SyFwnor?=
 =?us-ascii?Q?rvxzWQn42mO8c9YPCO+lz4pegX+wEGdzeFQjFbSECpdgcYGEYxdgOrC6iiSr?=
 =?us-ascii?Q?M7rxXyVz3jMemh2F1gWgt0iZx9x/z6W9o5k08BL9mPwOZHcZ6xZy0m1R9qHJ?=
 =?us-ascii?Q?FySm2urilCpqJUj3+c6iH2WPlvj93BHtOJU9xJR6MoQKONI4+HEjhjvrEYNH?=
 =?us-ascii?Q?IK40Q54q/kTX2Mu2VcZY1Tortljyf+FMqj/ufeiaoty7A8NXfKXXo7SSmoBE?=
 =?us-ascii?Q?vi3R/0LwosliuY0iLNBvkNsR9DT9wU9Yqeo9OQxssOazH4i1Q5By0gRG+rXt?=
 =?us-ascii?Q?RZgpsLFuftrlule/dW3QPgm7OSNMJaGPCX1/YKZm4+fgZk5bsv9EY2toZxzA?=
 =?us-ascii?Q?udqd3DywKtvdOOp9sXlcpey57RXdQ3RRfWJbEU6uljlPZxIkez5ppG6YnJDA?=
 =?us-ascii?Q?5ipz6EfzP1o522BcnIT4Kag/knlRfkHofIFiouIn234G9AvfR5n/4f1ewgUw?=
 =?us-ascii?Q?JswdX63WAqFhVmDN6MqtsFLYO2oUS9pMtAeziNGm2zR2Au/JaAdcUt0RXhzU?=
 =?us-ascii?Q?ucXT1+/MiekYUD8Ob0PN2cvyRImKZjYsZ/v/gRABK3T7MH3IMlIz3epNeIE6?=
 =?us-ascii?Q?DdHcuLYwHoe/79KQF89bDRYcMctEVx+zlL5s8bT/APwXY3IlaOqwXEH1fPsU?=
 =?us-ascii?Q?yAf+1LWhpbNqFvmZ54c9Jtr3Aix5O/GVFioEShmccjSthjd9wi2IXTVYBGB8?=
 =?us-ascii?Q?HCwBEPcxD8rb8YIPfNh8bqXu5MBlqxPuR3ONCSacJ7vSDMW4FsQa8Uqgzbri?=
 =?us-ascii?Q?+NZFFGexhHRx/TQwtVUI89QgcTY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44776e0-d490-417f-4718-08dee9315892
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 03:12:08.1301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOeRRGshGE+j2+H45PBQTR5EoeX6oFw0KATXd6ejNEYt4pZrfTdItzIyLZJRPx8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

Ping.

Cc @Koenig, Christian and @Deucher, Alexander


Thanks,
Candice

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>
Sent: Tuesday, July 21, 2026 5:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix BO placement overflow with four domain bit=
s

AMDGPU_BO_MAX_PLACEMENTS was 3 but amdgpu_bo_placement_from_domain()
can emit up to four entries for CPU|GTT|VRAM|DOORBELL. Unprivileged
GEM_CREATE with domains=3D0x47 writes past placements[] and triggers
BUG_ON().

Increase the array to four and normalize mixed GDS/GWS/OA domain
masks to CPU-only placement on all rebuild paths.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index 6a0699746fbcd6..bcf81aba942842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -431,8 +431,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, voi=
d *data,
        flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;

        /* create a gem object to contain this object in */
-       if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
-           AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
+       if (args->in.domains & AMDGPU_GEM_DOMAIN_GDS_GWS_OA) {
                if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
                        /* if gds bo is created from user space, it must be
                         * passed to bo list
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.h
index b558336bc4c6ca..321db2ca29f4a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -31,6 +31,8 @@
  */

 #define AMDGPU_GEM_DOMAIN_MAX          0x3
+#define AMDGPU_GEM_DOMAIN_GDS_GWS_OA \
+       (AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_=
OA)
 #define gem_to_amdgpu_bo(gobj) container_of((gobj), struct amdgpu_bo, tbo.=
base)

 extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index d4a9d5e8fb429a..bb02858cbebf0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -99,6 +99,19 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo=
)
        return false;
 }

+static u32 amdgpu_bo_filter_placement_domain(u32 domain)
+{
+       /*
+        * GDS/GWS/OA are not normal fallback placement domains. When mixed
+        * with CPU/GTT/VRAM/DOORBELL, fall back to CPU like amdgpu_bo_crea=
te().
+        */
+       if ((domain & AMDGPU_GEM_DOMAIN_GDS_GWS_OA) &&
+           (domain & ~AMDGPU_GEM_DOMAIN_GDS_GWS_OA))
+               return AMDGPU_GEM_DOMAIN_CPU;
+
+       return domain;
+}
+
 /**
  * amdgpu_bo_placement_from_domain - set buffer's placement
  * @abo: &amdgpu_bo buffer object whose placement is to be set
@@ -115,6 +128,8 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *=
abo, u32 domain)
        u64 flags =3D abo->flags;
        u32 c =3D 0;

+       domain =3D amdgpu_bo_filter_placement_domain(domain);
+
        if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
                unsigned int visible_pfn =3D adev->gmc.visible_vram_size >>=
 PAGE_SHIFT;
                int8_t mem_id =3D KFD_XCP_MEM_ID(adev, abo->xcp_id);
@@ -690,8 +705,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
                bo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;

        bo->tbo.bdev =3D &adev->mman.bdev;
-       if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
-                         AMDGPU_GEM_DOMAIN_GDS))
+       if (bp->domain & AMDGPU_GEM_DOMAIN_GDS_GWS_OA)
                amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
        else
                amdgpu_bo_placement_from_domain(bo, bp->domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index ff11a09034997e..20f4d8c243afdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -37,7 +37,8 @@
 #endif

 #define AMDGPU_BO_INVALID_OFFSET       LONG_MAX
-#define AMDGPU_BO_MAX_PLACEMENTS       3
+/* Covers CPU | GTT | VRAM | DOORBELL placement candidates */
+#define AMDGPU_BO_MAX_PLACEMENTS       4

 /* BO flag to indicate a KFD userptr BO */
 #define AMDGPU_AMDKFD_CREATE_USERPTR_BO        (1ULL << 63)
--
2.25.1

