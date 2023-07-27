Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278A9C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 17:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F5410E00B;
	Thu, 27 Jul 2023 17:06:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFF410E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 17:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoEbieSI9oI7mpdYH2mA50f+ZLLX68KrK5OilK6CgeNuID5x8yQlS1cFfe8cQoyX0eXVOXou7DuNrlv1CkibGFMjXkbVNYgpGzkAKXD2PgjHTAjfXF8evAMPRhczErnbcj6kZBbhI6UHTkiTfHGZB4UwrfU8VMmwEGu5yrSzG/lun4sfdkuuYoh3PqZCkHZLQRhNlIWy04pDyPNCIbeU/4BmUC8khs9a+/zoUX0hNK1waRMwhYOgCpgUwfJtLcpk9X+1EAGiphhJXaPTIULcBKJKGwcEDbn8acSA6tOciX9csNYpBmEAjQ8EyH1Um/mhX7u3KUFQxoK5lczq3UvzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFKSNjPrzSBGj1TTXh0wtVCpoBthpoXfhy2QctcoVsE=;
 b=D+MYcrGnxDqOjhyOL/Jic3ex0j2GRfkESrilz+n9MMnW1QHwMHzzXQvTdmdqLT+viAo/ciWctLnIP6j655nBGXsQPg/7YMT9fh3Z+G4Cz2eh3qwYy/jSivcf2f4HDbEn64jow9ONpFZH06qfQQndDgWWqkHn8zwnVTr25phaFNV6DZbbb+wGRz0NZ+qEkY9oHZM51ez/7mz6UdtYRn2j1i7xG0tW5eRfxc9HLLZXTezEaOIJC8+UrUY2FxXkgAJYzc5+3JDzvWuQGDDEHPI4Iza0sOcUwElizfyPfqK60aI2X77pPxg5y+NUMCRcIX8yXaHHBPSsFWzBt40m5j6zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFKSNjPrzSBGj1TTXh0wtVCpoBthpoXfhy2QctcoVsE=;
 b=KMK4uMI807+DXDewtpSVagC6IR67VKQlt061wXqZ3etmsSW0cLClHL4G/enh2qbwqndCQOD0pB7pHLyYqFqbDlUIXvrB0cXj+ySns42Fn0i9sJShRWjthogFMFo+AvsVqfGFfvoPLN7ntDknixqdX3b52JXfe050LWRjFiPJ40o=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:06:38 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::ff) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:06:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 12:06:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Disable S/G for APUs when 64GB or more host memory
Date: Thu, 27 Jul 2023 12:05:14 -0500
Message-ID: <20230727170514.9183-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d4a0f6-a35c-4bda-d431-08db8ec3d70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8n8dguVI2QlCQGTwksXatUlX2wDJ0P9FtQfB1eFuzKtwqu2rAlBndxT2m35HSCp/eu+80utjrzXkuogxcc72CgZrN7M0M0YJscy2jf2mvZLUgEelUQbJZwiaXFgS2mpupQNdLXMh9/WQ51Upagu7zt8ibMezyffXuvAFqUurbDaGpKxsPkM/L9Jbf2CgPh3ksLCDjIhjMoKLK7HLAWKUqfFBMJPBifIxpM3KoZMS1RI9H4Vlod5SutdAIup3icdMEBtZjYHIqTTsqmRZBasKNtMo7Z332J6vsiX2HldTKshSsedQHuHvSj1lou4pvmDXI6a9CKbOzotFLKbBNb2L9yOXTcs11sRtNIOXtxIqZoVbh9KavoL5veeJA8oTwaHxFEFK5JmSXicADzVbyZqgUUW8PA9TJ+LSk8Z6Ib01uxrsG+7pRU7Wn4Fxh/Sz+/z4owIklpd/2fWB0uc0/zt3H3+9C23YOP8dNs7QQfhGdRgNktIPG14QMIjgg7auJlWZVeRMZMYMDnUQ+S21ykGgGueCLXyT2fLAG3lYG6mf43+fG+kgNDKxvz2kFIOxh/JT9zAvP35i4Vs4KjSJTj2POwdUoIna0mUbCa4BrEEbd4+yPvlBw1BZbOMuY3PkHWXA44ltz/erqr2L3XH2561ZMfI5gXFBtoB16wflPzxebodaoprJYHcnq2HGVQ9fjl3Y1yERjb55IGIDyT0Whgv9PCP9FVpxodXXQDwrZ/daeRpIGgbFIj/hnKFiAVCWvTPtvKM1T+cZcth4KpdqIcQ0RwN70nmYgjtfV4seMcbA/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(54906003)(7696005)(36860700001)(6666004)(966005)(478600001)(47076005)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2906002)(70206006)(2616005)(336012)(16526019)(426003)(1076003)(186003)(26005)(70586007)(82740400003)(4326008)(81166007)(316002)(6916009)(8936002)(44832011)(41300700001)(8676002)(356005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:06:37.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d4a0f6-a35c-4bda-d431-08db8ec3d70f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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
Cc: Mario Limonciello <mario.limonciello@amd.com>, roman.li@amd.com,
 Hamza.Mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Users report a white flickering screen on multiple systems that
is tied to having 64GB or more memory.  When S/G is enabled pages
will get pinned to both VRAM carve out and system RAM leading to
this.

Until it can be fixed properly, disable S/G when 64GB of memory or
more is detected.  This will force pages to be pinned into VRAM.
This should fix white screen flickers but if VRAM pressure is
encountered may lead to black screens.  It's a trade-off for now.

Fixes: 81d0bcf990093 ("drm/amdgpu: make display pinning more flexible (v2)")
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add S/G display parameter")
Cc: <stable@vger.kernel.org> # 6.4.y
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 93d0f4c7b560e..2e3c7c15cb8e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dc0e5227119b1..a4e36b178d86c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1296,6 +1296,31 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * On APUs with >= 64GB white flickering has been observed w/ SG enabled.
+ * Disable S/G on such systems until we have a proper fix.
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
+ */
+bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
+{
+	switch (amdgpu_sg_display) {
+	case -1:
+		break;
+	case 0:
+		return false;
+	case 1:
+		return true;
+	default:
+		return false;
+	}
+	if (totalram_pages() << (PAGE_SHIFT - 10) >= 64000000) {
+		DRM_WARN("Disabling S/G due to >=64GB RAM\n");
+		return false;
+	}
+	return true;
+}
+
 /*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 77d970a2ee693..f81c6c249c02a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1639,12 +1639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 		break;
 	}
-	if (init_data.flags.gpu_vm_support &&
-	    (amdgpu_sg_display == 0))
-		init_data.flags.gpu_vm_support = false;
-
 	if (init_data.flags.gpu_vm_support)
-		adev->mode_info.gpu_vm_support = true;
+		init_data.flags.gpu_vm_support = amdgpu_sg_display_supported(adev);
 
 	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
 		init_data.flags.fbc_support = true;
-- 
2.25.1

