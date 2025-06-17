Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B71C7115D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6D610E49F;
	Tue, 17 Jun 2025 03:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTRCqD5M";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F019110E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utrl+wOGopKwnq861DBxd/sZnFrMHpeknMBguPZ9Cu2eSj/3j+xfjpLgMT/I0c3DPaC/lVqoSxrDwLTyTslBshnm7Eyg1fNCazU4GfSLVHjHaaqqGpPMOFuW8ZjomWW71Jn48hthyckVIW2vSMf2ASklEUZkTPLagFAm+PpQUTxR74mYx6iLX+km43qhPQCE/raCZkHW5R+UkkCDptVxz41nSRFWu0U5ptcbkWoLTFrTdEtK9v52wJ9L75DHBg3xJJBN/br9IcThjmGk6gesuGAeknAfIaSFjzeRftj4uDP8FPLPTvFvPTYJ1MjKfVSn/xrCbBtSClzyNn4pp5daQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJdkBVXhlG5VrKVrCwwWJFyFyR80Wbby+HkE6apEjSo=;
 b=hm3EyOrPUX0lASV0OT/Zzge3GzWzmAezQ62elR0Vyrc53bZHeMsS/1DOlP/ntKcaj3PdQnsLrnGMfrZTZr44SUCPHA+JYdLTLdKqceLsQLEPGTJIrBVz63Y7upZkd6UCRQKzFElfBqOeoePHwVdlkSvbAv9B1JQkFW1c4a3/sm6z8EO80DYfal/UT2k+c09lDNdp8QorFT03+9EQM3k87r2k/qPCYJ8MmrHzlnwQj0LH/OZv5wQmcx2wJd4billWNHA9u9758oB6Czmf53zybgERXKB7Zp09U8FRuM3nCb4udB0zzfJiiVkgvFa8wI0635awvkYVVak40dZXdNaA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJdkBVXhlG5VrKVrCwwWJFyFyR80Wbby+HkE6apEjSo=;
 b=RTRCqD5MgzDYe2HJabkEBb94QrceY2VF+PMY0C8INBkasK9sgT1Yp55R0k1eRAjnb8viqb9QmgYlGEp3tsGM3RdFcjBpl7hN3z9Z7QVTUfP2vN0A77tb/egbdsq1Cs30vYEcC92r7PKmrskfdXTLHvIffLf9f+I1DHUbqj9Nmgc=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:56 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::41) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Tue,
 17 Jun 2025 03:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/36] drm/amdgpu/vcn3: implement ring reset
Date: Mon, 16 Jun 2025 23:08:15 -0400
Message-ID: <20250617030815.5785-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e658b0-b8c8-4e4d-d6fe-08ddad4c4c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jE+c3vNYyMrRL0Sp3nVbyiTNkgmPMiZ0Hp/7ojsj4dfKTfrODwL7o12ljI0H?=
 =?us-ascii?Q?ia3UAqAwvd+/mAaHSWXBaAUeE9+9mBRlcjS2fWvhfTmeJxfD6B9u/PtYI1Cy?=
 =?us-ascii?Q?4oReumdllbiKjlbGwNvXo3mL7ue3WbEWcxYEuge06bgYN3k66dnLM16WXfm1?=
 =?us-ascii?Q?D2ybLEpJJoTeYT0R+dvwTRN/Pd0hv3eaU6bNPpq226aQfRflsbu1ni5UW5yl?=
 =?us-ascii?Q?zY6ty0dMm9qaus9zPUt/OcAitQOHQWsrt72vY3P9G1D/f97BbDAAaAYoKIr+?=
 =?us-ascii?Q?0p0CxQvD1xkIRpR/Gv7/8W5gSMj4DkNAOBXnYDfBOYRQ7PuxFsDn6MjwG1Sz?=
 =?us-ascii?Q?dYRvufBo8Zqr4PXLedqqdLPmeFFN9pD1EQjFrGy8dARjDou5VyFcYvkCkLom?=
 =?us-ascii?Q?+WYUrBipQfnEQmq4R0pskwTXUS15x/G8ExL/PU6Ctmgd+Six5vLvxIWRgA91?=
 =?us-ascii?Q?CwYIOC+z1wcTRNJLuNlZZGp8UFHXVN/VKhI1GHZ8dY6MqM9ULUtfoc6TWAs7?=
 =?us-ascii?Q?IHqihP3vjr/oJLL11bYsPVLLu4vG8d4/WbTHCuJ9z8aGFM6tIpR0m76cy9yc?=
 =?us-ascii?Q?wQi/XAwJcAsMFp+i3RRbiL1AihLLs3ZW32hielKpaVnVhDJrApnfjk+f5ray?=
 =?us-ascii?Q?JnuqxjeYyy3efNk+t50c52oh8rjH9shL1faCsO8IVcvTGHaouMV3bNeiO2nz?=
 =?us-ascii?Q?2/PHmOJsxlyZ7xpMjd3abRwISTLKdUf2Bxk1qevqerXGy8ZyXQkURAJPijdW?=
 =?us-ascii?Q?vREY1U+GQDOP5RX3rM/FjcIjJJPKUZqxuRIei0kD1F1pN3/o33DNQvlrB/kh?=
 =?us-ascii?Q?cI3z9SK17+G6RAGQt56Nq6lMAOMYk5RQyKafPFqkNKPPGtUi4bnqZkeiThFO?=
 =?us-ascii?Q?NkgiwFuwReeagPdV9aysFsIv+PEMVjx1MTJ8juZwNx2D+H6anlMCzoopLhls?=
 =?us-ascii?Q?9Ca7AvSqSaBR20A7kn4/dgzg38BDGwUSc1hK9ev63NKV0asvPbrdXX9BxRj8?=
 =?us-ascii?Q?0/cT3tXSCOKuAPHh39Sd3m+B7cBWpkGxxI7dixn71EMTZvxUDH3WOI4Y8XfM?=
 =?us-ascii?Q?WIsa6CsmIDu1Lyr3wi5MQXinjvIx5Xhq3ktxxENKVwVgCT71t0kjkDy4Hmi4?=
 =?us-ascii?Q?z2atj8JgpTe369s2MF+MVJLStZhuuPkp/vfTz8hsjJhDsI0ZAJ6ZJ2xVOnmy?=
 =?us-ascii?Q?T8/zvqxJFSMcpa2r7kKkzdVriEGQnNZwntJGogjtJBLjwo83DbRLxc3TiqtC?=
 =?us-ascii?Q?BeE3sPqD1S0nmXAj06xSEi3i34ecq6FlS0uilgX5CVVicgPB+rL2XeIYPDuX?=
 =?us-ascii?Q?qDX8sbjq47XEh2F1RkfiXusujhaT0Qc2vcZjU0VlXbTyy5+iNvXzq3T2xhwE?=
 =?us-ascii?Q?+wySdfq/vbCu2HvSFmgJeOEPIwlIuvkPIHrBUIO5ic214MK0wQ8hDdDvKlG0?=
 =?us-ascii?Q?Ctlgwnaa+cCF/sQTd7LpEEyFxb6eLSzbTPkYdqAA76MIs4xzZyCa2A5YqOXe?=
 =?us-ascii?Q?PwNNjwCZLofaHU9iR2v+tFy62VXVk0M3prKQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:56.1269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e658b0-b8c8-4e4d-d6fe-08ddad4c4c1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

Use the new helpers to handle engine resets for VCN.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..ec4d2ab75fc4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+		adev->vcn.inst[i].reset = vcn_v3_0_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -1869,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
 	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
@@ -2033,6 +2036,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2164,6 +2168,26 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int i, r;
+
+	vcn_v3_0_stop(vinst);
+	vcn_v3_0_start(vinst);
+	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+	if (r)
+		return r;
+	for (i = 0; i < vinst->num_enc_rings; i++) {
+		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		if (r)
+			return r;
+	}
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+	return 0;
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.49.0

