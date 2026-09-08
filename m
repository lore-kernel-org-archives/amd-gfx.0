Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D162BC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FCB10EB47;
	Tue,  8 Sep 2026 11:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YlGB8Tkf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BA210EB47
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSkN8RIwc0IootNqUqs2s8E1YvGkQA50KDdGUd4URo6VEGzvrEbZrREq/GnQW9+H2+tohDqRXsUyQzHDYLkHA+AJ5MW73TFB35FugmDOz3X/U3xxfA4IykCx5N0eYBG1DRRcD1jquNXkGM0EHXGvJDtgDTqzFa4M9bOjPO4kBLNEvZUkgd5ydZRjthusGnZkHJXUNAcPnYkPpvXMy1Ypgos2XkHAhib0u4f1STU3c9rrPewIXamIt0mK3odwUy8h43tvv0jBAPuq7am0tEPRx4LNeyfiVPVRRFHoeTdqLLS4HP73cfUWHOllPaDETsqTRkIS5+vmrho7NOiNTnfEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkGPZbnaQzSGCvtOGF45eihVBNdesjGgeUQtBy+RrDc=;
 b=moW7/rNo7O92aAiCCCCLudswmJUsV/GP9GNUgbyKxBgj94ZVIFpXWRpET2nWQYrI3kD5fqPm/uk3RrNaz6C5rVeO/18skq7dJ+7kShpT0KkvPxFYuPL3JWIim17H71dA6lGtCqhdGN8PKf7NqtV0g1ZICaKtXznCryL97C+p1dQChZ4a4+jyrytTwPTE6wyaL2O4KUoImk8Bf2RaVrz39wmYN6GEaslAZ7w/alwIcMRJPjIt/fbjT0n9paDngwo8yb4guZ+3EY0aoqX3e8nO2a91QhO+3jbRVYlgsiydukJF5rwtn+gyFe/Tfy0orxRTMy/6PnmH+BjyypKF84FKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkGPZbnaQzSGCvtOGF45eihVBNdesjGgeUQtBy+RrDc=;
 b=YlGB8Tkf3QMuml5lLvP5bhEemXop3D1cKZV1iahOHQjD/1qFTx5vPEhRzx+WxAltVvJZ8AToc82ppkToub1UQB8olyAj/WAnF0HYoG2logEsbO7EPHjrZbL8J9O3mr2q9zhdAdylgt+laLf2C/2n5kfgSoYMWmG/hg6UfQFdpxc=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:36:46 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::38) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:44 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:36 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 20/66] drm/amd/display: Test oversized AUX transfer
Date: Tue, 8 Sep 2026 19:31:13 +0800
Message-ID: <20260908113338.2433445-21-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 90227e66-fbce-4647-1132-08df0d9d7677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AycpzmhPxA7T/Mkqto9dRH1ngd+NS+C5Imu8FtQNKBkK0o3DAybsxUvf2qQxsqnezt8eAxdkrlV1Pxqt85QH4ULD/ug7BXx08poOT+MQzJuhS9mhdG3MdpnqMJzQ7MbRwAJlmqHd4do+b5KzVWmM+poTtv25bNPu/QSaWtQH+d7PxZvPXLXdaaa97ciDfug+nldYUP/gKPhhqPNdOCWdwW8ay85+vwWEmU6koZMbfBVnQm2YWyxJOkoHeCCX1vUxmCQtVneoVVP+ERnBawHgl3QyG812lmv6KmRJX+lEJZpNPNJW17O3Etj6KHTgP8uhXpv/bP1MxCDYV3t52fgmBfl9ztNN0ZIIAV/49tbMPJ0LViEqP20Q0gU2eTnIb+vbEUKkymcSmC/lCAkepxtaxvEdg7qIab4UA97vGJqWEmj8XJsVKniVCyje+wzQO4BDtBmDG0aCStU9ebbGqQmFVbrjss32plGryvf/V/4x1zhIAVSK0qKihAZ/csDO5H16rRZBo2Tbi8utcdO7CmEWOy2Iz8aMDNga35rMeIKjC3TGkNHeyz0Ya/11SA9mkVk2gKIDLCvh4ix7dkTUnfo/ac7VMaMZ2Ij7Hrpo92KA95CuvTglN775s2DGll5sd7n0kXZ7J4Q+u49owK74wjMW0QXfJqXWP/7XQ2Y/o4rkrKwOOhb53Ov6gMqkCSQJWHU6T7KKmLcsQWm23kBuXkdyyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 42T9YGekC+HCdrGDxjCbyDiOGl1k7QoYOzSiwXROcvQ/+UFA9QHYNErqcSJXB/0Mu6aGzfopFWvy3VT24xRBIP4OrBFHEJWi8wgw3ryRu6AozU93+j2lybSZzbh9p4VxYcnR5gPYWx5V84wmWNE/6QXOEtFeJvIvSWpNpjyupHSsO3Tai5LmZ7u55W1zQ86eF9rexOcMixh38j4bxo9BSzxVUylxjqo7Ns08PtdO0McbW84tnDJWsbSmpLxjZ/8WLkAfShtdj1igZSMX/4XvPGn5kMhQcukbdgNp0ILDcqo0LIwZkmsOTpYYER7t5Kp28JoUBhtFuDQ6vrHam9Yls1mPCn0WAQeuQa36Og3caWLKXreaWE3atolCzQput/ugnN+d6FTRzH2dO6y/vGe82TEYATvi24/caq96yyzgVzflrmR8sVfGwJrUAKxHnYIe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:45.7411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90227e66-fbce-4647-1132-08df0d9d7677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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
Add a KUnit test for dm_dp_aux_transfer() covering the message size
rejection path.

[HOW]
Build a drm_dp_aux_msg whose size exceeds the aux_payload buffer and
verify that dm_dp_aux_transfer() returns -E2BIG without issuing a
transfer.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../tests/amdgpu_dm_mst_types_test.c          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 36d3f0eebb50..af2dd5b8e79d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -885,6 +885,26 @@ static void dm_mst_test_aux_transfer_non_ack_reply(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address, 4U);
 }
 
+/**
+ * dm_mst_test_aux_transfer_oversized - oversized AUX message is rejected.
+ * @test: KUnit test context.
+ *
+ * The payload is copied into a 16-byte stack buffer, so a larger message must
+ * be rejected with -E2BIG before the AUX handle is touched. The guard warns,
+ * which is the expected behaviour for this caller bug.
+ */
+static void dm_mst_test_aux_transfer_oversized(struct kunit *test)
+{
+	struct drm_dp_aux_msg msg = { 0 };
+	u8 buffer[17] = { 0 };
+
+	msg.request = DP_AUX_NATIVE_WRITE;
+	msg.buffer = buffer;
+	msg.size = sizeof(buffer);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer(NULL, &msg), (ssize_t)-E2BIG);
+}
+
 /**
  * dm_mst_test_fill_payload_flags_native_write - native write request decode.
  * @test: KUnit test context.
@@ -2089,6 +2109,7 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_aux_transfer_error_result),
 	KUNIT_CASE(dm_mst_test_aux_transfer_hpd_discon_quirk),
 	KUNIT_CASE(dm_mst_test_aux_transfer_non_ack_reply),
+	KUNIT_CASE(dm_mst_test_aux_transfer_oversized),
 	/* dm_dp_aux_fill_payload_flags tests */
 	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_write),
 	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_read),
-- 
2.43.0

