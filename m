Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D33CD3445
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 21:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D73010F5D8;
	Fri,  8 May 2026 21:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvo05bQb";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A78110F5D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 21:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL/qPebvkUUWqrx9g9SVZgdfXLySeEjTLIOjvTgt6vkcuTRWQZbGuCWlqlUHwx/H14vQzKR78pQZNaGP+Yll7RHAEnAA+1PWT/J8aKxbDRoC3cUgK1SFvL/57rBB46hEFlAUaYvd5gs9tqj6mJA91dPbMzW3xxUl5YgiqQ2IiBUVK5IOdo8+ouWvpt3ygXU8Hsd+IdxO4Rtz0fo941clhgTyCS0UCyphY3mTQQm2tMQ/aD36f/ClIyUpM6ncqPZHK8R02MuHfe/JY3en2U93B1XYiotMJbp5qEjGjiUYdcnBXLMcLBQTGpK13pN41SvXJl0p8+djcn4im2Y5XXX/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCUgsFN7sVObhcHii1o1p21pfaTgUPMPvBAHFXXUD8w=;
 b=oxfTfh8C3W9V0WnzcfEWS5rXdJZ4xzpStVQlwXJk8DiXlRHcaSN7eiFYeR3BxyGJd4XGhpig4XvQVSkbu0NQGj6VlLrKOKGV3LCIfBxw8hKshMslrOYIESZeYf2sEtBBZd7/bKdN5HhHzIomarVbSbnZ+pd98gGi2uppZgYhjLzltx3nNoKDmrkYTS87k0bgDRer9U9stGpafYGxcIUwGbGLabVBFDe3cgoOdCg9dBsznCh65D2QbA1amfBAvjixEk2oq2MGDDnL2QFhhPlyYvuWTbcoJAdHkjMDM6K6ctNIRKeeMupd6PGxicAZ6P/2MLgn8Ftsm2pjAZRpHl5ITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCUgsFN7sVObhcHii1o1p21pfaTgUPMPvBAHFXXUD8w=;
 b=yvo05bQbbeyQXN9HYV/3VT6f6PM9SBUWSinjqUhURc68oTKrpQpg/T7XFNiI0XQZaY5NOttavTVe0LtFqeiNdXZE4qE4Fz4LRQ4+2h9hEiAmHKdCvrs4ARMaWTuwnPKxZoruLwysjaV9NAQYikQuVxtNUwIYezC019zv7+7cRuA=
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 21:13:45 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::cf) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Fri, 8
 May 2026 21:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 21:13:44 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 16:13:44 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Move mqd_on_vram out of v9 mqd manager
Date: Fri, 8 May 2026 17:13:29 -0400
Message-ID: <20260508211331.38805-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 830df76d-06c7-4562-73b2-08dead46b02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MEeZnQuU9pCFEyrkdIzkQ1jC7HAmH8i6EYukCvjcmEqdndDczUk5eJ0MaOZ6PlAEln83Zv0N4S3+/OPCyDmgRqfdox1dil+GptNqcTho6qoXFSA9nxG4Qpx9xJ9T/bi7MZnz/1yrKTQD3ceKxcg1doUipSncLm/nNDEXl8km6kNz+an/McU0DuJuuts04qrdpJOMlR7OSkALY3wNBrj7m4zq4C2c/Zi40MZI9iGbk3wWW63WI0EPerAXPM9ljDu6w0EEhVWoKplyEcdjVK5r9DV5qFzuiOcXaQ3Cx4kNX+nSe6AJ3/cFnCXnDjdQ+FzCFO7KHLGUos/j4TVyKaBlpN1VXq/7U6fVKrDfBkJYDKCnxRzGXxyn9pshC1zxyHWLsa6684BeJV7cSdzOCovOQUf709gxGZOdbKhVPmYEoWRjw79afTLLlbdOZova6BOxnSYGzOfAhTcY5pd4n5Rl0Y9EIWpeLWlnxOLf4Qbs9yPKOk7kuwajHo64E9ZRRgMEZ4Kx9R9XFuypUFGQ1xIflkT5XOeI4M0vN7nMF0FgXVzyAu74GqizEfmnNB6O8lqmg2LDuLJQV+iZPgViBFFGAb+w0BwuhoeKNFS5KcKV7WtPnA+gQwSlLV4oEa/Z0mMDhw1LXgpUeP1MzR/9cV82CpFyptAGoEmelQvYxBW4EJbTLu4z4kP2qgf8b/uJYoXfaO2Gvy29PK1BpM+slaRrPYl901ec6mFbwyU55a3lp+E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N7E/zuI5CW3WbRPxvy3beGFTsYO+G0mWBd/qzepyPwGGfPl9z3pbLtb4IwS0jLJfb3UzsP8hrVxwWO6INiWclpALohQrXIND3jhqFnvaVvOPFvblxN51LlwZTzEeQiV8GprpOf+hOhfWvyhsIGZtEBEljSJbFetS9mgaVI4TXWnz5EH3XZAu3Og6FOG2gNIGw39E0AA+f+Roqg1g9ymyUM7IhKh7IeL6l7wLDEzzIiq7n3xu1jtOzRbm3mYiUb4IjvG73yma4MZWuOjqEmAUcI/Xuyz5GwBVgTq7OUTKvq0PwkfBO/o0nlZlx3gKzweSM6N6kJZE1MBXTou6QnKi5flAhW8e1iDOvRE3VnDCMRWOdtrRw4wY2p0Jhm8QwllJOLFObATxKR3xYX5LWc/o7qjN7saSWnKNqKWq7DtdXUvF5eCNTjcLXK437pntYA4c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 21:13:44.7779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830df76d-06c7-4562-73b2-08dead46b02c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

This will allow it to be used outside of gfx9

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 14 --------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index d88d0de58edd..02b52f907f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -315,3 +315,17 @@ bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
 
 	return false;
 }
+
+bool mqd_on_vram(struct amdgpu_device *adev)
+{
+	if (adev->apu_prefer_gtt)
+		return false;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 5, 0):
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 06ca6235ff1b..140ee1fc5d81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -201,4 +201,6 @@ uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q);
 bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
 				   uint32_t inst);
+bool mqd_on_vram(struct amdgpu_device *adev);
+
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7232a0117a00..1f9b342ef085 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -115,20 +115,6 @@ static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
 }
 
-static bool mqd_on_vram(struct amdgpu_device *adev)
-{
-	if (adev->apu_prefer_gtt)
-		return false;
-
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 5, 0):
-		return true;
-	default:
-		return false;
-	}
-}
-
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		struct queue_properties *q)
 {
-- 
2.43.0

