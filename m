Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E77606A331
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JCtBMFG4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC86410E0AB;
	Wed, 18 Nov 2026 17:43:03 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D82110E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 17:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJOMFFEaDhdKRezbjMyk08jXXRjqAPstOJQKfH/Ojfzw2DFJq464vzfb21K0C+7soeX0AxFQ8J0mwid51D155iY+pRrYBFGtBJZPF/RXm/iOgamrjLwXYIvakCwu++azhgagNaJXDP08ed3dMSe39u3UkXZ7Y8bzndYNhxeeyv5kfBdXdrLrOYGautZQwzFoYX/Nw5JJLBllkIJORSOJPhjd8iPGnx6FYB9/Yt32VonAimyWactvkbCFd7/bZumCnICqdAEOI2RyTjIleB1jzWxtMU6aVm2R1wp9cfwr9H2Mx8Z0OwiPTxV36hjuJg+PSvS9YyTA8kN0G4BRXjcYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsxot7F/Od7Foc4gJE+dFRQVIii5vdzAwvu7o6v0M5o=;
 b=t6z9eKW9QplNFO7vaUyaqN4VOR7y2TRE16bH1U1psmQxcyDrJ1HPZBvZNXk5ZbO92J5p84vjnIcJ7Rby+097o52WD5RUojCF6vihSaCP68XzV60NfJ+wNqSNe2/3DRr5rNTM9Bkka8lDyzz5Mmh6YMxcHu3eTX/7WNzz2qsMT4DPotjlNgW99Uc2dvekXPLdZSf9O1qDfnHTmh4OIZBInHOo9+hnCh0UZR49+D7v3U0tE2GCKw0W9gMvLst9BHOAiQpTyOVB4eLxRrPMxptHdbPC4bFQqNXT0Ep5YWG/nK9TFc5gaccxM63nW2NwjPKvSRLPIUmtNctR03WYg36YvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsxot7F/Od7Foc4gJE+dFRQVIii5vdzAwvu7o6v0M5o=;
 b=JCtBMFG48getvskP0sQGVc5+MIfr64RNnqxCYYtG11e+8ytw++iVh3bpf4Yu26tv4krMuYwB6T4xCNh8uSJheaJYAWkyrh/zvjhfSS2FRLFT3aDfaZuTEjvr7j+xN+i+yahUeJ/hekfiPHg2LKfHj2j21x2flgh5cp8xhiIrfgU=
Received: from CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:42:50 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::9a) by CH2PR17CA0029.outlook.office365.com
 (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 17:42:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 17:42:49 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:42:49 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, <philip.yang@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH v3] drm/amdgpu: Disable XNACK retry on GFX12.1
Date: Wed, 18 Nov 2026 12:42:38 -0500
Message-ID: <20261118174238.159765-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e938ab-e550-46b3-d819-08df459b5d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261021123027099003|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dh4cncu2zh27EZy/gC9LAfs2Kxy4+O4B82+GNRE093umfpK4qJBwdZTdZ3+zCfT8mkzEGaQGZJEU31fthvuM+n19kSWCnoQjgKTghwRvJsEuI8oj0ZX5+9f09Bt0l9utirKmuISfpqt04veggu9qZmuXsgDCqyJq6KUWMv7TLyqZWw9/PEOWCS0jBthkHjdQzoFNAKc4efLCkm4yztxOXLgTDA6W1bKU2ei9uTQaHJSBpARPs5A+OII23FHB0S66r6BM81/+/ChISyJcLB/3m9nlDKglENTqCUEOzeZlOpAGeEWZr71PXbOPdcA2QljJ8qQ3aPzTehfIR9LsKIPOrvxFBQMt4iMutxNB4kaEJY/tYG9m3/0AcY6qWNv5jJPkqJ+AKMTEA1xOxI3T/Z/5NwIFnZRZcaxjCU6E0R1NMY3mMkDbrEUGmbYL7og9KkgfD1qS0ZZlrLNWqsMsisYQm729sVGcP3PfcrojvPQ05eqVs+ZXaecvhLfWqR06f7wRmmVz1hWloTG3+suN4eZclGBan3v1UNJjxsvTPbnVFgHmKyvqG/ncEEDBomG5HJTEi6UqLJ09jm75uGOBHkRQQzkbn5oaoqs6hT2h3kckzrEFr+rtk6mp741QxJEG5SWAfo5oXGhCAyOu0fenyRhstorwYEDRZDHCHIvbxMKqu7DtCuvijYyK91dJpV7v/tcXyE8yzDa0SbTWoAETn9n+4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261021123027099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AV7YpSwOfsn7E19XlqTrKYP/znK7deTGAstl6j6LhsHEqxzzFVlO1VIou/iD0oeRqnr8SGBMJlAbFpjYfxVvAoF58/ML8QNQ8VasdNJ9cY2G+PkhEHYrzZhupmejjloyZQ7KJO0gQ115UCYKpScMKZzZsDxwv+PovwytGjoCxdQgQcjEf0Y8YKHVztRFQ18pju0vgcTbD57Xhu8YoBH+EUvkLbA8yStA2+2CebRuEQSLM6fFgTNUvfvqjHiDCnVrdBLafv9Gm8gcp0glGNrzSCrDjTVJUHCYRrTLo06nUaiMTxjDWqHVUBzLVXOeK5bCfmLs/aHwJISuTaUEZc6sKInya2Ek0qDbZAVkYwgKEj6v3FR13Rqfz6bUlW0Fjiom3DLVAZzW8E3ZO2QtawbjEUrPRWAo1+WHNmONMmcxiBjVVpsF7P7uG5auGjhWjCe/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:42:49.7122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e938ab-e550-46b3-d819-08df459b5d4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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
v3: Remove unneeded extra check (thanks Mukul/Philip)

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 3 files changed, 13 insertions(+), 17 deletions(-)

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
index 56439c9f8e17..b2fce8c133d4 100644
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
 
-- 
2.43.0

