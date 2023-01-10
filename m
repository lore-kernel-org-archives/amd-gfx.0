Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0852CC54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 20:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5668F10E665;
	Tue, 10 Jan 2023 20:45:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 912B510E493
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 20:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kanekapCfWshzOx8hOn5DgXgmnDc09P6X4zV2DQ35qPiXVpSM8IPzuRqt4drt/1jRL7H2Pu791prKZFlBngEfE2YUgpPhqzeTW95EN82TnK4E8q0vrtLzNQvCDuXncMAyH5G0CqnApLJcqWBBxUbvNPljulMfsQrii1pmVL11AGvFiBwKHC4A0HDawubSrYwV8k+4Z1as3/O0OVE4SzCW/jHDMIiC8hQWSOboVuUjX2GU0J0U4PcmzD9LmzT3ZCEuqHxfbcEbjNVh5y4C1OwsIWccnxvECYrd6rxq2Oc48d8Lz0Gy2DmStKZUz7A2xWtwaJPP861r1RB98EPNf8lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0mTi75chIyEhNXh3FgieMkW4Mln4o8dydNKG1cZmWY=;
 b=VOLErCXbqyHC4nHNU6DPVPLy3B5aVrIYkOEH/6ZZ2jIbKnfrF2CUIWFRH00QpSg4wia2bax3RZ9iC1DNcFldOFgqKBNrmoVBBX55u/t7/jcd6+ougnBBOvAltFOUBLGQYgD8t8NeIuW5L2WabB39gMCTMm5QureFAgJhMH17bqOh8ruOAzRs5+Lfp2AWX8K2Pd+4Dot7gEkB8FslL/pex9bu4ewpdYrO8gjx4+7t75QyD2kBJ+nrJBkqQCOPqqUGy7BhZEiI/XeCn4ncUoejX+9lpxHAifW6qR3hHFXDJjhQ5LrIdoPDpUBaWE8noyGI5VuV5/DI2A3xfo8NCmyymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0mTi75chIyEhNXh3FgieMkW4Mln4o8dydNKG1cZmWY=;
 b=YN6fwSIk8DbbbnPYI6KYwzSaWgsNEX6BMx8WHsPDxMegJSSndq1K3asJxYeItwpON2SiDUsdMPp/SjPxDlPmYRki4HAmDC8Of7rP604tfiE4d1dBbMuPQ8WLERQejvqu1FURvHUU51ZOujjzao+U59wfjpuDZ59ACCqUSE3S1Hg=
Received: from DS7PR03CA0359.namprd03.prod.outlook.com (2603:10b6:8:55::35) by
 BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 20:45:10 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::7a) by DS7PR03CA0359.outlook.office365.com
 (2603:10b6:8:55::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 20:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 20:45:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 14:45:08 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Page aligned memory reserve size
Date: Tue, 10 Jan 2023 15:44:47 -0500
Message-ID: <20230110204447.18105-1-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f48a16-ae5c-4304-3c87-08daf34b9085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4o72YPji/XTPGpNQPl1RRSgvgC+DNArx7IsllK4JRzysu4tqPTcB+kIrLtjQBHXe5ZXKQ1dB44vO0TjfSoAgtIlTEmaSXELbg46cbexZvQyIZu+HSuHg43/0BBEUcYVLVMvY05u92hC6eGMI3be81PPJB7wvg5h2cJzpdWftoRao1YIJDJ4L2g/6hnUJhKsOyRGdQ3OF23GzhiPcvxVS2No956aWUBoEGe/cVMImCmphP4Yu1K4D7AtlsQUij7w8DYkgQHrGsu1I6ZiP5W39xs4yAoj8ipXaGRwreeYF4NBdxesAd17JJdriJ5oYZ7wXILZBWKtQ2HwvB9xbwzRTVNGWY1ZzmbBHikW8ghB1p1eXF6SQN7Y2R+Vsgk2REXknzNR5MMEEFm5wj3ELz2p2EIMxdiDDyREXDOTLWsClhZoDENAxxb6LHGQd28iAgEMyHl9vVkUGMXRI2AVRhcIq43TR93u2j2TKhiP+S9zBfZ1aaJmqT/0wjhYu828RwuP655Eh9ryAdnNLPWXP5t6v4u4zwrsgnkiZYVVu71pyAEtqH+Qg81HWguZQ8We9R5SaVENmxNYhwY6tEnp9ss8hWLp/AYAZo9EYPVAVr094m7+/y1PGDX53snPvnzH0qG1xYUuCa2Inr1fr1W4epabSwUD7R6i+Y8yxClcGwrRPBeTIP/8vMAACjwnRmcxJEKwMR77e8edSDraGDacanSMiMyKXDP76AqAnUfLt7OCGkug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(2906002)(356005)(81166007)(8936002)(82310400005)(5660300002)(82740400003)(41300700001)(83380400001)(36860700001)(426003)(47076005)(54906003)(70206006)(70586007)(7696005)(86362001)(6666004)(8676002)(1076003)(40480700001)(186003)(40460700003)(478600001)(316002)(4326008)(26005)(336012)(2616005)(6916009)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 20:45:09.8312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f48a16-ae5c-4304-3c87-08daf34b9085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 9 +++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

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
index cd5de5e08d2f..08e2c1dc92d5 100644
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

