Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D80A10ED655
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 10:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E52A10E3A4;
	Fri, 27 Mar 2026 10:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qBGXGUsR";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46AC10E3A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 10:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj0PbA01NrsTi0Sye5AznpFoUW9xfzJgScqXnUwFwRFi/JPmyWfCXb7OoH51JqTHapSKalKl7YtE18H8ctsgXJrppujTF6wczlqGHaJIHBcaNaBccgWobDhU2W511GkNUE97xbwTMa6U0UZYAcGNUAnZ7vA0ANVky0UiQzZR6efO3GtecVGmGOQPFVKcBTsYli3CEknqTPstjNdntz807u1dbicG4zDfG6s6YDh3ZXmw+L/rOwolGdd+r7i28f1PPGr0Akt02ft6OAxcQn2KKPqIRPG48bYLYU5uYmOzVjmaatUiwfSt3m1FsclYcmZfCrzxjfrGGCceO0mdSh5haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtV1k7QtHwByNElYM9mPnmrLSKUR+qrlDMEOYs8O32E=;
 b=j6F1DBh1lATJZDPDbf13mB6LN3lVVxGup7sk3tjfBqTLp5+cL+45ZxiHIgUf4+qhibIeaZbc7yBa6NQm0t+eVnb24Qo4fz02O7p7YjIuUHX438rtTAgrArwMlMg2CJyuT6c/pefQ9HuLdlktKMEx8GA2AXWWxkbBH+wnTdgMhzeLQ1IvdCRCVMtUGXES+8VtSCoQ1DBoWfljCs7iBADNSNk5BEoCLlnzMGYAM5XvrPGUkZqI1UVMX+9B13j+57LAGcRASBO+1J19NkrtpnIepxHrTK5X3r0Ol/WUeQtc4RlRoMsOmez5IwE4lxCQV68p3wTW2LM657ty0tIh/+7yVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtV1k7QtHwByNElYM9mPnmrLSKUR+qrlDMEOYs8O32E=;
 b=qBGXGUsRinzfFuIdStNgwED8axulRjbI1xO6X6gGqxRfFX0Q+p8/oWULqpUqnJgZGClrAmfcBx/C5wE7q0VxM9kH4Yhrg6+0jUg6Z6aV+iikB0uzCJMNU5UTvxW95Wfjc/WdUisD+0cQmsg5y1VcUGiLXbVhFFns8/JLpvcqdg0=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 10:40:04 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::c1) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 10:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 10:40:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:40:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: make userq fence_drv drop explicit in queue
 destroy
Date: Fri, 27 Mar 2026 18:36:21 +0800
Message-ID: <20260327103621.3374979-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327103621.3374979-1-Prike.Liang@amd.com>
References: <20260327103621.3374979-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f3ed4a-ba8a-480c-c50e-08de8bed34af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: O35Apo73m2/cctNyT7ONkE/B22Z0r8yAsmGepI98/p5gShqVaGovtn9IL9yqYHfl56/79C2DDn28DtUM4OMLFOJGklJxEJjD9HRcFLENrt1K0r4C/wteYLLvWWsKpJxTHEnTQTcnxu0yZCGi9p7NWpleq7xiJyw0lKDok9+tSsD2XKcn6lDaox7G1Y1RG5Zda++yTheSg0RZzsoXFDuL7OKpPkGjHFoOxg4WS22HyGhzV+jfH2i38H7KgHaMLYXFzQxZSDwHPAjouI0hy0er1Vn0Yml1fCQDTgfsz8CedXxG7PWpxPk7kRs44SBI90E7wf6jfC8u4VpYpGhMaiIZiUFbGkRTymi2zIoaN39NUaiWY8WD0IN6M465OVv28cJvcz/7jN5eGW7qKMXa8TASm6NUwYeocIDLeDIaeVPECIbnpM6HYEfU5BZhjUrp09BoSs6uDQOCKPuxq3Ddh+Ub3bO9WfLcXXEqA/YedhV7/2M95s3JaUhu7rSWiSP1KrLaVtBACqMEBw7YuFDwEvqyPXlLsaFCudQCT93r/BubLDnbimMRk/y4ELxe3iY7xg6wKXgSvy3GgLAf6z0DDOvCQtnviNmtGape+oGTMQ2GiRfiUo+A1obxoFgYIcg7KJxfkbFBlwaqQBu+Q0l4Bh8GuD7LoRWm5gdXBPpYRY+hBZrYpBGIYZmFnvXmg5YEIEGgLJDIAo8/FAze492TNLJeUvOxuj9vaNyNJdJSw7/BvdaM7FbmtNX64Ud0kL8UD3U5N9L4kWDmH277cACMOFW0Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: He/f5SR7Uj8srRzKJ3CF7+/WUfoPe2pAR2v1H+i2PR6cGmr0adc1F5F4dETahO8vrtXD6l545xmft2b9ckTwM9CWN74cAL3Q/T2F467ar5DF9XWLEujndTYF41dlysozUC/jOwenwC/dG3tnWZrvQPFmbtebpK+dn+s8hZ2guET1mK9wsCD/6xTIkCrfAHAwEWPK7D2cFHJ7/gN1aAwhW+8+cWZWJmRIBB35wUM+5VA2/20RT8M0TmVggRA+UIchBFD8Fcy1pZOWoDNy7Dw7tzCGzE/szXg37jO6H/bzWBlwQ2Gqp6qq5K/KYAQPoq0x7zeAnayx1bJdJe/5CTddog/32iwv8WRyVhpqRDKKfSvdftAolkQYl75SGoFaK8VSOnlp1aQCQDxdZzCgbbhCE37xXKv6ScVI2/+bYNbLbobNc6hs6Z5zQHMYBIpXrFkl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:40:04.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3ed4a-ba8a-480c-c50e-08de8bed34af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

amdgpu_userq_fence_driver_free() is now responsible only for releasing
per-queue ancillary state (last_fence, fence_drv_xa) and no longer
touches the ownership reference, making each function's contract clear.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c4841df80bf8..d676f2709a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -459,6 +459,9 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(queue);
 	amdgpu_userq_fence_driver_free(queue);
+	/* Drop the queue's ownership reference to fence_drv explicitly */
+	amdgpu_userq_fence_driver_put(queue->fence_drv);
+	queue->fence_drv = NULL;
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	queue->userq_mgr = NULL;
@@ -866,6 +869,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	up_read(&adev->reset_domain->sem);
 clean_fence_driver:
 	amdgpu_userq_fence_driver_free(queue);
+	/* Pair with kref_init in amdgpu_userq_fence_driver_alloc */
+	amdgpu_userq_fence_driver_put(queue->fence_drv);
 free_queue:
 	kfree(queue);
 unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 87560c1251d8..a392ef9ba5aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -134,11 +134,8 @@ void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
 	dma_fence_put(userq->last_fence);
-
 	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
 	xa_destroy(&userq->fence_drv_xa);
-	/* Drop the fence_drv reference held by user queue */
-	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
-- 
2.34.1

