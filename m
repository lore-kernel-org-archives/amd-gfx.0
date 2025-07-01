Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFD1C83F09
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DDC10E62C;
	Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjVG+MhT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5F710E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHgBwZj462X94CZwDzO28yxNADgUuD0dizNdHjxXQC+3CD2vMdqIFbjvUzKg/0puqUlBPn0/C7D5DAek6Huy7cT3viz062d2zzffRbdflxEGwwrjUNqFvuxS626PQZOHPGcW3a27O9Bw5DSm3wjmURdJcC9UxJiZRsruI6ZGVa4BLP+xyoaQh2KfCoa+5KLUZuX403cc2tWRP5x2bEWOigIL1usWwAPn2pmzWcgXYFzRF/AIwq7qX2uupLBiWPNcXsf8jrdQIodFqYQ0EWWfglLn9zG/kTjZ8eqMmv3X0Ye+5OHCzedU0ykXHVvIPojB0X/6vc/cvupRkxJfHzqtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AsPlGovU2seiUeHIviEap44EdQp40oMVXT0tNjVoXM=;
 b=vC5iXNNRz2fj+qLCTT0v6h5bAkIuvkG2PaxtVaPVVj2BSFmfVnAYB0wrGgHRbVv1v9sAmsnRex9a/+l7eODQOV3CgGPYO2DQO8Tp+6Euph6B0FjLm9xT3S7wi2TiPX2qQzgpde9kGUJQxrDFqgJjntYQSmdDJRUUNrjxN7JxMWTKc6rAow+UnbfQ5IATUkiyDHybZOqxecbD4EFxvhQb06yvzSkndvj5fRCOOEFSsapRFYh5QMU9OF54TXd7gAKYYgPz5z4uABaCWJxjt8tEjW9h6U67o5J/kCVcChmxMcqa0KEdMAG8hTej39N69KQgWkEp2rhY37rqz+FHsZKLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsPlGovU2seiUeHIviEap44EdQp40oMVXT0tNjVoXM=;
 b=jjVG+MhTKPrQtd61Ww1mT82GDrsw5e7tOQ7DGNgTVjJQi3KUc4yWk1jpge1fY+AfiqvBJMk6UJTsnsdU+b584ukGb2423pEIofaL/CuTcsTjp/HADJTscCbFtjlCzOS9wgQQLkywsz2LO/lfAoZjIjqmnwhqUK4/3EtEr7UpOlU=
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 18:45:23 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::7f) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 18:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 28/28] drm/amdgpu/vcn3: implement ring reset
Date: Tue, 1 Jul 2025 14:44:51 -0400
Message-ID: <20250701184451.11868-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 920676cb-6f28-47df-e00c-08ddb8cf6fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Ea0dGw1T/RIxazhyxmtJdFfpUL2Ykns4vHzGpMifWYICMDCTbjgAbg68VJ8?=
 =?us-ascii?Q?59kjmxvRtuIVVfUsmyGjTMAfM0rPVnAzj/WoOC6cYHtP5V5Lo4OEafF1XCT5?=
 =?us-ascii?Q?tQCX0m8B8yDgSCwVdD0Tkntp+fsLNJMYBvgrIWBnoZMyLqfWpSCrvyeFkMxg?=
 =?us-ascii?Q?RF+nBSvLNcHCXtIegFdXxvwey+jObovdVSVtI//5FmliSwBGBUEadI50ty2d?=
 =?us-ascii?Q?1BMum8r7iLdGYv2N/9bfHcrsu2oDpCwiaP4RvBR+1pOX6CFV2hYybnrTJzn7?=
 =?us-ascii?Q?kxIgJevd+2rvkaMg4H9l6mf/C3kGi61HcnbAtVY9jJXRjUwcFvfCf8Ro/DGT?=
 =?us-ascii?Q?i3xKn5UGKQ+StYO9kKt06EA1Jasoa6P7+zErAgbn/y3RE69JKLmz1jo9VkrX?=
 =?us-ascii?Q?xIHiJdEf6YAH7Bz6N6tJ1XxXjHWq5PavGIcjhyrlhQLGet0rf35uopgvm3qO?=
 =?us-ascii?Q?3rY9yCgr1RpiKRIQQff+4+jDOQph0r1JMu2Z2/itOqyA0Cs34L0TGGvb0yHg?=
 =?us-ascii?Q?4KSjFcs261HZau6AnFcpx1sHDNGSzxcpT1RjskP3iedFi2BV/0rU7bXh243j?=
 =?us-ascii?Q?TwkptTzo6OWR8byeKd+Y018eIuZcjftzCPw9xyp8n3QyESz9MLGS1SPpsz9N?=
 =?us-ascii?Q?PgbNIEvk7bxHWg3DTpuQCoSoAKk+PekNIQ9v2btSsIxq99v2JaHEr4CDPum9?=
 =?us-ascii?Q?55lDhxpkHrf6Iv4rP9enuYGJ7smLx+Fe7TDJyiVPJsTC/Yr42E0Nxycq+BTg?=
 =?us-ascii?Q?kMpVxEY+gooLGkZRZeo9CRKxXp8V+JgpBfuLhSWcfM4hAjpgVj22n5PwGNul?=
 =?us-ascii?Q?yfW335bYusEKOH64HrrOIV4Gxb4vcDIZsuHxIlKsCJf+iw8cMwgTpgD4EL+K?=
 =?us-ascii?Q?KbbL1aFEvqIbE+r8EkWtxh119hHE9p/4KT+JnaYqMjVS8WrytmpNBswfsZqP?=
 =?us-ascii?Q?AfxHi/bsXmpBoCH+sFXNQ3sbxeY5u/MTQi74xYRzXfD1GFdewM6ukpJdEaWZ?=
 =?us-ascii?Q?Ldsl/oQc0RsmmR2dnR44L6HIXwOod1eGZRCwuMeTWluXb0Azdr7K4p1/hHGm?=
 =?us-ascii?Q?5Qmqx5W4o+j1lUD5818c8IR9oP8naQUrKJAOTvdDjY1AZ/CPhuXm0IQhqDGO?=
 =?us-ascii?Q?rlNMHyE6C98B5cdEHZZMfZV5vEt4sVYqCzPq/gw2dyQpQ8YhRO6aLO2oFuT4?=
 =?us-ascii?Q?9Ev+hkM4mr1PUymqXrkyAfgLL7RLAFkU4KPgNcD7byOnCw4TjqPachqN8zqw?=
 =?us-ascii?Q?0H6lBUwjKjuFmCgWPFoxpIRhJuXzIDd+0XRGQjH2pKjQIdpa6SS6HKRrRtiz?=
 =?us-ascii?Q?aN33GmncI+U8WpElFvcQxUkKk7gJytBLxETYsft5KW0u0VuV1Pta7I8ZuZeJ?=
 =?us-ascii?Q?/3x5ZKE8LyQ6oGoKVhCDIcQa9Af8RgqqKlUtdha/bXy1We7cj3d0dXP825Ot?=
 =?us-ascii?Q?4O+EKSmh9mMABUHbELSHqM8npy1u6tHgj10tgcXuxvdqjfuYNQIygQXkXlzS?=
 =?us-ascii?Q?bhGy8YMA1cpPqCe7FuzE2LBI7ZBZl5TrK4mA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:22.8997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920676cb-6f28-47df-e00c-08ddb8cf6fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..dd015bc6fd0ee 100644
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
@@ -2033,6 +2035,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2131,6 +2134,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -2164,6 +2168,15 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v3_0_stop(vinst);
+	vcn_v3_0_enable_clock_gating(vinst);
+	vcn_v3_0_enable_static_power_gating(vinst);
+	vcn_v3_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

