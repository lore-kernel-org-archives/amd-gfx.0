Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D691CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 17:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEB410E88A;
	Wed, 27 May 2026 17:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eufxLiWG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792C910E88A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 17:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkoMnDQmEgKNoWmBVcHDFwPdOg3onX6kNtH3cKLN9ejGQkVt4/s1lEm52oSgqdE4ucNRyqi1sw2IXPa3Hoq+iFdwQFkIC5H9aOwZ9HweDXkOhVXNAcFo1wiv/FNSwqzd9RLx7DZQAYvhsRfCzWyZ2YKaYV3LyZuxHnhQPV4E5Qv22B0LDgGHjY7ew35ibK9eWii9wL9Y1xtyMe+yJrkmA9vDcobupXrjZDOW/4ZMTrbtTg8iLOqcgOBDwKI4oVRj3rYMAyInM5EAbyZtbDorQ5qDlzdyR/IkyO+ZVMSwAVmnyMchDoOcj8ZftQxbSlK+h4wshJGeTpefTSApvkowdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tffNVrEyUMn4h1jZqI0Za2IoRS/wkuJDyIkkRoh6GlM=;
 b=ekxCwOJ0UF8dwHIn0ZZquI+CggOXEwrv2Ak+az0FBfIUt3Kry7qCHuXSaOQVpPuY0k5Om1ch+Pu2gH4RSyeNFqAd8aS9plBYDaoY6dFE/E2AkHW5SNxjQ664MABzeBMYJzpP7BU3MOVPmk/qrPBDJZKMW2cBPpxJImKfAc1qDSY4L4AmXGo4y+Va1FAeK9qlpywkVlHP3s3QcfvmQT13nOKm6a+QBvzXngVTzkX73PRIgS8C5OkFhCnOONLL+s42AdWwF/F1Tie6X8Du/iVf2B/TRNZ2chH97VG/O0ATXWD9fbsF9kFATUExYAW5eAQ6r4TpgxmKW8XPKluM13iC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tffNVrEyUMn4h1jZqI0Za2IoRS/wkuJDyIkkRoh6GlM=;
 b=eufxLiWG3QdIeh4MF5HL00TZDVmoJ00r50uOkLul0t2YGnX5mRAKj9HdBNP8l1FgEwnSQ3e9tDvYt6LuZtoIJYu/fqVCrOBio2W4ITt3fvWXquy4iwpvhoTzSg96nIuqqIrcp/6rhAadWiQKfFJ8hJtSUtFsh0iSuPak9ryEQpQ=
Received: from SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:59:36 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::92) by SA9P223CA0027.outlook.office365.com
 (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 17:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:59:35 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 27 May 2026 12:59:34 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add sdma queue counter for gfxv9
Date: Wed, 27 May 2026 13:59:21 -0400
Message-ID: <20260527175921.192734-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecdc609-5487-4719-5b37-08debc19b688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: exd3ocTeH5jAFsLg7TTjc6vUJGV7Tv36uxBLQWSXeJceqaYNx3uxsFfPna8HzR/o+eolJS5ESfI3oNQBRoZ9L2/2HaKPdmY4PXttibBrL966kjMIjkv6UQXVOxb/bsprKmlTCqJrG5zjqENLvsmUvDfUpOFCIpUmAkzR3ZrglSUtJod0MR8nH4KgKCK1mNx+F08YlttHPnpedLHB91NvsbMbQfLjst0A1ylhcC9Nyy/q9Y4KvZqVuJ7quEx1p32cKJldVnt3Qbe5I0rhXq+Jm8JL6SPd2ujblmOJ3RC3B5YOh5M5Q1u+2bqyVWbtAP4uD22p4jwTHdDfzLx7aWAKSnzZFsdu5H5CmORBDqWK9FfXlvb4viUsiCsLQUaP4IBkoOpIyUsDnihC47LNZt5MZL3EUQ8/7jBYWtq2/xFe8Nytb6+5HV2NwDYOdfDj+DQ+X7xgjrWyp7u1npdkmJ8GwfVPF+bj9xzPznW0fTks9bkrBFydsIJfDzkGEpa0DYDigyQVvFp9gox+gta2mbRVYwz0EET0XgOI5n47ISqFDT4VDn4CISuhUGJT54IRSt6lBsCFKIk7CUFvN6EaS2zwY9sCGGU2z/4Oc4IVFT/BwEsoqe1Tf3BXtLsM6YDAw81Ew3RbzVw8HVbefdtkt9pPbqicItuO+oeXl+C4bIGDFQCVQ+hl8g8V2p4o6cKu/nT+tG7zRz5ghDF75xTWiZWWhFWdl5W/a4OuUPfiB879Ydo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ygnh4IGx979Jnlg9UXwKxlGg6AwDm1Uhh5HhVcNObfS7gH+tlFY/kXiDuyADgc7CEjq/0duieNwmknbiMJiF5WGzSFDuH98k+I/n9D3Z69HRTldlS3clGmmxcR08ZYP+yu6D2vWRT3nu8d7VZfI6/x/VYrtf+EEUGwz9oA1UGeQmCTryZgIGQvk+qhLQh/XBU8HvcT3raNzmWeLMD34yAM9WLin/vABwPMM2tziBZYc6SLIOpDkGbpfeVLzCXr6Ta+q5XTcaeywjfEYDGcXCY2jkokbvzrxC45vf0nMGdr7SLR9jC248aWNx3IFIQAhTLNFue3jQBsxLE2gONxxObFklCvCxjJQGsolWuDyjhVZATxm7Du4nE16w8JzY/1Kf94pWNer2UFJO4uFCSPnUP1sG6mJz6T6jlVdeOf2mNGMYgNZBYk6Ud5UiODmXDLue
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:59:35.5165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecdc609-5487-4719-5b37-08debc19b688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
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

since gfx 9.4.3 HW is calculating accumulated activity counter
per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
will still keep the way to read from memory at rptr+8.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 26 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 18 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 15 ++++++++++-
 drivers/gpu/drm/amd/include/v9_structs.h      |  4 +--
 5 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4c2378bbdc95..1a69091aa695 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1064,8 +1064,14 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
-							&sdma_val);
+		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
+			retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
+							 &sdma_val);
+		else
+			retval = mqd_mgr->read_sdma_counter ?
+				 mqd_mgr->read_sdma_counter(q->mqd, &sdma_val) :
+				 0;
+
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
@@ -2689,7 +2695,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				struct queue *q)
 {
 	int retval;
-	struct mqd_manager *mqd_mgr;
+	struct mqd_manager *mqd_mgr =
+		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 	uint64_t sdma_val = 0;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct device *dev = dqm->dev->adev->dev;
@@ -2697,8 +2704,14 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
-							&sdma_val);
+		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
+			retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
+					                 &sdma_val);
+		else
+			retval = mqd_mgr->read_sdma_counter ?
+				 mqd_mgr->read_sdma_counter(q->mqd, &sdma_val) :
+				 0;
+
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
@@ -2724,9 +2737,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	}
 
-	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
-			q->properties.type)];
-
 	deallocate_doorbell(qpd, q);
 
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 06ca6235ff1b..7d3b801ea6e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -123,6 +123,7 @@ struct mqd_manager {
 	bool (*check_preemption_failed)(struct mqd_manager *mm, void *mqd);
 	uint64_t (*mqd_stride)(struct mqd_manager *mm,
 				struct queue_properties *p);
+	int (*read_sdma_counter)(void *mqd, uint64_t *val);
 
 	struct mutex	mqd_mutex;
 	struct kfd_node	*dev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index a04102fd2fb7..fe3a676d734f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -959,6 +959,23 @@ static int get_wave_state_v9_4_3(struct mqd_manager *mm, void *mqd,
 	return err;
 }
 
+static int read_sdma_counter(void *mqd, uint64_t *val)
+{
+	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
+
+	if (!m)
+		return -EINVAL;
+
+	/* Since GC 9.4.3 sdma queue activity accumulated
+	 * counter is saved/restored in MQD by CPFW when
+	 * queue is unmapped/mapped.
+	 */
+	*val = ((uint64_t)m->sdmax_rlcx_utilization_hi << 32) |
+		m->sdmax_rlcx_utilization_lo;
+
+	return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -1072,6 +1089,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v9_sdma_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
+		mqd->read_sdma_counter = read_sdma_counter;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 419bb8086ccd..270f253213e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -91,6 +91,7 @@ struct kfd_sdma_activity_handler_workarea {
 
 struct temp_sdma_queue_list {
 	uint64_t __user *rptr;
+	void *mqd;
 	uint64_t sdma_val;
 	unsigned int queue_id;
 	struct list_head list;
@@ -108,6 +109,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	int ret = 0;
 	struct temp_sdma_queue_list sdma_q_list;
 	struct temp_sdma_queue_list *sdma_q, *next;
+	struct mqd_manager *mqd_mgr;
 
 	workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
 				sdma_activity_work);
@@ -119,6 +121,9 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	qpd = &pdd->qpd;
 	if (!dqm || !qpd)
 		return;
+
+	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA];
+
 	/*
 	 * Total SDMA activity is current SDMA activity + past SDMA activity
 	 * Past SDMA count is stored in pdd.
@@ -161,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 		INIT_LIST_HEAD(&sdma_q->list);
 		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
+		sdma_q->mqd = q->mqd;
 		sdma_q->queue_id = q->properties.queue_id;
 		list_add_tail(&sdma_q->list, &sdma_q_list.list);
 	}
@@ -189,7 +195,14 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
 		val = 0;
-		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+
+		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
+			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+		else
+			ret = mqd_mgr->read_sdma_counter ?
+			      mqd_mgr->read_sdma_counter(sdma_q->mqd, &val) :
+			      0;
+
 		if (ret) {
 			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
 				 sdma_q->queue_id);
diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
index a2f81b9c38af..e0d387f08576 100644
--- a/drivers/gpu/drm/amd/include/v9_structs.h
+++ b/drivers/gpu/drm/amd/include/v9_structs.h
@@ -69,8 +69,8 @@ struct v9_sdma_mqd {
 	uint32_t sdmax_rlcx_midcmd_cntl;
 	uint32_t reserved_42;
 	uint32_t reserved_43;
-	uint32_t reserved_44;
-	uint32_t reserved_45;
+	uint32_t sdmax_rlcx_utilization_lo;
+	uint32_t sdmax_rlcx_utilization_hi;
 	uint32_t reserved_46;
 	uint32_t reserved_47;
 	uint32_t reserved_48;
-- 
2.34.1

