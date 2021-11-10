Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3ABC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 02:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D380F61179
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 02:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D380F61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B00C6ECED;
	Wed, 10 Nov 2021 02:31:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1B36ECDB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 02:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2UXCY2ADf5Lo89VYFxQ2tei7Mme0FnIsp440lxMAx7aR6wuhJeaYpbCr+8IV8OYufaYnWPWJrpIKQdDl9pj8kUgNGjCQN3ktLfVul4UXDb002UNwzXLLjtmM6w+tKQXXrdUtJDF4znrzwPD/yATAa7GDEnLFZ8WquMjjPpNj6xZjA7qEFVrbcApbd1KYe337MTYJbrQWaHXe06KNjORKy768VC2n+01uwuscyikJeJsr3XgI1e/rW/zsSTB9NjmC4LzcQYiKd2WB7nvhy3w0rLlOGPNu/t7UzhdAxi9UHzwAzeC6M7+TXBa480h0TZPJ+XKk5hrpP2C2OYB0FfUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXwcmDhXZIcy5G3/SPkKf5I4VuvGO5KJN4to0TgLgsM=;
 b=ApU7OnjvE/U4XheAoQp5GnuHNB83TUdrtdTx1tynMwKaq3S27JQ0z7x+2x80qj6p4tGUvDdyC7mLA7Nrh3jJWevxhe6EBN5SXMVXeBlqy7sufuBRDEVpGLpNwtAPwqY3DYOQfLke5tTCMVj/mVYFbGDvJawOThJnNU8a2wF46wsnp7CbsSbVWD76kuWmg7E8c6b9Zi2jdsurPC7iuvN1nXHHf6PS0Ra2WaGnVIb3qh/g/nnvchyAmIrIiZ6vCD2PUEJsLt+r/xGEOQXPTQIBx4/94SmeIHYfgc6xa7NqklqPTVoXqNEnwnCVfey+p7i0THKLfxBXjnjZnAZ6XszJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXwcmDhXZIcy5G3/SPkKf5I4VuvGO5KJN4to0TgLgsM=;
 b=zMWq0JFiWEslpKziQidxRxBZRvz6oHiPCnJNwxoCznLvLJuNIrzJl7XXaJDvYyTXM7NYUfjFGoo/sRT+aAK28rDYHWUThgJ4b+EdvafXWozSuCo2ADVylotlHiE7s7DPcCCpLTjcR0HfrP+ny7dghT0ILrat8L2KJFgd2HL9Xjk=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by BYAPR12MB4616.namprd12.prod.outlook.com (2603:10b6:a03:a2::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 02:31:17 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::df) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Wed, 10 Nov 2021 02:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Wed, 10 Nov 2021 02:31:16 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 9 Nov
 2021 20:31:15 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
Date: Tue, 9 Nov 2021 21:30:52 -0500
Message-ID: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe6ef555-8767-486f-efe9-08d9a3f22c09
X-MS-TrafficTypeDiagnostic: BYAPR12MB4616:
X-Microsoft-Antispam-PRVS: <BYAPR12MB46162C646375507C47A55F3E92939@BYAPR12MB4616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIGxFeV952Wzkm39pHgxwtKEAaXfDFcxmUJuz3LL7njQzFY/PdtQIpOYGtbdwPY4sXByW2nTZ456Xt8o/09Kv1jpsu1FTchk5nW19bV3W/kht/gz1s2dBsjZVSu6aFIOXiJHoemGfwwsgDPclcJXWpL1Dn7+LsThrKhQB9pkOjWUex5+/u9B6nbU4M4fXAwidONfISNguQv374kVTwETa5a2qWLeUP9ZPxOyOaaClJp9ZkVcSmRNZIx54IVC3G4m7mKNGWm8Z5YnJm+muhWltDf8xhUS4jNSGNs5p656bRlu63twHmsnAuEfIHZIQgfgm8k4/5lDowYMkBSjJVItGR+ZTqwd3HB99qHaGeR6x2QCSvKmZW5jqEeYry4EpxpvpOGFloOeSzRPSr+SCshmbms7zFobeDQAHaBx717qbXfOlgA6W7dx+1L7/dW4xFegpK+gAguVy0y5r5k8oYrUy6O1E8wco7gOXkJWgNXhe8d34xGBsjjLeBMLyuhC2iagtrzvPmRPNUU7zYNMUDapn1bateRyZZYjcxDWyC0/iBIK93ej3PMxd+6Lusdbw2WcnuKz5MYoedMJfLnmu01TkMgmzLAk/MQCs7lXNBvEz7L6Ihe3RMupxdi+WAfpzt4FJYqmuGiWeiQLXSxZQDa6+f4RNENB2/I0ZYt87dD6QQIOMUpagGIg3wKqgnBAnfQ5LoiXD7F06KW0+/cGckEHg5iPQn1zqKcB69lhad/0Sj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(4326008)(83380400001)(5660300002)(36860700001)(81166007)(7696005)(47076005)(6916009)(36756003)(82310400003)(6666004)(356005)(186003)(8676002)(26005)(16526019)(70586007)(70206006)(508600001)(8936002)(2906002)(316002)(2616005)(426003)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 02:31:16.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6ef555-8767-486f-efe9-08d9a3f22c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4616
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
Cc: bokun.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
to the fixed address of the VF register for hdp_v*_flush_hdp.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
 7 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 4ecd2b5808ce..ee7cab37dfd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 
 	if (def != data)
 		WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
+
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 0d2d629e2d6a..4bbacf1be25a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
 
 	if (def != data)
 		WREG32_PCIE(smnPCIE_CI_CNTL, data);
+
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index 3c00666a13e1..37a4039fdfc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_reg = {
 
 static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 {
-
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 8f2a315e7c73..3444332ea110 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
 	}
+
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index b8bd03d16dba..e96516d3fd45 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald = {
 
 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
 {
-
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index febc903adf58..7088528079c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
-	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	}
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &nv_pcie_rreg;
@@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	nv_enable_doorbell_aperture(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0c316a2d42ed..de9b55383e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
-	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	}
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &soc15_pcie_rreg;
@@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
 	/* enable the doorbell aperture */
-- 
2.32.0

