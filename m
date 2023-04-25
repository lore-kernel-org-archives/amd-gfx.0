Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F10C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 10:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989B410E077;
	Tue, 25 Apr 2023 10:16:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD0D10E077
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 10:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9jLwXie5TSuzmlKXeB4+GY3TMzU8EMxqGZ1AWPgOCpFOw/EiX5A8KSWkyLUGB4/dbjW/3p4kPaoizneVlINe6r4Kj+gipWRJ2C9UrwGL243lkE1VzunVGH3WJRbTOG1U76CiWQfQQK2CuHloLbp036an+0S2TbZGKPzbkgK79509Nu6760uPNSrbW9m6VQnKkncLfcYXb3N5G+zLZ9hA/nWyl60YCKfIl0vqBYMcQHByLFnWAcAQenacQgYoKVwhjkMMT3urHGL/sTjKGLFaRm9b5u/X/Jo/DVquhm/s4THq1kSh/M/hdb2FafchvpvFKK/JxHUymecNl+rkVPy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvKdOQYwxDf9lTiA59yAdDnya+6HhLS85SNwVd9B+Qw=;
 b=MLvcEW/8ruxy1suOzx2b8UZ2ZZVuNuJQiFAtunj5y2+EQE5Y7OmqQH5+ONpFCYY0CNMaZPFe76QVCslj5wG8ZfcnQab6mRC8/gK41VFDHOuMhpXSQvBko6JKIS7NsD7ghgseLeABM/rxCCEWsu3OGrfA10lXIfUSMtNvm54DTNJoiA9wBd+bZFJGgPZPfJg0rttYDVuhfw5sFuqMAbqDkxXypmn4Zszpu/nzb2KlIJXTuVGshW+npNbvGe/KvR0+3MjFiyjxz8cW2qUkpasrCfHnvtAdSZ3qSt+GTTtp+g9Ml2YqoT3Xz3qx63jjINMoGuXiFAhY9x9hPMZzsxugCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvKdOQYwxDf9lTiA59yAdDnya+6HhLS85SNwVd9B+Qw=;
 b=ItnOmhYS0AGD4bBg0mwdVw5g8dflYIESBzANlboqYV996wtthkd9y5Jkna/AixlQnjNQ3LuFk0/HKPkTCtf7Mdn8ZWRByxHKbhLIstJKkkDVR2FiUEmLg9UZ7hmr8b2mCQp6q4z84tOfXecvSTuQ86fzz5VF6rCT0rQY1e8S4b0=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.34; Tue, 25 Apr 2023 10:16:33 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 10:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 10:16:33 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 05:16:30 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <felix.kuehling@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable doorbell selfring after resize FB BAR
Date: Tue, 25 Apr 2023 18:16:13 +0800
Message-ID: <20230425101613.1277792-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe6756f-405a-4288-a75b-08db45762527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2I4/iLJkm6/p3NGGFDerhSZHquhx+z33FkXvXw+Dn4hPl4c2F/aBMoahdH+0u2hwgzMiezWlABdD7/XxLRq4d4N62UeJczWwKLjLqNAKSsMt3/zGwSKtv7kZkXuFiKj8CDgrg5loCMl8TH832wx1oyPaHn4uBaS3VHCmm5h7aJQmC5fOjV5MwR1C9ZSQrV3fPO+zQHDNZhDnQCt2cfWdS0Dpc+b4GeGeyjyPKN/Ohul1Jhh/8GofPD2ytqCZfG+gvnWwa/SCWCfc9cAUaCSgAnHFUS44gvZ15zxUc2RRm5bws9AnUmSinOuwSOPoIeZRbJoA6BHmlPhYpxddurW99VVgnWEEZYGtLdrA3e126BoVnGA3xI79wJNQfuBAEvH4ixmTQKwjPMDS5eFucUILfhNkzji8QNdBAoOg3IcyFvRa6TE5ig3BPZ4ShTFmHDlxc+Ultl62QOUAhlew/LqxAQbvhjfreRpxZQMIwM+vgJy8QYIFGhk1aeiMIz5Z3IU1mLcdQVevN79IUX/hOm+PBcZZlrz4XXfJ31NFDHvFlNU5fj1BZJ7R3PrxtWZshptlCMcje6ey615EX3wWcxoogQbOpbUfgDElz3fXYxdjq3qTwFETEAZGFcEqTaJn/XShcGc2FSbNHkRDKwZYolLWC2k0gonlcfL/y4Ed/FIPic9NE4i8A3Tuq7dneX/LnmFwUgKkDbly4Vf75xKzHXF7YTteJjEzvxa9Iu8lwZJefybU5XwBTeJpaR+Fmkr7ZB9F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(40480700001)(40460700003)(110136005)(6636002)(54906003)(478600001)(86362001)(36756003)(7696005)(6666004)(82310400005)(2906002)(5660300002)(44832011)(8676002)(8936002)(70206006)(70586007)(4326008)(81166007)(41300700001)(82740400003)(356005)(316002)(26005)(1076003)(336012)(426003)(2616005)(36860700001)(47076005)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:16:33.4089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe6756f-405a-4288-a75b-08db45762527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Shane Xiao <shane.xiao@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The selfring doorbell aperture will change when resize FB
BAR successfully during gmc sw init, we should reorder
the sequence of enabling doorbell selfring aperture.

[How]
Move enable_doorbell_selfring_aperture from *_common_hw_init
to *_common_late_init.

This fixes the potential issue that GPU ring its own
doorbell when this device is in translated mode when
iommu is on.

v2:
  1. Remove *_enable_doorbell_aperture functions

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 17 +++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15.c | 19 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 17 +++++++----------
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index dabeeab2f2ad..cb39d556c23d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -531,13 +531,6 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 
 }
 
-static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
-					bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version nv_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -999,6 +992,9 @@ static int nv_common_late_init(void *handle)
 		}
 	}
 
+	/* enable selfring doorbell aperture */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -1038,7 +1034,7 @@ static int nv_common_hw_init(void *handle)
 	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
-	nv_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
 
 	return 0;
 }
@@ -1047,8 +1043,9 @@ static int nv_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	nv_enable_doorbell_aperture(adev, false);
+	/* disable the doorbell aperture and selfring doorbell aperture*/
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4d1487a9836c..2db021f6e8ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -619,13 +619,6 @@ static void soc15_program_aspm(struct amdgpu_device *adev)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
-static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
-					   bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version vega10_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -1125,6 +1118,9 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
+	/* enable selfring doorbell aperture */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -1182,7 +1178,8 @@ static int soc15_common_hw_init(void *handle)
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
 	/* enable the doorbell aperture */
-	soc15_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
+
 	/* HW doorbell routing policy: doorbell writing not
 	 * in SDMA/IH/MM/ACV range will be routed to CP. So
 	 * we need to init SDMA doorbell range prior
@@ -1198,8 +1195,10 @@ static int soc15_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	soc15_enable_doorbell_aperture(adev, false);
+	/* disable the doorbell aperture and selfring doorbell aperture */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_put_irq(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7d59303ca2f9..21d11b7c510e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -450,13 +450,6 @@ static void soc21_program_aspm(struct amdgpu_device *adev)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
-static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
-					bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version soc21_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -764,6 +757,9 @@ static int soc21_common_late_init(void *handle)
 			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
 
+	/* enable selfring doorbell aperture */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -797,7 +793,7 @@ static int soc21_common_hw_init(void *handle)
 	if (adev->nbio.funcs->remap_hdp_registers)
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
-	soc21_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
 
 	return 0;
 }
@@ -806,8 +802,9 @@ static int soc21_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	soc21_enable_doorbell_aperture(adev, false);
+	/* disable the doorbell aperture and selfring doorbell aperture */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
 	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_put_irq(adev);
-- 
2.25.1

