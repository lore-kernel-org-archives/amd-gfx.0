Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343DDE71D3F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 14:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B222F10E140;
	Fri, 29 Sep 2023 14:12:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5BA10E140
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 14:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVtNytOm+pte1g62mzRXLSXogw/FkW5Uyk50ingJDmO+zmuPUV/fHbb40HMCdiyhaR1i1JXGEn8RQUiyKuuuAz9j05RbU+/22oZGtd8SvswqEhjvzsEjf9W+x4knTVY2MtDOn5k4jbaBxkFUUOqDrBLfPDksQQIx3DaZt2D7vzW+BzUC9qUW5eA8MY3D5bMtCxsJ7kJ64w1OoVORDZ8ZoxR22Fj6/0MqjHu9ZfhXPj5COvK9mQGcr571ZkAjoZclYnawI5ENS8qXBhr/sZ3eYiGEWFSOqHJZjk+ymVitR2xhj35e2pRyuMeNw0BDQpDRP8XgKi38ydRAKk4tCm2nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDFBEkZYmWSzSD2RUojA9cGVNCtZxjR4DLQpYEgU6Ak=;
 b=KTO0iI26OQRaro0PIHTJ4SDdNaoae9MiD46cNYnIs6iBqbiJ577GpPc8mVRywIbouOYwO/CijARVT935vb5baQdcciN9DMRnY4hjJjaaLyF7KolOYpAuLF/LBZa2awLeb3/j4gJ+1JEFCbmbAdf0DAi+vaZ/J64x7yGcWEvmMDBKDfsMLI5z31tIEaoaXM1EuRgYcoir60JuK9guw9/k5r+nEWJAiD2Ubwzzg9WDLNFjztD67Fy7heO9i5xP9G0oce5kwdSfIXRDHDLEFRoayy+9F+S2FIQe+ZRIzAha3AKIygaH81IFdzQKaPT4UzCpk2GEpo2SFlYkycrsr2owhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDFBEkZYmWSzSD2RUojA9cGVNCtZxjR4DLQpYEgU6Ak=;
 b=WVu4+IL9Qy1JxXjkwkGvxt8dh4j9P3bsPtEj5vhdr/yAcDl3OKq9ryydSPVzaL2CTC5d6G2f5KBqRGagVt/dPfFbHsRIflePJUzTLMUIJ4c1zjvPyXcJXBTISdXg1WcatOtIfCdoVa8Uyey3VlCTSNTK49h5Rwh+MK2Dpin/Doc=
Received: from MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 14:12:15 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::8a) by MN2PR15CA0003.outlook.office365.com
 (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 14:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 14:12:14 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 09:12:14 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Check bitmap_mapped flag to skip retry fault
Date: Fri, 29 Sep 2023 10:11:15 -0400
Message-ID: <20230929141115.10016-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230929141115.10016-1-Philip.Yang@amd.com>
References: <20230929141115.10016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e90e223-4fce-4070-cd8c-08dbc0f614e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvadMXNE4dd1uJtOju6O3OCSjn42KS7cEV4gMh+BfR9/dhUIon1EpptpShduzm8PO9ApSszIIASXU4nJArtO9ARcdvShwnUDzdKAiUQhgBDOTdeDjTUelc7trzEQRjiKIdBlTUtN9PNO7H+Ic3fzaAcHNTawfgWhXTqxDq9uhngRUxm7ReAo9aE2rKmHsopxmnbKWQCflsQV1c8tgE3DckAAHRWMfoSGZ5cehRcr0aCLOObdpRD3J1Pyon1TFj3ShorLGkc0Yv2CmK23cH8iHY3iFOT0O883I7nbhv67Ed8WwKTYpv4bAoB3nlSwuElRNLxFVL+ZLZ8jfZOepdK+4V6ckEn0sOQ5y7hmQMl07o0fwfTMyKfOR612gpIrAu/AoMPksVHE2fEzY9utTyLqdZe5OyoGlIaoyDTPfS4xNZp3GaUI+ZDHcHADJXGDCJxUDd4GlFbWm8Xf80sK4IGEcEqB2auA7knWajhBO3qZBxZ7LBEV10DqrY8v/nEUMpYZZOEJ18JVbWg9RwJL36VhTjGbWVUfTEJIqrMHLQdOj6JduCOR+S20TPQ3i1aWsrg8sPcLh1sPGEUsD/d2HLJpFg8uADguoQxy5cBQs79YJizgoRSnbDjdPsKtA9lnEOi2m3t89G2x30yw3Jb4ecvee0GtfamkFxwXehdkOIkGeYaJppAwLxAOhjuVqP5SMk95lJOlwcgx98fPjQ70uqO092c+BsViIMeDv73grwYyBoKNTlnPyhKM31jF9HNlaoX4GF1m+kLfhc3dvVeP6HlPIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(356005)(40480700001)(7696005)(81166007)(82740400003)(26005)(40460700003)(2616005)(426003)(336012)(16526019)(86362001)(8936002)(8676002)(5660300002)(4326008)(1076003)(2906002)(6916009)(36756003)(70586007)(316002)(54906003)(41300700001)(70206006)(478600001)(47076005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:12:14.7484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e90e223-4fce-4070-cd8c-08dbc0f614e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

Use bitmap_mapped flag to check if range already mapped to the specific
GPU, to skip the retry fault from different page of the same range.

Remove prange validate_timestamp which is not accurate for multiple
GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ac65bf25c685..5e063d902a46 100644
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
@@ -365,7 +361,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->deferred_list);
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
-	prange->validate_timestamp = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -1876,8 +1871,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	}
 
 	svm_range_unreserve_bos(ctx);
-	if (!r)
-		prange->validate_timestamp = ktime_get_boottime();
 
 free_ctx:
 	kfree(ctx);
@@ -3162,15 +3155,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -3196,6 +3180,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
+	/* skip duplicate vm fault on different pages of same range */
+	if (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {
+		pr_debug("svms 0x%p [0x%lx %lx] already restored on gpu %d\n",
+			 svms, prange->start, prange->last, gpuidx);
+		r = 0;
+		goto out_unlock_range;
+	}
+
 	pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
 		 svms, prange->start, prange->last, best_loc,
 		 prange->actual_loc);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 10c92c5e23a7..3afc33a3dd30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -125,7 +125,6 @@ struct svm_range {
 	uint32_t			actual_loc;
 	uint8_t				granularity;
 	atomic_t			invalid;
-	ktime_t				validate_timestamp;
 	struct mmu_interval_notifier	notifier;
 	struct svm_work_list_item	work_item;
 	struct list_head		deferred_list;
-- 
2.35.1

