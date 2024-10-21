Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADAED3C935
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 17:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9D510E14C;
	Mon, 21 Oct 2024 17:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MLJ7ZYz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5BA10E576
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 17:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnE0hbHrEla0hX16C8JB1FOPlBLlGbGZurYxkE1lMObx13lTtDfsi8YuRIjEs/+ZEU8Njsi+1EVYsssph6RLg7hYvC/9tIhsErqoqOl9UkY4O3Cq3K+8sbVgDcuW45DT/yMsuwPss9Zxr/H7qf5+IveDdBovaNanAqyrtzDqUUiMuOvCuKxibDwv413/qsuD8P4imiZkfEzvtI66lOGCPHVBWssJW8K4wY8BVUOt85UivJLhraMsdMkHOVn1+ZNCaZ6AkjPdME0kB6CFRh9tOD4XhkSMnXmEG6vpAw4ezhjrfEdB2NLnqB2GR4egUhz1cwWtwEMErFoNgnTycc1pGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl5nUvUmFoVOwCRTVhGTd8e7FWbKPDuR/DtM/1vS/1U=;
 b=xsE699zIw+ajCm00lO+m10XyVFK8mapGifCxL4Za33l/0hmFzpxcqh8s2z1+ai7J+loy36HT65viFDjJtoWdf2lg/xIdNN0VRGNjcIwlQUmxJ3FZg0ZdsHgjlH8tDoK68Bgv4/bCqHyTWNw9A6oDh7Xm0EjOoSC77A5P6TMW+Awb4KRSGnwnWOur6OvTmlQMTzTWEonVU/kVmu5ODVCbXZCUesCOw4Jp+JMx/zOZbf4QjjGqvpSXqoNaJp6Eg5bcL4G+p98PZz4E8TTe+YNQcbpuHjcEJd28fEzvFCyznZsaQCQt+uanr5ip08+y3aZW8V2uHNPu3SRAY4hLOn3beA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl5nUvUmFoVOwCRTVhGTd8e7FWbKPDuR/DtM/1vS/1U=;
 b=5MLJ7ZYzg4By4Ibr7CM+d5TpnvniTtzVcS3n5uOKrEhqffWwI2qcmV9bUPW8IPXY/YQ5XterO0Vkku7GVA+xtzc+hh9uXRk7+x3PFyiEx4e/RYW3FBy6VkRPCxEFt8wqME1qYLRThKtZCeFcVASu3vRsYaaU09+F4GzpnMYmL+w=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:46:24 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::39) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 17:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 17:46:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:46:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] Revert "drm/amdkfd: SMI report dropped event count"
Date: Mon, 21 Oct 2024 13:46:08 -0400
Message-ID: <20241021174608.2093675-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 54514a90-0b59-4ed3-ace1-08dcf1f847e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ruUjuxdBKBV0CS+EbpyapRQP7BjGyzPSrBQhHBcXIMAGMpNHTQ0Gb/xQ7DTT?=
 =?us-ascii?Q?WjDyPq8orP5dG3EvuxflmEY7NXz2cbf5vknjDxOp09E53PXx9+lAfYqKpfeA?=
 =?us-ascii?Q?djfvy8oMaYbas9Iwg5VGyBQbqoLCaAsS0XApfOu8INld9hhXtdniK9vn0j2o?=
 =?us-ascii?Q?uiHyomfywsHU6TaH9QsyKa8UQlwX1hJqf4qn5NPX+JuHnrycWr/dUvikEMmH?=
 =?us-ascii?Q?ILXTYR65dzLBr4/BUysdPc9tHKbklWrSfaUCj1loShSjeaSSeKw4EOsVP0Uv?=
 =?us-ascii?Q?7w9LGVpMQsF9/TuMj2+WSU+XSPgguxoUPmTJoeHnwrIF2iDNpWel7jj0IwVw?=
 =?us-ascii?Q?IAZEsm8eXv5HbJjgEe37BXclsd3zo2HtAn48lEjPPXcUecE1zjy8pCEnJ9TA?=
 =?us-ascii?Q?eeMHpOzCvAHKyaDnTgYvcH96digF3cNmyQi8mRWqezAY+/LlDvq/gEU4N1Kf?=
 =?us-ascii?Q?aOsIGRsFnMLfqcD/GqT6v73cvFKjndiqM/CBOhRu931v/xuQ0uOKFCX9Xvza?=
 =?us-ascii?Q?06MQuqsVL0W+5z0dSiKazh48wClQOYkbGZ2j6UrN8rY+9jq5V1/QVBG5hZfs?=
 =?us-ascii?Q?OkiBAko3zb1SXLM1/CumRUVuBf6LHZ4BHvye4mY6mha3lM08/BvkEvZK/4aT?=
 =?us-ascii?Q?9SDND3itRBIqWsP0xF2uVq6CjaRne80S3Bw2cqmHVcuqbRBPZgcpdi10TX7x?=
 =?us-ascii?Q?ET4kCr4jz7VrQLqmGUtp2e0CEEpvX3RygYM3ue7fy6cGXgl9w+dm+QL451xM?=
 =?us-ascii?Q?yj6umMjuq4DVm6WMPFPIR4h4wRyiW7EwYgaYOfj+PEh15puDnGBkPeL6nPN7?=
 =?us-ascii?Q?EKD5KBr+tMQka1MinL2bvJMFXznqc70ic6Y3SHiXAFRyu8cC/rPFHac56Vu2?=
 =?us-ascii?Q?o8H30tJMWimtUtzGLyHWCMSqYme6HkM9Doc1Ka8mPWNf85YfZEQ3cXXD5KP0?=
 =?us-ascii?Q?3c19Nsf1gGOgSD/bvM3QLPCjzn9EqMMyjykeJs2MqcQAwVBfh4jblgl7iQ/q?=
 =?us-ascii?Q?sg9I0Z0QllWh1WVYdKhY9Ige8BynGDKop2FF5J+sTOhHW/lI43Np9T8GdIFp?=
 =?us-ascii?Q?2uwIX0Y1Ycjf3MlJqze6vIjkz9KkdOUxnOH0PZGXz5URJkmnOpP0KZ9ndBTr?=
 =?us-ascii?Q?6Mc1gt0QNDBMXkr63xafUDIgizoh0/4j4ca+U7Se/mAXcuxeWqDfly/CzvUM?=
 =?us-ascii?Q?c1Pjta2mEuD7ojTL17QkABq8zOPAtsBGRRaBogJtO7EmWEquwOkOUwjKBQYu?=
 =?us-ascii?Q?flGhwFYhsselypm7nMsyiQ6lmkPS06KzgVVqnw6HX1ZF+7K9SuwU08NS6WKc?=
 =?us-ascii?Q?cTarY0ldRliTZzOZ6wtVbLvoVtd39aHzhhV1kpNW81p7zRZNfl3q68SdpoJL?=
 =?us-ascii?Q?yRNHEW5/LtCbDvC2TKxSdM0jcpGg2rWhLNLfexiWoAb2iH94mA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:46:23.9273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54514a90-0b59-4ed3-ace1-08dcf1f847e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

This reverts commit a3ab2d45b9887ee609cd3bea39f668236935774c.

The userspace side for this code is not ready yet so revert
for now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 27 +++------------------
 include/uapi/linux/kfd_ioctl.h              |  6 -----
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index c8d67d62ca3f..9b8169761ec5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -42,7 +42,6 @@ struct kfd_smi_client {
 	struct rcu_head rcu;
 	pid_t pid;
 	bool suser;
-	u32 drop_count;
 };
 
 #define KFD_MAX_KFIFO_SIZE	8192
@@ -104,28 +103,12 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	}
 	to_copy = min(size, to_copy);
 	ret = kfifo_out(&client->fifo, buf, to_copy);
+	spin_unlock(&client->lock);
 	if (ret <= 0) {
-		spin_unlock(&client->lock);
 		ret = -EAGAIN;
 		goto ret_err;
 	}
 
-	if (client->drop_count) {
-		char msg[KFD_SMI_EVENT_MSG_SIZE];
-		int len;
-
-		len = snprintf(msg, sizeof(msg), "%x ", KFD_SMI_EVENT_DROPPED_EVENT);
-		len += snprintf(msg + len, sizeof(msg) - len,
-				KFD_EVENT_FMT_DROPPED_EVENT(ktime_get_boottime_ns(),
-				client->pid, client->drop_count));
-		if (kfifo_avail(&client->fifo) >= len) {
-			kfifo_in(&client->fifo, msg, len);
-			client->drop_count = 0;
-		}
-	}
-
-	spin_unlock(&client->lock);
-
 	ret = copy_to_user(user, buf, to_copy);
 	if (ret) {
 		ret = -EFAULT;
@@ -199,15 +182,13 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
 		if (!kfd_smi_ev_enabled(pid, client, smi_event))
 			continue;
-
 		spin_lock(&client->lock);
-		if (!client->drop_count && kfifo_avail(&client->fifo) >= len) {
+		if (kfifo_avail(&client->fifo) >= len) {
 			kfifo_in(&client->fifo, event_msg, len);
 			wake_up_all(&client->wait_queue);
 		} else {
-			client->drop_count++;
-			pr_debug("smi_event(EventID: %u): no space left drop_count %d\n",
-				 smi_event, client->drop_count);
+			pr_debug("smi_event(EventID: %u): no space left\n",
+					smi_event);
 		}
 		spin_unlock(&client->lock);
 	}
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 7afd66d45313..fa9f9846b88e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -530,7 +530,6 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
 	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
 	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
-	KFD_SMI_EVENT_DROPPED_EVENT = 12,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
@@ -611,7 +610,6 @@ struct kfd_ioctl_smi_events_args {
  *    rw: 'W' for write page fault, 'R' for read page fault
  *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
  *    error_code: migrate failure error code, 0 if no error
- *    drop_count: how many events dropped when fifo is full
  */
 #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
 		"%x %s\n", (reset_seq_num), (reset_cause)
@@ -647,10 +645,6 @@ struct kfd_ioctl_smi_events_args {
 		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
 		(node), (unmap_trigger)
 
-#define KFD_EVENT_FMT_DROPPED_EVENT(ns, pid, drop_count)\
-		"%lld -%d %d\n", (ns), (pid), (drop_count)
-
-
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
-- 
2.46.2

