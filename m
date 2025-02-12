Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13AC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 22:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4341B10E0CB;
	Wed, 12 Feb 2025 22:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I9hS7uBy";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B469E10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 22:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4VsTepSS5xvo3pQImoxza7t5QZ4ba79r7E7OC5JkphOP638NkdA5k/5gdj+fQGf6PMo18kpVdSGOi1dkjsdsemPY2bBNprzdswMKL4oQorZmhru/2BjQRo0Y7aPSq4HDEDl/7kcfZmrP3hOYUkNI0uJXUZugmT3AccXbFtpIUZsa1vlCMl5oGNUG0FkFAyZccGI/fXOrRmo8NMJPnCbJH1j+z0Z/SqPfihmHLrOyuiQjEoS1lZbbrGjyyiU0gN+e4Rnf3jlKeGk2WQTsgfyfEAHxfTNYI6poordGakfC4FhMy03LJWerYHWVph79kxsgLQL949Dxr88fKxc0aOHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJJMjkF5/PbllBCyTy7z8RBUxlzIklwalqX21JLdDrU=;
 b=c1ZM1JTPo0N1l3TS9676JaClsI3DR00BMLS8iAoG105yz/4Y3NVf2ElyW3Dvmgg0UuhSGqMCVvsqIsTMND0bcpPpaUY+Ro4KhMo5bPFL8qPHYEHCzWJWQztt/8aAR4g4bJTa8m/cS9G+H5h8gwUuZbhIhj8RDvZXD9o2Zp40flV0wrnFiWbUAg6XHPxAKGgckg/nL/IeA9T5srcwwa2kRV4UngfG2w9lgDBKvtOj/MftmVoPUprcXqe1U2yuNt+oKQV4dQRghIe1Oo9+fu5MHsjJmWqeZWqt1mAsWV5Cz0uEq6QLhuqhZ/jduJURgcguIA2ulX5B3B9Jn2a15t4ooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJJMjkF5/PbllBCyTy7z8RBUxlzIklwalqX21JLdDrU=;
 b=I9hS7uBy84m2g4Oa4s+crtVWHJRQ5p62MGY31I2u2FdpbEcgz6yWeh2/QtuzTisDrzadEB2aWymJVgLCvnWzL6uZoeT2VsoHiUXogArZp750p0eywL5QwBRiFz5VwtWwnW+uvzDtO6H3zhOlZ861qokFvERv+n1vmUbP4hGv59A=
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 22:03:58 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::f5) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 22:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 22:03:57 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 16:03:56 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: Rename grace_period to wait_times
Date: Wed, 12 Feb 2025 17:03:38 -0500
Message-ID: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3427c533-9609-4037-cf9f-08dd4bb12613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bE133Q+IilO6sU9Ms9vY+DahQ3bgn91+wC+0LZy/KFwxLKWSmIBs0ffYz7np?=
 =?us-ascii?Q?jpqaNon/a99eUJGBD1VcvZPgi5mZEtmM0nxlQBqb7GPGCCvWKfcyycXQiavZ?=
 =?us-ascii?Q?XzSMvgwsnVnaiGmlaoV4L75MiBXqhcEyeoPrVPLxuHlEsAaQkuCOZYniGqXN?=
 =?us-ascii?Q?HAAQPdDEUpSILcbqXxYs+l21EfkgM+qthbXia3LFCAMn3wdsOeCwTkNUYJn/?=
 =?us-ascii?Q?mWakuiiB1b1cO+Tj82Nx5hl33NlC3MMbwYrRM/8Xh7DelMFlwHQ/Sr2rQR7M?=
 =?us-ascii?Q?MAAg+FZN7RNztjFe99yVUSFjvSr6n9IqhChsiolfDwbp1Iskzy/lAr5ntxPn?=
 =?us-ascii?Q?zglrPXrBXCUHyvggi5YsyjdlMEgGD5YXA4IQezpRg0UILU6zeDDNLzjm0ZlG?=
 =?us-ascii?Q?paFxkyw7Di+wpCZIT9v6jZB9w2Qd+ZW33OFyHm0QwfqgCY3NmKODTBDMfNe/?=
 =?us-ascii?Q?VvK9ZkoaTIn6aiUIegAzSliYNsakUefavhf3YUKSIPQib4YayyJAgfGVoJ6m?=
 =?us-ascii?Q?0xyxlc1CuQBViqe6nSZQxjdv53BR6a25LbSDmdy7bQI2cvlgwsrzUUMGZuVA?=
 =?us-ascii?Q?tD9MDgMP4aEGAph+MtNtA6lzzAp3JUURyMDtQTKrHEy0znNyryda7HNVDZhy?=
 =?us-ascii?Q?S4xF1i/ywS0rO/RJVGMtoAy3/8Y3Fv43iDmtrFjyP095OudbGhCj8aLojZth?=
 =?us-ascii?Q?0HVapRe4SwAPG2i5kn9yMtkkI+6xIHVaYIS4YQ8Qr8kWYCR8AGlp43jIrogq?=
 =?us-ascii?Q?q2g499nW48B1cmfbCSZTiQbEOje1PE3NR8VlU5o6gJ32syZ5bv2DuLYzaXua?=
 =?us-ascii?Q?EO+QUBCWDMQdzzjpxFzsTzEclHzIro4crzMSVKwsd9uHLnsMeZO/W6ieJGgy?=
 =?us-ascii?Q?UVv90ysyieqask5iA3wDMU9LkHZX3paPEL53+r35e/oy7Fug8abNw5h1Feab?=
 =?us-ascii?Q?kp/kDnx4ctwZoa/3BbWFxvC2ODNXddoEMOxTNTfRMFfLwnR2+jVIISc9qAZJ?=
 =?us-ascii?Q?SW17QPU0RMJvA9SHi7u+82hLi5uF0VmB40R4Ryn325HEk1WKXCK1tH7QKtq4?=
 =?us-ascii?Q?eGSYXRYhR7y7Rc22HfEJPj7SOalYTShI/bdS6D1rXv5oU7WemEz0OgeKaFLX?=
 =?us-ascii?Q?eeImZ6vshWX7J4UpPO84HGhBeFQB0+rJeBdNKary+C1Bezk39eNWSrqAma5c?=
 =?us-ascii?Q?QrmqlW2Aiy235ESA3/H0jFum3JlLNh5qvOh3oFTBtazALScXT7uHH9KixnfI?=
 =?us-ascii?Q?WYvwao68UsyYcPpACYdFzPBeYb5JNvWTpT7ysMbbcvYDf7leCDRH2uD7H57P?=
 =?us-ascii?Q?vNgfDkZ88qtuWnieKlXCvV73KlU7Pj+cw529MPNpBi51aoxAzAr9eID1KO1x?=
 =?us-ascii?Q?CK026n2OjaASZLFmGwXk+S79TM7ohPbm/9lrR+YAILjS8S+Qkk+PQr9AuwBp?=
 =?us-ascii?Q?0JZl8DYLBF4+pAhBo5omS8InQz6ZDK21RI4h0qsj3EJO7Bwf1x7zXlzDs7e+?=
 =?us-ascii?Q?2esB0cIUW+6U8kU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:03:57.4417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3427c533-9609-4037-cf9f-08dd4bb12613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

Rename .set_grace_period() to .set_compute_queue_wait_counts(). The
function not only sets grace_period but also sets other compute queue
wait times. Up until now only grace_period was set/updated, however
other wait times also needs set/update. Change function name to reflect
this.

No functional change intended.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 46 +++++++++----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 18 ++++++--
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 16 +++----
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 +--
 6 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 195085079eb2..b88a95b5ae0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -976,7 +976,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
 		if (!dqm->dev->kfd->shared_resources.enable_mes)
 			retval = unmap_queues_cpsch(dqm,
-						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+						    KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
 		else if (prev_active)
 			retval = remove_queue_mes(dqm, q, &pdd->qpd);
 
@@ -1246,7 +1246,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 					      qpd->is_debug ?
 					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
-					      USE_DEFAULT_GRACE_PERIOD);
+					      KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 
 out:
 	dqm_unlock(dqm);
@@ -1387,7 +1387,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	}
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		retval = execute_queues_cpsch(dqm,
-					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
+					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
 	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
 vm_not_acquired:
@@ -1788,7 +1788,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
 		if (!dqm->dev->kfd->shared_resources.enable_mes)
 			ret = unmap_queues_cpsch(dqm,
 						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
-				USE_DEFAULT_GRACE_PERIOD, false);
+				KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
 		else
 			ret = remove_all_kfd_queues_mes(dqm);
 	}
@@ -1815,7 +1815,7 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		ret = execute_queues_cpsch(dqm,
 					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
-			0, USE_DEFAULT_GRACE_PERIOD);
+			0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 	else
 		ret = add_all_kfd_queues_mes(dqm);
 
@@ -1860,7 +1860,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	dqm->sched_running = true;
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
+		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 
 	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
 	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
@@ -1868,7 +1868,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		uint32_t reg_offset = 0;
 		uint32_t grace_period = 1;
 
-		retval = pm_update_grace_period(&dqm->packet_mgr,
+		retval = pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
 						grace_period);
 		if (retval)
 			dev_err(dev, "Setting grace timeout failed\n");
@@ -1916,7 +1916,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
 	else
 		remove_all_kfd_queues_mes(dqm);
 
@@ -1959,7 +1959,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 	increment_queue_count(dqm, qpd, kq->queue);
 	qpd->is_debug = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
-			USE_DEFAULT_GRACE_PERIOD);
+			KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1974,7 +1974,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 	decrement_queue_count(dqm, qpd, kq->queue);
 	qpd->is_debug = false;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
-			USE_DEFAULT_GRACE_PERIOD);
+			KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
 	 * type.
@@ -2054,7 +2054,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 
 		if (!dqm->dev->kfd->shared_resources.enable_mes)
 			retval = execute_queues_cpsch(dqm,
-					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
+					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 		else
 			retval = add_queue_mes(dqm, q, qpd);
 		if (retval)
@@ -2294,8 +2294,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
 		return -EIO;
 
-	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
-		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
+	if (grace_period != KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES) {
+		retval = pm_set_compute_queue_wait_counts(&dqm->packet_mgr, grace_period);
 		if (retval)
 			goto out;
 	}
@@ -2338,9 +2338,9 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	}
 
 	/* We need to reset the grace period value for this device */
-	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
-		if (pm_update_grace_period(&dqm->packet_mgr,
-					USE_DEFAULT_GRACE_PERIOD))
+	if (grace_period != KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES) {
+		if (pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
+					KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES))
 			dev_err(dev, "Failed to reset grace period\n");
 	}
 
@@ -2360,7 +2360,7 @@ static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16_t pasid)
 	dqm_lock(dqm);
 
 	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
-			pasid, USE_DEFAULT_GRACE_PERIOD, true);
+			pasid, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, true);
 
 	dqm_unlock(dqm);
 	return retval;
@@ -2468,7 +2468,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		if (!dqm->dev->kfd->shared_resources.enable_mes) {
 			retval = execute_queues_cpsch(dqm,
 						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
-						      USE_DEFAULT_GRACE_PERIOD);
+						      KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 			if (retval == -ETIME)
 				qpd->reset_wavefronts = true;
 		} else {
@@ -2763,7 +2763,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		retval = execute_queues_cpsch(dqm, filter, 0, USE_DEFAULT_GRACE_PERIOD);
+		retval = execute_queues_cpsch(dqm, filter, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 
 	if ((retval || qpd->reset_wavefronts) &&
 	    down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
@@ -3123,7 +3123,7 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
 	}
 
 	r = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
-			USE_DEFAULT_GRACE_PERIOD, false);
+			KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
 	if (r)
 		goto out_unlock;
 
@@ -3172,7 +3172,7 @@ int release_debug_trap_vmid(struct device_queue_manager *dqm,
 	}
 
 	r = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
-			USE_DEFAULT_GRACE_PERIOD, false);
+			KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES, false);
 	if (r)
 		goto out_unlock;
 
@@ -3355,7 +3355,7 @@ int resume_queues(struct kfd_process *p,
 		r = execute_queues_cpsch(dqm,
 					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
 					0,
-					USE_DEFAULT_GRACE_PERIOD);
+					KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 		if (r) {
 			dev_err(dev, "Failed to resume process queues\n");
 			if (queue_ids) {
@@ -3734,7 +3734,7 @@ int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
 	}
 	dqm->active_runlist = true;
 	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
-				0, USE_DEFAULT_GRACE_PERIOD);
+				0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
 	dqm_unlock(dqm);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..273c04a95568 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -37,7 +37,7 @@
 
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
-#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
+#define KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES 0xffffffff
 
 struct device_process_node {
 	struct qcm_process_device *qpd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 4984b41cd372..8d2f63a38724 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -396,14 +396,26 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 	return retval;
 }
 
-int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
+/* pm_set_compute_queue_wait_counts: Configure CP IQ Timer Wait Counts for Items
+ *  Offloaded from the Compute Queues by writing to CP_IQ_WAIT_TIME2 registers.
+ *
+ *  @wait_counts_config: Parameter overridden. Could be flag or grace_period
+ *   Possible flag values:
+ *     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES then reset to default value
+ *
+ *   If not an above flag, Wait Count for Scheduling Wave Message (SCH_WAVE)
+ *      is set to wait_counts_config value.
+ *      NOTE: if 0, The CP cannot handle it and will result in
+ *      an infinite grace period being set so set to 1 to prevent this.
+ */
+int pm_set_compute_queue_wait_counts(struct packet_manager *pm, uint32_t wait_counts_config)
 {
 	struct kfd_node *node = pm->dqm->dev;
 	struct device *dev = node->adev->dev;
 	int retval = 0;
 	uint32_t *buffer, size;
 
-	size = pm->pmf->set_grace_period_size;
+	size = pm->pmf->set_compute_queue_wait_counts_size;
 
 	mutex_lock(&pm->lock);
 
@@ -419,7 +431,7 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 			goto out;
 		}
 
-		retval = pm->pmf->set_grace_period(pm, buffer, grace_period);
+		retval = pm->pmf->set_compute_queue_wait_counts(pm, buffer, wait_counts_config);
 		if (!retval)
 			retval = kq_submit_packet(pm->priv_queue);
 		else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d56525201155..8b693a9446e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -297,9 +297,9 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 	return 0;
 }
 
-static int pm_set_grace_period_v9(struct packet_manager *pm,
+static int pm_set_compute_queue_wait_counts_v9(struct packet_manager *pm,
 		uint32_t *buffer,
-		uint32_t grace_period)
+		uint32_t wait_counts_config)
 {
 	struct pm4_mec_write_data_mmio *packet;
 	uint32_t reg_offset = 0;
@@ -308,11 +308,11 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
 			pm->dqm->wait_times,
-			grace_period,
+			wait_counts_config,
 			&reg_offset,
 			&reg_data);
 
-	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
+	if (wait_counts_config == KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES)
 		reg_data = pm->dqm->wait_times;
 
 	packet = (struct pm4_mec_write_data_mmio *)buffer;
@@ -415,7 +415,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
-	.set_grace_period       = pm_set_grace_period_v9,
+	.set_compute_queue_wait_counts = pm_set_compute_queue_wait_counts_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process),
@@ -423,7 +423,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
+	.set_compute_queue_wait_counts_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
@@ -434,7 +434,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
-	.set_grace_period       = pm_set_grace_period_v9,
+	.set_compute_queue_wait_counts = pm_set_compute_queue_wait_counts_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
@@ -442,7 +442,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
+	.set_compute_queue_wait_counts_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index 347c86e1c378..de28fc585296 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -304,7 +304,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs = {
 	.set_resources		= pm_set_resources_vi,
 	.map_queues		= pm_map_queues_vi,
 	.unmap_queues		= pm_unmap_queues_vi,
-	.set_grace_period	= NULL,
+	.set_compute_queue_wait_counts	= NULL,
 	.query_status		= pm_query_status_vi,
 	.release_mem		= pm_release_mem_vi,
 	.map_process_size	= sizeof(struct pm4_mes_map_process),
@@ -312,7 +312,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size	= 0,
+	.set_compute_queue_wait_counts_size	= 0,
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= sizeof(struct pm4_mec_release_mem)
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 59619f794b6b..ae58d50b8eb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1417,7 +1417,7 @@ struct packet_manager_funcs {
 	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
 			enum kfd_unmap_queues_filter mode,
 			uint32_t filter_param, bool reset);
-	int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
+	int (*set_compute_queue_wait_counts)(struct packet_manager *pm, uint32_t *buffer,
 			uint32_t grace_period);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t fence_address,	uint64_t fence_value);
@@ -1429,7 +1429,7 @@ struct packet_manager_funcs {
 	int set_resources_size;
 	int map_queues_size;
 	int unmap_queues_size;
-	int set_grace_period_size;
+	int set_compute_queue_wait_counts_size;
 	int query_status_size;
 	int release_mem_size;
 };
@@ -1452,7 +1452,7 @@ int pm_send_unmap_queue(struct packet_manager *pm,
 
 void pm_release_ib(struct packet_manager *pm);
 
-int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period);
+int pm_set_compute_queue_wait_counts(struct packet_manager *pm, uint32_t wait_counts_config);
 
 /* Following PM funcs can be shared among VI and AI */
 unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size);
-- 
2.34.1

