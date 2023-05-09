Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9320CC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BFA10E420;
	Tue,  9 May 2023 22:12:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C50510E418
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5Mm7Jto4KdV8V+QImmjZTH+KcNgwEO7/cUsPJuTIPGNhoXXOc8Bk33Om3VooWFS5QH3hby8tpY+aImZuQHsDMfnjUQax0h5lfrhBNRyTNmvxqWLujd5xQi4aPGXasW+4LtemRH91nGaMCdk5FxVaEC0ZaeDnkSnlpcwruBceAwnH+4RffXRfduKufR1qzzp5DjqD8EZHig8WrRBYBvwB/0yCI72FeYj9foFKtdwHfsup/rglAS4kmAfUVouNKhyF0CBR5rxDlvC+4MkkoijE/swQJArrfxmFXdEzFNA6CsviyvLhp6Ynk3+9PPa1vdsXTJyhKags5AKzyZj1LCZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtc791aLch2HtvzOQDSHbPXPmMChGQNkdvu8PZEXvwo=;
 b=D/8tfarPUjbtEWL5fySY+JdurJHZB1s4z5qz/7AojAc8AZiSy3/dhjmHqTHcit/RZatkA1+meRMRU6nbtoGnbbTCVhfHSkVOu7LGf6ZSR8A+8BGCR2ie1s8y6xJdHLeRc/7jzCGYskP02zbaQatnzXcTN6SQOsxN9kDEJ59desrmGN7ulaDoFFyx6Eben/NWnSXuwa3mkykNpnNihymaC2qyg0CeVdAVnaOfgUDO8+aKwgpkabWh16gC9EDv3rBEuku5ctjn0GhS58thJpwPR9UNHYCfzIrfm8q/sg72CMsELin+Hgjr2U7txcAdQt0TjCm2EYiPCpwYL1HIl1OGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtc791aLch2HtvzOQDSHbPXPmMChGQNkdvu8PZEXvwo=;
 b=KSxN5lk8IeFANfJ+ydotjv9bGdcBtdcDUR60bcxJm5/BHfLwIOO41ECuqupTbH1XUVPn80c+i7xVV7vlJR3IuFZ8UEsH6YbE1ZjbUAkkGpUeEFNzO7DHhDLZIWPbU4s0sJWi2LnKLtbqxaC+VGi4dsb3U8z+xZdjWto2xKTjlGY=
Received: from BN0PR04CA0128.namprd04.prod.outlook.com (2603:10b6:408:ed::13)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:12:45 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::b0) by BN0PR04CA0128.outlook.office365.com
 (2603:10b6:408:ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:12:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:12:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use apt name for FW reserved region
Date: Tue, 9 May 2023 18:12:28 -0400
Message-ID: <20230509221228.476412-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221228.476412-1-alexander.deucher@amd.com>
References: <20230509221228.476412-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 190ed984-75ec-4141-8d89-08db50da843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raXUoJ/QWHgKfe3KaEk+46lUnw9clfdUriB13/brL44kHTPY6FmoqhY3YnSiR5oDn8ItGLaEkAE696nsAbBDNClOgKCTkUtMabCQrvVr2d5vAJJs3wMFL3ospS+i8WHPs2yhbmDY/+PE3ytsV4E0b/Bz97SIGS5rPCDuaoCqVl3m5k5ZOVOvX7tsneHKiGqbTzGTNpQkuUcVWnxTHJ+c28Qyj74DedUJuvzZFZbWlvhXOFB+EaLT0vz9AJ1IEq+kX8wCymcVTUfH+7v4GoQMdTOMPfxbub2/QFzkOzX47m/oHhsdDmeF8fx+WSKpi2VQwEdNSd7+AqnjCMEqUAXcgn2R1y5g5Pnw8nQ/dity8aH2r8mGgASvp1nQ2YbcfEd4BjDLvw0/xnHbPfx+bqfiSjpdBDJUfOEz0U+7KHlg1R313GkHyKJfs2TM0uUfCw9Apaayc15e9UqynWf2xo6yr3gI3v1+1yMq2q/R90VHPoEnDeeUcW5UBvtKavH+HeTy06mbGTAFtH6RTT1/BPY7N3Ah1nxpcIwYeigMvDXsWwFutNchhJ1VzEaCv6c+0bvLICtJlgc0R787/7P+7nBJAvb8yQy5Iokp6tzLab8ef/TVwh+yuN9CCdsT7h/9R9dFJ+GoxIG+dB3toOCJ0UwBR5wD/fP66DHDnTPRFOHicdaE/WWuUU05+zt209U+l4aV+HRQnclSN31Jp4jaSGLm50lyN1gwMpiBpl2Nqh9qgA8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(316002)(54906003)(478600001)(41300700001)(8676002)(8936002)(16526019)(6666004)(2906002)(70206006)(5660300002)(6916009)(70586007)(4326008)(47076005)(1076003)(26005)(40480700001)(356005)(186003)(7696005)(40460700003)(82740400003)(83380400001)(36756003)(2616005)(426003)(336012)(36860700001)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:12:45.4398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190ed984-75ec-4141-8d89-08db50da843c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
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
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use the generic term fw_reserved_memory for FW reserve region. This
region may also hold discovery TMR in addition to other reserve
regions. This region size could be larger than discovery tmr size, hence
don't change the discovery tmr size based on this.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 36 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2bdd6bcad506..1582ef092bf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1648,14 +1648,15 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
+static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev,
+						uint32_t reserve_size)
 {
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 
 	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->c2p_train_data_offset =
-		ALIGN((adev->gmc.mc_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
+		ALIGN((adev->gmc.mc_vram_size - reserve_size - SZ_1M), SZ_1M);
 	ctx->p2c_train_data_offset =
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
@@ -1673,9 +1674,10 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
  */
 static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 {
-	int ret;
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 	bool mem_train_support = false;
+	uint32_t reserve_size = 0;
+	int ret;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (amdgpu_atomfirmware_mem_training_supported(adev))
@@ -1691,14 +1693,15 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
 	 * discovery data and G6 memory training data respectively
 	 */
-	adev->mman.discovery_tmr_size =
-		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-	if (!adev->mman.discovery_tmr_size)
-		adev->mman.discovery_tmr_size = DISCOVERY_TMR_OFFSET;
+	if (adev->bios)
+		reserve_size =
+			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
+	if (!reserve_size)
+		reserve_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
-		amdgpu_ttm_training_data_block_init(adev);
+		amdgpu_ttm_training_data_block_init(adev, reserve_size);
 		ret = amdgpu_bo_create_kernel_at(adev,
 						 ctx->c2p_train_data_offset,
 						 ctx->train_data_size,
@@ -1713,15 +1716,13 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	}
 
 	if (!adev->gmc.is_app_apu) {
-		ret = amdgpu_bo_create_kernel_at(adev,
-						 adev->gmc.real_vram_size -
-						 adev->mman.discovery_tmr_size,
-						 adev->mman.discovery_tmr_size,
-						 &adev->mman.discovery_memory,
-						 NULL);
+		ret = amdgpu_bo_create_kernel_at(
+			adev, adev->gmc.real_vram_size - reserve_size,
+			reserve_size, &adev->mman.fw_reserved_memory, NULL);
 		if (ret) {
 			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
-			amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
+					      NULL, NULL);
 			return ret;
 		}
 	} else {
@@ -1909,8 +1910,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (!adev->gmc.is_app_apu) {
 		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
 		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
-		/* return the IP Discovery TMR memory back to VRAM */
-		amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+		/* return the FW reserved memory back to VRAM */
+		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
+				      NULL);
 		if (adev->mman.stolen_reserved_size)
 			amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
 					      NULL, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..da6544fdc8dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -78,7 +78,8 @@ struct amdgpu_mman {
 	/* discovery */
 	uint8_t				*discovery_bin;
 	uint32_t			discovery_tmr_size;
-	struct amdgpu_bo		*discovery_memory;
+	/* fw reserved memory */
+	struct amdgpu_bo		*fw_reserved_memory;
 
 	/* firmware VRAM reservation */
 	u64		fw_vram_usage_start_offset;
-- 
2.40.1

