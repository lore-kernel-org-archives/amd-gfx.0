Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ED9C83029
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FBF10E952;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H3j2xYPQ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B02D10E947
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xyuv+mD7irBgIUC1ND0a93gXcA46xRn+aIG++/SCVi2cWQqgjLAgv0tim2NRNmo9m020PDAvVut40u5w0oHrqecJDejo7Ehr0ceOiYvHC9H2JsDRBUK39ece+uvxWYcjqW/whE0nCw4/y/JrIB4aJr68EGUdLwT5a7OVhlN7zG/JTPyiH1lPdTKZlL/d/cY7032WB8Ba71tkeQoaQXcGTfYXWoHPqMp6SV7jPXBe0bgtYrXc6rmELXkNolsy6bMPZrViaOmK17HwEF1tezR+pjcQdFdQVDtq93IERVDN9AkJy9+CVAbhc3QtRBjuDCLJX2RStqgTHJErPFrUvAzUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdQwpZrLhMHE6OtkZTzdpCAaCuEIvTE05jEmifUF+oY=;
 b=H/yMmFh4DgoRJa9P++gPL/lk7y8/YtziQ/qTMjydMHmRTpnYPt4KTlx9K7o1YSvcYdbGe6tfRDo8VuLW6l6NSzWjWXIIBC7dR395/4QQBfSo80Wufg3XO3bZgy/fAGV3Oyn3t+w/0yD0qKPlA8qLqD/fUwfzv3sc4T8MoHQsPmfJ0CiJpNn6s0nF6a2kR09ruWXJZevW4I27fQ5rsY6G1rSO2bZ/+Q12ODFYtffCwdhSZaIuOJM5TZQJPQqWlfw4i+AUBedVegPnD8LHyeef8696JX8IwnLOnfaPyLrzFHGRpxfpZ+rg6XXwOWYEP3TIB3ts3498TZIJDI9dQw/zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdQwpZrLhMHE6OtkZTzdpCAaCuEIvTE05jEmifUF+oY=;
 b=H3j2xYPQAN84eo3HLwmc8IfGnEpdRFLMsbhToR0DtLnT+yADQcaKB289UYf1uNmkXawZVZ4Nv17id2Cy/XbMzqU3riGcAtRGSNUuFNN8dBUsHckjvZZOrFOKyh2DS+3LO9kTEvmDDMNU7nx9a/jTGIx3Zi19iYbeg3Fqc6OmBe0=
Received: from BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 27 Jun
 2025 03:40:31 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::ef) by BL1PR13CA0198.outlook.office365.com
 (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.11 via Frontend Transport; Fri,
 27 Jun 2025 03:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/33] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:41 -0400
Message-ID: <20250627034002.5590-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a1c8a8-d2f5-4b57-f8cd-08ddb52c5d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uavCs7zBbVwF6DgV5qwVL3hHpbXBSvVMPOr4mCTXOztToENUP3DUhhgnQ4XH?=
 =?us-ascii?Q?pfNmmPTjdAYkVJeIEad85BK7jpk1SeZaDhygjl57RL1KQ1YEf29JQTbk1CCg?=
 =?us-ascii?Q?/6q2wa94GLvMG5den8TI43n0WWUrAow+VR6uJWn7ka/ry+XEGv8wWQSUKc3L?=
 =?us-ascii?Q?PNvLw+y9qzqV3nr5x7OBdtlwFuAt+92RGep1rnHa5d+2JkeXacb+LNtToGFK?=
 =?us-ascii?Q?U2DcnZf6QjJDGozJ3ncGcaP7tdjIzt9/xfqWYC95hFsJWGJ9pBjuYs2fyDAX?=
 =?us-ascii?Q?+m11QTmnoq3lE93ie3TcY7XujvqnagUpnnem/jgFUITpWDaR12U6poJDLoqm?=
 =?us-ascii?Q?Kiq4sD46oDZ++Xg6pzoiI5W5+5j1pQybHJIqgfymWeG7GklA+hIdvZBqDIs8?=
 =?us-ascii?Q?saVcTsuiDKKnPwHNO7iBNDI6G7yR27XZ4qrW0Wyn8mT/KMdSENEDra1Y5eG3?=
 =?us-ascii?Q?om3/44SMjKWlRQtpJnPc8qfM1ONphH2SE77yMOOXgwHl2SAipZhMr5BmMOLd?=
 =?us-ascii?Q?/5q7GPlNlHg15QIZvniiW7zAEmgtuj4m+doTKxSfTYWyWvXsIl4brJKqMCnT?=
 =?us-ascii?Q?U7yQTjbXzcpA5nZb9ug3+JxPWsw2rIVkiB+ShONkiWPhNIlkn2wKmXwZtDA/?=
 =?us-ascii?Q?7+qbe41TxSe+QbaGVJ2NNQ4bIP2TjEGUvT1f5frvK2t9OQBQ9ppBGzCbC+31?=
 =?us-ascii?Q?rWbKH8D00XBMCJXvZBdjTJgO3dTSeNv0P+33ut5wjH0J6gbEmt+RdCn+gxJN?=
 =?us-ascii?Q?l7iEAspaWCGuDCsaUM+1dnGUFSzFQax2tltkNY9fIp5TWnRjkt8zeWpCnRvp?=
 =?us-ascii?Q?1aXPHALSYrLH7PvxpuMNse4e8K2LdOsbI7/zoFt5lsQnnsxw4SSdJNsxfstk?=
 =?us-ascii?Q?w3J2A/oKw2xC23omyX112EBuMyYI3y7QiSqjesmznR9GextyUlhI4Rm9ZtfU?=
 =?us-ascii?Q?K5lFtwB7qOSg6TKHerI/iTpHjfDY/7kj94KVVmoC1tBtbBioi1VnYa1Eqsqy?=
 =?us-ascii?Q?gEZRsAA+TpMq2ncdBKxBlgWpjMwTGcHjW7m4oOgmfU3/zXa6BCoXzNhgWs1F?=
 =?us-ascii?Q?nrvGGgwIBNmkDhh1sgEz/VfJiTycnJ16bDcbC6N0U103K+XR38Z6OdwEwMuy?=
 =?us-ascii?Q?nES2cifFthi+tW+L81daCccbG5QohNDR0h6l252neTNleUtjvzzFuiP3ALYO?=
 =?us-ascii?Q?SyjgDva0mNb8+ZAHjEsBEQsJBjyAlWRskz+sd0ZWXm05LrsoDw0BvbCCCBzK?=
 =?us-ascii?Q?BJM9CMaFIY5P5HfDHqpktC4hmixfzEfNXo//X024cTXGWvRKNzH/0t9UoI6n?=
 =?us-ascii?Q?i4yweVbfozsyf4LxZQZ4tQgNdi5WNh9vszR4IAm10bd/LD+1SPC1FzZ8OAKM?=
 =?us-ascii?Q?xxFw3ViWqip/+O3ZytqJgSc8dHeSKcQFPdpOpUIJvrKshWDXe6jw9m71d9l8?=
 =?us-ascii?Q?RjmHBrh5gzxjynmzzI/hy8CWafqqffcQ+q3z6Q1x4qmPbyYJMXttIvSHl4an?=
 =?us-ascii?Q?VCozoaMI7x+7uWN9jOL2mE3KFbUlkPOeavnG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:30.8421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a1c8a8-d2f5-4b57-f8cd-08ddb52c5d87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37dcec2d07841..04b2e3def5098 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6283,21 +6283,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -6821,7 +6806,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -6844,12 +6829,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6992,7 +6972,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -7013,12 +6993,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7254,7 +7229,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7296,7 +7270,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.50.0

