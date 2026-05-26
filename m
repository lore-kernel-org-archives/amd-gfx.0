Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A9CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27DB10E518;
	Tue, 26 May 2026 07:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sWYpy8To";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFB810E518
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWPbTMnwU9GQjU72pcxOSKlgBwGMc/Cr+41VStNYBKQXOVSPKHk22kBAB77zQ8XfHdqt7y1OUAUxlfEv1b/jkV2Y+FEpFYbv2EA67c/lk5MVzd2cBk4QSZ3lJuji5m4d+tSbsUQlXxiY4/PDaO9KbVZGbStH+oUF8gZt8LA6VFIG7oUCLDRLPxDTiyVi0/bgraycNGXZEy0pguKnmpvqqFj/vZ/08LIAHyvFNEBgfeAoCBfNzlRghAX92tIchnuY+XYD51w9otNz7orZCDqdB1GS39UXfLUuQQ2eDGgjxOJ8AgIgyKY0CGLHjrCFOLZVaS3OKj3swvJXWVcOE6qZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/oYXx/zsMaXimG2RClLJucAxw8ZZcFjzNQIfGZiOiE=;
 b=BpxiBv/GmShrlHmrKyeH5GayeyBZO2lPkjEi7vtvORT8aC5K9J3u9D0EWJ//c91tlz5o6D3jSAOv10B0XejQRP8L6nZErfyaOJN0XfLbG6BZIjSXU26tLxZa6rvbJKgU/fb500TZciyw17l0RtJC+ml9oqoNjwnkygdKHRkmlEp48Cf0xxniFqi3vEroeu+WTfcCeIwPTdp6vEaG8lxRS/qm93gLNYyI+llyGJsPf2EFlL6oU1pBxWzpCFn2TmFDfQ9kdbi8Ao21ojmmnxEjGfm+/7lpYBSQdfVEuJGLm5kOlu5aqnJ7gT9fVP4GamnU1r3+R5EtYxJP2clSUhucMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/oYXx/zsMaXimG2RClLJucAxw8ZZcFjzNQIfGZiOiE=;
 b=sWYpy8ToWI9AO+QLAYR4t3VoreO41awSjthxOs5m57Z6bSwwA2ekW5FTNHEGFwANMBSiFgHszvyzNniDf2Jq+0XtRYEXzdVa1K/fByXaRl8heGCjwrwGDnOrA7XWMPUmt9RQxSN/Y6IqAgR5XXD5nk+SoD7zOR64VdthrylErUM=
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:30:16 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::5) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:30:15 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:30:08 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <stanley.yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Fix user-triggerable BUG()/BUG_ON() calls
Date: Tue, 26 May 2026 15:29:54 +0800
Message-ID: <20260526072954.7665-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 10aa761a-f7bd-404c-184c-08debaf8a187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Cq3i/O2xkfVXGlEQMoJYBNJBeuQvcvAoyIPV3yc+WciqnNMm5c8Mnnum5HzJ6QE3NUBAhpqYesRErlClnQ1UIK20+n2zGRyUxF0xY9sNIR0NXo4L3snrNk1KyX+qklc7DyUWMkLDj9lihzyy8/9PhrgLNSstKHAJegfmwde1ZXS7ZLsJmUZrZr1lAPtRuTaYv4rra40f2w6Q9qJmFugbmRK5Rg95KRa57Pi6rHhCTm+eyLDsTWO+FkvD7ZKvT8KGbIkBrmWkLBOLrJV9YdIH0pmvwwXyZmYig6kjz4LBJFiZzUmpDlhdrV9Ra6mBpitjXa+V67gnolzu74BsEYr4oP5m2VS4XM7kF9saxLuW5Oc02aRlIeGQszemdRm0we3MRyGtyShafzydC6wZPseuXsP2bwc5ffGLCJt2bzSRE9VDSWdY9uzaVYfH1/bru2vQi7OBsSsB2Pj122yOpeKLLGbUDBT5t87ZqACWYBRIrHdt6amPHeNvs7NK4WQ6oO1Fj6GlpfTfObx7thYZRFpYWVULT0/5Utkmz0GwZPRrkIAmWZ2FTcQ1bKGAaJmyp8KFKVhboVJdhqK88cY0mLO5FwvgJAMok08a2thHyb7TrAJU9Kn7O3xN54PSUgzCS1H5UYQGIYW9Uxpm2KUj6L1M4HbvDt9cVhOU4Y7jlUvBbA+athz/Y5ww86aUVGaPzXxBdKjcDSZfm/dL3YFnWws077t+KtJIY2ZgnL57JyhD7zY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6X9X5ZpyTa6yw+bkydCbvEcVZrQM+IYRA8Yxo861/rKOxxPwCyKKY2T5zCSx5Y8EMDoEuxCfzYZT3a0ma/Q46AhAy01GFC6e8lbUmTZRpDGZOj9IexeuIMrRj20uDCiuxN1OeS3M0pXB50nwT5ZJaa0+Rk5yKpp+AQVR1+rTT2TJrkdMNUPEBW7sN04QTAYB5pNr2WxzLxs+SwEn720M9gQEKSDweCJlXhgctEQMuX9Rv+ZFLmPOo5uyHzvxsBTJtmYLdj2QtFnqpQCRzSKEaRzDqkgKskQbumsWZur3XW2Nxnc4xuy1AiR84VSFLqoWit3vI1jtpqhThggdwrzkg9y5CeRK/H8QV9KiUx3r1qFydfkhY5FHQRik2vviZrjModte3kVXN3bSdVuIb/LiEtFoSjYt8Ifm0GOmbzUYWnyD0ia9aWi3Pt3luHwtSoVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:30:15.6822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aa761a-f7bd-404c-184c-08debaf8a187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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

Replace BUG()/BUG_ON() with error logs and safe returns in several
places where they can be triggered by invalid userspace input,
preventing DoS via kernel panic.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     | 14 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  2 +-
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ccbe6c885cf..8fbaaf62f7a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -717,7 +717,12 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return;
 
-	BUG_ON(!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4));
+	if (!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4)) {
+		dev_err(adev->dev, "unaligned pos/size (pos=0x%llx, size=0x%zx)\n",
+			pos, size);
+		drm_dev_exit(idx);
+		return;
+	}
 
 	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
 	for (last = pos + size; pos < last; pos += 4) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index daefbeeee4d2..7468855c16a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -406,7 +406,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
 
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
-	BUG();
+
+	dev_err(adev->dev, "invalid MMIO read offset 0x%x (rmmio size 0x%x)\n",
+		offset, (unsigned int)adev->rmmio_size);
+	return 0;
 }
 
 /**
@@ -469,10 +472,13 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (offset < adev->rmmio_size)
+	if (offset < adev->rmmio_size) {
 		writeb(value, adev->rmmio + offset);
-	else
-		BUG();
+	} else {
+		dev_err(adev->dev, "invalid MMIO write offset 0x%x (rmmio size 0x%x)\n",
+			offset, (unsigned int)adev->rmmio_size);
+		return;
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index e1d63bed84bf..c3293e5a658c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -308,7 +308,7 @@ void xgpu_vi_init_golden_registers(struct amdgpu_device *adev)
 								xgpu_tonga_golden_common_all));
 		break;
 	default:
-		BUG_ON("Doesn't support chip type.\n");
+		dev_err(adev->dev, "Doesn't support chip type %d\n", adev->asic_type);
 		break;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c491af21a34c..0f6e2b55625a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -961,7 +961,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
 	if (!aconnector) {
-		BUG_ON("Failed to find connector for link!");
+		DRM_ERROR("Failed to find connector for link!");
 		return true;
 	}
 
-- 
2.34.1

