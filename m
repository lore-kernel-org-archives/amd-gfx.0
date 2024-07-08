Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80237C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 21:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237EE10E324;
	Mon,  8 Jul 2024 21:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBJ1/v8z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E3C10E324
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 21:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR4K6kS3vnac+2puxOUcr6Yg8GoGCvZu4Go8LRgY5ln/qN5B9ZubQkEtSmoeoV8cDOIvR8Pc4VFFK+EKKTOjAabYDF5NQJiSwyrd4OPThgQCxu2JFBvDKKKWm3z2VNJWF1BayBEbaMYkIT8Hu8TTIXOSD54i2Ru8AEmwa59R+/PbspsX17v2cMmj21VMjIvjKbqG5D8Pr9h/eE/nx53aEhfX764+oMAIKR1IS5KbZnJZoT/qZTP9iQ4sLhduj6Yrn5yjSy5+fYtfS5cDC/+DWvlMS8FlnphyVxja+tpgG/xJUAfsih3QS6r5yAZgCnRRLviZCXYlInB3CxBgA+mB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI+9MJgwTGsGZ79EPVjcXRCRiPhaPQA/9Cx1iB1/txw=;
 b=fYFlEaC8JJ7GbJkizIP0Bt4BdazgnX2+uq7UD7v1iMVDOOaSfmU9o21oIatAg5NY0slKF6x2FNqp5kW6atY4XH3hTmW78EdWjAmXQM3rfqfrHvyrdUsKhlRtQCTrR/ZY7SB/xXMZ/upRjrZoDqDpm9QfpQY7ePYWVXvW99aHibw7bNCfTny2bUwWB/bm5ewOpych5JD+xpl3hMcYinKjAhEyIsRHh9+cGt1tVwHk4SLbKax5Litg22pG4aCC4Dur7ndC9D+criZTrKYRa1CAHhD+fijjUwhzQgYa4+bVNWXf8R9Kb23A2byE7cNcdJ35NNMpPmjCRF3kliR2WL5cxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI+9MJgwTGsGZ79EPVjcXRCRiPhaPQA/9Cx1iB1/txw=;
 b=MBJ1/v8zrsHS++YXnW2xRrdXTNC/7TGHgkDwLa/xx25xwEeqeVzGxSRUKsIEzXiarp3mXLG6MyS2nvL9e2xE9aHcE0jdYFR0AoR1QP3hz+Iap2iQLbc6WG8VyQ09qo/Oj07upyrAIr3qkwt4xx0fQ5SrccMCcRPLyfxEcWfYtJw=
Received: from BYAPR06CA0035.namprd06.prod.outlook.com (2603:10b6:a03:d4::48)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 21:41:45 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::58) by BYAPR06CA0035.outlook.office365.com
 (2603:10b6:a03:d4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 21:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 21:41:44 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 16:41:43 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH] drm/amdgpu: Restore uncache behaviour on GFX12
Date: Mon, 8 Jul 2024 17:41:27 -0400
Message-ID: <20240708214127.1330692-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: ba574cfa-3ba0-44a7-caea-08dc9f96c307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D6zZJq72tlusr24KEW+GZjhLIZAcWLRC5b65zkvQnn3q2WClVu4nuWH/AsfH?=
 =?us-ascii?Q?JEy8do64Y7/rMjqDlDJfN5J5myMi4JRTfY+oevE+8kFkECaqFjgjO8kVES7P?=
 =?us-ascii?Q?icXGstDs4UEOUDLdKC2WRK3UAUNHlzBaj2fvOLWVl9PQ0Fsz+89btHwRl2cY?=
 =?us-ascii?Q?s0z4HUR5dyYCQ5c6JHBKWxywXBqpDJG6fKZZUv6qM3OxXJdAiQrTa/utYFQU?=
 =?us-ascii?Q?oyuZosyn/GrNyTXmOKGGO3ho2q7kKgwDCJzW3VF/g+FvWXfqO1z+HdIHnoWr?=
 =?us-ascii?Q?4m5YdYSWd3y+/rLdiQmjJ5J0y7BY9asPcQWolGy2RMxhoyH2rWUfBdpriZpb?=
 =?us-ascii?Q?h6ffj6WBTBnO2llHgzNIW/qXMqXm/jKJ0dhcK94arI3OLCIlqbS08XBGhdKS?=
 =?us-ascii?Q?vA7kxfvaCu6kZT9aOPFIj6eCsHL/1adopr2Vp/9lCcsAFzLS8W08HsbWH6r8?=
 =?us-ascii?Q?1xqvQLm12qw6SLahGfjKqJdcei0vgHRXDAeaNiC4FF8XUTPETTEWQ4qDWmf9?=
 =?us-ascii?Q?eP/4ojpnTGzzOSZM1cMj4W9t7McIfrptg7Ir1pBMlcnDYTN+bRxDW0ibJBXW?=
 =?us-ascii?Q?mN73ahDyl8yO0lQDS/JQXWHabNLSJYHp5QZTz6VfVSibAK8LnsdX/H1OorUs?=
 =?us-ascii?Q?VftWQ88XtODYMwnP6vKS+x1JFDFc9tRoe4dVEqZ2lYLEFJ+S3GkewNiAHHKV?=
 =?us-ascii?Q?Xuc97ZaMuNAFf8xFuT1A0IqyiVBtzR7tk7z6Na0f7G7isjkzRbW20E18DStK?=
 =?us-ascii?Q?8k/XKt7Bb/xSfDu4kFBMamWiBg+soQWNV7yemt5NrWoBh90EiCbgi/0zuPdW?=
 =?us-ascii?Q?GFQt4WWH94pXr4ViRzGPT93nAOCzr4ulOH7sM5Twxl8/7qlbmkHqmZYwS/ZT?=
 =?us-ascii?Q?5Wx8zcLkYJKP4+dTx+CvIyUg1Lz38R6nE9G/vqEbxfhB9E+iLEQcL3o0EjFT?=
 =?us-ascii?Q?3fzPNrh7oZvzJGQRTnAukGNE6+CSMOMYEGFXw4uv8VsVIOc5tBEs/aQB0sqe?=
 =?us-ascii?Q?EPgpAqTJX2pEiknoIELadWYBi6N1xx7OOIVNkAZuAfzCezSodHp+cvVGtwHD?=
 =?us-ascii?Q?QmlvnYvZ8qefFp6wT41fSJfrACMVc8N2kKjD5bxhdoW8Aonfrh1voWWnN+YG?=
 =?us-ascii?Q?S6P8FmgLW36M39vbrwovyhCQ1R+krLPwrElXsk4caGAiHxKS//hRB57AXXeC?=
 =?us-ascii?Q?Y5G0UFGhe7RZrzqdIa2DErDMOu2po4NlBhtkUdq/z/Au8j2s2W03BpAE1UBf?=
 =?us-ascii?Q?f59HjlRTzPv8R2w5PuZofl0/Y9I+DQAWOnvM69qYHa+SnsjxM4R9vQcyRlOj?=
 =?us-ascii?Q?By6ERORLr6qkdOTGz4CnpO2e9Ib/U4OzwbAeviQQSAQDFsbLrZuG+x6SCFOr?=
 =?us-ascii?Q?GbNiemIF32nTpqryK89FBKi/g4njW2rQbESojnQYhIlbbiajc20L+8o/TDHI?=
 =?us-ascii?Q?eehFrys251p9zLM3F6mTcSZN1yKRYtWr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 21:41:44.4183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba574cfa-3ba0-44a7-caea-08dc9f96c307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

Always use MTYPE_UC if UNCACHED flag is specified.

This makes kernarg region uncached and it restores
usermode cache disable debug flag functionality.

Do not set MTYPE_UC for COHERENT flag, on GFX12 coherence is handled by
shader code.

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 21 ++-------------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  8 +-------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fd3ac483760e..542225eb13b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -498,9 +498,6 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 				 uint64_t *flags)
 {
 	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
-	struct amdgpu_device *bo_adev;
-	bool coherent, is_system;
-
 
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
@@ -516,25 +513,11 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (!bo)
-		return;
-
-	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
-
-	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
-	is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
-		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
-
 	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
 		*flags |= AMDGPU_PTE_DCC;
 
-	/* WA for HW bug */
-	if (is_system || ((bo_adev != adev) && coherent))
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
-
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd9c2921e0dc..7b671aefab01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1248,13 +1248,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-		if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			if (bo_node != node)
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-		} else {
-			mapping_flags |= coherent ?
-				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-		}
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		break;
 	default:
 		mapping_flags |= coherent ?
-- 
2.41.0

