Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E61C31D97
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 05:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B5110E718;
	Wed,  3 Jul 2024 05:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4x9lxpMc";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368FB10E718
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 05:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7yXh0iBdaQ0rYkh21m58Y4d6kfrmD9xzhoaJ4V8UsETw8Dkde0ViTcDy8SdkSXUc7C+vN3DVMW8lZEbyGnmAkR+l4ucDLcHvEfXq8y63w+xZpKqlBWAeFCxKP+ulBaa9vAEQXUX9/kbsPjqZvMVOqHNl3VLI2dFhbUBV4R3wXlQinlZefOVf0gC5dvbFtfE9BXE/j5g+fr3nVqiQnDaeYWMkwOL0uvJxT6e5qtf7C04HA4cq26HeY9Bg+XVK03CEiTTqWMHr4oodaadz9BkdJyyX8KaBB6x0tiFy3K+UcKwY4TwlnhoYtAjjXgPIMMA2myBGjUNCqXkT3epIQXngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVM+1VLj1RxENM/bNsAbGWkyaHly3TTjZs4KxI5YGCA=;
 b=kcKiIcjSRZXi5HsqODbBGySolCSwhWSDmMQSBSnlROw8mx9Y3eSosSKmzGxUJsHGb0t30lTT78Yr+2VtnTZHoVLMaJ2QikuYtc1WFUbsK4Ur5upLno1ON8AxY88jmTtf5bwY+wqPUvPJ5u0OyBxlPNhlWHVjz0rtALXR8jN4QY2cLoAeXFWukuI+kh4u4iqgtOHV2tL8vXhPxhU/24RbvgedUJR9v1kM4RqiifKF9BurFKgwYKompAqBShWJAoyzrZWAbzZo9Xy9AZLaHS56dtIw0wiel4HF8LR/Bo95f7WW4aRwwwy6VHYqFBQM/ntT4S5lQ0N/xjWdVxh3AtmD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVM+1VLj1RxENM/bNsAbGWkyaHly3TTjZs4KxI5YGCA=;
 b=4x9lxpMcI2c+Z8fuVoGnAJFNEkSjCkAvrIwqzklnOXd6td1XjZnqbwpYUCYO80BXML/KhpEt5knQZWKGjwnWW0lKc5iQPnjyLEM3adRA++SVxjqGfLnRDVw/P8W36cmpRVehabgDLxAp87KhzngDudMcdCr/8/wH63CYcCSPT+w=
Received: from PH7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::34)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 05:52:16 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::7d) by PH7P220CA0002.outlook.office365.com
 (2603:10b6:510:326::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 05:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 05:52:15 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 00:52:13 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id support
Date: Wed, 3 Jul 2024 13:51:59 +0800
Message-ID: <20240703055200.1610956-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703055200.1610956-1-kevinyang.wang@amd.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: fa15010a-b43b-4b7e-d6e5-08dc9b244b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wd2czxAKK+xUFz0gpJh/+2bNGFvLMk0aNnsiRidMmVnLkLwDJFXCGf5cx6Fg?=
 =?us-ascii?Q?iBUF3SzVH2jv5tXYGlx0dVdbCdPwblRQBqagCcYmtTgimiehmqNumL7gKbi+?=
 =?us-ascii?Q?i1f+y4VGv82rBJHK3Kh5CyKq0RNc+9FAZlK+hDMEe26vdavi0x6CiL+9SK/y?=
 =?us-ascii?Q?IZCtZwo5daLtdi/iPX0CvV38hwHII9n9a7v9I9ZpRAYAQ2s0RZaL+So+nilE?=
 =?us-ascii?Q?ZCYJFc5KEqeLAjaRWjqiZKeQzKVGhdCJWiZXyDWReM1uXS7U7hHnYzap8ZsG?=
 =?us-ascii?Q?xBCzT7QEUtvWxfMhTJfZKmsJFNYwplEekuQKjjHK4qmNCnm8BQfR3j72njcg?=
 =?us-ascii?Q?SVqjjj/jB0x2ovQwHsjGxgYH/W5AuSodfYAwyYuVzMu4hBiFwwXAEzAjNJwr?=
 =?us-ascii?Q?yoYfo1al0Z+pqeUnBaprmuMyuZj3qqml/WBtOWJro7gP12i9fV3IHY8dhkot?=
 =?us-ascii?Q?oxsAhYz0ygdpOKSbmKBbal7fPoilq8xCmGuqIFcKvMUnikPd0B29bn/KorwZ?=
 =?us-ascii?Q?NGrt90ZF7SPqxQLE2sFQelTTfyW5jmqvNlipGppy8k0NndDofkjHpCeNfoce?=
 =?us-ascii?Q?C5xsRr9F6PAqmlEZor2EsUGGCSPb56cHFaVv9fSdUBz8XwDyQZ4o3gF45oe7?=
 =?us-ascii?Q?IWo8Kjzr40dxrHV8/koJb+Re9+Tvu3ncX2QVDUo3PolaUbvprhzQRCKodUkz?=
 =?us-ascii?Q?jikgrp3dISos0wdjpX2hjy0KXzx+pMhZENMQxEdsHGhhAe54HDiG0BdTuZXA?=
 =?us-ascii?Q?+WhL87m8DjaPyRuZFg7vKwt1CzLyKocOiwYsQEFS+Lb6SoRaUEEOhgVEDmLY?=
 =?us-ascii?Q?TTd7q1GhTNJMDjx7KPs1mejFSXxSha9mTdV5eyePE0+MEW+vv3s5r23m5WCw?=
 =?us-ascii?Q?mX7+l7tDwrZZ57sNM2q2AJfhKKVH+Mj9o7vo4ptGO9O2l9s4uV38q66lLOpJ?=
 =?us-ascii?Q?c8S+doYpqXCrte6LWsHRGlPBXb099lF2652MLCKEtAtPPVweC3S4q9RLBPtG?=
 =?us-ascii?Q?kJQxQqCHLFhT22SChof7iCXK9py6e4a79wJC6nklfDc12dFO+EF8oBGirMjc?=
 =?us-ascii?Q?Ki8ujh48yBuCzpI/jO8Et8ZoggzIq3Hs8/vcd2/svWr4oH1lJ110MRuSS7r0?=
 =?us-ascii?Q?bTkWYCqheTUiF+5n0toV946wmgd4n/effviOwUdTOAFVXYbIcXeFD4MAEuif?=
 =?us-ascii?Q?Akanbxuo7fqgf1/cf7gkXGe8JdWYZTsbXC4ZrL9dzZjDGIjjojePp6qg97Kk?=
 =?us-ascii?Q?mpBdPTkWubWQp5N/5JoudUqPMFw0XCJ8yVdJteorH53ERVU04NU1Fp0M1NVq?=
 =?us-ascii?Q?C7NkuO9pgya23xl5dUizZynNnbt4r1+e0PyaVPLdDGsphtoDNfCFeHEuacvM?=
 =?us-ascii?Q?aPorTA8NnU4jTpu6LJjR0OYtSdD4slGhYwU3iueWIf5oBUenkXl88jjeEyvk?=
 =?us-ascii?Q?qL0AdoZLwxEf28OsCS8OTPCd5gqiFP7k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:52:15.8385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa15010a-b43b-4b7e-d6e5-08dc9b244b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

