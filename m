Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FFEC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28DD60235
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F28DD60235
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22436EA4A;
	Wed, 29 Sep 2021 12:01:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9243E6EA50
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCw8p0Shc0Cj0ydZkiDKsDpbHqYtNOevPt0YWzfTjQ8cvON1tQMEcR1xCVHRSy2nGMQhl0xcFmcFb1cxE8OzSrUG/Pwna4AaNsM3CjyL8VUBQLXsL8pBcP08pbJyhThFw/q6nQ60kkmZYz0dIBB4eIAvi6WgGrdlkYTG9ErkKDzErwZBCHwyTCt6FDd4tZGHXk3SSWD7D4t+TpSfEZdJqI3PHyKn/Pax94RElgMUrjbpYzAau9E8ZSU3TEhFkZJ7q5Hakacboh0UBiiIXYgA4UgrlLBjMvKUaX4PBu4LIxF2lEXi2mcKKAqX47PnsFtLE5WA6ID6muN8GEZE0d/6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YzAQiiAw5OknmfMbr2Hj7CBlYzyssQ0rekhG9qB/guw=;
 b=RPSRq634e3R9L+lTPENpQpZXOWMUImQVuoyt9qdolwdoR8bjb65vFmyUZ3/Yxz9BGT+n9sOk352vWed8f4W/qxlbCtinzvlaIBFm/iA+H5c/vxLfe6rHKpbAObi1wlxRkmgwSn1dCfTV5GV9YBwntZTGc/I2nwtb2dtR85aGaNt75sZ8wLkTRX0iHVmpoFJkozl6lLPL3L35YPSIb3dmnfeuQQ6PpD33ec1l+6cHoIj2JLmxx9vv7y4xomAzit/QUG8APvgUCl0p4NEUGoHbxf+Bw502A9h9/RboogJZca5m2oX2quu06Qz5+u1YvvLn/eAKryajsVd+bDcGR2EhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzAQiiAw5OknmfMbr2Hj7CBlYzyssQ0rekhG9qB/guw=;
 b=HwIHLyUu0i09JHvcc9sh2xt+xzTXpjfEYVosNogQAJRnplSAtYiVc4YGqBVrxemMLNJEK+IsuaXwx95F0A1G22QfX+VZVE+ojFsMQlj+qSnE8qVbLVhWHMywe+shGd/wg4nwfv6fuRFj4zHckQKd2PDd2/OqEr+iYWEVBxArw4w=
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 29 Sep
 2021 12:01:12 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::70) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:11 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:05 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v3 09/16] drm/amdkfd: CRIU restore queue ids
Date: Wed, 29 Sep 2021 08:00:31 -0400
Message-ID: <20210929120038.6485-10-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21e58cce-81c5-42aa-f783-08d98340d4a3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5243:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5243FC92D31788DD2C298A3895A99@BN9PR12MB5243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOuFN3YH4vjuDn+ojxtsX6C65PMikOtf6lZCYVQpM+Ur/SooCgYzeMMOk0dfSqnd1FpQmuFQFn3xdRF8b9damNpTGRolTS8gOcMgoJzTLTntwRmkX9YkP7DhJO4pI9X7Sx3nfguWlNIYJRi3OL6TiVbgTuAFY2+kxk5rExuxcWfWKpVcs/XZwBQb6dS1xxdxwMMGDnZWO4BAHvT8alpdG9x3MeODSaeT1LWducPPooKK957RuzYqrK/E6TP4s5XW3kHCM6IaA0CTLgo6qnQXnzBxGUJdGbcZAyWBZ+mljEnRf6GD1YZUIh8QO7lI5AHYWP9+rAaBGPcXtsSvQz53fyi9byB9cXS5BcZN7rKBSgYfAs+LXG5qMeR6OXyT7Thhx1phi3OPwjVq0fOe26GfgdGxg4qFyPohMDkHil2mnNcx3WoDS584jK21gaLOxQ9y64boPfRtohOLQC9zz0j5KY0TiN+5s6VeUamyWPsr3I3o87ifu9OvOzNWJVv3fyG7IbXWV6+LgxMTBg9YqK+eoFncm9F1bpCEMzqU50K9pY/hnuZWf5yqvm/5A44gy6l4ANM0fFN575mofvKvvnNg3wNdZG1X+6SMi3Yinx45nmttrEQ5x2OJ7+xRWXXQteBs9ySBA/+ljMeS0NI7qdynJrI5KO97d9yKdCZZavq9OMrGb+isn4t1hqx1xrzEbZAQ2moxZh8wg0U7pca2WTPQo88yPE9MHfOtg+YDl6Ga2b8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(83380400001)(4326008)(36860700001)(2906002)(82310400003)(47076005)(70586007)(70206006)(316002)(26005)(54906003)(356005)(81166007)(6916009)(7696005)(36756003)(5660300002)(336012)(508600001)(2616005)(8676002)(6666004)(186003)(426003)(16526019)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:11.6784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e58cce-81c5-42aa-f783-08d98340d4a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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
index 542a77b7f449..8bb470b1ee93 100644
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
index c5329d843ffb..7e52ef69636a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -470,6 +470,7 @@ enum KFD_QUEUE_PRIORITY {
  * it's user mode or kernel mode queue.
  *
  */
+
 struct queue_properties {
 	enum kfd_queue_type type;
 	enum kfd_queue_format format;
@@ -1128,6 +1129,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    const struct kfd_criu_queue_priv_data *q_data,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index f1ec644acdf7..e3cf99dfe352 100644
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
@@ -194,6 +208,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    const struct kfd_criu_queue_priv_data *q_data,
 			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
@@ -225,7 +240,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
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
 
@@ -774,7 +794,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
-- 
2.17.1

