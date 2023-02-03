Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8836BC636CC
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C3510E8AE;
	Fri,  3 Feb 2023 19:09:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875A610E8AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT6icb5ksonW8zsPwPAGnkrEJMfdPbZuxXcCMjyljHK/oG1cga70fTXWXFEM95JtIsfVwBN+oMTcMwHxwegsmfKwF53LlhuChZmraN1wENwiJ4P750WB1vGDf3RFQ7U1YwyYEA1mygr4ZoDKEPGAYEyYjNcRcKYZo121GVLLQY49KGcb9WGGxPXFhFq0lTVSP1XK7RAWzB98CqE6o9ydW7lRM6Mji9gMWnEL1i/lIo02kklm57s9zcgqCV31RMRUvWLjusgcxmQ+ikY6l+1vYz7iGYSFWsWFXsrzfBW8syD5UzDfVQa9Qj70jq37Pu10IrH6TiylWxuvE4jURroIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhnDpNyy/KdyVDdkIKDd8AOQhpEPgsMbaUuWfqnIUbQ=;
 b=WpXeGQ6Ms11IW/Hv81HVghuYNL288ClWcNiD6r+1KzMTrswZPO7PapdMpwX2LzzhE4U++H3eeuYEZ7kCdnW4JxPp6KC48OpiD6AybxsS+OARKF476rF0ayCYIYre4/LnSYRsXw88QfCSHgHhRmSf7k28BQk95UUrxo9k2FImmytf1V7lMm92ht7vHKdTL/Ce6r9CQapwDaeiznOuuY9vOFSvU+BeBHQqShx9+cH8TLvvkEMA53MDkA5gjtIWbfZGiD1NaL2PBeO3GsHyI0FxHt3/qr2dTV8kL+io1LaZ01Z/kFwzekamdr3StNb2CxaRCOealrYS4JNd1jxhq7f5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhnDpNyy/KdyVDdkIKDd8AOQhpEPgsMbaUuWfqnIUbQ=;
 b=yNsK3B7StvgUWFxvYCVL3A72Kmv2IWyXyZ8NNFD7Vr7XZVWiPsy0/8/YX9eJRMH4eVfxf3t1OzC2MiYN04FjztOHG7RgO6kyQQCKojUwMcqyr3AsoMx3L/RdAYKNhLrsZq61RuKpgq+/QLDQ2UoA6K/ygw4awLGDxbbx2ULoN08=
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 19:09:35 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::6d) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:33 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amdgpu: initialize doorbell memory pool
Date: Fri, 3 Feb 2023 20:08:33 +0100
Message-ID: <20230203190836.1987-17-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 955cbfc9-c426-4d4e-6ed8-08db061a300b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZ907WPrVFb9xCwHiiibDtk1chUOKs740TOsaJ9GA2hSw/2ITlBoxX5Tb++NmuENirZqtdGrsSaJQk8CBujRcIA0e6szwc3w0eaynnbJxzrfoY3vxd2Z7RqzYFaeozaHywXgRYzdBFK9oBd/xvSEqOsvd7deyr15ytiQqugG3c1wzgdkmKa3URcU31ZzUlwu50nrHaqQSfI4BGyKCrX652jKMV9c234BZx1MYoqH29vHD71RgW8jUTx/OdCGPRatjJCxoLbP1PjAIJedsuki4CiVk49VpCDI9Tf8PtayhHCCmtdXMh+e43KMtGuVeYN6KibZ8vbVWf9P321OzUVWlqTcR7VCWj/dUdChUfVhPVxaCDdJ2OiDejKEz4ZD0XMN8tAOrKCMo/YclszFTWLQyo/ayMGlMYbH4wiOWbgrNSI5Zmp3XT7QG6ZsXNrG1a+X9sNjEGK8fypVNHVZJfpoLVt61MYoBi6pktIcwZ4+tIhH5alL1xoarmSLk5SNjopNN/Zk5SaEXaXl6n/HQvhfv771akMYm7Y/iWVQPGjx0Lv2ktyf01dVqlNUenPs4tP/Lsh5vB9ofrq638WVtOBAthvSesmavOhOexP4Xp/wcsDua70YRGa+r0GYvWm4G1czLT932EFgLPaAI/08Y4BTbQe/OvX9fj04EaMhNOb/697oDqa9zOmc3eSOhRUYKuO9MX7KRGa9knQ0WcOq/GlQK3aocUnQWrFgC2w6SNYKr9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(186003)(26005)(16526019)(44832011)(82310400005)(8936002)(426003)(5660300002)(47076005)(36756003)(40460700003)(70206006)(41300700001)(4326008)(8676002)(70586007)(336012)(2616005)(6916009)(86362001)(36860700001)(40480700001)(54906003)(82740400003)(316002)(7696005)(1076003)(356005)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:34.7092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955cbfc9-c426-4d4e-6ed8-08db061a300b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch initializes doorbell pool with bar manager, which will
divide all the doorbell memory into pages.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e04409210415..95017de6b23d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1837,6 +1837,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* Initialize DOORBELL pool with all of DOORBELL divided into pages */
+	r = amdgpu_bar_mgr_init(adev, AMDGPU_PL_DOORBELL);
+	if (r) {
+		DRM_ERROR("Failed initializing DOORBELL heap.\n");
+		return r;
+	}
+
 	/*
 	 *The reserved vram for firmware must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
@@ -1890,6 +1897,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
 
+	DRM_INFO("amdgpu: %uM of DOORBELL memory ready\n",
+		 (unsigned) (adev->gmc.doorbell_aper_size / (1024 * 1024)));
+
 	/* Compute GTT size, either based on 1/2 the size of RAM size
 	 * or whatever the user passed on module init */
 	if (amdgpu_gtt_size == -1) {
@@ -1991,6 +2001,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 
 	amdgpu_bar_mgr_fini(adev, TTM_PL_VRAM);
+	amdgpu_bar_mgr_fini(adev, AMDGPU_PL_DOORBELL);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
-- 
2.34.1

