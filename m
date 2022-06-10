Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60473113FCD;
	Fri, 10 Jun 2022 20:53:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D46113FBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiX84XeAJ/4cAOet6gk4LayLshz6YqizXi9i397edDLZmYdTDLX4LJS9wjcKTLsC44Cw6ACEeBoF2TrfqirfEjwoUe78btYZPTvP/9Go79BJ8ZLngfMyscQ+elo4AJ8AE4peycNxuneWoI6RyKobQ8aFZFT/Pu6bBvBU7HR7UqC00QigdJRdnxNXIfR2vttekNbW0XxaMlKKvCbCZ9DDp0L6KkzR+NcjAwf6zteRdrmsvwBLZPg8ls2NQs+/wPaYHKum89ihLXvwJpRf9dfmP/6vEHomwdD//EPbwptrPOWpnYxqzV4CL9qpO3vfFusDB10hnof6njh+HDV8hkObCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wmsttm9PJtADV/hF7c63nL+wWWqk8bua/gW25gS0Kmc=;
 b=U0cBM/KNaNzFPllmHQSNh9Nni7rBG0X4OjDCJSCu2zWpnxciaApp87My52yMZwzn9uM2wkAtnC9BZdTnGpGJZIrahLi/rQj+d+Keh0sClt/QtMvtNJnuMkaGgivE3qSuk2oSpMRMCHW9asl4wq4rABrjizisaD7C5E4YieOgaAlzezALhYuxm+VO500hPzhlrWNZIx6dTKU/Q9aLWOVA+mmbFqYbSHv4F9fpV5Utjk0mx16/ok16c/x7EwDiz2UkHJKG6zNYqjo1c8LT+oiPL8XqNqF5Rj3tRNkjF27kdtMODsxCSqAnLu8cNGCThmliFDZpq400KHwJzJQcaY6PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmsttm9PJtADV/hF7c63nL+wWWqk8bua/gW25gS0Kmc=;
 b=ykUx3A0SRMblzYvOmexEbeySWXxYvY2MvvcAmFq8UkgGyghzqA9y342gy8qdT3igbD01do2JtRbCbZeFOvnHpTfmpqAXa3DpPNOOPYnq3DPK9EjRL3ZOFw4i9XZyTY6JTTpRPxb1wAllgX4NjcVT41sPZhLIq74jdiBE5tQ61XM=
Received: from MWHPR15CA0029.namprd15.prod.outlook.com (2603:10b6:300:ad::15)
 by MWHPR12MB1744.namprd12.prod.outlook.com (2603:10b6:300:111::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 20:53:14 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::63) by MWHPR15CA0029.outlook.office365.com
 (2603:10b6:300:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:14 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:12 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/23] drm/amd/display: dsc validate fail not pass to atomic
 check
Date: Fri, 10 Jun 2022 16:52:30 -0400
Message-ID: <20220610205245.174802-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4349627b-b87f-4e2c-9861-08da4b233d28
X-MS-TrafficTypeDiagnostic: MWHPR12MB1744:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17440FBD07C9573927C8B710F4A69@MWHPR12MB1744.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DoB/fdpA7Iyv/aLnguN9cabyR2+ZSinw8PLT/aRIBMIwnLpB4MSAq6+BbtvQZAPcDu1MmM0a1Cs9eeZM3x/aR5MXnV3Uqi5In5f2zW7iopUI+Xzdo60uHQg5f83eJBYzX7RkOd26J8pjLg9f1MXSFMQx9IkwgBSFfPpagYZrHs4U3wcV7aajEzUlYFHysyT9SikwB6o+lS11dHVhqkYnjPyRts1Iy5M+Mf/I7utLAYwEIzwXhBEnDi3sbFGsT3RqHaX/HG64rudXt9UuzxmY1JxsDUsc8Sug5CVzb1EcEz2IvMaIs+jq+F8nLvp75tiSyPgYaZu7u1X+lzbYZKy8S65CngOt7MtovGkMRBzAMnkx2gPDjBCGSjJbjczKd9gbUTc7vVN+3AIV9LLry+STFl/JuVgqN93qhE5irB9KK8JBMt3RPHFVY6HAw150rk60H8ohj+T7fCYuY0adiIQQj0+dO3oeAr9TcL6Lg2r2V29Pyi0OBoNJi78FuLGV2oP5+DWc70Cc/eD29BXHNp56tVKd/IB7ds8RpVixYX19QMEW4207O33cvslvhflakmySJt+LHZjUs0AOCtQcoSTg/z8ZJ7LpK26EtIjx5zdOyijtqUbF2I89GJdN4QhIDUrYmFJYpSbUv61xo3uoC1H9NdhOVs80sYic2ywQ9eVBOUhmvsWcMqFYpLSeNQFFnQyURgDT0agLKJ0B28IGbN29djsMnoc8idkp5RYcKXRR2RAlI05hxJrJ9XpnjCnEh4z2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(70206006)(336012)(83380400001)(1076003)(8936002)(70586007)(54906003)(6916009)(16526019)(426003)(508600001)(186003)(2616005)(7696005)(6666004)(44832011)(2906002)(26005)(82310400005)(47076005)(356005)(5660300002)(4326008)(40460700003)(36860700001)(8676002)(86362001)(316002)(81166007)(36756003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:14.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4349627b-b87f-4e2c-9861-08da4b233d28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1744
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, hamza.mahfooz@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why] when 4k@144hz dp connect to dp1.4 dsc mst hub, requested
bandwidth exceeds caps of dsc hub. but dsc bw valid functions,
increase_dsc_bpp, try_disable_dsc, pre_validate_dsc,
compute_mst_dsc_configs_for_state, do not return false to
atomic check. this cause user mode initiate mode set to kernel,
then cause kernel assert, system hang.

[How] dsc bandwidth valid functions return pass or fail to atomic
check.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 43 +++++++++++++------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  2 +-
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 06da4f2ed7ad..b048e40f23bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11209,7 +11209,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				}
 			}
 		}
-		pre_validate_dsc(state, &dm_state, vars);
+		if (!pre_validate_dsc(state, &dm_state, vars)) {
+			ret = -EINVAL;
+			goto fail;
+		}
 	}
 #endif
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
@@ -11455,6 +11458,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
 			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+			ret = -EINVAL;
 			goto fail;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 78df51b8693e..bdfe5a9a08dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -670,7 +670,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	return dsc_config.bits_per_pixel;
 }
 
-static void increase_dsc_bpp(struct drm_atomic_state *state,
+static bool increase_dsc_bpp(struct drm_atomic_state *state,
 			     struct dc_link *dc_link,
 			     struct dsc_mst_fairness_params *params,
 			     struct dsc_mst_fairness_vars *vars,
@@ -730,7 +730,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 							  params[next_index].port,
 							  vars[next_index].pbn,
 							  pbn_per_timeslot) < 0)
-				return;
+				return false;
 			if (!drm_dp_mst_atomic_check(state)) {
 				vars[next_index].bpp_x16 = bpp_x16_from_pbn(params[next_index], vars[next_index].pbn);
 			} else {
@@ -740,7 +740,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 								  params[next_index].port,
 								  vars[next_index].pbn,
 								  pbn_per_timeslot) < 0)
-					return;
+					return false;
 			}
 		} else {
 			vars[next_index].pbn += initial_slack[next_index];
@@ -749,7 +749,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 							  params[next_index].port,
 							  vars[next_index].pbn,
 							  pbn_per_timeslot) < 0)
-				return;
+				return false;
 			if (!drm_dp_mst_atomic_check(state)) {
 				vars[next_index].bpp_x16 = params[next_index].bw_range.max_target_bpp_x16;
 			} else {
@@ -759,16 +759,17 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 								  params[next_index].port,
 								  vars[next_index].pbn,
 								  pbn_per_timeslot) < 0)
-					return;
+					return false;
 			}
 		}
 
 		bpp_increased[next_index] = true;
 		remaining_to_increase--;
 	}
+	return true;
 }
 
-static void try_disable_dsc(struct drm_atomic_state *state,
+static bool try_disable_dsc(struct drm_atomic_state *state,
 			    struct dc_link *dc_link,
 			    struct dsc_mst_fairness_params *params,
 			    struct dsc_mst_fairness_vars *vars,
@@ -816,7 +817,7 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 						  params[next_index].port,
 						  vars[next_index].pbn,
 						  dm_mst_get_pbn_divider(dc_link)) < 0)
-			return;
+			return false;
 
 		if (!drm_dp_mst_atomic_check(state)) {
 			vars[next_index].dsc_enabled = false;
@@ -828,12 +829,13 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 							  params[next_index].port,
 							  vars[next_index].pbn,
 							  dm_mst_get_pbn_divider(dc_link)) < 0)
-				return;
+				return false;
 		}
 
 		tried[next_index] = true;
 		remaining_to_try--;
 	}
+	return true;
 }
 
 static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
@@ -949,9 +951,11 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return false;
 
 	/* Optimize degree of compression */
-	increase_dsc_bpp(state, dc_link, params, vars, count, k);
+	if (!increase_dsc_bpp(state, dc_link, params, vars, count, k))
+		return false;
 
-	try_disable_dsc(state, dc_link, params, vars, count, k);
+	if (!try_disable_dsc(state, dc_link, params, vars, count, k))
+		return false;
 
 	set_dsc_configs_from_fairness_vars(params, vars, count, k);
 
@@ -1223,21 +1227,22 @@ static bool is_dsc_precompute_needed(struct drm_atomic_state *state)
 	return ret;
 }
 
-void pre_validate_dsc(struct drm_atomic_state *state,
+bool pre_validate_dsc(struct drm_atomic_state *state,
 		      struct dm_atomic_state **dm_state_ptr,
 		      struct dsc_mst_fairness_vars *vars)
 {
 	int i;
 	struct dm_atomic_state *dm_state;
 	struct dc_state *local_dc_state = NULL;
+	int ret = 0;
 
 	if (!is_dsc_precompute_needed(state)) {
 		DRM_INFO_ONCE("DSC precompute is not needed.\n");
-		return;
+		return true;
 	}
 	if (dm_atomic_get_state(state, dm_state_ptr)) {
 		DRM_INFO_ONCE("dm_atomic_get_state() failed\n");
-		return;
+		return false;
 	}
 	dm_state = *dm_state_ptr;
 
@@ -1249,7 +1254,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
 
 	local_dc_state = kmemdup(dm_state->context, sizeof(struct dc_state), GFP_KERNEL);
 	if (!local_dc_state)
-		return;
+		return false;
 
 	for (i = 0; i < local_dc_state->stream_count; i++) {
 		struct dc_stream_state *stream = dm_state->context->streams[i];
@@ -1275,11 +1280,19 @@ void pre_validate_dsc(struct drm_atomic_state *state,
 								&state->crtcs[ind].new_state->mode,
 								dm_new_conn_state,
 								dm_old_crtc_state->stream);
+			if (local_dc_state->streams[i] == NULL) {
+				ret = -EINVAL;
+				break;
+			}
 		}
 	}
 
+	if (ret != 0)
+		goto clean_exit;
+
 	if (!pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars)) {
 		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
+		ret = -EINVAL;
 		goto clean_exit;
 	}
 
@@ -1309,5 +1322,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
 	}
 
 	kfree(local_dc_state);
+
+	return (ret == 0);
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 85628ad59e6c..2e13027d9b88 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -59,7 +59,7 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 bool needs_dsc_aux_workaround(struct dc_link *link);
 
-void pre_validate_dsc(struct drm_atomic_state *state,
+bool pre_validate_dsc(struct drm_atomic_state *state,
 		      struct dm_atomic_state **dm_state_ptr,
 		      struct dsc_mst_fairness_vars *vars);
 
-- 
2.36.1

