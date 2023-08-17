Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBE1C2FC0F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 03:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BB510E3E2;
	Thu, 17 Aug 2023 03:33:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D1410E3E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 03:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq3D/jcb0yJu7MMMXKTmdXF7DTKSUKxqyj68iLIXEsw0/XMMoVJXmvcsITyUv3Pjqg9O22yqWw47oyqJm4mShQLTtvTuVC20IqZ6fUmKmSHODJdFHwZFycZe9AUmNLoyNBIv/B2qOt4w1Hg3PrkDx66m1pH8kJzCeT99tLbx00G1FXEFLDxeW8+7QFsf0m56JH8WP3+atfudOk2Euln3xlk4llpHe0/ZGy8ym2Puz23FKl+YiXntvuxCDcWDiv2UxXBjHElp+pjHefdD8hdtGqzXvGs82OjoqXrqsPCexlV9yFzP2/7cmZCYxA72nRoCGqQpN/2GKuCwgN4ezopYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r+FTWk3APWPFZX8ElGBgAGg33063sBpz5gq4I+Jfxg=;
 b=QayeH3AhkPs/0G49jXnWdO8A/98YMGMWm88SA6rdu9ei0eF+2dAP1lhDOdLN1+tlnSH1L65ojwWV5pIK5XZRZ68usE1Q1K2PQZceYvULAPjI1OimnmmcQEelxEIqgmCsdwaDN3frJbFZD9gTw1RrjZWBFM4UQPDMXC6Z2YyWLpncGOBSSCoaFHbDGf+xPbcYBKGoX2W02Z3VKLpFOQTVnqnjfTL8UFgkkVbPBQ8QXs4XGVsgiMUurhyTwB+zjZ3h/Lheg4q9a2ys2xGakhKHNQUODivMdGdXw0xgoF3irt9QNV0kDBjLTC6WBWW+5iA3jh8+gioFJkRvLXPrL4TaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r+FTWk3APWPFZX8ElGBgAGg33063sBpz5gq4I+Jfxg=;
 b=vJvw0ZGDWteAr7KkLHCD+byb1Bs9ptQHwoPp23qvewb0PYJipbIQ9soTqGGex17Qm9TQE8zpElZCld8ia4H0S2j9sONZAIOuaQcBbFVlTNM65PJRb6ION2WOxwBNRQoDIhHR0shlhRxtmVMrCbBxIX1tX4hVMBfRDpza04h+Iew=
Received: from SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 03:33:19 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::3b) by SA0PR11CA0062.outlook.office365.com
 (2603:10b6:806:d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 03:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 03:33:18 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 22:33:17 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: update gc_info v2_1 from discovery
Date: Thu, 17 Aug 2023 11:32:54 +0800
Message-ID: <20230817033254.26780-2-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817033254.26780-1-le.ma@amd.com>
References: <20230817033254.26780-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fe7de2-2931-49bf-c3bb-08db9ed2b306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7O3OHjF6WyeieE5y01g99PbpfyQho5o6xriJNhdQYpPiGwoKzILNrRbXT3x+wDlxZfiUtlXjzevu/HLx00clRTAER7PtnBIKfrDWsKcQFlOy2sEZJ2ga/voCedzAr1ybApNyNB17f26Rh+WvzjSa08wzO0w9gPvJzsfhQFdXAUUQiHylqkOGtEJaq2IIj0T3BD7AHH2max7CNQ2U+MVhKc+rfhyWbU3x8WQzAvIvON+yWlclPiETNdITAZ+srvbse7NeH89x/UFJH0HbAlinvm4fe0O1TdAn10BvHJiQuI3oCPWzBN4PdlZ+fY591bXKCQ73f9uvIY3f90yb2+oqzjk6BmvLp6ingOiGeuFSkD8B3/I6s6srrWHjLU/bjHOD+E7j9KQk2N4PHTRIoNRLNsFcmbUb4Iou+7J7KwgMTSOlaRWRhsDFEI4ICE6ZWPsCsZCW5TVPr/zwV29C7HwwV3vYXB+XZsX6MUUrB0dnIlD0fvAqmd4Qh4pBp4weVCJjBSdpffZboMXpa2FdNezB+jKi1CfywojKRPwtdOkI5jh9HcvA32Mkv9SWpZnDbbaOEht89srRTEBzAgMBEdasu+iBIT2+t9CYqz5DTJ0CYYCjPH2cK92OSdHoFMxHJuZc1NhFNPiRvZM3WBsRkUXPLkpce+eEt58eHswlFFlSjIPT4dE2Cr/SjBOADW85v1CucvkIaNzzrL4wgEjg9KoagYXXlGql5u7Ff238WIXrJ2UOhvy51v4nq7kW4j5KrHgnyiApSphMxkrUUhqBlPYWRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(426003)(2906002)(336012)(36860700001)(70586007)(70206006)(6666004)(7696005)(6916009)(316002)(478600001)(44832011)(2616005)(5660300002)(16526019)(26005)(1076003)(41300700001)(8936002)(8676002)(4326008)(36756003)(86362001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 03:33:18.6474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fe7de2-2931-49bf-c3bb-08db9ed2b306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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
Cc: Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Several new fields are exposed in gc_info v2_1

Change-Id: Ib320e8ca70de8960634e1a22aaf2611ba7ebbaeb
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
 drivers/gpu/drm/amd/include/discovery.h       | 30 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f4cd43ce251b..6ffdfc5a7c0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1390,6 +1390,7 @@ union gc_info {
 	struct gc_info_v1_1 v1_1;
 	struct gc_info_v1_2 v1_2;
 	struct gc_info_v2_0 v2;
+	struct gc_info_v2_1 v2_1;
 };
 
 static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
@@ -1465,6 +1466,15 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v2.gc_num_sc_per_se) /
 			le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
 		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v2.gc_num_packer_per_sc);
+		if (gc_info->v2.header.version_minor == 1) {
+			adev->gfx.config.gc_num_tcp_per_sa = le32_to_cpu(gc_info->v2_1.gc_num_tcp_per_sh);
+			adev->gfx.config.gc_tcp_size_per_cu = le32_to_cpu(gc_info->v2_1.gc_tcp_size_per_cu);
+			adev->gfx.config.gc_num_sdp_interface = le32_to_cpu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
+			adev->gfx.config.gc_num_cu_per_sqc = le32_to_cpu(gc_info->v2_1.gc_num_cu_per_sqc);
+			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc = le32_to_cpu(gc_info->v2_1.gc_instruction_cache_size_per_sqc);
+			adev->gfx.config.gc_l1_data_cache_size_per_sqc = le32_to_cpu(gc_info->v2_1.gc_scalar_data_cache_size_per_sqc);
+			adev->gfx.config.gc_tcc_size = le32_to_cpu(gc_info->v2_1.gc_tcc_size); /* per XCD */
+		}
 		break;
 	default:
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a4ff515ce896..395c1768b9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -241,6 +241,9 @@ struct amdgpu_gfx_config {
 	uint32_t gc_gl1c_per_sa;
 	uint32_t gc_gl1c_size_per_instance;
 	uint32_t gc_gl2c_per_gpu;
+	uint32_t gc_tcp_size_per_cu;
+	uint32_t gc_num_cu_per_sqc;
+	uint32_t gc_tcc_size;
 };
 
 struct amdgpu_cu_info {
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index b9884e576f98..7a9d473d0917 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -280,6 +280,36 @@ struct gc_info_v2_0 {
 	uint32_t gc_num_packer_per_sc;
 };
 
+struct gc_info_v2_1 {
+	struct gpu_info_header header;
+
+	uint32_t gc_num_se;
+	uint32_t gc_num_cu_per_sh;
+	uint32_t gc_num_sh_per_se;
+	uint32_t gc_num_rb_per_se;
+	uint32_t gc_num_tccs;
+	uint32_t gc_num_gprs;
+	uint32_t gc_num_max_gs_thds;
+	uint32_t gc_gs_table_depth;
+	uint32_t gc_gsprim_buff_depth;
+	uint32_t gc_parameter_cache_depth;
+	uint32_t gc_double_offchip_lds_buffer;
+	uint32_t gc_wave_size;
+	uint32_t gc_max_waves_per_simd;
+	uint32_t gc_max_scratch_slots_per_cu;
+	uint32_t gc_lds_size;
+	uint32_t gc_num_sc_per_se;
+	uint32_t gc_num_packer_per_sc;
+	/* new for v2_1 */
+	uint32_t gc_num_tcp_per_sh;
+	uint32_t gc_tcp_size_per_cu;
+	uint32_t gc_num_sdp_interface;
+	uint32_t gc_num_cu_per_sqc;
+	uint32_t gc_instruction_cache_size_per_sqc;
+	uint32_t gc_scalar_data_cache_size_per_sqc;
+	uint32_t gc_tcc_size;
+};
+
 typedef struct harvest_info_header {
 	uint32_t signature; /* Table Signature */
 	uint32_t version;   /* Table Version */
-- 
2.38.1

