Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A817EE74911
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 18:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F0210E193;
	Mon,  2 Oct 2023 18:49:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9E810E078
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 18:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhkE46tQ41rLnb51Z/rUK14luZlD3RxhQuOW61By7WdlNaS9OsHCdl7R41ZN6TBGPtcxAjmoF6QQsbYwxkHCbXE6JL9uhruZVbLIwA9+UffMBNzGR3Idg/Mk0dGAhCTMFD+t/VUfrNbAa0RvpQifwljaEaNR2BsDvLvX2K1Jf8CgvKSbVLEkeaJ4e7AglkQtsTAUTMLiaF4G5DG5D0cvg3LRbgqjIW22rANrr1R/l8SKu7E/T4GUkYUaAlXCTWG35OdbLBNgfa921eSvov5dJ98rBEz/795cDkwScTTSzMbTStdVINaLPZGSfCeyeTneFNkjqonae+1OfwyWfOc3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BffKaru4vJ09TADzG9FfTHQrEhTPf5dj06fxL8s//fw=;
 b=LptQl0NznRaMjlTU+RcDjI6x4NIFJNhXnSN1F1/AlutJY39N/OUWlRdpy/3oOqtwl9w8XgtSSyBoVifUccvRGUtcZ7OFNNZwEgbZY8OHcMcdeJXs4q9Qb7xTOH4QaZVAT7houQPNrR8Z9OpPgSfBDARcl8SSNw8Z/YWE8yc+VLHMtVXh1A0LAXhIz/3sQ1hA0BHziLBMu5ofMi5VL2HEjTEMH6SFlV4pA/8k0yr75XrxC3KSuhtwJ7BZLTDyyF/AN8vp1dRM5K7YihZNrVHt1t2DZgHbrdKDfAFz4tUDxb/YOCBApagTv3DNdtEBx2u0NFfDRwswALfxjC6k1orLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BffKaru4vJ09TADzG9FfTHQrEhTPf5dj06fxL8s//fw=;
 b=B+FHBl2SB7jOyGO1Jms3d7ZKmLiGSeqcrnD2bmCJa5Is9PNOd7R/nUwOQ/DPFo87/kSr4e7dCKbgBx6RBvELsblftAINLLpDajVM5DUPicKKqhMA/4JJradDOw1xbo9zHMa8bEL+qFcSYqnHdS9vF+F2/StOgNspwlqY6wFUasc=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 18:49:35 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::4f) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 18:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 18:49:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 13:49:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: fix avg vs input power reporting on smu7
Date: Mon, 2 Oct 2023 14:49:17 -0400
Message-ID: <20231002184919.77753-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: abcfe325-1bdb-485e-1bfa-08dbc3785290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhgrAgV50F2sjK13WjLd65sPluUlR4hFocB8O1irO3rRcCG3Go8me82EiK2KRtk4XDv3/LY7QUfdCAd3vvEOtJHcSXwuEs3kaNipLLUrwlrsPWm/57G7oTBeltv1/rKh/3C7EpJsklIysJt4VymvNbzLOvptlgMWtsShq51WU10IOuylVMbzqJ7LldVZhwxqpeLRaweA2yjTH3iW/IQY4NOo/z4In3NnP2m+U3GIXgEPO34fdYvLWKlehF+1vLVm3vT6LY/DR1k4UcCo6eDjircfxqDjg3aReH3+Xui0ZrlnMgZ096iWBy+ipw1Jl/yyD48FPOZbJG9Z7m7O7/MhXTKa73Pd7RtU8GUyYj+FhSCehOdg4gIpdM2P3C3vL4TPnLz3nQ2vu6eJP7ltZ6qXm/93ffKN/ZnlQbdn/lCtsQ3R8Z/L9pq1rGB159kP2hd+0SCFfWApao9T810x/w8syIfAzMrE4TIyZRD5LT7lSy17kxsyMl2lHFYa+D/Jj3xOM787Vf2pbo1g/40VjZur+Ni/qHgegmNZmkueJlbUfcBbcbBrqwckoM1//u3GWUlKrdYgkEsqZ4W9hg13ujFngrnhW86zyMg4Uxm1jfZT1865XmkZfuPNGucs00Jxn+a9w1C8oVz8pvMip9bj9C0gkzLfQFM/ATaM4Yx8fh5uZ50HJJqvDUDeKfWpMR2Mowx4pZ2kSuq/Gi3if5IFBO6g6gHbx8MCOQbjhHLEaAzAPbK9fueWKywlEKgQWigwQCK6WwUM/7G+9N8j/XaTkKB1zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2616005)(70586007)(40460700003)(16526019)(41300700001)(356005)(83380400001)(6916009)(70206006)(2906002)(316002)(40480700001)(36756003)(5660300002)(81166007)(8936002)(8676002)(4326008)(1076003)(7696005)(426003)(6666004)(86362001)(26005)(336012)(36860700001)(47076005)(82740400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:49:35.1412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcfe325-1bdb-485e-1bfa-08dbc3785290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hawaii, Bonaire, Fiji, and Tonga support average power, the others
support current power.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 5a2371484a58..8052fe3379b0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3997,6 +3997,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	uint32_t sclk, mclk, activity_percent;
 	uint32_t offset, val_vid;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	/* size must be at least 4 bytes for all sensors */
 	if (*size < 4)
@@ -4040,7 +4041,21 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		return 0;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
-		return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
+		if ((adev->asic_type != CHIP_HAWAII) &&
+		    (adev->asic_type != CHIP_BONAIRE) &&
+		    (adev->asic_type != CHIP_FIJI) &&
+		    (adev->asic_type != CHIP_TONGA))
+			return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
+		else
+			return -EOPNOTSUPP;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
+		if ((adev->asic_type != CHIP_HAWAII) &&
+		    (adev->asic_type != CHIP_BONAIRE) &&
+		    (adev->asic_type != CHIP_FIJI) &&
+		    (adev->asic_type != CHIP_TONGA))
+			return -EOPNOTSUPP;
+		else
+			return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		if ((data->vr_config & VRCONF_VDDGFX_MASK) ==
 		    (VR_SVI2_PLANE_2 << VRCONF_VDDGFX_SHIFT))
-- 
2.41.0

