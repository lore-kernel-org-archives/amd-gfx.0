Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F77C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF9B61159
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CF9B61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA7C883A9;
	Wed, 29 Sep 2021 12:01:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7472F6EA56
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epQHG8nXe5jnv4pmWXMPlNCOTQOAY/6+uH5/idIzHA3FJqA+YjEMDbvOiicIv68qgOv3mYticNcg98/mWQF9UE3rN3SC0P7T8Wd4sL/IW0uVL34PW7LaOrdAeAXMVwQAT6aV0kJlnmVBx0l5yTV4wX87RxqnGmTD4AOVwr49DvLFs8BWiawnY5AleGlewLAK7sUdQ2JE2KnBM39MOrw+KRnUhsSvu/FNEKML70ncSVvVwJ1LffaUuEMEIZZSYRgBgrySvU9aCsC9gAOmIBx03hvPH8eLKVyVD39qUYWO1wxJ7w1lyRtQCw/K4LlXsdbSYUOH+nq+R3m6DKeZCLXopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GEW4tkKRT1aFQ8gTP0MwQdzS0ZIDELy9gQsPjAaJg6A=;
 b=S4g2Fy2uJkyclOzdAQBTJzsqOFafvVyqlnm7Na/U7gYbBPorrybGPwmT2uzUliDl38OAoHrpgVQa52b6Dqb3QfxXMN1IKhV3SSYUve+FMxjbRJiI1w66QM+QtPDxVpwW0IrOXbQ/OzbLWOWQ7Dtg/J3anhhL03LVkl7qzI0RSp+agil4eZcy2KUV/7VJ3Svx/6x4kjzP2zACP7AoQlbVuweiuA/cQbqrqYqeQN4shHelgFzmmwjX1e+0jS56kEMLxE56VrOfyTmh72ao8xwoLyJnjyTYjcu//1GQ01Flcrj2J7Sj4FH4+iRGhzQvWqFGg4xdHpE4cvr6NWb8vQUxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEW4tkKRT1aFQ8gTP0MwQdzS0ZIDELy9gQsPjAaJg6A=;
 b=jpIyM54d1/eQoekW/HnmlBvgcAxylQAc+npf1Twx6sIdSugrLaasQ/YijofS8lz1fznsBU9g2Ci7Rxfrv52bq/k/oh+7uUGhFk0y0zkCW3vfFNGG8Nqw0pnh6OS+btxrYRuKauT29aiSlukC1RV/u/q0dFKENSDG6GA8qy8AjW4=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by CY4PR12MB1253.namprd12.prod.outlook.com (2603:10b6:903:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 12:01:13 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::1f) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:13 +0000
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
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:12 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:06 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH v3 11/16] drm/amdkfd: CRIU restore queue doorbell id
Date: Wed, 29 Sep 2021 08:00:33 -0400
Message-ID: <20210929120038.6485-12-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b02a1715-a2ff-4b13-75b7-08d98340d548
X-MS-TrafficTypeDiagnostic: CY4PR12MB1253:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12533C50463AFDA37EC5AFA295A99@CY4PR12MB1253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krhWUZXV/DPDm2xwyVppaYc2Xzy29g3SZgof/poyQt4gwf5r0b75/DoaVfrk/bl8AM632oize9hqXFy7KH4IFPW9dUDtrI+0wFDyd9xZYy/dd71aanHhdOlIZxrzid3XZaE/TouhTD/FbPRpzgqIPoSCuK6UTFDchJcx0IahEzE0/xfw3s3bJOzh8BVuy8szHgPRVrX6hqCAr2MH1wvfsE8HUh57fMWA7LPI3XkEr4bVlQWKoUkpNGUYn63HnDUxlocRO/Mh6yNaKl8rYeEb/bN2gFqvAquP58KWOkg6rk2DmuBqfelSMfhpSjyDCPUmHsm8huWyFmBe1sD0Sk1l30MskGdu147jYxhISHuLGDfd4GScvlI2M93Or2U+wjmyUeQwpN1S36dYko5lDktIQXMNxy16o12RDUfS4W3OIpgl9PMz2a0SO9yoI7f742oQwftUmo597sXhG/u4r445t9BkTDYDfj443M6VTFrUU+95EQPUSLh+7Sxb29im03bIKdD47dVQjOqK2/S3szIN/t4TzPRRBDr3MABSC+fIObScpOR5LJ4W85+EtlyRAOJYM7ysOoNzwPvEZedh9XyabPvvJ3g1cn0bOHXXMyOlPys8XdatNpZdkACgPIoG6RZiquBQMnyDmwWejnzKJWeyKHjDZn48W77mXYlPWdTHFqcHxYOklgNvsxeH5aeg+GPWII3zoSjGGdYKmxAlDjnavN05MaqYl+7PG1343eulfGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(82310400003)(70586007)(70206006)(36860700001)(86362001)(7696005)(508600001)(2906002)(186003)(336012)(316002)(83380400001)(356005)(426003)(81166007)(47076005)(4326008)(26005)(2616005)(5660300002)(8676002)(36756003)(6916009)(16526019)(8936002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:12.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02a1715-a2ff-4b13-75b7-08d98340d548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
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
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 60 +++++++++++++------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c29dbc529548..30ee22562329 100644
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
 
@@ -161,6 +167,10 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 		/* On pre-SOC15 chips we need to use the queue ID to
 		 * preserve the user mode ABI.
 		 */
+
+		if (restore_id && *restore_id != q->properties.queue_id)
+			return -EINVAL;
+
 		q->doorbell_id = q->properties.queue_id;
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 			q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
@@ -169,25 +179,37 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
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
@@ -356,7 +378,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
 	}
 
-	retval = allocate_doorbell(qpd, q);
+	retval = allocate_doorbell(qpd, q, qd ? &qd->doorbell_id : NULL);
 	if (retval)
 		goto out_deallocate_hqd;
 
@@ -1333,7 +1355,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			goto out;
 	}
 
-	retval = allocate_doorbell(qpd, q);
+	retval = allocate_doorbell(qpd, q, qd ? &qd->doorbell_id : NULL);
 	if (retval)
 		goto out_deallocate_sdma_queue;
 
-- 
2.17.1

