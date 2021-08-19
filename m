Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95791C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BD8610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62BD8610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62AD6E979;
	Thu, 19 Aug 2021 13:38:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171706E94F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUJDUPSf4feQEaiQuxB+YtbVyuh4TmW50Ye4CxkMUFn8R0jUfrecaVwxH3AQA/MYaI08grTUekvz82ZegG8vkk89TrRVfl78DBMLsjHCfYddPi3bDpYzOb2pNo93cubX5NJYma43DX6vvmbJbeO0qt5hb4h6RpsAhVt6ohdKQEE1p4TeBcJ0Th+gv+SmSvoKt5XcT+YCJAqOfnyGpd/wXT5JWs4ISwOYWD7sTLb+9NAKd61lA2dkgbKNRPGaPJdvBM7zKifOLRvgUdysNZ2lXhfkqvdYmwfbl8Xp5iISabQ5lgtTC2bp1ArU9nXc3IunxaWY2XcQcSIh+oe67hMKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LfSiAREVMcIa8Pl0QMUoPPLFcm/VCmSRTWMlkx8buk=;
 b=lxP2ypv4EK6ZuzvqD/TM5xMSnHOka7dNdtCoSf1ql4U6NPTVcP3Awv1P5bKcTeEN6Bff3ySz59sodpQZCfhp81lDNGSO5R5fbatfxAfCvo0N4D2gXD6fihorhVKfcTY6BJaKd9T6RJ1pG2c08B8JQ6K3zjCF/RRujsGWgGb6bKuBk82tf4YjacQp/oTOdVQSV70L/n6pRDV7TEcP4eKPx6eNriYam6kyy1y8x10RSuqv2d+5+AjKRm4yI/gNbhejmy/Dzu2LmYc89HxMX2DXs9EmmoxFolLo2AtlyUo4Oze6g2AMsOx56nM+ftwnnFRut4443Tk/2u1ADkAI/bBebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LfSiAREVMcIa8Pl0QMUoPPLFcm/VCmSRTWMlkx8buk=;
 b=drRLYNbZLwduPTeawYAwey7lyzyFukY7WK0x5uaw0zZmxvrsI0sOz5p+10gYUovd3DGULmQtR0Y8vVS/OxIdf26lSKbdvyi7Oj9fPIorUYDcv2zxyoRPE3ma3E5KvcxGPsQTiEV+Kw3IPl280fqo3b4KromR4T+ZkBLkjiEVCDI=
Received: from CO2PR04CA0170.namprd04.prod.outlook.com (2603:10b6:104:4::24)
 by MWHPR1201MB0142.namprd12.prod.outlook.com (2603:10b6:301:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Thu, 19 Aug
 2021 13:37:58 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::5b) by CO2PR04CA0170.outlook.office365.com
 (2603:10b6:104:4::24) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:57 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:53 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 12/18] drm/amdkfd: CRIU restore queue doorbell id
Date: Thu, 19 Aug 2021 09:37:07 -0400
Message-ID: <20210819133713.4168-13-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75384e8e-837d-4f7b-531a-08d963168e84
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0142:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0142C243646CE81E889A1C6D95C09@MWHPR1201MB0142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg32YwPZ9mg9c7Bw14YXctx7y7qvXM4tNDwWx5q0PNP83o7EXXskyuFqZRWlGCbezydPgYP6Bfroo+O8vN88KMl1FvzBlS7/SYrdryj8wSBffXN1XrMrRvwEiPEUMbN4sYuPrfgB6JHL85/OyphRAK3gLA3wwSdnpo5IGtu9CvV5Dva993YK9LUcP9SpRdCpoSA65FzLaxyXl/AXPB2wVsdoi7m64pHdumNQfS7CeelaQu6HSnUmSzXgi9uw82nEoO8G20dadX65dOv/2vqirkVgtm8pXG1+vm2ONxM1OZfjk/20AjXhij/jhbotMR5gTLF6HJ5sXNmGJLWyQI6SablmIXHHI14Tnwzq7v3u9KfbKKSRe7l0NYRl9FvrCa+RiDsW8px88gYYmkSAJSOKy32n2ED9O+kO8E4tFKJrheQBxPYHCwXYbc2mqNx0Nn5AH4uFKGwSG+6/E59W2OP7ug4Dm1TgMI6B+10xtmzdxLtL0BEb+Z0ewt4ariy/mOW0MU89fYUtmrCeMpc8xUCppYziJvh1FE/jLtQCuBUgpEoW0hpDluKrcKbHPG9DGxTnkKsVf8Vh+UPOJS5zBAdNOlk2FheN3heN3CVwQnEQrUd1U4dood5nS8GTazPb/UElFEo/gDm5CfjApY77ufVtBrAHEVVpboKGC9fzkE54dICxpwq6l5Lm09VjDObBKDkQoe9A0/SVDEjlwKb9tEexB4/fkK+u1IZ7bGLxQILsQK0erzh8usqt+OvuIqIF5YBBRetZVXkakpAK4KUWjpoYag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(70586007)(336012)(54906003)(47076005)(478600001)(26005)(16526019)(186003)(70206006)(5660300002)(83380400001)(4326008)(8676002)(426003)(316002)(86362001)(36756003)(8936002)(7696005)(2616005)(34020700004)(82310400003)(2906002)(6666004)(356005)(6916009)(36860700001)(1076003)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:57.9513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75384e8e-837d-4f7b-531a-08d963168e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0142
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

