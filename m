Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31936C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 23:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F8011314C;
	Wed, 10 Aug 2022 23:41:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD2914A504
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 23:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZjbA4805I0A6b+k6m6q010Pv3HXrrXbqTWXI39kKJF7b2Uf8bYt0Th2ITXA+sQ6QhAuRwqnK7PnvP7H8wD+9BkAgwVwh5HKnMI2e8Oyo7pQw3eMo4i1jocLIlUrAkUiHtgnh7L2vu313Uu3h7GOF1Jg3ePU03ywyYjOixfFt4G4ZNhmSwwOuww0/pd2veD3nDLZgfjJUFySkwN3nP0bDDEHA5zltqy2je/uU9r/KN78Qs/r2kdLf5Cyyk7Z66dEORHTVni050+NBozeLRYJEwU08SWEOfmRPP7sxJqzgIMICB4mFt/vt8VvnFKYSPLoPGh5zdVb4Xz3Q3CHZWUROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/JbJfSdxaaGh1fNrbgAH20JHeCllAjKAMWmZiov+ZU=;
 b=ioLFOsYzhla7x2sBLKTEQwwD6YCd9nJlEUMQENuACof5bU0Wf0qYn0LshVdeP/gX5HvZPnw3uzqT/gBU7Do7OFIFCv1THR6wdihVuI7JpTquGDV5hF5XbRskbMUmXROW5bi0pqbNa8hZCtGH1PhAFfAFlLdhCc0MK6aikxZQW3YiG7GvDVRzDL1aJtu2V4/a5mzYL0FxsWZ19SQokIUDNpfZAY7Jm2KGi4hyc8QklD9wCSGJwxngo8YFDcmZpRYUWP1enqaPagS7agcwKyq0K/hBmQk+z2OFQUeYzSudHIHuRg1VR9EDpZHUBlLplQg/6KrvkaLDTNnre/4zml5CSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/JbJfSdxaaGh1fNrbgAH20JHeCllAjKAMWmZiov+ZU=;
 b=2+XIluczIyGbhxU7u9IVNn1z0XQDym8vknifxAhJ3t++WJb2ADZd+4ta5sfSapWwlHI+937VUEUasfNviceJDD2TZQuVtrN9yeQaTKrSSe81piGAAVfEceK7W3ak6j/YtLAkZrJB1t4hDX8xPZ7LNqG87pJUEzsmP+EJGaCg2ho=
Received: from MW3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:303:2b::19)
 by DM6PR12MB3755.namprd12.prod.outlook.com (2603:10b6:5:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 23:41:25 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::a3) by MW3PR05CA0014.outlook.office365.com
 (2603:10b6:303:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.9 via Frontend
 Transport; Wed, 10 Aug 2022 23:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 23:41:24 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 18:41:23 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Try to schedule bottom half on same core
Date: Wed, 10 Aug 2022 19:41:09 -0400
Message-ID: <20220810234109.935228-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f8e88b0-17d4-40ce-f805-08da7b29d688
X-MS-TrafficTypeDiagnostic: DM6PR12MB3755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9LidzG//e5zzjtBv1SQG8GlHQoi+U25L74pXf7AEmHLmMLaHanOMvSKO7P64sk3+1r+Au83z/9NQ9TOF7hcfAMmHpXUhj4UNtrFFBqfcL5M6io2b6jxdxtUOC/V+oYHId1+AZQhPBRdO2oIjtn9RTUeso770LJ47J1uzhE44My6qCP1zoYxEH9SQ9NHcIFjvvyofkF+IDRfWVIxRQ/rsaUiKUJZr+4dLFik/3+GG3c2VbHdGwUiX2a8w5GnTVBbeabyfAdQaM9YyqjT1FsPkye43uyuizt/4AXasumdfM05lfI4BwKAnHcUQSd7hnd7dwUfjglTvgnSV4m5pBqGfPvtEx8YircbS6d69n9tcG/tGmjwCmr8on+qDal08hGi4jZVcOJc/CO8419OqHj04Kw+AvLfE1nu/hfy5cIIn/yQFVFOzbCCAg8TEb4E3/5yoaeFZHKAbAyOF12VvA1hB3md2Y/ZJXK7+QH/4/0f/VgZkX7yrdFEPWKeUqnBwH2WOaKLY+qaVP3a7l9pyeqhfqGNtU6fxHhRPa3unbXmIzHZWob36rANj7heZClnLqBINJudexcCLHK0g6jP1OT8w7n8zYMElTr579rhjcrM4prnENxNUc1ppQBVDeuJCvEyMh4oezDiuGT6ylcJZ/Xu4kVl9c/ZcB5ix95os8TPB//qII1uBaViFeSpCsl5CQx/gyYl2eE9FE1p5ujLRA5Pm5AiWClFCTjE4nHzZUKhtBILUFU+/oMswBe/PRQTMRcEd0mii0jgdo5R01/N4cg093+qOADP85nuXIedb5C9s/EFlvDLr/FbxwMNfqDHBEjhKL1UqOKmNspEXEGGkmJS/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(2616005)(83380400001)(26005)(316002)(186003)(36756003)(1076003)(8676002)(6916009)(336012)(4326008)(86362001)(6666004)(2906002)(40460700003)(41300700001)(16526019)(7696005)(426003)(47076005)(478600001)(36860700001)(70206006)(82310400005)(5660300002)(70586007)(40480700001)(81166007)(356005)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 23:41:24.7647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8e88b0-17d4-40ce-f805-08da7b29d688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3755
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
Cc: nicholas.curtis@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On systems that support SMT (hyperthreading) schedule the bottom half of
the KFD interrupt handler on the same core. This makes it possible to
reserve a core for interrupt handling and have the bottom half run on
that same core.

On systems without SMT, pick another core in the same NUMA node, as
before.

Use for_each_cpu_wrap instead of open-coding it.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f5853835f03a..5b12ae69a301 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -24,6 +24,7 @@
 #include <linux/bsearch.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/topology.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_vi.h"
@@ -801,13 +802,24 @@ static inline void kfd_queue_work(struct workqueue_struct *wq,
 				  struct work_struct *work)
 {
 	int cpu, new_cpu;
+	const struct cpumask *mask = NULL;
 
 	cpu = new_cpu = smp_processor_id();
-	do {
-		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
-		if (cpu_to_node(new_cpu) == numa_node_id())
+
+#if defined(CONFIG_SCHED_SMT)
+	/* CPU threads in the same core */
+	mask = cpu_smt_mask(cpu);
+#endif
+	if (!mask || cpumask_weight(mask) <= 1) {
+		/* CPU threads in the same NUMA node */
+		mask = cpu_cpu_mask(cpu);
+	/* Pick the next online CPU thread in the same core or NUMA node */
+	for_each_cpu_wrap(cpu, mask, cpu+1) {
+		if (cpu != new_cpu && cpu_online(cpu)) {
+			new_cpu = cpu;
 			break;
-	} while (cpu != new_cpu);
+		}
+	}
 
 	queue_work_on(new_cpu, wq, work);
 }
-- 
2.32.0

