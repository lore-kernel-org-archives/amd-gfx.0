Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0426FC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973CA10EFE8;
	Thu, 30 Mar 2023 19:32:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A01E10EFCF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnwAbPItsvzaQ6tzmKa0SsmlYBuKZUUtLt6+cSU6avUEYmlIHtXGfYeyHHHlPGfQrxHvhG6pl1Dfz5/YYxSalGRSHnIZHW8AnXGwHv7vTiMQPJzDNckm0gwWoKVC6VifH2RTLXXOSwODENpq3T8guSC5c/jIomfwXlg+V4X0Taz6N5WBiMoNuXRtvpBFLwix1/GTGXVHVBSDgAnSQ/SLDrGhSLclFKk8odCdYKxbvE/bfvtSwxuiH3giNMNubl3zfu+mrPwWYpDRi+DupxgwTivRzOmvY9b6NLGY4C/DFEPs47/9GmF+PGI/XtAipgNwLT4PoXE+5qC2OhLCdppCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsQwKJeQCTnNRcvKBuCl4Cl1jV/iPnBpOsKU5YJ107s=;
 b=n8C+4ivoRsD4Iu9XAO5lnMR6QbdDXls/6gcphHbPl/saBz3XKACxBJ8BQebvlCsdrDWH7/Urdo0l0FQDDWJXBPX0CvRAUuQY5T3uXSS253SnbdGZu40gCaMxwGOcO0yQDVYBLtxCvM7LUDx8WlHZMHISigoGa4U2uYZUiUDdYl0URajhVtn6S5gVymJLXEziBds/Fad2j9jEOcxj2igozd/1Cm9nkaHAM8+4AkRM7YsWoh4N5AuLmpsPsFgr8cBB/XVJcrX8XvNsxHFgWHsr/NegJzlu4cfo0Fk9nt4HsU92FJst8MlwiAUULT9lENrWOXKg1Pxc7gC07DA6vBboXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsQwKJeQCTnNRcvKBuCl4Cl1jV/iPnBpOsKU5YJ107s=;
 b=f5e8e8FG39MM1zjh4pAOTlmYix6tYyxVYqfNly9bOzGMnxpdkej+dKcSx00yYsgvvwitd3q5XfCQAMmB1yMCt+ZPaH+1N5yMkOE2I9Kw40+tvlMHy/lhdSN8TleWUEvDWWLP7Rbl7prV8hFQBljO09Ow9/i7YI52v+YvxvuRYUI=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:32:23 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::fa) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amdgpu: Switch to SOC partition funcs
Date: Thu, 30 Mar 2023 15:31:54 -0400
Message-ID: <20230330193158.1134802-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cad090-5cee-40c2-1334-08db31557cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZDZIOzlKPmHbzp2PaVDOU9AN8li6OJ5RcLO2LkZQVmeE1gVXE7NQ+Aumgmv0LQATytVhc2mVJ33b+4IFn3YDOyN477Lg9KyOuJJ2KlSey63MMpUzuEEtOYEiT8EscLNVmI32HdPHMBwnwBiIZwfUsKp0FxbjOkyeXU2WJmFvcoZl3VBE0frmuq1I7vIFPGXYhlU2xvhVzzXit2cyluPnGKI/WXSQcGrZylmqdvGc7IcfebENe6aGKvOUi0Tl+XHnM4ueLZgRKoIqpi/l7mDZLIGuX7RK/dKG8pMCoNGelT7b7V0xs/WraewO1kdhV7BstkTt4C/IA9lVEcDZcYjcVH4Iahlr59jr07f1Rief6oKZgmaw7Jb2/hhBx8iLBoqZ1Ym5keE3l/ACP/6p6MlfiKkHrKNHOp8iB0zw4CoN68SjbWhWlIOOCOMHLRQmpkS9cVQN4CZKIpU/mDRngk9V8NFIA0LtuAU31XYkeXzOoEa99vZ0VhxP9qFKNrpbbVDXwN5f8+9GMlAdi1/Lvj7wb/N6/w0bQhFdoJYcOvirBVx3H2OI76dF20uRSm8DGhFWI40gidjjeviRkVyT5eTRbvQBfOn8KYW0JouFSbEFiexsTyjjMm54QvdtMKyDfkUjl6NSTlquV+wOLX7xZ2XgUe4ISJ24e923nR9mdG40K8SJZOJ8fYjyYIUjqr9H1pnQt6hworwIBv40Q6wZieGPLRdooueSAnrazzZyWbLukc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(336012)(47076005)(81166007)(4326008)(356005)(8936002)(6916009)(70586007)(36756003)(82310400005)(70206006)(5660300002)(82740400003)(40480700001)(8676002)(86362001)(41300700001)(83380400001)(2616005)(36860700001)(426003)(6666004)(54906003)(2906002)(1076003)(186003)(478600001)(316002)(7696005)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:23.6811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cad090-5cee-40c2-1334-08db31557cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

For GFXv9.4.3, use SOC level partition switch implementation rather than
keeping them at GFX IP level. Change the exisiting implementation in
GFX IP for keeping partition mode and restrict it to only GFX related
switch.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 31 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  5 --
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 61 +++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  8 ++-
 5 files changed, 21 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7d036a94a557..ce9f43024ed1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -28,6 +28,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_xcp.h"
 
 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
@@ -1092,10 +1093,10 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	enum amdgpu_gfx_partition mode;
+	int mode;
 	char *partition_mode;
 
-	mode = adev->gfx.funcs->query_partition_mode(adev);
+	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr);
 
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
@@ -1176,31 +1177,7 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (!adev->kfd.init_complete)
-		return -EPERM;
-
-	mutex_lock(&adev->gfx.partition_mutex);
-
-	if (mode == adev->gfx.funcs->query_partition_mode(adev))
-		goto out;
-
-	ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
-	if (ret)
-		goto out;
-
-	amdgpu_amdkfd_device_fini_sw(adev);
-
-	adev->gfx.funcs->switch_partition_mode(adev, mode);
-
-	amdgpu_amdkfd_device_probe(adev);
-	amdgpu_amdkfd_device_init(adev);
-	/* If KFD init failed, return failure */
-	if (!adev->kfd.init_complete)
-		ret = -EIO;
-
-	amdgpu_amdkfd_unlock_kfd(adev);
-out:
-	mutex_unlock(&adev->gfx.partition_mutex);
+	ret = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, mode);
 
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 3fc4f090ca49..674777b03663 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -269,11 +269,7 @@ struct amdgpu_gfx_funcs {
 			(*query_partition_mode)(struct amdgpu_device *adev);
 	enum amdgpu_memory_partition
 			(*query_mem_partition_mode)(struct amdgpu_device *adev);
-
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
-				     enum amdgpu_gfx_partition mode);
-
-	int (*switch_gfx_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
 };
 
@@ -405,7 +401,6 @@ struct amdgpu_gfx {
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
 
-	enum amdgpu_gfx_partition	partition_mode;
 	uint16_t 			xcc_mask;
 	enum amdgpu_memory_partition	mem_partition_mode;
 	uint32_t			num_xcc_per_xcp;
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index a9de229a2828..bbcdececfd2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -307,8 +307,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		goto unlock;
 
 	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
-	if (adev->gfx.funcs->switch_gfx_partition_mode)
-		adev->gfx.funcs->switch_gfx_partition_mode(xcp_mgr->adev,
+	if (adev->gfx.funcs->switch_partition_mode)
+		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
 						       num_xcc_per_xcp);
 
 	if (adev->nbio.funcs->set_compute_partition_mode)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8ac63e00d025..eac6faf7e1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -38,6 +38,7 @@
 #include "gc/gc_9_4_3_sh_mask.h"
 
 #include "gfx_v9_4_3.h"
+#include "amdgpu_xcp.h"
 
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
@@ -619,61 +620,23 @@ gfx_v9_4_3_query_memory_partition(struct amdgpu_device *adev)
 	return mode;
 }
 
-static enum amdgpu_gfx_partition
-gfx_v9_4_3_query_compute_partition(struct amdgpu_device *adev)
-{
-	enum amdgpu_gfx_partition mode = adev->gfx.partition_mode;
-
-	if (adev->nbio.funcs->get_compute_partition_mode)
-		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
-
-	return mode;
-}
-
 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
-						enum amdgpu_gfx_partition mode)
+						int num_xccs_per_xcp)
 {
+	int i, num_xcc;
 	u32 tmp = 0;
-	int num_xcc_per_partition, i, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	switch (mode) {
-	case AMDGPU_SPX_PARTITION_MODE:
-		num_xcc_per_partition = num_xcc;
-		break;
-	case AMDGPU_DPX_PARTITION_MODE:
-		num_xcc_per_partition = num_xcc / 2;
-		break;
-	case AMDGPU_TPX_PARTITION_MODE:
-		num_xcc_per_partition = num_xcc / 3;
-		break;
-	case AMDGPU_QPX_PARTITION_MODE:
-		num_xcc_per_partition = num_xcc / 4;
-		break;
-	case AMDGPU_CPX_PARTITION_MODE:
-		num_xcc_per_partition = 1;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* TODO:
-	 * Stop user queues and threads, and make sure GPU is empty of work.
-	 */
 
 	for (i = 0; i < num_xcc; i++) {
 		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-				    num_xcc_per_partition);
+				    num_xccs_per_xcp);
 		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-				    i % num_xcc_per_partition);
+				    i % num_xccs_per_xcp);
 		WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL, tmp);
 	}
 
-	if (adev->nbio.funcs->set_compute_partition_mode)
-		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
-
-	adev->gfx.num_xcc_per_xcp = num_xcc_per_partition;
-	adev->gfx.partition_mode = mode;
+	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
 
 	return 0;
 }
@@ -685,8 +648,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .read_wave_sgprs = &gfx_v9_4_3_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_4_3_read_wave_vgprs,
         .select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
-        .query_partition_mode = &gfx_v9_4_3_query_compute_partition,
-        .switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
+	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.query_mem_partition_mode = &gfx_v9_4_3_query_memory_partition,
 };
 
@@ -1905,10 +1867,6 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 			return r;
 	}
 
-	if (adev->gfx.partition_mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
-		gfx_v9_4_3_switch_compute_partition(adev,
-						    amdgpu_user_partt_mode);
-
 	/* set the virtual and physical id based on partition_mode */
 	gfx_v9_4_3_xcc_program_xcc_id(adev, xcc_id);
 
@@ -1937,6 +1895,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 {
 	int r, i, num_xcc;
 
+	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr) == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+		amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, amdgpu_user_partt_mode);
+
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		r = gfx_v9_4_3_xcc_cp_resume(adev, i);
@@ -2152,8 +2113,6 @@ static int gfx_v9_4_3_early_init(void *handle)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	adev->gfx.partition_mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
-
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
 	gfx_v9_4_3_set_kiq_pm4_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 02a87650412d..6c30f0870cde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -34,6 +34,7 @@
 #include "kfd_smi_events.h"
 #include "kfd_migrate.h"
 #include "amdgpu.h"
+#include "amdgpu_xcp.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -584,7 +585,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	struct kfd_node *node;
 	uint32_t first_vmid_kfd, last_vmid_kfd, vmid_num_kfd;
 	unsigned int max_proc_per_quantum;
-	int num_xcd;
+	int num_xcd, partition_mode;
 
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
@@ -636,8 +637,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * If the VMID range changes for GFX9.4.3, then this code MUST be
 	 * revisited.
 	 */
+	partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr);
 	if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
-	    kfd->adev->gfx.partition_mode == AMDGPU_CPX_PARTITION_MODE &&
+	    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
 	    kfd->num_nodes != 1) {
 		vmid_num_kfd /= 2;
 		first_vmid_kfd = last_vmid_kfd + 1 - vmid_num_kfd*2;
@@ -753,7 +755,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		node->start_xcc_id = node->num_xcc_per_node * i;
 
 		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
-		    kfd->adev->gfx.partition_mode == AMDGPU_CPX_PARTITION_MODE &&
+		    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
 		    kfd->num_nodes != 1) {
 			/* For GFX9.4.3 and CPX mode, first XCD gets VMID range
 			 * 4-9 and second XCD gets VMID range 10-15.
-- 
2.39.2

