Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60DCC678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 08:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE5610E081;
	Mon,  6 Mar 2023 08:04:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD6510E081
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 08:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwWVf4g14ctfwQHo+8ZCfknV26E9qi7j0J0+PIYGWPYJAZKT8S98QeIgmO9fb2No8j9dKvW3/GmNt/4IvFQjl0yqt7o/m/6voIBbjClOYrJBSCgvdldTBZnXGYWsW+eIZfFuVsYeNPP31NKHyM0Va/Uc62fqMGaPAeVkzYYo5MwS3dfwHb0M6fsWgX62ENvQhjAJWWSBGN2NqLe/AoEy0hn/KjuslnCs9ottKKwuvUVDAx2+wfTHMo94QSEss9hzMpL0tuiY2qztZ0ix8+tFFbUInetUmOoQ3fnlxYpwU1zeFEccfjC+g7+EMO5E5FFogiDM4RGKym+mHM15ZYvh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i38/MVU0IYrBZrejMSQitEXM97HZbMDPmS/H7wiWBaI=;
 b=PfSZl9Ei7p6DzcjkxoKbmdYDF9ETe8cTFftTVOuvhdJt7QsDlwxnW3UjAwcBFkSke20PqPhdwctguoJ3Z64i/oyQ47qkxW/M3h0K04WB22aB15pPBUFZmFh58g1jmm88JC8iP1WHoZe4Bovpa+IfdqPgTdm8MxX3bqVx/L7ibI9mwo7m56ZQoWJzysp+AS+GQufyOkEZ94MPNSSMKtdDpK0y1d/rhTLdYaTQ2IZyx3g68x+mwrXsG9z/ZNrrGNiY81ONSe6CjaoRlU/XLle8qE6ao/geINJDkAaMC2DkB66n4VFRmxrnpb4Sy/TbezUts/ms36Y5d4XqzgPYYJm1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i38/MVU0IYrBZrejMSQitEXM97HZbMDPmS/H7wiWBaI=;
 b=xwLIO9l3vaEbrdCKzJJT5gs1EiQ2OEssUfAPf5RFTa5qAwbcDVGiFqxxpoQMDXJoEzGnfNcvB/SBytgTYCCTYUtLni+gWEpNvVnWeMlEygrYFmGBZD/PQvahy6ihVGRL4O6DUeZ1iS3bZdt+zx/nfVL9jGfzTDKrqscXnXnN22k=
Received: from DM6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:100::41)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 08:04:33 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::cb) by DM6PR03CA0064.outlook.office365.com
 (2603:10b6:5:100::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 08:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 08:04:33 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 02:04:31 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Move to common indirect reg access helper
Date: Mon, 6 Mar 2023 16:04:00 +0800
Message-ID: <20230306080401.20501-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: de1bc398-2bdc-416e-95d1-08db1e196bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyS722zGqYsaqNWLpjXVDk1GqWIRXXvGkzLQcKCxS0iGNdX7ovwwTMCraDSRPZz++3guPlSRQLFYLJx3JCY62Tk8dbdwnD21gHSmgBXusga+6+ud6FQz1glxCMNkFZwRObxHZH7rwM4kJ5o7R46bKv/iIG+3V9hGbjb4224k8kkfpixbx7H4aLTgqSj0Gz6IT6ays2XGL5qq29kPip8P59+A/CveTXVhBPmQfc6LHq1zWBpjaZjbdqxyhgld85ZgzrGS3PdCMDRGm3pqP8YREl+iG6m0EzhjilzUz8L5nFehy4Jcff4387gs6s1Y8alJej9TkbjdH+lx4JA6MQ2WGSGAhltwKrDiknR5wWjL/GizYp6e6xNKBK628llpc/3hz1TgVa4Vy4U3KeOUOY05xXqjA9DsnN5qrRASvrWAkH8BGSAaYKjDrSnyse5HRbFsXf6TqUH1Xr4o2DeUPFFY6Bkt4agFEjwIORYRBHFFnJ197M4UxG+WNdwqt0q65QxVJhlmJ4pG+XKpqxGv0Fn/f0IvnBbj3eGWqN8QaIQoFJP2Wz+v6Z7byUqbWBcvKnfzyWmOf7SfRERsBypbBXEb/QguTIJ5XtHgrLGF23noGq5XLPddP7GPJuTBRI2J1eDyMYdldToAFVlOBwT1mok0t6WL5UoJTW8DqNaJ9NqgEN/GEjs1bF8XpTnkdHNhx/NywwMyEbWqP/fFNbn8xDR+KN8eVOU3R+Vqudc8nmEsssM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(186003)(81166007)(356005)(8936002)(36860700001)(4326008)(8676002)(41300700001)(82740400003)(70586007)(5660300002)(70206006)(30864003)(2906002)(426003)(47076005)(7696005)(478600001)(6666004)(2616005)(1076003)(26005)(336012)(316002)(110136005)(6636002)(36756003)(40480700001)(82310400005)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 08:04:33.3795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1bc398-2bdc-416e-95d1-08db1e196bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace soc15, nv, soc21 specific callbacks with common
one. so we don't need to duplicate code when introduce
new asics.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++-------
 drivers/gpu/drm/amd/amdgpu/nv.c            | 49 ++--------------------
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 49 ++--------------------
 drivers/gpu/drm/amd/amdgpu/soc21.c         | 48 ++-------------------
 5 files changed, 30 insertions(+), 152 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 07e846510005..9387731afb8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1142,16 +1142,12 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
 
 u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
-				u32 pcie_index, u32 pcie_data,
 				u32 reg_addr);
 u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
-				  u32 pcie_index, u32 pcie_data,
 				  u32 reg_addr);
 void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
-				 u32 pcie_index, u32 pcie_data,
 				 u32 reg_addr, u32 reg_data);
 void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
-				   u32 pcie_index, u32 pcie_data,
 				   u32 reg_addr, u64 reg_data);
 
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77e6c8bf7190..b1b815dc69b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -676,20 +676,20 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
  * amdgpu_device_indirect_rreg - read an indirect register
  *
  * @adev: amdgpu_device pointer
- * @pcie_index: mmio register offset
- * @pcie_data: mmio register offset
  * @reg_addr: indirect register address to read from
  *
  * Returns the value of indirect register @reg_addr
  */
 u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
-				u32 pcie_index, u32 pcie_data,
 				u32 reg_addr)
 {
-	unsigned long flags;
-	u32 r;
+	unsigned long flags, pcie_index, pcie_data;
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
+	u32 r;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
@@ -707,20 +707,20 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
  * amdgpu_device_indirect_rreg64 - read a 64bits indirect register
  *
  * @adev: amdgpu_device pointer
- * @pcie_index: mmio register offset
- * @pcie_data: mmio register offset
  * @reg_addr: indirect register address to read from
  *
  * Returns the value of indirect register @reg_addr
  */
 u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
-				  u32 pcie_index, u32 pcie_data,
 				  u32 reg_addr)
 {
-	unsigned long flags;
-	u64 r;
+	unsigned long flags, pcie_index, pcie_data;
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
+	u64 r;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
@@ -750,13 +750,15 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
  *
  */
 void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
-				 u32 pcie_index, u32 pcie_data,
 				 u32 reg_addr, u32 reg_data)
 {
-	unsigned long flags;
+	unsigned long flags, pcie_index, pcie_data;
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
 
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
@@ -779,13 +781,15 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
  *
  */
 void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
-				   u32 pcie_index, u32 pcie_data,
 				   u32 reg_addr, u64 reg_data)
 {
-	unsigned long flags;
+	unsigned long flags, pcie_index, pcie_data;
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
 
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d972025f0d20..60c10132ed32 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -280,47 +280,6 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	}
 }
 
-/*
- * Indirect registers accessor
- */
-static u32 nv_pcie_rreg(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long address, data;
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	return amdgpu_device_indirect_rreg(adev, address, data, reg);
-}
-
-static void nv_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
-{
-	unsigned long address, data;
-
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	amdgpu_device_indirect_wreg(adev, address, data, reg, v);
-}
-
-static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long address, data;
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
-}
-
-static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
-{
-	unsigned long address, data;
-
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
-}
-
 static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
 {
 	unsigned long flags, address, data;
@@ -737,10 +696,10 @@ static int nv_common_early_init(void *handle)
 	}
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
-	adev->pcie_rreg = &nv_pcie_rreg;
-	adev->pcie_wreg = &nv_pcie_wreg;
-	adev->pcie_rreg64 = &nv_pcie_rreg64;
-	adev->pcie_wreg64 = &nv_pcie_wreg64;
+	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
+	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7cd17dda32ce..6392d10e6eaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -191,47 +191,6 @@ static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	}
 }
 
-/*
- * Indirect registers accessor
- */
-static u32 soc15_pcie_rreg(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long address, data;
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	return amdgpu_device_indirect_rreg(adev, address, data, reg);
-}
-
-static void soc15_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
-{
-	unsigned long address, data;
-
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	amdgpu_device_indirect_wreg(adev, address, data, reg, v);
-}
-
-static u64 soc15_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long address, data;
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
-}
-
-static void soc15_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
-{
-	unsigned long address, data;
-
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
-}
-
 static u32 soc15_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
 {
 	unsigned long flags, address, data;
@@ -935,10 +894,10 @@ static int soc15_common_early_init(void *handle)
 	}
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
-	adev->pcie_rreg = &soc15_pcie_rreg;
-	adev->pcie_wreg = &soc15_pcie_wreg;
-	adev->pcie_rreg64 = &soc15_pcie_rreg64;
-	adev->pcie_wreg64 = &soc15_pcie_wreg64;
+	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
+	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->uvd_ctx_rreg = &soc15_uvd_ctx_rreg;
 	adev->uvd_ctx_wreg = &soc15_uvd_ctx_wreg;
 	adev->didt_rreg = &soc15_didt_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 78bd598d286f..9d91e20a22bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -127,46 +127,6 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 		return -EINVAL;
 	}
 }
-/*
- * Indirect registers accessor
- */
-static u32 soc21_pcie_rreg(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long address, data;
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	return amdgpu_device_indirect_rreg(adev, address, data, reg);
-}
-
-static void soc21_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
-{
-	unsigned long address, data;
-
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	amdgpu_device_indirect_wreg(adev, address, data, reg, v);
-}
-
-static u64 soc21_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
-{
-	unsigned long address, data;
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
-}
-
-static void soc21_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
-{
-	unsigned long address, data;
-
-	address = adev->nbio.funcs->get_pcie_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
-}
 
 static u32 soc21_didt_rreg(struct amdgpu_device *adev, u32 reg)
 {
@@ -581,10 +541,10 @@ static int soc21_common_early_init(void *handle)
 	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
-	adev->pcie_rreg = &soc21_pcie_rreg;
-	adev->pcie_wreg = &soc21_pcie_wreg;
-	adev->pcie_rreg64 = &soc21_pcie_rreg64;
-	adev->pcie_wreg64 = &soc21_pcie_wreg64;
+	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
+	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
-- 
2.17.1

