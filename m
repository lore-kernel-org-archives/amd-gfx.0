Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762ACC54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1206B10E3CF;
	Tue, 27 Aug 2024 17:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlnXKhK8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8193810E3CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOwrwCV9kSdQGEcZEzYcvBxOE0Lnm+54CaL9ft1MUQzldZ+3C2vwn3E9487GR9VzZRhkvE3jUNS0mDa2D54JAPTRTZK+ibpGM0ha3EKEqACAU0ut7ALci/KpxxjM3nWV58KCzDDEFU65RA1la7+qSgtgMF1PkyqWXkwx+O7GaXOIe6RTXU8SEK0PG7oq1X6WQbOTup1qlak7REBUB2ZJ/kKvWjP1RJvu4LKWS/eI+rIFNGJUPIXOQToYavPwkNFqltOsLZyIBWw7Vd0MJo5pceacCoob393cWgFIpOKgRs9B6KhDz4uC5ABbQYJUN20JwdeSDy0pF7g0uXk12E6i0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz3ephkYM533R5f4wjk/eZ1v2+LQM7u5S8afKsBGSqs=;
 b=u0AFn2rMqE7zT7AAMrNvdS05O/IQi3tcbojU9Fa5dPj4HNeBu19p3LjJl8Iu7GZkztiICVYh/0n1HdIHiA5DF9aNmI4l51lywW2/djW+V+zi/Ch/4/D5+u1bLak8NKyEPqXLDA9vzzYnbW+fFi5l0nnBKnPLAa11sbJSF5AdOqa3Bh5r7/ferJY7jY2RAGEKZggqE6tF4fJ6yTX0NYPA0p6vWwoAZ7zFLKOFwC2LubVjg2H1asCe+Fv54q2T47raKA0YmvBHLBRCpQhQH6+R47tYlHsk0N4FLlt9Hd4YyA/dU1igWJWMnaKmiOeCqnqSylKIb8G0Z+cohU6he2m7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz3ephkYM533R5f4wjk/eZ1v2+LQM7u5S8afKsBGSqs=;
 b=IlnXKhK8FXt43K8RxrCtOjaVFDuopggWb9c8hslwaKEoWFc15MD/nhBolOT0+lViFAzb+4F6TNPN/zn3q/YMf8ACBCVh/mYYcwrLNod21MXALCAWyUntm970uhrx70Z9JAOKVBeYJYGrMMCpznPo28lVey5toyyvxahmJrvPCjQ=
Received: from BY5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:a03:1f4::43)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:11:31 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::da) by BY5PR20CA0030.outlook.office365.com
 (2603:10b6:a03:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 17:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:11:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 12:11:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v3 4/4] drm/amdkfd: SMI report dropped event count
Date: Tue, 27 Aug 2024 13:10:25 -0400
Message-ID: <20240827171027.12910-5-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: db431e7f-ded8-419a-ae8d-08dcc6bb4be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?heEE+QYID1PKnbNgTDsGRtaJVhY0Lj3U8aic6LRDCnv979vIx5xSeqaHSXVS?=
 =?us-ascii?Q?wjTFtPfapJZvktRrN0mdbeQLOMTNTDeH7Yst2VTQ94p+ZkKnOEoDgigYI+lc?=
 =?us-ascii?Q?1tubFzqvSQ0K4VrN4cipdg4ehXVZFzUNHsaC35DpNqWH/FrbVO9J0b1/us3g?=
 =?us-ascii?Q?KjVOHFWtW80WXdsDwy6kaXSdvxvGFPEeofvYKz2hYJ3TpCsvzoODf2YtvIEy?=
 =?us-ascii?Q?pMvFby0hRYoO3YiEMoUi12oPBfeFiT2gUOdoUd5qEWNlj3mpThTfLmGv80Ri?=
 =?us-ascii?Q?eJQyeOB7DyVI+ZobOVud1Nu0X45lPVWS6tIQ7hKLb7GqwFFXUZoG5VdWEawp?=
 =?us-ascii?Q?u1Y2itRUf2evEO4t5KYNlCjx5VOLeLYXj2bFVr6Kdbrf37aq7hZ+yZveZJSl?=
 =?us-ascii?Q?9NdjY8fYsqE8bs/XN4qUOj99ZxM7QGGmBb0973TJX4gWjP1gRbtDb4tNEX1a?=
 =?us-ascii?Q?LUp664eL8QUHZci/If7gJ7JJUwS/QmSNoeMrzJ26GLKRIkaoIx9MiRGagg8M?=
 =?us-ascii?Q?aX29C9LpXG3Lxazb8LJsSIxzZUTzXZbQQoUoc0ptnfX4VYwwLE41CR+6GPug?=
 =?us-ascii?Q?w1QSxSLOaczco8al/QcNNRvEwQ4BKYzY4knsnQrKXn72mlFZj/rF+gofkBWy?=
 =?us-ascii?Q?wOLnEjeUfMdDiDW22X2v9argnsB6NdeLT9jgdsU6dIwxkiPWsn27HbMpdmek?=
 =?us-ascii?Q?6GuH6TshSgvL4zSR8uwpQv1ydOI005NmJMrLj3m8mhfG/By18cv3GVqaCXzL?=
 =?us-ascii?Q?TevgZNC/2X68gAQLWyWSraTZCAt/Uw9yXvAmYORost7QrPt0kblEzboZH7WQ?=
 =?us-ascii?Q?uiPxqQS0zGAyd9xlA2MD0yk6OQ3uwrdxoGqzG4UCK4N0CCJdj2vyWQ3owSwF?=
 =?us-ascii?Q?Px5cDq+MISCbPLxvOoBgVFLyxPRcKHlCf7XQAC+xkI4RlDD6FLkQMUF3mOeY?=
 =?us-ascii?Q?2uPihuboaSX5rDkZWkyxEOV+U4/DhGaUOx2yrbP5eOVCXtn3ZPvZNgDFxb8i?=
 =?us-ascii?Q?MCi1be2X8j3DOOj+jaNAHS8rgx28QDt9IScde+/gWigecgPRn4ybgbz7zcYi?=
 =?us-ascii?Q?1/xfQXg2NruVBwNEwHxrt+z0OYFJFya7i17y76DBlOv3x2+e8voJzxqa3BCz?=
 =?us-ascii?Q?YjKUyLMIQhaBjx2UAN576L/71HYd0Bdu855wGUhmhqKuhEsS8UuY4duzrith?=
 =?us-ascii?Q?9zvDGE4SX6sSmQXrnyUE1kkQ0t02ZQ6V+oK7DcgAv7821G/KwnqjjuQUp7hY?=
 =?us-ascii?Q?6EOwWb7CeeiMW6GtDFuAzrAOwq5an41FZZ4fcl24N6zklmEclqcCZEAnBmwX?=
 =?us-ascii?Q?0/2xFKBn9rncR9wfwaYCEIWtdXI4H/ekMTgTXL6VCPYSdpqQu7++M4F+c/4f?=
 =?us-ascii?Q?nujROg6g2qgwjI6DkCOkoqnE0vLbjUPJ0f6oZNRzrvKlAp6Yk3jpPoOw1U0A?=
 =?us-ascii?Q?j42u7b3cK460zBeV3JcN/omKHGdT3UJa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:11:31.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db431e7f-ded8-419a-ae8d-08dcc6bb4be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

