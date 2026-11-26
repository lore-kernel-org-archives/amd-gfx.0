Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDB606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c+uJ2GP+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222CC10FC10;
	Thu, 26 Nov 2026 07:32:53 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCC810E197
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 07:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJwLZiI+sjeXUr9c2PQv05Sk/wCtFOD6WeOybbu0QjAWOV33bpxYgjZmAAbMLK7Zrfx50+Zn3grvXrFTFeA5/sD1yyG+JCWigbh5B4EBWF96dtZSNn2nv+GooOWRbpIW4dO63XsPvRwaJzjUyXGWPVV+etrGNq2TlIPCfSSeoK9jQZfQrNyj3YXoEaDLdCgcpdSYo609uTNc8jHH/Y3fqmrGWciVtMtHqudX0DNKTI5t9lZlzIS01PdPRCTp4iL4IoGVoe9SU2nzxZkmYpVRr+r3EeP1Hu7VjnRTNGGbhLAFt75MyFilMinZc+6tzY0fDCkJFCe09O/wLdjGiT6h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfKq4Wr4ZFiH1kMWepK+B7DJR0y8vmi2b//hACk286Y=;
 b=y7XAB+77bJvo3rdffbbsdc3JUqUSAosvcTpqh1Hdl58VPq3+46sbECHxF24hBM8grrQXvwwoxEFfh3rt+593Ja2VLPCPGhisrlM06KI4rytw1+KbY9oPkpryiOqs5P5xHUcENF5GaF5vhAVk570fKsJzEDVPw51lfd+qTe0nTm0Oi0JhqutyVQu7Zk4Zukco0DXxo/5nfIwCPVuwisyP3zE3PUEmmt5Y/sJjoxzqjM72NSRZR4HQxWbHHK04od4Dkke8azRMqFtREeCBWbSluDqeZi3CIWZK4OykJyJ51MZwfni0gVFqS7olA3V7dPzi998sUcwy92v2i+ng+9YckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfKq4Wr4ZFiH1kMWepK+B7DJR0y8vmi2b//hACk286Y=;
 b=c+uJ2GP+prJu7nGB+AIukQhBLMs5joyPHwDHW6JucN8aV7Gl4KDmgzNkvbr3vVU8jiJtf4PbmDdHw50BTbsHFq8JtaQtSUcHnu7Q4BnZxtRuNn8cg2AJn9fXP83jSG25I29CSfismqSM57/FxTStPTdo/L2X7WJ72GuYHCg8esg=
Received: from PH7P220CA0176.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::29)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Thu, 26 Nov
 2026 07:32:42 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::22) by PH7P220CA0176.outlook.office365.com
 (2603:10b6:510:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 07:32:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 07:32:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 01:32:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 01:32:40 -0600
Received: from dev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 01:32:38 -0600
From: Bob Zhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Mukul.Joshi@amd.com>, <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>
CC: Bob Zhou <bobzhou2@amd.com>
Subject: [PATCH] drm/amdgpu: keep the address of cleared PDEs with translate
 further
Date: Thu, 26 Nov 2026 15:32:32 +0800
Message-ID: <20261126073232.2108102-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bd9838-4d9b-408d-779a-08df4b8f7491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: WEP1m5BhsvQsOwClPizU0KHYmEbFr1g0/igBkoWWDyNjQ9kSiBFmmm5RW6fJ0Gfj6e/x8V5nWWDrJAU520JvA7PFpP/DQZq4XxJaQClj6k2qZ56vVIKni+jtx1Zu/pNpMbXMcoWKG+E0o9qR3acDHIopgQmtf8LEwhJXNg2o+mIktYlcGCSwzIh3dD9GlizXt++MJV9X6ZyZfLLUB9H434InCoQZdKip9KR+y18K/fkMYlZPa9mMnIBjNvxhxJnJDq4xr31tjEkKY8nHj7Arr3ZqqI3pi7VCp2ZPRW8kqEnVfjtUKAFd5oNA8c+sWte0SJtuxIYcQIUPBOIl1WEGHzb/D19JimGCdqcQORhAHjOSq/IMf1SM2doWvrIT5tfVBB6Og2vLX5ZELM1Aj/jFUC19BP1WMuGNrEFzFVVJopaU0DEzpWCSCNUTtD+hXMYNeOWxcaB0QQvEfwyQES9kJxkVIRFoncp5DSnqstG0tLWCiWAkwSITNUOeymZCve2eb5OxCc5YUPy+XFVTFbPiv5mBpbUU3SyoLxNhbPf/Dx89HG4zEjFG4yMXmBqTHuIOVmXN0V1azWBreRylEXPlwn+6nrowZ9TnLl9CLVitjFdCPppMHr1KQ4WCSC6lulLvio9SplVF5RpS2QxMX1L2wU183X7TlT28J9jdYJBC3FhB6OBskYcXHvS0t5MGgWncpMXBrbonl6K0NPEOLvxnHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9nM2qLLigtmrsndf+qmQWILITRbPFOxfU2oL7hKBe0Wyy+yyGlShpwdMe6Ri0JIbP4qHPEGC7u1kiyYyYd0x046wDArMasM8tPUSncxOed+mfsMXMuFEbJOX2rzCvVkvFEVAiasTnGa8Y86MLylZ8OHp/7KCycIp3jRcDGu2WcneeoiYt00jmct7xMdU0lSbcoM2/kfVzTwInZm9rkbwBF1FjjFeEUEbEszFdMm9yQQ/UKDmLFWW43HdYEFoXeW3Fs163ln9AjEkTKloDS9NopK0qb39qMaSh38s/0CKtmYct83N2aqNF632NnXeAR265kXDcx83BYBLqBUlihJ6k6Yhr5B68Jk8cAVAdXYr4qHLFBe4sH7/Y+ZLRe8gN3eyUKi9Toc0NketOFWto37HhG1OS8ZJdid0jn7PQ4bq1WrTj/M0t7SNY1bQlrl+1qbL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:32:41.6733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bd9838-4d9b-408d-779a-08df4b8f7491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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

Commit 37a0bad677a7 ("drm/amdgpu: Update PTE flags with TF enabled")
made gmc_v9_0_get_vm_pde() set bit 12 in the address of an invalid PDB0
entry, because with translate further consecutive invalid entries which
read as 0 are considered a fault.

amdgpu_vm_pt_clear_flags() drops that address and amdgpu_vm_pt_clear()
writes 0 instead.Hand the address back to the caller and write it again.

Fixes: 6250a8342784 ("drm/amdgpu: fix cleared PDE/PTE flag generation")
Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a6d389c08524f..6aabd9f5291c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -349,7 +349,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
 /* Return the flags used for cleared PDEs/PTES */
 static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
 					struct amdgpu_vm *vm,
-					unsigned int level)
+					unsigned int level, uint64_t *addr)
 {
 	uint64_t flags;
 
@@ -357,12 +357,10 @@ static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
 		return 0;
 
 	if (level != AMDGPU_VM_PTB) {
-		uint64_t value = 0;
-
 		flags = AMDGPU_PDE_PTE_FLAG(adev);
 		if (vm->is_npa)
 			flags |= adev->gmc.noretry_flags;
-		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
+		amdgpu_gmc_get_vm_pde(adev, level, addr, &flags);
 	} else if (vm->is_npa) {
 		flags = adev->gmc.noretry_flags;
 	} else {
@@ -395,7 +393,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *ancestor = &vmbo->bo;
 	struct amdgpu_bo *bo = &vmbo->bo;
 	unsigned int entries;
-	uint64_t flags;
+	uint64_t value = 0, flags;
 	int r, idx;
 
 	/* Figure out our place in the hierarchy */
@@ -430,8 +428,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
-	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
+	flags = amdgpu_vm_pt_clear_flags(adev, vm, level, &value);
+	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, value,
+				     flags);
 	if (r)
 		goto exit;
 
@@ -724,7 +723,8 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 
 	} else if (!(flags & AMDGPU_PTE_VALID) &&
 		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
-		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level);
+		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level,
+						  &addr);
 	}
 
 	/*
-- 
2.34.1

