Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E75AC3DA7F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 20:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E0710E58D;
	Tue, 30 Jul 2024 20:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpBe7Nw9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F3E10E58D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 20:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGIC99pmd2MWR/v3czW/ehT/PDLNp2CH93TKXhJAzL8JPe2uiwArKD7842f8EdN1fU6SfF05a/4mVc6wK5YSB0047XCYjE9GfgG5+CEWkxBhxXuNY7n8h7wGYWp+a/2U0F72UVWaalHR/4jhfdDifidu9pikF3TgH4KCEU2iyl9TxhifQ32OQrzs0f2z6NTioKdsnyKjzzdm3PjsiYlKrCMEWYdQ15dveMbO7LPN4myh2NaVus5LD9+cjVJQWAkj8zR2/lCGLbnFDKMtuQV85s1SNWrU6/S20IjQMHtlW0IbjZmr5kL6sgZH30HrwX3D7DQ5uaQvQ1G6uuVcFmDXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPYQZSHVBZvqdheVFf35mIp4ZwVMtbMh9UoBBimQrHc=;
 b=qKCTxeNGTjBqe5pp0WqZCKNdJfOKEIFd4OPQKcCgXXT8q6glqDsteo/UpGOA3jqY2fH4YhzOIcWIk1pXVtrPxP1XjIoaO4PiLFmERTK5fZ0jThZtK9v42vfRynaFmekyJjW1iAmk5I7xjrR9Z1YcWbygxx+7bwgqyHPbXP32pZ6b0eJFiOXniFzkcfYyrj3t0IMKnxAoGWIvDPVuoFPd0MDUw9+IinSPUG1C9BmDNrpYu6GyAMAuxdJxDYT82OSYjzX8unJDXw1KxAZEetTIehEEb49H18mPHjfVl+hOSIp0Ye5Ubu1CWslBTuPNFJt70pzCpqSUd62H+iTCoM9xKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPYQZSHVBZvqdheVFf35mIp4ZwVMtbMh9UoBBimQrHc=;
 b=YpBe7Nw9lM1pKgN+unHBJOTrm8DqzPZ5kboi4xL4AlPMvXVtdUo0CnXOWcPfJDlbEnSOq5THcikf079pmR7MfSDHbL4SDxmkeiwMyIS+woYYjwMne0Jq/ryQujX723BohfZXxMSxv2GFuAhHnQxAMy2pfXsEeyFXaAwXS9PnDVo=
Received: from MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Tue, 30 Jul
 2024 20:16:29 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::e2) by MW2PR2101CA0031.outlook.office365.com
 (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Tue, 30 Jul 2024 20:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 20:16:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 15:16:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 4/4] drm/amdkfd: SMI report dropped event count
Date: Tue, 30 Jul 2024 16:15:47 -0400
Message-ID: <20240730201547.13590-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240730201547.13590-1-Philip.Yang@amd.com>
References: <20240730201547.13590-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 601a60e9-d8ca-4c8e-639c-08dcb0d47efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JVEhNNXexwLNjmyfVgcgD+DgfyblCz43msDALUmllXzF2eNzLpi0oAn4vd/W?=
 =?us-ascii?Q?F5+34NZTJwRmcrQsjGI6laSgQ/JrXEL1Zrk85n3hIdYntHRn3Bk3tRC4G7Db?=
 =?us-ascii?Q?tFq4L0VKCB56xZ8xQkHbmooq1jXDEFKYdjS3TcBaYQG4lJ90Uik1GMV5zSQc?=
 =?us-ascii?Q?8nABYZwy9AGEHdxmdYkch3CigymDH38rCjNc4P4qQAZ1VbRViFK1EKUGlo0x?=
 =?us-ascii?Q?X2xiU4/QRw5xlazmmiMPyg2tBN+E0U4uQvshTG6pGO/CTzXMT2pcAcbroT5U?=
 =?us-ascii?Q?vd52MbFN/hOfmWLT/lTZqk8jM7yAv+pCAYDdyXZ2t9j52Yrm4cG8Mcyt9C4K?=
 =?us-ascii?Q?K9rrAWx8PktvBtQ9k9o8L6gmZpkrYlfcN+6VJAjtyfRDK/5GYsHkURSFmiT9?=
 =?us-ascii?Q?p+p+b/yOhRb1EPiqR9+7y3o8qgm9ogNYvb+l9R8XqbbRUdGnMBHB4Z69aPzp?=
 =?us-ascii?Q?HSby2wHXspo6N5Zh05OlShO+nMkYgzJJA8UGOZRVi0JHfvNcysq/eILDa4vF?=
 =?us-ascii?Q?+3+A2vmP0gE5K5FuprnvD6zttDmeOL6KIV2laKTImx/x3nE5vuPrHEcCrlTd?=
 =?us-ascii?Q?2lJST3NZ61aXvOjYSYYXzSE9W0DZffKMb+RkqCZ0OSr+a53ECloLRZ+8YOXX?=
 =?us-ascii?Q?r8FlaQDrn8nWk93RkDlQ/UHaQF1hjOuSz1kW+B9RfgruWz70vyp6OKd/oBsT?=
 =?us-ascii?Q?KaMCGMWtp5nosMF4tSi8JobeL6vKTlqqluMPSU6QUZwMMOjgsqeuMAtYSKNY?=
 =?us-ascii?Q?GSbsF/DIeiburWsOmaln4QP4JrJpfv6SF3+8fQfk8n78TR6qf6FjtrlWIeKo?=
 =?us-ascii?Q?9C3DQc2XdTJERGvsdAkTygWyGPFsoREppoNBH1+TvJhyhyAkQShfAfMCGdTx?=
 =?us-ascii?Q?R/VMUOma7VR5GT76Tq5ysBclqVp4Tat/qSdj6pTYPFV27ZcpbslIIVtiPZ5h?=
 =?us-ascii?Q?w6NfGb9Drpm458ptL3XH2DQKI8jXde0ZIoHYMtJe2aqyo1jTPChESuTgWxWS?=
 =?us-ascii?Q?+6cIdDx2k1crik0yUE3fyjJezjuxSUtpeatsieGV6odNJEORM0fxFgZTooJc?=
 =?us-ascii?Q?VHiuFFZVVJZiYNvk7J0fn8GP2DywtZjKr5CBDGA7dsDymr4o9F2XpcK5G5+Q?=
 =?us-ascii?Q?VJP3JPOfMb8pyIMUub2cuNiLmr7Dd8AIe82qaIHw+DHunToZao7oSym3ZA/6?=
 =?us-ascii?Q?m3/8cVs4zKiscBvdXs+n3EKipdP9HCrJ7gARun982DEcHr8IHnUiUN3lp3Bg?=
 =?us-ascii?Q?/rJLWnEZgHLOXRsn2/J5wS0rL1A+8ROXs5YhAFHkGK+dNmrFQZy9Odp0G56V?=
 =?us-ascii?Q?SaQIu+o7SglatFh2JyMZd6DNTx5DEIIIvT9AC7bGUsdS8tsej3XoFmp/1GF8?=
 =?us-ascii?Q?FESsBOmk+HiM1QmWZHG/NOLiYW1n8kDMqZwD6PqZR6LgL6/wF/ck0KMzMEZh?=
 =?us-ascii?Q?zffCfyEzBR1zhrPgeFB5G8roX0aYqUOF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 20:16:28.8295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a60e9-d8ca-4c8e-639c-08dcb0d47efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
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

Add new SMI event to report the dropped event count when the event kfifo
is full.

When the kfifo has space for two events, generate a dropped event record
to report how many events were dropped, together with the next event to
add to kfifo.

After reading event out from kfifo, if there were events dropped,
generate a dropped event record and add to kfifo.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 41 ++++++++++++++++++---
 include/uapi/linux/kfd_ioctl.h              |  6 +++
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 9b8169761ec5..9b47657d5160 100644
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
@@ -173,22 +188,36 @@ static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
 }
 
 static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
-			       unsigned int smi_event, char *event_msg, int len)
+			       unsigned int smi_event, char *event_msg, int event_len)
 {
 	struct kfd_smi_client *client;
+	char msg[KFD_SMI_EVENT_MSG_SIZE];
+	int len = 0;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
 		if (!kfd_smi_ev_enabled(pid, client, smi_event))
 			continue;
+
 		spin_lock(&client->lock);
-		if (kfifo_avail(&client->fifo) >= len) {
-			kfifo_in(&client->fifo, event_msg, len);
+		if (client->drop_count) {
+			len = snprintf(msg, sizeof(msg), "%x ", KFD_SMI_EVENT_DROPPED_EVENT);
+			len += snprintf(msg + len, sizeof(msg) - len,
+					KFD_EVENT_FMT_DROPPED_EVENT(ktime_get_boottime_ns(), pid,
+					client->drop_count));
+		}
+
+		if (kfifo_avail(&client->fifo) >= event_len + len) {
+			if (len)
+				kfifo_in(&client->fifo, msg, len);
+			kfifo_in(&client->fifo, event_msg, event_len);
 			wake_up_all(&client->wait_queue);
+			client->drop_count = 0;
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
index e4ed8fec3294..915d1e7c67fe 100644
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

