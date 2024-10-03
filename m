Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352F0CF34C1
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 20:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6E410E241;
	Thu,  3 Oct 2024 20:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZdg4hUu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214EE10E241
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 20:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfs6TlXDyX6C9md+aEPGx/YSbeSB94oey3l1aNsffXZ6/m5cspEQ78/w5WeM5VaE2MzWSA/r0af3oPFoFXcDMSU/Je8o0KvY3RLs5sokZi07O9uaUDHEXdiBbWF3gjJT9U66CJwqUpK8zbQlkVZgX9EmC+lkni6UK9c2M5/OVq8HCa2rxDkA3jMRo15q9A/7DH12WnkvNrFUJuvGbyeO2EoyvN/A2xY790Xispij5zEvDvfcxiCtkw9vszBHnpDqCvbtvf1vCTNrlMkfcmt8QLdlqsrobEVGdI9YCwKFHGeJtcxZuvaPjlOZcioEE2Ilp1462faVAdYigRR31Sgmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXBaQZhyeZILSSYUp0zDS/izxz1LNPqcBwXRVSXnmAE=;
 b=uLEvZL2HagGrlKOjnKDCJEELXGJpj+x6UOpMts2UonHjmoTp6xqIHuMhirczgssiij3kmc8Q4yJw6BFDhlZmFAADggkddvBxWzImjkoyIRm3NCjWD6QNbeVDRrR9P1LKyo++uStUM5vyXOKnf0r1vJkqi6XTdYIyTh0bywOX2yCZCJQbCNJhhwaImzn4G5+f34s5kXvlEMQCNzkWbLmpWooO0afoH8n8C08kPFkNe5UuaksdZeLgFj4hjJb5ZVmSIlo9SJYLmkM/wBZ0cjgCodWQDwIMZzNz8yXP+IChy+xP3JTSVP2jZnw2vKchyp3EXsEdre3QaT8mzW1rNiy6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXBaQZhyeZILSSYUp0zDS/izxz1LNPqcBwXRVSXnmAE=;
 b=mZdg4hUuy7mcatPZEnyX/nO9nidoG5ayN7bs8+3829fgyc34ViPzaNAL0nh8luK36bEeJiZ3xlaeoJ9omcwWLO1qrMAC+DHyJs1DJWFI1/VC8Zv/wZ4Q+iCpGWe4yb5GzsLDpMMVScQ34B40EBvZL/GSn3/892abxV6h6LxQeL4=
Received: from MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43) by
 DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Thu, 3 Oct 2024 20:25:21 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::be) by MN2PR01CA0030.outlook.office365.com
 (2603:10b6:208:10c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 3 Oct 2024 20:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 20:25:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 15:25:14 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 15:25:09 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: not restore userptr buffer if kfd process has
 been removed
Date: Thu, 3 Oct 2024 15:28:28 -0500
Message-ID: <20241003202828.29433-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a883db1-6085-4269-996c-08dce3e980c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uhx7M06enBCPSNgun+xnqeKS5X2Axp+M//JCFITnrkqyjLCjySH57Oivpqjh?=
 =?us-ascii?Q?1cV8APP0hPSgJckkMn7ilSsgRzt/5HkvqCrYKVyvJpknmAi4APARJvXC/y5P?=
 =?us-ascii?Q?nVB/KABS3QwlTF2t39VYUoZ/bja89HbVnBfdWUCWHG6Zn65xUVDM9/WmLiMs?=
 =?us-ascii?Q?kjUb/82FA6nXE0jm3JL0KyezErO76mkCTMDym0XB01V8M6CK4US/yGRLYw/Y?=
 =?us-ascii?Q?nwUKjzc9PxOqbTvdzZRtiVG+5LfrapXxWu7D5asVLL253ga6Q5J+tauPBpWd?=
 =?us-ascii?Q?4B9vWtXERcrs3m3K9z3bfHERzswPHAc0MSpntJYSeyvBMqXUEuZVKuKMRi8D?=
 =?us-ascii?Q?YQHJExzm6sYk9sJnR4WSoH3sNJ3YfkiSohi+wQgzYnqHxMIdHQZWzqtmP2t3?=
 =?us-ascii?Q?IeRPSq7Mf5GjrbYn5I/4pCQxaNNKy8hPA/ELTMms/D5xjPEtN8L1TWMbmpoD?=
 =?us-ascii?Q?FSH1S0C9G58DIzmpL+/1rAMbVA6AJ1g3JGAxyPlZpKs+Mo/QMFB60qHytV9s?=
 =?us-ascii?Q?JJaRzeWjLv5F6zRxBMrrARv9dhwPTQL7mT7/wzJV2aLUzMst/0bKIMvvxMfH?=
 =?us-ascii?Q?3Q/oWv/RpWgnbMgjYy/PApEJ+u2ZRp6WneK8275Rs5GEZ28HwfnsJ3RVbIUV?=
 =?us-ascii?Q?E20hrOf+EZjI2JtPo8/2jffqacTnX1Tuz9k68ImQUdQcl0Y7/10fJ01DfixZ?=
 =?us-ascii?Q?0ewBlUpcKj67cMjrMnO+B7Z0t3blEN6MhQGIzgehnui0SWtfplARvpzNMlLT?=
 =?us-ascii?Q?vsg+vxdepMISDnu0k/t7dSrohaC6U4bDRFnzROK4jjhHRV43WWFWsQgMbVmN?=
 =?us-ascii?Q?p/2p+W1zDUFYjRTWMv4OHDxzp/CDCqpw+xHzbYGcAcMSzxrn4wlSIuJ2m9hv?=
 =?us-ascii?Q?hwwkUZX3okoxvP19kVT0+h7j0T5vRwxzVOr7Na+2VjzEMF0mkOwdY3mKRApr?=
 =?us-ascii?Q?KUV2KM06sedCqhPHTBdIkdxqzNTLLAetyDY0RCBugjizSMuGORf3d/pmAkd1?=
 =?us-ascii?Q?BLILO6pMPSYL63lTLh0YmgdRFbR8EixeR6RHr/pxvPoww+HJknBNgVNPureu?=
 =?us-ascii?Q?Vgmjd7aV1ikaHHe56i+JFDifXxobTHxlvOpvN0Vly2KP1FqtUlpsBO3q8/W6?=
 =?us-ascii?Q?F//3grLvCtUI+VtyrWJ4YMOBD7eYPynsDW+oKRXLpfycc8uizWZ3Mgb/xiJQ?=
 =?us-ascii?Q?c//54V1GlLKIQkr9IF+eHY0NaAUCLCuuEb5GEynOmdFUBm1YPe35xsrBzKrJ?=
 =?us-ascii?Q?zpjled5P4D4P7YBTCFazChn1TV/ztcJjGPtbJQgUmRlVwLRYUdeuqYd8g32J?=
 =?us-ascii?Q?yCdq5UdD72W7+B881vNrm7ZzuFEuolVmTkoSLxgF8lggzu0QuGFEZKRcFg6h?=
 =?us-ascii?Q?tdxxJq8QHNSnM31L0e3pQajhLJui?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:25:20.6239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a883db1-6085-4269-996c-08dce3e980c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When kfd process has been terminated not restore userptr buffer after
mmu notifier invalidates a range.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..dab4a6a74c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2524,11 +2524,14 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 		/* First eviction, stop the queues */
 		r = kgd2kfd_quiesce_mm(mni->mm,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
-		if (r)
+
+		if (r && r != -ESRCH) {
 			pr_err("Failed to quiesce KFD\n");
-		queue_delayed_work(system_freezable_wq,
-			&process_info->restore_userptr_work,
-			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+
+			queue_delayed_work(system_freezable_wq,
+				&process_info->restore_userptr_work,
+				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+		}
 	}
 	mutex_unlock(&process_info->notifier_lock);
 
-- 
2.25.1

