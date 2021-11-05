Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D554C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 09:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7A161220
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 09:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA7A161220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967B089C61;
	Fri,  5 Nov 2021 09:41:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D874E89C96
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 09:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6rCTuT7EysPRbZxz5V0a39wBHYMIKnfJR2Cy3J7rMBk4qmddRAL74w8h4KcKavdd/ZRb5xmqmoEmw55EmoVdFB4N4o8ENTOIxq7f6/armC5iilnnR+F6xfIc2hX2o+0XVgTQNnmA5gdko2MG3Wd5mwKQimz+oypDh5HpGVLoTKhLoJLaLu3BIm6o2LMAX0Q8a8jKH+LBgWliqmI4N66bZ39xRG1oXjncAaE2TiA3VATUECR45vrDwHn6L8XeiZ0EcmTqo2kDo6I+7jrMoLDM2LcIOucp0/+xjW9n4VaJL5Ps4H7vpwswS43XBJlWa8Up+REYm39SXN7/n2nsV0fKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19A+KbLsm1uknZ8+DC2KnKj/w7krYOJBCCeu4kEY57g=;
 b=YYyq8qTAArgv+cKvWHujA76o1cMmmXAmc+Ap76MU5U5VuurV021DZSArBhTAXMLkXOKrCts7M5kpAuAcHSX7NTQVi0Rvoo5nwaRetw3XChmcJQQstDrC3XrXiDr+x2M33+ODpjRTmHW5nDscCoAxX6jTevfDwi9GoSi7wnUVxBpnwl6QIJlfDAFU5H/gy0bzv78JENJ02rMmlOYp+WXftYoEGoyHNULUdaJr6rmW5p9mP7tpJr0d18h76/MDFjetrbJCfXipdBzEL6antaBHlbrvqvdFRHSWYcnZR4mVzJMO5PweiUTAsv4ZDI5aMg6Sgk9Dau5gGA7EFT91QB4jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19A+KbLsm1uknZ8+DC2KnKj/w7krYOJBCCeu4kEY57g=;
 b=Af29OduOyCx6QY1D0sHjGX1iWsAdiGKaLZvsBW01MiyMnCAL2k3CpuVVi3XVyKQQ0KYiT778RP/eSZkFWyClieqrhXxlp2tpYX3ZYzllGstTVjZCoeJNUjwrObvbeAKrlf5kh/izp2jRlqvp90R+dpXhnTUHBp/19yLdGWdhaTA=
Received: from MW4PR04CA0089.namprd04.prod.outlook.com (2603:10b6:303:6b::34)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Fri, 5 Nov
 2021 09:41:14 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f3) by MW4PR04CA0089.outlook.office365.com
 (2603:10b6:303:6b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 09:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 09:41:13 +0000
Received: from sdc-lnx-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 04:41:11 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs
Date: Fri, 5 Nov 2021 17:40:46 +0800
Message-ID: <20211105094046.3651331-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad2ff9f-8619-4a76-fb85-08d9a040680f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:
X-Microsoft-Antispam-PRVS: <BN6PR12MB121950FDA541B797355C48A18B8E9@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmUWoaL3QHlVCRwz/jOGlIwlM1jyzpaSAx91vN8KGFYlUYQ3aAdxR4LhPjYbPKM/4oAIszucV07uIMa9FpOBfoCI4qE5ReiCoF7i0etEjMOMs70BUG6B5uja8wEtPe3CwIpY3P06OhMIjw9YokexsJMLXxBIg5Vye1uK+w5wJbsku05Az110JiXqEgLocjUN9ZqIHIjaHmQhJgdRtAYBF47GqwwSZ4LS5c/AInYsKTQCbcnB9epuKDZaHaOo4fTsY2yzwjHTTKgPCKwKIEJpcWIOrnJeRvK5BQBzfB9alWSOKWLvKcLN/AnTqhYE4o2VJYuqJqHoTLwLw4vuNTF7Eed7rkX//x0tJyJB15QPgrFk3hYCapo85368szADez84+672EEmA2FAcbNsgBg71Bca20Iil73S4TssLOjekdM5Q/tbUJ2Vk3veL/d3+wnJ+eS3VE0w0uqzVZktJSXWuSEufzBo+I+rrfj53dNmvCc+Whd5Wdvi2LSlMqtb/1wAOVqGv5wqTOm4UR88RT4Vt/J/ebaKn+8uZZUaaLMhrGZNvU94ZDvCB0A2SS2SQv8i6Q0x5vPiGJoN+UlrbaPDq1OhrhThGTsyAE2EijZbz2KBIDX7V3qkl8WhZIIBXFXTrF3pboN4LVa2MHCaPx8pULtF4n3UBEib4lbMBF9o9Tw+wUbiXyQPOsxED+zj5OK+hjQC9zP92QQZTRwz72FAiEHhr84PquuTgLAig6aprN/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(5660300002)(6916009)(2616005)(6666004)(4326008)(36860700001)(86362001)(2906002)(426003)(356005)(81166007)(36756003)(316002)(26005)(82310400003)(70586007)(8676002)(47076005)(508600001)(1076003)(8936002)(70206006)(7696005)(336012)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 09:41:13.2265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad2ff9f-8619-4a76-fb85-08d9a040680f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In drm_helper_disable_unused_functions(), when !crtc->enable is false, a NULL pointer crtc_funcs->dpms may occur. To avoid this, assign dpms for amdgpu_vkms_crtc_helper_funcs.

 Call Trace:
  __drm_helper_disable_unused_functions+0xac/0xe0 [drm_kms_helper]
  drm_helper_disable_unused_functions+0x38/0x60 [drm_kms_helper]
  amdgpu_fbdev_init+0xf6/0x100 [amdgpu]
  amdgpu_device_init+0x13d4/0x1f10 [amdgpu]

Fixes: ba5317109d0ce ("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 50bdc39733aa..9cfe479c4c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -156,7 +156,33 @@ static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 }
 
+static void amdgpu_vkms_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	unsigned type;
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		amdgpu_crtc->enabled = true;
+		/* Make sure VBLANK interrupts are still enabled */
+		type = amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
+		amdgpu_irq_update(adev, &adev->crtc_irq, type);
+		drm_crtc_vblank_on(crtc);
+		break;
+	case DRM_MODE_DPMS_STANDBY:
+	case DRM_MODE_DPMS_SUSPEND:
+	case DRM_MODE_DPMS_OFF:
+		drm_crtc_vblank_off(crtc);
+		amdgpu_crtc->enabled = false;
+		break;
+	}
+}
+
 static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
+	.dpms = amdgpu_vkms_crtc_dpms,
 	.atomic_flush	= amdgpu_vkms_crtc_atomic_flush,
 	.atomic_enable	= amdgpu_vkms_crtc_atomic_enable,
 	.atomic_disable	= amdgpu_vkms_crtc_atomic_disable,
-- 
2.25.1

