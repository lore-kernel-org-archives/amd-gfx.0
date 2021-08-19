Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A1C4320E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE02610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCE02610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20E96E983;
	Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB556E94F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f89/lzXIkaP5RKVjVv4KLf749DCvxvnYprtbDHvhyWpjostyok+ZgonUPe8SJ7Az6kU/GKQR0eQAdPAnH4tvOTq2hZiz+n1bK+J0o0i5XUjaeawC9VJCNmk+Fvj9fhk4l84g/Pt06iOvc/9lgY8dz0cvg4CtxBd+hROw3wPIvVlp7cvQKxMUPFt26WSsEiierKB1ew/qX1oPQUdf3eeZ4lTkVzTwN7v2nDPVexzCJvmnZvVExeva9oPid3MpWl/h2hejHuQHiOcPecYbpEkoGguMbAZOV95u8hAjTtXpc3EuoDn2PQZS7lasjsDU2AHu6XhP7ycjSaDBjcw0kEnRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8fH2ktVQEHNpSZPu8TxB6RDZdEIPwb5+e2UzT2LQ2U=;
 b=LO03xnwM9HNlo98XZDFcFO/BdRJHwj10JeDIMS6+h5vDzoHnLhgL85s8RGsyGVIcArY6f3yiW9kqPG45tgeaOjPUYkCTQgQRE3bjbGIzMK0zsZuVoy8svn0MTL9SMKNhewisUmSpKrSuu4a87PJ0emfcyyscNz0beRcxdGXy/KKKIGoMNg6reQoreUpZ9wm62cL8FTcJkn84K6iCEiZhj5Qf19vJ7/RRT21yIritfvcbSWQ9QEhfZGUcTngMbRwXfYdrwYZO48hzep3WZs/OoR6Iv6qE2ZwRZzbv9iZcY4N+Ze5Lvx8HpjuqkzRrzXDc8xgCW5KCovL20Ca+Fk33dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8fH2ktVQEHNpSZPu8TxB6RDZdEIPwb5+e2UzT2LQ2U=;
 b=5R+XsX2mLENomEWR7HYhWfOyxibbZhmYE6ixwrNkEvia9VZoriE+4648QrlJUIU4AZiW2SqS7ArDJQgKNDKPtCpgBJ0xjojmr2GEp8X3iVCywh+cJrgUuJlSsUKwM54foV5isPWTCP1GEpkM+zwF+arN3W4Xgi+o1DqWH4w1ztc=
Received: from CO2PR04CA0177.namprd04.prod.outlook.com (2603:10b6:104:4::31)
 by BN6PR12MB1619.namprd12.prod.outlook.com (2603:10b6:405:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 13:37:58 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::1f) by CO2PR04CA0177.outlook.office365.com
 (2603:10b6:104:4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:58 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:54 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 14/18] drm/amdkfd: CRIU dump/restore queue control stack
Date: Thu, 19 Aug 2021 09:37:09 -0400
Message-ID: <20210819133713.4168-15-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf53550d-da76-4533-b9ca-08d963168ed0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1619:
X-Microsoft-Antispam-PRVS: <BN6PR12MB161961FD41BC5ADA2BE7DD8A95C09@BN6PR12MB1619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dr3a7akgJ3EeyhpnI0DDWysi7L9ygRtfu19jTIBzOj63MzOo4TFqNUCloY+oTf+NXOFMYFOXyvG50MYJ+5xXwAUmXn3igIUdvH7qioUeEMLcb84ELGn8q1XKxvoQQc0SLAT0s/MA6WPbstL+PPqezeXDRZcU9LHl9i00kEwTe2+1ICbrluXUqb8yM/Psoi8xxwoChgzZYjYR4zVLvgWvYl7mcYwdabPuGqoXdLFw66e8GlncI+2z/4/qu6MJqK/dZ5s5SPK2xEYSfWqfwNDnaEYVTSGzDc8VTLJr4XTPF+CAeGoq3ujkGyiCNyHjTmeYQNM+rX0b0J5SDZLi/e2hT8hY30MN5k0l5kfvFG+O+Ud3GmpZ62BNUr6H1sfpFU4wAi0rTfMH6F++6yinJd/eTjQ4WmElbTJqvmx4i4FRMQ25JZKNAyXCtw6VDK5gWWGpEgk2zQhNwnHtQ3Js3CUhwgZOP0Cded8YZMO8Af21ZwnXfyEOE5qIIXEYETOEYsiBRk6EroJQtMR49FDdbY53hlpLxPF5wAe6QiNk1TZo2Bu6U7pfaXiOPLi7z+S2XvVhO6fhLwL4Z9qp3JtSSWTYkBQeGGJWjAGNd+5ACxApMy5HwRSOpLTuXbLWlBGdFpLfjvtvJSSIFC1PPEHlzz04CtCcevRdAwTjK5yrDBN1eiq/YbBwRQKQJo1DKuzCH0hsAdL+PkFLj/t9YtMlDamoAFPYKvK1HVG2P4UxNUxNeholA0T81GCedTA2wmm8wcBWUoUJYAPzyV5JyV7dBxgf0Afyt9cYY8RFNKBoXRcYAw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(8936002)(336012)(4326008)(30864003)(2616005)(70206006)(2906002)(478600001)(5660300002)(426003)(47076005)(36756003)(316002)(26005)(186003)(16526019)(36860700001)(7696005)(54906003)(83380400001)(34020700004)(82310400003)(81166007)(70586007)(86362001)(6916009)(356005)(6666004)(8676002)(82740400003)(1076003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:58.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf53550d-da76-4533-b9ca-08d963168ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1619
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

Dump contents of queue control stacks on CRIU dump and restore them
during CRIU restore.

(rajneesh: rebased to 5.11 and fixed merge conflict)
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 31 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 30 ++++++++++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 10 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  8 +++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 17 +++++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 18 ++++++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 27 +++++++++++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 17 +++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +++--
 .../amd/amdkfd/kfd_process_queue_manager.c    | 19 +++++++-----
 11 files changed, 133 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 68b06037616f..19f16e3dd769 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -313,7 +313,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			dev->id);
 
 	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL,
-			       NULL, &doorbell_offset_in_process);
+			NULL, NULL, &doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
 
@@ -1968,13 +1968,15 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
 static int get_queue_data_sizes(struct kfd_process_device *pdd,
 				struct queue *q,
 				uint32_t *cu_mask_size,
-				uint32_t *mqd_size)
+				uint32_t *mqd_size,
+				uint32_t *ctl_stack_size)
 {
 	int ret;
 
 	*cu_mask_size = sizeof(uint32_t) * (q->properties.cu_mask_count / 32);
 
-	ret = pqm_get_queue_dump_info(&pdd->process->pqm, q->properties.queue_id, mqd_size);
+	ret = pqm_get_queue_dump_info(&pdd->process->pqm, q->properties.queue_id, mqd_size,
+				      ctl_stack_size);
 	if (ret)
 		pr_err("Failed to get queue dump info (%d)\n", ret);
 
@@ -1998,13 +2000,15 @@ int get_process_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t
 				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 				u32 cu_mask_size;
 				u32 mqd_size;
+				u32 ctl_stack_size;
 				int ret;
 
-				ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+				ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size,
+							   &ctl_stack_size);
 				if (ret)
 					return ret;
 
-				data_sizes += cu_mask_size + mqd_size;
+				data_sizes += cu_mask_size + mqd_size + ctl_stack_size;
 				q_index++;
 			} else {
 				pr_err("Unsupported queue type (%d)\n", q->properties.type);
@@ -2024,11 +2028,12 @@ static int criu_dump_queue(struct kfd_process_device *pdd,
 			   void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask, *mqd;
+	uint8_t *cu_mask, *mqd, *ctl_stack;
 	int ret;
 
 	cu_mask = (void *)(q_data + 1);
 	mqd = cu_mask + q_data->cu_mask_size;
+	ctl_stack = mqd + q_data->mqd_size;
 
 	q_bucket->gpu_id = pdd->dev->id;
 	q_data->type = q->properties.type;
@@ -2058,7 +2063,7 @@ static int criu_dump_queue(struct kfd_process_device *pdd,
 	if (q_data->cu_mask_size)
 		memcpy(cu_mask, q->properties.cu_mask, q_data->cu_mask_size);
 
-	ret = pqm_dump_mqd(&pdd->process->pqm, q->properties.queue_id, mqd);
+	ret = pqm_dump_mqd(&pdd->process->pqm, q->properties.queue_id, mqd, ctl_stack);
 	if (ret) {
 		pr_err("Failed dump queue_mqd (%d)\n", ret);
 		return ret;
@@ -2086,6 +2091,7 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 		uint64_t q_data_size;
 		uint32_t cu_mask_size;
 		uint32_t mqd_size;
+		uint32_t ctl_stack_size;
 
 		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
 			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
@@ -2097,11 +2103,11 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		memset(&q_bucket, 0, sizeof(q_bucket));
 
-		ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+		ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size, &ctl_stack_size);
 		if (ret)
 			return ret;
 
-		q_data_size = sizeof(*q_data) + cu_mask_size + mqd_size;
+		q_data_size = sizeof(*q_data) + cu_mask_size + mqd_size + ctl_stack_size;
 
 		/* Increase local buffer space if needed */
 		if (q_private_data_size < q_data_size) {
@@ -2117,8 +2123,10 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
 
+		/* data stored in this order: priv_data, cu_mask, mqd, ctl_stack */
 		q_data->cu_mask_size = cu_mask_size;
 		q_data->mqd_size = mqd_size;
+		q_data->ctl_stack_size = ctl_stack_size;
 
 		ret = criu_dump_queue(pdd, q, &q_bucket, q_data);
 		if (ret)
@@ -2552,7 +2560,7 @@ static int criu_restore_queue(struct kfd_process *p,
 			      void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask, *mqd;
+	uint8_t *cu_mask, *mqd, *ctl_stack;
 	struct queue_properties qp;
 	unsigned int queue_id;
 	int ret = 0;
@@ -2562,6 +2570,7 @@ static int criu_restore_queue(struct kfd_process *p,
 	/* data stored in this order: cu_mask, mqd, ctl_stack */
 	cu_mask = (void *)(q_data + 1);
 	mqd = cu_mask + q_data->cu_mask_size;
+	ctl_stack = mqd + q_data->mqd_size;
 
 	memset(&qp, 0, sizeof(qp));
 	ret = set_queue_properties_from_criu(&qp, q_bucket, q_data, cu_mask);
@@ -2570,7 +2579,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, mqd, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index c6c0cd47e7f7..3c29e60b967f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
-				&properties, &qid, NULL, NULL, NULL);
+				&properties, &qid, NULL, NULL, NULL, NULL);
 
 	if (status) {
 		pr_err("Failed to create DIQ\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 14199e467e96..5943dcf1720f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -319,7 +319,8 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd,
 				const struct kfd_criu_queue_priv_data *qd,
-				const void *restore_mqd)
+				const void *restore_mqd,
+				const void *restore_ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
 	int retval;
@@ -380,8 +381,9 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	}
 
 	if (qd)
-		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
-				&q->gart_mqd_addr, &q->properties, restore_mqd);
+		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
+				     &q->properties, restore_mqd,
+				     restore_ctl_stack, qd->ctl_stack_size);
 	else
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
@@ -1322,7 +1324,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			struct qcm_process_device *qpd,
 			const struct kfd_criu_queue_priv_data *qd,
-			const void *restore_mqd)
+			const void *restore_mqd, const void *restore_ctl_stack)
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
@@ -1370,8 +1372,9 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	q->properties.is_evicted = !!qpd->evicted;
 
 	if (qd)
-		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
-				&q->gart_mqd_addr, &q->properties, restore_mqd);
+		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
+				     &q->properties, restore_mqd, restore_ctl_stack,
+				     qd->ctl_stack_size);
 	else
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
@@ -1759,19 +1762,28 @@ static int get_wave_state(struct device_queue_manager *dqm,
 
 static void get_queue_dump_info(struct device_queue_manager *dqm,
 			const struct queue *q,
-			u32 *mqd_size)
+			u32 *mqd_size,
+			u32 *ctl_stack_size)
 {
 	struct mqd_manager *mqd_mgr;
 	enum KFD_MQD_TYPE mqd_type =
 			get_mqd_type_from_queue_type(q->properties.type);
 
+	dqm_lock(dqm);
 	mqd_mgr = dqm->mqd_mgrs[mqd_type];
 	*mqd_size = mqd_mgr->mqd_size;
+	*ctl_stack_size = 0;
+
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE && mqd_mgr->get_dump_info)
+		mqd_mgr->get_dump_info(mqd_mgr, q->mqd, ctl_stack_size);
+
+	dqm_unlock(dqm);
 }
 
 static int dump_mqd(struct device_queue_manager *dqm,
 			  const struct queue *q,
-			  void *mqd)
+			  void *mqd,
+			  void *ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
 	int r = 0;
@@ -1791,7 +1803,7 @@ static int dump_mqd(struct device_queue_manager *dqm,
 		goto dqm_unlock;
 	}
 
-	mqd_mgr->dump_mqd(mqd_mgr, q->mqd, mqd);
+	mqd_mgr->dump_mqd(mqd_mgr, q->mqd, mqd, ctl_stack);
 
 dqm_unlock:
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index ae4170aece6d..9d7d1308df71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -88,7 +88,8 @@ struct device_queue_manager_ops {
 				struct queue *q,
 				struct qcm_process_device *qpd,
 				const struct kfd_criu_queue_priv_data *qd,
-				const void *restore_mqd);
+				const void *restore_mqd,
+				const void *restore_ctl_stack);
 
 	int	(*destroy_queue)(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
@@ -138,12 +139,13 @@ struct device_queue_manager_ops {
 				  u32 *save_area_used_size);
 
 	void	(*get_queue_dump_info)(struct device_queue_manager *dqm,
-				  const struct queue *q,
-				  u32 *mqd_size);
+				  const struct queue *q, u32 *mqd_size,
+				  u32 *ctl_stack_size);
 
 	int	(*dump_mqd)(struct device_queue_manager *dqm,
 				  const struct queue *q,
-				  void *mqd);
+				  void *mqd,
+				  void *ctl_stack);
 };
 
 struct device_queue_manager_asic_ops {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 497e6f874352..bb91b95b4970 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -98,12 +98,16 @@ struct mqd_manager {
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
 
-	void	(*dump_mqd)(struct mqd_manager *mm, void *mqd, void *mqd_dst);
+	void	(*get_dump_info)(struct mqd_manager *mm, void *mqd, uint32_t *ctl_stack_size);
+
+	void	(*dump_mqd)(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst);
 
 	void	(*restore_mqd)(struct mqd_manager *mm, void **mqd,
 				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 				struct queue_properties *p,
-				const void *mqd_src);
+				const void *mqd_src,
+				const void *ctl_stack_src,
+				const u32 ctl_stack_size);
 
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 1d000252080c..bf32c67b723a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -275,7 +275,13 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 					pipe_id, queue_id);
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void get_dump_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+{
+	/* Control stack is stored in user mode */
+	*ctl_stack_size = 0;
+}
+
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct cik_mqd *m;
 
@@ -287,7 +293,8 @@ static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct cik_mqd *m;
@@ -309,7 +316,7 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct cik_sdma_rlc_registers *m;
 
@@ -321,7 +328,8 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 				struct queue_properties *qp,
-				const void *mqd_src)
+				const void *mqd_src,
+				const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct cik_sdma_rlc_registers *m;
@@ -451,6 +459,7 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd;
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
+		mqd->get_dump_info = get_dump_info;
 		mqd->dump_mqd = dump_mqd;
 		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct cik_mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 0066a2cf5672..6dd06ee98b60 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -283,7 +283,13 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void get_dump_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+{
+	/* Control stack is stored in user mode */
+	*ctl_stack_size = 0;
+}
+
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v10_compute_mqd *m;
 
@@ -295,7 +301,8 @@ static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v10_compute_mqd *m;
@@ -405,7 +412,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v10_sdma_mqd *m;
 
@@ -417,7 +424,9 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			     struct queue_properties *qp,
-			     const void *mqd_src)
+			     const void *mqd_src,
+			     const void *ctl_stack_src,
+			     const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v10_sdma_mqd *m;
@@ -478,6 +487,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = is_occupied;
 		mqd->mqd_size = sizeof(struct v10_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->get_dump_info = get_dump_info;
 		mqd->dump_mqd = dump_mqd;
 		mqd->restore_mqd = restore_mqd;
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 5b6beb69dfc2..db9f138e1135 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -338,21 +338,34 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void get_dump_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+{
+	struct v9_mqd *m = get_mqd(mqd);
+
+	*ctl_stack_size = m->cp_hqd_cntl_stack_size;
+}
+
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v9_mqd *m;
+	/* Control stack is located one page after MQD. */
+	void *ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
 
 	m = get_mqd(mqd);
 
 	memcpy(mqd_dst, m, sizeof(struct v9_mqd));
+	memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
 }
 
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
-			struct queue_properties *qp, const void *mqd_src)
+			struct queue_properties *qp,
+			const void *mqd_src,
+			const void *ctl_stack_src, u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v9_mqd *m;
+	void *ctl_stack;
 
 	m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
@@ -364,6 +377,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 		*gart_addr = addr;
 
 	/* Control stack is located one page after MQD. */
+	ctl_stack = (void *)((uintptr_t)*mqd + PAGE_SIZE);
+	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
+
 	m->cp_hqd_pq_doorbell_control =
 		qp->doorbell_off <<
 			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
@@ -460,7 +476,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v9_sdma_mqd *m;
 
@@ -471,7 +487,9 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
-			     struct queue_properties *qp, const void *mqd_src)
+			     struct queue_properties *qp,
+			     const void *mqd_src,
+			     const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v9_sdma_mqd *m;
@@ -530,6 +548,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->get_dump_info = get_dump_info;
 		mqd->dump_mqd = dump_mqd;
 		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index ae5e3edec92e..88f320abe850 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -303,7 +303,13 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void get_dump_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+{
+	/* Control stack is stored in user mode */
+	*ctl_stack_size = 0;
+}
+
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct vi_mqd *m;
 
@@ -315,7 +321,8 @@ static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct vi_mqd *m;
@@ -429,7 +436,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct vi_sdma_mqd *m;
 
@@ -441,7 +448,8 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			     struct queue_properties *qp,
-			     const void *mqd_src)
+			     const void *mqd_src,
+			     const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct vi_sdma_mqd *m;
@@ -500,6 +508,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->get_dump_info = get_dump_info;
 		mqd->dump_mqd = dump_mqd;
 		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct vi_mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 5d9efcc63208..7ed6f831109d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1117,6 +1117,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
+			    const void *restore_ctl_stack,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
@@ -1139,11 +1140,12 @@ int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
 			      uint64_t fence_value,
 			      unsigned int timeout_ms);
 int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
-			unsigned int qid,
-			u32 *mqd_size);
+			    unsigned int qid,
+			    u32 *mqd_size, u32 *ctl_stack_size);
 int pqm_dump_mqd(struct process_queue_manager *pqm,
 		       unsigned int qid,
-		       void *dst_mqd);
+		       void *dst_mqd,
+		       void *dst_ctl_stack);
 
 /* Packet Manager */
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a7eb1c6a700f..a4f757efc4e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -209,6 +209,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
+			    const void *restore_ctl_stack,
 			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
@@ -273,7 +274,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data,
+						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
 
@@ -293,7 +295,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data,
+						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -528,9 +531,8 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 						       save_area_used_size);
 }
 
-int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
-			unsigned int qid,
-			u32 *mqd_size)
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm, unsigned int qid,
+			u32 *mqd_size, u32 *ctl_stack_size)
 {
 	struct process_queue_node *pqn;
 
@@ -546,12 +548,13 @@ int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
 	}
 
 	pqn->q->device->dqm->ops.get_queue_dump_info(pqn->q->device->dqm,
-						       pqn->q, mqd_size);
+						       pqn->q, mqd_size,
+						       ctl_stack_size);
 	return 0;
 }
 
 int pqm_dump_mqd(struct process_queue_manager *pqm,
-		       unsigned int qid, void *mqd)
+		       unsigned int qid, void *mqd, void *ctl_stack)
 {
 	struct process_queue_node *pqn;
 
@@ -567,7 +570,7 @@ int pqm_dump_mqd(struct process_queue_manager *pqm,
 	}
 
 	return pqn->q->device->dqm->ops.dump_mqd(pqn->q->device->dqm,
-						       pqn->q, mqd);
+						       pqn->q, mqd, ctl_stack);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.17.1

