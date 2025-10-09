Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BF1CCA470
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 02:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC4D10E129;
	Thu,  9 Oct 2025 02:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OGerG9/0";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A21110E1B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 02:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOqg8Urcge+6Wmq+zd1rL+fIfUxB/Mft1WLD71FaO8WcgJVMcYVpTsi+NUJn+glUef+EcnWSQbOYsfquFIBRUCB3FM9O+lbHpctcS7AFj55g+XKmqwAYj7RVrt2D/LvheDLg5XDdBmLdYR6aN2dcTb51W7gyzoStHqIt7l14buhzewQaK5OdBCZ5Xouv8fiBJZcP6AFp2gMqrgyWu3SbSdjEBaEO3MUnWVIPV5ALVaSY6Jualy4M3v7Ewd2ZhTDpFy30s4igghAP0X80+J0lmEHx79knnsseMIseXf7uDVv20G/wbubLMHYGX0kmZzhXKEL4cbO5yGpC8xcxiVLgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ih4s6xNv6aifKbTgurQpUzJ+qYS55ZhDola+kmGqVU=;
 b=wwSGln42/gBnlsWGNyr1vkUZrTbkla4SUTHSAOyFwek2QPQ/ET4cpO70Kphd5zFQnFa/2V3Nigd0HhsFB632nl8twOorJglMB1EwqM5wesNuw0mqYNo9V+16LOIpyyctC/oHFZUx8x/B7lunvHRzUrj5hkLonDf2raqb0InjI5eGnOk01wYGqosw6WZ6ivkS/qkbiJERpdu2QT2wShp94+uhn9CqYlB+eAaBlg4vWMrgvT/O+DLRjFhoM82uVtx+tlFs6auNFMlQ6WLwFa8CRn0HQW9gWDaBR88SSWTit9hLVlcB0D968zPUXLQ3xDtcgbW2vWL9KjmDyaR9kR8Tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ih4s6xNv6aifKbTgurQpUzJ+qYS55ZhDola+kmGqVU=;
 b=OGerG9/0jPyduYZ42E5ue/iRFoX5c0DyngsaPeEmQfrP/DoA1Xt+uG4DyaDiWMrfLuc6B9+V1z2uXKQCxYMJwYyQ3sxLVk8q2eQulID4OEPpSWzuQr8boSLoJgT3146Vmne6gFKQirKlz44hNhImo6Kt+hCMsjurRUXyGmv073k=
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 02:48:38 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::c1) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 02:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 02:48:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 19:48:37 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 19:48:37 -0700
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Oct 2025 19:48:36 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add kiq hdp flush callbacks
Date: Thu, 9 Oct 2025 10:48:21 +0800
Message-ID: <20251009024822.3973163-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a685d0-9bae-4a59-b574-08de06de5916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XeYgpW2Ojcx9bPNImNg/VQlRxh3Dhfj8HaPggffOvEEHIIPqoNkbMZeislCC?=
 =?us-ascii?Q?FczqhstrakQLc8bw3pwYrzfUugso7BY6Bi919viyHwyAy2ER7a/wWvJgnFy5?=
 =?us-ascii?Q?OJ1ptmrH3UA/4qTFIWJB5LD6ileL0TVs/WkD8JGagwu8Icxu22vdo1BRW58j?=
 =?us-ascii?Q?bhL1TPKBEikqCIN5yjSwOgp38LqREmIPB/5FTRB48kRF9qJG4zOZQ5TT790R?=
 =?us-ascii?Q?UYO04xhMip0ASPl4LG5DODuidEQV209pTp4OSPCllmnTQlrzk4cGYxf4M+sv?=
 =?us-ascii?Q?rmUsj73sEhX9f1CspZfNVTtM8EM/ptvWUJlRHHN14hCPLwIR7PyBDzQbpe+w?=
 =?us-ascii?Q?V+GyxrBWVocKXQ2LTOWudJU37tR4y/gykEHJqRcB2VFOvLA1D0VRDn4ABghP?=
 =?us-ascii?Q?iUbOuTXs7ZGTUl0dLiE6FmNuXHS3OpFPjdXpEJ7rjtxENfkDv6K0/VprmnfD?=
 =?us-ascii?Q?WQf335cn5j1+4pVqLPusZGk5o+Aw7DiHf2ExD4bA0f/6aMv9A5+8oewGovoU?=
 =?us-ascii?Q?XbDKnmgyRStgg6zq4q5vYCje6IQGXmVfETPwUYM2im3HPzW62e2RG+nPg6++?=
 =?us-ascii?Q?LOnh5v/0njXt1nHmpZ5aqnJ9662FUjpzJfek63IDZTVOJH11tpHsA/lvil5M?=
 =?us-ascii?Q?AZb7B6wRxSfhv5eNSy9NDIwGgOIGOQD9lP+AQJZQN+tJF4ufxYkDDUcyU72K?=
 =?us-ascii?Q?Nyv/mx9vxuzpXb6Py/sbyxJ/xZo5B9wZF0GDWA7A/9Vfzf4CpzZf9VV21u2K?=
 =?us-ascii?Q?D00wSFarPmuF0Sfo6u9CKbcAGmpigksjiwk/NlFrb1sV934yZFx71t3y7DKk?=
 =?us-ascii?Q?ZEJdzLo0l3dDAQ0GdKxRYljbWT5TTpCM6mT4fhXHvcHVOXqvcIAC7gpUa4bv?=
 =?us-ascii?Q?9AAL+ROs6yuxBJ7Ctq0pLL6Tx7LO3fkaXGEeF+84UfesuV4knBaixZ+Yi56a?=
 =?us-ascii?Q?io5OTETdTLp2fP6Js5qoRafZRZ0g445yj4Nk2wD3jUhBTit+5uQgLt6Nwn1l?=
 =?us-ascii?Q?wDqspY00yKuXeeqLp+8jZHcsb+AUKCwqfx3+uFv9DhqCRA2/bmT4ds5UMzAq?=
 =?us-ascii?Q?NwdAFXGl2DLraI2H/dK/nd79u0pemzrgFfmGo59YdA7R8uCu4afQNMLhBd1h?=
 =?us-ascii?Q?BeBBBNd6NYujBUQ1rdOxi6wJUVgLnKgmDsXeGQ3kSH+v2wfHtA6yNrA6kALO?=
 =?us-ascii?Q?AJOgQeDjFNAql+dxDd9E1ur9jwoP1ZQqSovHCan74SadcUolGfu2pJvTXNGR?=
 =?us-ascii?Q?u2tOhg6OB15LlDWu1/rUDSEW6GutReD4bTK9zns5o+lAg4ucGkFeK9TV5yjz?=
 =?us-ascii?Q?lGnHJmzaEm6Uq3asTODnM6bnybjD6/8VTNlSxQKSz+09GhEb/CGt4xT3vi0t?=
 =?us-ascii?Q?ZBxIRzETChxkSeOQAUsX6uXl/D2hbQBARvGMSndNslEXmpECtrtZ57E7S+h8?=
 =?us-ascii?Q?cJFPpi44zGg4L0EIifTyMGTCiqiqzJsZFdEQxhWme5dDURBRb5r8YuFsO2nG?=
 =?us-ascii?Q?0OB1VBqbVeMG9YHD9R/6EpNFRx+C/DTB9/Q/RwALMZ0v2SBhBff+HQ9A7pKM?=
 =?us-ascii?Q?mC+FNBUoJRsMssr8Ffk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 02:48:37.9622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a685d0-9bae-4a59-b574-08de06de5916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

Add kiq hdp flush callbacks for gfx ips to support gpu hdp flush when no
ring presents

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8841d7213de4..751732f3e883 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..10d2219866f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..e2bb8668150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c..d3d0a4b0380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v8_0_ring_emit_rreg,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db..f1a2efc2a8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fb5585ab52be..e0b50c690f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4792,6 +4792,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_4_3_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

