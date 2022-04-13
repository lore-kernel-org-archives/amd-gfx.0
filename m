Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EE2C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 15:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3744D10E656;
	Wed, 13 Apr 2022 15:52:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BCF10E656
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 15:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6xRuQfRTMXz0ezIBZh3SFuLMtcQsdR6hC1/FN7OD1xVFsVvq2vTO5Zo2sH+fLq9NNgUPjB4KdFq8+8jfoQwygTC3TeHu/vpGeXHe+8Kb3mIdqw0+HQz4m52ts0uZV8YXXW0/6qXNYkR10pHecYSXFQoEyjojQeCHjVVL6Y10uRyJ5aOUJygJgIxQq4Kk5VdT7nhY0McPmCE2bRh8DGW7TotCPinAp3cDjipxuttYlIzuFWd0sm5cHEn0BOBMsBKX0kjCiUm8NTQznAMt5MzbN3v37783mVeVYoYjUliKGEBiyjLKEP6AF90jSWU6J2nntzyoLoPr/RE0xIm2Px01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rlelwl3e6rhTb1rM95Nn2bnsY/H81h+dDuZE1q1KMw=;
 b=XbrtD8XB/YWIgfqValHqR2y9H2LrNNAM6jekdmG2rblyJa8r7yq3zNHpNqRZnkA5UBnuyosSOS23l9HhfFUq4rQx/LE9MeNHf5oOEn7/lC99lCGcZyS27NuR/EfqqAUtW8RI5Sp2M2DH7D+UOWvuwA6fuFvxWy+QwooTuDNRfHJbJNF4np63VaCI072202VUYRoU/yKVnmCJohS7Nk+JkXjuh/Ztj3KGoFAvgcLCFJvxqq+Qe8oLgqc+Nv8FOK45vnsxB3di5lwvr9ppdEBagkrPsGS8KYprEwDgd/IvMY0esMcEW/1OydciAdLrLRwWvtXrOyU63Q0V3Pt38SNrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rlelwl3e6rhTb1rM95Nn2bnsY/H81h+dDuZE1q1KMw=;
 b=Qhs2lRUlFBRLldsIqqeKBtBXK/dSRAD/CKOYHLFVXAeYopDAuV2WqFtjCnP3zWViZLEoixJ5ttkzp2RgHh2htSftVs835qOAl6g+bouJ1gwSQ11x79GrozN1MsLIws6GsVzgOsd9WdJNu5pFdinLCsSHe/9rSUZBpShZzgSQocQ=
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 15:52:03 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::af) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 15:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 15:52:02 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 10:51:57 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: CRIU add support for GWS queues
Date: Wed, 13 Apr 2022 11:51:45 -0400
Message-ID: <20220413155145.861750-2-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413155145.861750-1-david.yatsin@amd.com>
References: <20220413155145.861750-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09823419-a708-4337-6195-08da1d658d81
X-MS-TrafficTypeDiagnostic: BY5PR12MB4225:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4225C30D723B1B0C78861D9295EC9@BY5PR12MB4225.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iO7jMuqOElnIHozi3ZUcyExPZGlOmLsR6+fLpfCsfMAR7AJ9UE+YsBqaOl9yr3jzJWCATAutT04MVQQ5BqDSe6LrAZxLtLuCWlvthWwsVBwsMsyR3wsdgcPihmTaEVj3KJUFz8F1fsXxrOdl4a68QZydAYKMiG2Kavb3ZzVOHURFm8lJho/piQsqmp6JjYhELZwffk3NmtPoKB3o2zkTBJGJ7ZP9dNzHVuKKhRAZKL8j6bprI+hUV6AZH6+7rBnmcQ9V8QYiCDnSQlzDgW2nbX2jnvKh7zhVj9OYXIPGx2lw047mhFiTfod/41bCCp9zeeAGfG8G7CFCRc9aaIJi9gdMHZhZjfgKgfzDDREv5rk6l7JDG2JzGXN4zJaRR5pfNFLxvj6+d7PK42wYlnZosgMHKUVhQm39UyyVd0z/virDD8jv4/suCuHM1qVtoYBZ4T5rNcUKlMsgYhKzaV+S0b5iaDWQhBa3u46U2TpBFkMuCkJ9OcDFD8sK9euZthMlf8+Q4kjB1BTpf5zcpNeLZ5s+/W2wxTeo/4ffoGZVqK8AuJ6LZGQsSNzTMiRyCFntoaTxf8CK936fiheXRFaMCAV2qn6kglnv5dwBE5M/H35tfRXGVouMX50QT55e68EeKOw9/eKBaxBmFf18zRO1JyuXKaTnBLxOHWGTWD14oGI8FcY0NAcMs23YxbUYRnZA6RI3vbD3P9wm7vIg/l7/cddaI58mibyKun7JDzCgbuXj0JFtzARvPkxobO773DZd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(356005)(7696005)(316002)(81166007)(2616005)(70206006)(1076003)(508600001)(6666004)(86362001)(6916009)(54906003)(5660300002)(26005)(4326008)(8676002)(36860700001)(83380400001)(36756003)(8936002)(47076005)(426003)(336012)(186003)(16526019)(82310400005)(70586007)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 15:52:02.7596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09823419-a708-4337-6195-08da1d658d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding support to checkpoint/restore GWS(Global Wave Sync) queues.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 ++--
 .../amd/amdkfd/kfd_process_queue_manager.c    | 22 ++++++++++++++-----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e1e2362841f8..b2c72ddd9c1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1377,7 +1377,7 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		goto out_unlock;
 	}
 
-	retval = pqm_set_gws(&p->pqm, args->queue_id, args->num_gws ? dev->gws : NULL);
+	retval = pqm_set_gws(&p->pqm, args->queue_id, args->num_gws ? dev->gws : NULL, false);
 	mutex_unlock(&p->mutex);
 
 	args->first_gws = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f36062be9ca8..3ec32675210c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1102,7 +1102,7 @@ struct kfd_criu_queue_priv_data {
 	uint32_t priority;
 	uint32_t q_percent;
 	uint32_t doorbell_id;
-	uint32_t is_gws;
+	uint32_t gws;
 	uint32_t sdma_id;
 	uint32_t eop_ring_buffer_size;
 	uint32_t ctx_save_restore_area_size;
@@ -1199,7 +1199,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm, unsigned int
 int pqm_update_mqd(struct process_queue_manager *pqm, unsigned int qid,
 			struct mqd_update_info *minfo);
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
-			void *gws);
+			void *gws, bool criu_restore);
 struct kernel_queue *pqm_get_kernel_queue(struct process_queue_manager *pqm,
 						unsigned int qid);
 struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6eca9509f2e3..3eb9d43fdaac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -91,7 +91,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 }
 
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
-			void *gws)
+		void *gws, bool criu_restore)
 {
 	struct kfd_dev *dev = NULL;
 	struct process_queue_node *pqn;
@@ -135,8 +135,14 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	pqn->q->gws = mem;
 	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
 
-	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q, NULL);
+	ret = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
+						    pqn->q, NULL);
+
+	if (!ret && criu_restore) {
+		dev->dqm->gws_queue_count++;
+		pdd->qpd.mapped_gws_queue = true;
+	}
+	return ret;
 }
 
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
@@ -636,6 +642,8 @@ static int criu_checkpoint_queue(struct kfd_process_device *pdd,
 	q_data->ctx_save_restore_area_size =
 		q->properties.ctx_save_restore_area_size;
 
+	q_data->gws = !!q->gws;
+
 	ret = pqm_checkpoint_mqd(&pdd->process->pqm, q->properties.queue_id, mqd, ctl_stack);
 	if (ret) {
 		pr_err("Failed checkpoint queue_mqd (%d)\n", ret);
@@ -743,7 +751,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 					  struct kfd_criu_queue_priv_data *q_data)
 {
 	qp->is_interop = false;
-	qp->is_gws = q_data->is_gws;
 	qp->queue_percent = q_data->q_percent;
 	qp->priority = q_data->priority;
 	qp->queue_address = q_data->q_address;
@@ -826,12 +833,15 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 				NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
-		ret = -EINVAL;
+		goto exit;
 	}
 
+	if (q_data->gws)
+		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws, true);
+
 exit:
 	if (ret)
-		pr_err("Failed to create queue (%d)\n", ret);
+		pr_err("Failed to restore queue (%d)\n", ret);
 	else
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
-- 
2.30.2

