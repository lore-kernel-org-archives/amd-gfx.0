Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30861606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RcOUFBHh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F9010E458;
	Mon, 16 Nov 2026 21:56:18 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC92B10E458
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 21:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ1KslDdjnw6zdi+VVxOfwHLDXLra3DrYhV5gLyfu5+bOIKk2Xwk3aYX9EJlC+Ny41BSgmL1kgH+VO5QQ5rrL3rJf73qCSKN9E251g1Y/7HQNzhjGICgrakSJueyb71po4+ui6vNk2kai1x3Ea9EyByYXu2NsdBWhGWXYpmNQhUEVJfGc+NKiHVwP98S8eO91MFuOI4Kimw1QKwfZJGelQw5DPoimd97PH9FAnt/nc8c0bok7+pB0yno7dPUK9/HgaaN/cHQlBwYOLKM/V12Rj/dyHY9pgadB8WlAGw2mDLvyfoIZCA0ISNsaH+kGgIFST1/WHMOM7qPf4nzk/OZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35tUa2Xwh9LPYb+/06SFuwvM1WjP2dMnjLR8xuj/zbU=;
 b=tbGSwNTg5XAA9jLR5KvyAlVCdkNEA3NENaCTzand95pZwxLZgxMvPCwL0SLiTTpgVUcif8XG8+BXKE4UNOw74f8gIi8hEH7JSOyoMJodkSPKZaMvmn8gqi2y5kaW3uPDBhc6w4wbtadN2ruwGNMbmoqiayH0p02smXOxoPyPKTa0C0WiOi7KnAg1TZ5DmLbrXQwiMylvZweqB5eSR2sDSdEsIbZx81N8wIgvn7TBuqCm5a4S/2R1SkldBYIr4cXiPp6qyHdf9jIfNgxW5AZx5CaAab5oKkDpphStQqrKaW87iSim/NjQ4tcP1x1+i8abR8rQD4FUktxQdCzt3c/vbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35tUa2Xwh9LPYb+/06SFuwvM1WjP2dMnjLR8xuj/zbU=;
 b=RcOUFBHhuKd921AstZ4PzeVsSwxqliM303usiX4ZYfffOLXkeLPVM0QaCvXrx/JjdbniMgY7H5FwyzNbNcklw2CAX0Vf32pRGxYkabo87VUJ8tkJy1XcYC0DNbl4Y2ppef+fFyjmvevclFuvhw9Acc3afHWb978p1+8OTS6C8EM=
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 21:55:23 +0000
Received: from MWH0EPF000DD30F.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::92) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 21:55:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000DD30F.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 21:55:22 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 15:55:21 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
Date: Mon, 16 Nov 2026 16:55:07 -0500
Message-ID: <20261116215507.148411-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30F:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 11561e02-2178-4cae-6937-08df442c507a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|261009223027099003|56012099006|11063799006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: yvkoRrfnsx+BF8dI/12VxSxKIi3TYxOcVfH2FJH+AP47xCsL/3Jk/M/MRux7EPrVUcQRU/YWCy/pcc5mAB4DxqtvL0oS2wEorKwvXBsMK1kDZNIlyZI4k+jL36f0WeNgOz3lv0M4damt947JsS/ZcrhLUdxigjPr13y6l270M32C0G0scbv1L8ESOib8LFAX3YIwWncXe4jnkrOJndbviKd9P95bToTYx+47syhfysEjZ1PPUKAtUXvBv03hbWfkjFCbKWR7K0l+hwZDbIyoZfy1ieRObrcbqftiRo48Sxq+Rlp6PE9aGiMUWF/gFbrsGy9JE9WyINuZqhPIUt/7j6eKyG5QapP5Fh8B0hs/RXWb0rAnSY+T/K0wQ1Fa/VfhtWbMnN9QxC8G2NO/pJL6YHeGo4oevZbYi1k23Gau0HMioieZJWzGE5UnbU8CzZXBgvMlsR/5w7MyAMie6z4sqMzM/QJHXTly8anpB7hfSjZHph8mGsTVp480dk3DjeP3VdW/b5Um9E0oBMFQYUb1w3GX0AhB8lnxL1HgpNOOyvQFECCLQaeZYtPIc+ZoBxAHIDbXWJctfe+E3jRIyI/sXpJIwaxrqJljySJwAEAjzWhZ9lL2vNm8zPBbYBqjar2D+mbcy2gVO68C//OuwA/b7fqmxtP9GCjNz1yQWG8gKkWEdBV8qi4U2Y6VuGnS5eNgnS6sIH3u2pbJQ8ynJgqXEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h4ltDAp8z4AXK4sEqHDSj0k53Pb+wt0WbKO6A/4/dvmF0TdS1Zn2v18knWbY+NihvykGa6a7WpiTeEuT/0Aps5mPV1emjPIuZbtReet7HB72FlLFP2JQBFDbzGGwUr01XVFAmwWX81BJEFpfo0fZLRtUTxQD/9mDRmwsxu0iYGQn9wlK6rl+lSgFDJmRH9pKSAOzLcdy+2gPEbqNo64imWkYT3K2yBmNqEofWXp51z2PUK3HvMWsrlIkGX13tTHG0/2GR6dhjWejNaamUg2/PGwcNdRAdqcVsjLgoyD7/G5Y6H7JOsmwZXrX88EzXxMq3v9G+tXEuwQeGbc+DeXKVzJp9j86MTfPzkU8k7KpxbtzJwRb8ipaqV7As5NJi9jQCjEjQidP5CaT3Cf3bYmcv8h1rXD43o8ppRJup0n1y19doPXztnZgL3AlM8EaDBKa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 21:55:22.7989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11561e02-2178-4cae-6937-08df442c507a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This feature cannot be properly supported, so disable it both on the
amdgpu side and the amdkfd side.

v2: Remove unreachable loop (thanks Sashiko-bot)

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..d0ede277aa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		gmc->noretry = 1;
 	else
 		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
+
+	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
+	if (gc_ver == IP_VERSION(12, 1, 0)) {
+		if (amdgpu_noretry == 0)
+			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
+		gmc->noretry = 1;
+	}
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f57d0fa2c04..034cc3fd07f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
 {
 	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
 
-	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
-	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
-		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	/* XNACK cannot be enabled for GFX12.1 */
+	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 	return sh_mem_config;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 525989371378..63ba13a60b98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *adev = dqm->dev->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	bool xnack_enabled;
 
 	pdd = qpd_to_pdd(qpd);
 	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 		qpd->sh_mem_ape1_base = 0;
 	}
 
-	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
-			pdd->process->xnack_enabled :
-			!pdd->dev->kfd->noretry;
-
-	if (!xnack_enabled) {
-		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		qpd->vm_cntx_cntl &=
-			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	} else {
-		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
-		qpd->vm_cntx_cntl |=
-			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	}
+	/* XNACK cannot be enabled for gfx12.1 */
+	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	qpd->vm_cntx_cntl &=
+		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
 
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59a..059e22cd7f1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		    KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
 			return false;
 
+		/* XNACK cannot be enabled on GFX12.1 . While dev->kfd->noretry
+		 * should propagate this requirement, adding it explicitly here
+		 * will help cover any possible future reworks
+		 */
+		if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0))
+			return false;
+
 		if (dev->kfd->noretry)
 			return false;
 	}
-- 
2.43.0

