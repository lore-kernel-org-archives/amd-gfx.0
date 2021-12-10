Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E24C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 11:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E1010E487;
	Fri, 10 Dec 2021 11:15:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB4C10E487
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpDAWV1mIFkhxkh9U8/0e9cdT4sGj9lmXtzL0/+OoWfj28bng0We6VsUDfD2BjSAHDSVz4u+uDcGbyTLDdw+PMXQtztXFfQox0WaraPRjh89x7x2VE55b9akCzaf0YoN3UjreT+bHte0B2qKbLU4AQJpOupUwPu3ppMFCoeyZI24uRHSxI4p3T7aW9eoVBBTGBrYyxR0v3kmw0rT8+ir3T5sbNlK0Mbj7p/EI6jP7MJRUq2iVn28f/P/ysTa3yLp8nZTnZyW09cevWZATNWI63jVcsDdvKhRkH6amA+mTBtz0kjM/kYwE58TGQnvnUlFTefebAOnBQhYs/JbRqvgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8DKBGlvRwX/k+1lNpK+8VK8lTXKIJGyWWT98Yi804U=;
 b=S59QD+N9H3dnF349Vq5dGEno07SWBI59xwJWtoE75LD/7TO4EHjRVVP51kZV85b8QPnLz8v3SaXIZgQJZMdk83IHzmcvkBAiXAFslzLrOC30grD/FV8dgxyQ4jD+tWs19ACT50NwcnpqCvNyGdivj5v0zUi6r3VwCf9PD2usTrwd3n++Agf1FEijZTTG4DTMUxvDFnkJLxbAMK2J1r0jLdr+GCoyp2HoEwg1+bavzHQKzYJ8Ag1BSLm8mkBl4TFBjnNCble7ldzzIXZ6/GC/qoSd+jhfenYu9Xdtn4TS+QyBYDuZtbmOO+Qh2jVirfUNzYx1yRU9NkLgySTlmRCjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8DKBGlvRwX/k+1lNpK+8VK8lTXKIJGyWWT98Yi804U=;
 b=u7S7rctbtfibnrPcaipUe+Uv/NeuSfrhekp6JnV6GdRZR9HtJJCSrJu0jsHQUSnK6rG1lvNsSAiVUnriVoBezOrHosLSJmoBwANba5xjWEEecS4Q517Fzz6G1rfU7EJg/Pi2OK/1QE2+mSiM1r1IH4k400GwJIIsrhSgzfihrJw=
Received: from BN6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:405:2::30)
 by MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Fri, 10 Dec
 2021 11:15:22 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::e4) by BN6PR11CA0020.outlook.office365.com
 (2603:10b6:405:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 11:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 11:15:22 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 05:15:19 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <thomas.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: reset queue which consumes RAS poison
Date: Fri, 10 Dec 2021 19:15:02 +0800
Message-ID: <20211210111502.17384-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210111502.17384-1-tao.zhou1@amd.com>
References: <20211210111502.17384-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc6df84b-75c7-4d31-6196-08d9bbce5bb2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3088BCA0027638D62B3FA880B0719@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYB5pTdychxJtwST8Pqn1Od9VbxdeB89AOwy4LrmSactc2MOjCSAueSJ/QiB/fAINjfW+8PHcuXgwyoVp0lLTF1c8AVNtEe94qqFoZ5ZGlY8Rwk0qSN0R+OZ/KmlrclrgbLpN3JPa6MJB9Or1B2dkiWxSQiBJwgVHuBYMTMnq1NR/T8NfTEMYUxokcgqyi3PiXC/LP/xe3uDcK69PS728UCKYN/OM7tZJSqyeorZ78rdMizFtMQaoI0c/slrbnhnJ6qPE1jITMllIBpNYTdY36yjfgMKhrHWhZEa7uRKYsTV3KV6lX5yp+XABcdsiMP524onOfkVjGQ4gOxnLjrk/RSu/CWKoDdOfh7rWGC/Nc008RKdGOJLrusDFHrzLGqWk/Kd3uTi9FmOR/Yq9Ozf/3RG2zk22ltSxOSZBi3aRu79ac+itnSG0+tv8wewessphdVLjatcTfiQRDguTsj+JBKlGMNEipibgSLWR4NeKxQaoTw86QX9kuP33oWwDEIa7KcUF9Z68KaTca7SIWbtq/s25dampQInPFaHWViSfxvi+pqevBpXHPtf6Tvh8CjNV9kk/W7u8e9UJOOyYA3tkp/iVASjIGGb7YKbNx0SfHk7/0Qtvaz4i5QmIT7uh20d8NbmhXdh1oSNO9uOJiGTncAJCfZNT9jH+JbyGOBPvVVu+0PEdWJK+JgsN6GL1TtV0be3PS2fhztKGV/m8NPM/OaO23Jy9miW3C00bXGfa+Eq/fqiW0lThc/fsKj0+I4VFgH9Zf1mvCjeJZ61voKLyDzHYx3sIS4AHmO0ldKHQfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(70586007)(6666004)(8676002)(7696005)(82310400004)(83380400001)(6636002)(2616005)(4326008)(508600001)(36860700001)(26005)(5660300002)(426003)(1076003)(186003)(16526019)(336012)(2906002)(47076005)(36756003)(316002)(40460700001)(356005)(81166007)(86362001)(8936002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:15:22.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6df84b-75c7-4d31-6196-08d9bbce5bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CP supports unmap queue with reset mode which only destroys specific queue without affecting others.
Replacing whole gpu reset with reset queue mode for RAS poison consumption
saves much time, and we can also fallback to gpu reset solution if reset
queue fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 14 ++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 6 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 46cf48b3904a..0bf09a94d944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -721,13 +721,13 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
 	return adev->have_atomics_support;
 }
 
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev)
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bool reset)
 {
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
 	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
-	else
+		amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+	else if (reset)
 		amdgpu_amdkfd_gpu_reset(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fcbc8a9c9e06..61f899e54fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -296,7 +296,8 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
+				bool reset);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 01a2cc3928ac..095b2e0822aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1476,6 +1476,20 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
+int unmap_queues_cpsch_poison(struct device_queue_manager *dqm, uint32_t pasid)
+{
+	int ret;
+
+	dqm_lock(dqm);
+
+	ret = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
+			pasid, true);
+
+	dqm_unlock(dqm);
+
+	return ret;
+}
+
 /* dqm->lock mutex has to be locked before calling this function */
 static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 499fc0ea387f..c52869133159 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -219,6 +219,7 @@ unsigned int get_queues_per_pipe(struct device_queue_manager *dqm);
 unsigned int get_pipes_per_mec(struct device_queue_manager *dqm);
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm);
 unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm);
+int unmap_queues_cpsch_poison(struct device_queue_manager *dqm, uint32_t pasid);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index deb64168c9e8..2863bb9e5bca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -89,6 +89,27 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
 #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
+static void event_interrupt_poison_consumption(struct kfd_dev *dev,
+				uint16_t pasid)
+{
+	int ret;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+
+	/* all queues of a process will be unmapped in one time */
+	if (p && atomic_read(&p->poison))
+		return;
+
+	atomic_set(&p->poison, 1);
+	ret = unmap_queues_cpsch_poison(dev->dqm, pasid);
+	kfd_signal_poison_consumed_event(dev, pasid);
+	/* resetting queue passes, do page retirement without gpu reset
+	   resetting queue fails, fallback to gpu reset solution */
+	if (!ret)
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+	else
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+}
+
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -230,8 +251,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
+					event_interrupt_poison_consumption(dev, pasid);
 					return;
 				}
 				break;
@@ -252,8 +272,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
-			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
+			event_interrupt_poison_consumption(dev, pasid);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0c3f911e3bf4..ea68f3b3a4e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -856,6 +856,8 @@ struct kfd_process {
 	struct svm_range_list svms;
 
 	bool xnack_enabled;
+
+	atomic_t poison;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
-- 
2.17.1

