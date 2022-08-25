Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCBCC04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 08:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC6510FAB6;
	Thu, 25 Aug 2022 08:58:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505B810FAB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 08:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ3kigQsMRMeZPwEC6DH9+4d6gJ4RjEflK1z9cOqf7aagpqRiIFlJzUapAGyY1WUNdUt07fakFWUpzq36OaHjKohG+v7Z8pnldzyd/uulmPEAJcOv+vm4KX2KecDpUK0k+XQMkYepDbpwfnusBCOBNCrt9MqZbtDZ8dLUVitDS3/iUUbC1J3dFuCWqcntbh4T2eEpmoiREAFyeJvmz+B+tOVtScR+Q49bQ0W+tHjx1XAIhxHpEI+LPy+UG7eUo8y7fjOUfmMJ35JRFk6McHvEDq/Bt12Jy4A3Br/eWOWVCmOIjtdKNUJGJ/CKUAvK3FZW4M6tImmVpaVC/JelvhC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypGbmaQ4MuVLTa/q/+udX1fKvRpLQ/7Biv7j5bHZWYg=;
 b=Ipd1rmOVXetRzaOpyZaPjEfdKIFOZZibdhqH4/4QrHS79bBpG/coPCZbGms+CPXpOUknwaRn7s7wSf6jLx5+wItdBXTrf9Tptr6dIzRzXh4GBRCLWw0vnIo/7Q6fkQcYUDbDp9n6pXXapekjMlk93ftDJpjM7s/egUrt+k883Hk/Sna58HdTKgH0pgWc/3wkEBYHfoNLwHrvDJaRUilps3oF8o2oSsKnuqPajuiqCZjLunMy9OszDck3FNXMDgA6+WrfeyI1NnQ/FxswMPlU7dDX0sJ4I9UM50ynv8ptXjYC3DU8XjhzFMwcAozDa3Q8K5ClZxlAURatPH6SlgMc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypGbmaQ4MuVLTa/q/+udX1fKvRpLQ/7Biv7j5bHZWYg=;
 b=UuvyLzr7I4QUrUMv538N1XRK/bmGefiAV9EfmXT9fqYAIXrvUnc0rocnHwNblbo1dtPtr+Du4nEjbOhucUvDj/zE+s7+LSEwYZq3WOaM+NPwlGOvI3N4BgjASHvYDUMyAbZJbq7dyzNOLW91K0WbmGdo6h38uwITESl+yQiUh3k=
Received: from BN0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:408:ec::23)
 by DM6PR12MB3388.namprd12.prod.outlook.com (2603:10b6:5:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 08:58:49 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::b4) by BN0PR04CA0108.outlook.office365.com
 (2603:10b6:408:ec::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 08:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 08:58:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 03:58:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Init VF's HDP flush reg offset early
Date: Thu, 25 Aug 2022 14:28:20 +0530
Message-ID: <20220825085820.1228641-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825085820.1228641-1-lijo.lazar@amd.com>
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f55dbbb-25e2-48f4-c2d2-08da8678039d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3388:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMM6fQ2ZHiSgKlQ9bvYsA+x+c1/GiFC7KljUbpNRLLa/vmtiCtAnX6e7OaMcNVoX4ceAUW6gWhHu7hyBdBSOuWKgaH0ssSrveQt0Pn9nBvruQllATtJuTdv6/sfx7aHwe+O4w24S4+7hEKct5KJ1o5OiDJ+QAJtMYkFFg36hKuQE4Fq9dcMXFHWRsjV4KaQHU+fbiH6pBkBdwgHfl+6YkC3esc5bbSmeMJZjBJVkN7X3XrvLWJCoHtzHEPezN07803+wXuQMUtS0WwgllKdZHc1s1YY4WFXxQhoJtmI+ynfB5Ffwl1sGI0GKpEd+nOWNlg+nlATf7MtieVmXezGGC/307RQ4TbO7zBUKoP9/4hJIAaZE5vndts5/LmzlXbmLnRbPaJgOS4KPGPeGB5fhrwRiBmG6F659MNkiWbS1fSH20Rlm4AhQZpfjHQQiQ81CqcX/1JwV3Qpqz8Fr3nZEUUAQl094FLszQ9+ZZ6PDJcR4W6OYp4gMaVIe+3w+rAp8UVYBLhZfKUyMOZT/+UkrNnmjKGqYBGBPjKPxUEEFauM5flTK6cNGNdwNZl/0EjqqdBhFHnxPrEAWN84MWPtrkK6WV+gM07LKi+FgaOmYEJ2z+6QV9LyFxIu7YpKD3KjvrEViKut3MDiaLkX1DVzDJam7LAEc9mfnt1LR7wBrkc515QhGt1b+2J1zm+qkIg+2KGhDbEPj+OOfY0sqwO8K8y3CFynjO7Z7zzwDc9vjM66yLIJMsdOSRUcng5ZgzqMd/wi2TYGI0b1ecndaV0WR/ajnaZqut6pZI0QobjhfET16QaPNJV7zfiocAq839yII
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(40470700004)(46966006)(186003)(86362001)(82310400005)(83380400001)(1076003)(40460700003)(426003)(47076005)(7696005)(16526019)(26005)(6666004)(54906003)(40480700001)(336012)(36860700001)(70586007)(70206006)(316002)(4326008)(2616005)(6916009)(8676002)(41300700001)(2906002)(356005)(36756003)(478600001)(44832011)(8936002)(5660300002)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:58:43.9964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f55dbbb-25e2-48f4-c2d2-08da8678039d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3388
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
Cc: Felix.Kuehling@amd.com, tseewald@gmail.com, helgaas@kernel.org,
 Alexander.Deucher@amd.com, sr@denx.de, Christian.Koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure the register offsets used for HDP flush in VF is
initialized early so that it works fine during any early HDP flush
sequence. For that, move the offset initialization to *_remap_hdp.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 23 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c     | 12 +++++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c     | 23 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c     | 21 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c     | 24 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c     | 23 +++++++++++++--------
 7 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 53d753e94a71..c0bb2e9616c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2382,7 +2382,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			 * to process space. This is needed for any early HDP
 			 * flush operation during gmc initialization.
 			 */
-			if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
+			if (adev->nbio.funcs->remap_hdp_registers)
 				adev->nbio.funcs->remap_hdp_registers(adev);
 
 			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index b465baa26762..20fa2c5ad510 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -65,10 +65,21 @@
 
 static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
@@ -338,10 +349,6 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 
 	if (def != data)
 		WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
-
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 982a89f841d5..e011d9856794 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -30,10 +30,14 @@
 
 static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v4_3_get_rev_id(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index f7f6ddebd3e4..7536ca3fcd69 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -55,10 +55,21 @@
 
 static void nbio_v6_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v6_1_get_rev_id(struct amdgpu_device *adev)
@@ -276,10 +287,6 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
 
 	if (def != data)
 		WREG32_PCIE(smnPCIE_CI_CNTL, data);
-
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index aa0326d00c72..6b4ac16a8466 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -35,10 +35,20 @@
 
 static void nbio_v7_0_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0,
+					 mmHDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_0_get_rev_id(struct amdgpu_device *adev)
@@ -273,9 +283,6 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_reg = {
 
 static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset =
-			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 31776b12e4c4..fb4be72eade7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -49,10 +49,21 @@
 
 static void nbio_v7_2_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
@@ -369,6 +380,7 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg = {
 static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
+
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(7, 2, 1):
 	case IP_VERSION(7, 3, 0):
@@ -393,10 +405,6 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
 		break;
 	}
-
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 11848d1e238b..3c11af99582f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -101,10 +101,21 @@ static void nbio_v7_4_query_ras_error_count(struct amdgpu_device *adev,
 
 static void nbio_v7_4_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
+			     adev->rmmio_remap.reg_offset +
+				     KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)
@@ -343,10 +354,6 @@ static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t baco_cntl;
 
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
-
 	if (adev->ip_versions[NBIO_HWIP][0] == IP_VERSION(7, 4, 4) &&
 	    !amdgpu_sriov_vf(adev)) {
 		baco_cntl = RREG32_SOC15(NBIO, 0, mmBACO_CNTL);
-- 
2.25.1

