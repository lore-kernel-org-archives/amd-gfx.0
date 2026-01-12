Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607BACF45C4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 18:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0670410E111;
	Mon, 12 Jan 2026 18:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qglMOsxK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6AD10E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 18:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/3ofy7bvOFVQ3GHyhANz5CBnfqVaLGEDFkwYr15JflrS4wXWaDmG2yd0fCjh14MFxb18dXZjtNk4JW6URCGlYCSvfgh/iwOMyWJZ9zr6/MzU7LwJMaT5/BklfDV03cp+Bq1gTE+872yTxZ2KZlwG6Hhotcqa0SbONllZ8+GbFeuVxEqfIImuccft8QcrOXTm/jwlU2/xa3x91emZARG91t+hDh1DtRyNw2iutHqFasnqafRfYYcckuV7dSmR2bHwfYIYTDr8yGqE4BF8BzcEk6MNRUwJwO5PC1GDoDVWl/x557LP4cHb0/T/mmnDYvptpATEvPe1a44DVTaciJu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLCQcmoBkYa/LlpEOO6QOIwDeMsOPMBVkhmFPQ89NAM=;
 b=vKvJ4mlEp2vR5bhRcDUghop5eRKqTOAabmHKodHxbgxfiSHhnn7Zikd8Hxjs3nP74GmmPjZQ9YV6Ki/faMf9J4yvEOtbklnDPYHkSFsOZI5MRPHopvaQvmOS5sTHURH6wopGxUNQ7lAE0Hh5ZJO+MnjCavS86XQjYodB5NcSOuyuIuJGlPDOSAU2x/9uf9aAUVVlTswZwH+x/VI9yLO5mXWYixBuTs8Wircw/KFCQVIs3Giwb76B9V8YbHCIHft/WMP8GAy+IasgbOIfrjRfsEsgX1QDET7FYY4Ndnrk9tXMbOfRihafp0A1BJoH9rzxRwlGGekhmjQ4IBkWOTaRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLCQcmoBkYa/LlpEOO6QOIwDeMsOPMBVkhmFPQ89NAM=;
 b=qglMOsxKBknw6O3KHyTDG8fc7zQ3OkyOyFpJEmcwqwzLoQX4HUtfXERj0UEjS7rn73tRfR+2bLj9Uq7EDy162Dy2t8Bzc7T8N22e9RDim97C7MO+djk7r0+OKJDHYtkRBKG/hgo9JUOkZkxx984BrzoOXwHT3SJuekVRk3GueW0=
Received: from PH8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:2cf::15)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:29:43 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::87) by PH8PR07CA0034.outlook.office365.com
 (2603:10b6:510:2cf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 18:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 18:29:43 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 12 Jan 2026 12:29:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Kent Russell <kent.russell@amd.com>,
 <Xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with running
 processes
Date: Mon, 12 Jan 2026 12:29:25 -0600
Message-ID: <20260112182925.347303-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: f96edabc-c6dd-4fbb-5eae-08de52088e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZuVGRVzwoF+X68LdHPbKS8MTCDJzPVMwKByZfS0hXgrT4X5VMyUGB91yfj2N?=
 =?us-ascii?Q?FqbvDS0K773jvmEeTAHJPUVN9qVUNqFH4u2m/mSnenplultGxk+rr9Fl0ZOu?=
 =?us-ascii?Q?g+jcKLt5m3lyzT9kCZ7sxcN68lz05bmEJmj5I4lzu5XromUfyOOjPKUArhm0?=
 =?us-ascii?Q?DTCCibEQTI3FQIPut5d14jF2XnnQvYEm4lUs8Dc989qsDYF5dqFoa758Q9Tg?=
 =?us-ascii?Q?Tm4KHgYMRs7CgavzTal9h4ub7fUxTpxhUaUl2xJDom7kUnembMtT8mU8EjrG?=
 =?us-ascii?Q?UgE1FQNP21VHq7nMi5BNE9n+3roimuxLCl1U6fY2c8RmFt3KaedQ9EgCyfWo?=
 =?us-ascii?Q?vtTJ0moU0qz3n7PVTymJK5czpw/Iju3Zzsj0TNYzRucDdPYVQ9CBwcT5u+/R?=
 =?us-ascii?Q?P+unsG9pZVe/TIeMAdpOXnV9QluheX0IzHHNWh6VQKUN6Glu4sWwE5J+aHdQ?=
 =?us-ascii?Q?95YGk4sBPlX4+eEERgoDU02mZ0qibqbYaNzOJisWmtkO/+njyDHvbyZ8gcVT?=
 =?us-ascii?Q?a8ruePxJrJwUMYmumgpxMqlmABT+Mvoixihnn0iGo77szzRC0VKWfV3T6sqD?=
 =?us-ascii?Q?IYO5SL0yt8qg8aAyTAWZCHZNqkkYYW4J51g5wS+4sVv3qNQMvHe66tsUUfjY?=
 =?us-ascii?Q?f3uEkPFwcf3pchu3WE1jYWnd9sWzLpQQ+GaCtohDN8c4i7YOqzjBajTdIq98?=
 =?us-ascii?Q?h5uiRT3nwnWxLMV7rK9QvnQFMENjDBcqz3QohMGcubf31OFDWalD/ZtdETGw?=
 =?us-ascii?Q?0bcoOmmrfn4lH6bHmbnQ5WUF/FI2BHkPmUlaQ2iTCBBbWQrVzthUf9uhQkmg?=
 =?us-ascii?Q?RAQfObT9VHR82CgMTvLwPYsnm+wAQ8iC+yh8SFe56i02VUisF3owSHVWZlLl?=
 =?us-ascii?Q?C4bhCeYv3olR7ZP8RcWbH14MpVwkv9o/5ZUYTT/U9FajYUZo+noYBaRGqCJF?=
 =?us-ascii?Q?TrRgXxTJWmD8ea99cICUuV4NRCbOXcasD20YiU0CONV9MjMPvgBEBO0FxHe7?=
 =?us-ascii?Q?2qVqDv9QN2P/fHFnEbJ+R9DgeaopAmUl1h6L2CiQMuEH2apcG2gcRVZmwyGg?=
 =?us-ascii?Q?NHwGHBQLXDD7UcFGNtGSfODlSnMPVFwfqxqH4LWlglovnKW8e2nbVuWvgLcy?=
 =?us-ascii?Q?HeryBr3CdJR8vE2GgXi6Fl050TogouA6Ojd0u/kFPekwJIdmvmXO9sIej+ec?=
 =?us-ascii?Q?EivxTyAQ4Qgo2eWloG3SZNis6UupjgGohoUqpBjtBiAoVQ2GwF7CCR7nZ+Gl?=
 =?us-ascii?Q?ODu9BbTFERufh35GDawaP+jCIkqjx0vkad0HrihUn9q38O0Y3va3Y1zRdST8?=
 =?us-ascii?Q?aEtX8VbKfjaViqtTNqbZ20IFNPCyRFokIHyoo4vyAu5D6uo6jb+e3As/rNRF?=
 =?us-ascii?Q?0XsxOhLkLebnk7Cu/bCjcQRNb8ok2UWy37Pu1DHn2klvyA6RlH9VCjfNG1aV?=
 =?us-ascii?Q?wZJw83TBam4RmNH9sxHEP+RUSCHR0A0ltc7mGYHFWuBPP9U4Ff7mhTvGX5gx?=
 =?us-ascii?Q?uLZXqHVxWoNh+K4pQz/8P0oJQuIqM8fsemKvKrrQjvd8zC9myysFS5YQE71O?=
 =?us-ascii?Q?JOIh9s0W9sdPxyu8xWg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:29:43.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96edabc-c6dd-4fbb-5eae-08de52088e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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

When a surprise unplug occurs while a process has active KFD queues,
userspace never gets a chance to call kfd_ioctl_destroy_queue() to
properly clean them up. This leads to a WARN_ON in uninitialize()
complaining about active_queue_count or processes_count being non-zero.

The issue is that during surprise unplug:
1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
2. It calls amdgpu_amdkfd_device_fini_sw()
3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 || 
   dqm->processes_count > 0)

The warning triggers because the queues were never destroyed - userspace
had no opportunity to clean them up before the device disappeared.

Fix this by checking for device unplug in kfd_cleanup_nodes() and
calling process_termination for each affected process before
uninitializing the DQM. This mirrors what happens during normal process
shutdown (kfd_process_notifier_release_internal), ensuring queues are
properly cleaned up even during surprise removal.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Xiaogang.chen@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e9cfb80bd436..7727b66e6afb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 	flush_workqueue(kfd->ih_wq);
 	destroy_workqueue(kfd->ih_wq);
 
+	/*
+	 * For surprise unplugs with running processes, we need to clean up
+	 * queues before uninitializing the DQM to avoid WARN in uninitialize.
+	 * This handles the case where userspace can't destroy queues normally.
+	 */
+	if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
+		struct kfd_process *p;
+		unsigned int temp;
+		int idx;
+
+		idx = srcu_read_lock(&kfd_processes_srcu);
+		hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+			int j;
+
+			for (j = 0; j < p->n_pdds; j++) {
+				struct kfd_process_device *pdd = p->pdds[j];
+
+				if (pdd->dev->kfd != kfd)
+					continue;
+
+				dev_info(kfd_device,
+					 "Terminating queues for process %d on unplugged device\n",
+					 p->lead_thread->pid);
+
+				pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
+								       &pdd->qpd);
+				pdd->already_dequeued = true;
+			}
+		}
+		srcu_read_unlock(&kfd_processes_srcu, idx);
+	}
+
 	for (i = 0; i < num_nodes; i++) {
 		knode = kfd->nodes[i];
 		device_queue_manager_uninit(knode->dqm);
-- 
2.47.1
