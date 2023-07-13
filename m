Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEC7EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 10:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920A010E02D;
	Thu, 13 Jul 2023 10:16:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8C110E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 10:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw/0eLnnXaoaczoPRWHz/acv3nX4uaS9HylqIrNWA9qkf8UV810BhSyg+wEBajrEvZubKXenunkRPKNTlZKmQ+nTlr8z8AXIPLMjUT3D3yGyRzrXzGWlHMP0KlDVRqWUP1++FaVTXKQuRBmUvfrCqQe8cdgPRTGdJeOp6oINKwNM5xxr1Gpz+ntPBnOlNsTdNT6sSr2sO5+31NBFm+x2wN4z0iIj8EFRszasdAJ7DcUaK/N/4FaPaH2WJnh5iO3/vwlV56BpxmBEUBa7k4D12s+03csMWQxcY3VdbxTjgAk1c5EpVniZu2SUICsce6RTc+aZysRyzGk9eMPB4AebYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nkEWLZNqB08c/wrR6i3pFplqF8STVVUuPo9yb6YidU=;
 b=Ndf/VYT4h09KDW+19IsA4bdXS2nO/mW3mxMODonELcN3AoiTD/E9ZlqkSrt3SVehpCPAAZxAAfTf/KtILWVMXn6/wTz4CB6tcDZoOB58XojPc3vmSdkjAuLj6nO+8Xn2ToMy4+B1cazDApb+93GkryBbvPdREv+aj45pezY1xmHu3JKWH/dfbZ+a17S6Y7ACdITSLazuO3NkGPpNsVUkiZE0fNrEPqc+xoD5QaOT6m0At+l29c5fuGULQWo7E2vRv0U77wZjJW2DYNlArAXFC6xZDbtYezwTa/KMRbc94CYtCCGs9tpUB6GDPv4hVxKuZCSDaphPRWYXzUbZlHs3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nkEWLZNqB08c/wrR6i3pFplqF8STVVUuPo9yb6YidU=;
 b=ckfSspyQIQZxueGlgVVigzGmH86wd3R+t1yLeNuHsOmXCGoll8F0ZCIjs6WKsuKGflZahux1vhRo6dRScKSLK45ZHBgBOF36mqOW1XnLuyYusJLjzw3VRl1WCjcrZ8+76u2u2iHd9MJZ/wEo25lYDv2pC8c1utETD/vjwOAmlf4=
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 10:16:07 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::98) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 10:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 10:16:07 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 05:16:05 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: load sdma ucode in the guest machine
Date: Thu, 13 Jul 2023 18:15:39 +0800
Message-ID: <20230713101539.20608-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 458c4520-d59f-40a1-f76f-08db838a2c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqD1TKs90UkKmsF6HRp7JHPY902KZTp7wdFbX53zaPEdgiT3XM5xexTa/qlPn+aQSfr0DcwPriwLLe+Uz30fs14WFBxEzOorNMNOSvmOJy/Pff2lI4PQeRhHHj6YbIVDD09Ah3RDJccyrqxu0CfQSTBWbSAMbTlyeOe5isjBLU33q0ewOTFOMFoHv7046YgkJvrU3WzrEm/Y/v1Ms77BNsgyHupHJx3Yqiw615u2mvvPxvUN348oFJcsGk350PKIr2X6BO2smxqbJSeTYE8p4a835pKyncc0D3o7YhF6ei5NMi9BK3EpDmi2qem3n/M+yRT+9ofI6gTmoqMT2eAZjl66x6fN+n+7O8bpSPz4SgvjaAdbIcErqdre9lbm8YS4Y7DQCip4Sq9hctUTgv4RJJu+nDfwp29YvZTO38zN8uVx425HyX2Vszh8cMYJLA+sYNK/SLjN3hnB6IZZRFbKiz68nwHxKEdCfPx+N/vOqTINsybtLW08/t9aPpwUFUpcxobKBLA1FqQcOhZ1qq05F77XqayIpHSPp52isl5qNww73SSBBO1WPF4E/a45xMIipT9UbcclJm/4crojZSeboExzdvMw7x2oONtb4C4/s/PkeDTLg23TF5Kx8t5hjRIYbTjitEzfjX/h0Pk/6r2WmPFuvflw99jZgWMrd758f0qT661eslU98HlEiBbcq4dBtpFoepKHoAH/skuXukeiYY+2uJ3cZE4yImVtDP5Eqc1VHiEDSmGcs8hlC3nX7vHefaayy8+1IjjwggEWRfZ3BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(186003)(2616005)(2906002)(478600001)(26005)(1076003)(83380400001)(47076005)(336012)(4326008)(41300700001)(36860700001)(426003)(5660300002)(316002)(8676002)(16526019)(6916009)(8936002)(70206006)(7696005)(6666004)(70586007)(54906003)(36756003)(40480700001)(356005)(81166007)(82740400003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:16:07.5538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458c4520-d59f-40a1-f76f-08db838a2c5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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
Cc: zhenguo.yin@amd.com, YuanShang <YuanShang.Mao@amd.com>, horace.chen@amd.com,
 haijun.chang@amd.com, yuansmao@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Load the sdma ucode in the guest machine CHIP_NAVI12
and CHIP_SIENNA_CICHLID, so that the guest can check
the version of current sdma ucode.
It is used to support KFDTopologyTest.BasicTest,
which need use the sdma ucode version to see whether
the sdma engine support a new type of package (Barrier
Value Packet).

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index dacf281d2b21..e2b9392d7f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -239,9 +239,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 			       sizeof(struct amdgpu_sdma_instance));
 	}
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 41aa853a07d2..16e4e30ee28e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -845,6 +845,17 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 			return false;
 		else
 			return true;
+	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 9):
+		/* black list for navi12 and navi21*/
+		if (ucode_id == AMDGPU_UCODE_ID_RLC_G
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_SMC)
+			return true;
+		else
+			return false;
 	case IP_VERSION(13, 0, 10):
 		/* white list */
 		if (ucode_id == AMDGPU_UCODE_ID_CAP
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5c4d4df9cf94..aa6b7390a7a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -237,10 +237,8 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 // emulation only, won't work on real chip
 // navi10 real chip need to use PSP to load firmware
 static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
-{	int ret, i;
-
-	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(5, 0, 5)))
-		return 0;
+{
+	int ret, i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ret = amdgpu_sdma_init_microcode(adev, i, false);
-- 
2.25.1

