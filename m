Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD378C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 10:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A083760FDC
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A083760FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FEA89CC1;
	Mon, 25 Oct 2021 10:01:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E34D89CC1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 10:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKbf+RmSyN5z4tvm8iK8NYxVJ2ULoACpVYZy7fwLMfLWNGG8dpBI5TO4GGWaIIy8puNJBVydWT4tXKBHUHsOf9Kmx037Mb3mBnNjJZP3Jniu2PszVW21TFpD8rPIKzcNytN2rY285wfUKozW9KNnVMA20DOxAIWKCjmWg9xAp9kub89LPiBlgmnM1VSeGe7W4O7PEEa/hBCy1BThBAG1Sc+EdrT2XtsUMZDSw01aRZUTNcoMJ/6PTMrcf2apFIqv+nWpeqnQSEPKuGn80q3R1n/JCdV8qn9YlAIuw7FB5G31zesgcoxlCp2mslOMi7y9Owy9Bm+iYyVhALC0rFupMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yxCZa6WhaS8XBknQ4YszCS2dIfeBeVgIxuvvzdZaAQ=;
 b=WX3mXaWAUWUZ3gqRh7Fr9t62Jue/9YsTthm+TkEdiQB2Ca8cWmcJ5FFSo2xHPfqB9ggyKVVM0oxlkrC0yJyVnCV11GKymaWBcsIiQADGFK8pkIHa85X06tPNa+G0vhpUYB8K9edhn2f1amap4+2javqiv5zB6L7wwIPEZsS7skt3dycUXWnTx2Rw7TxNsK3aBiTeyFu0F76ACjA5E9cwauH4V5XNmbal4DA75a0IMESIa02aLGVKdFjNLC9RmARt3WOa5fGsSUQjaq3guiDs3rWPOxvasc4kIC7eEa5Z0r4dw5YHl8tn4bDWrKFZLgKkMfmaoZgvavl7MPMq6dpbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yxCZa6WhaS8XBknQ4YszCS2dIfeBeVgIxuvvzdZaAQ=;
 b=S3XPupcLWSSL7T1VbZwnAvn85MRwfrU1myoEHopFk8fn7ax/VjHM4enkgo21sgcqKe00NoB49AM+vlna6K4pKWMQmOevamycD4m81VozARCIruwB02zHeNTMCgv6xx5daFONhMmTclqldqhW8MGAxe2N/er+OKj3LT73Ak8ueZg=
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Mon, 25 Oct 2021 10:01:07 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::af) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 10:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 10:01:06 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 05:01:03 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Add an optional argument into update queue
 operation(v2)
Date: Mon, 25 Oct 2021 17:58:21 +0800
Message-ID: <20211025095822.207721-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7645aad-3a28-4806-0306-08d9979e5cfa
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5445139E4A56B6BBB1BCB74CFB839@DM8PR12MB5445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CR37L5zqR/pc/CFjcsrOcaiTgbsxkUu/T64ePnduS0zA/IDoPXIMwclykD+54GMU+KUJjEMx2vhI4Ixz7L+IeoF1t/wPuOeS8U1HUs/rhiOFIRH6wOmNVi5HyqNGoXjIT0Nvi3CWkshrtdp3ZvSTPHM+INx6IY26sWWpGvLVdt3JRA1xc1pS9M5Ea72kbNvxduL7DgzTJLLcLM6oZMw0jJwf/Or/usg0daLc0XAe0LHvTR31dx3zkE5oiumTVR01sHbmpdOvmyEcqUWF0lmYr7g93ToZk88Si4ZQ1+FBQqdA/Si4t7gL3zMu3ZCHNK/T3io6smzsYfeZHOHukgkp1okWj+coVRFAoCRBB7M3RZNoZXAcU1d3DQVxy7W8keasx2yYfsvRNF53ZSNV3wotc8bdeQ6yYCvVZkTQ/kQDOPigNaGUKs/YUSeGfcZiOyMyGqcBVVCNKJ/heX3h1Iv3MdWcj4xjrEioWdbKR6XxnJyTL6uitjGTV+vLVFwvFlpi9viqOYfP/Qk73CLrz9IwDWhLGKcvLbUXHpdCcuqkkl4PjHf2aczOgkw6w3JMfn87CmB5nqDQhdXAwgDBZ5QaZV41XAl03n8Fn7I2rDmBkiKBMq2BLo945T29U9XhIlGQqwI0j8YkYVQc6PU2pf9RqHsftT3+S39JPWrz47LfNxoq7puMPVu32EvUZumECfyJEG4qJsYpJiDrks9tkTV9ky9IRthpZaDyagfwTsRyhGY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(47076005)(5660300002)(36860700001)(30864003)(1076003)(6666004)(4326008)(8936002)(8676002)(86362001)(508600001)(15650500001)(7696005)(54906003)(2906002)(36756003)(26005)(6636002)(186003)(16526019)(83380400001)(356005)(81166007)(110136005)(316002)(44832011)(70206006)(70586007)(2616005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 10:01:06.8532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7645aad-3a28-4806-0306-08d9979e5cfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
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

Currently, queue is updated with data in queue_properties.
And all allocated resource in queue_properties will not
be freed until the queue is destroyed.

But some properties(e.g., cu mask) bring some memory
management headaches(e.g., memory leak) and make code
complex. Actually they have been copied to mqd and
don't have to persist in queue_properties.

Add an argument into update queue to pass such properties,
then we can remove them from queue_properties.

v2: Don't use void *.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  5 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 23 +++++++++-------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 10 ++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 10 ++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 26 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    |  6 ++---
 9 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f8fce9d05f50..533b27b35fc9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -557,7 +557,8 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-static int update_queue(struct device_queue_manager *dqm, struct queue *q)
+static int update_queue(struct device_queue_manager *dqm, struct queue *q,
+			struct mqd_update_info *minfo)
 {
 	int retval = 0;
 	struct mqd_manager *mqd_mgr;
@@ -605,7 +606,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 		}
 	}
 
-	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties);
+	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
 
 	/*
 	 * check active state vs. the previous state and modify
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c8719682c4da..499fc0ea387f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -93,7 +93,7 @@ struct device_queue_manager_ops {
 				struct queue *q);
 
 	int	(*update_queue)(struct device_queue_manager *dqm,
-				struct queue *q);
+				struct queue *q, struct mqd_update_info *minfo);
 
 	int	(*register_process)(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 6e6918ccedfd..965e17c5dbb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -80,7 +80,8 @@ struct mqd_manager {
 				struct mm_struct *mms);
 
 	void	(*update_mqd)(struct mqd_manager *mm, void *mqd,
-				struct queue_properties *q);
+				struct queue_properties *q,
+				struct mqd_update_info *minfo);
 
 	int	(*destroy_mqd)(struct mqd_manager *mm, void *mqd,
 				enum kfd_preempt_type type,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 064914e1e8d6..00bcaa11ff57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -135,7 +135,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -152,7 +152,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static void free_mqd(struct mqd_manager *mm, void *mqd,
@@ -185,7 +185,8 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 }
 
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q, unsigned int atc_bit)
+			struct queue_properties *q, struct mqd_update_info *minfo,
+			unsigned int atc_bit)
 {
 	struct cik_mqd *m;
 
@@ -221,9 +222,10 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
-	__update_mqd(mm, mqd, q, 1);
+	__update_mqd(mm, mqd, q, minfo, 1);
 }
 
 static uint32_t read_doorbell_id(void *mqd)
@@ -234,13 +236,15 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static void update_mqd_hawaii(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
-	__update_mqd(mm, mqd, q, 0);
+	__update_mqd(mm, mqd, q, minfo, 0);
 }
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-				struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct cik_sdma_rlc_registers *m;
 
@@ -318,7 +322,8 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 }
 
 static void update_mqd_hiq(struct mqd_manager *mm, void *mqd,
-				struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct cik_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c7fb59ca597f..7f1101780135 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -136,7 +136,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -162,7 +162,8 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-		      struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct v10_compute_mqd *m;
 
@@ -311,7 +312,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -326,7 +327,8 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct v10_sdma_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7f4e102ff4bd..152f29b28a79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -188,7 +188,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -212,7 +212,8 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-		      struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct v9_mqd *m;
 
@@ -366,7 +367,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -381,7 +382,8 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct v9_sdma_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 33dbd22d290f..4a8f3a06e6df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -150,7 +150,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -167,8 +167,8 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q, unsigned int mtype,
-			unsigned int atc_bit)
+			struct queue_properties *q, struct mqd_update_info *minfo,
+			unsigned int mtype, unsigned int atc_bit)
 {
 	struct vi_mqd *m;
 
@@ -238,9 +238,10 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
-	__update_mqd(mm, mqd, q, MTYPE_CC, 1);
+	__update_mqd(mm, mqd, q, minfo, MTYPE_CC, 1);
 }
 
 static uint32_t read_doorbell_id(void *mqd)
@@ -251,9 +252,10 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
-	__update_mqd(mm, mqd, q, MTYPE_UC, 0);
+	__update_mqd(mm, mqd, q, minfo, MTYPE_UC, 0);
 }
 
 static int destroy_mqd(struct mqd_manager *mm, void *mqd,
@@ -317,9 +319,10 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 }
 
 static void update_mqd_hiq(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
-	__update_mqd(mm, mqd, q, MTYPE_UC, 0);
+	__update_mqd(mm, mqd, q, minfo, MTYPE_UC, 0);
 }
 
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -336,7 +339,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -349,7 +352,8 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		struct queue_properties *q)
+			struct queue_properties *q,
+			struct mqd_update_info *minfo)
 {
 	struct vi_sdma_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 30f08f1606bb..d758a57b17e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -482,6 +482,8 @@ struct queue_properties {
 			    (q).queue_percent > 0 &&	\
 			    !(q).is_evicted)
 
+struct mqd_update_info;
+
 /**
  * struct queue
  *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 243dd1efcdbf..37529592457d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -121,7 +121,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->kgd) : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q);
+							pqn->q, NULL);
 }
 
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
@@ -429,7 +429,7 @@ int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
 	pqn->q->properties.priority = p->priority;
 
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q);
+							pqn->q, NULL);
 	if (retval != 0)
 		return retval;
 
@@ -457,7 +457,7 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
 	pqn->q->properties.cu_mask = p->cu_mask;
 
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q);
+							pqn->q, NULL);
 	if (retval != 0)
 		return retval;
 
-- 
2.25.1

