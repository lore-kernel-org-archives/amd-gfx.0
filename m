Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0839EB594E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 02:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0206210E032;
	Wed, 11 Feb 2026 02:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4uaiGwS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AF310E032
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 02:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMyiRJ3FeIduM3pGbzLdWczjWIdZXChULkwCsZTyXCMAqvvhy5+aWwOVjpoUe52XyF+WfNYQFFz6Ic/SQJTu+9vwr8Jd23n3njjpHXWOF6pilMg/3kUVPqcXRgHtX4OJF2aruCmfeiyBx7SGoSMLsbW3Ik3QG/HcehscTP+wtllFM0KUH0lhj8ch7HPc2T0z3ufB9hJBtukOT9aogWsOnqicANzGWGPl7sVQH6R4ovEn9wHutgLWxxADfkw6oMtrSBGqd4XaxBbyvbLS08mxYZPnJwHtZ/2l323umC+QigSGXiEggygIFINVtTUpEhly7TkRJSccfVdN8hRkEw5KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyssAcNNS9ivwHHXZNLrxuUU20Z1uVb3iXl/Wg/XuwM=;
 b=WasMQt63iUFf95JcBnNrmj+0K3GTOb1qjMfc4hRPS/YYEwOMb4MHuFEnikANVb2CrhYOFubJXfdX6n5HVS4DKbLjEzB6rOkA+CSOvAFBUpZ712dE4B+tClGjc6HMFy46F4yk275Bj/IQpbklG6VfSRFXj6Z33ST5saz4/SyeSypBVjHQP36oRYgRERyBlyS0DOf6GCFoXlC9lryzNZdI8U3XhKcpCob3vYRqAzp+sNRRev6tlK/RV5Yb32K2qeHAoh2acOxh5SheLFDFj8xGXAO1Ep0QulCY3dcj7s48CV5TQuvVyR2tzu7irxJH3tMNd3wH4CC/ErcGE0C8ndXguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyssAcNNS9ivwHHXZNLrxuUU20Z1uVb3iXl/Wg/XuwM=;
 b=S4uaiGwSRx5BF0i31AW8g+bIbCpcm/52xdQge1PK8AtQZnowHmVKM90cLhKiIKjObD960YgXdKoCrXDY32Kt7xHk8fRcmmQ+vO6hPzk4gRVhXCBdc43/GPSx3HLXK7VGkTSVvXxB7+5+mX3GA2RJ3u3S5n6X/ymgW+pCCs0q68A=
Received: from IA4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::13)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:59:08 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::27) by IA4P220CA0002.outlook.office365.com
 (2603:10b6:208:558::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 02:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 02:59:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 20:59:05 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Harry Wentland <harry.wentland@amd.com>, Mario Limonciello
 <superm1@kernel.org>, ChiaHsuan Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH v3] drm/amd/display: Fix out-of-bounds stream encoder index v2
Date: Wed, 11 Feb 2026 08:28:33 +0530
Message-ID: <20260211025833.1544179-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: da8694ff-32fa-45d3-67f1-08de69198650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5wtSJKn1LTTO/Jm8MibhUVwNoOAIWvOc3Um+Z9i2NlGQxjAE7hfxBbU82Gon?=
 =?us-ascii?Q?X2opLvF1g2pvCe5LS5LYEXObMX3KgurUFptwPY91GSeL0m4tvSB9ZBpwUo3n?=
 =?us-ascii?Q?D0rI8lUIwxVF+TEHZ3QhuXYo5gxXvSzI12h8YwrgHmrtfSg6eRownUYmj17q?=
 =?us-ascii?Q?YT1zDWJfoXcXj/PRvznLwpZj8LJnmgrQ2qiJwBlwqnb2vUUfQycAyV+3+3f5?=
 =?us-ascii?Q?xeB0ZBOm6p9J5Dk4e5rAvOjDPUMZu3PUYFuHm+Byb0hbl6s54RHsMJaXjDD9?=
 =?us-ascii?Q?hedJCb1Na+2YidqainmgYHl1OImdR/abxbFLKz1hIbS6DgS8+Kqru29aiH3q?=
 =?us-ascii?Q?QShMAhDWRipOQ7S9AzWC/b5//kLCghVmMaDqL47RID9RnSJor8n72sW2v0hd?=
 =?us-ascii?Q?1fb6JlUVii8LmxApq64wkJcXj8DKJSV5AIVwBx1BRtx0jJYfyy5dx/j+j37X?=
 =?us-ascii?Q?y5mI+KV45FZ0pzkPUucUOmYVupnEKN1U4ob2Nnm28R9HEAb/i6mhj5MjD0nu?=
 =?us-ascii?Q?PjP0NKbCgLngLVBYmUEP/KAqHGYMaE7VZdMVkblCy8unzZ7PmVd3eTpQcVg6?=
 =?us-ascii?Q?a+bEaOLa2hu/DFRyritPINqjBRvB2QWPr7La/STLKkA6ZPNJ/Gw/hBLE7vfU?=
 =?us-ascii?Q?y7FxSgX3ZmQXSMxXD8c+zgZe3hYVwLEBD/4VYXRw03X2De8LWoNv/CkeZ+Tb?=
 =?us-ascii?Q?eCaWgn0jvsPrzpRqIdsvd5i/XS5NU+ZFBKr+4DBKNKOjPVvA2pbgO6pz3gy6?=
 =?us-ascii?Q?2BHKvMj9DyzSF3Xb/che+PNI5pJD+ZsDYu+7c13cdtBJM9PHligeH9I375Ge?=
 =?us-ascii?Q?ViFNCE30ATE6Q5SGEKIkUB9fdx2HvrOD+gblNgC2rggPmFLRs9cHFrc/WT1a?=
 =?us-ascii?Q?MwuWO76A0g4x1ImhpXW2XmhsLehnaFfO5fzAXBF1hRIFkIwk60pZAmpjOZzV?=
 =?us-ascii?Q?0kPpN9q3AQbJs3Xpsv/ql1//RYU3xsEGhdgg+kK/GiHiH9o934RG6CFjo9zm?=
 =?us-ascii?Q?nJ7Zz67s5wgaxUWplIsb9ffbzc0L2olsT1XgM2NxHgVsOduzeWaNXf4Z8sn+?=
 =?us-ascii?Q?h2lovqkBq2q6DSz3I1BOYgl3XRDVMJQifXuaApirs7Qt3hz+mE36GUCGhWbW?=
 =?us-ascii?Q?RBdKCL2X1VNshVjEbGq3eD/A/Dev0PMv2SS0VdWSItnoa+6u831bC+eDyYPg?=
 =?us-ascii?Q?1INzgag02pVQUf11uTzWokEo3PyMTBvIx4BZG/iOJm6aqB+L1+mWW3fZYGzg?=
 =?us-ascii?Q?WdCuSpyzRRhxIFxM2u9uMf3KIKRgANP2F5YKKp1hGDaO2rCaksaaE+abfx83?=
 =?us-ascii?Q?rqebXxgBocHeTSG3cPlADfx92I/YyJPj4OcbrYKtndyQ9rPgeKvqYsqiBqFO?=
 =?us-ascii?Q?dC723tRGsUZtbPY8OITW4x6Ti5RMzO/BYNlZPug1Pg0oQefIjoIDzYfb114j?=
 =?us-ascii?Q?kEI3j2UYhse2ddvXuRwuOQxKFELuY7ybun7ud6kPbAP4JR60Wb4kPkJa1HQo?=
 =?us-ascii?Q?1npQG4wxIHhMgDq2l73KgJqE6ttiG7064LaUsfoCpS9a+ZcTjP5NFWnuGx89?=
 =?us-ascii?Q?fPHT48MBEZvx4n6fDfhTZ+hNuLuFoXEwFcDVeNyXA4ASLvlYnFuCjEQst1l2?=
 =?us-ascii?Q?8cTwe5zM7pD5lDPTXpIyAcuWBvdd0NVLgPbhB7A5Be8Y6ncK49+X4Kv61E9g?=
 =?us-ascii?Q?Q9l7Nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BitfZoUXiAekOn2iYM1kAwvQW0AWEQbns/52cL/Z1IUODr9YfhlaXXFQcMZZlfJDPjkzQW/rUuIrttGDtcc0e2VhbdjtQau5x8t1htZoYnD/fdd2HW6vmCPWEmZ5AXb7bilJZV0VgoY5iWRExNTdkM4kiM7Ozf35OMyd+qba7Ol9PATHKpFWa9HSvAU1tZkG3qs/yRMnhpxdWv1wmY5mXa2tNxTDj94FZYYvSvVhM5zhZ6MJ0MhRD+0nCE93cWpXDayixHqoyvAxOzt6dH9Mx1vVhOb/LdFeL7beRvFocXfWvY0OfmcWtbLn+mNXK96Xh4pF3ROcZ4WlsFZhbpvzZtLLDXgLQqLHFwK8UouCCO2WVIlE+JyH8sIc+6Tqt2MFXZHb/rok/TWBCGrOjxFv1GqUTvtcLzA92YzvZPl7TGZzC4CC29877SIwgk3ltgun
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 02:59:08.1331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8694ff-32fa-45d3-67f1-08de69198650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

v3: The compiler already knows how to compare the two values, so the
    cast (int) is not needed. (Roman)

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
index a8283f21008e..3ae787a377b1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1230,12 +1230,12 @@ static struct stream_encoder *dcn315_stream_encoder_create(
 	/*PHYB is wired off in HW, allow front end to remapping, otherwise needs more changes*/
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 4da0e9320159..4b8668458f03 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1223,12 +1223,12 @@ static struct stream_encoder *dcn316_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d3b92c61b7ad..a55078458ba5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1211,12 +1211,12 @@ static struct stream_encoder *dcn32_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn32_vpg_create(ctx, vpg_inst);
 	afmt = dcn32_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index d08691ea27ea..188c3f24f110 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1192,12 +1192,12 @@ static struct stream_encoder *dcn321_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn321_vpg_create(ctx, vpg_inst);
 	afmt = dcn321_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 945da8cffada..5ea805fcff48 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1274,12 +1274,12 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e660889904a9..424b52e2dd7b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1254,12 +1254,12 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if (eng_id < 0 || eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
-- 
2.34.1

