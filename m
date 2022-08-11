Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB5AC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 19:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF21510F325;
	Thu, 11 Aug 2022 19:05:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DE711BD80
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 19:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKKGhtlisc+8CqdNhGYMyZNQLhKd+bTK6Rup8t3Vis25lEJYQZ2i0to+0o+5GcXTMJph/7BeTXS34lhk3NFn4g4/j7zYLkW9QxT8HgzGnyQ4zxBm1FgF+WBsHV7kyDYqxVSFLicw8qL6BoJUSd0ant2Qfe0/WnAcfZ8wcGTQnF7GrbfkJAI1hpUsHMi3/3o/+ozAXKYfYdlEy/a0PZ2WJjdlw2leGmr8+adJCz1mS3sq45lOdeaUAJ5o8bV6zkB4lSB3Ua6NdlZCzsyjNj5Z8xHzvON5q1Mka32tyZZIBkYTTMUTSpFVnBJ1/Km35+K/ZHpFA0HOpFR2/pM+8zBGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbb0djV94sxB0rhdwky4gjHQ3owlE65zaErF5mf488Y=;
 b=RUn2i4i3utOg5ALV4mC38MW+pMe6dhL/gybmFUcaopIYpfPIugRwul5M8MwMPXAjN3VYfVYMvwgd2JsLMr5x4o1V9Mmr4Vgf+I5WpqHX18hOowRCAdyyWshb1DwRQBkgDdFB/YVeg8nMTO5xKMyGZ6ZZRgTwLYXO890Q4XJxyjhIf1EPbKWWyX7ZhkqzBzGoLxEcCHNXjaOow0hIF3WAZZE10ox7KKPlDVeWUS3nL+XCEmwewGt6CqFCGwtoD/zc6HW4kUSY/KlHdog4ohoGGJbYPtfYdSdxVV2fX68M79bd0TN/+IEzEPcKCj24aZPk38ZPxwMP14mKYlmk5ZY5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbb0djV94sxB0rhdwky4gjHQ3owlE65zaErF5mf488Y=;
 b=c2SvG2NPPCC5ZfsmoYE5WHUEm2AgS019tPkMlN3P64T9dNCxVIGJoK2+J71ICUOhvYbulJvVGQYNUG9Hb+8BYU4HzmWoQnXdY3jYa1GoqveJQ5ogkQIsdxzMHlpaAZkpEwwQVNOjBj40iI4Z5dVlaCgF37D0ZeGePtOd8dpwLlw=
Received: from DM5PR08CA0046.namprd08.prod.outlook.com (2603:10b6:4:60::35) by
 BYAPR12MB2744.namprd12.prod.outlook.com (2603:10b6:a03:69::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Thu, 11 Aug 2022 19:05:08 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c) by DM5PR08CA0046.outlook.office365.com
 (2603:10b6:4:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 19:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 19:05:07 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 14:05:06 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Try to schedule bottom half on same core
Date: Thu, 11 Aug 2022 15:04:33 -0400
Message-ID: <20220811190433.1213179-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220810234109.935228-1-Felix.Kuehling@amd.com>
References: <20220810234109.935228-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cc71de4-e458-476d-5cc1-08da7bcc6831
X-MS-TrafficTypeDiagnostic: BYAPR12MB2744:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTonWfdXcQwvfFU4TqxisaqUO9XuMuMDuBrex1RcASjEdR7LaY7NvXT6SEXOBABHsuFT1bt9n7fFoAMHjJsurD/l4xLUDrV7QzBMilk1DbOPNhWH9bIfJgtJb1Tof8rrJsVBYFeuBr8QKgv61qCo9310itP1/sq6qH1OpKMMnLts2ajzeJFKKJbYGrvLsp4vEneYO2NTGeiMFzmckTCcUPuCoOUT8R19zHiJYSRDUIkplDKedPgPX9NZvrPuoYXQRbShLELLetL4f6Le3nFvVXb/2fV6GhjzkdBc4fONCVmnyyrv8Mei1HhmfX0gxtcxaZq0pV5GbE5HDvMAUMsn+P0fe33qi5tbdX7SGFE5mz2UKtDwJY+Vh9nxjAPPcYnxN9qBWXBRBzDRJ+lY+mM4LKegdSMjWkwQCxSG95wQmtDdjn6ihOH9yoK2HiV/HBC2wfH6wC5g3vJZH7NfNJzeGbfaM3KrGMicetVIgbIqSBhqmH6HN/V8AMKlFNF9nGYNXcQQ3kf2qhIiegYckrZB7JIJtFPzOs+Qg2AFcC9G/z7h2DnIie9JK6HU2x1S8mlo9HD5e3C8V2BidhASOJxmr9OqVn/ywCHXEiHrzEapvnZYZcBTM2ug0K/4A0wxR9KSYNZLyATv5trZQ/hQSEBjYamNTXAJ3Aio/bjS5IbWKFKUIN0bzGs/ImSR21XAYJz3pW7vAlp5BOtUhDjhQzapHvWvsNh4bZ0OqNk4W2xrvZ6wLGC43sP9upUB3Dow6BR3soiMErknD+V2pm6nz2iNl41njx4pWw9/xuNaGPBWafGnAnIZ26o+rk8alI07WMQLb8Or0yzErHd6MoJ1uEBhQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(4326008)(26005)(83380400001)(8936002)(2616005)(186003)(1076003)(426003)(316002)(47076005)(86362001)(336012)(16526019)(6666004)(2906002)(7696005)(36756003)(40460700003)(6916009)(8676002)(82740400003)(41300700001)(70206006)(40480700001)(5660300002)(36860700001)(70586007)(356005)(81166007)(82310400005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 19:05:07.7019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc71de4-e458-476d-5cc1-08da7bcc6831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2744
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
index f5853835f03a..4d1284714e7a 100644
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
+	if (!mask || cpumask_weight(mask) <= 1)
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

