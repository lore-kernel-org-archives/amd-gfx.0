Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F103FCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA9A89861;
	Tue, 16 Jun 2026 09:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wtScgtAD";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B23910E9AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0uXH2ts1G8YolCbnCEeP5Iv+OaGAauzlmKm+AoQ8Qf8ni7EXahI//vACYY/ksnxCc0VHcJaPeN5qkXO070QKty4QvZuw1XFTyZDtjuIK04Tr8R0RjcMt/sL7eFa74muxeCT4nnKIUtY3VcjQzqsKkHPagBRoevM2P9wdZOhdWDSyyGPlu2BUWrAFT+v4gQgQ7/yR7qNRx3zWpkI9UJiYN5bIYSTMjp4fu0ZZ2tQlAvYuDFzkCmgDNAMxKyWr6K21IBAnjX0WeGx4vranF3X/j94TsGM6vNuMCe3KKYPjQJlD0mX6o+6cIB0InJzj6CQbdcP3C72B3W8IUJM0eF7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUFpsE9iPi08hOFDQqQwL3QkhyIt4VXj8muw/vhBaBY=;
 b=Fo+NYEKV50nqhDDIsZpsQqW9GVARfQ9RVOfBZwA5RTaXU+jTbVf6Tc949J3A92gMzIbGpHjDh/l91f5HHwUWMPyFe++O7zU/AdtJi5cRVz0qwwNyBFnGdh7pWgRsbpD5uaFITYTKnBb6DAge/25V2U3Qr4/bphMC0aAJmUWYfWtDAaWpALXCL9sj96E6t2ThMRQkitdr6iZHj2a0M9P1zfAh/R9uCYVh30+dxtti5vCtSJxJHUuvIImzsa9bFdgpWEY+8slfPpTpYo8fDxTvHtEvuYIzcgRabXJ43zrlyoxHHdsrUY7v7tZnSn3pAk3tfrCz2ZNM0J0WI4bkfabSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUFpsE9iPi08hOFDQqQwL3QkhyIt4VXj8muw/vhBaBY=;
 b=wtScgtADcf8KkbFGVK7fiBsYGfnPqjhuKqul7u8LfBdjO2L1VMjMOA03n4OqUpkvinnRQUDgf6yMIxHG9pEY66OrRO7BEOkaTQJlGhdCnhpgWgm3eyY3jeeRbdwkVtxkgPFWxk0Tp00ULcvRVa+fFlkR5ZHJK0P3bQO3Lou71LM=
Received: from DM6PR07CA0081.namprd07.prod.outlook.com (2603:10b6:5:337::14)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:39:13 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::7) by DM6PR07CA0081.outlook.office365.com
 (2603:10b6:5:337::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:39:13 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:39:10 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu: add bounds check to prevent array overflow
Date: Tue, 16 Jun 2026 17:37:52 +0800
Message-ID: <20260616093753.4142104-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dbce8f-6898-4f30-7d8f-08decb8b2023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yxLuixZ2/dG5mvXIV+dvQVpxTqYmylPfjAXVoD4c3Gz+aesvQKPsbHZESV4kFmS7+JhanxB/LqK26QK3FXsBUvSrLGYlaBQb15g0ZMiYEbPIV9FNFcnbcdOGy6yEhoIMMAaj9eOSc2QgZ3fXyH/VX0LIV2voL5Rd4gDdl+Y/m/9NM/J6OEdDCfOwAdPKFAoaIve2dHqiiGd4F9MoAthfisOnCvdFxxJt66NS/RjD9VCoVmMYExkAnRHvzfj/uh9VOtY7J2GraE0A+lc57WcBWsehbkGqfRIZgZyJ0khAtV9aBsh1LnnukLSkqqX8WRRNoigkMdNT83t04PdhlyrSqf2qEOmPBpKiWOboOjv6CZC6+0XVV/htWFzSiDeiARG9PzDe9Eeq6uVTYdsJYLGrjp5xtvV95BMwdicVS21+RCgjX8GN/KavqEHV8D3yfNagdBHTodTsxy/CaM1ywA7u0PMYARNrMKfvh7lg/5mxIeGYJM7IOYY33/B1DJHFJGcfCjTSavfrdIMVlxfaiKcFc5RgEiLdUMqulszS+9UG5M/TwycHNLAYgTkvERxqhcws3ejOurBh22N+1MgomX5kadfDfVRjwqLqR+F6wfrgBLvEPjEWfpLeHcShSd6brEKJBR1v+k97+7QOqMmrdZ6fz09gtiZZdYltloimICXlTam+tpFV1A/1eMLomys/jPuI16jyfuSa+jJhctAv6SuXIXidQN3Armfhb+iKw8MyC8A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UYYJDJ9pa5Z4iFKNSY/6VWElN7uIhdQ7JzUha56nzIXhbJWPpCc2y36W+opZGPZMLeRICHDwKB8SakX4mo5cXDGRrjFkQRvsgBS5+bIDA/ZSi30DN7w4bGiGZD/v2lb3L6ENL9IUm1O5vp3Fg/S2uvnvmGSKkYTypKIGxab5tInXkMlVfnM7h8H7l5QBiQBx4UT7TnsIAlhIjUO6JYUYPzqhiRYYEP6OrDHZPO37LQRF2yhar1oXdlw4mJKhGychlWo6FEW8SIx2OSryfiHWirscWO0n5WuDSbBVJAS+KUAuWczBFG63Oz37vuL2z1xiEjN9ddZxmeRo6e76iwtKdQSpnOxM6ROdfxEB2vLfm7A/FuwfFa5nR7koP8MkwLT8UHQi/EBa9NiCycVkDRb9LJ5KJakU89BZlIcsYUPEhaxaaQ05HX04Mi9OxPAfOGE6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:39:13.2886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dbce8f-6898-4f30-7d8f-08decb8b2023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

Add bounds check to prevent array overflow.

v2:
  Add warning messages.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 94ddb8b98abf..8a49ae4c0132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5064,6 +5064,13 @@ static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
 	 * Use this list instead of mgpu_info to find the amdgpu
 	 * device on which the UMC error was reported.
 	 */
+	if (mce_adev_list.num_gpu >= MAX_GPU_INSTANCE) {
+		dev_warn_ratelimited(adev->dev,
+			"mce_adev_list full, skip notifier registration (max=%d)\n",
+			MAX_GPU_INSTANCE);
+		return;
+	}
+
 	mce_adev_list.devs[mce_adev_list.num_gpu++] = adev;
 
 	/*
-- 
2.43.0

