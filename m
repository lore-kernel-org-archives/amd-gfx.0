Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE3EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 23:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED51210E75E;
	Fri,  4 Feb 2022 23:45:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C4210E75E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 23:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9kAzWQT1pttPBHFRpmQsWcPH5istIMMdH/tLqanBkaZKXIbJ4IoW4Gs0j9CBX6lz60YigYMm69zP300R9gJA82eTqN4MkeBzMt8N0qLVnxQLGjHoopoDOdGZ8TQA0SgLzHIJppj59SjGSyyKGyIy0OPB/aYuquJFPULiPRW+vLFH0AxL4iJZrAboAtP417txb72i4TT8swDWrn/jldDdMwhXf1SDfIYZ1xY05eqrBwSncXy94CuYYGO4/O5JSUkz/c4tScoNDACCIqTYZWZQRLKR3bnIZVEEXNKOXKJqSNVWpu2daPe3CUT6277ZhmJbGPvygiwX7RPWdyIxv6iZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzqF6RLpJcKhbjNGVP9orADbuE5I9zTkyqUx10dhgTk=;
 b=a/NQDn15lOjMrmNwwUz/VtpVyr0v1f+/ta93eyMugHBVCoZq+Gnxj8B57J6G7xUPaxn3ZR1Qk5YOdHelcuYnD3jsOdKNbShRICTJLodmxElmoeNyMJWXx6Hieo02tyIeXDhtZIUGPSa4Tnrc/XA76xUwwoUinzz+CwsBASlwE6Q0feTM9N21LNGoL8YOUY7LBfjuQHO5xlHFc+m7L6I8wD1Xi8t3SmW92+9E6wFKjweCBNCaCieei6spEyni4+BvJCQ7I2epPW0fd6Yxyk7Y5hfbXKhos5+M3rgmk07TNI81+1XJdaSOsz4eNXoTZZJ3zhQ2oGnQKbUbH2lHjNSkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzqF6RLpJcKhbjNGVP9orADbuE5I9zTkyqUx10dhgTk=;
 b=sW9fe2rYv3m7brjo9CELou86rTHpqMKSuv69j12v7VmPJo5dP6SNUsYXdDnuXIT9UhxE9x/t1dfoln/C/oFxuCuprs2+y56K7YpA76xH6fJUMPJvdKlQUkJuVzggCyus+e75N65QZba5J72ws//WKN0oMNFebrtdY6++DUPy1no=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 23:45:29 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::1b) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 23:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 23:45:29 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 17:45:27 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Consolidate MQD manager functions
Date: Fri, 4 Feb 2022 18:45:13 -0500
Message-ID: <20220204234513.11714-3-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204234513.11714-1-mukul.joshi@amd.com>
References: <20220204234513.11714-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00483d93-7fb1-4acd-26c2-08d9e8386ccb
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2909018EF3D3EFDE8C2E2044EE299@MN2PR12MB2909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h31ar28pMtXFBrIPQU39wELRmwDFNRTvvguquDaPLh6dF75iAsJu5GxAuwLamqZABJpEUYIrLgNjEbhjJGk0fSXcJdghLU7ntPtpqwkdsOYf60qzyk5cs3fOnX5eGFgaSsrvBbjsJLuVsoyG/xNAwzTsxAXJUW24A7fF2/+2cWHLNga9fxC2aYuh0x+MmyGwgCxeA+6GxUGmBqKqAa9zv9tZpPX1NuCB+9Wcb9h+WGCt2HVWl76+zhFYGaQJE2OLIGwhFS1mAZwXroZlH1OEBVsYy6COfP8EQAikP+lj/aBZ/aUAXSP7rMflYAIvMFH6Hup5vxDo2MmhLJhx+wN0MEXBhQRbWX3cmyTCGQL8Sp15g5Bk3mQD6rG6D/K35AQZpYSVIM1bN9RV1fAb5stIBOik3EFD6c4izf6AG04WooKy2446lpjgRT3DBWqBACSephwgSx+i8FQucBOA32A5uEGmewZowLvjePhzI2UngEfTJlDO8zPeI/xl4IkW1fhm6qWLbxYMCWhnFSxY7am0KmM+L7YfCcyCg3tDuQKIzNRipPFjjDS0HEjEKhJfhwo8BJgzxNagMdQxVWXByTolqxnoBCyarF5mS8JZFqwDtCvB3F2RsDXsi7pYfHvHF/UGAeL4/4bN56DcWUBcjq6Icy9gPeSozemdu008uHXXdJ8SqvZo/sDAUZOJZJj25sekkP8acbx5DOh6aVIfpzClSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(82310400004)(70206006)(356005)(6666004)(7696005)(2906002)(70586007)(36860700001)(83380400001)(16526019)(8676002)(5660300002)(44832011)(30864003)(8936002)(2616005)(1076003)(26005)(186003)(426003)(336012)(40460700003)(86362001)(316002)(6916009)(36756003)(4326008)(47076005)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 23:45:29.0076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00483d93-7fb1-4acd-26c2-08d9e8386ccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A few MQD manager functions are duplicated for all versions of
MQD manager. Remove this duplication by moving the common
functions into kfd_mqd_manager.c file.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 63 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  | 27 ++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 54 ---------------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 61 -----------------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 68 -------------------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 53 ---------------
 6 files changed, 90 insertions(+), 236 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index e2825ad4d699..f4a6af98db2d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -173,3 +173,66 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		}
 	}
 }
+
+int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
+		     uint32_t pipe_id, uint32_t queue_id,
+		     struct queue_properties *p, struct mm_struct *mms)
+{
+	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
+					      queue_id, p->doorbell_off);
+}
+
+int destroy_mqd(struct mqd_manager *mm, void *mqd,
+		enum kfd_preempt_type type, unsigned int timeout,
+		uint32_t pipe_id,uint32_t queue_id)
+{
+	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
+						pipe_id, queue_id);
+}
+
+void free_mqd(struct mqd_manager *mm, void *mqd,
+	      struct kfd_mem_obj *mqd_mem_obj)
+{
+	if (mqd_mem_obj->gtt_mem) {
+		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
+		kfree(mqd_mem_obj);
+	} else {
+		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
+	}
+}
+
+bool is_occupied(struct mqd_manager *mm, void *mqd,
+		 uint64_t queue_address, uint32_t pipe_id,
+		 uint32_t queue_id)
+{
+	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
+						pipe_id, queue_id);
+}
+
+int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
+		  uint32_t pipe_id, uint32_t queue_id,
+		  struct queue_properties *p, struct mm_struct *mms)
+{
+	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
+						(uint32_t __user *)p->write_ptr,
+						mms);
+}
+
+/*
+ * preempt type here is ignored because there is only one way
+ * to preempt sdma queue
+ */
+int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
+		     enum kfd_preempt_type type,
+		     unsigned int timeout, uint32_t pipe_id,
+		     uint32_t queue_id)
+{
+	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
+}
+
+bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
+		      uint64_t queue_address, uint32_t pipe_id,
+		      uint32_t queue_id)
+{
+	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 23486a23df84..76f20637b938 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -136,4 +136,31 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		const uint32_t *cu_mask, uint32_t cu_mask_count,
 		uint32_t *se_mask);
 
+int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
+		uint32_t pipe_id, uint32_t queue_id,
+		struct queue_properties *p, struct mm_struct *mms);
+
+int destroy_mqd(struct mqd_manager *mm, void *mqd,
+		enum kfd_preempt_type type, unsigned int timeout,
+		uint32_t pipe_id,uint32_t queue_id);
+
+void free_mqd(struct mqd_manager *mm, void *mqd,
+		struct kfd_mem_obj *mqd_mem_obj);
+
+bool is_occupied(struct mqd_manager *mm, void *mqd,
+		 uint64_t queue_address, uint32_t pipe_id,
+		 uint32_t queue_id);
+
+int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
+		uint32_t pipe_id, uint32_t queue_id,
+		struct queue_properties *p, struct mm_struct *mms);
+
+int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
+		enum kfd_preempt_type type,unsigned int timeout,
+		uint32_t pipe_id, uint32_t queue_id);
+
+bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
+		uint64_t queue_address, uint32_t pipe_id,
+		uint32_t queue_id);
+
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 96e3303fa27c..81b6b3d5f2e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -156,13 +156,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	mm->update_mqd(mm, m, q, NULL);
 }
 
-static void free_mqd(struct mqd_manager *mm, void *mqd,
-			struct kfd_mem_obj *mqd_mem_obj)
-{
-	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
-}
-
-
 static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
 		    uint32_t queue_id, struct queue_properties *p,
 		    struct mm_struct *mms)
@@ -176,15 +169,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
 					  wptr_shift, wptr_mask, mms);
 }
 
-static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
-			 uint32_t pipe_id, uint32_t queue_id,
-			 struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
-					       (uint32_t __user *)p->write_ptr,
-					       mms);
-}
-
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q, struct mqd_update_info *minfo,
 			unsigned int atc_bit)
@@ -271,15 +255,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static int destroy_mqd(struct mqd_manager *mm, void *mqd,
-			enum kfd_preempt_type type,
-			unsigned int timeout, uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
-					pipe_id, queue_id);
-}
-
 static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct cik_mqd *m;
@@ -351,35 +326,6 @@ static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
-/*
- * preempt type here is ignored because there is only one way
- * to preempt sdma queue
- */
-static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
-				enum kfd_preempt_type type,
-				unsigned int timeout, uint32_t pipe_id,
-				uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
-}
-
-static bool is_occupied(struct mqd_manager *mm, void *mqd,
-			uint64_t queue_address,	uint32_t pipe_id,
-			uint32_t queue_id)
-{
-
-	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
-					pipe_id, queue_id);
-
-}
-
-static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
-			uint64_t queue_address,	uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
-}
-
 /*
  * HIQ MQD Implementation, concrete implementation for HIQ MQD implementation.
  * The HIQ queue in Kaveri is using the same MQD structure as all the user mode
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 0cc8679c24fa..8324757a1cf5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -154,14 +154,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 	return r;
 }
 
-static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
-			    uint32_t pipe_id, uint32_t queue_id,
-			    struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
-					      queue_id, p->doorbell_off);
-}
-
 static void update_mqd(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q,
 			struct mqd_update_info *minfo)
@@ -233,31 +225,6 @@ static uint32_t read_doorbell_id(void *mqd)
 	return m->queue_doorbell_id0;
 }
 
-static int destroy_mqd(struct mqd_manager *mm, void *mqd,
-		       enum kfd_preempt_type type,
-		       unsigned int timeout, uint32_t pipe_id,
-		       uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->adev, mqd, type, timeout,
-		 pipe_id, queue_id);
-}
-
-static void free_mqd(struct mqd_manager *mm, void *mqd,
-			struct kfd_mem_obj *mqd_mem_obj)
-{
-	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
-}
-
-static bool is_occupied(struct mqd_manager *mm, void *mqd,
-			uint64_t queue_address,	uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->adev, queue_address,
-		pipe_id, queue_id);
-}
-
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
@@ -352,15 +319,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	mm->update_mqd(mm, m, q, NULL);
 }
 
-static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		uint32_t pipe_id, uint32_t queue_id,
-		struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
-					       (uint32_t __user *)p->write_ptr,
-					       mms);
-}
-
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -390,25 +348,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-/*
- *  * preempt type here is ignored because there is only one way
- *  * to preempt sdma queue
- */
-static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		enum kfd_preempt_type type,
-		unsigned int timeout, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
-}
-
-static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
-		uint64_t queue_address, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
-}
-
 static void checkpoint_mqd_sdma(struct mqd_manager *mm,
 				void *mqd,
 				void *mqd_dst,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 87da4329dbf2..007886b2961e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -204,14 +204,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 					  wptr_shift, 0, mms);
 }
 
-static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
-			    uint32_t pipe_id, uint32_t queue_id,
-			    struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
-					      queue_id, p->doorbell_off);
-}
-
 static void update_mqd(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q,
 			struct mqd_update_info *minfo)
@@ -285,38 +277,6 @@ static uint32_t read_doorbell_id(void *mqd)
 	return m->queue_doorbell_id0;
 }
 
-static int destroy_mqd(struct mqd_manager *mm, void *mqd,
-			enum kfd_preempt_type type,
-			unsigned int timeout, uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->adev, mqd, type, timeout,
-		pipe_id, queue_id);
-}
-
-static void free_mqd(struct mqd_manager *mm, void *mqd,
-			struct kfd_mem_obj *mqd_mem_obj)
-{
-	struct kfd_dev *kfd = mm->dev;
-
-	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, mqd_mem_obj->gtt_mem);
-		kfree(mqd_mem_obj);
-	} else {
-		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
-	}
-}
-
-static bool is_occupied(struct mqd_manager *mm, void *mqd,
-			uint64_t queue_address,	uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->adev, queue_address,
-		pipe_id, queue_id);
-}
-
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
@@ -422,15 +382,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	mm->update_mqd(mm, m, q, NULL);
 }
 
-static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		uint32_t pipe_id, uint32_t queue_id,
-		struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
-					       (uint32_t __user *)p->write_ptr,
-					       mms);
-}
-
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -460,25 +411,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-/*
- *  * preempt type here is ignored because there is only one way
- *  * to preempt sdma queue
- */
-static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		enum kfd_preempt_type type,
-		unsigned int timeout, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
-}
-
-static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
-		uint64_t queue_address, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
-}
-
 static void checkpoint_mqd_sdma(struct mqd_manager *mm,
 				void *mqd,
 				void *mqd_dst,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 137b208135a0..c0405bbe8e36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -259,31 +259,6 @@ static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
 	__update_mqd(mm, mqd, q, minfo, MTYPE_UC, 0);
 }
 
-static int destroy_mqd(struct mqd_manager *mm, void *mqd,
-			enum kfd_preempt_type type,
-			unsigned int timeout, uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->adev, mqd, type, timeout,
-		pipe_id, queue_id);
-}
-
-static void free_mqd(struct mqd_manager *mm, void *mqd,
-			struct kfd_mem_obj *mqd_mem_obj)
-{
-	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
-}
-
-static bool is_occupied(struct mqd_manager *mm, void *mqd,
-			uint64_t queue_address,	uint32_t pipe_id,
-			uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->adev, queue_address,
-		pipe_id, queue_id);
-}
-
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  void __user *ctl_stack,
 			  u32 *ctl_stack_used_size,
@@ -385,15 +360,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	mm->update_mqd(mm, m, q, NULL);
 }
 
-static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		uint32_t pipe_id, uint32_t queue_id,
-		struct queue_properties *p, struct mm_struct *mms)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
-					       (uint32_t __user *)p->write_ptr,
-					       mms);
-}
-
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q,
 			struct mqd_update_info *minfo)
@@ -422,25 +388,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-/*
- *  * preempt type here is ignored because there is only one way
- *  * to preempt sdma queue
- */
-static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		enum kfd_preempt_type type,
-		unsigned int timeout, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
-}
-
-static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
-		uint64_t queue_address, uint32_t pipe_id,
-		uint32_t queue_id)
-{
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
-}
-
 static void checkpoint_mqd_sdma(struct mqd_manager *mm,
 				void *mqd,
 				void *mqd_dst,
-- 
2.33.1

