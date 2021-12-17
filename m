Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1739C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D54510EB53;
	Fri, 17 Dec 2021 15:33:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40B510EB53
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VImj0LXByz6k7c9dlZe0HdwHZL/5sGBn3F69gHB2O/fMKydjIROS5zMMg9mS+ft1pGRyV4Umb4PRwZd25b8AF1kkCwxgpkuTAq7rRiVXXfh9gSVLDC6aXuf1cVRJtvUxCsO/YSa8GExgjKe2SneCfCd9Bkb8iIujaZ6JtS34F7ifdJ/u/XW1YfwxtKdXpt7u+RJSNQmoIZTdrArhJzH44cctRe2pTzf+Q7jx64dNIN/bAggE4gO2+oXLARLkjZLatsiPtY6BT2F0d03jAw4FMw6NCQLapcZ9FtEEqsMUhwc+ozsv7npUG2t8dIpqPwEvzyvl6thxcSnP1LsOuNcnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHqrYBwNKhsRTYAnZjkIpCEku3U8Sma1YBfdMkXM2PQ=;
 b=R9an6icev2BbVDhJUdXm5AB155fj05zp7uR3/s4C2NvUQjl1wXNmO2NoJdUVbNwZ2kFM4IdCeOYtOajHdH7aJ+G4NNr2+2mjFhNMvW3d49LQfcgPQZKqeBEv82MrJP63I/CGj7G9nCY78IPxFwzTeO4l7qdotegDbi3SZFvK5fugd5bjhgsaciWz01/NonmWvkT5FsesogxdgyAYlewtbGvrNcTC7Z2VGkxuv7YJU9bNqN0TKtVCTRVvnocntFcWNYZfr18Pl5lAyOF9PmS3YavQWuz70/yDxO14/dFlUlJv6djlhYClNUwCKKFsjTwh2uXsbKYP/aA4DfCdEHk88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHqrYBwNKhsRTYAnZjkIpCEku3U8Sma1YBfdMkXM2PQ=;
 b=P108JtBdONz47tqQZsTjZtirtjKs4xaoddKLmv2cIWD//FlmT+wNVnNzms/kSKc+zuuUh5jPOmVb+OEP6DjCnjyLYCJeuTFca7lrqxc87gcK2TSCtdxAUufop2IqOMyypH46PAe1MXAhpEfjkZrBmSrmdMpd1GbaQ4jYlOhzT2U=
Received: from DM5PR22CA0019.namprd22.prod.outlook.com (2603:10b6:3:101::29)
 by BYAPR12MB3445.namprd12.prod.outlook.com (2603:10b6:a03:ac::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 15:33:46 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::fe) by DM5PR22CA0019.outlook.office365.com
 (2603:10b6:3:101::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 15:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 15:33:45 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 09:33:44 -0600
From: sashank saye <sashank.saye@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough for
 sbr handling
Date: Fri, 17 Dec 2021 10:33:24 -0500
Message-ID: <20211217153324.181888-1-sashank.saye@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ad461d-fc80-46fd-33d3-08d9c1729d53
X-MS-TrafficTypeDiagnostic: BYAPR12MB3445:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB344510711F66438A78C997FB90789@BYAPR12MB3445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1aU9n6ObF46aHe60BUTEqsooQ61rJoqJks006wN/dNwG5WJxmvjEu/+mjX2QzEdjGTPEl6XjFX6Z0qnzjI7eEf25aEoqsS3ruolo6wkkracfkQC+mjjt5Vquef3Qq+tjL0XZpCtVCEvSl3QVGEwinpmph0fuUCKDQ+36hqR6PJYt1LIg0zemSGg9j7WtmVCWjgbcm1qUlt0zDhNBA7jkcw0JJTfnSuMEMjX8p+yCWTlnVgutW0xXzZ5UnEnqx82BqAASTrnMfD7wBGapPtbHPKqsiVjujbj/XqvT0ZHgdIQf+WqLuyAJPzVJpUMRdJSCkCeqVbCZew4LaC0kw7zntUArR7yLZ0DCBXtgs6x/+rIr5luovUd3Q2xSJeEcPFez+q/H8cZ2UV6GX70JpN/gD6EFpVUoyNX9X6kssL8x3q08+IOfDJez59MY4r5FBSVDgVTeoqKvin7v0+gsQ5VaeNIG5BOGNLo5rXyFxiMvQtXP/3YSkkWvZmb2zlJdbb8QPwFV3nVDDIsA7cR5qeBLHhtz0yCdiucWtFUPHtSAyoHQ3Pa73LXBmF/aDZ14yO/1TcxDAsTsMpaRAE2D4x7p1hhVCQooL/wF59cBZzgzoV2JuUN7Ofl3UQXRimcZAbjs6+40cbqgaUd9PAUtgYT1IEFNKhhQg6pbRg55bfYhcUCaBAaw6DXWBkAB9uySkPtkAtae5cFSax3fwqoM5Ka7n0iKjfyVfrdzzhNPguaCNhYTZVWY6Q4QkEy6yGZKvPEuvc8BNbEEhRYI2ADUcLe9CJ+RR8zvXRajM0cvBrbsZVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(4326008)(186003)(16526019)(6916009)(8936002)(7696005)(356005)(40460700001)(82310400004)(83380400001)(81166007)(1076003)(2906002)(316002)(70206006)(70586007)(47076005)(86362001)(36860700001)(36756003)(8676002)(26005)(6666004)(336012)(426003)(508600001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:33:45.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ad461d-fc80-46fd-33d3-08d9c1729d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
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
Cc: sashank saye <sashank.saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Aldebaran chip passthrough case we need to intimate SMU
about special handling for SBR.On older chips we send
LightSBR to SMU, enabling the same for Aldebaran. Slight
difference, compared to previous chips, is on Aldebaran, SMU
would do a heavy reset on SBR. Hence, the word Heavy
instead of Light SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 ++--
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f31caec669e7..06aee23505b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,8 +2618,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type == CHIP_ARCTURUS &&
+	/* For XGMI + passthrough configuration on arcturus and aldebaran, enable light SBR */
+	if ((adev->asic_type == CHIP_ARCTURUS || adev->asic_type == CHIP_ALDEBARAN ) &&
 	    amdgpu_passthrough(adev) &&
 	    adev->gmc.xgmi.num_physical_nodes > 1)
 		smu_set_light_sbr(&adev->smu, true);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@
 
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
-#define PPSMC_Message_Count			0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count			0x46
+
 
 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
 	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
 	__SMU_DUMMY_MAP(RequestGfxclk),           \
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
-	__SMU_DUMMY_MAP(UnforceGfxVid),
+	__SMU_DUMMY_MAP(UnforceGfxVid),           \
+	__SMU_DUMMY_MAP(HeavySBR),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..f442950e9676 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0),
+	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,                        0),
 };
 
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
@@ -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int aldebaran_set_light_sbr(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+	//For alderbarn chip, SMU would do a mode 1 reset as part of SBR hence we call it HeavySBR instead of light
+	ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ? 1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 {
 #if 0
@@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
+	.set_light_sbr = aldebaran_set_light_sbr,
 	.mode1_reset = aldebaran_mode1_reset,
 	.set_mp1_state = aldebaran_set_mp1_state,
 	.mode2_reset = aldebaran_mode2_reset,
-- 
2.25.1

