Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBB0C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8483610E717;
	Wed, 16 Sep 2026 17:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iWS9oD7r";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD59010E717
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w97Q1Wkgme2JwV1TMt6ui8j9jQTfoI4aLdnrNHBBqHTJgrKl0cZNKF406rDR15FE2chXVOOjVyE9Rh5cUOgsVdvNTUdS40AgPjND1g+q2lzXfcq/TynXnDLNHA3zGApOGerw/gbNJiCo/3AmMKgeGGFDgczrST/XWn/Eb4fwTu4K7CqYs373266ePRAtLnCee7ioz/fzX5iAOU30VuUBLYZnvZgEo8sldee36dYB8pmCqmfWD6vAYH/414hapMvbpwGuyZ7Ndv4Wzyq2+b8rsx7hYNcY2I3PSaKFeCXplcgRUX1xnMRlfgfIzsSgDXC1PyNEly8UaCm/k6/VKf449g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS6pxtzAVcBUujFkebRjsJ/y1wU7Nxbh4TFDaeT572E=;
 b=VhDwTym2fUg5/cwi3uINbwf1DB+Qu146brpqIxk2/RQlHYRfLVR2n+FrVhrH8QSC3odatL3GeNbv6GZnEd7WWae9JI/irK9S+vQe9QNzFIte6nwhKVSN8CbXp0DNv2Br/vE6o7G41TjVqz9M0PyQLQIr/TwtU9JONGFT2rBisWTrkQEohhO+r9PIS0OSprojCB6iKLNvLJ0TLp8dK9zulsuq7jhJ3dk2SWPlfn8EKhVQ1S3Z2f2hyWEte3zjgyfykMqVgemqdNwkD6glaJq+nl070gwMyibLl7OJ1VS4bGpH/L2Qa+GCqZ3Fb9DqTCXIDMx7QaUa+1m1OmTAI5MzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS6pxtzAVcBUujFkebRjsJ/y1wU7Nxbh4TFDaeT572E=;
 b=iWS9oD7r+f/VRnjC+Z2dhhsY6RAuaHD6CZxpKEYWsoVjLHVNzrtmz568bf6M41J51kqCGZVHzmRMLsQxIGlgrTM4+6uDEIc/yuRbTPig7JWzhyYkK09MxWnlWYRc0KwPyGBe57gx5VeLt+CgqpREzA1UHd91stjT8RLi2jzLE2g=
Received: from CH0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:610:e4::23)
 by LV1PR12MB999330.namprd12.prod.outlook.com (2603:10b6:408:3f8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:20 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::19) by CH0PR03CA0198.outlook.office365.com
 (2603:10b6:610:e4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:20 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:15 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 05/64] drm/amd/display: Enable double buffering for DSCCLK
 updates
Date: Wed, 16 Sep 2026 13:51:20 -0400
Message-ID: <20260916175301.368306-6-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV1PR12MB999330:EE_
X-MS-Office365-Filtering-Correlation-Id: e6722195-f696-48e0-1586-08df141b41ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|18002099003|10067099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 5c5LxNcoWiMpi+MXIAFyDJYK/mVwU1J/K7PxmsKgqwiU8evj9YIgl9ZZCPc4Ej2n0+L/u7/uhEXbozGgk6jG0yc1ZjOnf/E5biWWGuB8125WUCUIs/nzBtvkzldIKOOa7I2ecc/9XXqxVJ7mMlOMacw2c2W/tzSgIv/WOgJvaTqrOmJJphAliqoaymjzBo+vhH5d4Ygata3insT+48xJdNslHDotWARgTTbAlEx57mKE9kjHM70tcXCHnb3FRmD4nVEYBw8g/uRRSHsgP7xgyxytYh6+PnAWWfHbjrJX5WnkdjfqsMz3xXm/VJziOHAOhrADhv73HWkqliO9/novokBKR6Q6qxzmYgmDswpaH+VEeCmtYUUspIPj4QDE21DbBTzuoGTPVqZIMKqfQ1gQ1tUDVTy9ggJCF0a3MPZwZEfBMJM7IECRYrlS3SsMLPOiL+l9j30hGL7R2c1+NKIgMr1/v+Dp6Kx4JdK5Mf6uT1hOyJSgGQxQWIrv7ZHCvo4+mPQ3UrfBJ5g9wC48wA4kSC+hyksieA0f5AU0PlQIvAvg8imFmwlgNudUGpuj2siCJHh2q2n81SeTK/y3Ab1VG/HhNhwlSTf8i8bPWXxp/blDdOaFai+JONGUam+jPukzh2aNd/sexNlGXypM5AGuZaGMvi6pfRqtbfegZA8VRjp4VtaD3r9F8BwmIzwohrcZCsys8fJLefPT9kmSfFUZ0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b49IyoO6N8P02NyIfDpaF6mVX/CWmTsId2KGfWbBngF2ThP8RJQKboI2yow9HzTYyU3DHsvs27SR/PYmAo3k1cih1qhW4vIyV9a542iIIzAyI86i6j3Fp8Q5q9QmFHddCS0SUD3CKcOzfcPHlAcytCm0u2IOULiWS98eYPuDFiq0RYf+5tz0UBHWISl7FRv+sjrm0IKLc8N5LuGCbhkMD6qMRzDVaQCuXD5oLr6mszjz4RhMxF3+NAQQlZrGg7GxLQQSoAG+56UPZ2f6bOdVy9bzXW06FZWZy1H1XCaaZSLscNnCZ5PzB48nFSGrOstzh4HEJbWoKhJQKKdvAknTh2dM0GnWiGqrl44+fUJ5NjPiROQ9cII3z0XNhtNT52DA+XMEUrGCgCvoGTOHm+Tuv4IluKD5j09KWtxgUqC1A9G3txMnerUVAFUCnt4OZ/JR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:20.7958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6722195-f696-48e0-1586-08df141b41ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999330
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Double buffering needs to be enabled for DSCCLK updates otherwise
a frame of underflow could occur when updating the DSC pipe config
or DSC clock.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h | 4 ++++
 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index cecfb0a68030..f47733db96f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -256,6 +256,10 @@
 	type DSCCLK1_EN;\
 	type DSCCLK2_EN;\
 	type DSCCLK3_EN;\
+	type DSCCLK0_DTO_DB_EN;\
+	type DSCCLK1_DTO_DB_EN;\
+	type DSCCLK2_DTO_DB_EN;\
+	type DSCCLK3_DTO_DB_EN;\
 	type DISPCLK_DCCG_GATE_DISABLE;\
 	type DCCG_GLOBAL_FGCG_REP_DIS; \
 	type PHYASYMCLK_EN;\
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
index eb8b7e12d2f1..2799ee3d3cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
@@ -76,6 +76,7 @@ static void dccg60_set_dto_dscclk(struct dccg *dccg, uint32_t inst,
 
 	switch (inst) {
 	case 0:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, 1,
 				DSCCLK0_DTO_MODULO, 1);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, 1);
@@ -92,6 +93,7 @@ static void dccg60_set_dto_dscclk(struct dccg *dccg, uint32_t inst,
 
 		break;
 	case 1:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, 1,
 				DSCCLK1_DTO_MODULO, 1);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1);
@@ -103,6 +105,7 @@ static void dccg60_set_dto_dscclk(struct dccg *dccg, uint32_t inst,
 
 		break;
 	case 2:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_PHASE, 1,
 				DSCCLK2_DTO_MODULO, 1);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1);
@@ -114,6 +117,7 @@ static void dccg60_set_dto_dscclk(struct dccg *dccg, uint32_t inst,
 
 		break;
 	case 3:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_DTO_DB_EN, 1);
 		REG_UPDATE_2(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_PHASE, 1,
 				DSCCLK3_DTO_MODULO, 1);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
index 3f068ccfcdd5..3a6b65dee154 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
@@ -96,6 +96,10 @@
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_EN, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_EN, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_DB_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_DB_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_DB_EN, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_DTO_DB_EN, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
-- 
2.55.0

