Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D48C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 12:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A64D10EB3A;
	Fri, 16 Feb 2024 12:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YAcU2CUE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3756110EB33
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 12:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpA0paRw5vesVz+HjJpbi0LlgzlkccWvYbF0GdC6hcJiaOacMcoo+vdXpAS90smHxMQqP4zhnX4xYPo9XkbiDD8cszo4WxRNvdzBQijRm31APU2X7uakhlRUCB2gPwcJ0QuPUipOtPEQT16nfs1f7SVTqIeRSVgWjrAkodi5b9VgwKr8STLBZwcqehTaMzhqejlTZcCtmjCmLoBKC6Eu2Yw2gWsYOhZxbEUrswym6V/5jSiJAM/FS3uOSo9SJ4xjwQrmdGB1jV0fOd6KhU5ZzpIa8AB8SZKBYe4KeH852QZTAbfZjxetQMzYmhui5Mez8p3ZoDV2imfHDjTuOHyulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/acTJKyu2dGNWZOYpMTlqRjC4OQdtvvsLxjBSPtfIY=;
 b=mlibGPoF2gsRsTZhjT/Iy4+4ocWV8BPWLA8FKPdFQCgjJ3bQgVRt0wbLJEDh/4nz/CZDkFQEM6IPDx/3boCOh3jw7sfh/N1m0qyN6Ck0ON+itmzMoNNTcr0TvDoko9CcE+W/CtI2IdLonVvGA9KmpUvnqGk5BbQCEUFlZUA2H/VwCZasRvGMxkSCiHetNjPK41QuFm/f+bEKR4dbLAll/6P9cF5m3cLTlhzGtDiq9vlJ/gnW30cw5HWyHSKady8zAQueK6bILly6/GV19NMhzykLryr3bfH/RGs6fLGrwPTIMc8QJuTJlCaxl21aCRVli5GKnbJ7k4nEobHxhcJJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/acTJKyu2dGNWZOYpMTlqRjC4OQdtvvsLxjBSPtfIY=;
 b=YAcU2CUErvWhFeXdEP4wdVSGOb7WFUBUtmEuKSAOGoTa+VrrNBwIsGuoWcJOr78VARiqt/HdkGjsggpSHJ9r35Ae2gFWILP+H/hyEaDWS26qJsi5d2EclIECauNuOWvD2VYV5MNB++pmpWUIcllALLFlOXEYva8KZ0Su3gLJnCo=
Received: from BN0PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:e8::15)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 12:59:42 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::2a) by BN0PR04CA0040.outlook.office365.com
 (2603:10b6:408:e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 12:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 12:59:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 06:59:40 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: Add pci usage to nbio v7.9"
Date: Fri, 16 Feb 2024 20:59:24 +0800
Message-ID: <20240216125927.1821169-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: fedde950-c1dd-446c-389b-08dc2eef2478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laTwX+OWRUfUdG05Q1cMCfcSRSVeSsC6tU5Zmc1XshN230VSOW+GyRPgKlsgXaE3O9pmCu3t9xA1EzQNMQp69SEmC9KH40URLqu0kVTtD+2j4S1iY9uxN74a7H++20cs1b3x/sGebNL4J5cqbvlq/TlIIWKHsFYiSoN8HvqSPGr91+Td49YJL5uAY8QCNTJLDFc2YesloFDEp861b1uoUEwdsxVTPsCWyo2sF32QpFGBgk8aIJeIodVbKaFhLDTXdT8QndFxkqUtHEQgZswDbYCVJwkt5MiOjPap5luQm/l+PZDLqqt9VqeZes3Tl9BArvTDrKb63vvNB2CppnQED6VrH3teyoCT7X5a0khA+2iQxCmvrhZ6JNkbGRuDKuMGN5Q9DJVnYRaCD7QLsPj0ASArW1/ZGm1ctdY9ZMSoJ8Ny+XatbrfHHsZCRsvrzrpNoX45/9BMq3YET4FhenGC6bZ4rxQM3JhtoKXkI6UUpB3vzUiVq6WRWlhb3NWoLVcILQz8yV3Db5nwikld6Q9hgQCY14YkmgrxYVrzPVFzU6erzJDWSX/E/PP4mz3tHKGLXatg3ef/eCzT4T6dplY20W75dnyiJtXdtB7wy6GQlYIz3bluztx4CnFNUhhqYbvras1Dj+qBEkYN767R35obGSW0JBgdG9if0aPaTN1pJy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(36860700004)(1800799012)(40470700004)(46966006)(426003)(83380400001)(336012)(2906002)(316002)(6666004)(478600001)(5660300002)(54906003)(7696005)(6916009)(26005)(4326008)(1076003)(16526019)(44832011)(2616005)(41300700001)(8676002)(8936002)(70586007)(82740400003)(86362001)(36756003)(356005)(81166007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 12:59:42.3219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fedde950-c1dd-446c-389b-08dc2eef2478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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

Remove implementation to get pcie usage for nbio v7.9
as pcie usage is handled by fw

This reverts commit 59070fd9ccea58c3363d39f69c25fa98c71eb02f.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        | 63 -------------------
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 .../asic_reg/nbio/nbio_7_9_0_sh_mask.h        |  8 ---
 3 files changed, 1 insertion(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index b4723d68eab0..40d1e209eab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -35,15 +35,6 @@
 /* Core 0 Port 0 counter */
 #define smnPCIEP_NAK_COUNTER 0x1A340218
 
-#define smnPCIE_PERF_CNTL_TXCLK3		0x1A38021c
-#define smnPCIE_PERF_CNTL_TXCLK7		0x1A380888
-#define smnPCIE_PERF_COUNT_CNTL			0x1A380200
-#define smnPCIE_PERF_COUNT0_TXCLK3		0x1A380220
-#define smnPCIE_PERF_COUNT0_TXCLK7		0x1A38088C
-#define smnPCIE_PERF_COUNT0_UPVAL_TXCLK3	0x1A3808F8
-#define smnPCIE_PERF_COUNT0_UPVAL_TXCLK7	0x1A380918
-
-
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -484,59 +475,6 @@ static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
-static void nbio_v7_9_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
-				     uint64_t *count1)
-{
-	uint32_t perfctrrx = 0;
-	uint32_t perfctrtx = 0;
-
-	/* This reports 0 on APUs, so return to avoid writing/reading registers
-	 * that may or may not be different from their GPU counterparts
-	 */
-	if (adev->flags & AMD_IS_APU)
-		return;
-
-	/* Use TXCLK3 counter group for rx event */
-	/* Use TXCLK7 counter group for tx event */
-	/* Set the 2 events that we wish to watch, defined above */
-	/* 40 is event# for received msgs */
-	/* 2 is event# of posted requests sent */
-	perfctrrx = REG_SET_FIELD(perfctrrx, PCIE_PERF_CNTL_TXCLK3, EVENT0_SEL, 40);
-	perfctrtx = REG_SET_FIELD(perfctrtx, PCIE_PERF_CNTL_TXCLK7, EVENT0_SEL, 2);
-
-	/* Write to enable desired perf counters */
-	WREG32_PCIE(smnPCIE_PERF_CNTL_TXCLK3, perfctrrx);
-	WREG32_PCIE(smnPCIE_PERF_CNTL_TXCLK7, perfctrtx);
-
-	/* Zero out and enable SHADOW_WR
-	 * Write 0x6:
-	 * Bit 1 = Global Shadow wr(1)
-	 * Bit 2 = Global counter reset enable(1)
-	 */
-	WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000006);
-
-	/* Enable Gloabl Counter
-	 * Write 0x1:
-	 * Bit 0 = Global Counter Enable(1)
-	 */
-	WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000001);
-
-	msleep(1000);
-
-	/* Disable Global Counter, Reset and enable SHADOW_WR
-	 * Write 0x6:
-	 * Bit 1 = Global Shadow wr(1)
-	 * Bit 2 = Global counter reset enable(1)
-	 */
-	WREG32_PCIE(smnPCIE_PERF_COUNT_CNTL, 0x00000006);
-
-	/* Get the upper and lower count  */
-	*count0 = RREG32_PCIE(smnPCIE_PERF_COUNT0_TXCLK3) |
-		  ((uint64_t)RREG32_PCIE(smnPCIE_PERF_COUNT0_UPVAL_TXCLK3) << 32);
-	*count1 = RREG32_PCIE(smnPCIE_PERF_COUNT0_TXCLK7) |
-		  ((uint64_t)RREG32_PCIE(smnPCIE_PERF_COUNT0_UPVAL_TXCLK7) << 32);
-}
-
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -561,7 +499,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
 	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
-	.get_pcie_usage = nbio_v7_9_get_pcie_usage,
 };
 
 static void nbio_v7_9_query_ras_error_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c64c01e2944a..7fc55e3262eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -895,7 +895,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.get_config_memsize = &soc15_get_config_memsize,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
-	.get_pcie_usage = &amdgpu_nbio_get_pcie_usage,
+	.get_pcie_usage = &vega20_get_pcie_usage,
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
index e0c28c29ddb0..a22481e7bcdb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h
@@ -38896,13 +38896,5 @@
 #define RCC_DEV0_EPF0_VF7_GFXMSIX_PBA__MSIX_PENDING_BITS_0_MASK                                               0x00000001L
 #define RCC_DEV0_EPF0_VF7_GFXMSIX_PBA__MSIX_PENDING_BITS_1_MASK                                               0x00000002L
 
-//PCIE_PERF_CNTL_TXCLK3
-#define PCIE_PERF_CNTL_TXCLK3__EVENT0_SEL__SHIFT							      0x0
-#define PCIE_PERF_CNTL_TXCLK3__EVENT0_SEL_MASK								      0x000000FFL
-
-//PCIE_PERF_CNTL_TXCLK7
-#define PCIE_PERF_CNTL_TXCLK7__EVENT0_SEL__SHIFT							      0x0
-#define PCIE_PERF_CNTL_TXCLK7__EVENT0_SEL_MASK								      0x000000FFL
-
 
 #endif
-- 
2.42.0

