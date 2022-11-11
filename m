Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361D3C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Nov 2022 20:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3CD10E8C4;
	Fri, 11 Nov 2022 20:54:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CA910E8C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 20:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqteQrajiw7RlYqGO/0YJGxVnu7x809xsAIywd/225GzDabsKnFx/WUSIR5Qm+L5xU33jXNWHd65fA7kmbCxwQ9LuaGBJwVDmxbwATWjiLOZBdbMALP7z7UQl83YiT9l8SJZG4inj1ZrxSDV3h/BOSWi/PWIrdxutGx6zx9XVqKn5dnIHXuoIhY+0xO2kUW6iXzwCo6BWcsoXj2L/Ma4X14ZPJVTsLxoBaL0hS8qVTbLWJEuXPlgnjEoQLvH/XRUyQQIZyUyzYdD/N+LdVGw+zF8z+CL4b4WvtfmcN1OsdktnRloZUVgdFknqbRaqyp6QGDwC0MHLOfFJ0/O2F3G4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp+4rJjEBG92m62QMqgRv6jW4zrGgv11xDFk/tgOZK0=;
 b=OeTHOYU9H6emk7towQrqWeb4JVlzMLITZoThf8I6+jtpvRfcOczLeHPITkIAVh0YiE6GDTFhmAxaPBNXbmd6XbC0x7ggiBrloqmYx8Dm2QYMY/bY77DPvHQ5Ip3n/QzqtQQ0OKJyDYxj43doCaHkklYPb0U3vi9Gr5fjCRkM4ffbprEPVWvCV/U4p3k1RgvmgrRNyW8gnigen998E3oYZ4WQ98JT++tzkkPT/XzB2BUkaYF+f7xznNWY6e2aUduvVX1CV0pFOJMOKWV0qHNDH2/Up8O9H2umwj8Ay94GuurJKS57kL/V6JCEYHuLnu5Sg8Ov7ymIK+pWfGn4kx+nNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp+4rJjEBG92m62QMqgRv6jW4zrGgv11xDFk/tgOZK0=;
 b=wYa9SItEslXnadmWsqoNXgmOX2+7Esc429rDOWOIem4l7WmDO9KUNTPEv/mFRpVdDzQDWhgNMbfOwiHpCkbp0pahwQYd2fxy5dSVCtFKK61Rn5ZSZyS4D4T1BceEs5fGP04zgPzlpON2vowYHsUpdGnYfPYos+heSRos8rWfrmE=
Received: from DM6PR00CA0019.namprd00.prod.outlook.com (2603:10b6:5:114::32)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.24; Fri, 11 Nov 2022 20:54:28 +0000
Received: from CB1PEPF00003668.namprd00.prod.outlook.com
 (2603:10b6:5:114:cafe::3c) by DM6PR00CA0019.outlook.office365.com
 (2603:10b6:5:114::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5856.0 via Frontend
 Transport; Fri, 11 Nov 2022 20:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CB1PEPF00003668.mail.protection.outlook.com (10.167.1.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5860.0 via Frontend Transport; Fri, 11 Nov 2022 20:54:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 14:54:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: there is no vbios fb on devices with no display
 hw (v2)
Date: Fri, 11 Nov 2022 15:54:12 -0500
Message-ID: <20221111205412.41093-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CB1PEPF00003668:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2c4495-ed9a-47d0-fa16-08dac426ec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V33HGr9YJmyN5hBcA82xZRA0FPqcI8OxMye7qm+S3Fe9HtIJMDtMOB8x0uU2K7rHInfZf4ZzGRgn3E8s3l643hGpsjay6zLhiSBA0HFoVEqzJa1HoMNqHnFNKb6NARTzBsrkJzQzzTyE2XGGWshadhj17VwwPH5vaatC6CqNcf6NeVEXTdg8b8K8qwK45Mqrp5SQFm4DwSmxdFlrK1X4A3Ap8Kgw4USTOkQl2Nnn5kC1SeDp3Kf8IwRYHnU6XiRpN0Qj5GsAdSnyehcoemDXCvFtysU/X0srw3BMo8XhLn0T2Bc+xh9TU9gaaeXI+AH4Nio4WyFdvQLWHsxpZgZd8rjs/H7MzDZwAH3fZtY8NhN+MAZP1i3oC1+LXp7Wj9fbCg7VwNT243o7sjUKxVb8O3Q4UkFbYHVK0OPxY/VhrsFDGLnuCkDnRWftFBJCfJn4Tx7PzH3G/PJcQy2LEUz1Y1mi7Q4RdBAsIMzl1ctbw5lkQhiJcaaW0hL++poimZtnu/r4zVrMjWvEGxi3DsB0f6KSXQpHCQ6eIfbFUj2SPrrx06QaB11URXOW8xFHygrzBF+I9EGagZclT7vPVgviFjQ7hwGT/8A2A4JD8LYwyzGClGrthEvW2kyaCpaE/xUXDh2RjLAni0C5uA1GPgCk5NWVdjvJhoLav7kuwMzV6OY0CU/hAEy+PiCEgUO8wpk/qUljg3M4ug54+SjmCguwAoS7Yp2Xehvm3lJAayQr6lNo9ejHnk9wo1i/odD7vIeEeOjXG1ybFtvpDYxs+UdSKraHL2ItURkP2ERzWtGXy22ym2VZcUi0yKqg/DH+lOlz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(36756003)(40480700001)(81166007)(36860700001)(316002)(356005)(86362001)(82740400003)(6916009)(478600001)(26005)(2616005)(5660300002)(41300700001)(4326008)(6666004)(83380400001)(70586007)(186003)(47076005)(8936002)(426003)(70206006)(40460700003)(2906002)(1076003)(336012)(8676002)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 20:54:28.2537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2c4495-ed9a-47d0-fa16-08dac426ec8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CB1PEPF00003668.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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

If we enable virtual display functionality on parts with
no display hardware we can end up trying to check for and
reserve the vbios FB area on devices where it doesn't exist.
Check if display hardware is actually present on the hardware
before trying to reserve the memory.

v2: move the check into common code

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  2 +-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a4aaf4d9ed1..1f3a4d596d0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1298,6 +1298,7 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 				u32 reg, u32 v);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
+bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e039df9fb3dd..148ac2e9f31f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6045,3 +6045,44 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 	dma_fence_put(old);
 	return NULL;
 }
+
+bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_HAINAN:
+#endif
+	case CHIP_TOPAZ:
+		/* chips with no display hardware */
+		return false;
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+#endif
+#ifdef CONFIG_DRM_AMDGPU_CIK
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KAVERI:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+#endif
+	case CHIP_TONGA:
+	case CHIP_FIJI:
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_VEGAM:
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
+		/* chips with display hardware */
+		return true;
+	default:
+		/* IP discovery */
+		if (!adev->ip_versions[DCE_HWIP][0] ||
+		    (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
+			return false;
+		return true;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 9c0d9baab4e2..4365ede42855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -657,7 +657,7 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev) ||
-	    !amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
+	    !amdgpu_device_has_display_hardware(adev)) {
 		size = 0;
 	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
-- 
2.38.1

