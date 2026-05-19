Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34165CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65FA10E608;
	Tue, 19 May 2026 22:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYnett4K";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9637010E143
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kd+Qbb36jMoGSG9uQlQkLrObB8DIG34s6w6HYS2M1GSaK8519U4eUSbdyD4dfQoeTBQKk1qXM87LLxhCz+NdeQXd5tzNXVunmNRVqb0pg+V0jtJcYcXHA3njPBnhvqNqr+xMtKMK3t3PJdlVRL7eM/kcXUMltj18vLSNesWAvJZzUgYFAC+SKT/9yrij+qV54UVOKv/feVnHXWkOfPqAkBV7UJ8nkaPHchzrduBmZZ4ouq596fsUX8bNq3BnFF2YfRTy0E1jSVNZRYb/1E3c5p8UfsXp1RF3uQEr9awzT+iKB0C4DCnGz+JY6TjFPYdHItY5Gaw+Q+cB20ipK48SUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQKaVxLLGVA4zoNLQ9Q+fYOlqoVclUm39X60PLslLVo=;
 b=YnRjwj/ssUq1WpVoQtdZe1AsNQMo2w6URR7C95TRt5RyP0YTPqOfZniXaA2mrDAiffMc+0nBSYP2oyAiZVQ4BU1n10avJm9J8kqF9TQCjoBgX82uKY8G8i0eoDiu82qFp+kzjQ9zco7AHR9YLEj1tg7wiIgY0m2R3Z9e+OnjkMGm5PT3xuc44Idzpl+mUHPmXw1H+XtqD6o2xD1SzF8lIG1uyCS9aaQCBaQN8B9fsbqLZdjwwNEMwhBgBgyDxwFgtamk31ERG8zwwBltv2Bl5JQSWdsxrmsshEhfSevgTd+MTqjsf8wYHuwWOQG3BgoO/OCZKlsklKPpflo1VguWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQKaVxLLGVA4zoNLQ9Q+fYOlqoVclUm39X60PLslLVo=;
 b=aYnett4KMQkKC3/MCydRCCMtOtMa7s7hUePJ1dO9vzhhwSLtcKJ7hvJ9zEeDE4Q6/gJAlqjLYHjBNbdO+uDI8cBdAm5XjhVbEMnZOtSCeTyRqBuSuCxWL1YcDFt+bqbVxhyuZwyfIKV2nJOfsLLXqZcnm/t5xbYWUSUZyta21/0=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 22:25:59 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::10) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 22:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 22:25:58 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 19 May 2026 17:25:57 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Use asic specific pte_addr_mask
Date: Tue, 19 May 2026 18:25:23 -0400
Message-ID: <20260519222524.204872-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6d01d2-6e40-4606-7005-08deb5f599f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: kTnFgrhe1p6rxElUcXZVNStXcYC7l9lRQU+gXMtAe6NODuo3hdPqsi5Hkf5CwS64w/XehVq1tQUFAzoFCR+6dicWNdMP8KfSMUzca5Xy6YSe+GnpUN2et1H5b8Iaf8qyHhk7LaV0oNu/E0uojyV1xgQjXnsp/LZASRNZS3fy4x4Bph/3hdpOvI+UxilWRMhMiNDszIiw7Oes2IGTSn3qQvw8oKn/E94J2jiq29h2AT0/+kuEkOFEnb9MCf6svA/1RCHrMxctRmriP4N8lGWHUXJeMy41HaJSDZiTEFOfcgk7vBw1+Pt9hDPPBTfxd/nOtRv2EI81aXieD4QbJJbgiE0HvOKabxQ3LlhhPtwOemPIApJ64xHzH4lS6pPSq06hTGnwZRpM/L5qmWWbT9Bu+EywZnh/oJSbA4cErTnYNLB1boL5IMeZQTTT+LU5yjJ+S9cifWjgl73kT0j/emV4pCVj3nfj+FgJ0aO6BYbi17JIIbua3FRknGYKiEjDZMA5DHMU6yNeYx/PVWIAj8fBOucbI2B1sk+F/LNMA58GfFqwXzEULwgl3T5+5OdMg0iX82jKqlYcypfmYqoTg7B+sPnSYF9NUEc1cDLEDLBIQ1zpOWyhC/ArgHJjp6xBlG3IhkCO7vDlTqY3dmXTotnCr+IjLyQD0Xp5KAW88h0fEJUk1jDGbWt3tpMjB/KpOF7vIzzgl9hFf+Kz3wR9ZBkePnoatACqqi/q9/Mu4o8l/GI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wxgRYpFGAIPLCt3kQP0UeMeDNv8GHUQI1AWm3L2OsoaXQhIPsM6ZrSDQU1fkS7ZSeZuXqi2OHf7aC0jkgZ+E8+YnfIqOuPey7wK2Zf/ZWQyUOtOUaSgUFVm6jTF8fj+KuGbUVbAO4KtEMSepLAx/DAdTaIvDJJZlWf2IuZaqPMoDL+RxG4yGFUemixRD/frHJofYQTmryqk8eb7be8DFyztwpK7opupMhIl4wNLa41NQ7WvUHUNoI0SHnVEjtz/TZX1p2tn+dB0+4vUcOHmoilpaRdmXfu3tbQJQBOak1VuMh47Sua9mqDi58+q4LCxagZfb3VQVtXhgQiA2b/2soAxr9uHTtqDxb18RJE+pps3YtodA9NOalBbR544tByIzBayXAgH8FQEADEV6StSlM5NawkX+zkmufhzr5rtuFDVEDaShP5ysAkCL70wwXwFy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:25:58.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6d01d2-6e40-4606-7005-08deb5f599f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
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

For PTE creation use asic specific physical page base address mask

v2: Change variable name from pa_mask to pte_addr_mask

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
 9 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..b49f5f0e3d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -170,7 +170,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 	/*
 	 * The following is for PTE only. GART does not have PDEs.
 	*/
-	value = addr & 0x0000FFFFFFFFF000ULL;
+	value = addr & adev->gmc.pte_addr_mask;
 	value |= flags;
 	writeq(value, ptr + (gpu_page_idx * 8));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..ddb0d500e0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -280,6 +280,7 @@ struct amdgpu_gmc {
 	u64			real_vram_size;
 	int			vram_mtrr;
 	u64                     mc_mask;
+	uint64_t		pte_addr_mask;
 	const struct firmware   *fw;	/* MC firmware */
 	uint32_t                fw_version;
 	struct amdgpu_irq_src	vm_fault;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f2ccf30da324..b5c3b7ba49c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -843,6 +843,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 93b1912e28c8..8a49ce0cbb6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -818,6 +818,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 8bea8d0d16b4..0052a40214a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -813,6 +813,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	uint64_t pte_addr_mask = 0;
 	int i;
 
 	adev->mmhub.funcs->init(adev);
@@ -842,6 +843,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 * block size 512 (9bit)
 		 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 		break;
 	case IP_VERSION(12, 1, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
@@ -854,6 +856,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 * block size 512 (9bit)
 		 */
 		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
+		pte_addr_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
 		break;
 	default:
 		break;
@@ -910,6 +913,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
+	adev->gmc.pte_addr_mask = pte_addr_mask;
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b39f37597429..4c3ff0b9b954 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -830,6 +830,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_vm_adjust_size(adev, 64, 9, 1, 40);
 
 	adev->gmc.mc_mask = 0xffffffffffULL;
+	adev->gmc.pte_addr_mask = 0x000000FFFFFFF000ULL;
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index eedd2006bec3..ac838ae5794f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1010,6 +1010,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
+	adev->gmc.pte_addr_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 347259700dce..74cf597ba54c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1125,6 +1125,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
+	adev->gmc.pte_addr_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4cc3f2434677..3e4a25c51498 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1983,6 +1983,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 
 	dma_addr_bits = amdgpu_ip_version(adev, GC_HWIP, 0) >=
 					IP_VERSION(9, 4, 2) ?
-- 
2.43.0

