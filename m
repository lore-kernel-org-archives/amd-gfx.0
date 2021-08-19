Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75568C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43635610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43635610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6B76E95B;
	Thu, 19 Aug 2021 13:38:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBB86E96E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N71+cVTR5fQRH3nu/nlbxskW2idzx91hZq7+09E9+2DxALBHq5NIIMdoJsXI6F1wacWq0FVdVWC8Ov1SLfp/kRtwT+w7CHzKg7cKdqfKeGUJC//BDewWKx7kMIKxUJzcHzywNoMOmcNQX3fOC5OQZ5x+POp5wp3us1laCdpSewxXcbew0vhzR1D1NQQqBOd7QW2u1t+o+SMM9aOe63sPRRa73prW+mJ+UDI6qczfrLpcb/tRrRKLbm2NMEiajJCslvmJWso3MWFk4d2IetyOMwU5OUF083TK0EJkGlnfhNpLqzESWv6o10Tay2Gmd0rCSIKbhmZwI7Xim+QdBnBFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY46StB+Wpz25Pmh+BCFofZkmCxwWvm8Z7ugekE1y5A=;
 b=X9f04wIvO1221dYR/ZQj6om7uA82iLoIKgjeApEiZ3SEyH7KwGL1Est7T/le/iohg/nZgCrZrBCd0PY0qvsEXG/TBGJ32uOXKi4HB4pZW4qowHWTgifpgPn2SAudly+9lDOx0GB42EwV7ApeE7/3cOvZHX9Qz+9YPqWK0PF6ZCPIivfr0PsChvRj2Xdh3guYwnEO/2zX0GVsIJECWhVfkGS0XeLNJZ4EOf2k0pGIj/vFHuLPHVUJdQBMXkTiWw7wcKqzBzUHWJ3br6L6TJ4b9NP/n+bOLktfMpJMep1VzmVACvZrcukzW3LztIzhGqBFW36CTcRBFKMHDpmyrfaavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY46StB+Wpz25Pmh+BCFofZkmCxwWvm8Z7ugekE1y5A=;
 b=5cQp0eRxsz5xnJ7Vz4Wd098tgdErcUYA5W++4wHjr6+90rHR7F4ghZJ+n804C/cbUXr0ffYg6Y26y6QvvKZqnuEKrn6SzPzF8BzB7qd/2RwZZRx/XYOAg7CfsXiSzcvwBkxEwaFS1lgHN6zXr/iAqForanu30dfzMamP/v0UcLw=
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:37:57 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::17) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_2,
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
 2021 08:37:52 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 11/18] drm/amdkfd: CRIU restore sdma id for queues
Date: Thu, 19 Aug 2021 09:37:06 -0400
Message-ID: <20210819133713.4168-12-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05e042a2-ef10-409c-48fd-08d963168e0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4154B24B521ECD0383B0DC2695C09@DM6PR12MB4154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYs9YNosGVOuIrPCOQpDSgJUTskZpKEvu2qrRuF9tO28qMrDCcBS2xOFsxyYBJ7VISsFZzC2sZeZn5lpg6rNmNmdbhEkgW/6oo/OtDij/dWFNvZHWdeCiCD66iE6yKoWX+RoJ6Wnb/Ib7AdkKrXsceq3cehYkR5iiFToDJvkcKCdc4bGnAhEb6Q/Sy54d9xIkw3Dtd2Eu4saPZTpywBBRVt6ekw3uKcNh+LRON6Wixq5q0nb/KX0vn7G7li7+OM833sghyGxB9c6qPGFueaH5JirXcWaPN0+fSklcJimiGqEYFJrVvHv3D28pzlPvDCpGyxGcElr/HGE1xY/EdYfKkAD3S4TrIkboGs+1sD9vCQSQh2lRnXlh32xJge4YMoeca18tpFSpqOTbN/aqs5caBfatx1xteQnfMN8y8q/blklipQvVlojc8a8R3avph1PX5aW9iCWVOE56AeUSkjb8HGdAykp6HORDFTtytAaGbM2ab0pukMf5Yqp0AL0n8NX6kbB/5WGUmU8vXojpByLkmqgg+xxSGuqcc3xYHYcjhX4KkrYecrprjInOw4PjpaNnLx1peo64nslOcwAGteYVcV253XcUsBnlQjVgjqSOWkFh4xT20egNWk5M+kxqNJ3DDj6H1kA+f4xK0ptrYvrZ56j3GSdZg4qlAxhmsTOF5bS/b/fUJCwp4dYun2mhu6iGrMSGli32lGWeYfqbUL2sww1Ze73I7E8EqQ8CiboKVbLkevOTGjVFS5iIYaoIKoagk6zPzKPQgQD/8lE2uN1hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(83380400001)(5660300002)(70586007)(186003)(16526019)(6916009)(2906002)(26005)(70206006)(47076005)(7696005)(1076003)(36860700001)(2616005)(336012)(478600001)(8936002)(34020700004)(86362001)(82740400003)(356005)(81166007)(426003)(82310400003)(6666004)(4326008)(8676002)(54906003)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:57.0606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e042a2-ef10-409c-48fd-08d963168e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
same sdma id value used during CRIU dump.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 48 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  4 +-
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 98c2046c7331..677f94e93218 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -58,7 +58,7 @@ static inline void deallocate_hqd(struct device_queue_manager *dqm,
 				struct queue *q);
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
-				struct queue *q);
+				struct queue *q, const uint32_t *restore_sdma_id);
 static void kfd_process_hw_exception(struct work_struct *work);
 
 static inline
@@ -296,7 +296,8 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 
 static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				struct queue *q,
-				struct qcm_process_device *qpd)
+				struct qcm_process_device *qpd,
+				const struct kfd_criu_queue_priv_data *qd)
 {
 	struct mqd_manager *mqd_mgr;
 	int retval;
@@ -336,7 +337,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 			q->pipe, q->queue);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		retval = allocate_sdma_queue(dqm, q);
+		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
 		if (retval)
 			goto deallocate_vmid;
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
@@ -1022,7 +1023,7 @@ static void pre_reset(struct device_queue_manager *dqm)
 }
 
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
-				struct queue *q)
+				struct queue *q, const uint32_t *restore_sdma_id)
 {
 	int bit;
 
@@ -1032,9 +1033,21 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			return -ENOMEM;
 		}
 
-		bit = __ffs64(dqm->sdma_bitmap);
-		dqm->sdma_bitmap &= ~(1ULL << bit);
-		q->sdma_id = bit;
+		if (restore_sdma_id) {
+			/* Re-use existing sdma_id */
+			if (!(dqm->sdma_bitmap & (1ULL << *restore_sdma_id))) {
+				pr_err("SDMA queue already in use\n");
+				return -EBUSY;
+			}
+			dqm->sdma_bitmap &= ~(1ULL << *restore_sdma_id);
+			q->sdma_id = *restore_sdma_id;
+		} else {
+			/* Find first available sdma_id */
+			bit = __ffs64(dqm->sdma_bitmap);
+			dqm->sdma_bitmap &= ~(1ULL << bit);
+			q->sdma_id = bit;
+		}
+
 		q->properties.sdma_engine_id = q->sdma_id %
 				get_num_sdma_engines(dqm);
 		q->properties.sdma_queue_id = q->sdma_id /
@@ -1044,9 +1057,19 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			pr_err("No more XGMI SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
-		bit = __ffs64(dqm->xgmi_sdma_bitmap);
-		dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
-		q->sdma_id = bit;
+		if (restore_sdma_id) {
+			/* Re-use existing sdma_id */
+			if (!(dqm->xgmi_sdma_bitmap & (1ULL << *restore_sdma_id))) {
+				pr_err("SDMA queue already in use\n");
+				return -EBUSY;
+			}
+			dqm->xgmi_sdma_bitmap &= ~(1ULL << *restore_sdma_id);
+			q->sdma_id = *restore_sdma_id;
+		} else {
+			bit = __ffs64(dqm->xgmi_sdma_bitmap);
+			dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
+			q->sdma_id = bit;
+		}
 		/* sdma_engine_id is sdma id including
 		 * both PCIe-optimized SDMAs and XGMI-
 		 * optimized SDMAs. The calculation below
@@ -1269,7 +1292,8 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 }
 
 static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
-			struct qcm_process_device *qpd)
+			struct qcm_process_device *qpd,
+			const struct kfd_criu_queue_priv_data *qd)
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
@@ -1284,7 +1308,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		dqm_lock(dqm);
-		retval = allocate_sdma_queue(dqm, q);
+		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
 		dqm_unlock(dqm);
 		if (retval)
 			goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 71e2fde56b2b..02cfa098ca1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -86,7 +86,8 @@ struct device_process_node {
 struct device_queue_manager_ops {
 	int	(*create_queue)(struct device_queue_manager *dqm,
 				struct queue *q,
-				struct qcm_process_device *qpd);
+				struct qcm_process_device *qpd,
+				const struct kfd_criu_queue_priv_data *qd);
 
 	int	(*destroy_queue)(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index e6abab16b8de..f30e128ee9c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -272,7 +272,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
 		print_queue(q);
 		break;
 
@@ -292,7 +292,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
-- 
2.17.1

