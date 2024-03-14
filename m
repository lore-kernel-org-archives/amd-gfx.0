Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53E3C54E5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 16:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1884510E6C1;
	Thu, 14 Mar 2024 16:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krSmQIRg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B0210E3DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 16:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7a71n8osBtzNeS4Iq66iagkCgyBeTPf/sdoUqVa5KRGlQL8vNkf38UN+RdMIGQ/HsI5TYjebTySsTWD6Cib5gocTfTsMIHlIt5cQ65GfQLiCcxlk38KzBxjTvwk6S2yylhutReIRP0dKzdnxQM17pFVJxeXF2J8haHV0ZCRawKdBnJ8T6e9wRqn3FzpcdwTrpDRyDhm9/a35kvr8Z496vfI6S2tk9c/7eFQeP/UaXv6BWQUtbXmLuE2vBrcvr3gV1NdUPQe6PCkv4PfA5rJvLSq4dZc3ptU/nER4foaMX7uYRRD/NqZecqzmTbCYxdT+a+eZhIBLuwGM2jnuX5JeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb3TH3NLKKeSYNaO14wpzsmayHGSztz7BZnUwIY7WNE=;
 b=j8fYn39lRfRBbSEfMzhfa1dSOJ9hG0pMwJE3/f+bzdz5y5IeSv/yCot97pba80iZtv6KVfo8wlHwi4jvGg6dh7xhx7xA3drx+q9lf2o8OWZBPS2YT+13aLswek1ObKCVZSCF0JhrVo0tODCz+u6eJIdm0C7sNfP+uunqVapu98Wz9jyACDZukxOU+n16XKesor5RpnT8x6wBOMHHdhcfo+rbuKcZzVeVleH9eDugzW5dwUoDwV1qWO1roAtOOaxiiElIjgIvPsnStvXYwYTi5oy2QogAoSEiZv8gcI0J/+NZVvb4VESchdhRnn76MkL9pZhGZuhRpYlsccYnu/y0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb3TH3NLKKeSYNaO14wpzsmayHGSztz7BZnUwIY7WNE=;
 b=krSmQIRg9Cyr5kMnCGhui/Wr+5ttaft+zPhuWjTsFWbTf/QUZLmYQ3IMEDpkmdGORSdrdl7Hkcd45uhBwH5NjfKmgMRFjfaVgBDW/8oX+w+mV8dlTn3BFrhwoWF5BpqAAShIePErSq3pbfoDtARJu2SoxLCUGLxSzHC521tkGy8=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 16:01:14 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::ad) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Thu, 14 Mar 2024 16:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:01:13 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:01:12 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Jay.Cornwall@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Jay Cornwall <jay.cornwall@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Rename read_doorbell_id in MQD functions
Date: Thu, 14 Mar 2024 12:00:28 -0400
Message-ID: <20240314160029.623784-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aec48e8-d6fc-4f90-6aed-08dc443ff996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xVmHSUvYu3zpHFFTTsWY8hCpD05bkDcWqJkRlTSYOp1oXgu4AGZUo+q56wIwFETfdoY6M2hQjy0xD3HWUlNzSbm0X+oVXEjN1ebg0GTgfBXBeGTQz2+JKeF0HgEu16+jabmKZEF+FSyV2N+pXGMBBZ0SB5R2K2N91No5AFlogKAZFyBhpjvUPIgxtb8XRhfsFdHcFrTjhDgFecB30uGjl/8TRGmfaF3dOrB+84NIHvAURh6SIimd3c5qMFCLraISQBJxYvwhHh4Uj3+flYQMeae7FjUG/qH58TJS2+db1vGrVFr0PjGyL2O8Yp/q5tVv3Vr4D6yxvrFCRCqFREyjsMmM4TY62liSUMsUpNeCZraODpwnf4Ox4E3OqkRSMmRGM5RgUQIuxr5QzrYJZXIQUn0aqSv19t+cN/wM5yf4yba9eb0RmzYmtHrhGnQvXYvmauZ3NUH/EOR1h098YCnFn6zL0espU6MALBSKP0g6wTTincjaY1undgRHaJEhAFW+kUdFu28yHvD3YY7135PFcWI0lEdaFfCq86IQR7Qr1IZuRPcFpBbLqnEikNQ5AEtDVWjY0aHYHvIFEKCdRslwZAtRPmTk/gmu16vIg3ZVibK9CYx7h9+a9WK78qV/wIDxUGL74d64Ozre2EcAEV+lpMFnbmpBMdOjwE/4Y98pWlB8dY8M4gspvfNJgaX3cvFwafxt0OWnff1f20MfPlkoSrunKHN+cxEnkipdNby+qAmmmIuJPFD1GJYPpvLvm/W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:01:13.9218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aec48e8-d6fc-4f90-6aed-08dc443ff996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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

Rename read_doorbell_id function to a more meaningful name,
implying what it is used for. No functional change.

Suggested-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h          | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c      | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c      | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c      | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c       | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c       | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f4d395e38683..1ce398ab0b3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1997,7 +1997,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 * check those fields
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-	if (mqd_mgr->read_doorbell_id(dqm->packet_mgr.priv_queue->queue->mqd)) {
+	if (mqd_mgr->check_preemption_failed(dqm->packet_mgr.priv_queue->queue->mqd)) {
 		dev_err(dev, "HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
 		while (halt_if_hws_hang)
 			schedule();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index e5cc697a3ca8..ba3eebb2ca6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -119,7 +119,7 @@ struct mqd_manager {
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
-	uint32_t (*read_doorbell_id)(void *mqd);
+	uint32_t (*check_preemption_failed)(void *mqd);
 	uint64_t (*mqd_stride)(struct mqd_manager *mm,
 				struct queue_properties *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 1a4a69943c71..8f9f56f7a8b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -206,7 +206,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t read_doorbell_id(void *mqd)
+static uint32_t check_preemption_failed(void *mqd)
 {
 	struct cik_mqd *m = (struct cik_mqd *)mqd;
 
@@ -423,7 +423,7 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd->read_doorbell_id = read_doorbell_id;
+		mqd->check_preemption_failed = check_preemption_failed;
 		break;
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 22cbfa1bdadd..d4cf7d845928 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -224,7 +224,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t read_doorbell_id(void *mqd)
+static uint32_t check_preemption_failed(void *mqd)
 {
 	struct v10_compute_mqd *m = (struct v10_compute_mqd *)mqd;
 
@@ -488,7 +488,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd->read_doorbell_id = read_doorbell_id;
+		mqd->check_preemption_failed = check_preemption_failed;
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		break;
 	case KFD_MQD_TYPE_DIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 826bc4f6c8a7..2b9f57c267eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -278,7 +278,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t read_doorbell_id(void *mqd)
+static uint32_t check_preemption_failed(void *mqd)
 {
 	struct v11_compute_mqd *m = (struct v11_compute_mqd *)mqd;
 
@@ -517,7 +517,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd->read_doorbell_id = read_doorbell_id;
+		mqd->check_preemption_failed = check_preemption_failed;
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		break;
 	case KFD_MQD_TYPE_DIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 697b6d530d12..7c93a0932677 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -316,7 +316,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 
-static uint32_t read_doorbell_id(void *mqd)
+static uint32_t check_preemption_failed(void *mqd)
 {
 	struct v9_mqd *m = (struct v9_mqd *)mqd;
 
@@ -881,7 +881,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd->read_doorbell_id = read_doorbell_id;
+		mqd->check_preemption_failed = check_preemption_failed;
 		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
 			mqd->init_mqd = init_mqd_hiq_v9_4_3;
 			mqd->load_mqd = hiq_load_mqd_kiq_v9_4_3;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 3e1a574d4ea6..dbc868e0363f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -237,7 +237,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t read_doorbell_id(void *mqd)
+static uint32_t check_preemption_failed(void *mqd)
 {
 	struct vi_mqd *m = (struct vi_mqd *)mqd;
 
@@ -482,7 +482,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd->read_doorbell_id = read_doorbell_id;
+		mqd->check_preemption_failed = check_preemption_failed;
 		break;
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
-- 
2.35.1

