Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB187CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 14:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E38E10E4FF;
	Thu, 19 Oct 2023 14:25:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED4410E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 14:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgUTG2LgTGnhDd/wMfl0SCImuxVbPuKy3UZkdBmthZENeIS7k/pZF5yotkfERyJQw2A23t8+QFdaB0puTuTD89uls2mx93tMIJwuhm9KY/5jyej6k08YcLwWdPDNJg1U5/7wdwO3rWgROi/aohh5SlFjXeelGV2zpijFJK7x4NhJ004QzqGZtcqANavKNNTiIuahhNB+atFdtn9gh44piWIc1BCFzcnH8O4lR5RCFQQdE4cP/gmWP7bOgbjnfbywtmA1+MvivlrQUYQEUELAAY3c7agdsC/Lcc3a+y112zPdxI2iMydjgrxtIpzwwAyXN68MWFGasExrFPzAymCrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIa+2amgFA4Bi9JtHUY5kG9iAl3B1+DzpPSMYnlfn38=;
 b=g3dh8Nshi0+dBhbKalb0FIRLibRkJpYS1U3oucwfbvJNBEhVj2vsujr7oGHw0vZ/NdDyztE2g0DxsiHQWopjnVYJ840Mjtl5ggsVF7rWUm/4wlPsG73wNoA+McgrnpYax6XrL2d2JntjiwkBHmfqXLZtdAVr/UOPBsSlRhS0m2wHtWdqeuZa0wkqwRk7pZ49TO1JFwXCW5XzScRD7l+oX6JeK+aLug13PcHPDRbhr1ThdRLS6mmXN8p6qlE/ok3AHRUwjWJKPIMQ8URanprG9V2NJzjXWulKhf3gvT8riu736qgFM7vTmJjdu/P0o6l7Gc1ygH8DybeaMZiNZkldlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIa+2amgFA4Bi9JtHUY5kG9iAl3B1+DzpPSMYnlfn38=;
 b=VzsDTufBwIfOatA4n63jRsw89Fz4surOLBMCDmPI/XnIOHmQwRd0zSJnHhhAXVzhBkvXmsDoATN45Eq7+oDXTiaN5tUHkpOUrPWwPmoYAHY+e9QB/tJcd3y6s5upE1A8mlFWBX0zQOZRsRolmEcauRg16Ey06RowHTMP6FO9liM=
Received: from PR0P264CA0163.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::31)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 14:25:40 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:100:1b:cafe::89) by PR0P264CA0163.outlook.office365.com
 (2603:10a6:100:1b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 14:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 14:25:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:25:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:25:11 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Thu, 19 Oct 2023 09:25:05 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use partial mapping in GPU page fault recovery
Date: Thu, 19 Oct 2023 09:24:41 -0500
Message-ID: <20231019142441.622430-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b85cf9-7706-4966-afea-08dbd0af442f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un2xDSYpIoFlFxUwxogolJ9ISBUcXkOhFb5Ix1hZKufuHv7Ezg2pOPISB2LB5fliVy+RwIpoAQvHUY9F4T1Z2KwYTfgRm6WXfu2CMuYfLQtBoqHkPv5KCpOTG3syGuofGMH1m0mK1DE664e9EdGgDX/+/5OH0Zy+X6ITEJyLontH2RfPY5gkLsKQzwKWPlGF/u1WkIVcHC0prCKfnbSb9gWlsQohWs+UY4vKwjGjM2WTBdzgtmfWBYtd3nRFt3lfdqvn6lxUV4tuTI2eQAMwpjX8aRyKzxmTVe3jpEhlLvUC0sgT70bq4vmkVan1Ch4I+MjJbvgWLH3JJx5rrVljCvUuEk7SFu0zSni2kyLL90HDmVCV4hzJfF8Hzr3zuhIBN1n5Pf2joD2Lu8316nZLq/uarBmWdbmntzaY1Xg2TQBQZ2BF1O6EPVDarecX/81IKvOXunVDrdOw7+QvxqtVVOUEhVBHfbyJ3eX7uKPLkEEMiwcK11DkbBAwoVeMjdHxNInAgLhWwtudUKFL56iRWVIcYGw6VtgtqxiCwMLGP2Aa9eCFfGtH+sDf1p2wZgdJRajRo16PyHQ+Dkbu66VfecnUcdiw4f7akYtS2kh5tVFp9J4kcB9BtN+k8djTJdEnU2S1lk3M4H7mx4YC6RByM7eL2qvTPwBgjUJx7b8d7cw20XKI8b6gM9tlP3//7SJuJx2K6IIEkNLAF4GDj1hVbcUgXFJi0kS9dvVxN3OGUru2zTg++x697hzgBJks6g1TKPKF+sGau8umucjqo97M7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(40460700003)(54906003)(6916009)(86362001)(81166007)(82740400003)(356005)(426003)(316002)(478600001)(336012)(83380400001)(8936002)(26005)(1076003)(2616005)(6666004)(70586007)(70206006)(41300700001)(47076005)(36860700001)(2906002)(8676002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:25:38.3637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b85cf9-7706-4966-afea-08dbd0af442f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

After partial migration to recover GPU page fault this patch does GPU vm
space mapping for same page range that got migrated instead of mapping all
pages of svm range in which the page fault happened.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 33 +++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..81dbcc8a4ccc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
+				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
@@ -1630,6 +1631,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	int32_t idx;
 	int r = 0;
 
+	if (map_start < prange->start || map_last > prange->last) {
+		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
+				 map_start, map_last, prange->start, prange->last);
+		return -EFAULT;
+	}
+
 	ctx = kzalloc(sizeof(struct svm_validate_context), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -1747,9 +1754,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r)
-			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx->bitmap, wait, flush_tlb);
+		if (!r) {
+			map_start = max(map_start, prange->start + offset);
+			map_last = min(map_last, prange->start + offset + npages);
+			if (map_start <= map_last) {
+				offset = map_start - prange->start;
+				npages = map_last - map_start + 1;
+				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+							  ctx->bitmap, wait, flush_tlb);
+			}
+		}
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1855,8 +1869,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&prange->migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3069,6 +3083,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
+	start = prange->start;
+	last = prange->last;
 	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
 		/* Align migration range start and size to granularity size */
@@ -3102,10 +3118,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
+				       false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
-			 r, svms, prange->start, prange->last);
+			 r, svms, start, last);
 
 	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
 				     migration);
@@ -3650,7 +3667,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange, MAX_GPU_INSTANCE,
 					       true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
-- 
2.25.1

