Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA2AD5B158
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 21:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93F710E57F;
	Mon, 28 Oct 2024 21:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/gIazuN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438C910E57F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 21:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv94ERz8e/9RBr2LLFslJweN9ysqFWQp86MAEWRGfliWgD8+Ebnm5W3RDdCr2rXBzDUei+/pgc3BwKLySDQT19RA/S1XWYfyGkPQInfyCcaqz7aZ9qnQpRWqnxrMUHghamYWJuqj/DAk6UCbgtpPUUSe6cB9OKWCvjlRjFrGVhIYYgYeiPKjjTLStk44dnmTp/U00DBQh80GRwen14XLNM1lOiBhr8UTKp4KWRlg8BStZ5c6nCRXLMPumyooh4yAarCaaaSyIHF7WaxHs4R8sv43/O8pmA2b1Sq+/Jq6Ww4RWjhMGc6TL6OfYbk+tP5nvM0SCz0HhoSrNDivJ3YeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcJvyCIwSGccxBSAmcclUdt6FKt3PySFB2tSGarDskU=;
 b=XqAaF85RcrCGcQSsybEclHv+U5llDDy2KieN+rx3Z1HCBNDnZmcpTX2j7/NoFRtwtDglETTvdt/2fipsApaiwzS16rjy4ILZq41lCx68THGu3KdTYonnElDRGLHe/LMF0oVRtQ9PhrrtPcpRJfFcrVtDYncYGPx20sO30K8DjoTmnXDTha3BpmXaxe1KZHRPEfsmNMBDRp+y0N/iiroew9L9iC8wNvDVEttlFS+GQvzR/mAdhMlfUIZZ7W+jsG+G8Tn6DUFPfNlU32VfKXaNGHcHSPcdsCMHSV4cruCqkC4+zA3S17LYLDg2ktaJWc5Zyi4kuNBSukapKiA6JOv9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcJvyCIwSGccxBSAmcclUdt6FKt3PySFB2tSGarDskU=;
 b=z/gIazuNm/TsiCkbOhPlxh/COuI9J+5Z9KJo3R0yDwUC7ZxTFrMmX4BtMBT2tQgiZBhYS5fUn6fGA0Ct++2P8s9k6F/Fw+tsbakvp0oNGLnlPfkBcLs0AtE2NlkGjZO1kp+/K2QYpAcvlnrBEWJBurLDrTN8uc/4WESAU/OQffc=
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 21:36:29 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::c8) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 21:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 21:36:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 16:36:27 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 16:36:27 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Differentiate logging message for driver
 oversubscription
Date: Mon, 28 Oct 2024 16:40:14 -0500
Message-ID: <20241028214014.59940-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: e068888f-3cc9-4847-12bb-08dcf7989520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OjCNuqBMbpPhmGxFthmXMUdbYga0JJEKeiUZBwVXIuYktNMeP99STlcm72cy?=
 =?us-ascii?Q?QldTwf3lVgr4C7kHouTFfyf7hYWmjjJVd1fpLnx0VnRfZMyUc1TQuQCs1X4p?=
 =?us-ascii?Q?y5IX+/jQhlWBs7dNtyzCvq77CPUp1V8fF1avMCupvVQdnDwybAVDahwXUJ+I?=
 =?us-ascii?Q?k7O3SvKe4Zhi6wFD/oqOtH6zZn6QaACluHz4oEmQ0LqkotzIsuvLTHQd+ygC?=
 =?us-ascii?Q?z7YvLnGJVGIwo8thECfeE1belmLLTRiNqRWPnkqCxwjwGy73Ar8lLPTClswl?=
 =?us-ascii?Q?W9bQu39JsXVQHBb7XBVmQYkTqLI0LNiNQDipL225nQsqGofILoMdvc5QO7hL?=
 =?us-ascii?Q?9X3iAYvWcXImYMN3KUpBjObww/Z+9SVDB7c/ckY+JC8Uf+SFn+XSbCt6F8q3?=
 =?us-ascii?Q?3DHMhQ5I9gvGZfMsgB0u8HW7qePYslwdUkyWzTK63Z5oygBe4Qp95rkNz3Xb?=
 =?us-ascii?Q?WkNyaOLHxKL2mSV23JD26TnbzGNGXl0WBiV/yZ5+rCeQ9xlCeUI45Yz4RAcb?=
 =?us-ascii?Q?DaO7BxvUssjA/jKZIBJtm6iD8eLGHXMUftaPnuf6KDYObRG9M+k9E16mx9/s?=
 =?us-ascii?Q?VXUAbuE42zf6zrWq36ts60N3p9PB8bgC/yqi2aBpKRqo7p0VKdZipyPKsImq?=
 =?us-ascii?Q?bd6v/PqgUe+DU76Ml2TEvlXWdDN1JSfbYKpeUC+iWvIEveUjxSukYEwd6lsB?=
 =?us-ascii?Q?6AbB3FrCUTj/8qV+LOV1Nwp+TAhS9NKmrAUeVwpQfjLHIHncXR7VaOEepGJm?=
 =?us-ascii?Q?ZwRuo87o5XXsjbKTm4laJJ5PC0zCNYakGXoMtweUeSOWRh+9lriBCZWQqaig?=
 =?us-ascii?Q?5opFWnlT/z2EnGGTe1twqW8SKHKGUMwgGaNP5j7dk4rIjVZ9hlUZi/Q4KiWg?=
 =?us-ascii?Q?4thf3lZCKctMUKLZb/111U891fRrJCfNF3CRUx02mvrzBhaTgTrGetkmV3vn?=
 =?us-ascii?Q?XwTcl1DTDewiwKeEZvdGWNINfdC0DZRLZwZN6aRbDSq4dyUn7gRBnnOClsDo?=
 =?us-ascii?Q?PMOp55M/q/h3GEd+W9+ZLn53VFaT23EVkY1wioD1z71f7EaCofWnP0JAsnBy?=
 =?us-ascii?Q?1lhyfdCZGcaEIWYroaISIx/iCfGD7cWv25yHT+c3QB44d0IlszGM7otZsj8j?=
 =?us-ascii?Q?MvWLC+yWYxw8Y6G8F+xuiOqnO8XQPDMn8Clwx5dJqiZfkGZwHYlE9hC+W6Do?=
 =?us-ascii?Q?WCW032682EQOpuKX+OhipiRcFBob4YZ1hKXb0kEIWFd+u/8a//CEGJCVArdA?=
 =?us-ascii?Q?KxHdvquQ9l4DZhD6jGlCfKWQ/gFD4lpYdLn19fhyQbaT5eG1vdxh5GC+ILeI?=
 =?us-ascii?Q?fnXRCikmVseJ1jtZ9iTjO02jWagm7/eB10AJ9gop47W9j8+cL5qqbV1TbnPv?=
 =?us-ascii?Q?MtI2YNYNSV74IdGc392Zmy84sSjBJujQmCMPqXUHinRwjbb6Hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 21:36:28.7202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e068888f-3cc9-4847-12bb-08dcf7989520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

To allow user better understand the cause triggering runlist oversubscription.
No function change.

Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 37930629edc5..e22be6da23b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -28,6 +28,10 @@
 #include "kfd_kernel_queue.h"
 #include "kfd_priv.h"
 
+#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 << 0
+#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 << 1
+#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 << 2
+
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 				unsigned int buffer_size_bytes)
 {
@@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 
 static void pm_calc_rlib_size(struct packet_manager *pm,
 				unsigned int *rlib_size,
-				bool *over_subscription)
+				int *over_subscription)
 {
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
@@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	*over_subscription = false;
+	*over_subscription = 0;
 
 	if (node->max_proc_per_quantum > 1)
 		max_proc_per_quantum = node->max_proc_per_quantum;
 
-	if ((process_count > max_proc_per_quantum) ||
-	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
-	    gws_queue_count > 1) {
-		*over_subscription = true;
+	if (process_count > max_proc_per_quantum)
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_PROCESS_COUNT;
+	if (compute_queue_count > get_cp_queues_num(pm->dqm))
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
+	if (gws_queue_count > 1)
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+
+	if (*over_subscription)
 		dev_dbg(dev, "Over subscribed runlist\n");
-	}
 
 	map_queue_size = pm->pmf->map_queues_size;
 	/* calculate run list ib allocation size */
@@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int **rl_buffer,
 				uint64_t *rl_gpu_buffer,
 				unsigned int *rl_buffer_size,
-				bool *is_over_subscription)
+				int *is_over_subscription)
 {
 	struct kfd_node *node = pm->dqm->dev;
 	struct device *dev = node->adev->dev;
@@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct kernel_queue *kq;
-	bool is_over_subscription;
+	int is_over_subscription;
 
 	rl_wptr = retval = processes_mapped = 0;
 
@@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	dev_dbg(dev, "Finished map process and queues to runlist\n");
 
 	if (is_over_subscription) {
-		if (!pm->is_over_subscription)
-			dev_warn(
+		if (!pm->is_over_subscription) {
+
+			if (is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT) {
+				dev_warn(
 				dev,
-				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
+				"process number is more than maximum number of processes that"
+				" HWS can schedule concurrently. Runlist is getting"
+				" oversubscribed. Expect reduced ROCm performance.\n");
+			}
+
+			if (is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
+				dev_warn(
+				dev,
+				"compute queue number is more than assigned compute queues."
+				" Runlist is getting"
+				" oversubscribed. Expect reduced ROCm performance.\n");
+			}
+
+			if (is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
+				dev_warn(
+				dev,
+				"compute queue for cooperative workgroup is more than allowed."
+				" Runlist is getting"
+				" oversubscribed. Expect reduced ROCm performance.\n");
+			}
+		}
 		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
 					true);
 	}
-	pm->is_over_subscription = is_over_subscription;
+	pm->is_over_subscription = is_over_subscription ? true : false;
 
 	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
 		pr_debug("0x%2X ", rl_buffer[i]);
-- 
2.25.1

