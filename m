Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B70C61DB8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CF510E578;
	Wed, 28 May 2025 04:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qleiMD3k";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E28010E543
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2IufjpC4YwDRkCCCqgx+kixw0uQ5JmjLw6jsDvSChxBvvoPZ2mzfBbFL7Dw4534e4JUsZcpTq50eSWsg03EE0xI1c4meOrzxA52z8ppZncUmF93ukPRy4zlavejeHoi5x/7BLm2DaNQP3a1AbDv8b72PJaeWxjIIB6xk2e5/pcEAmsHubNOF+Ox3xQYbfS5QWjARvTpFxjU/t++1FSdrGp4fT8UOtiZizG2QMH4bymD79QkijMuyMYUFaSZBgN/sbIF4TAiB8UqJsU5JHXNOV6dsHqdIsF7n5NzGzjFbMZtxUls71clSMhqr2IBOKhV5Ntb17g9bKdnx9OG6RtzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4zbxKtCmnWocPyyBH02vFDJKqBP7tyeHzXzMKW+O1U=;
 b=xyBvRlswZOPkbsVbhBRZZsfncNFPA3zD9w4NYCmZvSRkObF+mLPO3821i3OGygJenYQkisc0zOOWkdXL3MUbHiIhKkG2nnQ1JDGPvsWYpzyBccc7mQUjDRWIIVXhvdSX84lsT5s2WBxnW/f4d4e/TqLrbWR7kSvCusoukv6s8uGIBSBZNuLp1C6CQyHK9mrznrc9/SuPxQ75uXUEXxKySgjdG959lD0NdVVbEnLGOQcqPbUDwUWN1yGPrNVX7zKrwDEftfN2kZxkzLEH521NHwi1pyFqUFDbdDnAjs397SQEAsNsPyWv/sZny2TtPvQXveApYa5ZCT+LXBiJdcS1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4zbxKtCmnWocPyyBH02vFDJKqBP7tyeHzXzMKW+O1U=;
 b=qleiMD3kGGDhXz6KcC/gbdo4pfheRSQBfaaz7MMVS9e7IadpyGg093YCBeBrZQXGgXt8/QrwHXhSm5xpRu5L9ZluorVSMaWbB0kBpbHu42/mAlG2WYPTj0FlIHSfmPQRzd3C2MeNAJdZpT2oPCBfuloPKGkYWiYsDZXTtHYYMcw=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 04:19:40 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::b0) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 04:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/19] drm/amdgpu/gfx12: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 00:19:14 -0400
Message-ID: <20250528041914.5844-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: d1827952-dfe7-4141-f660-08dd9d9edd68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w1jB5YVbO7oY/w8+WarIH+AXFVLmZVNl46zGwP5+J/RabuFPHYsWclWYugjp?=
 =?us-ascii?Q?bIfbca9yfM8o/R9x3Ubb1rZJd5eUvUTzKrEYgsMlqpshe2Qumf02C0BzOJR1?=
 =?us-ascii?Q?WBHqSdxd+XeBdaTsv49bwB54fa2kZglDBOG20N6OLKCD/64fV/XZJsjMP4AQ?=
 =?us-ascii?Q?paDdA1p6MUUXYTvJGn/PB44ZI++FBLlEhvj2B/HDkLkfDhgJ7kQUoxd6SKt1?=
 =?us-ascii?Q?KTe68AoWVDjE7PsBblowC108gyTC0vMsjHE/vwL1QS8O8fd/GNKOknVl89hd?=
 =?us-ascii?Q?PQ/8PVS/mIBx47k7an78Cs7+TFxqds/B41nTk2zaU++AnP65Ktp+gD9AiA7p?=
 =?us-ascii?Q?HMbD0CLUtKH+skXQbsifAtKwwaoSgopOqtgBsRgPhi0mIHwUI10Ke6gstFMC?=
 =?us-ascii?Q?qD3LI/TRHh0JFC30YM2Av6Sdi4hsvu027MUqZQfbLiRnC/Mjk6dIPHeU9W4g?=
 =?us-ascii?Q?WIUu61o1UAAzs5ncpUAKufB6PdSKbZJqgcXSKfbA68ApfEEjS1Kap6hjVg/+?=
 =?us-ascii?Q?bO0aMCs9UidvFu4PHxzo8EXhKDE0XKr/nFu6Tvrmxsnzhd7YNKjuS501Rx4q?=
 =?us-ascii?Q?DZAaLe2hhs/w62cvdP34RKhE1aobLUx5Bb1+phJ5280ND2Hq5EXH8o63XFSo?=
 =?us-ascii?Q?5q8l8y+4VhG76FnPyyMIT4ZF059hUs/HwXCFx/E3Tr+oEtv886y+D3RUpB5D?=
 =?us-ascii?Q?Snc5yj0MkAXUk+6SFM0PMKUwNXF/SfHGrp504w89mdoq/fa0xs4rzjYHW+lw?=
 =?us-ascii?Q?+BBEjF/7xEXEFpFvDD0o4+SBhzoq7eQbj3Y6Cr7v618Ny3xav/oLdPfvsrkr?=
 =?us-ascii?Q?KsQW0dhpYVn+vbwgGvl6F9oAOHqKKd9e1gex8A13TE2KVCs7rx1+yDYtjNeU?=
 =?us-ascii?Q?UekNWtFnQz9Jm5ncdLMgF9G9mNGO6cPQQLe0+rEyDMEYU8Htfz77XV6Tcc/2?=
 =?us-ascii?Q?5+Y3y5aMgbalpT0BpDmCnNn7OGmWDX3w/HnvtRKgEzfTN3txEvB+AHbA7flN?=
 =?us-ascii?Q?kK6rTg1ps7I5kp24bqd8E+a5AdLQaL0Am3VnGuuqhx/0exdaVnzCyVEXqUdd?=
 =?us-ascii?Q?ELkJbmJoTrjSxgwar86ajULQsyKfa4ndP0EFkVGIaNF62hcVXM8H4lRVElp0?=
 =?us-ascii?Q?ZeW9yro4zAbDQvTgjlxt1dDaWBrbMB0IlS/p8RltHqEHqcAGlG2SPrwCBzY7?=
 =?us-ascii?Q?2OUrNSTfY5E2LMRKb1h/YZkWK6GnbLqtuxCPbp9bXuX/xwtKstGOm9yrV8c3?=
 =?us-ascii?Q?macWKbRjFN6umQ/kQw9d0zvuDGsBTdFWclOzXKJKvxUX5Sdas62wb1ykQMYZ?=
 =?us-ascii?Q?pM7TPuGx7Zq/6AFpEWcABERA0aUDoDPBuozThdSTOVeCIo5tmePo/b8YsbRT?=
 =?us-ascii?Q?JGWEYUZfU2EZbfNBFvSskpqP+ZUYIgs5OwYtItR/ycleXu/ZlE3yoGEHRG+s?=
 =?us-ascii?Q?5AoOXwm9stRJ92D7YwVTN06C5f2ypz54mETw4leeUn5h3LdfYWUY/T2GELV1?=
 =?us-ascii?Q?UJqv/xi/fj2TrStNqcp7ihuQhWehiuUQPraF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:40.0709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1827952-dfe7-4141-f660-08dd9d9edd68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 27 ++++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 4018464e00939..a9e8700bd5f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4699,21 +4699,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
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
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5442,6 +5427,7 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -5466,7 +5452,15 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v12_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5582,7 +5576,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

