Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C929DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9862A6147F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9862A6147F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B703A6EA50;
	Wed, 29 Sep 2021 12:01:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B698A6EA4C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWkgn6kzIfSNJSczLqqP3ELz+lRUencMgOhXDpZ4STuFCdI1qYH2FJ+nMRg2MbcGw3OI9N/sf4JWkA0Ux/CCrFcbV1gwpG7sNJe14hTtY8+R/9qwOg+9e6MsIhXxGkoaQbAtYLqWEXMWGYvu/fXFCR5Kok7Io/1XpwWnQ0kSnhuRssizl9sqTJypfOag/NSwVtHGJgzYZiP4Dfkm2WYZCBXeCExC9gbGDOWlrAfRN7sABmygbx4CYRExSq6f+Pq/S6cplF4yOJh0XC9ibPc9mURga6OnWtLEdu0woX5iCPt+i4jWFJQVGlGgjfvAIfwGmZnHxOzntVjZLzc2hjeHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cF8Jlvt0DUog9ddx7FoquzLO4U+RMCebwGUDy+GsgHw=;
 b=HjNptKj0VC7FC1ibMZKg3HvDioOA2r/4idThEX0jwchUOFrRW9gLiYnz/lGDGE8R6PrYf/akgaybxZSfBykbFou0GilVzR0WV9cdeYfjJm17Aef9Ih7WvA6KDYDMJAJTrbKcUdrTpe7xlD/fJJIDEjH6eWZW3ZPcM4hALQu0Kez4JpaHmggKvFzZxMl+q8Zyxt+fw0yqMtnPMays0JtKD9JYxyYkNhcdOKRd7J5HzqIFULfsit4f5giTd7iWAhc6Bfl0UQEr8qaret43ccHrkdmE+8KvsDOtzqVjzSFpCbBnrWtbjBZcEXsrByshxGucuOumaDf20kzq+RMxE2J1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF8Jlvt0DUog9ddx7FoquzLO4U+RMCebwGUDy+GsgHw=;
 b=cS7kwHUhQK6fmVmzZtqfW8OXansdIdO7a1REI/BS1JQQM/TYd1g3naQQVaLaouuAf0yGi1qe7jrWqdY+/sk/OHw7XHZvZ7Amb990Ho9OZ3Lz+kqMI5KvQQ4ufPWfl/NMxmQNy8imHfswAlCcLf+GCw7Rl1eFDtleTJ4jyYlIX8w=
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by SN6PR12MB2624.namprd12.prod.outlook.com (2603:10b6:805:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 12:01:11 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::35) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:10 +0000
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
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:10 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:05 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH v3 08/16] drm/amdkfd: CRIU add queues support
Date: Wed, 29 Sep 2021 08:00:30 -0400
Message-ID: <20210929120038.6485-9-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97cf695b-5baf-40bc-fff5-08d98340d3d2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2624:
X-Microsoft-Antispam-PRVS: <SN6PR12MB262437C01BBF4B89657F1E4995A99@SN6PR12MB2624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQz4GgaQpclaQOd9LOxHqqmo8yh9Y0k/+NHILIGGYCGqvSRLHcyvGw97kf2anaZZ+ZEKUiUDlKVKZUJiJ5DVOUgDWRQF+obG8yxD1MIPQS0i4+qrtPf67VcjLhWqrk+ySyurhOxk74oWFRPc59EU0ONaRpsCXLglicn32OJ9ft+45F9BrLX8tY+jAU4lE0l4174mb26tsdYMdQ2JZLsx/zhX29/LdIHsRLhSURmc+63sXl9jB+C+bJRsUz3Ji4dlBZZ6N3HNA3wxPBWpTyiX9g7X10hj3GRF9SjpT7MNObsJ+0YlkCuvL3qbaG+8KKQqtCWitPhqN3gDh16epiVKjeTh3hlRo13Zv4d49BZYnke6l2H7cryqYyaVzqDzHzPQvBZ9DcpZV62tdqIVgZWmzu29QVWGyn7hjkNvoVH+KOCMe9VJ44LXX5aqT6vOclVv/PDC5ieCTzxzacVZoGyuGREvYGPaIp1B1DDft+w+bXqhoNpjuW15peCMtj+sJwLZJ2iI+I6j/QVeNOL7gadsmjMEb6cFbH6ap0szYczfXXVBz0jyyXxvTlw8pRlyxQQwjUEbUcw1+7hOHkf1BWqQgNlZHJ4TwKWhpFL8ES6YKuq6uP+eLq6PS5frbIvbhBFYGnwQLbRjtYlr+oPKQaBmFdEAxIJY898EOdX+3RyIWK1ex23ci7rRE66aJHDVHRLR+aIQgV3yXZU86BE6nulAFqfJWTyps/GMeq0L0QUddT0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(186003)(36756003)(4326008)(5660300002)(6666004)(16526019)(82310400003)(7696005)(336012)(81166007)(30864003)(426003)(86362001)(8676002)(1076003)(26005)(6916009)(8936002)(356005)(70586007)(2906002)(316002)(70206006)(36860700001)(83380400001)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:10.3084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf695b-5baf-40bc-fff5-08d98340d3d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
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

Add support to existing CRIU ioctl's to save number of queues and queue
properties for each queue during checkpoint and re-create queues on
restore.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  25 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 363 ++++++++++++++++++
 3 files changed, 402 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 791cb1555413..542a77b7f449 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2043,6 +2043,8 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 		ret = criu_dump_bos(p, args);
 		break;
 	case KFD_CRIU_OBJECT_TYPE_QUEUE:
+		ret = kfd_criu_dump_queues(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
 	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
@@ -2350,6 +2352,8 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 		ret = criu_restore_bos(p, args);
 		break;
 	case KFD_CRIU_OBJECT_TYPE_QUEUE:
+		ret = kfd_criu_restore_queues(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
 	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
@@ -2425,6 +2429,7 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
 				struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_criu_process_info_args *args = data;
+	uint32_t queues_extra_data_size;
 	int ret = 0;
 
 	mutex_lock(&p->mutex);
@@ -2443,7 +2448,16 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
 	args->total_bos = get_process_num_bos(p);
 	args->bos_priv_data_size = args->total_bos * sizeof(struct kfd_criu_bo_priv_data);
 
-	dev_dbg(kfd_device, "Num of bos:%llu\n", args->total_bos);
+	ret = kfd_process_get_queue_info(p, &args->total_queues, &queues_extra_data_size);
+	if (ret)
+		goto err_unlock;
+
+	args->queues_priv_data_size = queues_extra_data_size +
+				(args->total_queues * sizeof(struct kfd_criu_queue_priv_data));
+
+	dev_dbg(kfd_device, "Num of bos:%llu queues:%u\n",
+				args->total_bos,
+				args->total_queues);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e0601bfbcbf2..c5329d843ffb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1055,13 +1055,36 @@ struct kfd_criu_svm_range_priv_data {
 };
 
 struct kfd_criu_queue_priv_data {
-	uint64_t reserved;
+	uint64_t q_address;
+	uint64_t q_size;
+	uint64_t read_ptr_addr;
+	uint64_t write_ptr_addr;
+	uint64_t doorbell_off;
+	uint64_t eop_ring_buffer_address;
+	uint64_t ctx_save_restore_area_address;
+	uint32_t gpu_id;
+	uint32_t type;
+	uint32_t format;
+	uint32_t q_id;
+	uint32_t priority;
+	uint32_t q_percent;
+	uint32_t doorbell_id;
+	uint32_t is_gws;
+	uint32_t sdma_id;
+	uint32_t eop_ring_buffer_size;
+	uint32_t ctx_save_restore_area_size;
+	uint32_t ctl_stack_size;
+	uint32_t cu_mask_size;
+	uint32_t mqd_size;
 };
 
 struct kfd_criu_event_priv_data {
 	uint64_t reserved;
 };
 
+int kfd_process_get_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t *q_data_sizes);
+int kfd_criu_dump_queues(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args);
+int kfd_criu_restore_queues(struct kfd_process *p, struct kfd_ioctl_criu_restorer_args *args);
 /* CRIU - End */
 
 /* Queue Context Management */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 243dd1efcdbf..f1ec644acdf7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -508,6 +508,369 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 						       save_area_used_size);
 }
 
+
+static void get_queue_data_sizes(struct kfd_process_device *pdd,
+				struct queue *q,
+				uint32_t *cu_mask_size)
+{
+	*cu_mask_size = sizeof(uint32_t) * (q->properties.cu_mask_count / 32);
+}
+
+int kfd_process_get_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t *q_data_sizes)
+{
+	u32 data_sizes = 0;
+	u32 q_index = 0;
+	struct queue *q;
+	int i;
+
+	/* Run over all PDDs of the process */
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		list_for_each_entry(q, &pdd->qpd.queues_list, list) {
+			if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
+				q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
+				u32 cu_mask_size;
+
+				get_queue_data_sizes(pdd, q, &cu_mask_size);
+
+				data_sizes += cu_mask_size;
+				q_index++;
+			} else {
+				pr_err("Unsupported queue type (%d)\n", q->properties.type);
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+	*num_queues = q_index;
+	*q_data_sizes = data_sizes;
+
+	return 0;
+}
+
+static void criu_dump_queue(struct kfd_process_device *pdd,
+			   struct queue *q,
+			   struct kfd_criu_queue_bucket *q_bucket,
+			   void *private_data)
+{
+	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
+	uint8_t *cu_mask;
+
+	cu_mask = (void *)(q_data + 1);
+
+	q_bucket->gpu_id = pdd->dev->id;
+	q_data->type = q->properties.type;
+	q_data->format = q->properties.format;
+	q_data->q_id =  q->properties.queue_id;
+	q_data->q_address = q->properties.queue_address;
+	q_data->q_size = q->properties.queue_size;
+	q_data->priority = q->properties.priority;
+	q_data->q_percent = q->properties.queue_percent;
+	q_data->read_ptr_addr = (uint64_t)q->properties.read_ptr;
+	q_data->write_ptr_addr = (uint64_t)q->properties.write_ptr;
+	q_data->doorbell_id = q->doorbell_id;
+
+	q_data->sdma_id = q->sdma_id;
+
+	q_data->eop_ring_buffer_address =
+		q->properties.eop_ring_buffer_address;
+
+	q_data->eop_ring_buffer_size = q->properties.eop_ring_buffer_size;
+
+	q_data->ctx_save_restore_area_address =
+		q->properties.ctx_save_restore_area_address;
+
+	q_data->ctx_save_restore_area_size =
+		q->properties.ctx_save_restore_area_size;
+
+	if (q_data->cu_mask_size)
+		memcpy(cu_mask, q->properties.cu_mask, q_data->cu_mask_size);
+
+	pr_debug("Dumping Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
+}
+
+static int criu_dump_queues_device(struct kfd_process_device *pdd,
+				unsigned int *q_index,
+				unsigned int max_num_queues,
+				struct kfd_criu_queue_bucket *q_buckets,
+				uint8_t *user_priv_data,
+				uint64_t *queues_priv_data_offset)
+{
+	struct queue *q;
+	uint8_t *q_private_data = NULL; /* Local buffer to store individual queue private data */
+	unsigned int q_private_data_size = 0;
+	int ret = 0;
+
+	list_for_each_entry(q, &pdd->qpd.queues_list, list) {
+		struct kfd_criu_queue_bucket q_bucket;
+		struct kfd_criu_queue_priv_data *q_data;
+		uint64_t q_data_size;
+		uint32_t cu_mask_size;
+
+		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
+			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
+			q->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI) {
+
+			pr_err("Unsupported queue type (%d)\n", q->properties.type);
+			return -EOPNOTSUPP;
+		}
+
+		memset(&q_bucket, 0, sizeof(q_bucket));
+
+		get_queue_data_sizes(pdd, q, &cu_mask_size);
+
+		q_data_size = sizeof(*q_data) + cu_mask_size;
+
+		/* Increase local buffer space if needed */
+		if (q_private_data_size < q_data_size) {
+			kfree(q_private_data);
+
+			q_private_data = kzalloc(q_data_size, GFP_KERNEL);
+			if (!q_private_data) {
+				ret = -ENOMEM;
+				break;
+			}
+			q_private_data_size = q_data_size;
+		}
+
+		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
+
+		q_data->cu_mask_size = cu_mask_size;
+
+		criu_dump_queue(pdd, q, &q_bucket, q_data);
+
+		q_bucket.priv_data_offset = *queues_priv_data_offset;
+		q_bucket.priv_data_size = q_data_size;
+
+		ret = copy_to_user((void __user *) (user_priv_data + q_bucket.priv_data_offset),
+				q_private_data, q_bucket.priv_data_size);
+		if (ret) {
+			ret = -EFAULT;
+			break;
+		}
+		*queues_priv_data_offset += q_data_size;
+
+		ret = copy_to_user((void __user *)&q_buckets[*q_index],
+					&q_bucket, sizeof(q_bucket));
+		if (ret) {
+			pr_err("Failed to copy queue information to user\n");
+			ret = -EFAULT;
+			break;
+		}
+		*q_index = *q_index + 1;
+	}
+
+	kfree(q_private_data);
+
+	return ret;
+}
+
+int kfd_criu_dump_queues(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
+{
+	struct kfd_criu_queue_bucket *queue_buckets;
+	uint32_t num_queues, queue_extra_data_sizes;
+	uint64_t queues_priv_data_offset = 0;
+	int ret = 0, pdd_index, q_index = 0;
+	void *private_data; /* Pointer to first private data in userspace */
+
+	ret = kfd_process_get_queue_info(p, &num_queues, &queue_extra_data_sizes);
+	if (ret)
+		return ret;
+
+	if (args->num_objects != num_queues) {
+		pr_err("Mismatch with number of queues (current:%d user:%lld)\n",
+							num_queues, args->num_objects);
+		return -EINVAL;
+	}
+
+	if (args->objects_size != queue_extra_data_sizes +
+				  (num_queues * (sizeof(*queue_buckets) +
+						 sizeof(struct kfd_criu_queue_priv_data)))) {
+		pr_err("Invalid objects size for queues\n");
+		return -EINVAL;
+	}
+
+	/* Queue private data size for each queue can vary in size as it also includes cu_mask.
+	 * First queue private data starts after all queue_buckets
+	 */
+
+	queue_buckets = (struct kfd_criu_queue_bucket *)args->objects;
+	private_data = (void *)(queue_buckets + args->num_objects);
+
+	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
+		struct kfd_process_device *pdd = p->pdds[pdd_index];
+
+		/* criu_dump_queues_device will copy data to user */
+		ret = criu_dump_queues_device(pdd,
+					      &q_index,
+					      args->num_objects,
+					      queue_buckets,
+					      private_data,
+					      &queues_priv_data_offset);
+
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int set_queue_properties_from_criu(struct queue_properties *qp,
+					  struct kfd_criu_queue_bucket *q_bucket,
+					  struct kfd_criu_queue_priv_data *q_data,
+					  void *cu_mask)
+{
+	qp->is_interop = false;
+	qp->is_gws = q_data->is_gws;
+	qp->queue_percent = q_data->q_percent;
+	qp->priority = q_data->priority;
+	qp->queue_address = q_data->q_address;
+	qp->queue_size = q_data->q_size;
+	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
+	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
+	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
+	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
+	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
+	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
+	qp->ctl_stack_size = q_data->ctl_stack_size;
+	qp->type = q_data->type;
+	qp->format = q_data->format;
+
+	if (q_data->cu_mask_size) {
+		qp->cu_mask = kzalloc(q_data->cu_mask_size, GFP_KERNEL);
+		if (!qp->cu_mask)
+			return -ENOMEM;
+
+		/* CU mask is stored after q_data */
+		memcpy(qp->cu_mask, cu_mask, q_data->cu_mask_size);
+		qp->cu_mask_count = (q_data->cu_mask_size / sizeof(uint32_t)) * 32;
+	}
+
+	return 0;
+}
+
+static int criu_restore_queue(struct kfd_process *p,
+			      struct kfd_dev *dev,
+			      struct kfd_process_device *pdd,
+			      struct kfd_criu_queue_bucket *q_bucket,
+			      void *private_data)
+{
+	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
+	uint8_t *cu_mask;
+	struct queue_properties qp;
+	unsigned int queue_id;
+	int ret = 0;
+
+	pr_debug("Restoring Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
+
+	/* data stored in this order: cu_mask */
+	cu_mask = (void *)(q_data + 1);
+
+	memset(&qp, 0, sizeof(qp));
+	ret = set_queue_properties_from_criu(&qp, q_bucket, q_data, cu_mask);
+	if (ret)
+		goto err_create_queue;
+
+	print_queue_properties(&qp);
+
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, NULL);
+	if (ret) {
+		pr_err("Failed to create new queue err:%d\n", ret);
+		ret = -EINVAL;
+		goto err_create_queue;
+	}
+
+	pr_debug("Queue id %d was restored successfully\n", queue_id);
+
+	return 0;
+err_create_queue:
+	kfree(qp.cu_mask);
+
+	return ret;
+}
+
+int kfd_criu_restore_queues(struct kfd_process *p, struct kfd_ioctl_criu_restorer_args *args)
+{
+	int ret = 0, i;
+	struct kfd_criu_queue_bucket *user_buckets;
+	uint8_t *all_private_data; /* Pointer to first private data in userspace */
+	uint8_t *q_private_data = NULL; /* Local buffer for individual queue private data */
+	unsigned int q_private_data_size = 0;
+
+	user_buckets = (struct kfd_criu_queue_bucket *)args->objects;
+	all_private_data = (void *)(user_buckets + args->num_objects);
+
+	/*
+	 * This process will not have any queues at this point, but we are
+	 * setting all the dqm's for this process to evicted state.
+	 */
+	kfd_process_evict_queues(p);
+
+	for (i = 0; i < args->num_objects; i++) {
+		struct kfd_process_device *pdd;
+		struct kfd_dev *dev;
+		struct kfd_criu_queue_bucket q_bucket;
+
+		ret = copy_from_user(&q_bucket, (void __user *)&user_buckets[i],
+				sizeof(struct kfd_criu_queue_bucket));
+
+		if (ret) {
+			ret = -EFAULT;
+			goto exit;
+		}
+
+		/* Increase local buffer space if needed */
+		if (q_bucket.priv_data_size > q_private_data_size) {
+			kfree(q_private_data);
+
+			q_private_data = kmalloc(q_bucket.priv_data_size, GFP_KERNEL);
+			if (!q_private_data) {
+				ret = -ENOMEM;
+				goto exit;
+			}
+			q_private_data_size = q_bucket.priv_data_size;
+		}
+
+		ret = copy_from_user(q_private_data,
+				(void __user *) (all_private_data + q_bucket.priv_data_offset),
+				q_bucket.priv_data_size);
+		if (ret) {
+			ret = -EFAULT;
+			goto exit;
+		}
+
+		dev = kfd_device_by_id(q_bucket.gpu_id);
+		if (!dev) {
+			pr_err("Could not get kfd_dev from gpu_id = 0x%x\n",
+			q_bucket.gpu_id);
+
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		pdd = kfd_get_process_device_data(dev, p);
+		if (!pdd) {
+			pr_err("Failed to get pdd\n");
+			ret = -EFAULT;
+			return ret;
+		}
+
+		ret = criu_restore_queue(p, dev, pdd, &q_bucket, q_private_data);
+		if (ret) {
+			pr_err("Failed to restore queue (%d)\n", ret);
+			goto exit;
+		}
+
+	}
+
+exit:
+	kfree(q_private_data);
+
+	return ret;
+}
+
+
 #if defined(CONFIG_DEBUG_FS)
 
 int pqm_debugfs_mqds(struct seq_file *m, void *data)
-- 
2.17.1

