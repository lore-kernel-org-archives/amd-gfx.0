Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ADBC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E866D10ED4A;
	Tue,  7 Jul 2026 13:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0O+Zn3mt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A475710ED80
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMyqH5iBnbLDzkSFeSveJ7Rzb1d2cZzcEB8hHg8j4bPJghr2I4iR6Atd2A82C+9MpHRbB3t9jNFnVPMI6cRYtj2I64VU4H94EHaPQRgPdRxNzMKFDI5b1XXsPKGDlboqzqv0EVMmlMR1dd8rG/mfJLWDJAdWH3j7AlFptDWlMYRRATtyszgao5+Ju8tgf/0r/GWjXSQ1Pxvwryc/iKtiegV89xoGbHFr2ZQYzFAFxmyDKh5xhwRfZjYSR7+uFgp3f9Uuyq79EnY1UmONHq/g0lvSLinXkFl1id/2fZwuYrMeauZFN2+elUii/v+lsewp+Ma7eH47XODtHxjxOyGnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpWs+iOYiS14aVPMRoSsVxKYiZks5Cq8Z+YHDgGoF04=;
 b=fYwhE1xOBXpW6WjYKe7B+hplOqECjrQd/SUv7E/6gPIoNK/hE4INsUDsizA4k/7Xdx3Ua5C/o0uygz8V54G4eh4nqs8KFtOKKSYZVIfeKHabbMjKdM6gSNjrCFenalTnv46M8/rvGxdCGABxMACSuDq0QiwvxM2d6f/3t0blY7f2OhObgB7SQ6JzT4KxJO+imgIlcffMzx3A/fCvitnZjhAxpzpMa3/yWTVcIDquC5rkv2Czg7ShAzoSvyMdZAXUAAWBTmhQkEOzF7Xdty7CUoji4cs9prDdt6Ia12Lj2EuAXz8oj6vM3vIv4dEXDQ910uTu+KH9l+RsxdwzdZ9ByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpWs+iOYiS14aVPMRoSsVxKYiZks5Cq8Z+YHDgGoF04=;
 b=0O+Zn3mthk2754c5Vb3LxE7+pszuNe6b2dczyvsp9j1OZlQ/e7qjEDvV+JXwGF/e7Llo8jEEgD9hwFFwNh9MtTTDIYzPbmZqMj+SrOm2D+sobUqxz9UKive3S0Isd1fxp0ItBIRmpMALTUiG0oVJVleA6KL9H/Se5xMxwFAJYro=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:59:02 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::72) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 13:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:59:02 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:59:00 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: drop debug_enable_ras_aca debug mask flag
Date: Tue, 7 Jul 2026 21:58:46 +0800
Message-ID: <20260707135846.1028199-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf6e11e-0b43-4f69-4dc5-08dedc2fe6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: kXAHK+5moffIYwgz01UYkxXshJGfESZPkD/LR7MYXIjHkXTy1BsDrD7o/grrx/cy5Z1WTHYfBpNb5zEBTp+vNVinyVzUJibkAXSr1ZsQPDjz3X7f+zbWLG40ozFGBVXHbqCTEabuXq3m1/DqgtqSLBVbu0L12q5urpOHjuXj8StODMKb0MMO2s5q4MhCh+iysrQU2W3woYKwjKPWc3YlxV4qKt5L8FzyERMqjKULYcD7YNmHLuiotB+hdgd2IPlhdapE1XGu9uqd/DyDCCSCAaoLFasO3Qv0AuFKyepKOTtC8KELz8aXADEZrr9qGLDhLLFTs1vkke6RaIHeFJgl1hEBEoNd9KZDjcG7o9ZkxDridqZeA9JHQCODQi5woOdEcDDjhEAmiB2ioMULVPvJul6ynknSJwyZaJmkCD5Iej5wq/tHxdo3ratyczj9nga0z0/xJ4EPztKr4lHnncg2Ele1R2z+wtqYpgqP5W/OSocKRhpUrw37F+ma8mi+7jPpP+LWtdAd6uN59Bp3PyCTFTxX8KdZh9Oy+cFeE5z9G4BiBopKLIh14i+GgnSCupK9owwg+ud7it/s+ZMUU62fc2pHya4G4/SH5x9FI1DYce3uoWLkH5eqyy7QHHZFBwrBTB0QHEncll0Y/AEqIroQMaTKNQNUKclbWaQPkxmkAzqVLwvmocITEm49MwPXaSM3cJBbtH3sPTIuKPnriI+ELQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U6/9n0Bat6M96oilDJMCy1NHnlKI90t2CRytcpsaxU4n6cAUN84snKx6zrlDfIpmtdn2MhgTe2F2vbS6rxcVNjRVuHrCV/+d+MfjcjS22tMJK3/Od5DDcuYfmlM69ASb8APjG9sWcJalz36wJ6+jBS9YyoMms6l0LmVagqAh4yFfvxTA8W0vDaZ2wzx/ptcZJnghJNR3sS2ExOluSUxL7G7D0seHY4UuHKI8Uo39qfTIyMnFwXDwUWnpJIHBwUFUhoaOzJIR5vWqsWPTQ646LJZmZ4TisMuHeKmso6KdFjL0LYv6yIZrbUXZ46s4f6eXnC60v49UYh7cyQSDA0ln4Q6gq8QaqcQ9ulRs8xqMipWPH8k9qnAF/4RlXm3P37zeVjikNZQVulUZ05SCcXTefTZhyu7thVJXHF6Ps9aKyEt1tqZ8VhC8p44jIDLTthEx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:59:02.6216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf6e11e-0b43-4f69-4dc5-08dedc2fe6c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

drop debug_enable_ras_aca debug mask flag

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8339ab6f5d32..f5d65bd0ac25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -926,7 +926,6 @@ struct amdgpu_device {
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
-	bool                            debug_enable_ras_aca;
 	bool                            debug_exp_resets;
 	bool                            debug_disable_gpu_ring_reset;
 	bool                            debug_vm_userptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ad631ad31899..5362705143bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -139,7 +139,6 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_LARGEBAR = BIT(1),
 	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
 	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
-	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
 	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
 	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
@@ -2264,11 +2263,6 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		adev->debug_use_vram_fw_buf = true;
 	}
 
-	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_RAS_ACA) {
-		pr_info("debug: enable RAS ACA\n");
-		adev->debug_enable_ras_aca = true;
-	}
-
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_EXP_RESETS) {
 		pr_info("debug: enable experimental reset features\n");
 		adev->debug_exp_resets = true;
-- 
2.34.1

