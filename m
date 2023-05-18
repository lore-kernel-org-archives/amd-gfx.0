Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E93C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6791B10E515;
	Thu, 18 May 2023 12:21:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DF210E518
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZsMprzXiSzbDleH/W2l9ZAMEe31FUz6KKQX53sFYBxM6jUOH1D0xCurZqDv+2ck3q3A0kvxbmIaIIGG7D4l/Yxbb+SXYSyvz1F+fZa4aFKWg2o00UVVDTT7x6oTPlOD93dGhoKM036viQrkYZEeXRCdGVoHxyAZQkxVO4n+gKHpmu8t/bOBJvmJ7+Mk1B0kVk5wsJm6q2WSE/zOiqR0SUV/2pdh8J4DuwlGzw1h4XMiHmYt7jGKgstGlfEsfx2h8z5BtIdLLgptrPPBwDqez2PYnLFbKA+o1f9EGKKh1aDd2pgFcWu8ZiLZ3UEnPrYRIJiO/zp02YJRSwHOmCjqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhYui4RCgKcj3Fw8Gjb+3S6/rHhHD8XIGNinhdRadwk=;
 b=a2rxENCTmmqS3j3vLbwA4TuGLuDEtrZ27Y/nO84Nezr0m1yfymvNa7n1LJDPKhM/GhsosUHnFZMfrOiQXnQoGo+KwJ6E8u2dGlQA/kdPAkuzLZUb0a2NVED5kPnyIS/W33bVx5wxkWJisMexWK3N+w/+J7zQm3clhrBBq2uqtzfJhPfbqTZRv3Juwihh+C6n4DDwzOCrX4IKv7ln386qL/Fj/CdzBxerbOz+KsGwvlxmgGXbyltcyp/e1XGnog2ZyzqdPRgcBToM0rLBWvflIT0yGc1NUDZd1WFXU7lbpXhi9BE1IVXUUiffvgMsKoKlSI7kGa6To+Lgp0FYVx+eqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhYui4RCgKcj3Fw8Gjb+3S6/rHhHD8XIGNinhdRadwk=;
 b=K/yjfYC+a7wF9y516kSN0IC90LFPkA2pgFoOprNuz+feS6OCRYT/5QZ8252wLM45xNiUWp6T79Kvt1jlngn1j5i2UkOfKjlNnl1DfAqfpdgG+D9pCh68GO2/5tTePQCNBbVyqgQ4KIOlPhnCERhjmHvE3aHOXxOfQRq1UmRjUxU=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 12:21:45 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::49) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 12:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:45 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:44 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/6] drm/amdgpu: bypass bios dependent operations
Date: Thu, 18 May 2023 20:20:55 +0800
Message-ID: <20230518122059.28815-3-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518122059.28815-1-shiwu.zhang@amd.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c6d4bf-5169-4918-172e-08db579a723e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVEVk3vNFtMoJ3R+MhBeH6q4dfySv3/r9VWx+UZ47PfTLtAHk/VDHKgqkxwVghbiNlhVKk0nEVO9lCu/6mr4aYvf73lipyaSkoFYgYoJ3LRojyPHiNNWLIETAgDgEnjoSTqhPXOb+lDeUM37Xoc0hXTzpsPomvjx4UcZTVrnEgMy+XUwMspNwxe5Ns2HMwlDI/zHVlMuyyCtN3n/EjxRfsvvO45H9ViXE5fdaxToR+qPYnYavgflm4iVrhzd7ziSbh5w07m+FTkJDMxL4Hu7ERVGrFsa8j24633L6N5gcUbtLgdGyHoyU0k3e53CfMoJZsSnbf9d67vSruPTtfRyAQjncXV9mCGaY/bZAEb82Mo9OoBhVvLBplDsNZHkEHOuGuZ7AAkI9E3krvZ9h+jzKp42XgepDNWnt1tRLls35MT6kXdgWRoVtrIr4EuFEx5dk6byMK6chGzledxWH3KVUyZSPkhY1djDI6A3y4982t0/RR4aGbu7Dxbu8Lv/ci5x6GtPn8GCejC4xNKa4Kw8uzq376ai6CoIFQON27waufF0kSIziKLnAbDMVVxBZpv+2AFn4u214QeOL2bdl8Ua7rGsJjyt9GRYgDtyZOCTGWj9gZfCx+K//ieiNvq0AIeciXCfrzlkIk0UD7gXMEVDCK+zqxUYFRt8/r1utb+hy7iNbR+zmCu4GFUQzzs/imQmX3VesrHpt4e5J8AajA5QzvkGtDpysUY1RL4b0+IJG6EFa0cfNTBFcBdelwYEgICXTUlpgmncN9/YO1x3eA4x6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(70206006)(70586007)(478600001)(2906002)(8936002)(316002)(8676002)(7696005)(6916009)(41300700001)(44832011)(6666004)(26005)(40460700003)(1076003)(82740400003)(356005)(186003)(16526019)(40480700001)(426003)(336012)(47076005)(83380400001)(36756003)(36860700001)(82310400005)(86362001)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:45.4902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6d4bf-5169-4918-172e-08db579a723e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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

Since bios reading does not work currently so just bypass all operations
related to bios

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 66 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 58 +++++++++++--------
 3 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..a36670c7bc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1388,6 +1388,15 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
+{
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
@@ -1404,6 +1413,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 {
 	uint32_t reg;
 
+	if (!amdgpu_device_read_bios(adev))
+		return false;
+
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
@@ -2317,14 +2329,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
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
@@ -3944,25 +3958,27 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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

