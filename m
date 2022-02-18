Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE382C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4840110EE9E;
	Fri, 18 Feb 2022 16:59:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E892110EE40
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBFgo29uJirVuhMLFoO/lkmXoOjWIhAu2JVAvj9hFBtjyZPefTnt+Rvqgkkvm3PaPSaUZ89w1/RszXSDuGHT6ACOxJCpWQvbjUnf8stYv8kVMBHCOiBbqecjKhVV/GFQbb3yq6UhmXnGdqD97GqaoFXAxf5sBfsmsmFRlY4a1t9Pt8Skw0ow3Fce0ISeltJggimB0pxbwZ8nNXMkr+8LQVHbSlBVgCcYk3sXnodfWV1kUl3E1NERE/oJXg2aTJKC5QGNTzRQgDNe6AqomHZt0Arhrg8zM8QmPTjrDA36bsAJHw8xT+taggexQG4cGfwZ8d0od+sjR1F2z/O0BuOlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udk9korspRpC1f+22WfpJ16eXsTAPy8/UdKkUfUl9KI=;
 b=PafJg+2DRM7NqTKU2KT66v1AvAVArFQiVvug3jBPo8sYGLEjEylW8jk/UC08oxOyrcatF2iw2IWoeZNHWDH+m/CzRsYnhB3vnhVG52zoy2YgWCLx5OeMzxun8i9C1YQV5XnaIld8f9wRFQfW9Kl1jtkJraWN5EdChxw3DGWeT4Qj8yxqTGZT67cACnqBkTgeyNeAEQJ2ipq5NE1ttfk/odD/YRuq5so9/zD0T/mbRhpwIr6ckdt+U7uy4c5lehT4kvwaLG7QGj0IpXlSXvXnHrhHmojh/aElVe8B7ofjnNXAHB8Myib67633FyYUlsbLCQptv/DgBbSb1AR0RxQ/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udk9korspRpC1f+22WfpJ16eXsTAPy8/UdKkUfUl9KI=;
 b=0zCvRjmuMgIHGPjomJx7gg6JzjjgPB+0sRopQdXGnSDf5U1xGtCnuw19J5rfjs+53PMq3ORFNuTg8nQCH0gKtRN5dLVih0itEnDAZya/8A/4Zhfg12NVO8MpqeX4x+tXiTQeac/Cdsa3/7u+2MGpjx+BCTILxDpJ+9rUM9Agky8=
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 16:59:16 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::6b) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: Add DCN315 DM Support
Date: Fri, 18 Feb 2022 11:58:53 -0500
Message-ID: <20220218165854.1417733-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c5adb3-da17-49dc-42a4-08d9f2ffff01
X-MS-TrafficTypeDiagnostic: BYAPR12MB4630:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4630BC85C384E22BBD4667D9F7379@BYAPR12MB4630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:312;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfTra9a22pji2djaYzPdOFE421h63b9EcBpg+OH9KieiSDHpqFgsm5RsImGWfLFubcSFjBx+/vy8TcTcvj2eYiQ4BPZamEag2/TwUvxJ+0dSAzTk8Lkc5Jz6vuZhol+KVXxLJ042pU9HoLHZMLfeH03A+WANBBa2tNDuedTuqZ6aFKzzFU4yIsyzJ+BQCzkjHM4QymLztv0/xmcdQXu+RgMU6SW6BPYSVaBml1QuJHH+JGBCu3Vs+AcwHd8t9fyJsTNRMyykVEWYOQfBXxfpofQNr9CFvEtx5s2AIvwFShk5bDjlrVvHSUBNKxdDoGW8aZQuUz9/bjsjQukPHLuiC1/ZKZHsG+YN1BqfCxYMmA3Wye2WrGX5IDfuLqKh+UwpGim27VfGU7rwE3OiVffUpcu5YBXDdqxsG0qn7YuMzgL1C2iCB+2nD9aGVJifenmG8ruHpDbWGz4HiICiCmN3teRn2fNRcdxOrVcgVIcHEOuE93v/R8DuncpuwH0RstITzCBwsNfFBSUTsl6PfneEe2q3kWHbhQf/udRLSMvFQd/7Wplf+FkGvTDFopx+bZ4kUrRk+6XLZowTSZbqS1h1BIA1yhyBK92GEmqblgbaWt1ftX0Z62QeEhjCgZoeijRGbw/d0VMky1JK4MVeYFpr/WC3VNRDGMnw6/OQCRXX8w9CB59I1mmiZr1TtAT7zcsd2cijsrGUfJ4dJ9/jgyzF+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(8936002)(508600001)(5660300002)(1076003)(336012)(6916009)(83380400001)(54906003)(26005)(426003)(36756003)(47076005)(40460700003)(2906002)(186003)(86362001)(16526019)(7696005)(6666004)(4326008)(81166007)(2616005)(70586007)(316002)(8676002)(70206006)(82310400004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:15.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c5adb3-da17-49dc-42a4-08d9f2ffff01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Add display manager support for DCN 3.1.5.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 38f57fe540ea..e8dec724d8ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -114,6 +114,8 @@ MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
 MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
 #define FIRMWARE_YELLOW_CARP_DMUB "amdgpu/yellow_carp_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP_DMUB);
+#define FIRMWARE_DCN_315_DMUB "amdgpu/dcn_3_1_5_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_315_DMUB);
 #define FIRMWARE_DCN316_DMUB "amdgpu/dcn_3_1_6_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN316_DMUB);
 
@@ -1465,6 +1467,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 5):
 			init_data.flags.gpu_vm_support = true;
 			break;
 		case IP_VERSION(2, 0, 3):
@@ -1803,6 +1806,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			return 0;
 		default:
@@ -1919,11 +1923,14 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = (adev->external_rev_id == YELLOW_CARP_B0) ? DMUB_ASIC_DCN31B : DMUB_ASIC_DCN31;
 		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
 		break;
+	case IP_VERSION(3, 1, 5):
+		dmub_asic = DMUB_ASIC_DCN315;
+		fw_name_dmub = FIRMWARE_DCN_315_DMUB;
+		break;
 	case IP_VERSION(3, 1, 6):
 		dmub_asic = DMUB_ASIC_DCN316;
 		fw_name_dmub = FIRMWARE_DCN316_DMUB;
 		break;
-
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -4231,6 +4238,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 1, 2):
 	case IP_VERSION(3, 1, 3):
+	case IP_VERSION(3, 1, 5):
 	case IP_VERSION(3, 1, 6):
 	case IP_VERSION(2, 1, 0):
 		if (register_outbox_irq_handlers(dm->adev)) {
@@ -4248,6 +4256,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			psr_feature_enabled = true;
 			break;
@@ -4366,6 +4375,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -4552,6 +4562,7 @@ static int dm_early_init(void *handle)
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
@@ -5225,6 +5236,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
 	case AMDGPU_FAMILY_NV:
 	case AMDGPU_FAMILY_VGH:
 	case AMDGPU_FAMILY_YC:
+	case AMDGPU_FAMILY_GC_10_3_6:
 	case AMDGPU_FAMILY_GC_10_3_7:
 		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
 			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 8709827b69ad..bf0d50277f8f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -664,6 +664,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 
 		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
 		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_16)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
-- 
2.35.1

