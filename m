Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B286E103E191
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4491E10E833;
	Wed, 18 Mar 2026 14:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LqPDiHRF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A4E10E826
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct2DSOfOzIZjn/HkXRhn8vGgSkC3B5TIpsGUi9aaIYGYzTpFTSFr9Bn7bqNMNINSHEFOkvBwyeZgZWHcic0o/tJgJGDvhbLL8Fab5Di3qcUU1ybMcePiobhmi5/DOnRz3dPbWKf6L58zMvWCFje/jJcHJgJ2WztenfwgOFLb1bOClVrsq+oDykPU29nKPnvAN7Ty/pEItb0azAhw030PC1qQg1pfwLdPZcCwFwWNw0v4j9oTiS2ZLJ6n7nkcef2822D573jU5gvCbAH7mDVm61CJ5MCg7NFqGfiX0MQj31tgtzCzZH5Fk3ubDdcZ0iE8wd0IbJtk/wurW5nh/vHlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIgDdYleyUzsf/ro8wAifAb87w5TAic/LVVHti5c5Lg=;
 b=g9chYo+ViLDW/rQXKsskxOjvUfb+j97T0sipb5gX2HXJ2vQRDeRA9soOqC8aGjY/Pz4D0iKsSyljveF52FiLJQBrIlUejzxL60w00h6ZyzejOjmRRs/GXG7viW6otNxUnhN9HeVhKEdiJHWL3/PURGoD9I438agp57Cds8r3Bepg+R1EI8iHBga0oY2edFJAiYfJ3fyQa+Pq4iZjaten1jkpYbqx4Zk98m+fKJ0Y0Q/I1ll4d4pYG6r0xKncLiVAxsSieYpUGYsvpzYCDUpJl6TWf/dZZHkDxDiAjkzWtEGCjhdWyJQaToEDq3e4mZeRsfzldwRN2C8OFYlB9cCDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIgDdYleyUzsf/ro8wAifAb87w5TAic/LVVHti5c5Lg=;
 b=LqPDiHRFt2vQqfUupvkkDnxFnlPNzRTmuNNbDC+DuNQ9bVDcyEk2B1Z+FpheXEJhOOzYqoiyXlqiCqjAu26kMD8UwoC/9XPvxoXmm88BP6oWbI58bKi3WTq+hLHc5laosSsxh+0P+ekq8jxHR/3bUzJUd7J43wBCJ1fy73XSglc=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:09:01 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::53) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:09:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/16] drm/amdgpu/gfx8: rework kernel queue priority handling
Date: Wed, 18 Mar 2026 10:08:30 -0400
Message-ID: <20260318140837.582776-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: da5a09e9-1d07-421a-1a71-08de84f7e765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2oL5JubXOp57APUd8omsJAI2ENOm8Ke7Y7/4duOT2zMBl/6qbkzZeLLfSptEtnB1q14YzBHn2sxTW6F7XWLxVDlo2LKYTg1ehV8zgUtPjIz+BXc6Snu+9Aetzdl760K+JmlnpaMvwWwAhEH8jFvcgb3dXWvNZjnMIKtBL9X6FMb+vD1hmYLh71Pv7v3eXei1SwJsyteWHq6Xxc66RNBcU2FfXvVxbW/Chhn9llc96kFwEATgiJfACrco3/p8FlJCjQR5IGEGOp3/tVG/4rQ+dVh9liKKl0IZfIgt/EBzM9QmnyplfuYXloq6f9ujj3vPJWYPMbV1XXQWFENKWXneuDbUvZpt60DIy2BTelehHalebiOla7D61Uhs/ZhP4THpSpwMGXdQlIcqHGImvcieHxjcprQ2/tsq3lNSiFE7JdVe1gigBxZ6om7kkvyjydYsDY6lvYr9VGqRWwpFJjvyEMTdr/nW7qVKf4Am/kDBxc42tIDfKlkdp225VWmTvs5HjXeAOVBLKySeH0vqfEAK38vgK9aD7uFprsS4PuA1YYT3GWfoD20+6sAZW4H5bx0lRPy7SM9jJDtHKcxbXv+J/FcoFJUh3fFpWoC+4s1Hlj5pNU2gfxYEuaZ7aoQqAhEbypqrbUtczXuyM1O4UNjM1kA7HuMAbN4juZ0cpEZLT5cvwc6rThP+FImhds4Z/WJO8Qov7bwh2SnvbZINwYNSbPgNcf5DgRK1SZZMmVKEfFhT7LjTeJkjeTuq9vM7HuHgLBKmpnxij8an/o37OgBwrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6GEhdwzh6pb4c7+m7VOUAdjUqigq5zhT5pZKQXyDYHJQb+STGwIWZA+fUkWHDC26ctg9NQD7LRRY5jwxE0M2x1XwE5o5rvicdCWi5DX0KAjvnANIaqlxUB3OZOF+SmM0YVR/6EHeZf2Pv1+Xmk1niJHK9wFVb0E8zA7LLHRzyCj4BL7de2I2oIGt3odUEyXgeY6VNdiRKFjQCIUPDid7ySNNHb2/AfQ8iyVumS1BPbFFvha9FlSc7UQiCFdaruZ13MYMHnwVsEQHZ5mXlGygne8jgLWXyBXgJRFuMf/sXqt2OA5L162cP6c9Xw88OEmMHyDS6ahFtJG6aONRjNQjOnZAYvqmXmpog97OPhbDnq+MkeIs2daPWRLNeWfQ24en6z4FaQJGzLeuFYJFqmlEfQOu8mXfX7jFloXcix2ahVOxVTnQgidy4quorRKmRaSJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:00.6277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5a09e9-1d07-421a-1a71-08de84f7e765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 130196859ff3f..49999bdb13499 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4535,7 +4535,10 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = RREG32(mmCP_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 20);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
-- 
2.53.0

