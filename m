Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF55C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 02:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60C810E12C;
	Tue,  4 Jan 2022 02:30:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5668B10E12C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 02:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThRbie2I5XvccUFeBKFvGMEu/0Ul04a5VcMeGZDW6jlB35DPsKTTDhwjND7Aq7icGmJbD2ZhznUFnG9/PpRN6OgYhkl6w9djytiOrmKtXX3EyJuKDZz5KySIALkzAC5QA27k3DHdTJ5iAuurhdINvLuLQYh3dDLc/fB17j7iWMiZnxsHRkMmz/W21PYYxeNJP4LyH23q0CL9PkIR+ZwjLSEU9x8aQXxmq9ac3r/tLdsdR+fHVusNQapcKdv0+28N9VMye4KoxWgdqXavd2YVUjCzl5B9bfmesF8ELFlh4Y6IwSZVy8uuXi9GWmbd/X4Pce0HczRxBlyni20IIEDctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pYcLwGOcPEh/+06PBbLiIa0iy4RlhjTpb58IDOFIwQ=;
 b=kqFHX2pZ3TXPdQp4IcnbsbSPqa/RP468a8J6+AgMLgpxyNSPSaN6b4B6K5fODTP9u8kMPwOghr8vOlxhEs6q8KRkdlG3v5+veMmwJH3llvjOeYThbW5IxYtShZIndoXq1gn/8c9iPQxXhtcj8dOHvLWHFew6h5pmWK9giyE1Wlh84nj+PJl3UO7j/5ZkT+blg9uosEBG37LRM5vf5WL1JP9Hv+W9aQPR/B6pjyjoAXYF1RIu9vIqTlJ3kN/3dU31dUKn+sXLfRbFExBa6G1j1cL9XjWh4nKKj6juV8BiqRk4RQpcsRx57jLYee/me8hmut45Yj/p1LPwV9g/2eB78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pYcLwGOcPEh/+06PBbLiIa0iy4RlhjTpb58IDOFIwQ=;
 b=OKpbek06dD+56cK6D1k53Z5iu40sgSSTWvaZv/3k0y/3NdYK6UKXmqyZjAxHwam1kFhAMrVxsdQpbuaP+u8B8OrpwWmh8dmG0eiDn0Yf3Tvg3Al60SM1mySiVq2a8lm7O1LkZODYCBC5s7C2YTspGFKAYlL8EpXlXNL7HWcTRsU=
Received: from CO2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:100::27) by
 DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Tue, 4 Jan 2022 02:30:54 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::18) by CO2PR07CA0059.outlook.office365.com
 (2603:10b6:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Tue, 4 Jan 2022 02:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Tue, 4 Jan 2022 02:30:53 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 3 Jan
 2022 20:30:51 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <andrey.grodzovsky@amd.com>, <lijo.lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Delay unmapping MMIO VRAM to amdgpu_ttm_fini() in
 GPU initialization failure
Date: Tue, 4 Jan 2022 10:30:36 +0800
Message-ID: <20220104023036.2114-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a71b56-cf1a-43d7-6a38-08d9cf2a3b52
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1195C86F8916668D56D34CD2E04A9@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBP6DElCPCaY3dwHCbcTh1hvnGWIKtPoM8i52cqalKp+b+iqexIUdoZp0DpctkS9y52pS08fJNYlvrWCZWVCEOgxQxfiAB19QAUl7Jc6YLfF81MpPvxaT/bEggfeG00+Pf6eadBexeXukTo8iK2sLInT0FTmbC+W98gCNS7lpHyLBy6+U8g97AAA+qNKYR14sgjbG2cac0A22PCALxFhPN2n4fqi78ubTY35LfQ3D7I2O2F3Fxwwtw8Iper1A5XMfYnXrj9s/D3OC71pjhIHhZYG5aEWWqmDuvGnB+gN2UyYNj3cwKZNgB3E+4rQrjXBnVviOicwHLSsy1Pmj8Ia/u26sbEOtcQDcSXieu1cJnBX2E+nL/XkeJnT62E4JpAabQLntswzTVgKIR45we4u3LtBzJTEdSemHD2Nwmw2Yz36h+aQE6ymasINT1rwEvyS2gkxw6gw/QYKwZFAega/YaU+VmCqhIhq8DdDb4vrwlzy8mRkM8BkhuRFeswFTxcc15UvDCqMp76VLaWCj1mla4smFdHAd8glkfDJWqex1x3Xdhy/Uuec8K4arndzsXS+OxbHfIecGvKKYYWPn5WEZcXK86eo4s2xQuPYUq87dLfiI9D0O5AQlM8FxSGFafxa0w76jAiMupqpc+UYb2YMeuka1ojqMRU5FjMCjWxRgqwEHqRWiAq84DzgCorAY0Hrs3ZdIF2Je6z5QdVgerePl3h9sJnnl2RH7S3kWCKDzlpLXuzp/tbtMcqRYuSWwPqWo8ir33JEsqyczGUJO1zZU/U0fMhLruSlv1I68VuIrno=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(81166007)(426003)(2616005)(36860700001)(7696005)(8936002)(47076005)(16526019)(186003)(4326008)(5660300002)(6666004)(316002)(2906002)(356005)(336012)(54906003)(26005)(86362001)(83380400001)(1076003)(8676002)(110136005)(70586007)(508600001)(36756003)(82310400004)(40460700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 02:30:53.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a71b56-cf1a-43d7-6a38-08d9cf2a3b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the driver loads failed during hw_init(), delay unmapping MMIO VRAM to amdgpu_ttm_fini().
Its prevents accessing invalid memory address in vcn_v3_0_sw_fini().

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 ++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce93a304292c..d6006de57af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3830,7 +3830,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return r;
 }
 
-static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
+static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev, bool unmap_mmio_vram)
 {
 	/* Clear all CPU mappings pointing to this device */
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
@@ -3840,9 +3840,12 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
-	if (adev->mman.aper_base_kaddr)
-		iounmap(adev->mman.aper_base_kaddr);
-	adev->mman.aper_base_kaddr = NULL;
+
+	if (unmap_mmio_vram) {
+		if (adev->mman.aper_base_kaddr)
+			iounmap(adev->mman.aper_base_kaddr);
+		adev->mman.aper_base_kaddr = NULL;
+	}
 
 	/* Memory manager related */
 	if (!adev->gmc.xgmi.connected_to_cpu) {
@@ -3905,8 +3908,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
-		amdgpu_device_unmap_mmio(adev);
+	amdgpu_device_unmap_mmio(adev, drm_dev_is_unplugged(adev_to_drm(adev)));
 
 }
 
@@ -5727,7 +5729,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 
 	adev->no_hw_access = true;
 
-	amdgpu_device_unmap_mmio(adev);
+	amdgpu_device_unmap_mmio(adev, true);
 
 	pci_disable_device(pdev);
 	pci_wait_for_pending_transaction(pdev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 367abed1d6e6..67cd12caf019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1815,6 +1815,10 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
+        if (adev->mman.aper_base_kaddr)
+                iounmap(adev->mman.aper_base_kaddr);
+        adev->mman.aper_base_kaddr = NULL;
+
 	amdgpu_vram_mgr_fini(adev);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
-- 
2.25.1

