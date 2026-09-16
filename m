Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF954C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F61910EAC8;
	Wed, 16 Sep 2026 17:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1PeSGdgE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774C910E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQSZGdxmhReTsCt0sz3BpXYuMQD3M2HdA9VGCvplfqXpMafNRKxfUX7gU99J5QhFPRvBXRKYIMAPaqRnANmXDu0ZDVPyyWD2vEco+fyRw44oTK9XSC4sTp0PeP/sQr8E5RJgneqOoLQCHy7QTyvNYv0l750pPoxgMJTVcbeA3KnEH2d5lMWPGPgVy05Mxu/ffr96Dn+N6LazfCdFiuhVyZyxS+XvUVNTX7ge3/BqftBjzYXsUaJi3KU14ptDP7SxdBV2H0FB6VTtyI7Rq1ltM5dhYs86AFeQq2f1blghwX8At5m9Cm8j3qk5T2vcDdxTovG6s/gbU5XtdwIrsgvmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7CMU5CWRuTykZp3WoMuR1gwPqmDF3jp3lXttNeZOdY=;
 b=LQpNvupcoJxdm64VJ5/IiuhpELvhtR5RCsosDBJIOHw38KYuOHLATcZ3Qr1Uj3hJj9Dhu+/TOjW0h+vbDWhZOcrYpmxzNY5L+Lic+VZ1QcMeqpwnV7MsaJULpgvm5ShjT6yumnfgoZzsM7qIokUaJMmZTnn1MM/8HWEktxVq/8GgajwkSp2WBkTtHbfqZCohEbhxGvkX+5+pZ+YQl9coTsepfOUWvz4Du94jvHBMt/FtLxvwNPAyphSPQLTmkUCyY1krXujQVn83J5DycDcDXNzPcYI04rwx8MkbTrdor3BoNlOfcHMj8vgOjLOU7676vhq6gzzCVFEY97T+1o1t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7CMU5CWRuTykZp3WoMuR1gwPqmDF3jp3lXttNeZOdY=;
 b=1PeSGdgEeMVl4gcUc8T8ThGzPC/IteISHMK3VKMRzRCmXM/9Zz6seQrj7DdKB44OkTsGHs+ciMkeATdwOHMRf235r8FHTWbexoIVEuBqk9hnjnyt/LY0TC/cgn7K5+kvDYrb3sI3HcnxoyviM+dRz2aGTfWrOpX2YOU1i5qoYmI=
Received: from CH2PR10CA0021.namprd10.prod.outlook.com (2603:10b6:610:4c::31)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:34 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::3) by CH2PR10CA0021.outlook.office365.com
 (2603:10b6:610:4c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:23 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 13/64] drm/amd/display: Fold universal overlay format test
Date: Wed, 16 Sep 2026 13:51:28 -0400
Message-ID: <20260916175301.368306-14-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: cb94d52f-e964-4de9-89cf-08df141b4a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cAxuvPr81owi8Rgd6Gnps4VBhJ+bwaVY73GNdLCu0UZDSSdcsbGvSdu4xPdVBOM8gQ+OkCcdHIxgTAg0DSWHkvcC+coA0SYenCaIxNPwLNttIy2WwxKO3hpZnpiIx/J9FqmTmRPMXV+MAUVKr6p8J3bTAtDvHx4YvxSFa4xeVPCRt8t4lDa79/UQhzVsBhFIDt9QF22a9vtnAgoXOKHopfx+gKLNHCzM8p24Kd6TUbInncV9cas3IHzKTudxpiwAS1Qu4XZgedF2u8x5B31B/gxqzFR3VizCNvGZYVlK+6G4zpZ6ijia/iNZxH44k73RqK6kcukrKtqR6l5JJAyT8bnkP7hvOOnElgCKxgQYYYbyKoiEPzRQglb2dc9tX8fok5lXLeUd0u2CDi8MGoEaq5Ubi+apwCkLkT5Gn3M2Db3aDmU9gXkNSjjjMGrGLehkSiu/ALFmjO13XDjUUdw/OKjf8JmBO0FS4k8Gfbz0iAjVHW5os+xw4dDEfSE3hOCvYy1cSTTzhm00l14qTP2wIASPZ3g9EzEymt6QdU52m83n7ntzLg36W4wlhTc00X4EDvi/L301SSS6Fhi9qmDcQLVJoa8owg/qvOEyfpumBk76ZM4YKDsMKbbh6+FeeiIt8ZQO2nBfe7iwTBlBwow3mz0nN+P8pWqT0mIMqr/F9dKkd3Xnu/5sgUtxh60Q9nRUJnTivTXpYdXRKsB961YcUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a/n6Y3qI1vv7ZHzX07ax9kOb0BMx7/iKGwp2H+8ijdcmEAZMmuA177TxPBSM/9GQvIPEOGpgs7dtxbhf86p8VOCyLi0gRg4IKg25NsqZH+ku5G9KUYVLt/jfbxGaXznDbAPcegWgYAk6kAdyGoMz1/rPXVAbCSX8O85TAO5Y0GtEvNMzhmkilvMrvZB7Nhyio9pYi+9uhoY0+cwIsjKHXjR6t7Z5TMFATx/tmgNBVc5teRsobBUYWCyLAUxqzAIUnNBs25p1KcLMjoOMAscd6CYe64YnFfNfBl11aRptwahb5xcgTnhcRhowHbUiuGy5SO3ItCOQXuv/ElnY9TcRPRo6FnkaqsxuHBp4VyUu5Hohp3RQXkI4kiX7rQ5SVaEm84nOcrRjTof0zd6sDGAE7vaLlOo/CWdm/jdSllIeGqq5iSRM6w+D97Dumy3iAdfR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:34.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb94d52f-e964-4de9-89cf-08df141b4a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Reduce the two KUnit tests for amdgpu_dm_plane_get_plane_formats() to
one.

[HOW]
Allocate a second plane cap with the DCN universal type in the existing
test and check the overlay format count against it, then drop the
standalone test.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 39 ++++++-------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index f60bb6239e53..8fcde1e55a31 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -258,18 +258,23 @@ static void dm_test_modifier_gfx9_swizzle_mode(struct kunit *test)
  * dm_test_get_plane_formats() - Verify plane format counts for key plane types.
  * @test: KUnit test context.
  *
- * Verify if returned format counts match primary, overlay, and cursor planes.
+ * Verify if returned format counts match primary, overlay, and cursor planes,
+ * and if an overlay with a DCN universal plane cap reports the RGB list
+ * instead of the overlay-only list.
  */
 static void dm_test_get_plane_formats(struct kunit *test)
 {
 	struct drm_plane *plane;
 	struct dc_plane_cap *cap;
+	struct dc_plane_cap *universal_cap;
 	uint32_t formats[32] = {0};
 
 	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
 	cap = kunit_kzalloc(test, sizeof(*cap), GFP_KERNEL);
+	universal_cap = kunit_kzalloc(test, sizeof(*universal_cap), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, plane);
 	KUNIT_ASSERT_NOT_NULL(test, cap);
+	KUNIT_ASSERT_NOT_NULL(test, universal_cap);
 
 	plane->type = DRM_PLANE_TYPE_PRIMARY;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 14);
@@ -282,6 +287,11 @@ static void dm_test_get_plane_formats(struct kunit *test)
 	plane->type = DRM_PLANE_TYPE_OVERLAY;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 9);
 
+	universal_cap->type = DC_PLANE_TYPE_DCN_UNIVERSAL;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_plane_formats(plane, universal_cap, formats, 32),
+			14);
+
 	plane->type = DRM_PLANE_TYPE_CURSOR;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 1);
 }
@@ -1307,32 +1317,6 @@ static u64 dm_test_gfx11_dcc_4k_modifier(u32 pipe_xor_bits, u32 pkrs, u32 tile)
 	       AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
 }
 
-/**
- * dm_test_get_plane_formats_overlay_universal_cap() - Verify universal overlay.
- * @test: KUnit test context.
- *
- * Verify if an overlay plane with a DCN universal plane cap reports the RGB
- * format list instead of the overlay-only list.
- */
-static void dm_test_get_plane_formats_overlay_universal_cap(struct kunit *test)
-{
-	struct drm_plane *plane;
-	struct dc_plane_cap *cap;
-	u32 formats[32] = {0};
-
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	cap = kunit_kzalloc(test, sizeof(*cap), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, cap);
-
-	plane->type = DRM_PLANE_TYPE_OVERLAY;
-	cap->type = DC_PLANE_TYPE_DCN_UNIVERSAL;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_get_plane_formats(plane, cap, formats, 32),
-			14);
-}
-
 /**
  * dm_test_get_plane_modifiers_gfx9() - Verify GFX9 modifier list generation.
  * @test: KUnit test context.
@@ -3968,7 +3952,6 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_modifier_gfx9_swizzle_mode),
 	/* amdgpu_dm_plane_get_plane_formats() */
 	KUNIT_CASE(dm_test_get_plane_formats),
-	KUNIT_CASE(dm_test_get_plane_formats_overlay_universal_cap),
 	/* amdgpu_dm_plane_get_plane_modifiers() */
 	KUNIT_CASE(dm_test_get_plane_modifiers),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx6),
-- 
2.55.0

