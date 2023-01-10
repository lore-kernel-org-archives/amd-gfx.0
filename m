Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68038C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 22:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BCD10E0AC;
	Tue, 10 Jan 2023 22:41:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663010E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 22:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmIOEDSu0O1Bzn6oJHOavnxf9ASOLvQkHbwTavTDT+mFX3xwPzh9GPMafY+fdw/+FM00f3hTxhkCw5kNZmngM3yAWbdx4xD37AmEzLWeBM1/upMUgC/T+IuBuZxo/FFRFyv8iuSASQ4bMTTZU8hX/140fO7wWkXw0we6TpY0EMRTHWWn6FCpaf9HZ+aOBvzjdFBrHXaq2cjzNoCnEQCwbzCbqGey75bJRUK2TobKaB5cPEDWl5JY1G8KE8ATakWRdOXSnw4r/aX54ioQGLTf50M6NF9ikQG8a9uJOyn3xqG1aLx23CD7/3bj+ts78sJiGy1dC42L34Cn6NHR/jvLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cziIWxvnVXaFMMCdEgyRCq08jokxDmJ+gLPZGIC2nr8=;
 b=mkgI/Ew+qBsLXGT91NPOSvZyTb7iUkWgUoqzjwX/Ta3ScIFgC0S54AKKnBd/TY/Ss2FQEkij9al58hNnSILYUTGZ0hnBusDiwpvPoBZIStPrFVeofUZH63dy2oK6eNg24LvfBy4UX94gg7dbpGfAy/nBCYBQ5kQGS1GuueFM80ctbqgcAM8tuDrdvq5Mg9grqdI5sjiK2um0fRmT3+K59lA/0gSy+Le6yJiT7l83O6a983kWLEkdJ3fZM1ZsUsIP6eRHCpm53UXni9nHSSawkGBXfNLt27yU5Zi9Vv6EFJDqdhrT8JFukeDizvpA7tMfCbWMBXJvUFlYLrNHvNALiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cziIWxvnVXaFMMCdEgyRCq08jokxDmJ+gLPZGIC2nr8=;
 b=MHZDcCmj0bXfJXG0NRr1OkMBNT/cZYoUH7wfcYp0qe9sKiOo5WJPZ3n65X7997XQyOXaWiI3wOfNwjfLOJeapQSWdlbICTM/ILt8StKf6KxCmroIpayJ96lAJJfXOoWtZ5Gkxe8pGYbfWIFj+jkgzZjcLjD06dmys4vYHX7DVYU=
Received: from BN8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:408:c0::31)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 22:41:53 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::c5) by BN8PR15CA0018.outlook.office365.com
 (2603:10b6:408:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 22:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 22:41:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 16:41:52 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdkfd: Page aligned memory reserve size
Date: Tue, 10 Jan 2023 17:41:38 -0500
Message-ID: <20230110224138.20271-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230110000112.29730-1-Philip.Yang@amd.com>
References: <20230110000112.29730-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 7768411c-765e-4663-e84b-08daf35bdec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocJaBPqTa5lJdE72gTPXHLYTLbv+lpDhuyi+luopEeZyb6HtEeVg5azfBK1RGU9bDSuGlotmkWmPFXcoXDdvRUO5NG6tlgaKE/W3k+k+pM+gn+UFEZlrw1oyfPplajYOLzuzpYl8pqlgeZjf23BLIoKz72NW6G3S9avhfADvIT2o2uR3JyOw0RF7N7X6XutIpcEpHdSwMi9l39KLVQFIVYT3ZwnAt+fAsjAHHnpVbjXEjEdzEWobjyUjPX8obibKpkt13p0ro2QCHml725qEZfKzNVgm8jdwf7u8ibcPsAGzkinqQnHywpgAW0f8fa5WL959jVI4HVMgPJfuIpq81AALjuil4cLFg5UB0Yla/CMrO7VyTWqxtVSSBD2l0h/P2ubPmQ2duhNX3boZynixNjtwDaFpHgZZujJWWaDN6d4eHcWfT02BsP4Lp5xA4Cu8u7yrpqrSHXndDT8QvgfBUC+SRjspu3RsYRUzrDs+T03f0N4xQuVuVUz8DxKQSm3wbXe09DkfOnZoB7bpnNzUCtMbY88aryMu6Y+5Mn8tKvSi7CR8dBNCAp5FNWSl43fi+Yo6WItOiQIS7lOf5AimJF0GA746FsaT42bt90jV1k4v1r5bYkBpbiHVea/B1e3X4UH3W45/nU0bg5TxhlnJqGOxASJ0w7oWvAhTbwARCHuNdbB9Kvv/UyChHd8SBHqQr3wFtUFp/4f2/wUy2aEO25/imTOvycVDNovqnQohZ/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(1076003)(5660300002)(316002)(7696005)(186003)(26005)(478600001)(16526019)(40480700001)(2616005)(70586007)(47076005)(426003)(40460700003)(41300700001)(336012)(54906003)(6916009)(4326008)(70206006)(8676002)(82310400005)(8936002)(86362001)(36756003)(83380400001)(2906002)(6666004)(36860700001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 22:41:53.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7768411c-765e-4663-e84b-08daf35bdec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use page aligned size to reserve memory usage because page aligned TTM
BO size is used to unreserve memory usage, otherwise no page aligned
size causes memory usage accounting unbalanced.

Change vram_used definition type to int64_t to be able to trigger
WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
accounting issue with warning and backtrace.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  9 +++++++--
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fb41869e357a..333780491867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
 
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
-	uint64_t vram_used;
+	int64_t vram_used;
 	uint64_t vram_used_aligned;
 	bool init_complete;
 	struct work_struct reset_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cd5de5e08d2f..6f236ded5f12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1598,6 +1598,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct amdgpu_bo *bo;
 	struct drm_gem_object *gobj = NULL;
 	u32 domain, alloc_domain;
+	uint64_t aligned_size;
 	u64 alloc_flags;
 	int ret;
 
@@ -1653,22 +1654,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	 * the memory.
 	 */
 	if ((*mem)->aql_queue)
-		size = size >> 1;
+		size >>= 1;
+	aligned_size = PAGE_ALIGN(size);
 
 	(*mem)->alloc_flags = flags;
 
 	amdgpu_sync_create(&(*mem)->sync);
 
-	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
+	ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
 	if (ret) {
 		pr_debug("Insufficient memory\n");
 		goto err_reserve_limit;
 	}
 
 	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s\n",
-			va, size, domain_string(alloc_domain));
+			va, (*mem)->aql_queue ? size << 1 : size, domain_string(alloc_domain));
 
-	ret = amdgpu_gem_object_create(adev, size, 1, alloc_domain, alloc_flags,
+	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
 				       bo_type, NULL, &gobj);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
@@ -1725,7 +1727,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6d291aa6386b..f79b8e964140 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1127,8 +1127,13 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	}
 
 	/* Update the VRAM usage count */
-	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+		uint64_t size = args->size;
+
+		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
+			size >>= 1;
+		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
+	}
 
 	mutex_unlock(&p->mutex);
 
-- 
2.35.1

