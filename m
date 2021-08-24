Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB2CC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91BA6138B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A91BA6138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5648C6E0C5;
	Tue, 24 Aug 2021 19:23:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138856E0C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX59sNOX3yeV8berDtJqk+j61QfSQI9vZIpNSe0kp1MaXGAsXpi57T4+jn1AqkhfiIXyPZxmpMQYDupTU/v5RgROIfbzHQaym/C8/Am5ES9LKUR/z9MAlWK9jGbbczwEFeq61OvmxU7QWiEpjJ+SzP4XIwS78JopTem5A+UUvuhia1MvvRD01gGzTzOJ03UIpG79PM75oM9C6RvFI9XP9156u54UGywtpBK6mlv2F6EOME4GbzN9MAAFN3acRqg9xT5lIzzpOa2baWqFOI0uOfN8Ye1L+MiQ2S99epgPauTtmpFhWj5aUKUt/vY8HNw6QtGSXErK2aKzoJEn+VORFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKfeMPg1xBsMKCKxW2R7edtnFj18y2zHmSEpqD96jkc=;
 b=Hqb7NEzfDtZJq6PLuv1ZXArED8mq5VT/O+OOyt+Jjxd9ggrBQqP6kPcaF3st8Fjq1d0E65BMrxviTiJjixUy0+hIOPeDJK9mkolwuyl9g69HZrIUAa8yCIglaEdnBAl/b6NwnVr0XwAVuME/rpOiAM2zmML3A/8doabJXDyyq9w/c3z9awgfwBOsj81jb0Vpv5LN4oHb8umTjvW1UvXSbrDeYD1Vki1PMcmzJY1P4MoR/u8HErwJdGUShijIG0HFAIxIvMFbyjvuzqX7GI1pfOcRljBY+14ghGbWiVbnwsqrW1mjTFYlvS1ViwK480sN7HdwQerDs6gCsRqZbfg3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKfeMPg1xBsMKCKxW2R7edtnFj18y2zHmSEpqD96jkc=;
 b=Dlt9G6BUbCH0yaogK6TPTGcPBlJDxpZM0c10Wegw0xBkE57CoIfU2Oz3o4GVNwc8JG8olKUUR+A3I4x/mdyl2CqTdB/M4P6i8sht2CGzFY/3v1pwmC5o6cvNCdXnkR0hmpXXnFqIysrbeU2p73P1cvbEbPofcvUi77af9bHHOqo=
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 19:07:39 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::51) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:39 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:34 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 10/18] drm/amdkfd: CRIU restore queue ids
Date: Tue, 24 Aug 2021 15:06:31 -0400
Message-ID: <20210824190639.6288-11-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 608664eb-d8c6-4966-5f95-08d9673270fe
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384E6B8A7C1E06B96AED32995C59@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2yOUkS+3Gkr2pP+KYpYmmffnbeoEbOxJuR9/OOLAUNu+ccXf90ep5sedaRCMZ8CuLQKutR+BQym/qxoDoeNnmOuwzbHKvD5ez/SCEvJ/mau+ilvTLhDyznpXeI9IxNzjsu3B6H2YjofXzl0vbNeDfkGdI9no+EfaHxrHfReiApAtwBQ03E3YjUnQ9n7Xq22SRKCjzJvga7uZJ27CRkdOhEz4Dh5SI96pLAA1pTlxoZ7JFuXwW66O40tDSRxfE9+vK/BfvSdRYMg4NxUjjU0DSWc/Hhhy1L6XvvPLEujI6JVqgzTMzjGOlGp5uDw1lmbIx+ZlcoM8Eh61xsWGWDNPa0v+bgrEmSsHSJyLrq2zGm9/qN7GV3GinUqpX0VLK7iJPZOsYI/ndY+vJmakdHLElkElEaWW3r80wCtsH14UibXEvsZAJGIHn++9aJ6C9YFPsNcc98QTlmDraOnyDdsY60VYz263PCcunhhNlYKvA1XjBlRgiuitA61aoopO2fpr/Sv+9ssRKPPC8XB+ybKqteZwcTgPepUYM9VsM+/PzV4td7NpMjv3DK/RjKVC52iO27Be9tQb8lCQnjg33oq/eTJnb+9jwSKseuR2RvTUrIZMgNJbQ/BvdwbWejviz0lzpfIZ73oHOz5v8NEIZo7/Su5BdxzV72/YA/Ls3TH4m4V6tjR3O9RCGm9OJrWRca1ftFHP3O3N4DQu+o5N2Z0NKDyFzHC3D/yIadz+pD0aBA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(70206006)(36860700001)(2906002)(356005)(70586007)(1076003)(7696005)(8936002)(26005)(508600001)(82310400003)(47076005)(5660300002)(8676002)(426003)(81166007)(336012)(316002)(36756003)(54906003)(6916009)(6666004)(16526019)(4326008)(186003)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:39.0310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608664eb-d8c6-4966-5f95-08d9673270fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
same queue id value used during CRIU dump.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 24 +++++++++++++++++--
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7f5dc038030c..32dbd0f83ee4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -312,7 +312,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
+	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL,
 			&doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 159add0f5aaa..749a7a3bf191 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
-				&properties, &qid, NULL);
+				&properties, &qid, NULL, NULL);
 
 	if (status) {
 		pr_err("Failed to create DIQ\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7c0f3fc551c7..73e952659bed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -468,6 +468,7 @@ enum KFD_QUEUE_PRIORITY {
  * it's user mode or kernel mode queue.
  *
  */
+
 struct queue_properties {
 	enum kfd_queue_type type;
 	enum kfd_queue_format format;
@@ -1117,6 +1118,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    const struct kfd_criu_queue_priv_data *q_data,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 65cec45190b3..0609bbe7f818 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -42,6 +42,20 @@ static inline struct process_queue_node *get_queue_by_qid(
 	return NULL;
 }
 
+static int assign_queue_slot_by_qid(struct process_queue_manager *pqm,
+				    unsigned int qid)
+{
+	if (qid >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
+		return -EINVAL;
+
+	if (__test_and_set_bit(qid, pqm->queue_slot_bitmap)) {
+		pr_err("Cannot create new queue because requested qid(%u) is in use\n", qid);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int find_available_queue_slot(struct process_queue_manager *pqm,
 					unsigned int *qid)
 {
@@ -193,6 +207,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    const struct kfd_criu_queue_priv_data *q_data,
 			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
@@ -224,7 +239,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	if (pdd->qpd.queue_count >= max_queues)
 		return -ENOSPC;
 
-	retval = find_available_queue_slot(pqm, qid);
+	if (q_data) {
+		retval = assign_queue_slot_by_qid(pqm, q_data->q_id);
+		*qid = q_data->q_id;
+	} else
+		retval = find_available_queue_slot(pqm, qid);
+
 	if (retval != 0)
 		return retval;
 
@@ -773,7 +793,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
-- 
2.17.1

