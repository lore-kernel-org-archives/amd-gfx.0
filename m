Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF8C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EE36113A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74EE36113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1617D6E0C6;
	Tue, 24 Aug 2021 19:23:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (unknown
 [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51F26E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPTVhP24wvgrGFmYmf/7uKxAvy9glB1icaAnaOZPebjjeOot83Mgrx29WGJ6m51LOZKcO3Foncz5Y5dEVCofdvk3coA1sA6loWvjaLgY5YKgN86jD8OclRK+NUQ0haVxGDvwOwp5YdRkGDHxgR+UBGF6c6POdlE8Sk2J2+858STlb3tQw9MGv9i5oJPTRg9CCmWII7gm8m52ZW9vXcU0RIhI31aCrVbn4ynedXk8ft9jfkHpjylqWFhJbEmbxQOhgm+ro8da//fByzKpHOtaSdjih0IkcSj5XqbBFA4jxgXbj8TipiVK1TVUT9Cd/Nmu9RIIgJu8oWOQKJt6Mox8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Hu2UGI6/m/Uq4EOcNBz1KnaEsDpOoCfOBzA1bjMT0=;
 b=PlUN8bzAqb1ZAzmGpVF9Kb+rlcrc9Nkh3y7sUrD9U/M4ecitGXk7v1ySzA/Z/dhI3ng6uENOR7Dsufb4yUbRrF8oALjxAckJtYXa5WPDWRpWlUqK1qjsAKwUO7e9FLVabP6x12Mz6GMAyZFmNlruWIEW32aWz8eRaJ3BZGgGMZ8tEXRkJ+cZVnaUErCpoj5nzw5cAmWwMhRKCvPu/uv4QjCIL6f752aHfbb83v9EKoWkOaewAql+p7kgWlEn8KrshBLBAc1o3e7S5LWpS3z/7wAe3KYnpyiSA3mT7T3MRGkJXhZyLjXGQD0C1pPy4J4nNDq1eYOcchdoOTfwynZDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Hu2UGI6/m/Uq4EOcNBz1KnaEsDpOoCfOBzA1bjMT0=;
 b=p3h2kQ0SpyNIa4b4PTS+zldmRELT1hxfplfzfiebaf4GAjpASCLzpAsV21Ztp7HehVDL6aHtQLRfjfGdY/tOolNZzuryc6oL1JO6xXAcYlNAsAVuH6bjfywB0uXYUNLw5ji/mM/BXZ/bKn3S/SVEX1n2PFs5uTN8VJtQOsj79To=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17; Tue, 24 Aug 2021 19:07:39 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::3d) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend
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
 2021 14:07:35 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 11/18] drm/amdkfd: CRIU restore sdma id for queues
Date: Tue, 24 Aug 2021 15:06:32 -0400
Message-ID: <20210824190639.6288-12-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e1a19a0-c61e-4ea8-8189-08d967327146
X-MS-TrafficTypeDiagnostic: DM6PR12MB3529:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3529B662168A31EFC69EE98E95C59@DM6PR12MB3529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbukXDs7RY6VWGTkbxSs3+v+4LhaxcJwjK+YJjz5WHIf4Oi84YNUYftrUDgac6BK+mBd0kTBhQhQ0xkZGFh+A/LaDTbVRXQsgnp21Hd9aZiV0ObclEz88+uSv6RRppIDX4qFw+9NC7XqCQd7B1iS34k/Lln/xsO3ykbUMqbSXW4rQzryRDhz5KbT0/xCqqL6BemMEXeA7g4EZKEIgvya9ngriZ423CgwN9IxAyxQu/4epIBbKkX9yiY8OqpmW8PushaCnzz3Vh3elkzsvJqDdAjpqTQyDAzjHGrQS34vwqxL0+K0fTRqBG072MzaLBKJgptDZrRjTKdTCkyd9Ya8EaAeCnfDfHW8PGuaLBDwuwA/eaXtaO+80sl1eeuxNejpja0vy2+O4Qb3sB5qvleHhOYf1dn3L8w5biX8FLIDxY1f28nCISPcZgsqwiwcHTD+D8mRudNESwxzy6Av+NFP7/FE2rqQcogaOvOQ0J2ZuaZglvKXzNw9ct2wPIn7gveZE4tp+dSA74YBl7UGApfXG8JjwDFXArfLTdKBDugH+wdPIjhtrqWG6rFFiBoutvSWETBlYKg6m2k+PC/OhwDN9CkjMfsYian4oSbDisvnDR0ESBB59pcVAvV10PuMeBqqyywOlJAUqYbb4pZBPn9NtokhEXjYCdf7RjoFRYPS0zQx3SoUQDOeR9lfIyAwUf0WLNMI675wIna/LJbbVDyImAwVJPOYZtl5LeVS64Ngwjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(36840700001)(47076005)(82310400003)(36860700001)(82740400003)(36756003)(83380400001)(81166007)(86362001)(478600001)(5660300002)(1076003)(356005)(8936002)(6916009)(70206006)(8676002)(16526019)(186003)(26005)(2616005)(7696005)(2906002)(54906003)(70586007)(316002)(6666004)(336012)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:39.5048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a19a0-c61e-4ea8-8189-08d967327146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
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
index 0609bbe7f818..8d85e5ccf0df 100644
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

