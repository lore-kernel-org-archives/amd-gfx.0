Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E823CD8C98
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D910610E38F;
	Tue, 10 Oct 2023 14:41:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC20E10E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5ZVMQtMjkIY4EZAOirzlYowwGfsamQwi4lk5a9Zv107J2BpOOtOEUGWJbMH2cVqRACAs8MG5nJUxtuudhPLgKtondPs2i37T7073SgPvTsS4ayU9EPfC9nb6BPfawiO5Sei0ww/BguF0uB9Zt+fniLVLgCpqFilYYMdwvS3JuLxxXmiKi2Zk/SaaIxjl9tV/UsCRejVCepGxBi0/6JO2Naed1NpljCWq97mp0hYYqRTxjLFNKM8XaIuCw+luoZXNBE6H+d8fEB9nsp/dgXu0C/wC+V6mLacBfMyZtYJ+0yfB0oRID5wUCYliIlbCUItV2VOISQfYxdwvYB8HKT5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXM1bYl1F2TN5430ulQalO6O58HDT4/1Iu9TLPZRtic=;
 b=jo+RTyhxXKGOXFNwlAB+mK2SWrwH2CTa7/r4w8W7ohBC6vG4cI2OLbXOVx8t6rkwEQLCUunLr8xn3pgvVRjXrrg0DhahxKf+3AlYtqJLe7q0u7k+7Rt9vaN18cmcj8ZyFklMy1ti62x2fCsdWPVq3RTefmOmQPWB4q74o6N99ncgvaaCoU74xwwVoT5X1GusH8c3/yRMnc7RiesEeO/OLMeckQA5nzIFphsm4YWrmzEkB7hiQVmDgzRWd5Tfob3Ycz1FG8USZjrfzw3JkfYxH9G1Zd8Aw8Jp5DqHMe30AzZx30zcrafx9lEUug5ngsRFmLIs//rszuC4EPYf90xySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXM1bYl1F2TN5430ulQalO6O58HDT4/1Iu9TLPZRtic=;
 b=yLtNoT7b4V2dzqQfTw8NREhHQ0GWZaTwJFgb4R1i2LCcTM/5bzbbz7KvZ/5HvFeJHcyb5oA2syYFhaZ7gy5Sl7qg4Oo6p5F2u4UEmEiAdNOIG+TQKY4vtZGVpr9ezH7YbxwcNLskAn97Me3qIRKakbLE1fl1puxneW789bM3Sqc=
Received: from MW4P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::32)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Tue, 10 Oct
 2023 14:41:50 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::5a) by MW4P222CA0027.outlook.office365.com
 (2603:10b6:303:114::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:48 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/7] drm/amdkfd: Check bitmap_mapped flag to skip retry
 fault
Date: Tue, 10 Oct 2023 10:40:22 -0400
Message-ID: <20231010144024.3016-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
References: <20231010144024.3016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: c7260b26-2d72-42fb-71ce-08dbc99f09db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J37NvyhT76LDeRIZhV7j89TAhQYcEDigzFXH69zi2YbHaD3ciOr+fKP66/zatb3aS8MjKfd8gvYVbS/9mKqCxHEoQECBaB4tv2y9vsguzObm1c9uC+2DUTh8nNEvHbHMbcCc18ZyP9SG+GXeBUZ56rXagSZer1pDvIHib8baBwrAE7gkZI2/RVJD8O0sqzNKKzI37rwxxBW37mKSzRljxG+ctsMQ/0TPd2q1PDzomLwhiULFxrVxLX27qdmdo1MF+OPv1VGYk9gtbzhNnXhLJFnjSpajHMxpZQwuv2WEb2CcrTLZbPpXJE+/lPnbKijxI/7qlQ58nKLv9/gdta1Y8pzBM//HiH5lb2ksBLPElGu7D5WnTb4RZGIqQfSlmW7W6+J+OQQe0g9Cq6loulExSw7Lm+AoajNwwfK8ENKk/eqI3zwL58xM38T5yXoGWBnD4SXfbJxwMs9XRdT0nTLVUHSkqRjcKP2h+dNgMHSmRRuxpb7QjtISMJXKQaMP2CTI7Y3MVNrv2nNrYGRVj4glGEu5hTObxy4f9xxgXOb0bfAhqg4VDyvJFJ/zWheeMWH+4JPPGCMGpOZzhJ05EYY4qcocQ36t+K4JZRYBDXfTijAtoOVBHBfkPZcQoOf0W3/2f5yEwBV/yYWRbfKaFqEwqALywI4E5yfjSpPHXzvsjPFztzp5Jzc1utYwR4fYJc+TuQJZeAoR52BNmQ1tp4SiNxN9xeZX59FZR3+RVUrcfKtwrw0Zv1vYpSzSLuEl+KxrusXIGjm0nX3KYIp7X3lBcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(2616005)(336012)(426003)(1076003)(16526019)(26005)(40480700001)(316002)(70206006)(54906003)(6916009)(356005)(70586007)(41300700001)(47076005)(5660300002)(8676002)(4326008)(82740400003)(8936002)(2906002)(81166007)(36756003)(7696005)(6666004)(86362001)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:50.4010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7260b26-2d72-42fb-71ce-08dbc99f09db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove prange validate_timestamp which is not accurate for multiple
GPUs.

Use the bitmap_mapped flag to skip the retry fault from different pages
of the same range if the range is already mapped on the specific GPU.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index daa996d7039d..0ee5633c8972 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -43,10 +43,6 @@
 
 #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
 
-/* Long enough to ensure no retry fault comes after svm range is restored and
- * page table is updated.
- */
-#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
 #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
 #define dynamic_svm_range_dump(svms) \
 	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
@@ -369,7 +365,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->deferred_list);
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
-	prange->validate_timestamp = 0;
 	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
@@ -1938,8 +1933,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	}
 
 	svm_range_unreserve_bos(ctx);
-	if (!r)
-		prange->validate_timestamp = ktime_get_boottime();
 
 free_ctx:
 	kfree(ctx);
@@ -3214,15 +3207,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	/* skip duplicate vm fault on different pages of same range */
-	if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
-				AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
-		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
-			 svms, prange->start, prange->last);
-		r = 0;
-		goto out_unlock_range;
-	}
-
 	/* __do_munmap removed VMA, return success as we are handling stale
 	 * retry fault.
 	 */
@@ -3248,6 +3232,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
+	/* skip duplicate vm fault on different pages of same granularity range */
+	if (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {
+		pr_debug("svms 0x%p [0x%lx %lx] addr 0x%llx already mapped on gpu %d\n",
+			 svms, prange->start, prange->last, addr, gpuidx);
+		r = 0;
+		goto out_unlock_range;
+	}
+
 	pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 7e165854bc0e..7a12be42cf16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -129,7 +129,6 @@ struct svm_range {
 	uint32_t			actual_loc;
 	uint8_t				granularity;
 	atomic_t			invalid;
-	ktime_t				validate_timestamp;
 	struct mmu_interval_notifier	notifier;
 	struct svm_work_list_item	work_item;
 	struct list_head		deferred_list;
-- 
2.35.1

