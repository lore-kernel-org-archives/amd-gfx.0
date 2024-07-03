Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9307C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37DB010E163;
	Wed,  3 Jul 2024 09:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EbYGKrND";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485F110E163
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaItPi7rgAdIgEIwUT7DZXjvqzbtuppI5FdaZwBMHc8v7WrOAms1eX0ngOzx/nVfyoQL5Onq1wJgCix/1Pkrey8S4nD7qgJNuoyM48yFjS62QSzjgEoM8GBeFqQPzEiZfWQa+1P3JwF5hftw4VF7AubVd8KCanMgi6WBSTvsjKn5h91FTQnNtbKdxOwYdrEw5ez57m9GMq+qm4Qw5PQn/Ai6SkZttkxnyhKO091u1lqFRMzfy9Z+e4jeuKQDNrwgJLSCPh+8D/2in1uUfunPgTeN5r3cGNJavBqGLz6IZT0ZPZco0gQXcyxiAS0N4KCgBsdm+a3ih6xPSfAk0FrH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVM+1VLj1RxENM/bNsAbGWkyaHly3TTjZs4KxI5YGCA=;
 b=RTeI1QSTb+HgoUk/JJ98J/9aBY69YzDwH6rgTY3YZC9iyIkvRDrnjzS5Zs+xOuLZva5+UFymPm7RgJrfNrxELvWu299CVAcL/nlXPzG1w5aQWtvHWlA9TdR+1mAIYnbl99HMaiNvOrM0IVOgHK83fp1S34M3L5nsZOHc6uxRaFGBhDPbBqOamcKZT/E9oVd2Bz1wdO5Zz+TLZlesi7VIsDoh2WipOWUNPdlW0c/XVxsMfKfxppeT/bBj2S+Du0Vd00bZCQ7J886nPPeOe8futu95pV8dYBs8VctAmtKGtimUPiaWrKgnspHpkJmqWf/oKcD7Zeso9g8u0tfYoLBfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVM+1VLj1RxENM/bNsAbGWkyaHly3TTjZs4KxI5YGCA=;
 b=EbYGKrNDRDZsyQ2FwWgZYMp8Wxovw8SYRd6FryX8HDAHr88lFl9hSSG+6CUY2c0I71Ow7PdJ1LXA3FD5l+wWSaqL0BaRjjaQc8Ff+JvO6ZdXEwWb+rP+rFSDAGsuKeqTIc7Zk8c8nLiWfe5PshkIDHcGhuA2pZOFCQS4TjqOUBU=
Received: from CY8PR11CA0014.namprd11.prod.outlook.com (2603:10b6:930:48::8)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 09:03:27 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::e0) by CY8PR11CA0014.outlook.office365.com
 (2603:10b6:930:48::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Wed, 3 Jul 2024 09:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 09:03:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 04:03:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id support
Date: Wed, 3 Jul 2024 17:03:11 +0800
Message-ID: <20240703090313.1659512-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703090313.1659512-1-kevinyang.wang@amd.com>
References: <20240703090313.1659512-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccdeed8-c216-458d-3cc1-08dc9b3f0073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KP4Wm1ZuhziWjbr1xx6Rldtk8Fs/SC8OieJRKUTz8e4UCeqyWNYASgo6wg9C?=
 =?us-ascii?Q?mZfflxJjYy0/V6RJMJqbelfbMBnIhEJn8e/KQIrH9yGLWa6PY5ZGa5AQ+gP8?=
 =?us-ascii?Q?ZjsKb2La4cxiD1aHWLOXZ+QkmFYS4t2uvm6NaHgRIUr5Nf1B3Yyx5Ii3APGa?=
 =?us-ascii?Q?lW38kI9Ut+myTfAGPFM8H/Jd2bj78NuS5pXOfCxahs7QtF7lCRayp3BR4ckM?=
 =?us-ascii?Q?aKKsUhWpJ3kuH6/8MKGWnBOY1WvesAAn8F1gD4fORThs7QgxKSI/b2GoEFt5?=
 =?us-ascii?Q?mb1gFJelsTYluuFs+M2eL8Dz9pvA8JzZrPJeNN8/CtdQB3NehkKQi7Vhh6/7?=
 =?us-ascii?Q?F4vL2Yw1fK8W63UwGZkce7qFjYcuJwGIm4gIWNLGNNWTqVMT91uWEZYOqISB?=
 =?us-ascii?Q?VgKCKbLXCaE1GJrqIwtacGEnuavaIsIhVRuAQRBwswtFLgZoTJ8NtshMucsh?=
 =?us-ascii?Q?Aws1MQNFtme+eKkZpqk2RLwFH3tAg7t8tLUmzD1QEPCq1Z0LSoExFZXIy987?=
 =?us-ascii?Q?UP6VNDh/p1d1A1UpxlZwGjC0kYPUrr3L+lBiEJmNZZgX6VGr3eMFo9vScXph?=
 =?us-ascii?Q?nuxDIwVR9nBBOIRXuaGEBoAow1gWtiN1r8ZdD7GesVKn3vP9D+cPPfP0GkMV?=
 =?us-ascii?Q?eclQa2ueqvLD38Kzov1v4xa8O5Oh5iRvmypaXKbxC0ihhd5PLWDw+bGBQfhK?=
 =?us-ascii?Q?twxlR7d85KM3W01mg0bYv6nSAzMu+shTZkTnTjIYU603/Al0UKrXjGcG8Rtt?=
 =?us-ascii?Q?3nw3jAKOQ76kmm7yn4iTwLGAb5GDlFL4Pa3oVIdNOnyumrqfuW67ECyEzbJi?=
 =?us-ascii?Q?dfmuFKREkdhT1hWquV1bVH5uo+p1dC8RkDjfEdNZVUAwdFAfBcx3XXqwP4gM?=
 =?us-ascii?Q?uYaJm6tVDBC/GampkqU8K+r5mYIYx8ZG1d/2XHB2M9FnJKaY7Lqwr4925ptf?=
 =?us-ascii?Q?3HnCRw/OUIhFAij7LSGttvdmX5nCZ2cWgodxu2EbixtErHKMvh3u8LLryJwA?=
 =?us-ascii?Q?CqQN1lUqMsZ0FMYNHCK9DHoaIUpSwyfto+SFlEDeTYOdRnlFChCUQdpQtptx?=
 =?us-ascii?Q?qoovmM8sJzEMvtDKXjmp3VkojafR5iU3m/l0Nq/jVbtgFiAURIyGu0NpomRk?=
 =?us-ascii?Q?1fye7a8MLC0wi5cq+o/m9eqlA1YtXWLEbkolHtxJ+U6PqDzYznC/RtWHn4GN?=
 =?us-ascii?Q?TxAquHveJjrPJSRazJbQf78pZozjK5mHewcm5ZZKhPNl7Y4NqwF/CiNolEfW?=
 =?us-ascii?Q?rd/p0PAFV2X9HFV81MqtgSbPDNKrigQlvbSt3KZqIpl5t8uTsbxv0vNP4FK3?=
 =?us-ascii?Q?2ue05eFfFmsGPximbDe1nWTfObCZ2hpL4/hbdNVXYQuK21dFyXS1kRq82jSb?=
 =?us-ascii?Q?lWe4bV9qfOY+IrJoI4ncX/GHgkAFRbS2Wfc/dwIyi8NBRVI8eeFyB9hThsH2?=
 =?us-ascii?Q?IQQ2uw9frU47InfFoJOWx/W++LwbHKcV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:03:27.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccdeed8-c216-458d-3cc1-08dc9b3f0073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

add amdgpu ras POSION_CONSUMPTION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8a98611d2353..11f8c37a97ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2076,10 +2076,17 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
+	u64 event_id;
+	int ret;
 
 	if (!block_obj || !con)
 		return;
 
+	ret = amdgpu_ras_mark_ras_event(adev, type);
+	if (ret)
+		return;
+
 	/* both query_poison_status and handle_poison_consumption are optional,
 	 * but at least one of them should be implemented if we need poison
 	 * consumption handler
@@ -2104,8 +2111,10 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	 * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
 	 */
 	if (poison_stat && !con->is_rma) {
-		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
-				block_obj->ras_comm.name);
+		event_id = amdgpu_ras_acquire_event_id(adev, type);
+		RAS_EVENT_LOG(adev, event_id,
+			      "GPU reset for %s RAS poison consumption is issued!\n",
+			      block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
 	}
 
@@ -2498,7 +2507,7 @@ static enum ras_event_type amdgpu_ras_get_recovery_event(struct amdgpu_device *a
 	if (amdgpu_ras_intr_triggered())
 		return RAS_EVENT_TYPE_ISR;
 	else
-		return RAS_EVENT_TYPE_INVALID;
+		return RAS_EVENT_TYPE_POISON_CONSUMPTION;
 }
 
 static void amdgpu_ras_do_recovery(struct work_struct *work)
@@ -3975,6 +3984,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 	switch (type) {
 	case RAS_EVENT_TYPE_ISR:
 	case RAS_EVENT_TYPE_POISON_CREATION:
+	case RAS_EVENT_TYPE_POISON_CONSUMPTION:
 		event_mgr = __get_ras_event_mgr(adev);
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1343cfbc913b..6086da67fa4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -433,6 +433,7 @@ enum ras_event_type {
 	RAS_EVENT_TYPE_INVALID = 0,
 	RAS_EVENT_TYPE_ISR,
 	RAS_EVENT_TYPE_POISON_CREATION,
+	RAS_EVENT_TYPE_POISON_CONSUMPTION,
 	RAS_EVENT_TYPE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..8a10a0e42846 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -27,6 +27,7 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_ras.h"
 
 /*
  * GFX9 SQ Interrupts
@@ -144,9 +145,11 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
 	enum amdgpu_ras_block block = 0;
-	int old_poison;
 	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
+	u64 event_id;
+	int old_poison, ret;
 
 	if (!p)
 		return;
@@ -191,10 +194,16 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		return;
 	}
 
+	ret = amdgpu_ras_mark_ras_event(dev->adev, type);
+	if (ret)
+		return;
+
 	kfd_signal_poison_consumed_event(dev, pasid);
 
-	dev_warn(dev->adev->dev,
-		 "poison is consumed by client %d, kick off gpu reset flow\n", client_id);
+	event_id = amdgpu_ras_acquire_event_id(dev->adev, type);
+
+	RAS_EVENT_LOG(dev->adev, event_id,
+		      "poison is consumed by client %d, kick off gpu reset flow\n", client_id);
 
 	amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
 		block, pasid, NULL, NULL, reset);
-- 
2.34.1

