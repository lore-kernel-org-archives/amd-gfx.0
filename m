Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125AEC7EE22
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6E10E4ED;
	Thu, 18 May 2023 10:53:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87FD10E4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGzcF7v1/SIUvG17ZrTrY7J/Elp0xwo1iXIvvdLcmiZ8fuLYC2UI6hH+gHX1PmhFDx863tRuX1ki4AOuzno1noshCJ9NB32svqrLTPLMNIjp7hAQMN+efRl8R6tRTPo+QFzwSvqn0cqMmSmMzMi3CT8Qb/DDABKz/A1W0VU2N0Kzgm7/fl0agTN8IfWkTfOHVnXmoLp6sAzvKu/RPNeBAo5Q4scATsgkeakeipFXHLBr/A3d+Cla/BMuTmUUcL6Zs+sch2jvzSPgP/8Tzg8z85dtjNz/VsNlOqXoxXTuvr1/23CtQCC8x3K2hltbYAJDXsOf3JNyJBjAZUKQCSnm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eOOHwch7nuBUZirhkkwOZTQ6ShRbp94l7ZfOT+eT/s=;
 b=ZOU5TdGVY6aayp4uZg2zNnQsMBFZXCb5EBW51Q5vWORlpDGZ2pjBHHiRj0pFf6e/H1sCka+/Qu4Hmfj8TFvmILtrpzmoQS7CTh+0JDCZBRtR0l/56aWvbII/+h3OWC4zBSdhcpFRSuMtx8O6Ho+i6XB5niDAmgCoV9ZXdLlX+pcs3bluPAmOJP0NgRmc9V0kPL9LAeidpZrDXJ5kmFRGXXEMS4hqlyG8rvqHVUGbjWR4Pw64ki9HbjlyfuBktVim/a4jw7ichjJZFUtlTkKLV+6NVbSQ6J612mnFmhtf4rjRj9K2MNpdznXViJd24LXT8nm+a6LaebiWzz3ntLZAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eOOHwch7nuBUZirhkkwOZTQ6ShRbp94l7ZfOT+eT/s=;
 b=BJj5TfqhaISeiMw09o4qhLAcUdut0BxkZQZppKg2TcaqWL0vhtx4igVL7FY0f+h9nNyxtUGOYSPLgvnUwrHZJ/gKLcXUQtQ8AOxXV5OAPo3hO3pfVFqseCfYpO9socESrNZQCaWOqERggx/6e5DyoDURHkBTjBQiirpe6/9J7CU=
Received: from MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 10:53:47 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3a) by MW4PR04CA0149.outlook.office365.com
 (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 10:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 10:53:47 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:46 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: bypass bios dependent operations for
 aqua_vanjaram
Date: Thu, 18 May 2023 18:53:21 +0800
Message-ID: <20230518105325.15609-5-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 28787fa8-b2d5-4faf-8177-08db578e2837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9umGBYEW8JaEClw7WlevBWFpzcyAwpKfSurmVyGWem3xaFChcbOXJzRW+J7KT+Zg+ZSOyXZcGPYn8+tCvh2HgJoE3cxCuo5fmcT8rNlOmKONwsIBvRXPQSgEF33SNtWoZRbNeWarJy65MGANCqUg02/DJiWMeZ5v7dhNRAldLda5CT0RIDXMS/cYiZ+xWGxj4s6hz0nKib5KAApybnNDCiFdJg3TdZSbbY3JqbMpp4aBR24MB12gx+AX2CVxmsLFEXQOCRTOjzkQt7/dwW+UafaoXQGmiauLdCqRSaSO1bgmemP3hCie7iQO+sGgQFxETRck15MAfcx6NoPHpElFjMpr0FZcmNQEAA5ZYbR+gDfwWyeWWo5pSkePqbuLH/iFsJycGFIhsbo9KO/WFV6dqmBs5xXvcU/9LXUFKdvx5U7MdQ4LDOgfT1tzT+M8eRp8ySHxyF/aWXIgC2RR1i1P9oGgoFnt3/pb5OicaBkDt8HBa/RH04DSLz9QOuzamcC3gsnR9iPIYaQzMiMvxPTlk/QAt/lLUZ0OEw3Bb0BcVZLeARSfAOO7qtMgZS/Ya4FuKLTGOawi/6w6mp4paUnZlP34aCUTWm6EJ/m0o05JVle2/AKC/nlJX1S6i6kqerGQacZphGqMX5M/Wm4iPsx7BrrzsjMBezXdZEvlUjexEDk1OdO533Jn45fSWkJ3xm+LxbaRaoRbwiwKKd75U2NK1JagIVe/OlRWD8+8+obxw9RCZOJrQ3N3mXCYtWfHueMg+OEac/kbQrRE+eFkxLq1Bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(478600001)(316002)(8936002)(41300700001)(8676002)(6916009)(44832011)(7696005)(70206006)(70586007)(5660300002)(6666004)(1076003)(26005)(40460700003)(82740400003)(356005)(186003)(16526019)(83380400001)(426003)(336012)(40480700001)(47076005)(36756003)(36860700001)(81166007)(82310400005)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:47.3349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28787fa8-b2d5-4faf-8177-08db578e2837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

DO NOT UPSTREAM. need to revert it when bios reading is ready

Since bios reading does not work currently so just bypass all operations
related to bios

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 58 +++++++++++--------
 3 files changed, 81 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a1312e1b5af3..2da967949e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1389,6 +1389,16 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
+{
+	/* only AQUA_VANJARAM has the aid_mask initialized */
+	if (hweight32(adev->aid_mask)) {
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * GPU helpers function.
  */
@@ -1405,6 +1415,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 {
 	uint32_t reg;
 
+	if (!amdgpu_device_read_bios(adev))
+		return false;
+
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
@@ -2318,14 +2331,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				return r;
 
 			/* Read BIOS */
-			if (!amdgpu_get_bios(adev))
-				return -EINVAL;
+			if (amdgpu_device_read_bios(adev)) {
+				if (!amdgpu_get_bios(adev))
+					return -EINVAL;
 
-			r = amdgpu_atombios_init(adev);
-			if (r) {
-				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-				return r;
+				r = amdgpu_atombios_init(adev);
+				if (r) {
+					dev_err(adev->dev, "amdgpu_atombios_init failed\n");
+					amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
+					return r;
+				}
 			}
 
 			/*get pf2vf msg info at it's earliest time*/
@@ -3945,25 +3960,27 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
-	if (adev->is_atom_fw) {
-		/* Initialize clocks */
-		r = amdgpu_atomfirmware_get_clock_info(adev);
-		if (r) {
-			dev_err(adev->dev, "amdgpu_atomfirmware_get_clock_info failed\n");
-			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
-			goto failed;
-		}
-	} else {
-		/* Initialize clocks */
-		r = amdgpu_atombios_get_clock_info(adev);
-		if (r) {
-			dev_err(adev->dev, "amdgpu_atombios_get_clock_info failed\n");
-			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
-			goto failed;
+	if (adev->bios) {
+		if (adev->is_atom_fw) {
+			/* Initialize clocks */
+			r = amdgpu_atomfirmware_get_clock_info(adev);
+			if (r) {
+				dev_err(adev->dev, "amdgpu_atomfirmware_get_clock_info failed\n");
+				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
+				goto failed;
+			}
+		} else {
+			/* Initialize clocks */
+			r = amdgpu_atombios_get_clock_info(adev);
+			if (r) {
+				dev_err(adev->dev, "amdgpu_atombios_get_clock_info failed\n");
+				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
+				goto failed;
+			}
+			/* init i2c buses */
+			if (!amdgpu_device_has_dc_support(adev))
+				amdgpu_atombios_i2c_init(adev);
 		}
-		/* init i2c buses */
-		if (!amdgpu_device_has_dc_support(adev))
-			amdgpu_atombios_i2c_init(adev);
 	}
 
 fence_driver_init:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d466c02857a9..a6a379d3acdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1700,7 +1700,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	uint32_t reserve_size = 0;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (adev->bios && !amdgpu_sriov_vf(adev)) {
 		if (amdgpu_atomfirmware_mem_training_supported(adev))
 			mem_train_support = true;
 		else
@@ -1717,7 +1717,10 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	if (adev->bios)
 		reserve_size =
 			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-	if (!reserve_size)
+	/* reserve 256MB protected region for aqua_vanjaram boot time TMR */
+	if (!adev->bios && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		reserve_size = max(reserve_size, (uint32_t)280 << 20);
+	else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f70e666cecf2..3b6b80d784c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2010,34 +2010,44 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	r = amdgpu_atomfirmware_get_vram_info(adev,
-		&vram_width, &vram_type, &vram_vendor);
-	if (amdgpu_sriov_vf(adev))
-		/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
-		 * and DF related registers is not readable, seems hardcord is the
-		 * only way to set the correct vram_width
-		 */
-		adev->gmc.vram_width = 2048;
-	else if (amdgpu_emu_mode != 1)
-		adev->gmc.vram_width = vram_width;
+	if (!(adev->bios)) {
+		if (adev->flags & AMD_IS_APU) {
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+			adev->gmc.vram_width = 64;
+		} else {
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+			adev->gmc.vram_width = 128;
+		}
+	} else {
+		r = amdgpu_atomfirmware_get_vram_info(adev,
+			&vram_width, &vram_type, &vram_vendor);
+		if (amdgpu_sriov_vf(adev))
+			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
+			 * and DF related registers is not readable, seems hardcord is the
+			 * only way to set the correct vram_width
+			 */
+			adev->gmc.vram_width = 2048;
+		else if (amdgpu_emu_mode != 1)
+			adev->gmc.vram_width = vram_width;
 
-	if (!adev->gmc.vram_width) {
-		int chansize, numchan;
+		if (!adev->gmc.vram_width) {
+			int chansize, numchan;
 
-		/* hbm memory channel size */
-		if (adev->flags & AMD_IS_APU)
-			chansize = 64;
-		else
-			chansize = 128;
-		if (adev->df.funcs &&
-		    adev->df.funcs->get_hbm_channel_number) {
-			numchan = adev->df.funcs->get_hbm_channel_number(adev);
-			adev->gmc.vram_width = numchan * chansize;
+			/* hbm memory channel size */
+			if (adev->flags & AMD_IS_APU)
+				chansize = 64;
+			else
+				chansize = 128;
+			if (adev->df.funcs &&
+			    adev->df.funcs->get_hbm_channel_number) {
+				numchan = adev->df.funcs->get_hbm_channel_number(adev);
+				adev->gmc.vram_width = numchan * chansize;
+			}
 		}
-	}
 
-	adev->gmc.vram_type = vram_type;
-	adev->gmc.vram_vendor = vram_vendor;
+		adev->gmc.vram_type = vram_type;
+		adev->gmc.vram_vendor = vram_vendor;
+	}
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 2):
-- 
2.17.1

