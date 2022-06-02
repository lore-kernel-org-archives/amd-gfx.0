Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F02610EE40;
	Thu,  2 Jun 2022 16:12:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F7110EE40
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKKpOTTGkadUvjEGv+BsIXgKpYiOP8WW8dmx9CAvE/ENIu21/feRJLw3a3T3k0Lf8PIXErvIn5OiVmgFxPKMoHhelGZKCD5iKQRLhTIG/0tb02g3qN9JMe8i5s5/TdPIvprf14pne9MLtWH8jedUN4osoD1nl8jqM22zygbEz7DtilUS5AtAWuPoFJ/NVW1sNG5Zdsr3PWd6aF80VQr/fZaDtV61kNERBReFD6MuxDI15wjlOuEAqaVp3fjtwhksU/oRwU+fKpdHiAVoXqST+7dwtQGKriYp9vD/xeoMU7z2lL+pEjG1SzYCDwpFexGRG/8FElTQy5+/VYMW8WYZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyudwVzm1ez52ddaRgDlBDyTs0BOlIOF7/34rfuO+Ug=;
 b=QvXeSxJbjgmMycXghha674ifwXRR7LTVqj1MKUwJ2wDD0YPsvaMBVNnFNZqBdM3oZVrgsDapL4sc4oJ/BhQUNh09jMebYisHKUsuIMnIjBXdVtEDvsXpdj+Z6d81f/1kVVXkNAX7I1sZVaTJ9Foo+12q2kILysT1UWjYUygvA7l/7XQMRAwKDFYo6iTyiaGpwqwdDJ3SZreGFOT/ILib6eJBMeitbp84A1Xlw+gAtJGVwr7RtMYRwCoHUymMBJidF7y1grOR10SFWF47mDtLRmaGE3KdMqZm6H33l8mMxTfPT81mbtFvd9JW3AmbIaujWmZh92NlbhIsiCw2P9ghYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyudwVzm1ez52ddaRgDlBDyTs0BOlIOF7/34rfuO+Ug=;
 b=Wv1WHCJ0Hs85yKM7VW3wHQXeiVqG9vHvUMYxUa19lvIgAMvjF5cW6jUy979e5mcpuLg/QOCJQXtJqBlpkTtSRwBHXW881S/cUxlgnFVVPLlPeERYFms62ZIwA53FDx2y0CK+chvHPWs+4Bm66Y27NI/fMQV0n43/ZtAxGNXA52s=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 16:12:24 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::ee) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 16:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:12:24 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 11:12:23 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: use VRAM|GTT for a bunch of kernel allocations
Date: Thu, 2 Jun 2022 12:12:08 -0400
Message-ID: <20220602161210.19380-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <20220602161210.19380-1-luben.tuikov@amd.com>
References: <20220602161210.19380-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ae24282-cebf-4f6a-de5f-08da44b2ae0f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB491070B1DE36066768E1DF8099DE9@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Dd1/quiYZVdiZdRXqbpGtmNy8rckA7fs9uqky+TRGu7XwbSAPj8of2Z/wbaplHQ/yERUwKo0a/azYcPXaVVgWY4k25yQkEzoM+I7ctktc3t+VhD261ZYwgJm4XJCHdifYItBQ/EB+/Wgw3DKcoB+ok/UiZTz/oTGW5U6a2oauajn3nRudywSQcFJSMvMJsK9WPsFo1or/gAohDVKMa5XgrJ1l82CLs55MSnMbGwmjndDmbU6BxQ6rUuy5Zsy2l78bTnqm9StKRcbDfwrQvGzJLqwXnmuJAU9H2/r15nrJ6M/SJWfFJ+CdTuJNwcpdyqcAGofcV1tXlvEqFOBvoHC30X3nBC3cOSIyN/03RzobtmA7E2U0SxU2HGBnWXRk9KUbv5q8pglqOxe96yq7IzDhDWXMGpLXzkchDIVjh8VBpHQ7KkzYH7UsEfA4QM0aSM3iMMShB78x7HwddWC6VO5CLeOc1QQQIHQjTE5EjZZj+TMLMgkQ4He7B6GDTNvinA5JnDyeljQ8CIWPNPivlyfrsOW0ke/2VkT89+rfUMNrbc67sTIzTA98PG9vbldnNce/ncCbm444+RT426mv/UVPn06+eadwXc7mpbQfuo3oVCW6uHDmOkpTCc3FakY1o2qucMRqhJ/GI/9f+WAitR7FCeILC6MFnNlzQTjxtu/mrvfH3lR/UcRecrqQXIo+YFIYtuVQFIiwWJwT82oxdPVmnLcufwCcOE+dTFUh9Y43tydIMA97szvSnmm5Xn1oPQ2JSLSFbMtyhGBoSaCRI0ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(4326008)(356005)(336012)(6636002)(426003)(2906002)(47076005)(66574015)(8936002)(508600001)(16526019)(6666004)(186003)(40460700003)(8676002)(110136005)(1076003)(83380400001)(81166007)(70206006)(7696005)(2616005)(70586007)(44832011)(36860700001)(86362001)(82310400005)(316002)(26005)(5660300002)(83133001)(44473003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:12:24.0708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae24282-cebf-4f6a-de5f-08da44b2ae0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Technically all of those can use GTT as well, no need to force things
into VRAM.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 14 +++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  3 ++-
 .../amd/pm/powerplay/smumgr/smu10_smumgr.c    | 10 ++++------
 7 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 16699158e00d8c..d799815a0f288f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -338,8 +338,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		 * KIQ MQD no matter SRIOV or Bare-metal
 		 */
 		r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM, &ring->mqd_obj,
-					    &ring->mqd_gpu_addr, &ring->mqd_ptr);
+					    AMDGPU_GEM_DOMAIN_VRAM |
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &ring->mqd_obj,
+					    &ring->mqd_gpu_addr,
+					    &ring->mqd_ptr);
 		if (r) {
 			dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88ba8..116f7fa25aa636 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -748,9 +748,12 @@ static int psp_tmr_init(struct psp_context *psp)
 	}
 
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(psp->adev),
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
+				      PSP_TMR_SIZE(psp->adev),
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      &psp->tmr_bo, &psp->tmr_mc_addr,
+				      pptr);
 
 	return ret;
 }
@@ -1039,7 +1042,8 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 	* physical) for ta to host memory
 	*/
 	return amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
+				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &mem_ctx->shared_bo,
 				      &mem_ctx->shared_mc_addr,
 				      &mem_ctx->shared_buf);
@@ -3397,10 +3401,10 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 
 	/* LFB address which is aligned to 1MB boundary per PSP request */
 	ret = amdgpu_bo_create_kernel(adev, usbc_pd_fw->size, 0x100000,
-						AMDGPU_GEM_DOMAIN_VRAM,
-						&fw_buf_bo,
-						&fw_pri_mc_addr,
-						&fw_pri_cpu_addr);
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      &fw_buf_bo, &fw_pri_mc_addr,
+				      &fw_pri_cpu_addr);
 	if (ret)
 		goto rel_buf;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 6373bfb47d55d7..c591ed6553fcc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -93,7 +93,8 @@ int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws)
 
 	/* allocate save restore block */
 	r = amdgpu_bo_create_reserved(adev, dws * 4, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.rlc.save_restore_obj,
 				      &adev->gfx.rlc.save_restore_gpu_addr,
 				      (void **)&adev->gfx.rlc.sr_ptr);
@@ -130,7 +131,8 @@ int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *adev)
 	/* allocate clear state block */
 	adev->gfx.rlc.clear_state_size = dws = adev->gfx.rlc.funcs->get_csb_size(adev);
 	r = amdgpu_bo_create_kernel(adev, dws * 4, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.rlc.clear_state_obj,
 				      &adev->gfx.rlc.clear_state_gpu_addr,
 				      (void **)&adev->gfx.rlc.cs_ptr);
@@ -156,7 +158,8 @@ int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev)
 	int r;
 
 	r = amdgpu_bo_create_reserved(adev, adev->gfx.rlc.cp_table_size,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
+				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->gfx.rlc.cp_table_obj,
 				      &adev->gfx.rlc.cp_table_gpu_addr,
 				      (void **)&adev->gfx.rlc.cp_table_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index aa7acfabf360b0..10350387687e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -263,8 +263,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			continue;
 
 		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-						AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].vcpu_bo,
-						&adev->vcn.inst[i].gpu_addr, &adev->vcn.inst[i].cpu_addr);
+					    AMDGPU_GEM_DOMAIN_VRAM |
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &adev->vcn.inst[i].vcpu_bo,
+					    &adev->vcn.inst[i].gpu_addr,
+					    &adev->vcn.inst[i].cpu_addr);
 		if (r) {
 			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
 			return r;
@@ -285,8 +288,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 
 		if (adev->vcn.indirect_sram) {
 			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
-					&adev->vcn.inst[i].dpg_sram_gpu_addr, &adev->vcn.inst[i].dpg_sram_cpu_addr);
+					AMDGPU_GEM_DOMAIN_VRAM |
+					AMDGPU_GEM_DOMAIN_GTT,
+					&adev->vcn.inst[i].dpg_sram_bo,
+					&adev->vcn.inst[i].dpg_sram_gpu_addr,
+					&adev->vcn.inst[i].dpg_sram_cpu_addr);
 			if (r) {
 				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
 				return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5349ca4d19e38b..36bd6e5c52ec01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1948,7 +1948,8 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
 	if (mec_hpd_size) {
 		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
-					      AMDGPU_GEM_DOMAIN_VRAM,
+					      AMDGPU_GEM_DOMAIN_VRAM |
+					      AMDGPU_GEM_DOMAIN_GTT,
 					      &adev->gfx.mec.hpd_eop_obj,
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index ed2293686f0de3..48ca4a501d40fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -140,7 +140,8 @@ static int psp_v10_0_ring_init(struct psp_context *psp,
 	/* allocate 4k Page of Local Frame Buffer memory for ring */
 	ring->ring_size = 0x1000;
 	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &adev->firmware.rbuf,
 				      &ring->ring_mem_mc_addr,
 				      (void **)&ring->ring_mem);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index 88a5641465dcf5..7eeab84d421ac3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -250,9 +250,8 @@ static int smu10_smu_init(struct pp_hwmgr *hwmgr)
 
 	/* allocate space for watermarks table */
 	r = amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->adev,
-			sizeof(Watermarks_t),
-			PAGE_SIZE,
-			AMDGPU_GEM_DOMAIN_VRAM,
+			sizeof(Watermarks_t), PAGE_SIZE,
+			AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
 			&priv->smu_tables.entry[SMU10_WMTABLE].handle,
 			&priv->smu_tables.entry[SMU10_WMTABLE].mc_addr,
 			&priv->smu_tables.entry[SMU10_WMTABLE].table);
@@ -266,9 +265,8 @@ static int smu10_smu_init(struct pp_hwmgr *hwmgr)
 
 	/* allocate space for watermarks table */
 	r = amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->adev,
-			sizeof(DpmClocks_t),
-			PAGE_SIZE,
-			AMDGPU_GEM_DOMAIN_VRAM,
+			sizeof(DpmClocks_t), PAGE_SIZE,
+			AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
 			&priv->smu_tables.entry[SMU10_CLOCKTABLE].handle,
 			&priv->smu_tables.entry[SMU10_CLOCKTABLE].mc_addr,
 			&priv->smu_tables.entry[SMU10_CLOCKTABLE].table);
-- 
2.36.1.74.g277cf0bc36

