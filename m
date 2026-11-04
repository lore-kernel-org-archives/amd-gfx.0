Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6D606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rpgk9opu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281D910E24C;
	Wed,  4 Nov 2026 15:52:30 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBFC10E3E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spm/Nwc/aDS6TFEXT3QLrTY+KK25V3Z4p5V7MWdM1q9PKXkAAafpfESn43mCcZZgCYSTZTNijzRsAJ13GB/FW+Rzd9zy5+LGntR47ge6ybuu8vmzBhotieffpKAK1egwGCZA5izIhL7aEHaAtjBlor7T5mHx/JTsgAYhpm0eEICJJqCZJxFvaq60Ga80hfbSqlRr0y3s0gZaEiQSfzji7SqUf/ZUlKLLfwDreSKT8V0LRSwC/uMw32/KEjXMgSOL5UGwnGzyYWDKRqZ4RhfImlsXtoQiAWpKgS0f+I/KQDGAPjqA/QiW/emfQ0FKGZlOt0f3RuDLz+mG3yufbxrMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0UWAI7d+EaQuazJrM8FBD4HSdu3/xOm1VT5JCAQP2E=;
 b=Q8pCxUPZWjSOijiz6Sppo/5ppjjixGMpVzQ2u6YQ4QkKatUmtKFY97FCpaFRnhFANlpGeTt5DmUL0ydWo7E2Jr2akD/sW5XjfNT3usgI/BQ2M7Y5h3Clii6ALPFrldILgyUFNPC2ungs/S8yjEwsClVuo3dVkdNmVfYUKxJLpNxv+ZC2IsPiXidEE5GrRzLtuZFf6tPUgmktUY6yG3Qo0sAtBzeOjV3XgKzEiXdFTakbxZ+5NWoE68SKhcxBzmO7ZiVt8JtJ4AltuAgiogc59xK9Ge9Is64whBWx8Uyxkbj4aL5/1UKJS9glI2y3E75j5lFJfrMFiuiyQu9zAhvEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0UWAI7d+EaQuazJrM8FBD4HSdu3/xOm1VT5JCAQP2E=;
 b=Rpgk9opulUacSZhuvBCmo1BOEfs+Lle9W7411X821rOqCmWz4Qx/It4xIfsYfeAye0ou66kSFR/7doMOKy/09KNRnusToETDz3cjPtQ5nZxnVP5RJWsTLG/HIZW5eR8y1C1ypXs5nrSwVvDLyMKaNrUMw5xMJA1TgVCq184NKLY=
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:52:18 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::a4) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 15:52:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 15:52:17 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 09:52:17 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v4 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Date: Wed, 4 Nov 2026 10:52:02 -0500
Message-ID: <20261104155203.3826257-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc74f70-6402-41e6-5faf-08df3a8b9aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: +YeJmVHe0FMkfrTOGPTR71SFHqtQN8O1i9tUST9NuxAnsZIHvW1hPEY/hWkArQqRjHkG7GzyDIZj5Fznm+vvcqAUrFuKDyKnP5Z29w3d3k0kO/ER2yU73JU2aWESs8Pzwd2C0tf5LpPh8u+vAibPa5VQMDUnbZ8ehEVSKjCkty9Adm7sxozyCwwA8NXyNeNS02acCNQWyz/msKx6JzaGiSaUQ0Y9gQoJOJDdGGetohzT5AZFp7loYe2BOMi5o4lyjOAIr8+qk9MfFDWhZw1J6Xa9aVqe0rtZSLuE7B7ew2yS/P6nH4MWGUj6/6i5pUoxGd/lkc47p11Cpv0xfr38BT8WW5BdWAsKgr2/PXxEVJBalGZtpVkEMkaaNpNyX26AwXJU5t4tbZ1lX5cWRnpbRc+Ajjbr3XN6+WCjEHKQH9Nc2woKyUlZzDcrvoOo6fdFbiMwVG2oN/cNn/2qgzaDfuu6SVzFgiYXLlgysp/yZoEtaMe8Lf401k8DOsm0Xg2OCbYU9qAW8oKmVePViliXIEVFkkEJShvAfQSqVxwzM31iNYqk//s3I5Ll1GI6QJyX1JYhjpfULkw8C8QWK1D0iVgxbEUjghsiQGqGjeB/SvZP4u/yMgjT6GjTOdvmDHrUz7X9te65b2mX5RyIwv9Of5NOEP7EPBYRdE6269Ete1Toi81NgK5V53Ln1dcpGqukKyp9EgnhPHpz/eNeNL+eAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IYLpgyziE57eP+yGyuJFaBjzvwKPdE0pr6R094n5GYv7aiBnV0hg6oB+/vV7WzmkM3zy2UghXbuDUFQCVUmmmHoi6pMLmZU8eUSQQINtafs4Rg/Frpd86xy1weDptQeHbC/RxfPOy9AsxIhSRg0WRpnbQ/V9sl/E2CvZbBRVpOEfQEZGoJ4wR449ZkzrRhqA/22ig3kXaLUncxk5YMti1Ok8V0mblBEKFTN8cpuumIE6psRnwGnw7w5T+ZcFico8rF3J/pi0LUC/YlPN/WftEEpxQNPSvp2JpZrUOg1WEiuv2WZ+4WD4w7R+0iaKr4+lZjhSc7S5hSo6bhDE6Kq7kT/0GqPn6BtpJHV5f0gZXadE/7rYAXd/wZ+U6PU4tTkRzmbwgRX5P1uNm3rU9nnd8iRxePyNY8JokRWuVyKofODBed9LMQqC+ivhwZ02LmO4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:52:17.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc74f70-6402-41e6-5faf-08df3a8b9aa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CRIU queue restore doesn't acquire the bo buffers in the same way
normal queue creation does. In normal queue creation, the driver
gets an additional reference on the queue's underlying buffers
that lasts until the queue is destroyed; this prevents the
queue's buffers from being removed from underneath it.

Acquire them, but don't get the svm bo. SVM isn't yet fully
restored by this point in CRIU and so there's no svm range to get.
This will be addressed in the next patch.

v2: Don't use checkpoint ctl_stack_size

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                 | 8 +++++++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6c710e4a5220c..d8233337b8d5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
-	err = kfd_queue_acquire_buffers(pdd, &q_properties);
+	err = kfd_queue_acquire_buffers(pdd, &q_properties, false);
 	if (err) {
 		pr_debug("failed to acquire user queue buffers\n");
 		goto err_acquire_queue_buf;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f0ce5fc4a138f..eb4d35a42e917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
 void kfd_queue_buffer_put(struct amdgpu_bo **bo);
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4c4a3a8587f46..6e19be9e89f57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1095,9 +1095,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
+	ret = kfd_queue_acquire_buffers(pdd, &qp, true);
+	if (ret) {
+		pr_err("Failed to acquire user queue buffers err:%d\n", ret);
+		goto exit;
+	}
+
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
+		kfd_queue_unref_bo_vas(pdd, &qp);
+		kfd_queue_release_buffers(pdd, &qp);
 		goto exit;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 6010a5d7a7eb9..18d24ddb455eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properties *properties)
 	kfd_queue_buffer_put(&properties->cwsr_bo);
 }
 
-int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
+int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
 {
 	struct kfd_topology_device *topo_dev;
 	u64 expected_queue_size;
@@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
+	/* CRIU svm buffers are restored at a later stage than queues. They'll be in
+	 * before the queue is actually used, so no risk here
+	 */
+	if (is_criu)
+		return 0;
+
 	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
 				       total_cwsr_size);
 	if (err)
-- 
2.34.1

