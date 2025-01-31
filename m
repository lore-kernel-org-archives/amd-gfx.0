Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C0AC02197
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1D410E408;
	Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqyvV+8X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3235010E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDk2lwRfP/i8tK3ERMFm5W3gSWtYljGt+dZcTRrBiOzno0saY1jEyTQ4E14QKuUT4jNpEjEzo+OqI/MUWpEmJgl0lp4Ue/PKUHGuimWEu94YgrJKYoTyKwkc77Q3NzvO39GKXWQC5Tqedm6SgoX4jx/KgMLMyAcAw59AuHPKysaYocnI8OHt42io+WPuwpC4iMMbHH7/4Em5iMk22g8nVaLc42qOXOCp/a8QgfbYu/uS+qehqTfmP0SoZjwxVeuKp0r+OBmSuNaUyY4v9INIqj6h25aj1axk61QLG5AOwEnWB8WVxi4w1H5mF88WC8u0HUYRQzlK94RYJRBe3Zl6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M67Ti/ncHkr5Ervy8iDhlMLMFRisvQIfU/NPBD1C8OY=;
 b=gEH0MYbkFIuGeXT4nojIPvoDicG4thpQPMrmQZCXvC7wNf2RRCAORSFjPBRvm0dXAbXRXg/bvvm6D4G4aRGVxho3ZXhPz09E+o8Mhipq6OP7o0+sEHZprY/UzcRx+cqjfxvumV267V3jbqIqxxbjX2gOQZ78QW+hDbcWQLr0iErYqtg0qhRZTFL8iO9lmuCAMVKGiPIn+3y1/XoNmGJ15aYKTMwjH82L6JQufvQni1QgbNd2yc23FrBCjCRMyPXhMTHTyGSRm8ieYjY8r4JcHn/nGmM1WQkzFvZKI/34UYQGmhutpOsDkpMxzyVa7eIKrnNHQf8tdD9hNt3Rcm0rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M67Ti/ncHkr5Ervy8iDhlMLMFRisvQIfU/NPBD1C8OY=;
 b=BqyvV+8X/4yM/91Qx4W8wOWlRSkgEKC6tS4jQ50jnl6yOLj/hV96dAtz5+UrtZvus3Hnr4nq2rYHfQokx80jnoAEvQHEdXgL7nKRFSThAx3R3gk/b7zOXEb+n38ng7Xmn+GuDbnOwpQXrZTjhZm3JXBxtTCL1CYbY3/1wqKCNyA=
Received: from CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::24)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:58:20 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::86) by CH5P220CA0012.outlook.office365.com
 (2603:10b6:610:1ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/44] drm/amdgpu/vcn4.0.5: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:25 -0500
Message-ID: <20250131165741.1798488-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: defbc636-c461-4bda-f5d8-08dd421876b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ggUiPW8f6sn0mE1e7ZA9FUwVZ999QOih80VvuFWRy8ARk620zsmhcSBeX50B?=
 =?us-ascii?Q?ZmxIlcB+p1TPA4Mhu3fGxKPACa9umWWvaHtwCxR5kwhgZ0fMbgJUu7ZYL98+?=
 =?us-ascii?Q?GYNrq9qIjEvGp8WcUyw0Bdrv0AxQbOfvi0f/LyXHxVTT6Gfm4cI5xcjRVpyM?=
 =?us-ascii?Q?z9ttfJnkvHPZxxWvpdIejGpPKKb7R+be0jsMIsKD6ZDBxodswXCmrE3dvRFW?=
 =?us-ascii?Q?uMnxC1JW5BQ6ja4xzIC/4BRqvo6sre8Oe+DdOFQgtovUa5tvt2LkSOe6DjCO?=
 =?us-ascii?Q?sK+EZI3nnkoola6PyKtvVqwVumu730A+e1m2ARWUHUvNxxuUyDV83zrNFFV1?=
 =?us-ascii?Q?Y0LUFzNfrQTpFdNQstac8edIUYB19PHQsQFBneLq2maAkXQEC7qSRjLsmXuO?=
 =?us-ascii?Q?nUJQ7F9K4fzYi5ujP2ZF4YTmc4CQ3K7pwY/1fA3dXHz/L/wdh2lfRzQRAWJl?=
 =?us-ascii?Q?ZrjFNQxdqWoI1Ag9wO0ch1yhj/WYW0wrknVaIJQCOqQ4agmQmiKSnZ9QRBEK?=
 =?us-ascii?Q?Ai7eHBTN1KG2Kz6pJmYNevYtHvOHfa2ycOdaHjltp/mJXpa2iTb9x12OEoSP?=
 =?us-ascii?Q?fqrZfsldQBv7xdWSjNcS0ed4gMAyLl+4gSDaT3TOBcPiuNiSMmG8ZNe8zzHr?=
 =?us-ascii?Q?rBPVfzn0lw36+3WXXKJtW5ChSBbeSJg4cL9Lwk8ZBm1DHLIhjBHvBWrGUUS2?=
 =?us-ascii?Q?dmFef1sBmTbgYTkiu+xM3gaAGQBMzJiARQ5wrTy2hzROyGQKcD6Nffxs/jai?=
 =?us-ascii?Q?yGcxy8+1jf4NXnnd6QHwtqYqpOR0pk0Z6K1UeRl9m3KslfKetBu5e7ZNBLSJ?=
 =?us-ascii?Q?ZOVMPHfI7+wG4XszaImFh4GUDtPsR8X2btaSHmdYHZj4+YtQ01F96eA8BWGm?=
 =?us-ascii?Q?D2ATZJuboFFB7IiPNjhosFFPlDCdI46EXDI+0Q6Fv5fE//v46onRz7pEIoLj?=
 =?us-ascii?Q?mgGgRhywgbrfOyfgAlDdTc/KiGsOG2xIAkIUOOjFymnGmx9k4ln3Wwhsc7kb?=
 =?us-ascii?Q?jaK71V8M/Xo6ZGBdPLECkfQv6MhB1BPr6cR6cg74RJJL+T6pqDlp/c7+Bxul?=
 =?us-ascii?Q?iuY3L4r1uTa5h2CAjw+B0FFNX8jl2eKqHPnodFIoszyiqqSMdUIAKS+qcnUB?=
 =?us-ascii?Q?92a30itP+i5bU6UAAbewmG8muw10ad8NHY2UQ1JKLf3lOHMJaJVaaNyBh31F?=
 =?us-ascii?Q?szL9j2liHTdFlCP7XnhqIBNhhCU1Z0klQMAD7/SvQXvvdi84Zmh74QGmT6AS?=
 =?us-ascii?Q?Lk7UO513TllsZySJCw4rHIqSvkGQgIbc33f4TTRncFH9n0ASUn2AqsmeMwpw?=
 =?us-ascii?Q?mxY7DfJPbVHFnCV50WNYr7ajic6s4Vv8EojX4BmlKq68yyAER7brFvt2R6fx?=
 =?us-ascii?Q?APrVtL2F1tHcb4NeMEBSVrWhDjDRc06yhDi7nykmH89RZfb8A7xG2uVHFB1G?=
 =?us-ascii?Q?U4YVbRl7R/h1OMD47gG8iBy18KbxvC3HfENwuwaaTog97xi+pC6Uqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:19.4087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: defbc636-c461-4bda-f5d8-08dd421876b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a00c74d287a69..0ac41249755db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,9 +95,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -124,6 +123,8 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_5_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v4_0_5_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -317,16 +318,18 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		cancel_delayed_work_sync(&vinst->idle_work);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			    (vinst->cur_state != AMD_PG_STATE_GATE &&
 			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1558,15 +1561,12 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1575,7 +1575,7 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v4_0_5_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1594,8 +1594,11 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

