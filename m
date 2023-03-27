Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02256C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC57210E726;
	Mon, 27 Mar 2023 19:36:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF38010E722
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH5FILroUp0acFUe+JBU4DqNeicCRzwQkN6eURIDBKzNeKEuJUpj7kJtUfxGrT2gLwDa97Ed3ePntm5jlGDtO5U5lUfcGUEYxbgZkwwjpGNFXM1OGGl9KVbw1MVchsI4m+6y8Fioim/hTevfQaKTMs7dB5Iqpot43e9i49mJLkLVpBVpl4GHF0o1Zfso/KadkbWnEbVJRwtD42SE1znMwkUau9mFyebt6eMr1ofC1jkDtYPA+qbFvRQePlR3bWMU9tODCylXgG3JR5sUCtzpqHoDJA2YBap1cKJ6NyIL5eM3kRpjkLgcsWAbsRaC7BrpBEsihomZ/gNP52KtaKpB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm4pgywjSR9xhuHER/XyHTigaJ8Pp1ARnoPx/T8rw8c=;
 b=JTzua37xEaysu/6y9UFGvFWR7ijbXKryBMK7RTqehSYXjZpHWkLrlaI9r+9VvUC0qPgYM4h9LJEmS1Ul3uQV4FsvWiwAnUv7keOCKysuAALhT5oEwaNvEjyr26bdOUzSTxqPrCmcrD3uVe76Ri0Alt28LUCX+Tm8/G+7z6wDXubBMKNyNYzNvol/4Eq3EccT158ukokmad0/uxhhu5x9ibd4HVu+TXWG2j5PsSRS2HsYsanAPXosoVwAH02avhA0PPT4Ow+fVea9/gWgcyBQvzI3XmTWncwdPdf3gNNqyOmqqW5gQq430q05qaq6Bs15hIXcsqnD0JHXM/6OxKTELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm4pgywjSR9xhuHER/XyHTigaJ8Pp1ARnoPx/T8rw8c=;
 b=ko54Byrr9UrPg5RtwN8T1KGH0MX69RvaGxAy/LKJbLbzcLSwZVRYakbS8Wdz1QjPO7MbuiKNZQBFbZHcqSm8iuFGuYAct2ahqOr446YScBQxaG/e7iN2VGS2CXJUlO1oiCKy6su0vtHUg1EcYQKtYwcqDPJQqGPrWOzrX9Q3DD0=
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 19:36:33 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7f) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/28] drm/amdgpu: add bitmask to iterate vmhubs
Date: Mon, 27 Mar 2023 15:35:53 -0400
Message-ID: <20230327193602.7901-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|CH2PR12MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e16a28-8624-46e9-7c2f-08db2efa9251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdKtnQaJ1VSRkH3SaqkS75VMnJCawL3SwpcFDp/K9v7C/qXlAyOuQjIEd7/BLw+oHgJz5qZ+GhGoqJFI5XCTzV5jT/HBkFk6ipYZKPA+XXapo4Rud54YAQ/AcjgjTyTPpFepirCjJRTuSBGZ0EWuRlkCUs5DcapLxWnnXDSuWAumUlA25Lsb9a4de6r4y0/8SlPZexRDGMEWIIvcN0yvsnWL4vqxpqb285wdpOsS5w/65Bl2ZZRk197v6YoRMIYiceHRz2sO1JgjksdKy6XqQJNbhbjeovO2nb4+ElJJ7SSYcvOjmbY2NvPszeVQrRg7O1tGSQWH/dk1m/e7FyNHNJMEQ23HJVLot67dJDWdazBBwZH5vRTqbbU8shBfZuHahGIr/OZyj+hwZnN6PB7uPDD/sSPJfebhyUz8QS60CcO9sQwMKno1rulIB57b3iAjFAgvMjJOFSuqfkRHtDHZVD9BtFaHnNdwVeYBPkMijF7UvYKyJZPjj0CkDQpAYnKvxHoBxo7u8qFxEThdDiVntZrmqAs0tLsAiF8cjm+/RNTos6b/kL8usc6upHg3wNdcnJHn+jtM/6eYI6ttzqjFArDOhTg4Ov9L0kNAkNn5HXV0Ib0dgDESMa290cTXp/ZhpwiAEtj7Vl1WGuE2xt/A545CuYW7KQp/ckzxeVaR+Eq1qwaOi1mIrV2JEXeawV418DDJYvz8XEbf8sHmXt07+fQgvythKybD7Smx6+aiKrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(70586007)(70206006)(36860700001)(8676002)(6916009)(316002)(5660300002)(8936002)(356005)(41300700001)(82740400003)(1076003)(16526019)(26005)(81166007)(478600001)(54906003)(186003)(7696005)(2616005)(426003)(336012)(83380400001)(47076005)(6666004)(40480700001)(86362001)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:33.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e16a28-8624-46e9-7c2f-08db2efa9251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

As the layout of VMHUB definition has been changed to cover multiple
XCD/AID case, the original num_vmhubs is not appropriate to do vmhub
iteration any more.

Drop num_vmhubs and introduce vmhubs_mask instead.

v2: switch to the new VMHUB layout
v3: use DECLARE_BITMAP to define vmhubs_mask

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 21 ++++++++++++---------
 9 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7c3288a1aa70..81b437fa7b9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -850,7 +850,7 @@ struct amdgpu_device {
 	dma_addr_t			dummy_page_addr;
 	struct amdgpu_vm_manager	vm_manager;
 	struct amdgpu_vmhub             vmhub[AMDGPU_MAX_VMHUBS];
-	unsigned			num_vmhubs;
+	DECLARE_BITMAP(vmhubs_mask, AMDGPU_MAX_VMHUBS);
 
 	/* memory management */
 	struct amdgpu_mman		mman;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a7afe1fb8881..90d872356edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -732,7 +732,7 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
 	if (adev->family == AMDGPU_FAMILY_AI) {
 		int i;
 
-		for (i = 0; i < adev->num_vmhubs; i++)
+		for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
 	} else {
 		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0), 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 01cb89ffbd56..6b12f4a75fc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -182,7 +182,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	}
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 
 	drm_dev_exit(idx);
@@ -264,7 +264,7 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a3ac887f36ab..503b4ff13fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -460,7 +460,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret	&& queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
+				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 					gmc_v10_0_flush_gpu_tlb(adev, vmid,
 							i, flush_type);
 			} else {
@@ -928,7 +928,8 @@ static int gmc_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
-		adev->num_vmhubs = 2;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
 		 * To fulfill 4-level page support,
 		 * vm size is 256TB (48bit), maximum size of Navi10/Navi14/Navi12,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 37bc272bcf98..d5a0f16cddba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -362,7 +362,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret	&& queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
+				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 					gmc_v11_0_flush_gpu_tlb(adev, vmid,
 							i, flush_type);
 			} else {
@@ -760,7 +760,8 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
-		adev->num_vmhubs = 2;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
 		 * To fulfill 4-level page support,
 		 * vm size is 256TB (48bit), maximum size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b7dad4e67813..aa754c95a0b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -808,7 +808,7 @@ static int gmc_v6_0_sw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->num_vmhubs = 1;
+	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 402960b0174e..81609a2b226f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -977,7 +977,7 @@ static int gmc_v7_0_sw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->num_vmhubs = 1;
+	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 504c1b34dab7..d48e33738a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1093,7 +1093,7 @@ static int gmc_v8_0_sw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->num_vmhubs = 1;
+	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6d13d42a125f..ce9ae3a5a9c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -481,7 +481,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		for (j = 0; j < adev->num_vmhubs; j++) {
+		for_each_set_bit(j, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
@@ -509,7 +509,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (j = 0; j < adev->num_vmhubs; j++) {
+		for_each_set_bit(j, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
@@ -786,7 +786,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	u32 j, inv_req, inv_req2, tmp;
 	struct amdgpu_vmhub *hub;
 
-	BUG_ON(vmhub >= adev->num_vmhubs);
+	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
 
 	hub = &adev->vmhub[vmhub];
 	if (adev->gmc.xgmi.num_physical_nodes &&
@@ -970,7 +970,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret && queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
+				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 					gmc_v9_0_flush_gpu_tlb(adev, vmid,
 							i, flush_type);
 			} else {
@@ -1667,7 +1667,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 2):
-		adev->num_vmhubs = 2;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 
 		if (adev->rev_id == 0x0 || adev->rev_id == 0x1) {
 			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
@@ -1684,8 +1685,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
-		adev->num_vmhubs = 2;
-
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 
 		/*
 		 * To fulfill 4-level page support,
@@ -1701,7 +1702,9 @@ static int gmc_v9_0_sw_init(void *handle)
 			adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	case IP_VERSION(9, 4, 1):
-		adev->num_vmhubs = 3;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask);
 
 		/* Keep the vm size same with Vega20 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
@@ -1927,7 +1930,7 @@ static int gmc_v9_0_hw_init(void *handle)
 			adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 		adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	}
-	for (i = 0; i < adev->num_vmhubs; ++i) {
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
 		if (adev->in_s0ix && (i == AMDGPU_GFXHUB(0)))
 			continue;
 		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
-- 
2.39.2

