Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B754C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1714B10E72C;
	Mon, 27 Mar 2023 19:36:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BC310E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8Up5aVBBOiSy1olQra9I5MY6n2Tr2Mx9iP91F16cQVcnkQMpAOoykI4OMat7x2BQEMeCBHE03u5sOnyNNUpir2bCRqvg1VGBiy7ToKuT3dBIgKuYXr7vPBwFK7Yq4B6iEQG2Hz5gJkPIncsoPJj9Odv/dGzddL1VMGUA28ZUknHc4KSKErFGNC4kppzTAf69smsbzI0mUWUAGf0BgOyjObCBF/kJLiE3YplqBVQITuj9kPbAqfeBaLPjSrrOCIkYD2sy8aVIsjrVIdr6Zr+aohPSYAbV6i/X1KXWm328WiiInMiAWZDtRFoTBBI3W8N+h27SoPc5IVLEmNd9CP+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqUrLjESEk64FP3m8NMwcR0r9K88/OvrcF/RkCgR4Ps=;
 b=mP2XcFYJgGonn9zw6tyAWgdTEzLXMeFa8aTpyGFtSSkQp/LPG31BHKhBsdlMos1CoCPN32Mv3kjuEe4L3QD+TsOA3uy8JrHnagg7pFkrhXIVigLwisQlYnwZ4t/7H1kt1UHbzX4VY2sBFE8QPEJAYMwrG51Xh40mP5Ef5jAzdyTNEhwdxVpx1ynOlNxMnsFrWGY1a43SjYzG4gaFvnTLQfz3l4okwB3gXtzf3E7Y+wfcg1ta2AVTqZS3ye19PUlp6O2KSzsTLwQr1pB9qgdwABvLVRsNpobQB2/PCQRRmac0Ga3luEpE72NNj246P5wI6i+4K6FFD+IAeNjK7/Kwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqUrLjESEk64FP3m8NMwcR0r9K88/OvrcF/RkCgR4Ps=;
 b=JV/sCQqSoenYEPVQnt3gHemMjHneZJ2lDrPSYlA+9cTqK/lfsHKdRWQJf+Ly5Lc4fl7hCqyLzQFVpk8iYoS2oUaDUOLol4jmQWA/Qpc4whQLyWvJZSkg5v6P5Ufz6g3VTVJfyYWsi7SyyVKMeINOB21VJYRJHhK0un1QhZJL2FI=
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:37 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::9d) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/28] drm/amdgpu: override partition mode through module
 parameter
Date: Mon, 27 Mar 2023 15:35:58 -0400
Message-ID: <20230327193602.7901-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: f37fd5c3-936b-40cd-8b1e-08db2efa9467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYM+YHMR0gKe8MiegrCsh/A8sUgxcZj6IxkbAcKY+5tTlH7zd9sDVaBQxN13JSl/zx1fi1209MgEb0kQn6sbOXzB6xyRlGNAEW5TKzXuZOyQj9OTbtftiWOLpcfSIrvP2zkWfm6ZaM2rgMa36H9+FB+MbbSZDcOjY0DauX1KCgihQN45tI4hbp4FshXExxDv1BoI0nPtLi9AEFx0+Z8llSovHSbiH+rTeM651hJMHd3rg2Gyiw3GLrUv00bHWq7/hYLEVoaOgCIvHn/+S5YZwfowd8clXklevT+btDnSLs5VZdP0+fqL5Bc62+gBMiG/08sQV7Ic/uqN7xojSpRooaDy+uMUk3F2YosLr+1YE2HMF5s5/gDIoMDgxSD7VygsDlP1sQKz5zQLXdfA0a9DfWoklxCJQvTDYy4L03igSPXhWZCkTxtNrLCi/0QkCQskWEEwGU99uvv6cQx0ycXU1vld4N0JorMQOBeNPrQD+P2ODuvD406P2oNfyBtr09BEb3/jugIN7OZaNpMBJkeW7g36Fmudyh6LdOwZ6hud6N9EBdFAhfJeCl/d4xeeUFvZbCvwGA2QyCVCdYeEBo+j/l0WGlUoJUFo2552luz4WSGVsMHkkimXqF0SkmZpIncJtsyo/DX38EHjq44Wbtw8r1Jk1u3aSwaIOCiVTV0L1EVY+SRmY3aIMJsNqnOiK9PQhkyyC0duPhU7rZSJp5TbuBIX9Ow6Pi5NOr7ZN6fyOjA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(7696005)(40460700003)(47076005)(82310400005)(16526019)(186003)(26005)(1076003)(36756003)(83380400001)(6666004)(86362001)(40480700001)(54906003)(41300700001)(2906002)(426003)(8936002)(336012)(36860700001)(316002)(81166007)(82740400003)(8676002)(5660300002)(6916009)(70586007)(2616005)(4326008)(70206006)(478600001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:36.9103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37fd5c3-936b-40cd-8b1e-08db2efa9467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

Add a module parameter to override the partition mode.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 25 +++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 81b437fa7b9c..bdc1190601d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
 
+extern uint amdgpu_user_partt_mode;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 917926c8dc5f..13bcd8e955ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -193,6 +193,7 @@ int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
+uint amdgpu_user_partt_mode = 0;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -957,6 +958,18 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: partition_mode (int)
+ * Used to override the default SPX mode.
+ */
+MODULE_PARM_DESC(user_partt_mode,
+	"specify partition mode to be used (0 = AMDGPU_SPX_PARTITION_MODE(default value), \
+						1 = AMDGPU_DPX_PARTITION_MODE, \
+						2 = AMDGPU_TPX_PARTITION_MODE, \
+						3 = AMDGPU_QPX_PARTITION_MODE, \
+						4 = AMDGPU_CPX_PARTITION_MODE)");
+module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9a9e52e1c4fd..048e21d202d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2168,8 +2168,29 @@ static int gfx_v9_4_3_early_init(void *handle)
 
 	/* hardcode in emulation phase */
 	adev->gfx.num_xcd = 1;
-	adev->gfx.num_xcc_per_xcp = 1;
-	adev->gfx.partition_mode = AMDGPU_SPX_PARTITION_MODE;
+
+	adev->gfx.partition_mode = amdgpu_user_partt_mode;
+	/* calculate the num_xcc_in_xcp for the partition mode*/
+	switch (amdgpu_user_partt_mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd / 2;
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd / 3;
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd / 4;
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		adev->gfx.num_xcc_per_xcp = 1;
+		break;
+	default:
+		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd;
+		break;
+	}
 
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
-- 
2.39.2

