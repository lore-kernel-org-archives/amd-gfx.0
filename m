Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D70C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B459F610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B459F610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E656E96E;
	Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BA16E96D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6BZibu50BkD5upf7nwvO9VYCtohez26/TyW14/Y+sKo+yfrEPAwAEOiCVi1KBQoh3qTGCTPZyYs4tfVu2uAe9g+NOoeMLKpa4HIuCB2Iz0Nfkip0PYYpWNVAPat10tsJfEPaoVT7+xeC5ILwtNcd+Hv0xu+96CWWFfnmqK4db29gDwzDYOnB68zsBnLxY5h5qHUHeVXh2uLw6BcVOA+dALV1rgMxRX4ekad7HOLJ2eHdKTGLTKGpph4ulPQzG84QiEEIRswwwwKnUVkcqGTECHhq78XQ1DWs6Z+vDSzA1NTREuCr2WZ7qEQwvJTU5ZM2y2ttlf7x14R+MyWPumo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14G4Id+waK/nJNd9PUvkBUoNQl+FfSx5U7SAtPYAQNs=;
 b=b8wet/1DrnvKQA5SmmEQSklMyzIriL6sc24bZzninM/bOXsb3Hl3OOPLgnJMx4nm9uVG5N/GbFICrdHmJX68T/SR3TB8VR/RciPX/d6iI6nrZfcL6uG3VeRkfbCt+5BrY3f+1Gb8+gJVqObI7vQMDv4sPVitPlVGsmWbouhFYqtCHKxKzf0TUD1yjDdz98l6dbGJbd7yVRzAmJT2nCCdl8qcHmEoVQDCxnX5qQecSPKReVx/rdd3FO+400XbP/rmLaEccaGoHeHh9SubQr8EzWBc5qvXAZnKRVzp8MNljT+X2eIWxT2xIZ82EdI9WSriBT4il+CLzj05WDxwEOUbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14G4Id+waK/nJNd9PUvkBUoNQl+FfSx5U7SAtPYAQNs=;
 b=ZLv+At12k+2aGXGWJoXzAGLC++rN1liaguO8qvFu/dr1fBXI/k00EHU3IFUbLKGbElf1OI3Uu5TnZBrRCKDg2LMXbtT39/Sc9jPMIxL/kZnczffp+OHBuewd0EfANIjpKOveDn4rKET0MqOF+PUJ5RUiI9HjWVgWPX7z4xVSZOo=
Received: from MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14)
 by BN8PR12MB3620.namprd12.prod.outlook.com (2603:10b6:408:49::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Thu, 19 Aug
 2021 13:37:56 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a1) by MW4PR04CA0159.outlook.office365.com
 (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:55 +0000
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
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:55 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:51 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 10/18] drm/amdkfd: CRIU restore queue ids
Date: Thu, 19 Aug 2021 09:37:05 -0400
Message-ID: <20210819133713.4168-11-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 992d9e94-2dfd-4743-a732-08d963168d32
X-MS-TrafficTypeDiagnostic: BN8PR12MB3620:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3620C0637524A41F4CEA4A9595C09@BN8PR12MB3620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+jsY1aKaaobXttXc2dcMxCzHwY+Nyva34BXIiQj8O+tSjekGZ8/y25/qV07WgYqsNmT0Er7WiNsn0qBzm1PChHv71qRF5QljfKvAFRJBYh6BBXnDM4aFjqJAa3QmUAyGpPnoORTb7HfJOxETHP6Xn2gOyPEm+49MuMZuemCaXKCq9yuPx0wqt8eZP+V67RBg78Mf9gG/XVYlvM6ZrVMk3UiEHHikO7rv8SrocnFzFFvk4yUioGffv2+wATKjpJawzbPB705xyE6rt+HnQRPl1V5mV4vcp/Ws3Tv2svmNQRcyLNzOfpcjCB0Ln2PqaqUG4DaBT5nDOqkDM7luaWwMvApWVsEuDoScjEaU1ywsQG9DSQo4nib/QB3tD9PhIEiFul5hH09SqbJdIJi5IZtHMmN/xIQmI8/j+xlJgZ2pvjRqU2qxB3bcf9QF96kACkShRwTbbVDsF69FmOyfttZSMMyN7GGxNnuwB7HORBLUuBLhiBAIIcfA+KNkyDOptpGV+rle97Ut73JX34rdcqjln7uXafd/UahxtcmOmepBdxp3OnOcNNPNM/QG7MJY9oo/IKDxNoYwZnFZSkLsRFjwm4U7GaDvOBARPZqd30h+sq5eVXWYwzW4zOilqw/wksQjpbwdJYa7wsUq1fQjOHhe2chW5lzacSle1906oiNnIOHDIa7xVSiWbV7Pd2gf888CyTeqnRvkcKcB4xYsVAOfXuUX36Hjmo6c/GJOjpNPqYEaKGb2pBhRbVueWhK8qIIRqv5Kk89IAhdu5iLkx5trA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(70586007)(47076005)(34020700004)(316002)(8676002)(6916009)(478600001)(70206006)(36756003)(7696005)(1076003)(82310400003)(82740400003)(86362001)(36860700001)(4326008)(6666004)(81166007)(83380400001)(26005)(54906003)(5660300002)(2616005)(336012)(356005)(8936002)(186003)(2906002)(16526019)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:55.7404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992d9e94-2dfd-4743-a732-08d963168d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3620
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
same queue id value used during CRIU dump. Adding a new private
structure queue_restore_data to store queue restore information.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 22 ++++++++++++++++++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6f1c9fb8d46c..813ed42e3ce6 100644
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
@@ -2543,7 +2543,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
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
index 4b4808b191f2..eaf5fe1480e9 100644
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
@@ -1114,6 +1115,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    const struct kfd_criu_queue_priv_data *q_data,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 95a6c36cea4c..e6abab16b8de 100644
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
 
-- 
2.17.1

