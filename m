Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B487C54FDF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 09:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046BB10EE34;
	Thu, 30 Jul 2026 09:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2mb9yIy";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F0810EE34
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 09:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvsUceoJJY++zJftWP6HHJrRjB+JupCQ8/fS8qvTKvf718ZmkI1s4uzAgSiZBjXQ8t1ZVOAF3IGD1IbWr1/FLqm6cOBxerJjxml3d8eMD/insS2D3n7lvFpaAb/SW70w6XCnTzNMXVwpy3KDBefuz76s69RDnFBXw63Zd4xgIz/+rUnIT7FigirZKBTjmGbpNMWPGFrDrBogPejetpPJ8wZrZiGeceqKH00GATKytT6HUwfEHqnlxAbRU7Glj1CxgkT/Ot9ggE0BI+EadfBcyZPFR+QYSkgXcGlvRORefJAn4ViUJYwGFpiGIHxX0eO13c+ZnlvAvJZwdfv4FvVMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvpiL5ropnT3SadBhoktXqX0rgxQ6fANhU7x61Iq9x4=;
 b=K8fMr5PTQZJhVrWnBZjR2M5VGxvn+u7diewyuFdGvbWMsGNOAkgQbdX6eUx6d0LT/PPHINmVVNNU1gQzdnORB6GMFyjEVtc42ds8aKPOAi9rwOIs7YiDs3xz49xkARJPO2rN9gEYQZsOp9/BVyQpe6N9p/KqI3QTmfjbwAZE61BVLZvBO/S8aEzw4GcOhY+VNrIofjRr14eKJ8nF52J5LgNB3KwFHzCItyMzMGl+neySpem/0lW4OBWpp+KQxCrTqQFctexrKxx6kanHWvm5SW+vcEvb5WvYYkDnqap6TUlorWHbqjd/oW91SFMFeBrwD+4uoRpT6Q45GCIhTrJXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvpiL5ropnT3SadBhoktXqX0rgxQ6fANhU7x61Iq9x4=;
 b=t2mb9yIyeeVcEOFiKei1GjwqowAgP8S/qNMkjtvu4lVv4rNY3+5yTG3jRjKa8gDMdULft3WoI7H76/QQf3h1mVynX8LdcDost9gSfLxGOGU3hlpBm8YIGVt5Rb4+WQZkOsuN0F+n97bMMmimxSdc+uzTNvG7tcvNskddgrW4MOk=
Received: from DS1PR02CA0015.namprd02.prod.outlook.com (2603:10b6:8:44a::13)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 09:40:32 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:8:44a:cafe::68) by DS1PR02CA0015.outlook.office365.com
 (2603:10b6:8:44a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 09:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 09:40:31 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:40:30 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Candice Li
 <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: reject oversized IBs on rings with 20-bit size
 fields
Date: Thu, 30 Jul 2026 17:40:11 +0800
Message-ID: <20260730094011.3466352-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b0b8a5-1d95-49cc-ae0b-08deee1e98fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: zphiIz8A0N5/jYx/bovsPjMINffKeHY/JNNFdLbgZhITghkv7f4Wjm3PUXOBULcVl3RnKcGpmgNDt/iWIsH3MgsiMcNZwOh8F9C6slkmRIFP6lHdAquoZPLolDx71bnkEsyzEt9mXEOc2Uy/P4VQOUAoczxanFC+1ybzUmLvxTjUrG+VQBPdyyiVfw3tVwngm1jv91bBFZxzvKAo0CpElf9XS7enBG4noKfQH1B5SKSjtfTQ4ujgzt9MgerA/QClv3xXscMOwq2ym0zlrqLYxQV9NlkVdow2BxRMovhv2+CXCMIWKtKfONXHN8Tg+R8Vadlf0f+JnAOdsN+/Pf0dRNRh5Z0K7f1kSQXerlxN1WEGHNgr+eNPCgvzQXMQFLhENOQB8hoUyOeNujmcSJUPWo3Q/zzx66knvjWWX3fxTRBjgYxPVo7/dP5qhXl2sBEQvHF/IPcJLHJDNaJoiZ0Y0hss2Zh1uBPxvPLJxAuZlEKCJ43eit/zSj0D5Lt8oonJm5pXbPKJ9966Yeq2GNeRyHirWnH09ddvfylVT3c3VY8eBF8iw6U0p/9Ye6BjGmDEr0W32ivrTb9qqt2v6NIVWbww0izcai/kWpt3dEXx/dQIKMsMKPZNHycNRONciZo36JUr75isalDKAXvVXbR6yVNw4ivAh4OgzAH8vkKHhgWJQvxV8gGPhKSasczCQD9n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SJ3yRuOYpFsb2IXvvltmK3ouAXmLsCr07LzYcrAvtuJhhbDSmfAuAF+wNwPKBsYl3Npl+aKshJRBjQ6eVhpbtxEhDNstdVVk4peVTr5EOpmemZfdxIu7Bh1HKKBsU2ew+6OHFbzsaqIwxdfC9FCpXsmXzHKNwOK0nObEdAZKLwCH4j25goy1cE+PcLJICMzcD7tvCBLrLjrsBn9VGMj4wB3rgF+Z2jadk/E1qSCi5RkHKL3q8jMddkP9vEQ9NVWys0v6KL5oJdiNA6LBQ+ih8qKb9oDi2iYg69B4EXQKUklLNXZLx4xUMUdOIFw/EfklgEU+AKoWDDYzSPnxlyqB56trY8NaQO6tjszfDuBe84X1qEtU6oSRz4aKJyYEBO8FYGzZj3zsLL8eVnU31oLiNkOCrU+rSoCPJHhy41eg+YmfOUDHQcIg5eIea3R6nr5J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:40:31.5544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0b8a5-1d95-49cc-ae0b-08deee1e98fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
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

PM4 INDIRECT_BUFFER control words encode IB size in 20 bits.  On GFX
rings amdgpu_cs_p2_ib() passed user-supplied ib_bytes through to
ib->length_dw without a limit, and ring_emit_ib() ORed length_dw
directly into the control dword.

Reject IB submissions whose length exceeds the hardware maximum in
amdgpu_cs_p2_ib(), but only for rings whose emit_ib packet format
documents a 20-bit size field (GFX, compute and SDMA).

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index afc1c631d55aa6..0d06b6d166c576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -42,6 +42,25 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_hmm.h"
 
+/*
+ * Maximum IB length (dwords) for rings whose emit_ib packet format
+ * documents a 20-bit size field, e.g. GFX PM4 INDIRECT_BUFFER ([19:0])
+ * and SDMA indirect packets.
+ */
+#define AMDGPU_IB_PACKET_SIZE_MAX_DW	0xFFFFF
+
+static bool amdgpu_cs_ib_has_packet_length_limit(enum amdgpu_ring_type type)
+{
+	switch (type) {
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+	case AMDGPU_RING_TYPE_SDMA:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 				 struct amdgpu_device *adev,
 				 struct drm_file *filp,
@@ -340,7 +359,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 
 	job = p->jobs[r];
 	ring = amdgpu_job_ring(job);
-	ib = &job->ibs[job->num_ibs++];
 
 	/* submissions to kernel queues are disabled */
 	if (ring->no_user_submission)
@@ -369,6 +387,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			return -EINVAL;
 	}
 
+	if (amdgpu_cs_ib_has_packet_length_limit(ring->funcs->type) &&
+	    chunk_ib->ib_bytes / 4 > AMDGPU_IB_PACKET_SIZE_MAX_DW)
+		return -EINVAL;
+
+	ib = &job->ibs[job->num_ibs++];
+
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
-- 
2.25.1

