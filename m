Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C6DC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 20:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B0910E8F4;
	Wed, 10 Jul 2024 20:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hjlGYXJy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D11210E8F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul25N5OkeHyOjPv3DXMAMGCpwGfNYCqSiwi2pW+yl459MBmT2P5FRBUpbtCKGdbbQF+LYpijitZuN5iqthsgOx5H0H2lwHCCvERfP7FfMmc5zkB6+v/Z0eG/+vaPY0KIbhcmrlGFcym8hIigRGJ7iJgId1gNHCvbS4j/oViGn7CkG3vzq2bw9Ni3GnHsfVt0eqSmr2qusaxZcRjQr7w4x5GpIf38DFJJ/FzKL+Wkm8nMDxDh/qCz4UrlURH7Per/LSzs+mzC6J4voNPeQQuUxBpxrVxlB9hwNB4gWeoQbY1MGqWTdirelnXxgZH+FZsjAUt0v01BJXiXn2z0fUL3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAa+5J9VCi7epi/ExPKMcpROlS4OvtHigYQIDQJsQ9w=;
 b=Yhkvb2xfk3hzUK5ElAF3Wv3SPoa2zPUwbSUr/VNsjslcF64oYAeKnCJReIaQB0htCIm6C1Yfu2k6ImvVkdChJttS2wT6T6dZqTF7q5ZCIEoLbQjvzoUEd3n+bAiqPy1zSaCtvtx2Jz88RDhE90evzPLvLdHJoOg4i5B0jIsuLp5stducMcqY7zNAsdyoXVoNEjKnylsP4CrFYRBjJc5O04egO9rCOK/ZDOPc6nVAbE5LyGsdRfW1f40rOPtpFmPNV+tLNLTBdSuYyR1fDg+tuQwzlkkJpoHO8Zf5rg1DCf4FdxQ1L6/Tc57Si+1WJyKXk7AWiTdepgZkk7lyWKngDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAa+5J9VCi7epi/ExPKMcpROlS4OvtHigYQIDQJsQ9w=;
 b=hjlGYXJy+Fl/yVFa6Q624NSawU1GDsJu0o5sb43v6AIAQvR5r+LbBmTQfhDI5dx/X60qiH33GTVCto/E0iY36J8glMUMv7qEggros60KuuKu1n0Tho21Vzwr4ZDOJJq3O7dVB2CQDV++XzYyUScQOZKDssqQtNt+wqYh0fyltz4=
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Wed, 10 Jul
 2024 20:30:11 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::d) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 20:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 20:30:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 15:30:05 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Date: Wed, 10 Jul 2024 16:29:52 -0400
Message-ID: <20240710202952.188573-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710202952.188573-1-boyuan.zhang@amd.com>
References: <20240710202952.188573-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: e9147b36-a325-4376-3ea1-08dca11f18cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wz8cAWS7pS62PjVDu8L3avCvuitbvk/mi9KnkhnpZFnGA+EQFJe1X/AjsxVm?=
 =?us-ascii?Q?n4E/ZP7CGJ48fexmhLP307fRWuinHZYUqF4UwBy9e+h/GeuDBmJcAAvJDsnz?=
 =?us-ascii?Q?kZWyxJegxz5V59EUqaBUxYhPISzyysF1D6G/7dow7D2F5bIgstXcMG5EIGYO?=
 =?us-ascii?Q?H79tMMlihnPGaPijYDAu6g5c7phHprfpWfvGgMHkujUhOZZd44BCtf5uTBku?=
 =?us-ascii?Q?yt8U0WVj6jgMZS09CbwnOfjOxYAtFDiSRzj3J5dg3ARne3J8dh9VwVNVNIAD?=
 =?us-ascii?Q?DtMbjZwXy34pwPBLAhQDrtUcLVmyWRxCgUbUFks2Iuo8F7qZIcDZVDY9flzZ?=
 =?us-ascii?Q?ZPDLxLMxRyOR1G7H9yhmRVdS69SOfu4KhdacjhDjty/Kl82qBxruuw0CYODI?=
 =?us-ascii?Q?nzjNXX8uMDRbe7J5Y1veLqHu8EvVv/r1R1EoW4Hfwpk/+JtIookbxh9pMRiB?=
 =?us-ascii?Q?6QHl2rPBFttWHle9K7bw4/xiEjiYnGY0Qix7ZZJ5OirZ3a70/gepWDFZshFj?=
 =?us-ascii?Q?MDyBKyMDwFE9IW1UrlXBYTsj+hmO6Lxp++qrdVj+xyvH4CCzaK1gZ9FQt2py?=
 =?us-ascii?Q?FOb0UMZK0iNdGXPxaqBiI8A5OXW08RoYiX6NhwWThlHPdMVd2vK+xlchbrPK?=
 =?us-ascii?Q?MzOEXHor6L2AmyK7+i7bjBxRmJD6/S8cV8R2kThGbeZgKB5eIw75DM2KASsu?=
 =?us-ascii?Q?O+NcH66yApttVDUBVfG4VUyrkYuxUTV8dwAvWm8705eNShizXE7Hw/ZooTZN?=
 =?us-ascii?Q?TJ3LCuhW2VG8/CGjVV2IeMAF/qGhS7YuHAH1K6Z5Fb1Zg8Ih1HV/QoicILNC?=
 =?us-ascii?Q?Lvxy4boRAfnuw1Dc7s/bbz9IU2GRaIqispKUaqaeR457Luj707VOCQWU1x3L?=
 =?us-ascii?Q?wGxCmxdj135sUT2p9DeblFddddLq1U4gOBtKZYG4OP0/awdoY1VW8yDPzZR8?=
 =?us-ascii?Q?gtzCCxIv6K/6ij1gVPeN2bMjNNa60bOzHLUU+McW20dY78tGP42b65qH6z4I?=
 =?us-ascii?Q?i3UQk3CqPsoaImwlmbEF9q9GUEICN36PsAX366ohIw4kEB7Ea/x4R9Z9x972?=
 =?us-ascii?Q?oWHMGmQBaJPn/jYo9DPLi+6F+Z5YQHFSrPSQ5qRW4MORF0YkSy5Iod/vXv+n?=
 =?us-ascii?Q?5Ry48bbngVE+vT7kSo8Xb4s49am9pCr4EWVIW5CpHlv19yh8cGISw2ff3VMG?=
 =?us-ascii?Q?OV8QGqrPS6En5lwT315e8drO9YXDjBDbAGZnJUIBCFMLA7Cd6Z3SSq85N1mL?=
 =?us-ascii?Q?0QdA042jkNU4okmcr80Rl4RXkUsQ3YFZZzLl3B/VbTKRVGB+ede8kZdPLBRJ?=
 =?us-ascii?Q?X7VxuHBSYL/7La4joAmccvWRp3D9X3g6ZpKjseMPqLWTw8Px7JXXZ9sFWifp?=
 =?us-ascii?Q?OQTxYRY+fmewxe7tENZMONjI8YRU3cxVtvAm66T7LQq9mbQvEeaJfNhej0PU?=
 =?us-ascii?Q?aMAkMkrsgTgLIFuK/GPPj3UuFPtN1oEG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:30:10.8673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9147b36-a325-4376-3ea1-08dca11f18cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For unified queue, DPG pause for encoding is done inside VCN firmware,
so there is no need to pause dpg based on ring type in kernel.

For previous generations, pausing DPG for encoding in kernel is still needed.

v2: add more comments

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f59e81be885d..00f3ac5f4572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -412,7 +412,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !adev->vcn.using_unified_queue) {
 			struct dpg_pause_state new_state;
 
 			if (fence[j] ||
@@ -458,7 +460,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -484,8 +488,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
-- 
2.34.1

