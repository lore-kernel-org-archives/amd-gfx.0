Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1A5C79F8C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8075A10E408;
	Mon,  7 Sep 2026 01:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t3yqCNJw";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4EA410E26E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHSXyauQhdpug41r55kx9bUd3mSGV1Nho8hD31dNccd+0+8hAb7rNbHIferpmnW9GcbYDi7wSbRAE9mBPGVs6qc8CB4hdrQ+lpFNwSOGfWnPw+HnvvEKDqcml1KV2DiSlbfukCRbRvOjuZRMGwParL+r4jpap6F4mcEYNtKyS6n+snBv0/59AURz9GCNlizkxmyFUlhzyL+biQBHoceS/U+PP59D5E1a9+ia6dRKNVKghrwqpeO9hZUU7vm4nHgS2rPg0INK86hFb4BFtqCa+8UeO7wWFW0g/Dx6wP18fqahFLCn+7Ru7FUbypvyTlMYI8RS6WfgL0bH3crvrkhUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8B4xMz34eTUFCWSS+V8tPdKj1EsR90axdoU+wN+T/8=;
 b=dk159giADKwEddDjOyu/6WjfjIeToYVugxB6otQ/OjIbSjVBtA7568Kq9wLVlFEhjcUtqYjaQ8p6GdiM2Ff3zhOI7DBE/CiWCabxVpYYg2dg8T21ea9lflUIjwNmPb7rUHeiAYWBluKRQqZccaQyPM0QMN5FYK6LTPOSlZoPRBybfe+OE6r2H/blz1EKfmFVwvS41kGr58/irgonp7nzn8K6pzg4RsnRka6Jf2qcy6fWWo+pP7JiVW+kwu6BrPyRRBbjJoVpeeL4pnAKxf771apAfdt8l+tGQgwUKnALee86yokFxo7BddXehM4Od3r028Dfqyuav4s4GypL5AiAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8B4xMz34eTUFCWSS+V8tPdKj1EsR90axdoU+wN+T/8=;
 b=t3yqCNJwoqI68qaFvMnoRwP+Q9xd7aQk0RhqdJIlSZwN7MiuG9WekBAi8/natgl0DWT5RsLUF1yBokTdaUzGWZadmwZAuRNN5mJ1xQtXXGUTPsXa7MUvpevET4SCIESCGr+d6VVz4ShBYKm/DUHXK8EhdVRt+5jN+5CMI/PhzUc=
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:46:42 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::1d) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 4/8] drm/amdgpu/gfx12: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 7 Sep 2026 09:45:31 +0800
Message-ID: <20260907014629.2186163-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8f100f-d122-4931-418f-08df0c81ddfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VQ0gJ6OZterqSgxbYtQwH1Qxui7A7i7zD6gRc/vKDYTXk0OGWbsS8O/a6eXAm4jg0dv4NNh0Ws5G9vUk/cyVD7WlJFv7JTMg5mKAOA3hZyd68su5SjYytjmcN1rsYd7AVlj0JW9NvMYN/Iob4CyMFAsENwAdm5h4RDaHpa1Yv5SydL419EJZYyCsvWewxfgQJ2owM9b/xfhD+TO9038FPBFKCNOS1iIQbsmug0k79kyyWlpPF72pDwkpy12ojFUIGlk3JpdDrv95hefLE/j562WJ1ks0nlUHtVL3Q5YgstYj+wAulaoRzHuIjMftfVoTci2rysb0YriBAjGXzjisB8hw2XgfZ8Ofgdz4QE6awGyu0RZ+W3xVNegJ3F8TyonSvzROUeUt0N/+66m5M/6u9TxCsynV0G++5tgCxF90cST5jm1bPQMH59xnw5VmmaCHMD0IYp5qJOrMa9yHLJY4rpKjFY0oCQMvq/y8++1ZLD3lYnqWiY4r8veY6fFC+hBVRud+QHj0Pv6ADi9tOGYXmtwqqshfPXWUex2f8MHmTX2aiNjhTgAhvte+lAPNIdtMsH2N6njK6WXcHjB0LU97a0vyNtHPvWvHsZhLI74yqTap8ChmkapNGPUuyqlwE+23kNTSiM1BzhorK/kh848XuB7DCLqU7qKJggGFdHNoyBiZjyl1ZgNhrCcVcxMqODj3Hig/6vCMEpZzwEmZUsONjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9X+ZOBM5kLGdwim/FW+V+vl6tryszJMc+N+8U07v+i81Mz/KjYmdnM2J6rkIEIX2M2dBdpp8OBxf1RrfVvUAPm5vpwYwh3sdHvbcXvD54aj/g5ksUXN6vY01qaF7wCjedxwZidEZXoNXNBWEhRvekEoriE2SEiuTSDong0ZxoLHnOh+Ng68q3TslImyzTFd7j/McXH4kVlmv5f9b1WF0f1r2lJyq348izAJ9/qtuecgATxx/j7PF3MmxpVepj9G/qSEghR6IdO8UcJwg4xGpMfD9Vt4qW5SRfJxKy2EtsQTzuD7957SqBeg22gqC5nBO9Yue0iVDLmK4XjFZoSwbGop5Z+2j/YwmdesdW5lK+BVPgTDOfy9PApOn72G1rYRTChrDcgM0fY6gOecEaJdVnV5So68ESbpk6nmXhG+a1Aq1k86hSUTrQdo0s3mQGOW6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:42.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8f100f-d122-4931-418f-08df0c81ddfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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

On a queue MODIFY (prop->modify) the gfx12 GFX and compute init_mqd keep
the ring rptr/wptr that firmware context-saved into the MQD, so a
re-enabled queue resumes at the first un-consumed packet.

v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
    SDMA update_mqd style, instead of patching individual MQD fields in
    place. Keeps all update_mqd callbacks consistent.
v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate gfx12 update_mqd callback, per review.
v4: also keep the context-saved wptr instead of programming a user_wptr,
    per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a434b665d913..b2d210681224 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3006,9 +3006,11 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	uint32_t tmp;
 	uint32_t rb_bufsz;
 
-	/* set up gfx hqd wptr */
-	mqd->cp_gfx_hqd_wptr = 0;
-	mqd->cp_gfx_hqd_wptr_hi = 0;
+	/* MODIFY keeps the firmware-saved wptr; otherwise start at 0 */
+	if (!prop->modify) {
+		mqd->cp_gfx_hqd_wptr = 0;
+		mqd->cp_gfx_hqd_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr = prop->mqd_gpu_addr & 0xfffffffc;
@@ -3079,8 +3081,9 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
+	/* MODIFY keeps the firmware-saved rptr; otherwise reset it */
+	if (!prop->modify)
+		mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -3212,10 +3215,12 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* disable the queue if it's active */
 	mqd->cp_hqd_dequeue_request = 0;
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
-	mqd->cp_hqd_pq_wptr_lo = 0;
-	mqd->cp_hqd_pq_wptr_hi = 0;
+	/* MODIFY keeps the firmware-saved rptr/wptr; otherwise start at 0 */
+	if (!prop->modify) {
+		mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
+		mqd->cp_hqd_pq_wptr_lo = 0;
+		mqd->cp_hqd_pq_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr_lo = prop->mqd_gpu_addr & 0xfffffffc;
-- 
2.49.0

