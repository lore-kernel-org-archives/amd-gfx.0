Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE234CD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4770C10EC73;
	Thu, 11 Jun 2026 03:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKYLYS7+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9FF10EC73
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXB/LNNRftGg2zTrdb4pJqbSZPf5UurJDMpb6LrNjay2MkSP2CGz9+n9MYT5B5AP8O/RvLBxIMqsZ5pEPze5DaF3b2khxPw2JU1qAfwTH7aGs0A3B27SiB4DMELGu11yqbKgFDbVy9GH0csNX4iAthNthHiPg8AK2MwY2+DCu8xEw0j48iMckieWGXob2jDpDWA1pC68JMJaGoBYEhH9cTb5JdrWZK09Q96NHkaeUKP0ixiaTZj01SjXAvT5Qm+uZWNSr7G95oPO5b1Wto1gJdoMp3e+xr0/XgpjyL0CfmjeLsFUaG3FBxqidCQ6jV2gJE0oveuD1MHiubEdGZRZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpNkA7Yb1zaOlZ02Z4ZPa1KPY+S9mfKjqT6iAIimKHc=;
 b=WAzApsfd4flyUspGJAR/MFzcrsV9U3h02jBp3Jv8OveHJ3D6jbAeYqOEzR4I6C3fHwcS3IvSKXJ/GF5HQfNZmhIZ+bHF+6BksvDav4OcpnEVhMVWAwipwGrgMu8NnhoM8JTMp29+UqJv1Sr7k5K8qY6mwaQX5SQ+PcyXmJP0Of1C0sJIpTqVpeNR5f8Q0oGo6hE/HWHDy5UeP5gJtOA9Ieec2r0iUM0xpBgfSkpoMZhO7Srt5lEr/ZO/KhSfhMhqZUBpogz74+Q7rX1unI/9HhYRcmpPSFedV3GB/79uYEX06r9TuDVxOk4HvKCT6xpuecTayuzww2/LWam9RGE0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpNkA7Yb1zaOlZ02Z4ZPa1KPY+S9mfKjqT6iAIimKHc=;
 b=HKYLYS7+ROt9pkWa9mWWz5htpOWWUVjG/vP9enS60hsKvlnXflU7+NcqMNSoh+qigBGi8SYNue1PzpNEVQf070EVHTfePZTcPG/io9aet0mxOR5ylSOMSpdEkZGqMMX7SqM42mX7kKye9jKWUNeWTajS6RKFJwu+s7Gow+eL13M=
Received: from PH8P221CA0066.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::6)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 03:10:50 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::22) by PH8P221CA0066.outlook.office365.com
 (2603:10b6:510:349::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 03:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 03:10:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:10:46 -0500
Received: from amd.com (10.180.168.240) by satlexmb09.amd.com (10.181.42.218)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 20:02:27 -0700
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <Felix.Kuehling@amd.com>
CC: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH] drm/amdkfd: Fix NULL deref during sysfs teardown
Date: Thu, 11 Jun 2026 13:01:50 +1000
Message-ID: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4089f2ee-c60f-4160-04ae-08dec7670a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: encryFIVS8yK727pT6Jib4zZp79qKi5ia8q1QD5lGRkIwzu4I/WvRau0d/WuU9MxjiSqtt/bD0WOi7EdWwSq2uQC/voQKIRS7aKr49RcLI5jpZlndkFGZ2KdEYc11j5GuUeBujYu4cTSwbTBbNmnqXkmLmw94pV5hOayjgaYQR/27GoQdv8tYtEiijijfYlGG5uNLgCj4MCM0AHnQvuiLExGECcKvroPjFqq1udhpHGWBGHwVRvHWaimYNjQcam5ndJ5Qq64AXrrx7FcpoXrOlPSQELZVXKmbW2a6cptqEUQdWia4dguqr9I9llEJDGgKTTA0H+L5vtN2AiFp0D7WrRdTvPc2/Evai7YYrX/pe/6isfYovV3FhfQqp1zpXsuSD+y716X0FSFVXRWE8XRmSB2kTmhdCR3MnxRsNihKMiEskcRRtkgFkzFM4c4pwwty72n1a9xD6J81OHYsFNu3IHB2ZTV4oZjjU8w2KjaCx38kKuSDbEp/ra9WsgUc8HBfVJ3EsuMQLhX38PrYmWfND2Jx4wVi+G8lAG2G5u4Pfnjj9cpz0+ts4vz3YPWYLYQ+OAdf2JYdXhNKNGYogWFs5zZdwyDs4OUX/WvE5a3f1QZyUjzV8JaR1jkfBnLNuZf/popmu+BSoCjZwGO3wI29TAu87mF6NtY7vr42VZa5C+45Uc2mONWuFLjw7m7v7dTP935MKSZUasgbwjOdfDC3TKo5elh1f7JFZIOdUyTK2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w2TuJUpwWa+CyRQ8QKh1lKAySjGqna1eUO+1Q9Lih03x+tcAilyA6HfuRTHUo96v8kf8atDe7JgjY052kOvdeQ+ENiZM6Kg83wDT0JyadmI1aFFiye2W/l4wXPXCTlBdx9iycx2wYKSQc1tKykuqsDSDf5F7/CYS4InXT/iagwNrOHAIVTfxT937Jy9WFSxb4zaFnEt0KkKrRwGO1NhVi+oQx6seaOTRVJTRqS5XZ+zUkjyp/uC0z+Jyzdenqe0iRg6wZxjO8EcTQt4bL0LQ26gc/imNct71JTGjw8r8uGxIQYx5BtW3tQom753Xs1Zoch0oRr3TeX3hqRB0E1VsqZhsS42dXXfVzqmrUx0UHFLEQ9t/5xSgodL8x6s7NyCftUxorhlMwQ30s0ZOyStzwlE57/A7krjTGbQyIYMFpEI1LppK45Psnq893ChNknXw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:10:50.0573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4089f2ee-c60f-4160-04ae-08dec7670a48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

Move kfd_process_remove_sysfs() earlier in
kfd_process_wq_release() so that all sysfs/procfs entries are
removed before tearing down PDDs and dropping lead_thread.
The per-process sysfs attributes are backed by struct
kfd_process_device, and their show/store callbacks dereference
PDD fields. Since sysfs removal waits for active callbacks to
complete, removing these entries first closes a race where
userspace reads sdma_* and stats_* files after PDD teardown.

This race caused NULL pointer dereferences observed in
kfd_sdma_activity_worker and kfd_procfs_stats_show.

Also harden kfd_process_remove_sysfs() against partially
initialized or already-freed objects:
- Check kobj_queues before removing PASID and deleting it
- Skip NULL pdd entries
- Guard kobj_stats and kobj_counters before use

These checks prevent invalid dereferences during cleanup.

Fixes: NULL pointer dereference in KFD sysfs/procfs stats paths
Change-Id: I405b8fb95d3c5e163dfc45928da54f31546d92cc
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 44 +++++++++++++++---------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d28ca581cad0..b47e7dac8b2d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1160,28 +1160,36 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	if (!p->kobj)
 		return;

-	sysfs_remove_file(p->kobj, &p->attr_pasid);
-	kobject_del(p->kobj_queues);
-	kobject_put(p->kobj_queues);
-	p->kobj_queues = NULL;
+	if (p->kobj_queues) {
+		sysfs_remove_file(p->kobj, &p->attr_pasid);
+		kobject_del(p->kobj_queues);
+		kobject_put(p->kobj_queues);
+		p->kobj_queues = NULL;
+	}

 	for (i = 0; i < p->n_pdds; i++) {
 		pdd = p->pdds[i];
+		if (!pdd)
+			continue;

 		sysfs_remove_file(p->kobj, &pdd->attr_vram);
 		sysfs_remove_file(p->kobj, &pdd->attr_sdma);

-		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
-		if (pdd->dev->kfd2kgd->get_cu_occupancy)
-			sysfs_remove_file(pdd->kobj_stats,
-					  &pdd->attr_cu_occupancy);
-		kobject_del(pdd->kobj_stats);
-		kobject_put(pdd->kobj_stats);
-		pdd->kobj_stats = NULL;
+		if (pdd->kobj_stats) {
+			sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
+			if (pdd->dev->kfd2kgd->get_cu_occupancy)
+				sysfs_remove_file(pdd->kobj_stats,
+						  &pdd->attr_cu_occupancy);
+			kobject_del(pdd->kobj_stats);
+			kobject_put(pdd->kobj_stats);
+			pdd->kobj_stats = NULL;
+		}
 	}

 	for_each_set_bit(i, p->svms.bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
+		if (!pdd || !pdd->kobj_counters)
+			continue;

 		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_faults);
 		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_in);
@@ -1239,6 +1247,15 @@ static void kfd_process_wq_release(struct work_struct *work)

 	kfd_debugfs_remove_process(p);

+       /*
+	* Remove proc/sysfs entries before tearing down PDDs or dropping
+	* lead_thread. The per-process sysfs attributes are embedded in
+	* struct kfd_process_device and the show callbacks dereference PDD
+	* fields. sysfs removal waits for active show/store callbacks, so this
+	* closes a race with userspace reading sdma_*/stats_* files.
+	*/
+	kfd_process_remove_sysfs(p);
+
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
@@ -1252,11 +1269,6 @@ static void kfd_process_wq_release(struct work_struct *work)

 	put_task_struct(p->lead_thread);

-	/* the last step is removing process entries under /sys
-	 * to indicate the process has been terminated.
-	 */
-	kfd_process_remove_sysfs(p);
-
 	kfree(p);
 }

--
2.43.0

