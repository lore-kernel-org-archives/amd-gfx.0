Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8D4CD98CC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 00:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E26610E8E9;
	Fri, 12 Jun 2026 00:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O1FecpFf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4889D10E8E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 00:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOrqOVwyX6VPEIBnvvM0wySr5nKHV97Z/7cd7xONuyNMY7U1cavMVWgdG4jRDR/AOG+Y/EH3aQmCTHfIeVXr0DWJSahiQwkv3vtFEZXXskIPTXJ8RBfNAavSbb04pOenP3fI56Of6vi16fwtLaI1TIgnjxZ1Kl4KSDKoSAu/Tywa/v7Ie3If2svSxJAYLS/11VfF5OUqE8pQibJAA6Dap2eq+PXzAdsslfFiqy2RBi7TD5CEkp8fcX5ICVGjxC4ewqFUspZ6j6zDZ+1YJYLmdyqOSc662iHQBgnLbuzkVFCg6KJsmKBRficO3ochmPbQLogRZlqehnLmhuCi5itBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7LTtreomjkivWRtKerz0VN2kdPAyZnPX4L7FYGsj6M=;
 b=i4uNdoz8d50f4dL170WgiGGWnhYT6S6jxRd4oldopnof5zk/AqosEwwZYP3Z7renOECgXlQ0BAfIVie0NacAoYJzFVtCSHnU0xgQe+cylpL+NoCC30qhDSZZSYmIvEci1Fhnh+mGBgBadkYKJcA//Ys8Smdp/0ypVXxJpcp4awQb+eYCc/WZgZoqT06zhlGgJ/A+iK24cnLzCy2sgW6Y6IGbzKdooavD07dyLi4Y0qfG2wmCN2Z/0lco/t9t7+ltwGdV8cRh4Kh/CP/b1OeAOEpAHBMmUNc78r0oFrm7xfvr5IfIFHIbl2j4hzXjkv6wfwVGvvyEBJVEmsDiEH8Tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7LTtreomjkivWRtKerz0VN2kdPAyZnPX4L7FYGsj6M=;
 b=O1FecpFfmlYl12WIIuTTs4wSUuZ4/NPZur5HMdihm1MshuSnY8qty9bbWBY3Eie0chx9wFA1Y4u9CjY5h45c5tyw2c+YubI4AVm3LyeaCbg/4NaiF82f+LwowkknBItoMkjDD+2tUbNvtxeQfroMwW4Hb0xGLUFhgqHphunLxPo=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 00:04:55 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::61) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 00:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 00:04:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 19:04:54 -0500
Received: from amd.com (10.180.168.240) by satlexmb09.amd.com (10.181.42.218)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:04:52 -0700
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <Felix.Kuehling@amd.com>
CC: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH v2 1/1] drm/amdkfd: Fix NULL deref during sysfs teardown
Date: Fri, 12 Jun 2026 10:04:07 +1000
Message-ID: <20260612000407.3734265-2-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612000407.3734265-1-geoffrey.mcrae@amd.com>
References: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
 <20260612000407.3734265-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 77165860-5734-418f-7601-08dec8163bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: m3AqDp93aA11L/FYMF8lWTpikWIdufmYveh0bfHYd7EtyPONEx+KVTeV/9B2oNEzpDOG3rDBUgwkogZRv9uacqXVZRZQnoDqIEMHZmmblr6pDcvvTvGf6tCYEPMEvaexa9p5zcK8EtWw6DS1AW7qYZUDjYiR8pDZ8W52L2mN/OUDnJDJr5Wc/se12ECSDOpVWFrgTSNU/WwjcB/8EqlukEvCylJIZDKPxz0bnBkeJJ6fqBIfTfHjivskkhRtVs9QxZ/1pI5FiEx9qjYUtq4lXNIhOpY1rCZYI4JiSmwqxkFqr4dprqj76Hm0ktGVMizjPImaEI3tH1BNYqhjRKT+2hnQ6jhH/wnFQN+9BSQjd1r2jC1Ty/v5Y/QpwZVT4SdBzP1Zf5JtdiAp3WeGP3kJtZUbGsGw1x0PINClHKYKX+LhoTS8gjZ/pg8Ef/DL1G3BE+kJ2VbqdssbE8CPZBPeadjOksfAwezuTuID6k2P956Cytfui0C4X2lZql4blJEHNfyGoDI83MaNzMEGgM3OkA0WuoOXu8nhoJW8XXABQWJWalKWoHCXt6nVX2prNcLuTGz91k37WyZPoPeUoWTez751HjP/1Lb67fyWwlPGt9FbA/3hBhMhiEMREMgIsNKT6rMIFpgbdewVUCrl3bvsVaOmvZicV0wqyfgl4jp6cnb0LgJG4AuTbiVJQYqvz8Ffe5spVBlwYEgT6QnQzZ9SpWP6mPDaXJ61J/TM1gqngyM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YXS08krFHoGJ7aatZs4btqU8pS1h22JovVZ/MFDA0up3UNAaIIeXRzB1yQce+9ZPTIUWoJxPi0l7v3k+aPJ/659pMcLVXwgHfQ+D8JaWR7P5T85UVPB2AqVgkrgZzJyQQyPIARLgJSMkHWGKUk7H7XaDXAjQV1hDHU4ER+gT7WxYR6uaAe0hYIU36uAgxyUvESnwuhiPhNwXuC8YakRhQJzKgsUICpixxZ6vImidW3aWNd9rK+xweIGP29BvH2Oowb+Vni/e+kd4qLibrs6CqE23RwJGGGM6oGwBQbP+6WDTq+gZQVj7+f/4wykjsPayy0Rw3yeet6KNDu2sMhe0PwNGaFHJWJ/+D6jF+4MTEgB21CgGfcQTEMzDsaDDGMYtaYArA4ucAOJhs7KqoVMgD5U5Be4277t+Q7tMlUw6AD8x1Jp6l8p9Nux3hGYEs1UP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 00:04:54.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77165860-5734-418f-7601-08dec8163bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

Move kfd_process_remove_sysfs() earlier in kfd_process_wq_release() so
that all sysfs/procfs entries are removed before tearing down PDDs and
dropping lead_thread. The per-process sysfs attributes are backed by
struct kfd_process_device, and their show/store callbacks dereference
PDD fields. Since sysfs removal waits for active callbacks to complete,
removing these entries first closes a race where userspace reads sdma_*
and stats_* files after PDD teardown.

Previously this cleanup ran after kfd_process_destroy_pdds(), which
resets p->n_pdds to 0. This ment kfd_process_remove_sysfs() could no
longer walk the PDD array, so the per-PDD sysfs cleanup did not run as
intended.

This race caused NULL pointer dereferences observed in
kfd_sdma_activity_worker and kfd_procfs_stats_show.

Also harden kfd_process_remove_sysfs() against partially
initialized or already-freed objects:
- Check kobj_queues before removing PASID and deleting it
- Guard kobj_stats and kobj_counters before use

These checks prevent invalid dereferences during cleanup.

Fixes: NULL pointer dereference in KFD sysfs/procfs stats paths
Change-Id: I405b8fb95d3c5e163dfc45928da54f31546d92cc
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 40 ++++++++++++++----------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d28ca581cad0..63b80d34c112 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1160,10 +1160,12 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
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
@@ -1171,17 +1173,21 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
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
+		if (!pdd->kobj_counters)
+			continue;

 		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_faults);
 		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_in);
@@ -1239,6 +1245,13 @@ static void kfd_process_wq_release(struct work_struct *work)

 	kfd_debugfs_remove_process(p);

+       /*
+	* Remove the proc/sysfs entries before destroying PDDs. The removal path
+	* walks the PDD array and sysfs callbacks dereference PDD fields, so the
+	* backing data must remain valid until sysfs removal has completed.
+	*/
+	kfd_process_remove_sysfs(p);
+
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
@@ -1252,11 +1265,6 @@ static void kfd_process_wq_release(struct work_struct *work)

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

