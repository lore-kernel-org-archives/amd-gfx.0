Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01749D44140
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 10:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D3410E0D1;
	Tue, 19 Nov 2024 10:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a+E4AVLj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766E710E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 10:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5Z+DU8/7Cb87I6QHCWNSmqJ23q2Ge04dX7iPXMxw8DdkD2jrOAJ3exzqRBLkuz2HpIiyYwZDIwpscgVFtahnCph4HZOWWa/1NaUEITOicxzJRorwc0IzJnRLDHLJWa/PuRGEm31h+9ff8McdSqUdZXRttSwW0em2JWtstlKFzbLp9ZSWNCjOR0Y6bYFHdHiCi2gSkhN1UhjXxCxr3TuFJKFVdx8qbnBtghpo3gfddZmd0rVrFFMznVzVLrBiEnvPpeA0nR9fTq4gxj9mbP+5qQeV7dZtWAjJb1aRzKsiokSsp2HS/wewfQmmOqR46D8GWmiKpJJHIbhcTGUkT58bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAw5OoIalqQ6MniDh/ixMDdAlzWt2xhJ9ebO2qh6gaU=;
 b=YO7BsmgsLwiwJ+Jdx9BuQ/+VzDd2WvbJ4720sZIOfj+5QKSBdNP3VBjsnYqRw1fZ23QHS/Gnsypr74AUhJOodMksk+NsYHW4+LFjLAebIVGkuo5aPl1rcfwBuue5fW8FqHKltPCov3QIzoWms9X6EnL/iwkksNap9JrjJfjPdsfSEvwDjgRyJ+W2m5JRuMfFaWMEhJZfkdBPHNBB8+R2CR+EqKF9R9QQ63cVYw3jIeNn9Mz1cKj98opeZ4akMeffjpEq9Qyi4fVax0PoOoA+a2ydRBUxeYBWBdVDfWkDNlek3TgHy95baQ0LDS1fBfgWGF9t1F42+evXHL7nuH3tgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAw5OoIalqQ6MniDh/ixMDdAlzWt2xhJ9ebO2qh6gaU=;
 b=a+E4AVLjg+nwWrzN6e3VNpkWSxVssp7DungfIFGUebQcDTuTrE/SCV3ppq0VwwpIC4IHJG81/VGGf7kMyHVMz+IhhIZ8ctAyemIp1Hb2FiPPbeDyQyh3/VzoOljVEQvPErye+qmYOuDpDXVr63yZEh5wD2nY24vgcPkvDAlShek=
Received: from BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 10:58:50 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::25) by BN1PR14CA0003.outlook.office365.com
 (2603:10b6:408:e3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Tue,
 19 Nov 2024 10:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Tue, 19 Nov 2024 10:58:50 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 04:58:47 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>, <hawking.zhang@amd.com>
CC: <david.wu3@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrupted
 on vcn v4.0.3
Date: Tue, 19 Nov 2024 18:57:39 +0800
Message-ID: <20241119105739.1047372-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118094737.1024533-1-xiang.liu@amd.com>
References: <20241118094737.1024533-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a656817-8bc1-4ace-8f29-08dd08892650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q23wORsVaMIVYBLq12b8gYLyKDdEGj+yH/y20UP09oQiybZnujP7N9tYygF0?=
 =?us-ascii?Q?dy6i8u4BKJQHo0koRBp0T6WFdZTwoa0c43LySCNi6zmpoSMhAxpc5FKna9D6?=
 =?us-ascii?Q?bsM8jkFCVmaLSvN4EgMFPtOx3tocYVaUcDTYegWKsW4F9H7Llq9axretBKic?=
 =?us-ascii?Q?EdI2S8bQLfSLrLDO0yrFaVb7kI6uVG640wn7AW9Zi2KwefK9bb/uTOtF0CqC?=
 =?us-ascii?Q?QwtySrPRJga+fzRsc0KCzqZNTNbLjNmsxUym5GBIbg1tfuX2GckgxqK34OvK?=
 =?us-ascii?Q?mnNBsrX2M86CyFQawFs/fRTZtI3FiMU8agUp3z7UIZksWGIDXVmGjZwPzVby?=
 =?us-ascii?Q?tZDjQQybDrWQkEZ6ggTVQXON2VTJFKvMO1xUT0qf/8LczhrZlZBjecVgHL+Q?=
 =?us-ascii?Q?aUaHIkw/ZVy0/kej23sBIeWO9vpPoQC3qh2jPGRhTlj2YHstarnIjX1J/Mhf?=
 =?us-ascii?Q?iPi2ejNuqVwFRleKnkiy+r9pb3Ycdz5d6FDzmVQC2qKETw+9RXZ9Dlipyyfm?=
 =?us-ascii?Q?Z8nFfoKKjsKrYkS1VsaQfDg+B0Ib2j6FXNgpa5/yC9qbeECfP3267w7GNODE?=
 =?us-ascii?Q?wgRoe5RWGugAk5FOyhsSqzd4+q0gs5oQYBlP3WCevyOO8UPgzg3stoT3Mq3d?=
 =?us-ascii?Q?kxFiOp40/C2KqnjdP3etcDYym4eVX9GDhwII53TuTYBw/3Msm3RPKQPpeucZ?=
 =?us-ascii?Q?70d6uMIDaQpzhaF1MhwDneanceWzDT5bFyITHIupJk31EMm/3N7Qg4Pde6HS?=
 =?us-ascii?Q?AAS7Dc+HJAL/gs3MjkZfIN1/Vky6LqK6dLGtAF4OLWCDwi48k7OWNuZ4kLVC?=
 =?us-ascii?Q?LcW5VL/bv4l5YNIH0hnzlivDPLhBXpxJsS//9QyD7yFahO9+FIvynODp5ebh?=
 =?us-ascii?Q?moDUaX3tdiTelIEYhYcGPeX52EGeUpM+E6hMAfHpzO6qQXHrKeZYNFBFAPo1?=
 =?us-ascii?Q?ltxXLarWAwnzj/gtatLKEPPta8Sz7KViBymp1hs7h5alh7moh70GgMUrkQB2?=
 =?us-ascii?Q?xPrf2vHPDrSd6IVfxtoRF9HppIaZ1tEdoHBYueK8P3aLOQAmONEearneUIT7?=
 =?us-ascii?Q?xf1SKamqlF5QBHbJZbY9vXaSv6//ziy7n1q5hxnyAKtyQk2vwBKOqc6FI2k7?=
 =?us-ascii?Q?wTonb3ZNKw0sjXvAJ6s+e2YCHtf+WgONkNyqaQTWCJiGQ0RjhF6V4TyJh0nT?=
 =?us-ascii?Q?hW4kKP1NizGFyT0XXnEpOf2vf2O26qFPC+kmLde+FdDafC2SE8hysy9cJrvI?=
 =?us-ascii?Q?RcC0TfqGcHn9Jw74zvkv8NRSfQ0swdag5CEZ926C9ER1XYCxOTycOqsN2ieW?=
 =?us-ascii?Q?T+nsm4493xZTtTQw27VfjJd8jFyQdagOIf37B8GpbrRmUmL9D273G2JwqHJv?=
 =?us-ascii?Q?cIVFkYCIbmAehsNLYN9GJva5N0J0PcTeSSedCSSuIT8pvlteqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 10:58:50.1896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a656817-8bc1-4ace-8f29-08dd08892650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

In the case of RAS err_event_athub, the VCPU buffers are corrupted and
cannot be restored in amdgpu_vcn_resume(), the buffers are cleared to 0
for good. However, the fw_shared stored in the buffers need to be reset
, or the firmware cannot work properly.

v2: Remove redundant code like vcn_v4_0 did
v2: Refine commit message

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 32 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d011e4678ca1..cf8264bf45c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -123,6 +123,20 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vcn_early_init(adev);
 }
 
+static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_3_sw_init - sw init for VCN block
  *
@@ -155,8 +169,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
 		vcn_inst = GET_INST(VCN, i);
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
@@ -179,12 +191,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = true;
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+		vcn_v4_0_3_fw_shared_init(adev, i);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -234,7 +241,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 
 			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = cpu_to_le32(false);
+			fw_shared->sq.is_enabled = 0;
 		}
 		drm_dev_exit(idx);
 	}
@@ -280,6 +287,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
 			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
 
@@ -303,6 +312,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 					regVCN_RB1_DB_CTRL);
 			}
 
+			/* Re-init fw_shared when RAS err_event_athub corrupt the VCPU buffers */
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			if (!fw_shared->sq.is_enabled)
+				vcn_v4_0_3_fw_shared_init(adev, i);
+
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				return r;
-- 
2.34.1

