Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD3EC636CC
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 18:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C4C10E374;
	Tue, 31 Jan 2023 18:13:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27F610E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 18:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB/5smiI1J6l/Z2/qjAPUqRqkQHHpI5G+pKrPMFmC7HrDjfq7JVcSgvH+KTYRwFG2IoxREt6XRxYiXwRDCUA3tYxd+yfL0NFLs4dFQRxD5EB8AQWpptw2oZhH1ac1nlDPPjbcXGPOQbIrp24kQa9AzEdeP4Z06yduGuzsv6lD+U7ybE5EiqcasphBJSNPP15zt047n9Ko0JkZxWUx3FKATdYlhGG6lXE30XInrEL2xdL/LgJ8zyqzYtTZfmqopdIxH1odMTaeuQP9PJ+14LTrz1bIEI7CjywvEpfjbw7466l49FgMl1VpjHXxsfXiVSexPxJ+ZVpykdxT7wFSTipIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2KaYbPFcHwYv8SguYWgOx9qJGk1VkvhMCw9fkb9tE4=;
 b=BSXErN3XWh88FEbTp20QYVZWeCWeh5hzdR/xQsTzv1xYULr+Yh2Tfwgmv+dHVKJffAMb0MA7pIuiDX7pNTZg2SQ6NN0Iz0e/oIyoKMr+KY0yMlySBXZ3qIqse0DnVlAW2K6snk4AKPzdHE61q3ArR3XfWh3cM+OS5Y31UOLVZS22qPBeKss+iD879yyNFKwDL078BYtcwqs/0ndcOTOFqf7YUay6Zw2GO3aJKAWUHdEkUq29KrlKVYuiYCrEcjUBMXzkKANq2K7ZQR6a8xsUJpSSbZWC3wn8KAL+vZCGz1l3fNBxJGLbcZzBClTTZM2LBA8iAsHjpfUttwV5+FZmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2KaYbPFcHwYv8SguYWgOx9qJGk1VkvhMCw9fkb9tE4=;
 b=al3HlPPcYLT+dxD4QdA412FzXNEGdv2FXNCaXHO/YKA1YR/B4f01q8sp/Klw0yR5iPBiDPRdYb8jpyia/AQ2RDxZpJOvEo3TQBPLRK2xse9q9tJJfMzoQGwUHyPG+GXENuYeaXnDALz7x0aSUlCHlIkE1ayFgMzqj4QpSfxrDmA=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 18:13:47 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e2) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Tue, 31 Jan 2023 18:13:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:13:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd/display: properly handling AGP aperture in vm
 setup
Date: Tue, 31 Jan 2023 13:13:24 -0500
Message-ID: <20230131181326.3507396-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131181326.3507396-1-alexander.deucher@amd.com>
References: <20230131181326.3507396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d15a9e-d8be-4421-654a-08db03b6e5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P+TWdyX7dU9qarWU9RhB7jKqZY1tWqKY6YENM/+JYOmq2Kmo8imj/WyQI2UDKTo3+YCOjFX3IRVhARiso3ohAh6zd98JHG7vzW3ek6+0du8fOC10ArBXxL2ToIUrQKvlcM2M2jlup6kOf3xWIxI0LdpGgoABo6GcxtrmZYvWNwpIdCGPTB4KqbvschOMuOqM8Mou9lEH8+nyqsfdK7PVBKsUttl4Qnvgz0KrXgzkOBrKz+RVO/dNKKSUTVYup7T9+fSWsRiFiRNGl0rsPrD0dK1+sbd4O7mscG4u2PE+jbX9IH/cOJi90qeCTZG2924Q31QFQD+y5bNC7VrEkOCyuU071DjNOR0Pc0B9FViuyIAlt1F8VvPmL4qO9PmnjUP2UHHZEjPsNXf4hvVZw6tg+l47jTBSjRTnkZ3b9pAt5iREsoqXNQxGC+e53BWyDJo6xpX9WhVoQUoRyHjL49+VSYl0myZP2VIMkHCJSZ5igaqRynunKUxq6PGgfxh3iXZe5WiBZAjV23CKyd2Yo7uc1bQYOMe2hQrCN6Do4atI6I86x2EWz+eHwHNba/mMDRJvk7Y7AjGjO+8IKZGef7IArLBTodlrHqWmrj0mjeM1D0KygXQ2sGQpyC9TjmbXVVOyaVz8vamGU9sHCzp1tkhBBkBvjXxn3w/PBinbW4qFbIHjm29LDZOxuz9O6pBvn050REmEQ37DHQL5ILEZaLTOY27NfvRyc9s6gPqxj/s2yI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(41300700001)(8676002)(356005)(82310400005)(54906003)(478600001)(7696005)(6666004)(2906002)(5660300002)(40480700001)(70586007)(316002)(8936002)(40460700003)(6916009)(83380400001)(36860700001)(70206006)(81166007)(16526019)(26005)(82740400003)(4326008)(186003)(47076005)(1076003)(426003)(2616005)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:13:47.5541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d15a9e-d8be-4421-654a-08db03b6e5c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Take into account whether or not the AGP aperture is
enabled or not when calculating the system aperture.

Fixes white screens with DCN 3.1.4.

Based on a patch from Yifan Zhang <yifan1.zhang@amd.com>

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 ++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1736a5488762..1f5b9c485dda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1185,24 +1185,38 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 	memset(pa_config, 0, sizeof(*pa_config));
 
-	logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
-	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
-
-	if (adev->apu_flags & AMD_APU_IS_RAVEN2)
-		/*
-		 * Raven2 has a HW issue that it is unable to use the vram which
-		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
-		 * workaround that increase system aperture high address (add 1)
-		 * to get rid of the VM fault and hardware hang.
-		 */
-		logical_addr_high = max((adev->gmc.fb_end >> 18) + 0x1, adev->gmc.agp_end >> 18);
-	else
-		logical_addr_high = max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18;
-
 	agp_base = 0;
 	agp_bot = adev->gmc.agp_start >> 24;
 	agp_top = adev->gmc.agp_end >> 24;
 
+	/* AGP aperture is disabled */
+	if (agp_bot == agp_top) {
+		logical_addr_low  = adev->gmc.vram_start >> 18;
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			/*
+			 * Raven2 has a HW issue that it is unable to use the vram which
+			 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
+			 * workaround that increase system aperture high address (add 1)
+			 * to get rid of the VM fault and hardware hang.
+			 */
+			logical_addr_high = (adev->gmc.fb_end >> 18) + 0x1;
+		else
+			logical_addr_high = adev->gmc.vram_end >> 18;
+	} else {
+		logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			/*
+			 * Raven2 has a HW issue that it is unable to use the vram which
+			 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
+			 * workaround that increase system aperture high address (add 1)
+			 * to get rid of the VM fault and hardware hang.
+			 */
+			logical_addr_high = max((adev->gmc.fb_end >> 18) + 0x1, adev->gmc.agp_end >> 18);
+		else
+			logical_addr_high = max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18;
+	}
+
+	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
 	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
 	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
-- 
2.39.1

