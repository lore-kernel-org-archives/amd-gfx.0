Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484C4C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4634910F6F8;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lsO1usRh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1372710F6F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMpdymYo5ly2TFR/Bo2kDaxrQ7ejUZsLu4P9H5l97vAL+0FIfu/ZyIpfmrv8J1h5P9E0j+aMgSKAuKlm/evJUYpcl8V7OMb0qlf/51nyFiaoIJCZB+faUc0pBnxfiGwBaZi+9MJ0WcfqRhSpsva1wBpM+ZvBhPNAg438lI6eVTQlq0eoacVAWm2TAM5YCZqBk+T6BSLe9dwFFCo7ObLTUfVYuDYkSCc/8EpsItKb7/BiFQPKPCR31yDB27rplxzK009YinMLqxCwTPAvHVVmpKcqyStE4LlHp09oElkCgTloroQKW6BhF/+jDo52t8kFVW2TDn2xap55zEWfkutHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35VCc8N/8XA2UDuJ2gSGthCwQoVI1rXjUVHWFDHvqks=;
 b=fKRpxhUUkTFn2l5UDGrNEb6lo8PzPqV4arP8i9q/hw6KGnHcnx3iEvoRZUIbThrJwt2nf5J9RywkCROGz42UM1qBFLUiMRBk1PJBfmAyw+wfNIyYgtonSeoJ5QSPWTahVvKbaKJgTnKAgw4BgnMAik56eOjKbTcYuh8Lk5zdZAMpaTNM0YZL9Edcoe6PbvnOaeSz344jo73LCxpfSL+7VX4CeLonElpNshLGihVbYjfNcaM4pruiEZK22zCLF8qXw4zgLAB8Abe3MDxI0PqUYXNzn4z2gL+VnnbbhlZbetvGFyqw9zzqAsICyoUgc6QR5w3nM70rnsYuKjjzWnN3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35VCc8N/8XA2UDuJ2gSGthCwQoVI1rXjUVHWFDHvqks=;
 b=lsO1usRh8pvY415z1ZOnC0r8mWonvBcPTDVREfjDy4DulAUMfBEh8TZ3mncnVq1MvKPN84k+hoT3fUDhiGsdZwO7XduK37G/BUcoGeTGD5VR8GN2n6b8lX3iLnl7j+gb7VeEeE7/Qg8UXsl+ADXBfS6NM5/KvJCX13pmgdEwn80=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by DS2PR12MB9686.namprd12.prod.outlook.com (2603:10b6:8:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:21 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::1) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 031/109] drm/amdgpu: load TA firmware for psp v15_0_8
Date: Fri, 14 Aug 2026 17:01:28 -0400
Message-ID: <20260814210246.3067612-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS2PR12MB9686:EE_
X-MS-Office365-Filtering-Correlation-Id: 9403f11c-aa2d-416b-0c7c-08defa4778fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +pFDnSVRmQKtK4rAbolOXr778Qz/2C66QFzPQZzblW0cuSHz2JXkscQo9rSJ/blZKDMXeR5FJAlqKlb4igjRVCAp/b2+zOs6FNron0Rl8R1C9R83hO+KAtpGdHDYwAeYg/y+f+COZKhCKZElFlvQd6MGUpaFKy/Y0HxwZpbsHSfoRCPMRl8p78clRnnJ+M7AZKypK8kBIbeck00coZSFWgyhB0MhSnaDL2/YnxH409nyiDNJIBWfQYU8A+0w+Ih4Y2QCBBrOG+KxT7Ee8sboCctYqBvsDTdjH3oOjsh/KysUx7NBEUzAfr42mVJ8a60droS1pYsxydOP5RIGktpLk5YscvQcWwcTJIvxSZ4t4DszFaj7So7SpY8hk061SwStab5+6Va5zUM2C5EubQmJO4EjF9i62vw+uwveSD1e4lTiz7IhayW0AtjfyN1+eSZWz7fNo/8VEP44R8pIMixRCQ1JLYE/AXnrsjWZ1qbGVuaVxsL1lFirMrVaYpSs0Hz/mfLv/52ek0dFhIst537wZvHSwGY7DCbsByKLcEsDHYPqB2v9r6PZ0JFvcj6aRvXEwUQzFc3wzkrDAyWLlGaPAUSZUacM5LpnlC66SHA3bPOaQbJRkiClgPi2GldXMfdp7ANzV3w4K+Xs2HHwRLeEbupdKHZrO0HZMmqhj5VaUoI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4bU6P462S727J/PXyRdC5PfuLbI3uXV18QspGi4UxWLktC9KyL3CyX865Rx0DDE4UO6KAYLg5pggtctybznVbG0TfXY4+5kHqsnjIqvexP//nHRRPx7dg7ER56jKqBO6F2z1SMCqFNhOrdlwTFKLqAOodaIAxPKzPnx8tonGip7y3JVUksMQNVqpHgUHMtfzzAVPPOuz7OLqGRwVHBCaU/gpNIvRQpTlsP0mWHdtjmXC8QRVeCJ4WTrcVwpQePAA232rHZgRlj/CTLis2ycVLBL2BjtVIyWK8BXR82LqOzPuCXfBChpli7CMWW0flJz0XH4Ppsk3msaGAP2Wl/Eww6669enpXh8NlhQQaJVPHE796kaE+1qYb1eACQnvkBbuY5aofPl5BBw7kZqmXtdTXCYyATFBpAIPJCahfd+xYfUAbMk8Yzh8MHQsOCvw+xur
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:21.2139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9403f11c-aa2d-416b-0c7c-08defa4778fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9686
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

From: Candice Li <candice.li@amd.com>

Register psp_15_0_8_ta.bin with MODULE_FIRMWARE and
load TA for psp v15_0_8.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index 57a079e3f356e..f159efd585c32 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -34,6 +34,7 @@
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc_1.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_rl.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_8_ta.bin");
 
 static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 {
@@ -51,6 +52,10 @@ static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.55.0

