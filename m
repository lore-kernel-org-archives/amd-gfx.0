Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C509EC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 05:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7105F10E3DF;
	Tue, 19 Dec 2023 05:58:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C91F10E3DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 05:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1SBjhchm6vhPq2qb6fqi8uz6k6zJMS7357Trx3VTkVRRn07/9PfBkv76GZpeUv55Hq6NMn5plCIQerxoFMDJyOX5fRtjj3n3+ExQC1cC/fG8pUThr1cIPKtI43OfDkBITrcmeIpmM5G85H65mcmmzl+4FP0WuAlyLFhRF5LF6hPVniANHejaj1Gi/1mUGYVPqUN97FgwOd6JTxV0In4WXJMdyNX0gpfu1Y9StqVp/cvWEuQovuRsmZTgPLOIFNi7BSFwH2O+uRJmXjmlL7cU7CMhXmC77+O1tG3gTAk5j7+uLlPogZLvR9FW3BP3ryS4J20ZElRQFo1MPcHuVb66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zkFk86Y5/Ns33Zr9srZvfjzyixchkv4TBo7pMR7u9Q=;
 b=Kcvg9nCGW+j/xxG6es8N1E/RNKaxWVRM/1tcW8idqZPspc06jD/aRVROrcW0KWYCLJepKYDYzA54o0Qll5p9byBPPBUGaXSsMW3HScEPrXlC3LH1JwiJb4IdYudHCJ3/FuB+G8PKPSizTPOi1dmP1i5yy/ott9GDmf5/xIb6wpwa2+4K4JDouxriNU+D6I6rCo2rwSSENNLigzT5WJLwHKNXjS97Xot14Ctfmhv5geih/T74fHb+PN4FVuSpimC77GLGTwO9WvWueC5mAvzJCrYKoNtZIrmqP9q5XmT0+Bgr9FAhGETUEnq1kUamcb05trx/3pADGmggEe6i5VWxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zkFk86Y5/Ns33Zr9srZvfjzyixchkv4TBo7pMR7u9Q=;
 b=DnnmCQhOGtkoYlBaIPUAQKhwryxeL1VQk66z6HJclYWBrvsGdcx0FREyVW+SnwL1kkHgFnQtnqM1l6R2Nd4vAVCXAPDvh/keAfW9WFn0gcClUMfVX4GxTq7GoBOwaocjyD6KqjN+gGfC1cghPAwjPTSK1TXZ4Wa5ZiXXbOQ2fzI=
Received: from MN2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:208:134::43)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 05:58:40 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::e6) by MN2PR16CA0030.outlook.office365.com
 (2603:10b6:208:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Tue, 19 Dec 2023 05:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 05:58:40 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 23:58:38 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check resize bar register when system uses large
 bar
Date: Tue, 19 Dec 2023 13:58:02 +0800
Message-ID: <20231219055802.304678-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: abc9098d-1a87-419a-a566-08dc00578cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXwS+u9do1K2XVW5Q4K6Et2BZvkN6aScw8YpjiWClX6ESO16x9tXx/FnpLVuh3JipJgiV467YXk1ZM6rXOd01zkU08hyS2POU/I6EYQy6gbrBIgWdTurOgVuLBZMFTFSpXnKPTDL2ZJayrSB1Z6HbLrBoWerxtu96K1sfgDli8onDKFXw1CNGEoLKfeToH4yTsiwVt/DzoZy6ZIY6pfw2I6CUGZPTfs/qpDhW9BlFqJ3XB2FEjUpTGwUa/T0V0x9XtMWQJLJFMNN19uXpibXYeb5OJgLI54DKd+16ekcme8Gse7dpq2q41GJUJC1KI2O++KszIGbMOmFVWw7mAEWapUaprGiS4PuHFyCH8Hyrg4tL4wJw6AoPHFGs49INlA7H1c5JAw/NWRQneaYJ6+P3HW0r0DeByKRHKI+0hSJGAu6H3vbG2kEstN75m+eeWwwhs2kCGmlCNKb4yrwCoJeLpVg1G+kwATFcKTOS8iha0OalIvEg0FpBIhcnLBwzxyTUr2NGgG8tcW8YuWsjMO5MA6zML9IYZzU4XEkOsmJbozqSd4Ninqo1Ga3GUqHb099/ZCR6Y1gv9LyDRNpflko00mEt02paTlVHIMsEWOtMCqssMgBVFETPtk6siir354baSJW6vZW58IZzDClUW27MuHrJ20KCFeZ6JUNoRgQpxyknIkBynS/XvMKf62LoSegIPlPrREl5wBmfJ0o6ovQOcf1R08TCGOhK6/emPKvkxELuqLjmb7Uc2BiMk/EBaHnTNDBjNUzjsRlkxh44bF0ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(16526019)(1076003)(426003)(26005)(2616005)(7696005)(5660300002)(36860700001)(478600001)(2906002)(83380400001)(47076005)(4326008)(8676002)(8936002)(70206006)(6916009)(70586007)(54906003)(316002)(81166007)(356005)(41300700001)(82740400003)(336012)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 05:58:40.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc9098d-1a87-419a-a566-08dc00578cd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print a warnning message if the system can't access
the resize bar register when using large bar.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..e7aedb4bd66e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 		__clear_bit(wb, adev->wb.used);
 }
 
+static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
+{
+	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
+		DRM_WARN("System can't access the resize bar register,please check!!\n");
+}
+
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
@@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
-	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
+	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
+		amdgpu_find_rb_register(adev);
 		return 0;
+	}
 
 	/* Check if the root BUS has 64bit memory resources */
 	root = adev->pdev->bus;
-- 
2.34.1

