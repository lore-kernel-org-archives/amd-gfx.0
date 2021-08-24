Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689BCC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2425B6113A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2425B6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4376E0DA;
	Tue, 24 Aug 2021 19:22:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFFA6E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3h/2JOYXQbXwiQaUvSQa61v975aAvuuD/XGugjayOoxZpSsHSOTBkbjCNK9Nq8wT8H4e1x4w0Oyav9dnUZ1HWYoA+su3ZUO2Zis8EHKgvps22a5YeV0zf3wEDLE+9ecc0PK8cutNUnlH4gn/Vr8/hfgkcOBvmnyvlUDLgNR1GUs5CZCtE8x09Jxiq68hONmVHu7d5UYVxP5fWCWoVAYnANNZogaC6y1IAlB13Q3T63V6/hG4ygy7cw1Vxgpa2x44JPGhebHALV74xPoQVujVHligABIg4AcRtbiTKrqxtioBSqYtOV0O95I/qvBysvZDULDVPShWQPjeGnUvVTJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LfSiAREVMcIa8Pl0QMUoPPLFcm/VCmSRTWMlkx8buk=;
 b=kKufo02+jUcYAchzNN0VZ574YGeIzBZ5W3AJzC6t/u5TAnm2s/mIyHxUIMOd6yZCbWi1AhfUPv3YrwjOvVy6JiCFmpNx6YVgnmpleHnREJn2C+S2AjVxLqz1c/C6UIDXhut48uj+eIok0ddjhZT7VQnEN+uk3fC7qHf0d1GqN6hpKy3oksKO2GN/qxC/LMy5oDDUYAV4zE4W7DNCrCZ2UG/M7vCCcAz+dnJg33uXil/4nVO0hsebUfdhqCBTBTP9iwn9oR/AgQJbyI4fLMjG23MI6B6v8OYAjGXyt688MMkCEt5yGfpZG/VfX3eQl9TdOuOpBr5Yf/GtLMq+7ScgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LfSiAREVMcIa8Pl0QMUoPPLFcm/VCmSRTWMlkx8buk=;
 b=mnom7wOF8BzrfhkELtrFTtGAMUvqmpTcBtuR3O9N9RAXJdADwZ7HXObazKIrQ5xDzDrh3tYkkdeuvE/WIyDutgUieSAAM0JHKFa5wy3o8FNiDXxochulkPidW3fZOTjE+B9ZfEhfDt1TU0FPsaBKvD1ici+FjErcNu47TSTkirs=
Received: from DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) by
 SN6PR12MB2671.namprd12.prod.outlook.com (2603:10b6:805:75::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Tue, 24 Aug 2021 19:07:40 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::be) by DM5PR15CA0034.outlook.office365.com
 (2603:10b6:4:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:39 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:35 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 12/18] drm/amdkfd: CRIU restore queue doorbell id
Date: Tue, 24 Aug 2021 15:06:33 -0400
Message-ID: <20210824190639.6288-13-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc22614-c071-4462-ce4c-08d967327149
X-MS-TrafficTypeDiagnostic: SN6PR12MB2671:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26712403E1E90B8F0357EE0C95C59@SN6PR12MB2671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOtg1coMhybDKnRYYSZO9wbglthRu6QCiuqEiD3kfKnvR43K+byoO2d4HRS7Ld6CPB1VA5ZNPKAK+ztZLRH1tZn56ONzRUxvWOP+SAC+VQRbmLSvtfvqptVOARex6gD41Ye8/Dy+3pcDoi/bROZEL0KqbR55CmrAEN51WZ7q+UrIXrmb9aSAl7Njb8FolsXRWlXDGybBlNhrHyhQu8A+TWHGQq0asj4wpAT0FPZLZvRpEyZqxQa+DYQQa7pVC+frw5+pGyL00i6lsIWjkw3+lJT5O7z3ylCPHx5nfEihvoLgRxQ8/v2Uy0RGGpjejpXNYQL45D+NeyNZtkm4JEC5TKeD+qRxazE65SYzKm9F/DLL0HD4czsToogdmhHPk7r7DqebvdXPihOVoTrWkfgfWGxgkoEFpucHR9ajJRVfTTPjZP/SSEsCJvp5lgLFMBUhdquxk32NWGTPBnL6kNZpThnoGbEkJnZhIQTjV3tH4izgsr/x2CMcCVvFc5dhuKuItRhX4jge6mZ6e4xnDxKesSTsHsehjUg2G/5p6GZg1XTvQJjenUISxeZi8D5yZOz+uPQ9hfjvBXSb5r5KJYu1NHxwiHB8DOj057bQVsKEl2ICYGhU7B+F2QD6TBgn1CPA8zEpS63TNTQ9QCzdJoO8Tay4toSJ2BCcT47VrawI0M8L8WAJqUE0xz5NrFYSuy0AYzoEOCRk9wtr44s+34xA997vbBkFnAEObJcblXA4us8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(54906003)(1076003)(6916009)(426003)(82740400003)(47076005)(36756003)(4326008)(16526019)(26005)(70586007)(82310400003)(356005)(70206006)(478600001)(2906002)(8676002)(36860700001)(316002)(8936002)(86362001)(336012)(7696005)(186003)(2616005)(83380400001)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:39.5364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc22614-c071-4462-ce4c-08d967327149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
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

When re-creating queues during CRIU restore, restore the queue with the
same doorbell id value used during CRIU dump.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 61 +++++++++++++------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 677f94e93218..5c268c7726d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -153,7 +153,13 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 		dqm->active_cp_queue_count--;
 }
 
-static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
+/*
+ * Allocate a doorbell ID to this queue.
+ * If doorbell_id is passed in, make sure requested ID is valid then allocate it.
+ */
+static int allocate_doorbell(struct qcm_process_device *qpd,
+			     struct queue *q,
+			     uint32_t const *restore_id)
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
 
@@ -161,6 +167,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 		/* On pre-SOC15 chips we need to use the queue ID to
 		 * preserve the user mode ABI.
 		 */
+		if (restore_id && *restore_id != q->properties.queue_id)
+			return -EINVAL;
+
 		q->doorbell_id = q->properties.queue_id;
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 			q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
@@ -169,25 +178,37 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 		 * The doobell index distance between RLC (2*i) and (2*i+1)
 		 * for a SDMA engine is 512.
 		 */
-		uint32_t *idx_offset =
-				dev->shared_resources.sdma_doorbell_idx;
 
-		q->doorbell_id = idx_offset[q->properties.sdma_engine_id]
-			+ (q->properties.sdma_queue_id & 1)
-			* KFD_QUEUE_DOORBELL_MIRROR_OFFSET
-			+ (q->properties.sdma_queue_id >> 1);
+		uint32_t *idx_offset = dev->shared_resources.sdma_doorbell_idx;
+		uint32_t valid_id = idx_offset[q->properties.sdma_engine_id]
+						+ (q->properties.sdma_queue_id & 1)
+						* KFD_QUEUE_DOORBELL_MIRROR_OFFSET
+						+ (q->properties.sdma_queue_id >> 1);
+
+		if (restore_id && *restore_id != valid_id)
+			return -EINVAL;
+		q->doorbell_id = valid_id;
 	} else {
-		/* For CP queues on SOC15 reserve a free doorbell ID */
-		unsigned int found;
-
-		found = find_first_zero_bit(qpd->doorbell_bitmap,
-					    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
-		if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
-			pr_debug("No doorbells available");
-			return -EBUSY;
+		/* For CP queues on SOC15 */
+		if (restore_id) {
+			/* make sure that ID is free  */
+			if (__test_and_set_bit(*restore_id, qpd->doorbell_bitmap))
+				return -EINVAL;
+
+			q->doorbell_id = *restore_id;
+		} else {
+			/* or reserve a free doorbell ID */
+			unsigned int found;
+
+			found = find_first_zero_bit(qpd->doorbell_bitmap,
+						KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
+			if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
+				pr_debug("No doorbells available");
+				return -EBUSY;
+			}
+			set_bit(found, qpd->doorbell_bitmap);
+			q->doorbell_id = found;
 		}
-		set_bit(found, qpd->doorbell_bitmap);
-		q->doorbell_id = found;
 	}
 
 	q->properties.doorbell_off =
@@ -343,7 +364,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
 	}
 
-	retval = allocate_doorbell(qpd, q);
+	retval = allocate_doorbell(qpd, q, qd ? &qd->doorbell_id : NULL);
 	if (retval)
 		goto out_deallocate_hqd;
 
@@ -998,7 +1019,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 {
 	pr_info("SW scheduler is used");
 	init_interrupts(dqm);
-	
+
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
 		return pm_init(&dqm->packets, dqm);
 	dqm->sched_running = true;
@@ -1314,7 +1335,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			goto out;
 	}
 
-	retval = allocate_doorbell(qpd, q);
+	retval = allocate_doorbell(qpd, q, qd ? &qd->doorbell_id : NULL);
 	if (retval)
 		goto out_deallocate_sdma_queue;
 
-- 
2.17.1

