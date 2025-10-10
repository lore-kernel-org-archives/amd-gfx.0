Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD56CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B2210EC84;
	Fri, 10 Oct 2025 21:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bYxamRTQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A81810E188
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd3AePdX/yUG+XFTRKG9e9fr6MEPnDWYFCFz4og8GN0duI0UtYu1yJs+HWGsJbePg33mDBd3KzeXbA/NAi0MyR+Nj2TkEWAIAJ35uIJIgqIEonvDKyEoHtVyzSENAvpIJ7RmxAnLqcUk67ofJQlpQYH69UGi7i9Mfj9FaA0gpuL29VMbDFwhMlJKmKHAwRX7bvZwh2J4VoVXaQATcg99MAQAw2nT1JJV22LJyYS3OPfvH8olLKGgamglOUTtOCAIdQ1Aq4bdswxqUt4/WPv3dsh4Gdw4KHnglpZiQrt0YIakUPttHIfUYpjC4QoDq8LwCil3oMiw+BVeB7GOboHnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbqhj3RuYvqVTlC3hykaZGHxeND7Pm5LDeJGGjTZnWI=;
 b=VPWDeg9IwWL1cebksjAFWCivf0/kT6yhO+lCG3IjvuC0Ut0Po12F/YP1EKQGQ1Cad0Y0sHlfCoFPyEzO0lWTdIllle46tl6uFnvD5qSfB+0BeA/Qw6tt9hBM/SJjyldtp7YAzZt1KWiKGDrc65uar71zS3MJysWthVOSfw1gEnAlzw0J0E6xUEHWUNTip1u0ZamQ4d9QIipZ/Cu10xZZuJoaJ16b8qAgKLlUP211fAt+RGrmVM5W7KRTc3RaVdMuor7j7rHclAw9aTsPLaD7qbnb0ivYBIIo7Z+mr1zYRDdr4SsBAWvwVz+EM6l3PD/omX7PQKyQgv/kyMn6dUqXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbqhj3RuYvqVTlC3hykaZGHxeND7Pm5LDeJGGjTZnWI=;
 b=bYxamRTQ7HpCL1t60ZYpNjJrsgptUnEsGyBoXovNZL0//k+1Vl+kQ87FP9ZEznxqm0c4y73mF9XoDVm+CZbIDJ3Wb3pSekeRp9wI3w/+tjxAZUC/zyZWI/qV5hfNM5h/EKTvWnMse3MsSStTnKYGaKqdRgIfLvFGYQv/HRjof0Q=
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 21:15:42 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::ec) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 21:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:42 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:38 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/userq: fix SDMA and compute validation properly
Date: Fri, 10 Oct 2025 17:15:10 -0400
Message-ID: <20251010211510.1528572-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6311f216-e1af-46cf-b4f9-08de08422b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kt1jMzCvbsjvn+EffPBRdX2uOodQ1TQwPscMCk7KCU9ddFr8Jb8ebETPU4Ql?=
 =?us-ascii?Q?kBHysD8sT+B+xPnsWHPwIZZLz29LmU1JWC/URO7/U+AyVuv8hJVUiCOOEmxn?=
 =?us-ascii?Q?THsxr3R5O0Pf/IuBewOpG0JSSsjRu5pVy6SNcdFECwQ8EYJbWFMfDn/nC7Bk?=
 =?us-ascii?Q?Ebh0mbHQdOxlOvKyq/2L4yoU0ezAha8yE/GalG4bFNzlHeTEwH0D6cSzc0+D?=
 =?us-ascii?Q?fKf72KXjQuXwTCnb17GOkLUJzH9IXwrzxh0YoqmlTDos3inkBYAkLriz96qd?=
 =?us-ascii?Q?U73ug3zHF972yNe4fzKQXcieYLowdFSSJDVMeabnMkCkqt2Eq676zqUobMeF?=
 =?us-ascii?Q?U9e77Pqtr/UDfpaZKNDo8rEBlgQt0gQfj2Ld+5p5KrEyptycBC1mmd5e5sFb?=
 =?us-ascii?Q?efb1q+/CoNkjhzgUp6yvOGSwHX75ZRS1OrrB8v/JWVkETQpHirfEcwETwqme?=
 =?us-ascii?Q?bSa5UQFmSNqadnwpNXTKonj7V2H4P8teEsFspWP6+7hEeMKtOEvM6W9QfoO4?=
 =?us-ascii?Q?IYvsrDdDzjM3CDFOha5rWUqixtkrnGFBAMYSx//CSIvfuU/LtAAKihbaQViD?=
 =?us-ascii?Q?BDgCDYN8jjnwuKiGhSsGiY5gMiZE/e6YkJ/TUDL8J7llhKz9FrbyZkeSEc+F?=
 =?us-ascii?Q?5PWiv9mxw6hXn/tiuRigGm8iPNR2JpNrc+9dn2gggsG2mY86aDo/jI037eVC?=
 =?us-ascii?Q?h9DLI5XzN2NCYX/rL5zrh32U9vbsewCzf9VI9Bq9IvMvoZv1ntHyB4By/dMW?=
 =?us-ascii?Q?Bl8PavMbqmzGfGsFjRotMNRTTqy6Mw65JRICA2ss/LqLthLTJaiMptgxLDlL?=
 =?us-ascii?Q?DDI0Qv6wePSj3owVmxSECyiwhzE5AUhrW6NBNAHoG/CEgAxkeRoL84/zEkTs?=
 =?us-ascii?Q?uR5DH+xXsFXMWjaux0Rde2S+Q1sO66ZQV1/amqY9sMiXJ2tYKac6jUe5JbOU?=
 =?us-ascii?Q?vjbWHiADUyvGFC/TI44IYZqorv2YuzHFkyGPsi2+s+A4Y1MCjV1dIjcqYYiz?=
 =?us-ascii?Q?+EAIQEpqgtvTwMoL6EF5woDTCJCp42DML2HclI62pHN35johkTgAhW4L4BAp?=
 =?us-ascii?Q?Y0ssLkTDjsB2jTCCL0YPRZiqoKtzGNvkuRS2z1Xs/QLhh881H/xpIn4XWzhR?=
 =?us-ascii?Q?/TKKTlpE0XcWY7SBjo7BZ2VZvUqvkClYjEWQ3I/3EvAIrC/+tSM5klg77XwI?=
 =?us-ascii?Q?/eDwl9E5mjYgXoGW8lABeFprJgVCogl0+7KyvJDpCZpgbqyxUIqNCW8m+ASB?=
 =?us-ascii?Q?g+zda5c5sUE3htd/zSMPv1fYprwVjeroukmrTYpnEpDtYTMtC7+k35YGVy9B?=
 =?us-ascii?Q?jqLxC4GeJ9l5aCOc57dOxU7OBVfb2q8Kl8tEuxXLrDZXBAdfn3k+QnvOqg8f?=
 =?us-ascii?Q?DTw10CchGENvMc2qj9hRC0TW/4wdu7uCMcog/+TyeztSnkqhvNSpRdqdQy5p?=
 =?us-ascii?Q?F+/z8LFWSA6SUmV4rKCV4GG7tZl8R+ml8s5R7U1wGhFajBbi1t9AMUY8Rh80?=
 =?us-ascii?Q?WlqR027btwe67XrnxP3jX3DntnjLM6sTCIbYcS8JJ8Hqf8IrMkl8zHoClC8V?=
 =?us-ascii?Q?nMJErr2QMUdRn8p6V4c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:42.3188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311f216-e1af-46cf-b4f9-08de08422b9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

The CSA and EOP buffers have different alignement requirements.
Replace the hardcoded sizes with proper queries to the IPs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ab392de2a2388..17a386969b663 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -281,6 +281,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_gfx_shadow_info shadow_info;
+
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -296,7 +299,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
-						   2048);
+						   shadow_info.eop_size);
 		if (r)
 			goto free_mqd;
 
@@ -343,6 +346,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
+		struct amdgpu_sdma_csa_info csa;
+
+		adev->sdma.get_csa_info(adev, &csa);
 
 		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
@@ -357,7 +363,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 		r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
-						   32);
+						   csa.size);
 		if (r)
 			goto free_mqd;
 
-- 
2.51.0

