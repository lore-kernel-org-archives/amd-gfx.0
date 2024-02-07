Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A4C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C19A10E142;
	Wed,  7 Feb 2024 20:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0BrYSEFt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430C410E129
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0Uzo5ckGTKpG9BuobOLMtrnILTNpRRyG1MUQbIRMp44vMkIu27Vjz2Eqdq+0pCCqPy2GRc5OJArm/3L6xtyQbRL4qygK4na08kPym0tK7mR3S3tsekaq7cvLfwRpkks035rJAkgSuv+DSvTN4L7Ry0Yx4J8bGZRGVfbzI4SDJhy/yOl3Z1cEPVKJmFYRSsqHWfmiyhzis3tX8vcTfN8Jxux0NeEWaZnal4Js08UuevnNNol8L8b2OZJISvO4OgugBWJ4JV9o79kQF8iXvsiEAfKmSMyqYU7i4oiuYDBL7D3BbBu16GTU/NAKDSma704A43ADN5hsL308KYUM6IL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Q/EJTz3uGoTJ170UL/2rGxR3cxtwuCe8rxQYz0dQQ=;
 b=LTIb7THso+gQp2T4aN+N6rgf84yPtQfRB4lefaSOSOhdwcVVB8NbQDalqdmyD1YbQ2lz9qSpl0QIA+5ci37FtQodRD300mtkRCdZTLia3xJdam05nAore+B8Actt6AcW4oJsoxU7/ct5Yc5fL3F2+sCz/Y6xqoIilHWb26mcABhWfOgVakAS13W+jffHEWR6dJvpEzXgtdvluDSIdtOzopjyLz6y8Cm7lSY6F+DCQx8qy9DKHqvyxzSODqh5dau5/JLAkNX20kCf+oCNjYBsK/vkKB4otptrOfG1wkocWa+A4nzLAdjTQoRxpwjpu6qBbBw+YJ13pWzSiO+NVunggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0Q/EJTz3uGoTJ170UL/2rGxR3cxtwuCe8rxQYz0dQQ=;
 b=0BrYSEFthZfSTaQdsLk6vBFPx10QjiApcfRB4Sen5OrEoj5SDTLO5HkTRzNG3998xIBfUxIumYuGUF6C/Y9nm3MTiGWta4kWB639Fs4ngs7OoiH68hbuaazbfpFM/oOMShN3hH51xiULTZkIGeK8rGkQe62TTPkmtxYp+ClefbM=
Received: from BL0PR1501CA0007.namprd15.prod.outlook.com
 (2603:10b6:207:17::20) by MW4PR12MB8612.namprd12.prod.outlook.com
 (2603:10b6:303:1ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 20:41:15 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:207:17:cafe::c0) by BL0PR1501CA0007.outlook.office365.com
 (2603:10b6:207:17::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 20:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:41:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:41:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] Revert "drm/amd: flush any delayed gfxoff on suspend
 entry"
Date: Wed, 7 Feb 2024 14:41:02 -0600
Message-ID: <20240207204103.82789-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: efa1834b-298d-4a85-2bed-08dc281d2085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqXmBhsKp0+N9yUJ1o7SXoFibyPTC7e/hvUnvErax2VtnJrASQIQJOMyZU+QqaAZh7komAzIcHDnmVABV6rzs5VnkD2ffBN4SN7+TP/NN/YxmdRKjVIAxnkfX7QL/fP7XO4alzS8fUu+QSxGl+HXPTUT770fWC6EMGAAfN+wFDjv8Lu9xRNEdLieb5vNA8tA1KNb9vvg8jDIQUn/mWkqjp0YBVPpSWcogOcLfyafR92pkmc2uU6b4KLjOI9qJ4koMf9j9fqg7XjPJckYwW3qfWkGXNtAvoL6RgJASB5cTjYt5VKcNC9uPs7KdVafcJYaYy798pYPE7bW6D4Ql/GQU3ipDi8DljW20jRT9EhdfVEQE58VK84bOJH2ZIBuG4zaNwrPq81DEx8ZUsDfKGCuL3EbgS4KRSbeE1BhK7gP0644AZRht63xbNEkdVGuJ9xOG8QveM8lu45VJ7ro1WFt/V3eM4whCbGcYFxSj/jYHhH8duyE7utfrU3NK+cGSoXKEHl3nNu0WcOynh+EnDNdw63tMPO5bQE4D1vKkACoRnlKi3Zmox7cyO/eglWd3oZuMUyJ5VsIjIv4k9Jj/M80cQcCnVw8yi1lHC22+BPoxZM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(356005)(316002)(82740400003)(81166007)(70586007)(86362001)(2616005)(26005)(6666004)(1076003)(7696005)(6916009)(15650500001)(426003)(2906002)(5660300002)(478600001)(4326008)(83380400001)(44832011)(8676002)(8936002)(336012)(16526019)(70206006)(36756003)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:41:14.3903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa1834b-298d-4a85-2bed-08dc281d2085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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

commit ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
caused GFXOFF control to be used more heavily and the codepath that was
removed from commit 0dee72639533 ("drm/amd: flush any delayed gfxoff on
suspend entry") now can be exercised at suspend again.

Users report that by using GNOME to suspend the lockscreen trigger will
cause SDMA traffic and the system can deadlock.

This reverts commit 0dee726395333fea833eaaf838bc80962df886c8.

Fixes: ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 670ecb789d59..2bc460cb993d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4573,7 +4573,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
-	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index aa8e1d29d10a..9831dd854532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -727,8 +727,15 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			/* If going to s2idle, no need to wait */
+			if (adev->in_s0ix) {
+				if (!amdgpu_dpm_set_powergating_by_smu(adev,
+						AMD_IP_BLOCK_TYPE_GFX, true))
+					adev->gfx.gfx_off_state = true;
+			} else {
+				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
+			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
-- 
2.34.1

