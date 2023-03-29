Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AADC761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F337A10EC1C;
	Wed, 29 Mar 2023 20:10:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829FD10EC22
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwE+ZOH2oLRFpFvWyIeM9P+voEHkAijeBwlQ7jIadROck4e7yHNRbe4p2AerIbCHmvrcg+rKiUMm7BKIpk1kQ9hYcMaAnhfaoPKeohs6qLM8Qox+y0T9aMGlve7ICyHPckLp0HwnXo9ofhwlQDAEnOBehF4GqFXkZJhHsrlCPIZPeFb4S4Sp99tJfypcE6EXAeBRMYTMp0hnSNsSE8bXSbMr4pdrrdiAYyrA1Nz4uhcj/ecwLZZwzhQHI5wbKwJX/4airxWTsjOOqdfELtUSLqrCPfAEA1bOJszlwTbvDq4ZZtwuAeadAfYG/ZXqgnQxc8n4+1wP4PMMwLy6wa0Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngGAYtZ1K54nAu7Hnh501T7S5wHaEkxrc2n5eBEBKDQ=;
 b=FzmHaTw6VjNRzK4A/ULYqilWOfUGyRPeUbLS8MrTLamAA3w4oOzpVEgK9/1CNe9Bzc0OGU2NlpODx6SVSbQ5nGT4AsxRKhzWBIEfg3UatWMEJm2WvTvFkRNvLJLPKvKly/FUTwpy3WKwJvxh0l/NkBKC66e76MYWtXZdl2Cdz7+V0XDwoFLcDEO8Uba9fRELT6FE+xo8x7c2g3G4/6F+RrOXsN01mfu2frwG5ScpYdfjooaMKMRwaiJ1I6+U8jXkjrkF9Abr4sN84d3q+NrBMezJ0PJUVxkqpkVg91felEzcMCRzvQdKlDraeZTs7BzF7BM47T04MaD6TkUGl8QVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngGAYtZ1K54nAu7Hnh501T7S5wHaEkxrc2n5eBEBKDQ=;
 b=N8su13lzAszVrXI4//T1LWvgepspplOPEQ7+YRDHhigofTXSXMxjLPkDThVF0KCg5H1oqni80T/tSD73AAgu1zi9JzgrwRKES3zOdrFOn/bTWhp5z90eDjCK/rB7MsA9z4Lw1BK99qjtOxSeW1sC+Hu+iGWMn4n3E1pLM4v/7S0=
Received: from DS7PR06CA0018.namprd06.prod.outlook.com (2603:10b6:8:2a::9) by
 SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Wed, 29 Mar 2023 20:09:53 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::9b) by DS7PR06CA0018.outlook.office365.com
 (2603:10b6:8:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amdgpu: add indirect r/w interface for smn address
 greater than 32bits
Date: Wed, 29 Mar 2023 16:09:21 -0400
Message-ID: <20230329200930.1982035-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: be4d1937-4d45-40f2-5a67-08db30918eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRyNBvvUwc7IKQfrAtbHMVifN3fiBziSlV2WSXF5EGnn8QU9FoBRgvga5SsaPpzmUQxaj+/eHhsh9saJEDILHOOE+Ga4lmdVOd9OsiVtH4W6qJq1omOkvO8BTRCihDFliNV84KbGdH+cmdyxm4p8CYT6aN8An+Qx6Yd6e1F8DiBWO8bh0xRcvkn8wOQHhIfzJbMCyIDD2x9HI6y/pZXSMADwjGEcVXMESuW2UgnCCxjqzcGOnu7+NvPTmuj9h3bMk/Hw/QTV2uLuHviALv4Gs33/Z9NJAlgXwDV8dLs2uqiN/+dYEzL8mpr03MooUFl2A8fSkb+hPx02l/PVOa+sDoTjt8paeZxsNnARerkp8b4HVUTPWWHeZ0OwYJG/T+CxbNpM3qwQ6aT5O58Rgr9nggdsnQlKXeGe4YeAd5I/ZgJwiFLtlFPQhMMVxWot0uhOUHCW4PTSDEe6xFQogXI53BrBLRn2ONbtZqQmZ7h0S13ABVs/ivdezUR4Sed097db3H9GScmfWrbaOXpz5wyoK5WagKt0pCXhJsqpHYsVnN3S8tCJkaKtk6ICseC0XVxE5LVpmU59wFwilIbRu+U3XCZlcIP7FEIZMxBmUkJHBM0+NYakG4eE3knQlwhoWWW4qiMzXreumzzJ+icgIF19vmPeaAy1N75E4J6RDfB/RmAOSoeN1aqupQ3vHrLXEWT5sCMyLA8R5ECQ3+1Kal4NVUEhAOaJ+Fon70RRSVVmVsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(426003)(36756003)(336012)(86362001)(16526019)(81166007)(186003)(2616005)(83380400001)(26005)(1076003)(5660300002)(356005)(8936002)(82740400003)(6666004)(41300700001)(36860700001)(70586007)(40480700001)(4326008)(7696005)(6916009)(8676002)(2906002)(47076005)(40460700003)(54906003)(316002)(70206006)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:52.8652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4d1937-4d45-40f2-5a67-08db30918eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

On multiple AIDs platform, bit[34:32] in SMD address is leveraged to access
nonAID0 register smn address and new PCI_INDEX_HI register is introduced
to access the higher bits.

v2: rebase on latest register accessors (Alex)

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 98 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c     |  6 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  2 +
 5 files changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ca9c4d31e352..5ad7ac75cc0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -629,6 +629,9 @@ void amdgpu_cgs_destroy_device(struct cgs_device *cgs_device);
 typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device*, uint32_t);
 typedef void (*amdgpu_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t);
 
+typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device*, uint64_t);
+typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device*, uint64_t, uint32_t);
+
 typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device*, uint32_t);
 typedef void (*amdgpu_wreg64_t)(struct amdgpu_device*, uint32_t, uint64_t);
 
@@ -819,6 +822,8 @@ struct amdgpu_device {
 	amdgpu_wreg_t			pcie_wreg;
 	amdgpu_rreg_t			pciep_rreg;
 	amdgpu_wreg_t			pciep_wreg;
+	amdgpu_rreg_ext_t		pcie_rreg_ext;
+	amdgpu_wreg_ext_t		pcie_wreg_ext;
 	amdgpu_rreg64_t			pcie_rreg64;
 	amdgpu_wreg64_t			pcie_wreg64;
 	/* protects concurrent UVD register access */
@@ -1109,9 +1114,13 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
 			    uint32_t expected_value, uint32_t mask);
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 			    uint32_t reg, uint32_t acc_flags);
+u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
+				    u64 reg_addr);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
 			uint32_t reg, uint32_t v,
 			uint32_t acc_flags);
+void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
+				     u64 reg_addr, u32 reg_data);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
@@ -1163,6 +1172,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
 #define WREG32_PCIE_PORT(reg, v) adev->pciep_wreg(adev, (reg), (v))
+#define RREG32_PCIE_EXT(reg) adev->pcie_rreg_ext(adev, (reg))
+#define WREG32_PCIE_EXT(reg, v) adev->pcie_wreg_ext(adev, (reg), (v))
 #define RREG64_PCIE(reg) adev->pcie_rreg64(adev, (reg))
 #define WREG64_PCIE(reg, v) adev->pcie_wreg64(adev, (reg), (v))
 #define RREG32_SMC(reg) adev->smc_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 518e89a7d9ae..c0ab1a57dcbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -706,6 +706,48 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
 	return r;
 }
 
+u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
+				    u64 reg_addr)
+{
+	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
+	u32 r;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if (adev->nbio.funcs->get_pcie_index_hi_offset)
+		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+	else
+		pcie_index_hi = 0;
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
+				pcie_index_hi * 4;
+
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	r = readl(pcie_data_offset);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return r;
+}
+
 /**
  * amdgpu_device_indirect_rreg64 - read a 64bits indirect register
  *
@@ -773,6 +815,46 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
 
+void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
+				     u64 reg_addr, u32 reg_data)
+{
+	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if (adev->nbio.funcs->get_pcie_index_hi_offset)
+		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+	else
+		pcie_index_hi = 0;
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
+				pcie_index_hi * 4;
+
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	writel(reg_data, pcie_data_offset);
+	readl(pcie_data_offset);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
 /**
  * amdgpu_device_indirect_wreg64 - write a 64bits indirect register address
  *
@@ -839,6 +921,13 @@ static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint32_t reg)
 	return 0;
 }
 
+static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64_t reg)
+{
+	DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+	BUG();
+	return 0;
+}
+
 /**
  * amdgpu_invalid_wreg - dummy reg write function
  *
@@ -856,6 +945,13 @@ static void amdgpu_invalid_wreg(struct amdgpu_device *adev, uint32_t reg, uint32
 	BUG();
 }
 
+static void amdgpu_invalid_wreg_ext(struct amdgpu_device *adev, uint64_t reg, uint32_t v)
+{
+	DRM_ERROR("Invalid callback to write register 0x%llX with 0x%08X\n",
+		  reg, v);
+	BUG();
+}
+
 /**
  * amdgpu_invalid_rreg64 - dummy 64 bit reg read function
  *
@@ -3607,6 +3703,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->smc_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg = &amdgpu_invalid_rreg;
 	adev->pcie_wreg = &amdgpu_invalid_wreg;
+	adev->pcie_rreg_ext = &amdgpu_invalid_rreg_ext;
+	adev->pcie_wreg_ext = &amdgpu_invalid_wreg_ext;
 	adev->pciep_rreg = &amdgpu_invalid_rreg;
 	adev->pciep_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 6a636c34b717..8fa3a1f3b181 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -61,6 +61,7 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_hdp_flush_done_offset)(struct amdgpu_device *adev);
 	u32 (*get_pcie_index_offset)(struct amdgpu_device *adev);
 	u32 (*get_pcie_data_offset)(struct amdgpu_device *adev);
+	u32 (*get_pcie_index_hi_offset)(struct amdgpu_device *adev);
 	u32 (*get_pcie_port_index_offset)(struct amdgpu_device *adev);
 	u32 (*get_pcie_port_data_offset)(struct amdgpu_device *adev);
 	u32 (*get_rev_id)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 40e694932a20..cd576b767912 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -319,6 +319,11 @@ static u32 nbio_v7_9_get_pcie_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
 }
 
+static u32 nbio_v7_9_get_pcie_index_hi_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2_HI);
+}
+
 const struct nbio_hdp_flush_reg nbio_v7_9_hdp_flush_reg = {
 	.ref_and_mask_cp0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK,
 	.ref_and_mask_cp1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK,
@@ -382,6 +387,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
 	.get_pcie_index_offset = nbio_v7_9_get_pcie_index_offset,
 	.get_pcie_data_offset = nbio_v7_9_get_pcie_data_offset,
+	.get_pcie_index_hi_offset = nbio_v7_9_get_pcie_index_hi_offset,
 	.get_rev_id = nbio_v7_9_get_rev_id,
 	.mc_access_enable = nbio_v7_9_mc_access_enable,
 	.get_memsize = nbio_v7_9_get_memsize,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 81c2150eb374..af47fafd2e77 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -874,6 +874,8 @@ static int soc15_common_early_init(void *handle)
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
+	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->uvd_ctx_rreg = &soc15_uvd_ctx_rreg;
-- 
2.39.2

