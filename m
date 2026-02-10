Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1677FEA8128
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 15:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B64510E39E;
	Tue, 10 Feb 2026 15:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCGRD5DN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0017B10E39E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 15:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHoQ7sEOuxtmmwD8h3hrbE5PY3n+qQLZhHd4v3HS/c0wpiyP5Tb8eVDkxytHdjPjAj4lPZPkUW/tyAOrJY/Usz89nE198MLAzB6qLAMWajSZqH97ClrpM1yxJkWsleDsW516OvXmP5JDQ2D028+PUffE0q00zVzUc+vK1LfBGhGpnZDrkimJGb6Zv5nQTsWxEs6LXVEbviIIyvq793QtWJ8PtZxLUppwGeHu7w6IOdD1qx1I7evuj1nnbsGAX5pSdf4eSYuutExYJMkET1YfmObXBsIl1S1zAhwoRzL291oF2TMRdEF9ErIFpc7lqAV5s/eGlGs7P8eOZQv2WhN+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+u1sFZCSSzw8jSFJXOpmoPv0SEQ9uVTZWKe+yFxAi0=;
 b=HI1hLO34NKj9aAzj+3SkAPnBUObsjBoBom8Ff+pMZ+iWwZo/M5SFq6wVVCVIYAprVcJdoU70D8pip9u74k7LkjN7nzL8OnmuLp8Ar/6FIEtpXCarLn1C7ty7bUtPXpTog3rhvU8zI99BeUD4F/GlgVFF0yx+XsGg/gpeGr/OKvFsMwxxYZGabPh85pdHKagiHclZzpcUFDBgdInTG5AtOdkLf/G/VXtJmt8JYADrNmetrmlWkwfzzyPOqkgERfUyXtuzor1xM7FvhceO9vx9cz9yin6fymcVIyb+lCQJ+vKgub5WlKsuDuWq5qFUhjbYlkIqFSM3ZQxbVbdrzvgn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+u1sFZCSSzw8jSFJXOpmoPv0SEQ9uVTZWKe+yFxAi0=;
 b=cCGRD5DNxOsIYeGBGIwU8Qltc7HMbLo4SP1RTqW6mHbTqUoLM6n4XhAVv77XMJ/VpoCqA2nZ7bWu5Wx5J5oLP+fC2O5rVs+pSLPcijOF+BBPSrceGQ7dPj+NRuBeockTSbUp7GrcLWbbgx4bUSYE3MM0e9kTtSu7Rt4g64PT4Mg=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 15:20:06 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::e8) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Tue,
 10 Feb 2026 15:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 15:20:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 09:20:01 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Harry Wentland <harry.wentland@amd.com>, Mario Limonciello
 <superm1@kernel.org>, ChiaHsuan Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix out-of-bounds stream encoder index v2
Date: Tue, 10 Feb 2026 20:49:47 +0530
Message-ID: <20260210151947.1541045-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e5026d-2504-44ff-0df4-08de68b7dec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdlAionzKtxVMTRfKA5QQ/0IADLR4QWwp0CDa6XyVipX2vspzWq60mPGmLRC?=
 =?us-ascii?Q?81BvzN2QpIxio4e+6d64RdS9dqHSsr6CSLycVHWIUlIG39Gtp1bXAPgmjrX+?=
 =?us-ascii?Q?P6h5LqJQLkD9moD/6PnXIFqO6zNm/grQYbc+fF1JzyXrX/q4WpVVlr+lw+Wi?=
 =?us-ascii?Q?UQ5QGKXCvIcQe7aAUeMM8qy/YZDpm634iPSKiEo6qhhbctckQ9Es2R7i3RLu?=
 =?us-ascii?Q?7y7rVlJZWzSlwYGMcDmkEuwgKlJcwHH4jIYDD1Lc6FNrWj6z0g6/BoxKPsvt?=
 =?us-ascii?Q?+pF/R09qmLC1NpgEqfUpvZLu45rDAcVR5erGqONcfbaON9soeQnxUXfMQYuP?=
 =?us-ascii?Q?6SqCbNnJn7w8nMemk2neoP+cDxBG7so0nGYZCqjBkUDqkMzizdW835azhVdL?=
 =?us-ascii?Q?RtCnmIUXxac8OhbVpT9EbOIiPsUC4sNhLUug3FvNRAKsM2FoTNyrvvc3YyMX?=
 =?us-ascii?Q?ma4pfWEuxzWdL7wBi2dZva3QtlIrbI4hnq4vE8BiB9uL9SZpyM4XEcPbRtwU?=
 =?us-ascii?Q?qbeQOp3T/9A9fl7sVJI+yQyssm/GZRGRIr1BL1Kc1LJk1Vkl1DFyK7MPUa03?=
 =?us-ascii?Q?nuWvJ9733rD36SyWbJX9G+CapXesqfun24l8m7dsDeQ9/6+eM0kznRK4qu6o?=
 =?us-ascii?Q?6EoLn4RqcXUvHTZ6mB9WiTtUtfUGhZjqzHGLRd0P6eBe0/2inVQpUjECPQk0?=
 =?us-ascii?Q?dmqh3QQBC660ISygni6uMNDrvbCisHcoxfuR1lRIKEhaD+iqYGY5d/Sws/Xo?=
 =?us-ascii?Q?6jHfR41Oak3znWXASW1i0MqwN+Ay+ivVfnV51QLEUUyZFR5tDTh1CmjsaA1C?=
 =?us-ascii?Q?HgOhgXBJ3MFloKkqBbZ5MyD5J/qHI2ZLmh57adw6hGEDHV8TMbJslnqigw6w?=
 =?us-ascii?Q?zSqwu4+dLsLR/FwsR4OF2FrYVJNuF8AXYEpDrrVVrvq0hgpnUrywdVSbVQBn?=
 =?us-ascii?Q?Wo6R7vnp36j+XdUf/aHxwzbeLL3iiLDltcYWOvWoiQakprqDFIjO9i8uMQId?=
 =?us-ascii?Q?Su4X1KlfBhcFGwuTGQFSN4xYDOxPr10H05sGt/TQyyzPmYOrVPvdBA+D85YE?=
 =?us-ascii?Q?vMm7jnOAzYQWOaTV8+Ncv/SufuGRQXUxN21vF8tqML8ooLLam9GAihNyjWvX?=
 =?us-ascii?Q?DeW+7aZoXUuSpzLQiljDOpSxtaWsiTvbVN544Al/thi86Sjdpj1dUok2BUPv?=
 =?us-ascii?Q?3JAvRLAoLKwrkBygASWcIF5ZJf2rHF0coLe3lKzkxpzcWoJVDWook9qhq0/w?=
 =?us-ascii?Q?qZ1yilh4qrIIF871Gfj56hy+N8SST1aNyJ6J15S0nx1kNC3WP0Ci9HcHvq2M?=
 =?us-ascii?Q?Ox1EgWhp7j6N0l+iHCgCT+v72KbZ2F3e97Avn3BrlDPueyXn5LRq19Qb+l3Y?=
 =?us-ascii?Q?dihNqDNR3bcDJyUHF9TaNVk6ygXyf810SldXa5K4oO6MqVGtW0gAvIAkz0jv?=
 =?us-ascii?Q?9rAYHiSnnqSSsbZDqTIs0/8JniFRLC7BDsUdPbC1TI2X0ja3j3qqVBYmBNWE?=
 =?us-ascii?Q?Sxlq+tYCiNQsZ3xcvqkrFv87/oN2FL/xau2n6SnFjA6/fxwly08MvuEw7jpo?=
 =?us-ascii?Q?/uZamw5SguWCi3OocMtXORGXjdyynRHK+Ta6+je3szHB81WrmN+qlaM5N416?=
 =?us-ascii?Q?USxFcMeFENM8VNk3rXS8CRo9AvV2a5hbKVSZlcPFJc2IQwgivUdbHqXlvtQg?=
 =?us-ascii?Q?GurgKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T49zXqvKjH7rdLr2a/vKQhXBJZ06roR1CKMV1VQn47LeihupzH7uHuUDSEzRyMgTUbX+GL/cCfZZ0JNTl9n623EWgIbj4qZfK2mqF9zQOWkHfK+g20f05cpqqpZZmsBTDzz+G7sC+fEVH/mRKdxf2wn2zoAkNfTarEOlJE70brHQPZQq0L2m7CpUBzNSlloBbdAPmPH2sfkSHD/WsP950hJmk1Wr8vCwn3pKHfO9wMBLzgYDkNbzH+Of2yrtREQ1CEKWU4zlvdAFm0f/zCPFmJ8eHGf0q//SW47mDEtaZ2yCwNi4e46ZgkMhJulv4Ccn6yhgi3mlm1n/Wk/acxqRMfMk5Z6ki8zlUCsSvYNGaSqwLzKZKzM9TvoScRy7cOQGXL17Tngda/T25BB6bbLC9j9BffkPGmnOeXHvq7499dbHmfQfFYXU0GOXMTerMgZJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:20:05.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e5026d-2504-44ff-0df4-08de68b7dec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

eng_id can be negative and that stream_enc_regs[]
can be indexed out of bounds.

eng_id is used directly as an index into stream_enc_regs[], which has
only 5 entries. When eng_id is 5 (ENGINE_ID_DIGF) or negative, this can
access memory past the end of the array.

Add a bounds check using ARRAY_SIZE() before using eng_id as an index.
The unsigned cast also rejects negative values.

This avoids out-of-bounds access.

Fixes the below smatch error:
dcn*_resource.c: stream_encoder_create() may index
stream_enc_regs[eng_id] out of bounds (size 5).

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.c
    1246 static struct stream_encoder *dcn35_stream_encoder_create(
    1247         enum engine_id eng_id,
    1248         struct dc_context *ctx)
    1249 {

    ...

    1255
    1256         /* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
    1257         if (eng_id <= ENGINE_ID_DIGF) {

ENGINE_ID_DIGF is 5.  should <= be <?

Unrelated but, ugh, why is Smatch saying that "eng_id" can be negative?
end_id is type signed long, but there are checks in the caller which prevent it from being negative.

    1258                 vpg_inst = eng_id;
    1259                 afmt_inst = eng_id;
    1260         } else
    1261                 return NULL;
    1262

    ...

    1281
    1282         dcn35_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
    1283                                         eng_id, vpg, afmt,
--> 1284                                         &stream_enc_regs[eng_id],
                                                  ^^^^^^^^^^^^^^^^^^^^^^^ This stream_enc_regs[] array has 5 elements so we are one element beyond the end of the array.

    ...

    1287         return &enc1->base;
    1288 }

v2: use explicit bounds check as suggested by Roman/Dan; avoid unsigned int cast

Fixes: 2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 8 ++++----
 .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 8 ++++----
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 ++++----
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 ++++----
 .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 8 ++++----
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 8 ++++----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index a8283f21008e..5101bc24342c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1230,12 +1230,12 @@ static struct stream_encoder *dcn315_stream_encoder_create(
 	/*PHYB is wired off in HW, allow front end to remapping, otherwise needs more changes*/
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= (int)ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 4da0e9320159..09cfc0b74e91 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1223,12 +1223,12 @@ static struct stream_encoder *dcn316_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= (int)ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d3b92c61b7ad..8538cd574eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1211,12 +1211,12 @@ static struct stream_encoder *dcn32_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= (int)ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn32_vpg_create(ctx, vpg_inst);
 	afmt = dcn32_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index d08691ea27ea..1b9f1770e7f8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1192,12 +1192,12 @@ static struct stream_encoder *dcn321_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= (int)ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn321_vpg_create(ctx, vpg_inst);
 	afmt = dcn321_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 945da8cffada..00999c3e0a08 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1274,12 +1274,12 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= (int)ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e660889904a9..328cc6c091c5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1254,12 +1254,12 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= (int)ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
-- 
2.34.1

