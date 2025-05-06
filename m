Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2B3C3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 20:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B9610E0F9;
	Tue,  6 May 2025 20:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QH0vdXyh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890CF10E27A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 20:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4itYjvbgGuE/sEymPMluMBMq07nmhLrozK2DMwSeLzk/5guJU+3AuY4CUAdQvyeFVYRFNVILxIjb0d0mz110jrxYEW72yBrVEwo5oiiyg2JpO4wreLuiXA5OkXEFpH6WNsa0ydPA6sGjRPa1dGJmizXQ0Zu1mfFSNoNxKKm/rBoZqTkUa6o/qHj8BrQLgx2/q97YNCEP1iQlrdoUTljLA+4dMWHoiUgg44HPdqCF7vwTtAbwOuuzd0Lm1i+2CpPlBO/HA+nr+gPz8AiVQS/53xwVWycm8WrPBGKAdiiRX6N8aqjYUwn6cHjeHByeindhD1kHFubJUa59DogPWrv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BNPVj7AaFblAraMvzz1/RKrgZWVKFt4Iyi6RK0qpt8=;
 b=ZIGPRdLMcZMvBLl9VtqmzJ9ixS96gC0+Xhks0j9Atjuea8txsMMrpbRvHmV1N8VWZ0OtlpAWpOCVcZ95RwlZrbnySL7fazhTeLmN3Ah5AIwN3atgwRoNwlzy7PBhRxSr8NOoxY1S0I9IKBSJAFXmd8bCcO0WWSi0r1sVnVojqCDUEBw/arEUJUIuwy7ay2KcOsmDrQCWL5ZPX09V4vJ//n5Pji41RDbLKb2qNYIrBxgE1qVXvRQTtsZInBjzRaUVfl7oCDFv8DCTREihALzbIZxt5qO5gkkDfAtAbGq6Y+IBr03fdj83j3yl32xuMWxXmTy6PkNdK6VApjqFckrgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BNPVj7AaFblAraMvzz1/RKrgZWVKFt4Iyi6RK0qpt8=;
 b=QH0vdXyhhGBXsyL4it4ptL/rx+7u12/gWyEmEAoRYqA9LKWUaIFGXWvfanHIQLCVdMLxUWPdonDhD/buCb9TzMwCzaSKREsiDiiIVPdx4yg+9UIKLOOSBB7VmdQ5mu+vMXZGs5CM2ttSfc/w9J4aTff4vmkP5mP+w9oUfuWLkQE=
Received: from CH2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:4e::26)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::611) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 20:50:07 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::b8) by CH2PR02CA0016.outlook.office365.com
 (2603:10b6:610:4e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 20:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 20:50:07 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 15:50:05 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Wu3@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] drm/amd: Add per-ring reset for vcn v5.0.0 use
Date: Tue, 6 May 2025 15:49:48 -0500
Message-ID: <20250506204948.12048-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506204948.12048-1-mario.limonciello@amd.com>
References: <20250506204948.12048-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: f1641cbc-dcb6-4728-ed46-08dd8cdf95a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fpRr/ybc+3x86KSgFo4+GCDxlM/S3bKLvKbJyRsjFYDYCwgQHi5hHdmNdMM/?=
 =?us-ascii?Q?9z2YpWuALx7T1WgVFV/GcMiSe0/oqUZOrwwE6+bJRIVrd8oWjYiHwtE50wAM?=
 =?us-ascii?Q?ATbeKUNkxPsSqj7crnnqGO2kDW/EtALcAue7DbHPhYualIfMaaYPBR11KfUX?=
 =?us-ascii?Q?z8fTcCU6WWTVD2HuSpIjm/4hPHNhV92cihAD1HFLYmLnX9pnc8bVDRNSVxw/?=
 =?us-ascii?Q?XZTCrP2gbGymwQetamy/ppuScWfteocp9pDYRUblAoxccI2hA5+iI75bYa0Y?=
 =?us-ascii?Q?DiUG9bm4Jj3zvLakECmstcJOY8UK/n10SF7V62jIyGPCUbI+tjlnZ3T2EDxD?=
 =?us-ascii?Q?1eDElzfIoHbUY/5UIZDsRYCgo4LX3ey8kZpRcQJHtUWNycjT36o59xj5iXAZ?=
 =?us-ascii?Q?z/c/zEyRqZhPOkeABCTOcjQyJN9QMfA2fyTnDLocqQiWEb4NzC1MgRDuhb0X?=
 =?us-ascii?Q?PtOcWkyvYB+VGKwtVuk1IcqQW5mdSF0aEihfW0yu5BSA1wd3mgyqbjsdbPvb?=
 =?us-ascii?Q?Z+pgmPv7fdZ6oVEKZnosfT9sTgrbOyZdLtRTfXYkoX8hB//pbUUPnumBmmh/?=
 =?us-ascii?Q?ObMPmYycZ7XkQBmFWvHlC2hA7xJNBXWedTj1Z3QMrMoN0ecJlsvp+80LOlaJ?=
 =?us-ascii?Q?SqqNqZEH6N9JNq9wU2L2ETdt7sfgyQye5TWy7eUmjgBNA6JkotiyOVwH5dg2?=
 =?us-ascii?Q?JlW046rAQ1Q0HLhbqoWnR768OZO7EaUdDSf3GVyKnqCT9Ixv4FlZ0wRYidMw?=
 =?us-ascii?Q?yCK6sMfSd3nnIiUrnjtCVMONoxf9y4eruVtRl4UtDLz6oOZ0tpqijxAyQBva?=
 =?us-ascii?Q?HN5AtR/gkIOYhN/iLQE4VeYxZf9INKsgX70KkqkSaIQ/ToKyiEUA99mUF3wY?=
 =?us-ascii?Q?IbXwDZp3wMDT0N6+vqwhntgb9g5LvieMRgNHTi5Og5JvzxUa2rKDGSYLBDls?=
 =?us-ascii?Q?nw7ybopMGNt0XLArAchRDTi+p2xYHDNiy8nuWi9r41n3SRHXWe1b+2cnn/X/?=
 =?us-ascii?Q?9+I1zyjWkhgfABWULoJsayQ1CZD4uxwVB4OOcHOSTVDwon7BlL95dONtA+D4?=
 =?us-ascii?Q?XnAATEMzl0sA3n4bsGxn1SD+wNEvLf2dVChhtWXlQ2IPu8sa4+olKkHWt79N?=
 =?us-ascii?Q?WALaR5xcg5s0sW7vGqcbrOt79VRz6QdzxJWJ8yyHdUpNJWRIK+YUBBg1bzfA?=
 =?us-ascii?Q?K0Gg9Iurr8sOUM9yhr5RxKY2fHfNiyvPWk4RC/GGODZqLJKRCbdEL9zhMALF?=
 =?us-ascii?Q?AcCQGFiR99pqK/qdMqDbUzjEv0hRc/G+u3of3v9gpvh3luALOCQBlwlcFyCN?=
 =?us-ascii?Q?ZTv5hppW930EBB8yHFnpeyi/GLPXJEPqTbZL7cpJbrFCHloZRUiN8xDstdhT?=
 =?us-ascii?Q?90Q1UmCRlA+wRHxg9nTY1YBYKjQ6tTMFf7tN2DSPpwV4ZWqokMMCeyZ3SZGw?=
 =?us-ascii?Q?+Ens9GQzh1YWW8iab6MfxL2dlEnZtcVaWsrxS2+f+ed9oFSthmHhJEbsjI87?=
 =?us-ascii?Q?p/3gH+73IXYaIM21757jRyDENETjlcirKWTk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:50:07.1939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1641cbc-dcb6-4728-ed46-08dd8cdf95a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB
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

If there is a problem requiring a reset of the VCN engine, it is better to
reset the VCN engine rather than the entire GPU.

Add a reset callback for the ring which will stop and start VCN if an
issue happens.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b90da3d3e140..27dcc6f37a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -196,9 +196,9 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
@@ -1172,6 +1172,20 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	vcn_v5_0_0_stop(vinst);
+	vcn_v5_0_0_start(vinst);
+
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1199,6 +1213,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v5_0_0_ring_reset,
 };
 
 /**
-- 
2.49.0

