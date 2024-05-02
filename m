Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C388AC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24661112585;
	Thu,  2 May 2024 16:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CWugVbcy";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7E6112571
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjp9OBk3QLGTU7TIEaTJExffb5jfKV9KVYDpakAp6XO5JbRE7gNxpAx4yrqXD5z90pP0OHa+NkLB1d2SjsIrP6kSDiMpkadGKG/Sd3HJzJsqYGvqilldernd5uAU2BqQGWCg9LEuLUOfvJXCVLHAClOAQZaqopqQXqmdtVIx2l8cFocVaJscLV7rWVQWD+ZTQggb/0RMyd5TT/d+UzENMIOd4eJTJfivhV2iTRt2CWO7nR3NlpzFB94qd7FI3Zh5mVTbX7JaX9RFSOWUMaL4eX3vsvq8HN7iI95LipulNFZhIkk81uFn/B3WHD6y0xV6e8hH9hW/W0H/hIBeeXBtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drP4OOvwJwRl49NpASrCJ2qUTSYiRy+QyWm6nX2BJzA=;
 b=N1PNyAoC/4M552a8AjqADdfetwjBpywFdXBL/9dqrv8bLBkmNLrN6E6X4S0tKTCd0PjODcljEVUXhsczHVEWZ7+FbdHHebAx9lR9kFPKHzHsqBaA7okUswYD0IVyurE1b8xZ9Txp6jH2YzugWMVXxuOn0F5ct+UMKCZRIlXCyetZz7ZXtpj5b4mLjSeZVBUV6B0Ox3KjcA/h42QYavXB1ba3AXnfNtNkaCUEtVuBIQA3moCVC9/l3inN7z2rhIt1erCkOB+saN5Z5npq2BXyncfuN94xmFAuyH0+osb0Po8UWX6K2ynnDOabxFLoBbilyOSH5/Q7wA0CFRrLaE2Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drP4OOvwJwRl49NpASrCJ2qUTSYiRy+QyWm6nX2BJzA=;
 b=CWugVbcyDNxAkXYFk5jhgwLRYJqBB4HRaCAenL1E6WTGLKLcfhZRyqGFYwcQfe2Nxa9jlzFgPEamr53zWgpUVs05gGO7yeSbMExeuKoEpZQX1vVRSGpHgxlhXVjO58Y2yFz6dNpVsnX865r11RN9UrOLcyvrAm2eJ2q5CMixGAI=
Received: from CH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:32::17)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Thu, 2 May
 2024 16:32:37 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::37) by CH0PR07CA0012.outlook.office365.com
 (2603:10b6:610:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 16:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:30 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 07/14] drm/amdgpu: map usermode queue into MES
Date: Thu, 2 May 2024 18:31:44 +0200
Message-ID: <20240502163152.1382-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d59607-62b0-4528-e472-08dc6ac57a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zvWBEC16nyKu620lurWTtfy+TJWlJjsCFe/UopVqZ4QByK/kL7NKaglaie0M?=
 =?us-ascii?Q?6/mqeiDZFPD8pmIT9KF2c2OhT00hwk90EILyXDVBlmLnwG14ZlkfiYHRaqfA?=
 =?us-ascii?Q?4FiDCntblru20YIiB2n3Mv+L+tSDSCMhbRN5n9CXDwkSKlQGnpWNqIVRqiWA?=
 =?us-ascii?Q?JGf3TbR7devmYb8GYNw2GX9QtM78gPPl6v6clBPcaqChm1PXQ5cC2Kqi6Qys?=
 =?us-ascii?Q?h6nAD4OMrSS89XPek0fXTZK7uS2llUAL9WlDzj0XtsSSEUM0PBz2wWFKejnx?=
 =?us-ascii?Q?eNv7bW4ZKLWELbAULgUV3/57d3GNdBJ49bu8tS0lgJQJWZI3eJleR7rhXbeb?=
 =?us-ascii?Q?eOA5iw0cHNA6PbJt86cmq2UEwqk4cbeUcdy1Ga9ciP8KD2kOUa9t36O5qU1E?=
 =?us-ascii?Q?jrsBDQlyv0vhmYv1SVf+VREvEISTARRCIefrZhVsoRmRgn2Mi+vezIYS04su?=
 =?us-ascii?Q?iDsMT+JUrWuAbSxioStReSOL+OmWHSKGDWBFWJz5e2KI4wZ77BG7DE/mPDjd?=
 =?us-ascii?Q?ZZ2mlOQPKBsgvfICPjjYU/TAVJT1TK95BtJcpDxziM51TkgMNdAcPGIoXGaz?=
 =?us-ascii?Q?mRXlk8fAlsIt8OAubwMNWGFUlZlqcBApbXDZE+lHX6ySkFz73nbM6qtgds2W?=
 =?us-ascii?Q?51cvkvzRE28Be/bgwPqH/pW1K/kwp08v1wjcjQuMtGVWE1s/Ds+RaqrbDUFS?=
 =?us-ascii?Q?8ZfGqEoofZII5R9qgF2R4+bWphiNAp1CQmdSuPB1DQbuHK30i3yvWIPA+e4h?=
 =?us-ascii?Q?FWSQ8psu3JAN+8QktLCX79zawDDwKwlzY4OCRULOlpev1DfiIWBJm4uAI5io?=
 =?us-ascii?Q?WvMruTdGyMo37aKujpaITE78mXtdzNjpYW2oEpCYXgelfZ4aliMcz094ym52?=
 =?us-ascii?Q?YXdFKIGTfs/mc+KzmpeYpmwJQntr6N2ZefTQOI5UdN3HX0XyuxyYQd2SkWWP?=
 =?us-ascii?Q?DKqYCoAxZRmjf25LcClF5H/vnVSsqQIZioyQ2slwBiEZW5Oh0wdkWasbx0xA?=
 =?us-ascii?Q?WiWILXZRSKDDM8FzxaaArCKjlz2y0zFXUAlGgJPW6SjadlNClLn85vA5ZoTb?=
 =?us-ascii?Q?jaOgy9h2Drvy9Ae/RPNzq6lh2kZrI8PV11WymCMyt3g9Ub0oZQTY8LOzpHIy?=
 =?us-ascii?Q?5PZ+h9y8466hv6WW4ZUZrOgbDeqs2MFRfhgqn6qTgGAZyfERInCLhLRaJsyd?=
 =?us-ascii?Q?SxKgeCczo563J9azVqFK+USNewY0yms8CaYe/QAK00eOH6SllJ/Hf3PwYMEf?=
 =?us-ascii?Q?jjje3j4AALsQMLbZlgEnK3Wk1uuhPndjbKeyzmGOOcp11TZAZj+sK7ed7Y+P?=
 =?us-ascii?Q?M7SSS78rqUrAuqsOugguTMZp7utX0h8EMwYz5gdyEqbVclYXh85eyS+fe0/Y?=
 =?us-ascii?Q?4WKbBAkS7mlwDW3TrT9Lij21djmS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:36.9437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d59607-62b0-4528-e472-08dc6ac57a34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

This patch adds new functions to map/unmap a usermode queue into
the FW, using the MES ring. As soon as this mapping is done, the
queue would  be considered ready to accept the workload.

V1: Addressed review comments from Alex on the RFC patch series
    - Map/Unmap should be IP specific.
V2:
    Addressed review comments from Christian:
    - Fix the wptr_mc_addr calculation (moved into another patch)
    Addressed review comments from Alex:
    - Do not add fptrs for map/unmap

V3:  Integration with doorbell manager
V4:  Rebase
V5:  Use gfx_v11_0 for function names (Alex)
V6:  Removed queue->proc/gang/fw_ctx_address variables and doing the
     address calculations locally to keep the queue structure GEN
     independent (Alex)
V7:  Added R-B from Alex
V8:  Rebase
V9:  Rebase
V10: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 58cfc956cddd..874ea3901319 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -30,6 +30,69 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
+static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_mqd_prop *userq_props)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct mes_add_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
+
+	queue_input.process_va_start = 0;
+	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+
+	/* set process quantum to 10 ms and gang quantum to 1 ms as default */
+	queue_input.process_quantum = 100000;
+	queue_input.gang_quantum = 10000;
+	queue_input.paging = false;
+
+	queue_input.process_context_addr = ctx->gpu_addr;
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+	queue_input.process_id = queue->vm->pasid;
+	queue_input.queue_type = queue->queue_type;
+	queue_input.mqd_addr = queue->mqd.gpu_addr;
+	queue_input.wptr_addr = userq_props->wptr_gpu_addr;
+	queue_input.queue_size = userq_props->queue_size >> 2;
+	queue_input.doorbell_offset = userq_props->doorbell_index;
+	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
+		return r;
+	}
+
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	return 0;
+}
+
+static void mes_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+				  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_remove_queue_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
+}
+
 static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 					    struct amdgpu_usermode_queue *queue,
 					    struct drm_amdgpu_userq_in *mqd_user)
@@ -121,8 +184,18 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Map userqueue into FW using MES */
+	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
+	if (r) {
+		DRM_ERROR("Failed to init MQD\n");
+		goto free_ctx;
+	}
+
 	return 0;
 
+free_ctx:
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
+
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 
@@ -139,6 +212,7 @@ static void
 mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
+	mes_v11_0_userq_unmap(uq_mgr, queue);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-- 
2.43.2

