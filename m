Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A239DC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 13:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1898210E0BB;
	Wed, 24 May 2023 13:35:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FCE10E0BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 13:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuHHulxQIbMhfZBBdizDaUhBmeMXaV8+yGjl8y/lWNw8Bo/LE0WZGkrDF547DOuX/2xn7YKZggTFPfCLQiT1W01+1tG1+WQj+q9D72OLyiu1wj3EPSq8V1TjuAh06qA+lf2oq8IhFUjljJ630goeCq/ADylzviCbWlqdJwuU4C744av+Qjfj+vxL5zfQV362b4qvARsWM7zf1d55Cd1ueztp/F5JAxq5sXg2+Mz+kqf1xa1FczeeWgvKW/0I0VgXiVMbmMAGUu/+uR2OOZ4jwvNlak7aIetpSplHwdslJSlYZmEgahDtenUW0XL+YwUvo2l3GPfQtts5znTJLkv+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oekZ8BjZdR4q9TcUVg6JUXa+4HBgn1SPCptXFwjZKgM=;
 b=C87yFifhBmdoIn3mrQ4jO7H8Q8WbHqh1r8U3cmlHqjiw1PJddEL1unKIyO9C0Yh+bP0AeL5+Atmil284c8pTBnbJTen58XQpyTJYVA3IeXsE/cPJBbIXcUu16sb7HRmIWhRWz9PJ7B1z4+jaoyQa2BYAD0Tdcqe3ztZXO9GI6zJMfFad0G2I85si3V7PvQPOwC4AVa4um7B8nF/gFnQUbDuoKdoW3NuyfhN8MIIOW+C4lh24EobPNMIUy1Z7g+eInj5lRx9uaPI4HK8D6lwnkfHbdha7cS1Zvd93P3E+jPEJzwH15t2m5BfMvrJVyj9GmI9ELrvZ7+lz4vomAgw+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oekZ8BjZdR4q9TcUVg6JUXa+4HBgn1SPCptXFwjZKgM=;
 b=zXGW9A3AjfugSHRxIu3k5nuU3Y7kbTDOTFqB5eUGPBxaoFx9W60tQADCn5A0nq4Df3/5JyxJ4AjmHb7cBucSY/noO0D0RakvGlu3yCGz6pzaFbselzXL/Yr24L8ovNcGYrVdE5KZ6B9G1ThdgKLqzw9vp5WBA/YrQdqyIMVatOU=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 13:35:16 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::36) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Wed, 24 May 2023 13:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 13:35:16 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 08:35:15 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: bypass bios dependent operations
Date: Wed, 24 May 2023 21:35:02 +0800
Message-ID: <20230524133502.23073-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce00c0b-6185-4528-036e-08db5c5bb5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCwYIQITeR1Lj/J/UaIvpw2P2eY4mi9qlUKA5Cyj/W3Fjnlafc2vGkrxwp96CI6d5tfzOsao3BPfOYB2hXbuVi5JmFJXcD06+uKxpdD16wOJC5srkZwIbntvJmxQ1BxyJ6xCKK0VY7/xhnldIs+GZrODyZc6M8bBulYleUFfeZagQSuUfxZ8kJ3EM+EHj7P+95bn31fj8ctp3A2LIwXTYUbzd0mEJcBsRKGbIJsWOZ3CqZXOVioEck5V4neTY22NzGiJhggLZFzzAOGcpiz0Wh/RgTpS9w8hJpkbsoNlcJil+idMSyXPEPfiHNLubwrbE/KcM8Kv6lz7fQmeJND9JzKtKjQzap5P+Puwfn27OVtY6ntk2f8ZUeN2jt2hH7Mfh6NqZdE92JnrLIVBTRcx6CHeg9Di8fv2ilczBJsnEuF1gUA5PR2Ad5b8HR5GtCH2F7lg3dYgugzN7XXNpaEexDpE6h6HIhVJLN0nlUTz7k0VyLiTiqQYFjSh+y/HxxGq6aYP90+UqEYNQj//kQcIXrESa2YHbpBlqeFRg6GxO2qj2Z/O128b3ly5VMo4pWRqg8gghruBfDfuFzgA/GcT9WP3tdUzFH0nzGTWXXs4pPRI/WeDKNipNx3FVOq6vxyCbtTtMdbHMY949dZ22wXerUuGg6tLwupeNRn8/FOikxo0x5lC3bpRB7IbMsLt+BKwjIiCe6IL7Z0hrvJq0FdFBE/sEvJDPx20Dk5G9KbOKop93DZFOqAchiS14y95zYR1oOzyPMQIcsjXPpy7nlEInQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(82310400005)(2906002)(44832011)(8936002)(316002)(6916009)(70206006)(70586007)(8676002)(478600001)(2616005)(47076005)(83380400001)(40460700003)(6666004)(16526019)(186003)(36756003)(26005)(1076003)(41300700001)(86362001)(40480700001)(336012)(426003)(36860700001)(81166007)(7696005)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 13:35:16.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce00c0b-6185-4528-036e-08db5c5bb5e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

v2: hardcode the vram info for APP_APU case (hawking)
v3: correct the vram_width with channel number * channel size (lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 66 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 63 +++++++++++++--------
 3 files changed, 85 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..46cfa8821c2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1388,6 +1388,15 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
+{
+	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU)) {
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * GPU helpers function.
  */
@@ -1407,6 +1416,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
+	if (!amdgpu_device_read_bios(adev))
+		return false;
+
 	if (amdgpu_passthrough(adev)) {
 		/* for FIJI: In whole GPU pass-through virtualization case, after VM reboot
 		 * some old smc fw still need driver do vPost otherwise gpu hang, while
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
index d466c02857a9..6e34a67e606b 100644
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
+
+	if (!adev->bios && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		reserve_size = max(reserve_size, (uint32_t)280 << 20);
+	else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f70e666cecf2..75f258322b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2010,34 +2010,49 @@ static int gmc_v9_0_sw_init(void *handle)
 
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
+	if (!(adev->bios) || adev->gmc.is_app_apu) {
+		if (adev->flags & AMD_IS_APU) {
+			if (adev->gmc.is_app_apu) {
+				adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+				adev->gmc.vram_width = 128 * 64;
+			} else {
+				adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+				adev->gmc.vram_width = 64 * 64;
+			}
+		} else {
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+			adev->gmc.vram_width = 128 * 64;
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

