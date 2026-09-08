Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD25FC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6649F10EB16;
	Tue,  8 Sep 2026 11:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBjL+QaM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A2010EB16
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHh5YNUlGC4kgLWOnp+5B2NVcYZDhObRJOZIkZH0neoD3rI8XIZu4+UGqRLniyNe2k+IU4Oq3ckEydGEkVnA6bHeDpxrmJJexky72o02yFQZffzAZrIVltvvAtBdqzf1fWYZlKPhJLyDViKnyohGcG7TnPHnGjb83c3STNMARzQxvaub6YuyDhYR8awPDKRbpzu2G1uFGEUdvaTlLu0kqqACDbX/VPeSGvZ/G10CVAZDPDnUSTkbVpZIkcpLy1u1F+yNopMpQROyjOMhuyQeCJnK6Gvkxhu+aWWFQdW98U00L7XeY+/LwtEDuXY7FNS12f9XzW5mf26RkvadPkbZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk8Qaw3N8x4yoLnWZ9MuYWV+zdyXbhrG5uW3O3uE8pA=;
 b=ZXLLzoc9zSq/CFqvGFYhfG/nPbZSOnR3aqpiYIgtAXCvmoV4+k8BwaScIHxx99rht4cfMK6hDxQqY8VVDI1NA7S5MdB7Mng9+f5MpwW6ElnckHNDv+YuGfuJSRiFd3Y8nzLQcXWuGsMiOllmfxHuP7nXBDbNF/Q6LLvEo0KAg5fNZ/O//UQm1i33M89Wc4pptfy/vPihWPaflvyonzdp9NUm/ZyEJ6gqsfXchqSeqPLNMxQB/eogQvInVs/r5k070O/nDgDTVVn0068vY4ofj6qcuiqlmtb9sHFDPQqUv9G7Ce4qiD43K2/JTrvBIkM8svhsg48qNtyQkyIVk6iKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk8Qaw3N8x4yoLnWZ9MuYWV+zdyXbhrG5uW3O3uE8pA=;
 b=dBjL+QaMr76uCw0AV488xdCE9ONT/fLjIzVzkLP29fOdZPfJOhw9wP1NugQOo2FejKDnqrB2LiKGXO45VbvxoCkp7/WqACko/c5S2ooHKz05jwR/qkDiVaTN/VakkIMJoA1MwkzlIfRZAzFSzL2BXg1/+ebuGqxnnFoI+i+TDOE=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:41:38 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::29) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:41:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:29 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:41:15 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 49/66] drm/amd/display: Drop dead update_type param from
 update_planes_and_stream_adapter
Date: Tue, 8 Sep 2026 19:31:42 +0800
Message-ID: <20260908113338.2433445-50-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d207c9e-65d2-44f3-121f-08df0d9e2515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m2wNund8/QI+4d1W99SBuRSlIBdcpOhRxphGsZmlMcHa0hPTH8UKocq9FKRMCPrW7CjOIIyGPIMeWpkvbNZhM0InMgW4p3wLGNvGqd7wxO4/gn3wsS1XLghyHDsDVMo3tFf7B11ghd6cHT3ZwV0C8PInJLeQ7hYV/D9K2v+R0G81ceTt+LoPBMZ2AUq/rRazhisU/g2jvVvo2LsJ56/wIDso/kRpJ9U8R4J0K8rvE0+v/G+ubJSxm8BdgPmaN4gQHRinxiATtcziJpQurfeQGTDjLD8GLJgYtA6GpbxI1XkOzld+LZTkASEmjvDcLRDwdibqHBsvMPRXhvpC1UmZpxvdSpJAB16XLj3hRf7qJtswh4Dj4+VGd/ro2UCmsH4sgiUDuyvqk5Or/AoACh5y4/xsEY+N8Jr5QCNFMWHveEoh+jNIyCTBctju49N0xQSOqlrCh5borc5IT5fgoOBPo2GS58DCBWGi7C+sCs5CeE9vkon3uZu368Xf/QxfnhmE5svods0myw2FaGr37TomqQ13wPkOZnJromodocA6R0BJE+xndU2a9DP4CogLGSYSfxrfnQ608/tK+uWcAVlfUKTw5fhFg8Azh7zbFHyL7JTvRtTZBlqiwkXK/Y0pUSulVYifVCAZRS/XeA/5CzbESHcReUjNmvw/qAnFi/lIgafm5CN2QxdxUzD5wQIcs5eYm6yd+g9SkAOYxOoPPUx/XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l/cr/xS7tyn6+D7tFP62x1YMlvaC3AIwGRPoAVzWGXoRIdKm2reVqQlo5ECPe3hSprAw9vGhflLiAPpa3pywhFdowcrVsCYIl/VxfwSMMDwO4kRbxVlzcAhn8fT7bW/qJIdPZdhFRkFCKXkDRDEyAnOKFBmHoVCHp2pEbHPacDnoc/6h8/g5CiKURPBuyNV+xuZZtQnu3TZKPKw3n2xr8m6lgsFW2y92OmpS5wqfv84QtRnh/EE+TPAfNnfUb9dv+q5VfcMGfmdUKhs9sssnQ3iZZDTExUv8KHf1lerQ/WbG1yuv9q3QmOIS3kwWspsO1TpbsqByK0p3MRGAnAW9HR/bwf4P4uBiNJQO1ioHbeIUf5RbrPRga7EDo55yxsAW7KGWUOng6+ASKNLEMO37kOKEHeUxksU3WZsNRVcH5ZvzLoiXU7ue/g+CZwg2wB2+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:41:38.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d207c9e-65d2-44f3-121f-08df0d9e2515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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

From: James Lin <pinglei.lin@amd.com>

[Why & How]
The adapter never read update_type; DC derives the update type itself inside
dc_update_planes_and_stream(). Drop the dead parameter from the prototype, the
two callers and the KUnit tests.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            | 4 ----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h            | 1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c | 4 ++--
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 301e09e60e75..9a585f8b3d67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -275,7 +275,6 @@ static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops;
  * before passing control to DC.
  *
  * @dc: Display Core control structure
- * @update_type: specify whether it is FULL/MEDIUM/FAST update
  * @planes_count: planes count to update
  * @stream: stream state
  * @stream_update: stream update
@@ -284,7 +283,6 @@ static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops;
  */
 STATIC_IFN_KUNIT INLINE_IFN_KUNIT
 bool update_planes_and_stream_adapter(struct dc *dc,
-				      int update_type,
 				      int planes_count,
 				      struct dc_stream_state *stream,
 				      struct dc_stream_update *stream_update,
@@ -1807,7 +1805,6 @@ STATIC_IFN_KUNIT void dm_gpureset_commit_state(struct dc_state *dc_state,
 		}
 
 		update_planes_and_stream_adapter(dm->dc,
-					 UPDATE_TYPE_FULL,
 					 dc_state->stream_status[k].plane_count,
 					 dc_state->streams[k],
 					 &bundle->stream_update,
@@ -4229,7 +4226,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 		mutex_lock(&dm->dc_lock);
 		update_planes_and_stream_adapter(dm->dc,
-					 acrtc_state->update_type,
 					 planes_count,
 					 acrtc_state->stream,
 					 stream_update_needed ? &bundle->stream_update : NULL,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d2b1a63c99a5..7b8941b44895 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1251,7 +1251,6 @@ void s3_handle_mst(struct drm_device *dev, bool suspend);
 void dm_gpureset_commit_state(struct dc_state *dc_state, struct amdgpu_display_manager *dm);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 bool update_planes_and_stream_adapter(struct dc *dc,
-				      int update_type,
 				      int planes_count,
 				      struct dc_stream_state *stream,
 				      struct dc_stream_update *stream_update,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 6335fc23e977..e0fbb84912df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -413,7 +413,7 @@ static void dm_test_update_planes_adapter_sorts_and_forwards(struct kunit *test)
 	};
 	dm_test_install_dm_ops(test, &dm_test_plane_update_ops);
 
-	KUNIT_EXPECT_TRUE(test, update_planes_and_stream_adapter(dc, UPDATE_TYPE_FAST, 3,
+	KUNIT_EXPECT_TRUE(test, update_planes_and_stream_adapter(dc, 3,
 								 stream, stream_update, updates));
 	KUNIT_EXPECT_EQ(test, updates[0].surface->layer_index, 5);
 	KUNIT_EXPECT_EQ(test, updates[1].surface->layer_index, 3);
@@ -436,7 +436,7 @@ static void dm_test_update_planes_adapter_propagates_failure(struct kunit *test)
 	dm_test_plane_update_ctx = (struct dm_test_plane_update_ops_ctx) { 0 };
 	dm_test_install_dm_ops(test, &dm_test_plane_update_ops);
 
-	KUNIT_EXPECT_FALSE(test, update_planes_and_stream_adapter(NULL, UPDATE_TYPE_FAST, 0,
+	KUNIT_EXPECT_FALSE(test, update_planes_and_stream_adapter(NULL, 0,
 								  NULL, NULL, NULL));
 }
 
-- 
2.43.0

