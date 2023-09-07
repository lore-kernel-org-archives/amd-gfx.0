Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FAAEE14A9
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 03:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D0010E74F;
	Thu,  7 Sep 2023 03:28:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65F010E74F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 03:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGpJRWwQFSFNTlVQmDMqZm7VpxT1K5bYjwDzV43kn4berl5t8jryFFSV+/80DzxFytoYvY3VHA4VuyeDAG2EjhdboAQ7cfOyx4/B+YKTaGuR698dmbmx7DE9qlYgFeBiggbob6+YeTQ3TXrUnM9nSPh9pc/f3sSXlRn4Ic9y5mLIKquJq0VkMYtpesZwtzqzUv6VhBI6hJtQT/LQRXqJXLwfNOunLOxDxZK0CqUGEp8vYNeecaaisFxjYJnp2q1SR8tQIo4k5YNTgKYWP64xPhAfmAte3VIUTgLiRQ4hGVQScSLABW7j1IEG+VsfD8KvxQhHhIR7PlBI0qWsvVQEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvvtzyazZ5qWXK15FY4SKYxxx0RNa3wnjdr3dFLZYQU=;
 b=mocPxIRcALDhmQDR0WrZ33FCpGMe9+ojPCOK5GjEnPw85cXI8TBrYL0Ui7LmxBZsQ11QRUscDAfhO+JOJnib1lA32gJenl+GIGKih3if1+iG2TV3q9rcboEPCRamHvb60P3d7aNk3GOUR+KV35KUtK9yiw3U7m2nPUE8MhutV81KEOEoPhIf5nfCzobFU1ljWSUMgMpC6rVZQGOsCjWHmq3/Opy/oB0AdvRKR8sDT1powiW+NEvT+uWqBEvfvLU466pVEKZM4MZIOtxc+4jCc4xD1dnsGd5PyzaBqs6h4DcoLGgfmF0ndrellDDAiJIpMC6NVMdMLa6FX7sy6mSquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvvtzyazZ5qWXK15FY4SKYxxx0RNa3wnjdr3dFLZYQU=;
 b=LR5SLy2R2bH6rh7YKMBoYuXu6k6mWNpJR8sR27WqNbjHeV2oYv+puxKwMe4zWVKP45sJCrzF7jLyuwVcqwcrD7Hdqkos0z/APamb1Ujcf0HRJWNZGho1XVzM+V7Et2/G/CiIs9qr8Xyi/PtofNJ0C/nEmUkjzERJYOnEiTrPA/Y=
Received: from CY8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:930:45::12)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 03:28:45 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::dc) by CY8PR22CA0004.outlook.office365.com
 (2603:10b6:930:45::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 03:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 03:28:44 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 22:28:40 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change harvest unit to WGP for gfx10 and later
Date: Thu, 7 Sep 2023 11:27:11 +0800
Message-ID: <20230907032711.99858-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6bea47-73bc-4af4-afc6-08dbaf528a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlLk7Q8ltu/x6kKlNTGylxbamTEGMpGc23JXKuV5R0g/LfPOy43/uASc61rY30roqLnG+VKgdADMLwpXNU03jmwE1sSKDE6ZRSYi7pPIdSw9s1+nvbR3xCdgGXuHIQzBabOZ04feKhz9rPzR0KYx0w4h7bek27TwzjpxpkMOp8OirRpDRO9z1Pa/u0DGB+uMqZSCewJkCQttYpfr7o/MqiYf3kyw3Ea3/QVMcpAoQF+n+cpIuddblBk4UmPP0jtv1g5Wfthq9/FE4JF1LhH9Lozj13UnbQ5dsBUUmSj7/vo85t0+2c5lFD9ljzq5piNJ6kdrAUu/lEXX/USMHLZCyAiSVt6Xm95+fyTLQuvJhh/COd4c7WRqZRJo6Iho17WUKeGoHUhkFr8HvziNS54LBBZyftvG6JAXdWOkU7dQV0XLXkCWLE3BG/5jMgwyhzFoin0DGgQK57L9smJNnvhXTUNR9fk3Zsig7nMWI9m3xaPl5m/EZcDwjhjvKFhucFs1hFMnBd4KabVZqg+GhPwF6Hvn9ZOH0niN05OMja0o5ZFNVrmUCfUjexok/ocVxg+vdyCKZAPQu+okfTeEfo9kzSftQ7KW9sIZv8Q9rePVQuOw4yp7utkusJuHbdYD4P3CNFCgOwvDqhOfSdVaSFiGZyq+we5yqXlY868kQZCVZgTBh3MlUlreiL4P68VlDHKWfeFQMLkR30xSKiSkbLAEMpk/FC//vwMoD3Q7UI9CfwqWAgJBTrgPq09f63GGA/vSFpNr1urJlSEmkTDrixM2Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(2616005)(40460700003)(26005)(81166007)(16526019)(356005)(1076003)(7696005)(47076005)(36756003)(426003)(336012)(83380400001)(40480700001)(478600001)(8676002)(4326008)(8936002)(70586007)(70206006)(5660300002)(54906003)(86362001)(316002)(2906002)(6666004)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 03:28:44.5734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6bea47-73bc-4af4-afc6-08dbaf528a60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From gfx10 and onwards, there are two bitmaps in driver,
CU bitmap and WGP bitmap, current log for harvesting WGP is
misleading, the disabling unit is WGP not CU for gfx10 and later.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  2 +-
 11 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 83a9607a87b8..81191005854d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -184,7 +184,7 @@ extern uint amdgpu_pcie_lane_cap;
 extern u64 amdgpu_cg_mask;
 extern uint amdgpu_pg_mask;
 extern uint amdgpu_sdma_phase_quantum;
-extern char *amdgpu_disable_cu;
+extern char *amdgpu_disable_wgp_cu;
 extern char *amdgpu_virtual_display;
 extern uint amdgpu_pp_feature_mask;
 extern uint amdgpu_force_long_training;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ef713806dd60..1eff18649963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -151,7 +151,7 @@ uint amdgpu_pcie_lane_cap;
 u64 amdgpu_cg_mask = 0xffffffffffffffff;
 uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
-char *amdgpu_disable_cu;
+char *amdgpu_disable_wgp_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
 /*
@@ -505,11 +505,11 @@ MODULE_PARM_DESC(sdma_phase_quantum, "SDMA context switch phase quantum (x 1K GP
 module_param_named(sdma_phase_quantum, amdgpu_sdma_phase_quantum, uint, 0444);
 
 /**
- * DOC: disable_cu (charp)
- * Set to disable CUs (It's set like se.sh.cu,...). The default is NULL.
+ * DOC: disable_wgp_cu (charp)
+ * Set to disable WGP (gfx10 and later) or CUs (gfx9 and ealier) (It's set like se.sh.cu,...). The default is NULL.
  */
-MODULE_PARM_DESC(disable_cu, "Disable CUs (se.sh.cu,...)");
-module_param_named(disable_cu, amdgpu_disable_cu, charp, 0444);
+MODULE_PARM_DESC(disable_wgp_cu, "Disable WGP or CUs (se.sh.cu,...)");
+module_param_named(disable_wgp_cu, amdgpu_disable_wgp_cu, charp, 0444);
 
 /**
  * DOC: virtual_display (charp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2382921710ec..13a24efe2352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -107,20 +107,23 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
  * @max_se: number of SEs
  * @max_sh: number of SHs
  *
- * The bitmask of CUs to be disabled in the shader array determined by se and
+ * The bitmask of WGP or CUs to be disabled in the shader array determined by se and
  * sh is stored in mask[se * max_sh + sh].
  */
-void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsigned int max_sh)
+void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsigned int max_sh, bool wgp_mode)
 {
 	unsigned int se, sh, cu;
 	const char *p;
+	const char *disable_unit;
+
+	disable_unit = wgp_mode ? "WGP" : "CU";
 
 	memset(mask, 0, sizeof(*mask) * max_se * max_sh);
 
-	if (!amdgpu_disable_cu || !*amdgpu_disable_cu)
+	if (!amdgpu_disable_wgp_cu || !*amdgpu_disable_wgp_cu)
 		return;
 
-	p = amdgpu_disable_cu;
+	p = amdgpu_disable_wgp_cu;
 	for (;;) {
 		char *next;
 		int ret = sscanf(p, "%u.%u.%u", &se, &sh, &cu);
@@ -131,11 +134,11 @@ void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsign
 		}
 
 		if (se < max_se && sh < max_sh && cu < 16) {
-			DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
+			DRM_INFO("amdgpu: disabling %s %u.%u.%u\n", disable_unit, se, sh, cu);
 			mask[se * max_sh + sh] |= 1u << cu;
 		} else {
-			DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
-				  se, sh, cu);
+			DRM_ERROR("amdgpu: disable_%s %u.%u.%u is out of range\n",
+				  disable_unit, se, sh, cu);
 		}
 
 		next = strchr(p, ',');
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 395c1768b9fc..c13af19c9b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -473,7 +473,7 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 }
 
 void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
-				 unsigned max_sh);
+				 unsigned max_sh, bool wgp_mode);
 
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6ccde07ed63e..bdb980e20b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9422,7 +9422,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2, true);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 337ed771605f..03b765658d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6364,7 +6364,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2);
+	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2, true);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index da6caff78c22..33182b058458 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3564,7 +3564,7 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 
 	memset(cu_info, 0, sizeof(*cu_info));
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 90b034b173c1..f916266d86b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5106,7 +5106,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 
 	memset(cu_info, 0, sizeof(*cu_info));
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 51c1745c8369..cb28926eca55 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -7108,7 +7108,7 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 	else
 		ao_cu_num = adev->gfx.config.max_cu_per_sh;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5c85ac34360f..aa2b6517d38d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7208,7 +7208,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 
 	amdgpu_gfx_parse_disable_cu(disable_masks,
 				    adev->gfx.config.max_shader_engines,
-				    adev->gfx.config.max_sh_per_se);
+				    adev->gfx.config.max_sh_per_se, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a60d1a8405d4..6a9005eee43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4306,7 +4306,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 
 	amdgpu_gfx_parse_disable_cu(disable_masks,
 				    adev->gfx.config.max_shader_engines,
-				    adev->gfx.config.max_sh_per_se);
+				    adev->gfx.config.max_sh_per_se, false);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-- 
2.37.3

