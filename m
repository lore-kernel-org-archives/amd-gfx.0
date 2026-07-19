Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE1AC44512
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2026 17:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A78810E065;
	Sun, 19 Jul 2026 17:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJaoQva4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3637A10E065
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 17:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaNjJtlrKwrUGyZX2O6Wn0hpLIuZLgLzK2S3d/RfqhI7JbRRE+OoXIbVJPdsOdjN6+Ub3T09KZAO4RYUwQC97mqvIzDLUKv2E9EplsGHqYUs128gpt+SHkaZUqu837EiaAM92GIAWUu080wjx/OXZo5JKNDNzmyWGo85Hjcrm+IE5AUMv3EyP4ZVVSt4pZY5m6YSQyRjkv+Ngr1iLzM1EJphORvRYl2bud6ciSmNLDsIRJc6eXXHjfAhFEv7IlAKVpXe40PbBvPbWVknmox1z1PXMBNZ0OAN4+deiU0RIeTzgOFw6Yq8UOlqWCyqKSpygJrVSmzqTsVa8WB1yoVZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbFQNc0vqWA7oatnZfYBlwSAxBZBwd1ePOjJi1t4x3M=;
 b=WkjjLMrNRaokJZodi/vKjTfpyfPGhnlhtyzr17zL7xeYF0nSMPBAx7CZDtNyn46T9sDxLnYHiijw4U4Y6qEYkMQXAa5wr6cIbYfB4ZYTIHZ2rzbUcUpkqgoU87SdaHZ1AkMAIq00SStxmGi73RFr/XpNd3i93XdA03USeUEZl1sCydJFIlVbDzogTyIVQ7UUa1Sew7YdwAgNuocvc2pB2lNiIhPrxOeS8CVwgfFiG830VLq9vJitN1RWv0aNBmqb+7EKedzN/hYE5rzV0xohpf35YDxKJhorrMlnzKXHhrQnnSfJ6BlUeZwXLoV+QAkaVVWK/ByOmkFtAtWUPrlm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbFQNc0vqWA7oatnZfYBlwSAxBZBwd1ePOjJi1t4x3M=;
 b=nJaoQva4bE0sPs/v6IZxmKHEHEg4LSG6JogNLmT1a1H3B7DVxdXu0JTCFLKrALqPwQeLaPvDzySMyWQQSxtND8RF4yBIjZ4WcHGMG4CDWiyqatGJ7dSMeOx2Tl+pocYEQSFBNPHypNhCpPVoLUllQ/XT2TIKS97Q+RKYmRqDvKM=
Received: from BL1P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::25)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Sun, 19 Jul
 2026 17:36:44 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::28) by BL1P222CA0020.outlook.office365.com
 (2603:10b6:208:2c7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 17:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 17:36:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Sun, 19 Jul 2026 12:36:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Michael
 Chen" <michael.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing MES helper parameter descriptions
Date: Sun, 19 Jul 2026 23:06:27 +0530
Message-ID: <20260719173627.3598744-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4471e2-9e01-4998-a79c-08dee5bc4d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: k/f+d7LzsttLu3oD42a8qX687AArS1MjP4PArueZdTuo4ppMkhuSPEHoGneuW9uNtjRErB3kAYlJym+esaGMTMcFhQL2VRWBwkgbBLStt5C6s+5BLDWBqfJ7BxMHxnT5mAMfBC+LNt6b6mvPRLljCnCok+NkBq82NoJ+3rSWda+LAL/ED4TeHMvI40gylM4xV3GsDp6g4bHproOLktavaKIQ4GGtmsOI4dFuxyATaZd9gD3lMBb4AyJ7UPH46yn9aN/nDAsQhcPSKKeiBJa3/yoUQl0a6YJ1HCfq9bMXu/dZSudr2Dq2L8PKYdHaUA4VzOwZ5pqAShVZ3kL0PceFv9Ge9oo92gEHJh0hwP61oPFtCrxaCOys4fDfIY3Bfxe2z66dH7dhHjBrpINiXF9eV02rxiYAncI0FdzuNsTPjIfnLgCpozyFf6DFZaKPb5NNYNNDNflNvk6RhNqEgdi5yBGlqbvRwYSMZU9DrKlWR7ML0/qhof02x9Up78EFOGIxio/rXxgnXB2andy6VPDQUooA3lUxEHw+fq2CLpZ+HboPclKypJ1rDGwa2We4q3hJOYvO5j+xezgjmNJ3ESE13C5+FRBu2slBbTcjR8TbCCNAiwwJw1doanzsPTousyi8quBzOchLV6/L5psxShKaLplS/yPBZ1Pw2Bs7gNTIS9PF9SNIu7vqxY0aNqBs7p0oDKEw99T/Lj30LwC5T7sdJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IF3/esyf04obMvELnoE8C4BqYbGYm29T98iBBr/G7yQEZMKAov/oVdXBWg5+nj/sOX4icM1ejAGqC19/20uLnavnvqJNk32v37sSUkYPHPjdiSb3rIFYlsBmbFqL4kK/2APTshIRljReFpAINj3+g7KXxzCHHKAQVyDLrhzkNGvi0C9VD5K17VxW0TgXmctKD+IE2Rc8o1aNvWh5uWqjSduMMEQ6XcKNxoJA+S7N0dL1nWCLSVKEOuQjBafzUSBccfr3w/Wx3iXcVUeZRTGckQANp3Rq7ZyaSpbUkC3+BjFbbMQUSpV7ZNetM/1k/6N+3myEIoX1/TiXFzf8nNcyN5uOq2eKFqiVqYCQejrYPpPRfDFGVQ/+lX0zQEbGh9XQ0xv+H8JZvjUyBB7YDGEXjjT2kD7NkjDPQ6XTviZDFTQhYgcx6OwkbooK4nxRiltl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 17:36:44.3536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4471e2-9e01-4998-a79c-08dee5bc4d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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

Complete the kernel-doc comments for the MES RS64 memory, process
context, and gang context helper functions by documenting the missing
function parameters to keep the kernel-doc comments consistent with
their function signatures.

Fixes: d160cbf3e4db ("drm/amdgpu: add RS64 local memory context array init/fini")
Fixes: dded4c22699e ("drm/amdgpu: add mes process context alloc/free")
Fixes: a755b0cf3ef3 ("drm/amdgpu: add mes gang contex alloc/free helper")
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Michael Chen <michael.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 +++++++++++++++++--------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1e3a23c81552..9af7c97af5be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -952,9 +952,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)
 	return 0;
 }
 
-/**
- * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
- */
+ /**
+  * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
+  *
+  * @mes: MES instance
+  */
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)
 {
 	if (mes->ctx_array_size_bo) {
@@ -1038,9 +1040,10 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
+ * @queue: Usermode queue receiving the allocated process context index
  *
- * Returns 0 on success, -ENOSPC if all slots are used (caller should
- * fall back to system memory path).
+ * Returns 0 on success, -ENOSPC if all slots are used, or
+ * -EOPNOTSUPP if RS64 local memory is unavailable.
  */
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
@@ -1064,9 +1067,12 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
 	return 0;
 }
 
-/**
- * amdgpu_mes_free_proc_ctx_index - free a process context slot
- */
+ /**
+  * amdgpu_mes_free_proc_ctx_index - free a process context slot
+  *
+  * @mes: MES instance
+  * @queue: Usermode queue whose process context index is released
+  */
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
 {
@@ -1080,9 +1086,15 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
 	amdgpu_mes_unlock(mes);
 }
 
-/**
- * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
- */
+ /**
+  * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
+  *
+  * @mes: MES instance
+  * @queue: Usermode queue receiving the allocated gang context index
+  *
+  * Returns 0 on success, -ENOSPC if all slots are used, or
+  * -EOPNOTSUPP if RS64 local memory is unavailable.
+  */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
 {
@@ -1105,9 +1117,12 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 	return 0;
 }
 
-/**
- * amdgpu_mes_free_gang_ctx_index - free a gang context slot
- */
+ /**
+  * amdgpu_mes_free_gang_ctx_index - free a gang context slot
+  *
+  * @mes: MES instance
+  * @queue: Usermode queue whose gang context index is released
+  */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
 {
-- 
2.34.1

