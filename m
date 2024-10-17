Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDA5D374B3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A27989B33;
	Thu, 17 Oct 2024 16:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a9ehWNJo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5544989B33
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnJfh1QYboOCg9jtPtZ6ERUbc5LwJjLwiRAnuAjs0qfeJnqpjBOlKuzlOsuXjrkwk6IaGNA2udu3DnWw9UP5DFuWyL3Itpa9r43gjCbDzfXC0t3g4sjV+HHoR8IGttssChEgt3X9DZbs+xEX1Qdo9W9EEj6nFiu3+kRk6KBgioZgIvgkP40ItcWiwMbSiCZ7rFkxyFpPjX5KQG17fvq88vPYv55ndupwjdnWSP6E6KgvrURVN+kEyE65JOigTA/YZEjlZl7I3TWIDk3fRF9l3c+SGe9OjC51EHywaI6/B/JPbmKZBv2yCJ1vVXzqXORV0U9pwF9FJRCrbCUJbkaPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj6B9qk8aGARmwJQggVbLIDpdJeObBRmuhIoUjRGtds=;
 b=iyKJWyFvnE9KFP14yMydCN5sonEGx1u1XD/1I6nF/ZpmIID69XWTXTEdRHFloJGjEwR5t6iwuCoqWAr6OBNTTBnQyaRBTzr4sOHK5Q2JHWmKzT3X4hFRJQ4moChejrvERezBDdU9MzWqu/aEMAgxBs/H51ahhHxVaDVpGmp2/S/YKo/FMYXrTOscUpdYx36ffSCpGM5LpL5NY0IFr6VqqJme8Oidc6jfjQK3EUxXREwQONl48sms54iWQ5s0AEMUOtn/YGir8IRMjiDqBiB7ezp79xhbU5eQcTGAk9dpzcSq0Bik3KNqcZvSW5U9S/d6fIrXID1sfu6mxg++JZmg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj6B9qk8aGARmwJQggVbLIDpdJeObBRmuhIoUjRGtds=;
 b=a9ehWNJoi4dR30sglYx/M0VkZIYzGTmS8jR1IxD6p1RjR9Hi61Sx59voeJKZoNlOQ1kIQn0HmfA7Sx6yGpwroiHJbsDyRn22Wq4GM/mgkWjS4U2gEjsfsvbNvsduUYKe6ppufbIvMQI6A0hvbNDASnDVAhCbM7RY66GRkz6hCsI=
Received: from SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:04:39 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::85) by SA9PR03CA0008.outlook.office365.com
 (2603:10b6:806:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:04:38 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:04:37 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdkfd: add/remove kfd queues on start/stop KFD
 scheduling
Date: Thu, 17 Oct 2024 12:04:24 -0400
Message-ID: <20241017160424.738845-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 639b9c95-02f3-4ad9-2d5d-08dceec56732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?svdzIeL1AyJW/+drIiiuYLwrfp+wsTURJiRGzxtRyAnDyjLrf3etJrplqNPe?=
 =?us-ascii?Q?Cu7FP7LikBGYiNz1+f5BJQJNsCp0xECJ8aKP82MCyhs3YWa5cW/d/5cNT5OE?=
 =?us-ascii?Q?WWZnG1vpEnK8HlKQVTzFi9A+HejWNwzpGNExKtc6+6CzFYvDYl0IoTmC5oos?=
 =?us-ascii?Q?AM7ikTUURWjatKew+OEPpDQywEMsJfWq0JeQ7wFBE1VjymDX0MuLC5y+URU/?=
 =?us-ascii?Q?pmPb7k9U+qfWp5+fOW2mOAxVzK2BriK+8eD/gmilHijg3VPNcB5pFJhPmy5f?=
 =?us-ascii?Q?LmW1680kUdNz0YVZiCBm7Oe/vIDyn+6MD5wKlfRuXRXIDaW21mwyFzfWRFJ5?=
 =?us-ascii?Q?ut/rfayN1zUi4cyAWRJwK0TPT5vL3PeP3fXzL0QvHKYkTS6KxFCe2AKvIqpo?=
 =?us-ascii?Q?5BfbopqR1jwRm7P0rpP0Xxen8JxmErx138MVC9oT4TTuqj/WP6Ea82YwxSLm?=
 =?us-ascii?Q?cAwAAhbtjqzij/1uMlUJ8Pqej4sWa7LFj4R3gRG0LJMtULVXoxZHvjP03OgD?=
 =?us-ascii?Q?wVohktgUCNhj9ddLgZeJhqoD073UDi/KjKHlOUttj139+QMl1L0IXP7g8OmZ?=
 =?us-ascii?Q?7oq5WXtnHBfMiG6Tq4VWUoTOniEiOoljtxekik0Sc27W+DEKY2p/poTtqoMn?=
 =?us-ascii?Q?/1dWcaVc4yU8e2hBnZEYZMZEK2EJrljwhylAJRbIIH5iVv0DOVj1oygjc8Du?=
 =?us-ascii?Q?7RMzL5uCe1tDPKvn8tmKRO2Cr5LkKIEhh4KphQx5+4OrVXWL7YtVk/HHVykF?=
 =?us-ascii?Q?6GC/AG5f14MXaqOgbJL2K5Mpl5KKkqTD6Mny2GwrN/MBU04bIWCfX3MZ+LSd?=
 =?us-ascii?Q?VXj1GSUF2mMYNw4NxgnIUPZ1nMt0Y89Lubd1ZQVoPw+azLewWVIVbhe0loQU?=
 =?us-ascii?Q?N1GpwwK3oOMn+HYt6U8KeoVwOc1rqMW9xN2iPVkGM3pXMFDS2ruDhs/gJsoT?=
 =?us-ascii?Q?ZUG3yYFlJbcf3b6XJ7zTHwL2/O0mMlrFTLGL2xN2flx3bpIVg61smNFiS0sU?=
 =?us-ascii?Q?ePnKA90wQv4qcgfNV8MnUhjcgnd0yUOW0UqPj9t1W9mbfSJe6und/5iK7djo?=
 =?us-ascii?Q?BDP/9QxV9tt/nwCE6ubS07XUyweQsH1l50obXhFfm7/exnSQ6dRlt1XEwwUq?=
 =?us-ascii?Q?G33ZQYreP7RI6uEwWlXkwpBCP6Ew7gcXcxqwCbeOQeMMaa2NkJZQWhKI4Elh?=
 =?us-ascii?Q?0WVrfa7+7z5X1o08vQ9BtcojSaRNoaplfKW6S6XZhP9XoutkQFMdQQi6DSG/?=
 =?us-ascii?Q?OBTUf9CEy1i9Nhmdn2ModipCNmm8jebfncjIxO4XivpqmQ/3RWUHSKOOU42r?=
 =?us-ascii?Q?fzabbZ4ls7Usc7i8t0DAzeYCTVCUQ1DU/0Bj9RzCavSEdwfcaawxS5UPf94i?=
 =?us-ascii?Q?enXkS4m/jssCmXDSqd0UsChEuJzQBHcALGqpNtcTs+lqkRBiDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:04:38.6139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639b9c95-02f3-4ad9-2d5d-08dceec56732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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

From: shaoyunl <shaoyun.liu@amd.com>

Add back kfd queues in start scheduling that originally been
removed on stop scheduling.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..437ed0ae6e76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -204,6 +204,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
+	if (!dqm->sched_running || dqm->sched_halt)
+		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = qpd->pqm->process->pasid;
@@ -272,6 +274,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
+	if (!dqm->sched_running || dqm->sched_halt)
+		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
@@ -292,7 +296,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_all_queues_mes(struct device_queue_manager *dqm)
+static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
 	struct device *dev = dqm->dev->adev->dev;
@@ -319,6 +323,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
+{
+	struct device_process_node *cur;
+	struct device *dev = dqm->dev->adev->dev;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+	int retval = 0;
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (q->properties.is_active) {
+				retval = add_queue_mes(dqm, q, qpd);
+				if (retval) {
+					dev_err(dev, "%s: Failed to add queue %d for dev %d",
+						__func__,
+						q->properties.queue_id,
+						dqm->dev->id);
+					return retval;
+				}
+			}
+		}
+	}
+
+	return retval;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
@@ -1742,7 +1773,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
 						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
 				USE_DEFAULT_GRACE_PERIOD, false);
 		else
-			ret = remove_all_queues_mes(dqm);
+			ret = remove_all_kfd_queues_mes(dqm);
 	}
 	dqm->sched_halt = true;
 	dqm_unlock(dqm);
@@ -1768,6 +1799,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 		ret = execute_queues_cpsch(dqm,
 					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
 			0, USE_DEFAULT_GRACE_PERIOD);
+	else
+		ret = add_all_kfd_queues_mes(dqm);
+
 	dqm_unlock(dqm);
 
 	return ret;
@@ -1867,7 +1901,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_queues_mes(dqm);
+		remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
-- 
2.34.1

