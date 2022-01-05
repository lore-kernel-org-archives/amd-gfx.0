Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579D3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 04:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1D210EBB7;
	Wed,  5 Jan 2022 04:24:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7316510EBB7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 04:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auXAAZeTDT8D3rq5ZHkhaIkve6kJmMIwwCooy4LCrklluZ+DC4TA5b+4MWJsRmQkRmMmt8gnJxaz5l+f6ioSN0nZ92iJkuJKWGOnZ0A6+pzMa0KgVnMlA1D7omr+ftr82qSHY7BUx8QEC49xYCpUbj8Rs3tHFpIK9GNlNt9dOY8+gGt6MAQa5eL/cjLLrLuKGBUUoWUYGi0nWEuijioJbq2zT/VChzNSvzZK2ZS7RAHsNxRKZd/QW6UVIyaNgwa+wmYxx+WH7kM3BSlPtamtKXYaO4vPcIVhGnPwjUWqM4JoUSi7Y34/xu5othi8+VxWJbtr+qCU4vfhNZON4PGOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7JHeJNYk731rRo6K3mIEK7n/MycXee2ISmJNBabMbY=;
 b=jHEGf2bYXkoK216BLv1XBpIFqTONyehFKLfIsE4znwjNeCrvcrM9N5ITpIw18XTgbtf49UBhA1/Sg9HS+CaVIjme4QJVLXHtHz14P5oUMRpw20bZ2lpj7VSo2Wn4PSQfJQOQRpRsHYWcR3fl9Wy5m/1DstJKHSSOurNNc2+uQkV+9Pt3kvDZPdXNsZVes0bKXj6Egvb8tPXtJ2rQzSRP7Jdvu8bP9gcbbROmEBjsAGRiLdzjv2gOCQPCRtCSVSNOzUp7CMPSJG+GWHlp3rFo17YvnsCZHfFPwzHZ4g7u3uWxfS3sMxIzsYQ9fnUgS8dIJ7Ue5TcKkfBlmMCPkpCLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7JHeJNYk731rRo6K3mIEK7n/MycXee2ISmJNBabMbY=;
 b=GB5aPmeDf7y4R+xdoh5Y/Alb2tTUstPws+uUKb9rOibqdHVIreNnF6U84qphTQmYJEKwLuT4zwSl3MgY58lK/LcySmCxAd+U+kQ7fDj6a+vs9CDLgVH7zUYWkoodi1OYKxbCuPWL0RN9qDJX0ExmpONG/VmahXuaA4OgGYYicN8=
Received: from MWHPR1601CA0020.namprd16.prod.outlook.com
 (2603:10b6:300:da::30) by CH2PR12MB5018.namprd12.prod.outlook.com
 (2603:10b6:610:65::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 04:24:07 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::2a) by MWHPR1601CA0020.outlook.office365.com
 (2603:10b6:300:da::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 04:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 04:24:07 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 22:24:03 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <andrey.grodzovsky@amd.com>, <lijo.lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Unmap MMIO mappings when device is not
 unplugged
Date: Wed, 5 Jan 2022 12:23:44 +0800
Message-ID: <20220105042344.988200-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7349285-3399-4867-107a-08d9d00336de
X-MS-TrafficTypeDiagnostic: CH2PR12MB5018:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5018214FC5BCB1A9AE4B898EE04B9@CH2PR12MB5018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kqts+E71bPKijMNfM5qH/4C/NJyvbwp6592vNawxmdBbLQOA8wafDfoqQlLrA+a2lHGSgacivd2mf8oIa9M5SWFUXeaxkGGySqjiuRUW/x4vJqqATBge3+6mFQ3PP4hYP1S4o9PS/We0ur7qjgsreqXDxucK0oFmt/5b6TRWn1m08k1uQ10xEL1G4/gIfIAvrnbz783gBFy1Dn6dYtKDfWl6NNsIjuA143lS0gxxdeJDTdbCzXUffyKAaT12cCKcQGYNJGisaR9u/KPKs5/bPmQoNtqUNpt9crJeEMp6UlleVabKuBUWAY+Wt3obobT6aSNT/5mLQyIzzgPLE58lCj3VtY9U/GQxzqCnCaLEVrP8aXA4RUpxIXmR7yljBIJCPqruBpgPuhrcam5/zjyBf5nqXb2TROzcTwm8Z5kF6NFfRVpEGb1r+LF7AwZ3j73YMUp+oEU5+sYILC1snDYSl/qvS3nT2HXncs1VSCahj/j9cFxrzuGYJw5ofSqKAdkMvYax5pTambXHGy5IeYE7TvvQDD8LHyXJSBTT/vjX7PZA2nlA0jiNKoMshcyZ2LgFvg9HuffDm5ccHl0Hzo4qtm71eS9Idma5k0dx73ZWh6S452Vry9CB133PHUd7E7zxdoyTTbrZikQY84eA3QUKn/AVoMb0Ma4WZgQw/npHW2gRCc11x22RPBZnhKSgSLw6GiA8efXWBuCgz1OT6NaK2QGwXgzoFSRVomIX86sjaWBmQ7pwVD8By9i3u7m1fLVIZp2QeME45/ub2dxEQipezuIvN/E2+jOD/lrczh5UvKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(70586007)(70206006)(8676002)(8936002)(40460700001)(54906003)(426003)(2906002)(356005)(47076005)(1076003)(82310400004)(110136005)(81166007)(83380400001)(2616005)(5660300002)(86362001)(508600001)(36860700001)(316002)(4326008)(16526019)(7696005)(6666004)(36756003)(26005)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 04:24:07.1919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7349285-3399-4867-107a-08d9d00336de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
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

Patch: 3efb17ae7e92 ("drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
is unplugged to prevent crash in GPU initialization failure") makes call to
amdgpu_device_unmap_mmio() conditioned on device unplugged. This patch unmaps
MMIO mappings even when device is not unplugged.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 +++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 412f377f80b1..16dc16c860cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3832,6 +3832,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 {
+
 	/* Clear all CPU mappings pointing to this device */
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
 
@@ -3912,6 +3913,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
+	int idx;
+
 	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
 	release_firmware(adev->firmware.gpu_info_fw);
@@ -3936,6 +3939,14 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, NULL, NULL, NULL);
 
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+
+		iounmap(adev->rmmio);
+		adev->rmmio = NULL;
+		amdgpu_device_doorbell_fini(adev);
+		drm_dev_exit(idx);
+	}
+
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
 	if (adev->mman.discovery_bin)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 156002db24e1..ff9dc377a3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
 
+#include <drm/drm_drv.h>
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_cache.h>
 #include "amdgpu.h"
@@ -1061,7 +1062,18 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
  */
 void amdgpu_bo_fini(struct amdgpu_device *adev)
 {
+	int idx;
+
 	amdgpu_ttm_fini(adev);
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+
+		if (!adev->gmc.xgmi.connected_to_cpu) {
+			arch_phys_wc_del(adev->gmc.vram_mtrr);
+			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
+		}
+		drm_dev_exit(idx);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 367abed1d6e6..ea897feeddd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -42,6 +42,7 @@
 #include <linux/dma-buf.h>
 #include <linux/sizes.h>
 
+#include <drm/drm_drv.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
@@ -1801,6 +1802,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
+	int idx;
 	if (!adev->mman.initialized)
 		return;
 
@@ -1815,6 +1817,15 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+
+		if (adev->mman.aper_base_kaddr)
+			iounmap(adev->mman.aper_base_kaddr);
+		adev->mman.aper_base_kaddr = NULL;
+
+		drm_dev_exit(idx);
+	}
+
 	amdgpu_vram_mgr_fini(adev);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
-- 
2.25.1

