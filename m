Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E180C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 06:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2803710E0CD;
	Wed, 12 Aug 2026 06:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WhglKhfB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDC710E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 06:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1Uyv9Xnp/OIWIArpWd7dMkUfErdKE8WVSV736ntyaMc8Eyie0bQ8FUwTTQAPedlS+vXiQwzIztfxjZSKxAXhEUtJyRNuAXG8jOC6kAa0j3XGXdRafsRMWFwCPeiFahh+vw7NueuB4Dy6DZNQfX2mjra6D6+wyDmuH9LmlMoO3mZBIqhDq+rneWGTDttT80fFuG2z1H12fmwGxUGL5LBuSSrvJhR49PmVv4oRRyUjIQQtTRSRxfo1yYHdkyVdH7ErZkPJM7PhtpotH7cq3UvweHc0Bb7296CL98nkMVajm1P/Q/f57C2AS1HCC+Q7iNT4bVUN+MvgyMN6JVonbbwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtwQxvW9Kmn9hcn8flAuohsmGlrgumuG/4LgkZ2o1Fc=;
 b=xc3qzf/sJ/7HFOmXM+NRfHGD46ov+Py3u+z6pxBQsrLtkjDZCpKwBb56ZjNB0MHEuo5meCduVRI1e03DG4s/F91cuCuNBeNpOo+XMe9C8Q/f0w1yZLdJNVJS8BrCi0jc+6UNhA68C0/b3Pd1e+nhfwXMHM4dS2Hy0LPtbOkaGTpESKMRoiG0TsJrIEz5b8UUMBS0kDOo03FmNMuYacjM1xDRS03s9igpZwTwn62NcbzK+WPU7IOQA+Q9ht1u0o795bPPEVzazLwTs6vb20KLOWmUCr982G20Z9XK/NwYABug/bMBoKnOLhOyoOXgep4evi8KS5+UqWd1yhoT17pV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtwQxvW9Kmn9hcn8flAuohsmGlrgumuG/4LgkZ2o1Fc=;
 b=WhglKhfBEmaFXEkGnAYALxZsCmDWPcWQtmKt/5f3S3GVvFm2x4+os8ICXAEuBVjx14NkILjXSLo8eX5Dyj9tJQAMNIzutYHNpB/23CA5HY2DVFSvAXyf+0rG+gnkhWzd0kgnsWjSnOdkmI213Kk7E9PlbGw7eO9j+vlNJ2JCPGQ=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 06:11:35 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::8e) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 06:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 06:11:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 01:11:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 01:11:34 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 01:11:31 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Shaoyun.Liu@amd.com>, <Lijo.Lazar@amd.com>, <Alexander.Deucher@amd.com>,
 <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Wed, 12 Aug 2026 11:41:22 +0530
Message-ID: <20260812061122.435929-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812061122.435929-1-Priya.Hosur@amd.com>
References: <20260812061122.435929-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f1a227-32de-4400-89ce-08def8388ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YbCAtxJvTf2PttPiXzIlK0ysvjGHJqa1zARuuDtqLitWbdUtWrrc2eqDCY9xnqJb5Xm0UAJjw/v5CeQRjVKAYmBou+Ylex8FQzjz0OgXTgdW1QRddZleElfdQBKVhVekCalWsmriw7TRZ367Ltcs5NCUaCQtxFMHwvOrfYGciQ1gyUsF0GG2AS9v81mdm6TM+DZ0yKQ1Z2M9wT9eMeqaDfso0SNojLTJFEbj9vUQWm/gzV/Y0G1MxMm39l0gr0PORApDbVcErdGMfWB5AVlwC9WP9K1usbeDvTbzrskLo4ZPt5hpFOAGWUAvVW0PDeyeiuXPC8DDVV+F/CXSIS+R/AjDkZ2gwKb0S2WQUUyZQLN3Sake8gydvOh0mPdvrqty9U9SJhNwhiqLWJFkV3+Hw/2SeoDoTGMdpvhrzVBo3cioEpedxqGVglT0Ww8ilG2n+w1k2J+HMXghCTmh9nNtVrl9Fh37F44Ubt399Z3amHobGysMsVeUo838RIFoCUQFPZ/q75MT7fRXJhfjWGcKtFK7AcsMFPWhbgQKLTRoh/UmX43dwMFQ4N6FHmKCZE/xh9nk4tZZeEpMLO/dE4hPCavogmaELuL1B9AzCh3HzRwqosdnh0WdY5SQW77A2SjQnlNVa/b6xAu8w2VM6Xe7mbZt/r01yNCfLEgwCxxXqo2NkiEXJdRBePXviE+ApC5nJx9XCg6uW393El7n2gnBUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LPdCEQS75sf22bPUvTvlxrR2FwaonAbj8Xx8lNj+SsBhTYvfIImDcBxtL1NPBilugQj4+LZdcrA2QYWZyycRYdN79u6pDRzsQHf7maBB/YrzPey+BfJdyqtuuy9N+gIYvPWn3e8kdUdMUGUuE+qCN+6B+FQkzFzhjZtHJGTlROj98f+wSOgvSd6MsWPYV3AO2d+kd5Ogp0gmv2ftrWTh9oj8Vqhu0ihWg4xEvbfMVy1FbASMSTlHfEWMRWcemFL186YMGxhBZCI07YFH8XaBArH/2shZZ/xb5BbTm+FmaZlP7O6VQEC/YBLH/tkbk/BAwL7jaMhd5XJA6cBRFBeePn7h60Jpl4xJAvhw3ULWgYGxZDEYJGfrfjcZ9QXKnLTzu1sa3AM1PKZeQm9U1sCD+XL7M44IXA1F3IgGFFOQBEwatpWNfElaeJUvbxy967Sb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:11:34.9649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f1a227-32de-4400-89ce-08def8388ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

MES (Micro Engine Scheduler) does not perform heavy-weight TLB invalidation
after unmapping queues, unlike HWS which does this automatically. This causes
a race condition where in-flight SDMA DMA descriptors can access memory that
has been unmapped, leading to page faults and GPU queue hangs during SVM
page migration.

The issue manifests as KFDSVMRangeTest.MultiThreadMigrationTest/1 failures
on gfx1151 (Ryzen AI MAX) with XNACK mode 1 enabled - the GPU compute queue
hangs with packets submitted but never consumed.

Add kfd_flush_tlb() with TLB_FLUSH_HEAVYWEIGHT in two MES code paths:
1. evict_process_queues_cpsch() - after MES removes queues
2. suspend_queues() - after MES suspends queues and mem_fence completes

This ensures all in-flight memory accesses from unmapped queues are flushed
before memory is freed or migrated.

Testing on gfx1151 shows this reduces failure rate from 100% to approximately
7-10%. The residual failures require further investigation.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..5eb85290126e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		dqm_evict_mqd_bo(dqm, q);
 	}
 
+	/*
+	 * Heavy-weight TLB flush after MES removes queues to ensure
+	 * in-flight SDMA accesses complete before memory is freed/migrated.
+	 * HWS does this automatically, MES does not.
+	 */
+	if (dqm->dev->kfd->shared_resources.enable_mes)
+		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
 		pdd->last_evict_timestamp = get_jiffies_64();
 		retval = execute_queues_cpsch(dqm,
@@ -3736,8 +3744,11 @@ int suspend_queues(struct kfd_process *p,
 		if (!per_device_suspended) {
 			dqm_unlock(dqm);
 			mutex_unlock(&p->event_mutex);
-			if (total_suspended)
+			if (total_suspended) {
 				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
+				/* Heavy-weight TLB flush after MES suspends queues */
+				kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+			}
 			continue;
 		}
 
-- 
2.43.0

