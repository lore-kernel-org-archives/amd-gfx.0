Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A69E74911
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 18:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987DC10E1A9;
	Mon,  2 Oct 2023 18:49:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23C210E078
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 18:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey2vsOPyWFTdqWxaN0LELqQUILqWDp7kX74H4SA+av0IXyd3X43y5y32Us4doLSlnzGz6lanpee/NPliGioyimhzyS7cdrd5TF1Xx71Z4srd27BQk+djcF6c6deA1eHKFZXrbrwajoNW+qqUh8GWA/pQVAbhatKd0tircAmrEUyiQc+Qcr2qXMsJJLZGtYkFihqKdot410U5fFmoT4gB7X5jP5eZMyCJgBkjSWIwzZK2/H4rUK68+jcEF/BZ/kgzJSeUuzdrB08GsKAD1MBpb7pdOpVZhNatqUsjkA/aQIv2nimpp2b0AK/eQ67ONlkGTalj7SSny2CrfXz39SN5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4hBOCs6J/xTgRpfTwjmBUSUFp3ZhMWfR25aIqpFXAs=;
 b=SRSZOFHoSunD6BBKswZedzM8HI/cmzaAJx2YAVENLSOUV5zcR28qVmSpnI/Sjr70chG59BjPH8Q15KxtMKrIKMP4mScr2nqph+CZvxxva5UVi9ku+KDfJ10SY+WOLITwxBOZYdnmbUyGeiZLkVfySfjP1rfzBRKhfpGZq9KIHIkGc+P++I9zeylgGKzhASVnSVYwaoOvYWlS2+IZ4sn80aBy+ccLRKJH2VoMzEJV2DB4Edx6VPmCpSFxMD0FToclhy98qmiQdDHft3fZBJ5ndfMMfv+P/aKChhNIIUy9Em7DZy/0p22SkWMmtGimiaNy3ZplRCt2DZKWIf8V8v4AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4hBOCs6J/xTgRpfTwjmBUSUFp3ZhMWfR25aIqpFXAs=;
 b=5Bwnd4979fg6CwtVQW1iupoMrsmRgMNkKeMPADpQs1rSQzqXmSvBvDpNFCLPcBC1vNkUTqsB4JFO0Pt/9WNYPQ3Kd/6V1nLxvga+GL4CyY+xkzQWQiGH2k0Ob9NLrP/4V3Alx8Bv0pqUCZ3C8N4pB9mHavtlS7/hg6uSeZbIRTU=
Received: from MN2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:208:23b::9)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Mon, 2 Oct
 2023 18:49:36 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::f5) by MN2PR11CA0004.outlook.office365.com
 (2603:10b6:208:23b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
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
Subject: [PATCH 2/3] drm/amdgpu: fall back to INPUT power for AVG power via
 INFO IOCTL
Date: Mon, 2 Oct 2023 14:49:18 -0400
Message-ID: <20231002184919.77753-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002184919.77753-1-alexander.deucher@amd.com>
References: <20231002184919.77753-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: e841b8ef-c64c-4688-a0f4-08dbc37852f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4gEO12nfd7abvx0wYyGLfIb8la3oY+Soj5VpyqXmqixN8ABgwlMjnRfF7ZMOxAChMTumcPmK6Kc32YDDGS50HYFjZ70P3zqjLM1/MFEHqfBYqEZcJenoNCLNkLiCrCcx9kqcseCMBAJMWRAVYh8J/di7E979qkHQUQ9YVABMbw4V70ck2MLBGxehZoLuFuGpQkoXO4LWQzL8ON5XeJk14Zmlxkn6EeqBYxz4gaLv4697nobgaSau072mhk4PSFGxvXSsTsMuHygV5bNWuEXUJ6sGPo+cX2pyw1uTvPMTFgP0nbKSvmg0XiZua2L2D/noMK/7Ww3QiWIDnB9gEYk3PsZG8S2j81MBeNV1adCn6hJgHlpZ+XFFz8ubmH4oDEVOWGUlpwfCmNK8ktadM7is/AhlRZsUUXYFRqFaRtmuf46bNL18tosYoZ50LydUwtj8StB9MTtEQcODfsckZzaHqohCqCQrSOou/kHojqMO5dYDgXnraPMS2u2bGbefkwvH42tUifm3QspyjrN15aK6fsXiIYWDjLkAaa8QYj9VlnhI2F5VtS0ltqnHdV7FHFtnl/6wD+SHCiJ/NuT9dSXEcePXfrFBhTiPyZFTxwc0SHMh77fSIZYXLBth053STAnJNvjXteQl6Zl68jisb3vV88FdRLhkd0k/v4lYBivchWzD/p3mGYELVuduCVkKqTHBsu+0LkeiGopV/Lh58VzuPGcf2C/xlPq6ZhCIQvvriz230bpkwXwRqSOPrwGQtGm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(316002)(8936002)(8676002)(70206006)(4326008)(41300700001)(5660300002)(6916009)(36860700001)(16526019)(6666004)(966005)(478600001)(83380400001)(4744005)(7696005)(26005)(1076003)(70586007)(2616005)(336012)(47076005)(426003)(82740400003)(81166007)(356005)(36756003)(86362001)(40460700003)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:49:35.7975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e841b8ef-c64c-4688-a0f4-08dbc37852f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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

For backwards compatibility with userspace.

Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..ce71f853931a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1077,7 +1077,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				/* fall back to input power for backwards compat */
+				if (amdgpu_dpm_read_sensor(adev,
+							   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+							   (void *)&ui32, &ui32_size)) {
+					return -EINVAL;
+				}
 			}
 			ui32 >>= 8;
 			break;
-- 
2.41.0

