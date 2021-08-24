Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32284C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AB561265
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1AB561265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D616E0CE;
	Tue, 24 Aug 2021 19:40:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CDF6E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfMBx/ARTEW73vBzV0bLiOBfXpIoBTB0nOzvo1q52qeQLmeyxjcD3xODf+gk75G5sSCIsfeIVXq3W8O7xv9+n/pPZ50VYh1ebMH99H8a05o/XHKQO3KIYAVXu5OhOCGHOGpOWUH1W7XE0vU3etxoUtUINJjKwuoFr1YAtqTLjXfwj5GgTh8GWOBwxgoUM1tCim8wl6t9VNmMj0cu2JbcKBvPYySwSF5M/Xzuy0Ayy4dkol7ke4ZJBhR+LEriFVmtiE+y0HR9nMNBUhP/ZN0GXEqua05uvDp3k9hSGhE0C70KbDRGhXMFcGym2iHAHfnbzBSx+2LULYfeCFRn0ijwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3uWXai2GplDb5AIV0Y9kSwEudP+aeeVrcZ3antwk6M=;
 b=PVBq1sbNl5o3hqLgyoThFBKeSOuJ99jMEiAh1D9TEyxJptQhGM/t4Jtwe7bnmTKjmg10hlypd8z6SVPMEWCIyGhgPFKN9gcJm/OiS5dAwm5IT0xQ/hy7iwT+EpNB0Hj8uvZNEs261bpuf+5TjSGJ2jqlsdPCRd4KmU8PgaQb241FOdtrgEzB7qFdD1/IOQpbXBSAJSJOoIZ9ZBC+HMEBnlS7A4ieRmw77e8jjxU5E5oP7lh8wpbSLY5tM96NsaQuzU5L1DsU/dq12S7OCI630yB7Er/qh07zyFb8oOFW/XWkM+cOfHlvru3AmVZ0XjV/eGFEDp8/nwDUDHv6HM3bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3uWXai2GplDb5AIV0Y9kSwEudP+aeeVrcZ3antwk6M=;
 b=staLSweuPo8SMPgSPp5RhzHjuybbhQ+x+LfUUXpBFJeMhPdwH9S6cvCi7OVtwQ1ia+kCPJYoTlDj8ESWkT8Ryl4YCLWhPEXTk50VyVg7Yi4U5K8MFsHRa7Znip+y0uvC4Kw/4KQSBEAh62Tq2wyjA/ZvbV6CIXlTsmNssVI/t8Q=
Received: from DM5PR15CA0048.namprd15.prod.outlook.com (2603:10b6:4:4b::34) by
 BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 19:07:39 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::5b) by DM5PR15CA0048.outlook.office365.com
 (2603:10b6:4:4b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:38 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:34 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 09/18] drm/amdkfd: CRIU add queues support
Date: Tue, 24 Aug 2021 15:06:30 -0400
Message-ID: <20210824190639.6288-10-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 311323fd-694f-437c-edfd-08d9673270c1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:
X-Microsoft-Antispam-PRVS: <BY5PR12MB418072DE104427DC9D6D4CB695C59@BY5PR12MB4180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLicYh1VpEbnkgXK72pcrewmrHdcuRVmrS/0ly3pbHTwOaB0+m6iJt2xsxmDRcABfDy4tspb7uqfo7OLbOtq5vL3cwSuiGahNcBz6tg3yosSgK9Q2FiizUOOr4omIS01QmRRQYEVbl/EXVEPRGYlILQrKxLTB41BcCLNXw1oPL2aYyuczheOchE3JKDBoZMNrVPfXIzgzvGUbZmbBpaS1ws8myHEKqxdKnI/7S2uzpTnIuUlkVnDTVLWlJI8tF8NSoYNShPWeu3vYdPH75FLjZ5skanuo7vyRmuJUvY+13SG6S1FLHtSwiXTTUwT2CqIoKozyZiO+rTcpfW9xepvQ27N7N/r+74JsKoPXabGoyCTQsjnSJk3Dn2wqMoZuG6LkefKiW706YMpvlQ6QNzxCeW3ME5iiCI2g3YZwzzka9nw92F2zqicJXohxchTPZjBJeIX8m3lUC1TIJ/YfcyOGLRPqpYzdkYVMd0wxV3n7kFu1pI4eG0AEySblMqS/u5sOAl2K623BhK+ZKeml+XiQVuNJTGQMhj3yLbm6PRpI2vbfTDPn85eBEBg9x+3Q689fFtOoRyGrofQixoXGgDdVH31ioQ3ddHJP49xx0ktmX9f/Ruu4rvUZeJdj586uj4zVU6BfkS7GeFvICpiT0MihyrafBNgdgMH8Erd+pL6G5PPt7iBAPWR/jCbP+OgaAP2Kv8O7JpYQ9hfCNrExgS2NzBxwdN368/VJLd9gxK8mcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(82310400003)(6666004)(4326008)(7696005)(83380400001)(54906003)(478600001)(30864003)(82740400003)(336012)(70206006)(81166007)(1076003)(356005)(86362001)(47076005)(6916009)(36756003)(8936002)(2616005)(8676002)(36860700001)(16526019)(316002)(186003)(26005)(5660300002)(70586007)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:38.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311323fd-694f-437c-edfd-08d9673270c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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
index 821b7663fa5d..7f5dc038030c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2006,6 +2006,8 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 		ret = criu_dump_bos(p, args);
 		break;
 	case KFD_CRIU_OBJECT_TYPE_QUEUE:
+		ret = kfd_criu_dump_queues(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
 	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
@@ -2305,6 +2307,8 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 		ret = criu_restore_bos(p, args);
 		break;
 	case KFD_CRIU_OBJECT_TYPE_QUEUE:
+		ret = kfd_criu_restore_queues(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
 	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
@@ -2380,6 +2384,7 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
 				struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_criu_process_info_args *args = data;
+	uint32_t queues_extra_data_size;
 	int ret = 0;
 
 	pr_debug("Inside %s\n", __func__);
@@ -2399,7 +2404,16 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
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
index 0b8165729cde..7c0f3fc551c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1044,13 +1044,36 @@ struct kfd_criu_svm_range_priv_data {
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
index 95a6c36cea4c..65cec45190b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -507,6 +507,369 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
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

