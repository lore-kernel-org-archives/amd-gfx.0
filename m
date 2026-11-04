Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228F606B2E4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hW5Q/obj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D5710E1D3;
	Wed,  4 Nov 2026 20:49:49 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879B310E1D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuPk4QHLxiRgIzXgR1YTFyQyzG7ZtU6zcVj9kB3cGRXp7/63Ky9JQ6qMPSQfmDtsbQKYWzuLv+DfQe65f7U7L/f9NpiKG8qrkEChvn1/4+6d7PzkvxmuGONRS4gh0tercYAqAgk7SI75v7+4yusH+4VZ8p5YpWOrp8sX6T2dLGxMdv6dWnfoHolZH8N5m1hJUJSRO5MAmBuRXdt+nghKxKpJ2QcDsQKkLIUa/a6Jdae4LP7MkRYEDKSURjjl3dI1ZKdbwEisepl/G8uZqup+F6QCJNYLEIJR6FuvoLeHcznbN6fl4ddiFJSKjd4LTR6pBEZoj3ZAWhFM0IU3ORYeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EogZANmZHmFyRXkElsbgBaKaeKxYjGOwojO+7hAAMho=;
 b=Pqik++baBWH7Uy3hnkFqZpPpb1c095hwzQZjpCIQU6AGk4dYFL1etyivBXKAinuEY9c9tuPBf1gQT17RNnDqKpV/3CGwK+xQKsy6xxhE2sMknqG03myCj8jQmNWPd/2XFXeRjqx2sYatrqqIHcVju1UxXWVmCJinhJInH7yuZXwl2Q1qkoh8fTAFS2g9l0Rjxme0haawT+NRBvv3i/tFP661Z0pK2n/k4q4tLc5900fg1qT1b/38/ZEyGO784P/ZRZ8gXlGSaRHdB1yhi1X22ACoskJEG6DGkIp9w3s4VhEm6i7mhD40BXpITeP1FX/R+oKBhJe31egjibu3DhVlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EogZANmZHmFyRXkElsbgBaKaeKxYjGOwojO+7hAAMho=;
 b=hW5Q/objrPcQZGaBO3XCllP/y4r6lj4fKAcxdtv2YsyxJlxsdVMiQlpZgsgYZXTQ9sQtvCW57WjKXW8pHDjvCMagaKehF906olfB6bPTge8+UVkuw0tfR47jhq216Xu/iIWYzcwM4GLufCUL6kJVVPG6w4/amv+LSUiAZxfbj6k=
Received: from MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:49:39 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::ab) by MN2PR07CA0010.outlook.office365.com
 (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 4
 Nov 2026 20:49:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 20:49:39 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 14:49:37 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Francis <David.Francis@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v5 2/2] drm/amdkfd: Acquire cwsr buffer during CRIU resume
Date: Wed, 4 Nov 2026 15:49:23 -0500
Message-ID: <20261104204923.4011440-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104204923.4011440-1-David.Francis@amd.com>
References: <20261104204923.4011440-1-David.Francis@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 2366d08c-6533-483e-94e5-08df3ab524eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Sju+U2y1ngYdIIUlwG7MHqSI8p2yntzklBU034TWV6D6YrNNBhEJ6cPjPkdYp036iRVYvspkQeRLVtX4ypub+O4o6PJmDYfTJmgjSrokYKpmEnr+p86QvCMbCptwihdix5IaS3RDUb+sIcVeL/VyRfN5YJsqcTg1FLI/3klsJcziqK3lbSl4yCp9LUwECwXzlJnGsnnYnQcrRR5pkGKY8meoAODpUZhpPb+3Y4K4SQyV+731MEzDBi+cXksOhQxOPzAP0E9dSlBLZNwY1XdrZeV3VMgaMXLMvwRfe/i10MKZAs4UgwU1Jr7ISETAIicuQPt10kxQZ3wOp3vT2e7o+mdvxbpXRhIiNlWrXN/xq/c3jZ58jRHaWtIacGEEWmUxFM89aCNtsvOTIKXHflDdD86t7mF0qmL8pTv+lfMeinKvNNwDUD5So38bPI/PUssnpZaKkiltg9glkKRlgtyVwAJA3oEbYIDcRzeRRIXQt/O2ng7VxRWZfb1FrB58rKSIg2WU11hgPJH3VNDfBFpdmNhJLdEUv+HHenqAk0NI4dUYKvLtLiYOHuZ0CLLGVtep2nkIrfJQqG3DbX1lgqIrMscxbCA/XiKC6gHknBW7eyZMKNAD/ONS90zSbKdLc/ao7YXUC6XJjruocqjilMLHiuyv6s599DEQtahmrUAyV6NboaL86i4kWgb+pj4ZFs82g/ZFePW76C4t2uRpfQUdww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NfEOS2opV/PhtL7fg2bmRcPX6Yu2WL8I5QswOnT5UHo3nNXJXQMjDnfQZt+tQAODcu0eVtirtSz54IfGweBync4tM/EgfQ+CmEhkIqMCFCpk7Eevjd5NxT7Xi64FVV4CtEe9O9PH9EGKftluyoQeWqUxxl078Vkh0I2ygWiTnnaUSvJ08D/gUvQrITFP2hpCnrejqYFb2TptEL1JpB+cQ01mLbml7R2H7tk0bL+bA8PkZyWNDoZIVMI5XKUcz/rkHW197qIFTF2G08GQeS9955YCjtME3u4X8hXBow8+OtTdn01u/IGq8CrLwpxHKauJEf/RD1rAjO2idRmreEDYPRA3YTlqji4dHVRFuz7joIHDOkaZRYHrx7pFRvtLDjQL5g4xgeUz6ik4iQXdM2AuaCIzFnYW7KfiUnpL3K2JepeBCIw8fA0V7jwaX2JMM3MS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:49:39.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2366d08c-6533-483e-94e5-08df3ab524eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

In normal kfd queue create, a reference to the cwsr svm range
is acquired so that this buffer is not freed from underneath the
queue. We weren't doing that.

After svm ranges are restored in RESUME phase of CRIU, go through
all the queues and acquire a reference to the cwsr.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 32 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  4 +--
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cae3767aec567..b13aca2fc89cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2861,6 +2861,8 @@ static int criu_resume(struct file *filep,
 		goto exit;
 	}
 
+	kfd_criu_resume_queues(target);
+
 	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
 	if (ret)
 		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 5f27ea7752349..05b24ca26b11c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1371,6 +1371,8 @@ int kfd_criu_restore_event(struct file *devkfd,
 			   uint8_t __user *user_priv_data,
 			   uint64_t *priv_data_offset,
 			   uint64_t max_priv_data_size);
+
+int kfd_criu_resume_queues(struct kfd_process *p);
 /* CRIU - End */
 
 /* Queue Context Management */
@@ -1387,6 +1389,7 @@ void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 			   struct queue_properties *properties);
 void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5741ed95c3817..b68e884b1c37a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1124,6 +1124,38 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	return ret;
 }
 
+int kfd_criu_resume_queues(struct kfd_process *p)
+{
+	int ret, i;
+	u64 total_cwsr_size;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct kfd_topology_device *topo_dev;
+		struct queue *q;
+
+		topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+
+		list_for_each_entry(q, &pdd->qpd.queues_list, list) {
+			total_cwsr_size = q->properties.ctx_save_restore_area_size +
+					  topo_dev->node_props.debug_memory_size;
+			if (check_mul_overflow(total_cwsr_size,
+					       NUM_XCC(pdd->dev->xcc_mask),
+					       &total_cwsr_size))
+				return -EINVAL;
+			total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
+			ret = kfd_queue_buffer_svm_get(pdd, q->properties.ctx_save_restore_area_address,
+						       total_cwsr_size);
+			if (ret)
+				return ret;
+		}
+
+	}
+
+	return 0;
+}
+
 int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
 				  unsigned int qid,
 				  uint32_t *mqd_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9dcf0134f35bc..cd41b10e08731 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -88,7 +88,7 @@ void uninit_queue(struct queue *q)
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 
-static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	struct kfd_process *p = pdd->process;
 	struct list_head update_list;
@@ -182,7 +182,7 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
 }
 #else
 
-static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	return -EINVAL;
 }
-- 
2.34.1

