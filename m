Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30298606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WEsGMMgQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9701611225E;
	Thu,  5 Nov 2026 09:16:50 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931A211228A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 09:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJx8YK4QQfrvFstWMsZwzt4UmExA+F5/frdTc9SpyynMq51epgClrB0hT4rZCuhUW7myXniPfQJkZx+SjEk9Vj37QI035ykqTzzrh752uLXGcpj8r2mZOLZtnTUPh08h+HJghmhBYWJVwElNqeMGo60mFgKiAeuApKKwBn2JXmt+4VGw7H+pGak4SblxzwLXYlVw+RuSEluQF+px1eC7uWJVOU4V3IUI9xv4OCDx/k3YJcfHdgPi+y36wWYRqGDPn9XdeOPus9ACvfBgc5Y6NQpyhxrkToLGkyuiYoRj1hDyTIw51jdxA7VsygUmWrCXthxalNiLNB+m5Y0UQdmDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFr+acg4mKONrI/rYqUPmCP4scLYmGssRH8bRqxcswc=;
 b=XgQNnK3nVKmskUixo+TeQkrLRNnM4LmvyO3ZP37d7sckxqEayLrTCbdqlQ9U7YRIn0uJcjvU5wbxl7Awus/XEDgMjm6Uxd4/Ja6gLw5NElwiNhcLakUy7CmcrmTlldUfBAQBHivrCCjx9Wmqk7yZvhxGswccYEb8FT/cNIebdr4yJmX89GpBgiISBRiaMvOytfpEdG+vC0HylxQAxEJQ5iLkPpEs3zpsGFECDxUYxO7iT5GJ44NyTDrkE+3UjqYDMElMSvRo4OPonVeJWst1b0OVGVmSy9Qpc8FMaGQCF+QRwfl84eL7spHKsMd4l6WLQQrtw13uTPRj3vdx9Jfxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFr+acg4mKONrI/rYqUPmCP4scLYmGssRH8bRqxcswc=;
 b=WEsGMMgQkB36sAYSgcorCuuFozURJ06lOW641utQwO1MXL5NIOs3jUYji1ekJJb9KSLTMwhmV6eT5jXoFObcI9KiL1wbcmsu+OKm1j54f7Ny+yYA1wRe55K5Vdq5/gv8WqG52edsmk0RAK0quU2sMuQOVOJIlOgN56CuUiFiXso=
Received: from BLAPR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:335::12)
 by CH4PR12MB968995.namprd12.prod.outlook.com (2603:10b6:610:51e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:16:40 +0000
Received: from BL2PEPF000352D2.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::6e) by BLAPR05CA0031.outlook.office365.com
 (2603:10b6:208:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 09:16:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D2.mail.protection.outlook.com (10.167.254.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 09:16:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 03:16:39 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 03:16:37 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: release the IMU firmware with the other GFX
 microcode
Date: Thu, 5 Nov 2026 17:15:58 +0800
Message-ID: <20261105091632.954712-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D2:EE_|CH4PR12MB968995:EE_
X-MS-Office365-Filtering-Correlation-Id: 616a2c8b-db2d-413e-dd0a-08df3b1d8000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|18002099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261009223027099003|261021121427099003|56012099006|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: XXDoEDedueos+ETTjsqaqyJW5JAn7Op1HwWJTlxSubBgeuFPMBTCe3xrfz37y4DYEfbSBecnpIIdLJ3y/4Bj8ZZZKilzTkiBV783nYmej7KgQd+gOGPqS4A5ovcQ1mCAtc9tiTdfzbSEI4XLrqnCmORvy0IrQUC7x0zAlgTUGjeoLttl3nvAXQCJP+7sAEemwxk4MI3LDxkAHpCZlPKJWLU7gM/gHkQx8EyGz5fwl05wiMu7JqxAmGgXx+p3SiyT5kG4UmY896oZna9iXlkqve3D70Wvs6YeyzSZHjpM1mmuCH3yzJs6hk0a5hWC45mFMZcLh4lqnprAPttxxEZYTS8YIEKjQhPxXdBPBq8hr1+VYc7knH4GhTZCZ956+N8P1nllccWPHFXu1NYOIxnWZFPhMh+42ODzoebm7PqX3QrQ+VTuXbI1d/vcexuendKis2Yqp0fFfitnTPNxyuDgICE79qO3bYjufdk0zgTVBSxOA42Mgfn+yJgYcY7naxQE0xj7DjYpRjU1HJV0yW+1otn2/ZrnTjYzPJj0zdmFQ1d6y32J00tILSXs2bMg4jMyAGO0w8smyXPvxXUMou1g7i9uTfgwjZZ1FqVrzm9mKv9wCgeVWfeMKwFjVFkirN/YAwAB9/Pl0AHH+nk/woTnmEPeTsUu5aTuTWfjgxmCFBzDLTlQ0y+SzOas5JePoAvxjUHkpxOCr759EonBGQ92jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021121427099003)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 64XyVTihr3NNUABVD5TS1TJdnOpATKo+jelzV3ff2tPy1ZDCp9Y9U3EkV8vw2hsAC8KEyxrkMCnfts4Gxmzc8nNtNaU1lnnpPyV74cGioticAgt74BSHsYtmN7oSEj/0BkezaYvSGapPppxqx2ff5f09FCh4NjuBKUPHxZ0u4aACc7AZrwGOoLaCt4hHHVQCoLfYwhL58JNvtVMkkIDSu9COuJsl9kyTwN51uEpghfn02mWYLvY/jTQAFs2gvR7Tr0+5ASq5v/TwTvvpEm6mUj0XnmVj+W89SE+LFa/D+nWCFq4Ql7HRw9lvf5fvt1UNNCmGJ5lhnzJBpOY1/cn40EeXqkrTVgvBX+pDGsBhF82Qt7JsNjxi3upNoP8wNJKGKZbm9zsm3wB2BvfjvvAMK5vZ4l9WaGFIiFoT01Y6SDIUg75msilMYH9nglWRlWWR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:16:39.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 616a2c8b-db2d-413e-dd0a-08df3b1d8000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB968995
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IMU firmware of GFX11 and GFX12 is only released when loading the
microcode fails. Every unload or unbind of such a device leaks it. On
navi31, binding and unbinding the device leaves:

  unreferenced object 0xffff88810dd6cd80 (size 32):
    comm "modprobe", pid 2891, jiffies 4294943088
    backtrace:
      _request_firmware+0x207/0xad0
      request_firmware+0x3b/0x60
      amdgpu_ucode_request+0x150/0x330 [amdgpu]
      amdgpu_device_init+0x2d70/0xa650 [amdgpu]
      amdgpu_driver_load_kms+0x1e/0x140 [amdgpu]

a struct firmware of 132352 bytes, the size of gc_11_0_0_imu.bin.
Release it in the free_microcode() functions; with that it's gone.

Fixes: 289bcffb9d76 ("drm/amdgpu: support imu for gfx11")
Fixes: 32d163768989 ("drm/amd/amdgpu: imu fw loading support")
Fixes: a0f8297068cf ("drm/amdgpu: add imu support for gc 12_1")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 430b8f3743b2..d96c941fc9ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -695,6 +695,7 @@ static void gfx_v11_0_free_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_release(&adev->gfx.me_fw);
 	amdgpu_ucode_release(&adev->gfx.rlc_fw);
 	amdgpu_ucode_release(&adev->gfx.mec_fw);
+	amdgpu_ucode_release(&adev->gfx.imu_fw);
 
 	kfree(adev->gfx.rlc.register_list_format);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cb15dad0e57b..ed10dba2b743 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -570,6 +570,7 @@ static void gfx_v12_0_free_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_release(&adev->gfx.me_fw);
 	amdgpu_ucode_release(&adev->gfx.rlc_fw);
 	amdgpu_ucode_release(&adev->gfx.mec_fw);
+	amdgpu_ucode_release(&adev->gfx.imu_fw);
 
 	kfree(adev->gfx.rlc.register_list_format);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index fde1bad5450f..b7e89f5902a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -350,6 +350,7 @@ static void gfx_v12_1_free_microcode(struct amdgpu_device *adev)
 {
 	amdgpu_ucode_release(&adev->gfx.rlc_fw);
 	amdgpu_ucode_release(&adev->gfx.mec_fw);
+	amdgpu_ucode_release(&adev->gfx.imu_fw);
 
 	kfree(adev->gfx.rlc.register_list_format);
 }
-- 
2.50.1

