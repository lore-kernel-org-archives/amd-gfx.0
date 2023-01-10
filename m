Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11705C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 17:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8063310E62A;
	Tue, 10 Jan 2023 17:11:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DD210E62A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 17:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M21m//Q1LTobW4gunKpB5WfZ2Z31LHODNB4fwglre9gXQvyalUd6m2Nc2HNQwyy1LQmHxvr1YMOCO87lSJt6MyCtd2Ef+QU8guEAOWs+gwz6KpS+dXpNklS55bvElaCFQmUykMNFwMmQZw+LXAGFqhXj6R6cowKwZLgPh18tafKLjWptNh8ksOH3/7g75N1w0wVrU761Bd4juaBjADV/5+aVDNy1xul56+t++08B0Eg7iNeLEe7fWf4+O7unQctT51u+XOzNIFntoIoe113vAfDE1nP//qSvOJqMFIOyhNUFI2on7vmi7IB7hAOONvrLxceknJd4p5jpVsOneSEpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ+rWlmYHrbIXIySr8XIcd+7GPPcnURKP2ddN4SnLWA=;
 b=ApZTNMQZc95aE+MD6M9WP81YRoT/0qcd5DwImFiS4YNI2udvbR5vxwvVSGuCGTMCWxOkDD0xyhdpdOeJSyvX5OT7EBTWHUDt2rRSz2kGab1Kn5Z9mcwrNckt0wEcSRdgy9cu/2/jOR6XcVOSdIfkTFFIFFtS6UajyePHlEosGB4GC5/uxpoXa/9KnfPF1oL8Bk9qdqxij6adRg5V6sUliyiLIWuUFelVUaEY/iCbCoOlsV6JM7ZwKFOcy6+ovaXXy760aQh9KEujDSGdlVKhC32NlfUO3UDxBZFVdJRtvakKn8Aj45CTkZPQE+hJdwLs06+rcFlBxCETIZ+YzwATtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ+rWlmYHrbIXIySr8XIcd+7GPPcnURKP2ddN4SnLWA=;
 b=LIPob+REl+WnSZsNNj2wY4CRYC5D8RjuMQHFOqijpdHsp8C1FHQVywQv0t1budKRK6GAyNPIGEkDqfnH5EFuE2dnt+kwX2SnkTiXZylgOxNZ246lXKuICSiuks2tUcsw9YL6W4pGSQoa4ACYhcxeJoR5QwKRJPDlWG74hIT8K8M=
Received: from DM6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:5:80::38) by
 SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 17:11:52 +0000
Received: from DS1PEPF0000E650.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::1b) by DM6PR08CA0025.outlook.office365.com
 (2603:10b6:5:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 17:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E650.mail.protection.outlook.com (10.167.18.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 17:11:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 11:11:49 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Page aligned memory reserve size
Date: Tue, 10 Jan 2023 12:11:22 -0500
Message-ID: <20230110171122.10380-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230110000112.29730-1-Philip.Yang@amd.com>
References: <20230110000112.29730-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E650:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab0b55e-598e-494f-e06f-08daf32dc494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/BaXqWL75UGSMAsU2/QVDWA1bqqDbfeXKJUgH41pKMv7oRe1uHXDbAOy/4GNuRhLEYfO9rrmRWgJg0X1+wtiBs710n08LOiGsGoB0ZeGwiYRjBbvrTweeNaRpUg+TZ4wqVkko9hqElMNTmfQcQpheNiCqXraZBuYPX37Ya21fcG4Bs4WtRin+ERVDEJAFfBTHq95DqQu/fvtlRj5cctzeDhyq/MmmEYbvsPZdYKMe//660sQQYPGf1V/lfacNBmQ6YOvNxLmCIEAqOBCeHob+ANZA+22IsOgi7ELPY6PR+IIU4CvfDMHMcJYPQ/Ph29UWNKHHn7lxqtQyctg3D1AhKdjwMmidr/CaGSSCGp+OWG8Fh86NKPOxd493Lfn5V0h3HWUEZoAV/b0+tnGvK8Bzjv2XVRN6Ew5XPeKygWGR6uCkIjHJvkIyXaQH1iBmuKUQBH140bbGX408HJk9TVh4j0HN8tDqvboYlyEILmHZYDWL080qOOKon3Ogzsyb+myZjieE+cvLMXD1CyYfBiG/u1VLBjMHWOnCwvznIzb5QIkmBpKYhUsORdnSN3lIEUgNGvnoOiknzuexGHWTg4iw2j4t6BFC1hpHD/OYc+dv5GqZh+3P95sRty0t9lgOdr8YDCYFeRrWcEwOaqJuEX4tU45oqGmWceu/0+7vhil9930wE+na4Bxp3JE2YqzoT5vBxiAD6DAA+e0b411aFfS0nymY4KUBCp9OSHRFjbYCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(2906002)(6666004)(81166007)(356005)(2616005)(1076003)(26005)(7696005)(186003)(16526019)(40480700001)(478600001)(316002)(5660300002)(82310400005)(8936002)(83380400001)(36756003)(86362001)(47076005)(426003)(40460700003)(41300700001)(70586007)(4326008)(8676002)(70206006)(336012)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 17:11:52.2734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab0b55e-598e-494f-e06f-08daf32dc494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E650.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
accouting issue with warning and backtrace.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 7 +++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

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
index 2a118669d0e3..7efee672bc41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1598,6 +1598,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct amdgpu_bo *bo;
 	struct drm_gem_object *gobj = NULL;
 	u32 domain, alloc_domain;
+	uint64_t aligned_size;
 	u64 alloc_flags;
 	int ret;
 
@@ -1653,13 +1654,15 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	 * the memory.
 	 */
 	if ((*mem)->aql_queue)
-		size = size >> 1;
+		size >>= 1;
+
+	aligned_size = PAGE_ALIGN(size);
 
 	(*mem)->alloc_flags = flags;
 
 	amdgpu_sync_create(&(*mem)->sync);
 
-	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
+	ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
 	if (ret) {
 		pr_debug("Insufficient memory\n");
 		goto err_reserve_limit;
@@ -1725,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6d291aa6386b..e11451100a20 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1127,8 +1127,11 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	}
 
 	/* Update the VRAM usage count */
-	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
+			args->size >>= 1;
+		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(args->size));
+	}
 
 	mutex_unlock(&p->mutex);
 
-- 
2.35.1

