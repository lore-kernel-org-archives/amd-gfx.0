Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA4C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE814610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE814610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077436E978;
	Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CFD6E94E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDijGztYhgaTuoXTtcN6n/v16D9SN0dNKP+DTz7iJkYV0Oo8JoxtQcvg7Gkhs3rEa9P7wkMu8MFDDlb3Wq1LF4mEXs2t8ZQOOX1y+EIhE7K5WS8G4ixp3qbPOoapgI88ZJMOW6eukCV4w5t8LpR+wrJstTDBxiITmsNXlnDPerkfNXhqmjNlGgEu93IEIrrpd+WfBrVDxKCJ6Z7Z+PvrjjFwY0yPhDetFnevaZ4XGn5iHGBRxzLT/oDZ8jCsSSXuMkwLc0OddXYyZls0NpiBSyRmzXf/qFuEOaXQ1d+NUA0D/DVPvYga9/Q1gyKx4XHB97TKoIq8bm9SPknhGVH0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVj/LswKKUvNXLQ0pINrGhnMwe6Rl6QH0qoCKi7v4VQ=;
 b=Um4tSWLji1EbjFvDOoentZtwjguw+aGnuAV1TllPBItzTSedQEIkDaKdrP9b0eQZDp7bH6Pj9gePgN2iwxpZzxUlcr27r6AtooRt0qmTIroGPbXC6/blXtg0mSQxWAdLU0L8tZVLd5J6BnDaDlvvcULmWrwgmINVhGfsSTTx0XNmZH/n08XDvsEOCipBp91ua7EozWx29hdnT91nyZxPYZIBmpqk4IZ9gFySKM37lFrMYz3A268bNYz2Ujx0jm96IBPkcQp7H8Y+BFzZi0YTEr6DnYPCjEczIBiGhPktxfRxLg+ar4Y6TbCjj6cdL1Kjd5lyzDMS8anZNCuPsbbl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVj/LswKKUvNXLQ0pINrGhnMwe6Rl6QH0qoCKi7v4VQ=;
 b=D00pSWMfmuBhiYaHeMITqg9xbKM+qpqmSRryMjGQnuvYvZQP/BTmaFTkdqDMPqTRDFT+5z5v8b7GaKkwxwUyAq3Pkk6s/gmUnWOv553CuxlYxZAUng3suEM6Qk0dt3Mq2SQimppNpYcchh4IdcBKlmp6cDrnruL68HJAWJ0l9CI=
Received: from MW4PR04CA0153.namprd04.prod.outlook.com (2603:10b6:303:85::8)
 by BN6PR12MB1409.namprd12.prod.outlook.com (2603:10b6:404:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 13:37:58 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::1f) by MW4PR04CA0153.outlook.office365.com
 (2603:10b6:303:85::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:57 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:53 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 13/18] drm/amdkfd: CRIU dump and restore queue mqds
Date: Thu, 19 Aug 2021 09:37:08 -0400
Message-ID: <20210819133713.4168-14-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bdd48d8a-c30c-47f1-2d2c-08d963168e5c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1409:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14099FE33361C4C46089B12395C09@BN6PR12MB1409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2a8oTInFha4CjFBEOY+JHhbmeNvumNsv4IsZSWjBKW150n3J7tp5hN5vDSouA1CNTSsqt08WrdmnRXF8qYFffsLeEtCYdOUdDXl2Ahvu/0a0+uHjYwpmeesvIbYiPJMloY1krRIvC/JQ07XSiqXJpS6gkGB8t3Xvzkg68p6Nhnf5kwOkeqHcJqeHI0uun4BLz/d5mWns9hHx3TTE52yZ6mmdFDSrZ1HzIDGZ4lmMPjaxSh5wr7lwPX2TC9IPeqTekcHM4rmoLM0Og6fPGxbuyIdwk1Iht4EOKdhd4xoa3rdxLjYPOfAo7JrekTf9cCGcFaFfPKE6042iypMw/xyj0U5aAQ/EVeslHLnZ0jA6HmHoRBtzIeYZV8OnZp5euFaeNiqFD4VloFnigvvMFrg8V9xf7g83KGnc5G6PaBHCl2khrK9uH3lUoKInRBdC9+97djhvAe3KX7jGUNJX5lwGL+QHZNHLR9SAOec4CudnN7BV09ikY0E+YMkzMfxprZyx6BHvAYmKygKGWZc1lX6tgveDOtJWtu9bmrzW8z1dR+FpMUPK4dvEmxMBJNEXiGn0Hsq3MSXCO7OhFeS4CX9iE7xA97V2pLzOTNgEK0BJzEaN/48YUFz1t5Hn5oq1+wGIKUO2CNehj0UK0BORf43+XsUyLC8eP1Ts9LkpeJa20/VZHc4JU34Hm6OEvIJ8ykD86Ml9wgsXKCbq/BXIpWxOwCZV9iJ9RTFgsSyiU9ftKPkj1RmpATba5jh1rvMGMQ6CTu1xfdoQQUl2pIX0J1Ee/V911Mk5xURX7kyTVn3nsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(2906002)(336012)(6916009)(47076005)(83380400001)(8936002)(478600001)(26005)(54906003)(30864003)(6666004)(356005)(81166007)(36756003)(8676002)(186003)(36860700001)(82310400003)(82740400003)(2616005)(16526019)(316002)(426003)(5660300002)(86362001)(4326008)(7696005)(1076003)(70586007)(70206006)(34020700004)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:57.6892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd48d8a-c30c-47f1-2d2c-08d963168e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1409
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

Dump contents of queue MQD's on CRIU dump and restore them during CRIU
restore.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 53 ++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 70 +++++++++++++++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  7 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 67 ++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 68 ++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 67 ++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 68 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 47 ++++++++++++-
 11 files changed, 444 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 813ed42e3ce6..68b06037616f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -313,7 +313,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			dev->id);
 
 	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL,
-			&doorbell_offset_in_process);
+			       NULL, &doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
 
@@ -1965,11 +1965,20 @@ static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
 	return ret;
 }
 
-static void get_queue_data_sizes(struct kfd_process_device *pdd,
+static int get_queue_data_sizes(struct kfd_process_device *pdd,
 				struct queue *q,
-				uint32_t *cu_mask_size)
+				uint32_t *cu_mask_size,
+				uint32_t *mqd_size)
 {
+	int ret;
+
 	*cu_mask_size = sizeof(uint32_t) * (q->properties.cu_mask_count / 32);
+
+	ret = pqm_get_queue_dump_info(&pdd->process->pqm, q->properties.queue_id, mqd_size);
+	if (ret)
+		pr_err("Failed to get queue dump info (%d)\n", ret);
+
+	return ret;
 }
 
 int get_process_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t *q_data_sizes)
@@ -1988,10 +1997,14 @@ int get_process_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t
 				q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 				u32 cu_mask_size;
+				u32 mqd_size;
+				int ret;
 
-				get_queue_data_sizes(pdd, q, &cu_mask_size);
+				ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+				if (ret)
+					return ret;
 
-				data_sizes += cu_mask_size;
+				data_sizes += cu_mask_size + mqd_size;
 				q_index++;
 			} else {
 				pr_err("Unsupported queue type (%d)\n", q->properties.type);
@@ -2005,15 +2018,17 @@ int get_process_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t
 	return 0;
 }
 
-static void criu_dump_queue(struct kfd_process_device *pdd,
+static int criu_dump_queue(struct kfd_process_device *pdd,
 			   struct queue *q,
 			   struct kfd_criu_queue_bucket *q_bucket,
 			   void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask;
+	uint8_t *cu_mask, *mqd;
+	int ret;
 
 	cu_mask = (void *)(q_data + 1);
+	mqd = cu_mask + q_data->cu_mask_size;
 
 	q_bucket->gpu_id = pdd->dev->id;
 	q_data->type = q->properties.type;
@@ -2043,7 +2058,14 @@ static void criu_dump_queue(struct kfd_process_device *pdd,
 	if (q_data->cu_mask_size)
 		memcpy(cu_mask, q->properties.cu_mask, q_data->cu_mask_size);
 
+	ret = pqm_dump_mqd(&pdd->process->pqm, q->properties.queue_id, mqd);
+	if (ret) {
+		pr_err("Failed dump queue_mqd (%d)\n", ret);
+		return ret;
+	}
+
 	pr_debug("Dumping Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
+	return ret;
 }
 
 static int criu_dump_queues_device(struct kfd_process_device *pdd,
@@ -2063,6 +2085,7 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 		struct kfd_criu_queue_priv_data *q_data;
 		uint64_t q_data_size;
 		uint32_t cu_mask_size;
+		uint32_t mqd_size;
 
 		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
 			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
@@ -2074,9 +2097,11 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		memset(&q_bucket, 0, sizeof(q_bucket));
 
-		get_queue_data_sizes(pdd, q, &cu_mask_size);
+		ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+		if (ret)
+			return ret;
 
-		q_data_size = sizeof(*q_data) + cu_mask_size;
+		q_data_size = sizeof(*q_data) + cu_mask_size + mqd_size;
 
 		/* Increase local buffer space if needed */
 		if (q_private_data_size < q_data_size) {
@@ -2093,8 +2118,11 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
 
 		q_data->cu_mask_size = cu_mask_size;
+		q_data->mqd_size = mqd_size;
 
-		criu_dump_queue(pdd, q, &q_bucket, q_data);
+		ret = criu_dump_queue(pdd, q, &q_bucket, q_data);
+		if (ret)
+			break;
 
 		q_bucket.priv_data_offset = *queues_priv_data_offset;
 		q_bucket.priv_data_size = q_data_size;
@@ -2524,7 +2552,7 @@ static int criu_restore_queue(struct kfd_process *p,
 			      void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask, *mqd, *ctl_stack;
+	uint8_t *cu_mask, *mqd;
 	struct queue_properties qp;
 	unsigned int queue_id;
 	int ret = 0;
@@ -2534,7 +2562,6 @@ static int criu_restore_queue(struct kfd_process *p,
 	/* data stored in this order: cu_mask, mqd, ctl_stack */
 	cu_mask = (void *)(q_data + 1);
 	mqd = cu_mask + q_data->cu_mask_size;
-	ctl_stack = mqd + q_data->mqd_size;
 
 	memset(&qp, 0, sizeof(qp));
 	ret = set_queue_properties_from_criu(&qp, q_bucket, q_data, cu_mask);
@@ -2543,7 +2570,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, mqd, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 749a7a3bf191..c6c0cd47e7f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
-				&properties, &qid, NULL, NULL);
+				&properties, &qid, NULL, NULL, NULL);
 
 	if (status) {
 		pr_err("Failed to create DIQ\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5c268c7726d2..14199e467e96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -318,7 +318,8 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd,
-				const struct kfd_criu_queue_priv_data *qd)
+				const struct kfd_criu_queue_priv_data *qd,
+				const void *restore_mqd)
 {
 	struct mqd_manager *mqd_mgr;
 	int retval;
@@ -377,8 +378,14 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		retval = -ENOMEM;
 		goto out_deallocate_doorbell;
 	}
-	mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
-				&q->gart_mqd_addr, &q->properties);
+
+	if (qd)
+		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
+				&q->gart_mqd_addr, &q->properties, restore_mqd);
+	else
+		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
+					&q->gart_mqd_addr, &q->properties);
+
 	if (q->properties.is_active) {
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
@@ -1314,7 +1321,8 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 
 static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			struct qcm_process_device *qpd,
-			const struct kfd_criu_queue_priv_data *qd)
+			const struct kfd_criu_queue_priv_data *qd,
+			const void *restore_mqd)
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
@@ -1360,8 +1368,13 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	 * updates the is_evicted flag but is a no-op otherwise.
 	 */
 	q->properties.is_evicted = !!qpd->evicted;
-	mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
-				&q->gart_mqd_addr, &q->properties);
+
+	if (qd)
+		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
+				&q->gart_mqd_addr, &q->properties, restore_mqd);
+	else
+		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
+					&q->gart_mqd_addr, &q->properties);
 
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
@@ -1744,6 +1757,47 @@ static int get_wave_state(struct device_queue_manager *dqm,
 	return r;
 }
 
+static void get_queue_dump_info(struct device_queue_manager *dqm,
+			const struct queue *q,
+			u32 *mqd_size)
+{
+	struct mqd_manager *mqd_mgr;
+	enum KFD_MQD_TYPE mqd_type =
+			get_mqd_type_from_queue_type(q->properties.type);
+
+	mqd_mgr = dqm->mqd_mgrs[mqd_type];
+	*mqd_size = mqd_mgr->mqd_size;
+}
+
+static int dump_mqd(struct device_queue_manager *dqm,
+			  const struct queue *q,
+			  void *mqd)
+{
+	struct mqd_manager *mqd_mgr;
+	int r = 0;
+	enum KFD_MQD_TYPE mqd_type =
+			get_mqd_type_from_queue_type(q->properties.type);
+
+	dqm_lock(dqm);
+
+	if (q->properties.is_active || !q->device->cwsr_enabled) {
+		r = -EINVAL;
+		goto dqm_unlock;
+	}
+
+	mqd_mgr = dqm->mqd_mgrs[mqd_type];
+	if (!mqd_mgr->dump_mqd) {
+		r = -EOPNOTSUPP;
+		goto dqm_unlock;
+	}
+
+	mqd_mgr->dump_mqd(mqd_mgr, q->mqd, mqd);
+
+dqm_unlock:
+	dqm_unlock(dqm);
+	return r;
+}
+
 static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
@@ -1918,6 +1972,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.evict_process_queues = evict_process_queues_cpsch;
 		dqm->ops.restore_process_queues = restore_process_queues_cpsch;
 		dqm->ops.get_wave_state = get_wave_state;
+		dqm->ops.get_queue_dump_info = get_queue_dump_info;
+		dqm->ops.dump_mqd = dump_mqd;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
 		/* initialize dqm for no cp scheduling */
@@ -1937,6 +1993,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.restore_process_queues =
 			restore_process_queues_nocpsch;
 		dqm->ops.get_wave_state = get_wave_state;
+		dqm->ops.get_queue_dump_info = get_queue_dump_info;
+		dqm->ops.dump_mqd = dump_mqd;
 		break;
 	default:
 		pr_err("Invalid scheduling policy %d\n", dqm->sched_policy);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 02cfa098ca1c..ae4170aece6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -87,7 +87,8 @@ struct device_queue_manager_ops {
 	int	(*create_queue)(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd,
-				const struct kfd_criu_queue_priv_data *qd);
+				const struct kfd_criu_queue_priv_data *qd,
+				const void *restore_mqd);
 
 	int	(*destroy_queue)(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
@@ -135,6 +136,14 @@ struct device_queue_manager_ops {
 				  void __user *ctl_stack,
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
+
+	void	(*get_queue_dump_info)(struct device_queue_manager *dqm,
+				  const struct queue *q,
+				  u32 *mqd_size);
+
+	int	(*dump_mqd)(struct device_queue_manager *dqm,
+				  const struct queue *q,
+				  void *mqd);
 };
 
 struct device_queue_manager_asic_ops {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index b5e2ea7550d4..497e6f874352 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -98,6 +98,13 @@ struct mqd_manager {
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
 
+	void	(*dump_mqd)(struct mqd_manager *mm, void *mqd, void *mqd_dst);
+
+	void	(*restore_mqd)(struct mqd_manager *mm, void **mqd,
+				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+				struct queue_properties *p,
+				const void *mqd_src);
+
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 064914e1e8d6..1d000252080c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -275,6 +275,69 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 					pipe_id, queue_id);
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct cik_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct cik_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct cik_mqd *m;
+
+	m = (struct cik_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control = DOORBELL_OFFSET(qp->doorbell_off);
+
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct cik_sdma_rlc_registers *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct cik_sdma_rlc_registers));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+				struct queue_properties *qp,
+				const void *mqd_src)
+{
+	uint64_t addr;
+	struct cik_sdma_rlc_registers *m;
+
+	m = (struct cik_sdma_rlc_registers *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 /*
  * preempt type here is ignored because there is only one way
  * to preempt sdma queue
@@ -388,6 +451,8 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd;
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct cik_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -428,6 +493,8 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct cik_sdma_rlc_registers);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c7fb59ca597f..0066a2cf5672 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -283,6 +283,41 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v10_compute_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v10_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct v10_compute_mqd *m;
+
+	m = (struct v10_compute_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -370,6 +405,35 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v10_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v10_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src)
+{
+	uint64_t addr;
+	struct v10_sdma_mqd *m;
+
+	m = (struct v10_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -414,6 +478,8 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = is_occupied;
 		mqd->mqd_size = sizeof(struct v10_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -458,6 +524,8 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
 		mqd->mqd_size = sizeof(struct v10_sdma_mqd);
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7f4e102ff4bd..5b6beb69dfc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -338,6 +338,41 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v9_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v9_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp, const void *mqd_src)
+{
+	uint64_t addr;
+	struct v9_mqd *m;
+
+	m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	/* Control stack is located one page after MQD. */
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+				m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -425,6 +460,34 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v9_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v9_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp, const void *mqd_src)
+{
+	uint64_t addr;
+	struct v9_sdma_mqd *m;
+
+	m = (struct v9_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -467,6 +530,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -507,6 +572,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v9_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 33dbd22d290f..ae5e3edec92e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -303,6 +303,41 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct vi_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct vi_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct vi_mqd *m;
+
+	m = (struct vi_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -394,6 +429,35 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct vi_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct vi_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src)
+{
+	uint64_t addr;
+	struct vi_sdma_mqd *m;
+
+	m = (struct vi_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -436,6 +500,8 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct vi_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -476,6 +542,8 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct vi_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index eaf5fe1480e9..5d9efcc63208 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1116,6 +1116,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
+			    const void *restore_mqd,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
@@ -1137,6 +1138,12 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
 			      uint64_t fence_value,
 			      unsigned int timeout_ms);
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
+			unsigned int qid,
+			u32 *mqd_size);
+int pqm_dump_mqd(struct process_queue_manager *pqm,
+		       unsigned int qid,
+		       void *dst_mqd);
 
 /* Packet Manager */
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index f30e128ee9c5..a7eb1c6a700f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -208,6 +208,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
+			    const void *restore_mqd,
 			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
@@ -272,7 +273,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
 		print_queue(q);
 		break;
 
@@ -292,7 +293,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -527,6 +528,48 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 						       save_area_used_size);
 }
 
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
+			unsigned int qid,
+			u32 *mqd_size)
+{
+	struct process_queue_node *pqn;
+
+	pqn = get_queue_by_qid(pqm, qid);
+	if (!pqn) {
+		pr_debug("amdkfd: No queue %d exists for operation\n", qid);
+		return -EFAULT;
+	}
+
+	if (!pqn->q->device->dqm->ops.get_queue_dump_info) {
+		pr_err("amdkfd: queue dumping not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	pqn->q->device->dqm->ops.get_queue_dump_info(pqn->q->device->dqm,
+						       pqn->q, mqd_size);
+	return 0;
+}
+
+int pqm_dump_mqd(struct process_queue_manager *pqm,
+		       unsigned int qid, void *mqd)
+{
+	struct process_queue_node *pqn;
+
+	pqn = get_queue_by_qid(pqm, qid);
+	if (!pqn) {
+		pr_debug("amdkfd: No queue %d exists for operation\n", qid);
+		return -EFAULT;
+	}
+
+	if (!pqn->q->device->dqm->ops.dump_mqd) {
+		pr_err("amdkfd: queue dumping not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return pqn->q->device->dqm->ops.dump_mqd(pqn->q->device->dqm,
+						       pqn->q, mqd);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 int pqm_debugfs_mqds(struct seq_file *m, void *data)
-- 
2.17.1

