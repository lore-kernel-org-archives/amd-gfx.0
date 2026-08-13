Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711B9C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 05:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C4910E4E3;
	Thu, 13 Aug 2026 05:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dxRzzoFa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB6610E4D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 05:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPLpSStNVDwl/QXV4W/hIQfce0QGaWcYjmu9IByiZVYdqiZTmLG2EH5DAcxuPiiel7cKWyMfkWUeOt1gV0hSliYSp3AhYPXM4XwMfXKqLq20OrT4MlRPU8fACHCfVpBWg+S7QCsybj2LV8wjkG3F6bjn8UG/k6ttNfjpRfJoRrn2/uIEhKlwOA15Ynu4i+zG2bKO+6sDFavfZVHLlv6NY4CgCC9FOQmYSHTdoPhnj02IpX9G+1ayGWPta2g8wIB6W+LlxM4qCai01dMP2OFhBBINZ0xpK+I1zYSeMpog1wVX41UHDe8ccCzxor2XAMidCpUjlbXIBgsbPBefSHkTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5MJ4LubXohyPh0DXj8HT9nT3Rtc75mwO6uRtWPeVnY=;
 b=Tzdr4nyo5sG460ew/cE0FnBwbOJPdMWq2x1wdEvhjaRKwa5fGyYHCAlJAgX6BNxuRoz72ynqyzNGRUTFtKRLJ8iFA8yIXQhKDUGWPc2HbLApRTU+rpgUEmYQhfBe7M63sz2d9gzWvD3C5aMNvJ5YIbV+BkxWZSvZfurrVvO3C4O61CWjY4K0iVOi5sd2AoUSQ13UGlHkNs8cqEZCHVu3Xx57fFAkYx2JOkqMbzp74Z6xAM7OuyvAZMA6aSpRCUGnSDu/4T0NfLUiuPmQKo28HWdLS2xkCaV+6R4dZLgP1lBn/m7ESrzC0IJMjW+bF/V4eMJeuiTpZEvLgFPA4Zk05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5MJ4LubXohyPh0DXj8HT9nT3Rtc75mwO6uRtWPeVnY=;
 b=dxRzzoFazgIH5i54uTvrHXWjsFi+Aq8RE6iAQZ5z2vykg7UnGff8Ppf2uU3/FPqSZwpoB163LdegvZ+oc6sOMzOhDV/ng6x0PP90I8vuTdhILgEwZSXOaTrcUn2eXO9Zx1ljgOIJMmsL2mfroPm0gLc9V7ee87N3JIDgPcnA45g=
Received: from BN1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:408:e2::31)
 by DSVPR12MB999261.namprd12.prod.outlook.com (2603:10b6:8:41b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 05:42:33 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::6c) by BN1PR13CA0026.outlook.office365.com
 (2603:10b6:408:e2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.4 via Frontend Transport; Thu, 13
 Aug 2026 05:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 05:42:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 00:42:31 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 00:42:24 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Alexander.Deucher@amd.com>,
 <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, <Felix.Kuehling@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v2 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Thu, 13 Aug 2026 11:12:20 +0530
Message-ID: <20260813054220.450509-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813054220.450509-1-Priya.Hosur@amd.com>
References: <20260813054220.450509-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DSVPR12MB999261:EE_
X-MS-Office365-Filtering-Correlation-Id: 969de1e0-79c8-4bb9-27c0-08def8fdabd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5cEefYxSkt5sSyJu1ahmGniETXbGOYgs9gHAhL10gzNXMdIyJKLXsUigx0ODhpU8D/QMjxreFd5jhjx3g/l8jcuU2r9ITAZGRTt1ZE1l8CmKTskNxxNj+suvmyWTEeCd5UYLDttNgXEWYCeDOfG5N3fF6xviN5acrd+5c+CfWPDk8aDDIsu9yCvtQHZ+jzTrqbLx5xidFtKfDXVNp5uZDxihL5j0D7vMIhb+Ka2Mk4cp3JaWPA+kwtlLIw/DTIdgJcB1Gi/NamhDnVktdDNXnuoBrjFd1MB+V4hEnjWo5m3IuZk4lpwfldmEjRrv2i80hz22OOlk5dvXOz6rycPNRMV/GDLLO1ZLLj8YiIEK+DGdaQDV3J/PbOOaVf7kEgjPeJ3srtaBSZygvWp0T9hjFtDXwZ0T0ldO9duJffXU9UUn7gHopgNdeMAdsBJjRd4yQWhxrpbjyUGMq8qMQ3xxVy5t2hIMh2anadA2inTbWRGpaw3WpAw66j7flqinhyh7yfj0Tkttwzvyqq1VtESa1mwIf5yEw/Qp08n7eWlDv0lwrti7Ria8U9Rkp2Q3h54h/CARr8DPXNE/JrMZMucrKWG9SI863yBpCs10mw1U4htdjxwojSgl6JazOC5xzueKCucsD5Z46gzoaKYH139f7HU/D9xFzmkG9M9FrMpaneTa377eljvynf7K0GHFJU08osQtRZ9D5TRuwLhzSG0rOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tXiwXcLlG694TPKTwH0CVX3k6tX36btoWu5u/exr7Si8RGI4cjX8UARq7bnqNdfFmLr0ZetEAN9QNiHs7JMaEMEd9Tg1+l7CICRBLx9V9a7+4RDQW9AgETSuCeftPYPUTbORt9kMVRhTQf+DaMtQ+OdkLOqh9yoMQ+5W+vwZxcOTXmIvGWottaXAMMBcYoqKDq2EQ2MCBona+Au+vNA3Ey4jhSw/dM5nHkK1G8ptkq3ZdO6h/QGeEt2ZbKpVoTszkjvdgE6xGh8+CKsa6JS/gA+DSdTrg4BlSGSQXg5PBMkTzMJPnQiMMqRf1o6LY/cEo1lxtgMSbAaqN0nO/XlDrK3KhPgchVgeq5wOCYv2tCa8Cgj423IzWZRl5JqurcDePbQQjW2bVNhkWZJBPL8eK6I1L6U4C3u0AigOC+r/WX3IBvSyqmrexIg4JIt1GGqJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 05:42:32.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969de1e0-79c8-4bb9-27c0-08def8fdabd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999261
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
a race condition where in-flight DMA descriptors can access memory that
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

Change-Id: Ia83e6af7a66fe2bff56cb62c741728e9a18883e8
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..71c60a42c581 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		dqm_evict_mqd_bo(dqm, q);
 	}
 
+	/*
+	 * Heavy-weight TLB flush after MES removes queues to ensure
+	 * in-flight memory accesses complete before memory is freed/migrated.
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

