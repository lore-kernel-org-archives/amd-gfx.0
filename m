Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBEC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 05:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9F060F92
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 05:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D9F060F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72D26E9F7;
	Fri, 20 Aug 2021 05:33:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4A16E9F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 05:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddf7K1Ci7iRniHPXa10MMdVKfQMBF4uKAJ9DOiquHqzjaE5YHVCxhzLWiVxBGQwhslVwVKEVzkifng0LYQ3ZT04AsaUFwjVNhvthI5oiOo0Jul0nPpUXuu1QLpVVdPfa6QVMuSZrNkFud+gkfi+WaJrwim7MKhuuvDGNSCzzKoyznr0pmev9ibYCdCfeYmPFhev1VmEwI/sB3om2+CGM73uC9XA+fg2YIV95aNzLmVWs7WrbM+6wy9mKkCLPCFtQxIfbq7PDULrj3nw1eH8SzF4c74XQOPuUfRax+a7M09s4N80PXLSZcq5iRwwto0Who2YT5qup14up788y+jAfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8QVDhqT+SKgkB6lAID49YSSqCMKey6jgxi5g5RLLIs=;
 b=bxafd7ZbTSjxCgaHUYR3FvFxbSwJfF7Wc0JwLGlaKjA+lk6bX/CV3jFJiIiOcP/Y3hw3JE6mblsu4RDIbLF1nKcdEz0HgjR7yrWZvxCSfFvz5vlY8/yZowZSrgC3ZC2RrYqdNkmuWpDoARUvwZfN1TgZjAdNtNKkk0+bM/V78FuvuB597ZyEGvXM7k8jea8xW9ZFmIgarzwSkQUBxXvh8TNJd9tauTc+6YkZF33k18P50ouVTTU2qhenXqGcPDo9LSLwyO95qxZhMXldB1FbvM9bxf8LvJvUjd328Fi7XSTxW6J6r63QdanqETzagehlcG3wssHVyisClW220X1/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8QVDhqT+SKgkB6lAID49YSSqCMKey6jgxi5g5RLLIs=;
 b=Ca1XFhXgrrjrg+xdLikqnFf/2WFI6v5qDJDZZ80nH+Wyqgg5Nmwn7BT5qAWFwVojoDsXtxI4iOgoKwcB5co9b0ssqq1//JCUxkteEHllDhYjjnGoIEKFeaUVaHwp2E/ApbTXVChjCUpq++IeDz3O700LkF59FzLhV2C2nsqHVaI=
Received: from MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 05:33:03 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::d) by MWHPR13CA0028.outlook.office365.com
 (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Fri, 20 Aug 2021 05:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 05:33:02 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 00:33:02 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Joseph Greathouse <Joseph.Greathouse@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
Date: Fri, 20 Aug 2021 00:32:43 -0500
Message-ID: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 232597d0-3b27-411d-43c6-08d9639bface
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768765836C5A4436CE901DEF9C19@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlC93zUmUmn9LKg0x83U0iSTt2VQJdbtGkzMK/cjEucpJzThQwUYxsIVrvVHldUvj/Jno/fBrPJvqgs6vF6vnDHlRCKMu/8jhAh7ZDblWISffYheria/oefJnBptkTDjm2NlGiwi9kAVOpib/219zT3kQxtXZj/zN4OANVtCxjlqT31e9pGJooem/weFhGShyCh0RoJZWr53Sj8+MnSYZwQYBeIqajZblsg/j7OG6K+h2N+q5zEffxHZTUQgmJDJaT7sBaNEuS9Rae+1GhiVsRHaR66As/nxFXFFQT6fFdiTfLGRKe0FRVZi3kTr5YYKAMV5OZ2XdBDzgw/v0RY2rYLU4NeNKcJmkhRk4zqkjJD10r5RILzHIMqcEH3dhsZX+X8TcZtI3Uf4yE6vF/yuKPAmsmSfCGHjr4L5GYD5cZCfZCvsOleFoE47lNl2cT0Ri75wxjXlq4hTX/2SFyrPZacLofx88+FSSqv0Rr2TgYMPDS/L2pim/vym1iMyY2giBbr5dDPB0xjHJ1Lls9Sd9fRLEP1IDZ7HWc5sj5dHRVY0u0UEu2+OLzDjkE3LUGB9Zb8Ypc1hUXrW5XoT+O/OLSYXb6sCij5ZC0w+4FLKVTFuqSEAW7kTHTJTdxPnIa4npcXYToSLu/5+0+7+g1CteH5ozPEAVOaeUsmw5n2/MKUaORX0+8INV3uyIjeR4541rY4c9ECk+2p6W8tNEgt1PMlcflUvkjndY6v52U0brkScUsx4IKlBP32XBds2WDCCWADy5dZHzlmlxPGpIoSw2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(6916009)(8936002)(7696005)(81166007)(6666004)(1076003)(83380400001)(5660300002)(30864003)(8676002)(82740400003)(36860700001)(2906002)(356005)(47076005)(70206006)(70586007)(4326008)(2616005)(86362001)(478600001)(16526019)(336012)(34020700004)(426003)(82310400003)(316002)(186003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 05:33:02.6879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232597d0-3b27-411d-43c6-08d9639bface
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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

Give every process at most one queue from each SDMA engine.
Previously, we allocated all SDMA engines and queues on a first-
come-first-serve basis. This meant that it was possible for two
processes racing on their allocation requests to each end up with
two queues on the same SDMA engine. That could serialize the
performance of commands to different queues.

This new mechanism allows each process at most a single queue
on each SDMA engine. Processes will check for queue availability on
SDMA engine 0, then 1, then 2, etc. and only allocate on that
engine if there is an available queue slot. If there are no
queue slots available (or if this process has already allocated
a queue on this engine), it moves on and tries the next engine.

The Aldebaran chip has a small quirk that SDMA0 should only be
used by the very first allocation from each process. It is OK to
use any other SDMA engine at any time, but after the first SDMA
allocation request from a process, the resulting engine must
be from SDMA1 or above. This patch handles this case as well.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
 3 files changed, 107 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f8fce9d05f50..86bdb765f350 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 static int map_queues_cpsch(struct device_queue_manager *dqm);
 
 static void deallocate_sdma_queue(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd,
 				struct queue *q);
 
 static inline void deallocate_hqd(struct device_queue_manager *dqm,
 				struct queue *q);
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd,
 				struct queue *q);
 static void kfd_process_hw_exception(struct work_struct *work);
 
@@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 			q->pipe, q->queue);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		retval = allocate_sdma_queue(dqm, q);
+		retval = allocate_sdma_queue(dqm, qpd, q);
 		if (retval)
 			goto deallocate_vmid;
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
@@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		deallocate_hqd(dqm, q);
 	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		deallocate_sdma_queue(dqm, q);
+		deallocate_sdma_queue(dqm, qpd, q);
 deallocate_vmid:
 	if (list_empty(&qpd->queues_list))
 		deallocate_vmid(dqm, qpd, q);
@@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		deallocate_hqd(dqm, q);
 	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		deallocate_sdma_queue(dqm, q);
+		deallocate_sdma_queue(dqm, qpd, q);
 	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		deallocate_sdma_queue(dqm, q);
+		deallocate_sdma_queue(dqm, qpd, q);
 	else {
 		pr_debug("q->properties.type %d is invalid\n",
 				q->properties.type);
@@ -1039,42 +1041,93 @@ static void pre_reset(struct device_queue_manager *dqm)
 	dqm_unlock(dqm);
 }
 
+static uint64_t sdma_engine_mask(int engine, int num_engines)
+{
+	uint64_t mask = 0;
+
+	engine %= num_engines;
+	while (engine < (sizeof(uint64_t)*8)) {
+		mask |= 1ULL << engine;
+		engine += num_engines;
+	}
+	return mask;
+}
+
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd,
 				struct queue *q)
 {
-	int bit;
+	uint64_t available_queue_bitmap;
+	unsigned int bit, engine, num_engines;
+	bool found_sdma = false;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		if (dqm->sdma_bitmap == 0) {
+		num_engines = get_num_sdma_engines(dqm);
+		for_each_set_bit(engine, &(qpd->sdma_engine_bitmap), num_engines) {
+			/* Do not reuse SDMA0 for any subsequent SDMA queue
+			 * requests on Aldebaran. If SDMA0's queues are all
+			 * full, then this process should never use SDMA0
+			 * for any further requests
+			 */
+			if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
+					engine == 0)
+				qpd->sdma_engine_bitmap &= ~(1ULL << engine);
+
+			available_queue_bitmap = sdma_engine_mask(engine, num_engines);
+			available_queue_bitmap &= dqm->sdma_bitmap;
+
+			if (!available_queue_bitmap)
+				continue;
+			/* Take the selected engine off the list so we will not
+			 * allocate two queues onto the same engine
+			 */
+			qpd->sdma_engine_bitmap &= ~(1ULL << engine);
+			found_sdma = true;
+
+			bit = __ffs64(available_queue_bitmap);
+			dqm->sdma_bitmap &= ~(1ULL << bit);
+			q->sdma_id = bit;
+			q->properties.sdma_engine_id = q->sdma_id % num_engines;
+			q->properties.sdma_queue_id = q->sdma_id / num_engines;
+			break;
+		}
+		if (!found_sdma) {
 			pr_err("No more SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
-
-		bit = __ffs64(dqm->sdma_bitmap);
-		dqm->sdma_bitmap &= ~(1ULL << bit);
-		q->sdma_id = bit;
-		q->properties.sdma_engine_id = q->sdma_id %
-				get_num_sdma_engines(dqm);
-		q->properties.sdma_queue_id = q->sdma_id /
-				get_num_sdma_engines(dqm);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		if (dqm->xgmi_sdma_bitmap == 0) {
+		num_engines = get_num_xgmi_sdma_engines(dqm);
+		for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap), num_engines) {
+			available_queue_bitmap = sdma_engine_mask(engine, num_engines);
+			available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
+
+			if (!available_queue_bitmap)
+				continue;
+			/* Take the selected engine off the list so we will not
+			 * allocate two queues onto the same engine
+			 */
+			qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
+			found_sdma = true;
+
+			bit = __ffs64(available_queue_bitmap);
+			dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
+			q->sdma_id = bit;
+			/* sdma_engine_id is sdma id including
+			 * both PCIe-optimized SDMAs and XGMI-
+			 * optimized SDMAs. The calculation below
+			 * assumes the first N engines are always
+			 * PCIe-optimized ones
+			 */
+			q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
+				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
+			q->properties.sdma_queue_id = q->sdma_id /
+				get_num_xgmi_sdma_engines(dqm);
+			break;
+		}
+		if (!found_sdma) {
 			pr_err("No more XGMI SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
-		bit = __ffs64(dqm->xgmi_sdma_bitmap);
-		dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
-		q->sdma_id = bit;
-		/* sdma_engine_id is sdma id including
-		 * both PCIe-optimized SDMAs and XGMI-
-		 * optimized SDMAs. The calculation below
-		 * assumes the first N engines are always
-		 * PCIe-optimized ones
-		 */
-		q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
-				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
-		q->properties.sdma_queue_id = q->sdma_id /
-				get_num_xgmi_sdma_engines(dqm);
 	}
 
 	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
@@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 }
 
 static void deallocate_sdma_queue(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd,
 				struct queue *q)
 {
+	uint32_t engine = q->properties.sdma_engine_id;
+
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
 		if (q->sdma_id >= get_num_sdma_queues(dqm))
 			return;
 		dqm->sdma_bitmap |= (1ULL << q->sdma_id);
+		/* Don't give SDMA0 back to be reallocated on Aldebaran.
+		 * It is only OK to use this engine from the first allocation
+		 * within a process.
+		 */
+		if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
+					engine == 0))
+			qpd->sdma_engine_bitmap |= (1ULL << engine);
+
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
 			return;
 		dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
+		/* engine ID in the queue properties is the global engine ID.
+		 * The XGMI engine bitmap ignores the PCIe-optimized engines.
+		 */
+		engine -= get_num_sdma_engines(dqm);
+		qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
 	}
 }
 
@@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		dqm_lock(dqm);
-		retval = allocate_sdma_queue(dqm, q);
+		retval = allocate_sdma_queue(dqm, qpd, q);
 		dqm_unlock(dqm);
 		if (retval)
 			goto out;
@@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		dqm_lock(dqm);
-		deallocate_sdma_queue(dqm, q);
+		deallocate_sdma_queue(dqm, qpd, q);
 		dqm_unlock(dqm);
 	}
 out:
@@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		deallocate_sdma_queue(dqm, q);
+		deallocate_sdma_queue(dqm, qpd, q);
 		pdd->sdma_past_activity_counter += sdma_val;
 	}
 
@@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Clear all user mode queues */
 	list_for_each_entry(q, &qpd->queues_list, list) {
 		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-			deallocate_sdma_queue(dqm, q);
+			deallocate_sdma_queue(dqm, qpd, q);
 		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-			deallocate_sdma_queue(dqm, q);
+			deallocate_sdma_queue(dqm, qpd, q);
 
 		if (q->properties.is_active) {
 			decrement_queue_count(dqm, q->properties.type);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ab83b0de6b22..c38eebc9db4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -576,6 +576,8 @@ struct qcm_process_device {
 	struct list_head priv_queue_list;
 
 	unsigned int queue_count;
+	unsigned long sdma_engine_bitmap;
+	unsigned long xgmi_sdma_engine_bitmap;
 	unsigned int vmid;
 	bool is_debug;
 	unsigned int evicted; /* eviction counter, 0=active */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 21ec8a18cad2..13c85624bf7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1422,6 +1422,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 							struct kfd_process *p)
 {
 	struct kfd_process_device *pdd = NULL;
+	const struct kfd_device_info *dev_info = dev->dqm->dev->device_info;
 
 	if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
 		return NULL;
@@ -1446,6 +1447,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->qpd.pqm = &p->pqm;
 	pdd->qpd.evicted = 0;
 	pdd->qpd.mapped_gws_queue = false;
+	pdd->qpd.sdma_engine_bitmap = BIT_ULL(dev_info->num_sdma_engines) - 1;
+	pdd->qpd.xgmi_sdma_engine_bitmap = BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
 	pdd->process = p;
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
-- 
2.20.1

