Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3CDC54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555CF10E3CC;
	Tue, 27 Aug 2024 17:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cGI4tWZO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A404E10E3CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aG6aNMpo/VqgRwWOjZ4Ahbx3UTcf6RNpRj4w+5Y2s23jL8NyCG0zEWdAtKUwH+LWl9m1di7T2+eUYxCeqDMQRRlJleVzzNytDDxGfnpxQvwk52elQ3GlVhy+ehj5q0fiyA0jOCOSGvA8y617dL4DxWsMFD/pZFE5sKd90O5MDwhhqpKKAc2rYi505pnTLKI02KGvPk1xEFP+O1ud72/5QN83ERrmGrDu8yQdpHsLWwNxDVvEUTSJgSrgDhzQz1CbdTzIInBOfUa1A7N3VOh8UDLLchsi7nDH8Za9b18csoB5xw61zoMUq13q93OoSIcG+QnkcVmUYYbjyz0jk60cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz3ephkYM533R5f4wjk/eZ1v2+LQM7u5S8afKsBGSqs=;
 b=xZZFLJAqdz8/D5H5P7qSeTDnCupmvT2YBANIXFM20mLkpPZZpNhS/lQDH3HtvJ2i5DOzZcNNRCP0ezX76Est4FNwXX/rc8NeEGYT+SOEqmnS8In6a4q+85GSvjvz8k3/Xxo0JAmYqgklAFcBkoGcrn6Dd0xiY2n/WyZ+6I8uReKIaRUbZaRhr1gQPXl+0syVMDDTW1TDec20OxOxVeriIvj56A+Z/h67zrLgMR3OVNqgKeWY1cN8iQqAwfpvsrNKSAWejixDTT5qjjFDFMG5NSXG0vvf6EwmT6LCjXWJR3YjBRHWVqCVNZ3uO50NCh8qV2q6j5TI18AZrHa804geow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz3ephkYM533R5f4wjk/eZ1v2+LQM7u5S8afKsBGSqs=;
 b=cGI4tWZO7QS5ruKTR1LEr+ekPJoxo+7PC6zWeRKWGMDm7puWSUd8/t0a66DsbgnuRLQepK6bwqkcYzlzLL8GFY8hakhO1eYz30WRG8t86lfGKnHe2DVl8WhvEfsjEG/E2GOm7YRntyKNz1gDx3EU6ETdBrt0OnvkCPNUZ6P1X9I=
Received: from BY5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:a03:1f4::18)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:11:33 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::e3) by BY5PR20CA0005.outlook.office365.com
 (2603:10b6:a03:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 17:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:11:32 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 12:11:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: SMI report dropped event count
Date: Tue, 27 Aug 2024 13:10:26 -0400
Message-ID: <20240827171027.12910-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240827171027.12910-1-Philip.Yang@amd.com>
References: <20240827171027.12910-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e51db2-1a57-49be-1f8b-08dcc6bb4c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cFGIj5/qywlKf89xwBa/OOcWIX4QWNDSzbNbQ9SpRgK79auMfsFhMrndZgHC?=
 =?us-ascii?Q?Xd8PDOBiKk12EVUl1xg6MMmBTq+wKpSerQVIs9Fs4fWzqCCZo/9g0Ylx9J1p?=
 =?us-ascii?Q?VK+K5ZAsO9XFd7dkF4/YHfarMUbaRRXe5cbUqULwlecB+CNgbMG9JwnGzi0R?=
 =?us-ascii?Q?Hqf465i3j+k3yQ5vv0CxJthsWDalV+9y6mREEOO9/rt8VDESLApFKgXHLx4e?=
 =?us-ascii?Q?DHJVAeI7TioFJnjFG2JIj3fOwyTKh9LffboFHFNHecd0rt/N2v5jW7G+EyrX?=
 =?us-ascii?Q?148hA5FzSXavbNmBi+6yI3MHp8etyddkt1vMUB26KvQxVH6Jad0AHFn9Cluo?=
 =?us-ascii?Q?7jTWDhcX+BTMcEvknycYabjNsY6inBBipvfaa909lzIdAIBvf2cww9uSMloL?=
 =?us-ascii?Q?VhJCegwrGNO5C+Vh2nNpnLvdzyT8QxtkRlytcJxoLydxBlnd2G1m3ghwTKy3?=
 =?us-ascii?Q?JZqmHLrg+iUiasKgBCr9TEprsbcm3IDIZMBZ2RxOkAYYFsxMmDHS7DM8KQg+?=
 =?us-ascii?Q?nZVjuG3e9UFt1PrORwoC4dNoZg2bNRE06IH5kgr5tz4v7u2RI9njCetTY08e?=
 =?us-ascii?Q?RYOMoa0gwXSW10RqgPGYCbk7w1IdABBIjzbVltmUeAyWF1E/kmeTv3rMm0/4?=
 =?us-ascii?Q?yBcqGMnXZtK9cxvvwRhovSKFNruwpRCnsfnYii0tgSAe1XPrb15AWqXed7mQ?=
 =?us-ascii?Q?t/ifoEPFZaJtqzrlAgesw/uIF5BUsFJBStnhk7nO4coOwof+Ikpj4sWe5LbR?=
 =?us-ascii?Q?mDYSRKrB6x/+fizRz1iH0l4o2k8wQiQevlsg/Zz0bR8nPsoIHSl067bHri35?=
 =?us-ascii?Q?shMK56VrlIPxW1DZPy8HaapfAMbdDly6+dehqUjhKx6O1Gwe1tZzUP3aWyGC?=
 =?us-ascii?Q?GXwu1S6pgP7nm/sIim+ZWtLy/I6/JS89WeAEH02onawnm2waIh5xYWVxKXg5?=
 =?us-ascii?Q?AzjdKK1T1rdF+ME8jXPqA/U78ie3PSap8i075fhB5cugkvWmStVroOcKOZGk?=
 =?us-ascii?Q?o1QuIg9yslyij5732iOYQXdfWdOxLKIUyugxFJQ9lQElb9N4Zkac32UqAjNq?=
 =?us-ascii?Q?MZKoNI6x1MaLo4SaYI4lSQQdSFIKcK5c9uqIpl/hCMF3f39VosdtVJykCOsp?=
 =?us-ascii?Q?LcABluhObg4fqwSHbwX2N+XSuE9UKr/rj295nYCjjefWg7/WEqBcy2NAa5Hj?=
 =?us-ascii?Q?kXVJkORq5Rr3aiJBXScVJPGLADFz+N7C1q0GLu9b6QoKAsRjK39NEZAr7zND?=
 =?us-ascii?Q?FCPS8R82wll84nulmxGZ0tElg39WfE5b/Ir51Hl80O0xaiqvmwN07g5+AX84?=
 =?us-ascii?Q?7N6ePbbG/HPLf4usErZHLbCMseJodNsXIgKXux5aSpGPLSu6OWOh2Nbz/wZ/?=
 =?us-ascii?Q?p+aRdak1pUx4qdW+Gp/q7CcbquBL8GzN2GOiu6D2hmZH8zXwkpqXhyow4y/1?=
 =?us-ascii?Q?/0d08TCyNGRuyqIgx7fWNI/T1e5O0aC/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:11:32.0651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e51db2-1a57-49be-1f8b-08dcc6bb4c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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

Add new SMI event to report the dropped event count.

When the event kfifo is full, drop count is not zero, or no enough space
left to store the event message, increase drop count.

After reading event out from kfifo, if event was dropped, drop_count is
not zero, generate a dropped event record and reset drop count to zero.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 25 +++++++++++++++++----
 include/uapi/linux/kfd_ioctl.h              |  6 +++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 9b8169761ec5..db321b8ea127 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -42,6 +42,7 @@ struct kfd_smi_client {
 	struct rcu_head rcu;
 	pid_t pid;
 	bool suser;
+	u32 drop_count;
 };
 
 #define KFD_MAX_KFIFO_SIZE	8192
@@ -103,12 +104,26 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	}
 	to_copy = min(size, to_copy);
 	ret = kfifo_out(&client->fifo, buf, to_copy);
-	spin_unlock(&client->lock);
 	if (ret <= 0) {
+		spin_unlock(&client->lock);
 		ret = -EAGAIN;
 		goto ret_err;
 	}
 
+	if (client->drop_count) {
+		char msg[KFD_SMI_EVENT_MSG_SIZE];
+		int len;
+
+		len = snprintf(msg, sizeof(msg), "%x ", KFD_SMI_EVENT_DROPPED_EVENT);
+		len += snprintf(msg + len, sizeof(msg) - len,
+				KFD_EVENT_FMT_DROPPED_EVENT(ktime_get_boottime_ns(),
+				client->pid, client->drop_count));
+		kfifo_in(&client->fifo, msg, len);
+		client->drop_count = 0;
+	}
+
+	spin_unlock(&client->lock);
+
 	ret = copy_to_user(user, buf, to_copy);
 	if (ret) {
 		ret = -EFAULT;
@@ -182,13 +197,15 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
 		if (!kfd_smi_ev_enabled(pid, client, smi_event))
 			continue;
+
 		spin_lock(&client->lock);
-		if (kfifo_avail(&client->fifo) >= len) {
+		if (!client->drop_count && kfifo_avail(&client->fifo) >= len) {
 			kfifo_in(&client->fifo, event_msg, len);
 			wake_up_all(&client->wait_queue);
 		} else {
-			pr_debug("smi_event(EventID: %u): no space left\n",
-					smi_event);
+			client->drop_count++;
+			pr_debug("smi_event(EventID: %u): no space left drop_count %d\n",
+				 smi_event, client->drop_count);
 		}
 		spin_unlock(&client->lock);
 	}
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index fa9f9846b88e..7afd66d45313 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -530,6 +530,7 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
 	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
 	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
+	KFD_SMI_EVENT_DROPPED_EVENT = 12,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
@@ -610,6 +611,7 @@ struct kfd_ioctl_smi_events_args {
  *    rw: 'W' for write page fault, 'R' for read page fault
  *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
  *    error_code: migrate failure error code, 0 if no error
+ *    drop_count: how many events dropped when fifo is full
  */
 #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
 		"%x %s\n", (reset_seq_num), (reset_cause)
@@ -645,6 +647,10 @@ struct kfd_ioctl_smi_events_args {
 		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
 		(node), (unmap_trigger)
 
+#define KFD_EVENT_FMT_DROPPED_EVENT(ns, pid, drop_count)\
+		"%lld -%d %d\n", (ns), (pid), (drop_count)
+
+
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
-- 
2.43.2

