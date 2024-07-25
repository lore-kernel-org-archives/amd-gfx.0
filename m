Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF75C3DA70
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 21:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1FE10E17D;
	Thu, 25 Jul 2024 21:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4WpzJFXH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5608810E17D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 21:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVNrtbQq5WJQgt1lNRLgEUQPJyChVjbL4nYXc9p/Y7KN2B1Xcd5xx7LxuWsulD3qjIRFUTa1m+sVhwYNJeErJPHYco2T/r6lpayOccy2hjxnA1UiZ95f4RfaxzRwQyMmv+uP69oFYb0TJnDqU6C+WFTxt/B89ixR0/2yHzAoTRO3IoywvEu8AaBie4Ox8MOg1W1IQOOTeHwpbOdFD4F+DpfQ/p4DJ/2OTMQz4vkLKU8Nf2JXJwq5Me+GAnj9o0PSCogUu/Z+DTHfJTU1uqGgEJ7CeUrGyWV6lgEcu4RUySy+4rqud3ga0md/gUI74zXPcRqjy2KfcpFkDLN7GEqtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrDto2FF3NAPCnA6qbh/WRD8zNKn7bpy7zW7DJ7gyaA=;
 b=ReT4fgBbLmUdFZwTy9F7ut6R/IguyGzvBME5MphE3zuCWJxswImM4rO+mImQRLfA2JyGqiiy87DDnSJLMvJffHMkTaaPxIhrhTrN8vOerlqCZezgB1qGMgGDDwew14YKOCk68fVNVtTsANwEB3h9efeDYUwvGNwMxGMUO3YXZCZ5BSYJ0cvUX+j44gfeDSGhJj01cJoeBa91p5ibzwtkHDIilADI7QfhZ6J66o7UP302K3xLH3Jw+h+bemd1ZzswnDZzQWUeFu/vjZfP8uOnAd+DSwqzCbTEZzDcGBtL3rDJtxfQSNjfB2UDaGdAf1DJAAtJ1eTspIAUz6nIXdFj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrDto2FF3NAPCnA6qbh/WRD8zNKn7bpy7zW7DJ7gyaA=;
 b=4WpzJFXHh28YqpR0jJbvpT00VJYuLVk8sT0vRsRtV+grW9zCPnRrri17XRt6gSF9LBc6XHipcSZv/zsizuIieD4/SOTZNvGFNGK82S8Xn1lIIwuBFLSGWzhGOT04CE9pjYke4Gor8Ng6y/AQ4tW+KAuWjO7LuYxe+jmnstV/mh4=
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 25 Jul
 2024 21:36:00 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::66) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 21:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 21:35:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 16:35:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix APU handling in amdgpu_pm_load_smu_firmware()
Date: Thu, 25 Jul 2024 17:35:44 -0400
Message-ID: <20240725213544.2988415-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fd1a28-1975-4060-290f-08dcacf1c649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bl8sJVUWXTJcgy5zSTdikgnI7XzbvbvlkMqDAqJwZq3VMlIR6Kt5DzTHN6Ql?=
 =?us-ascii?Q?9szf8U7RDs2QSpZTXxSSre6zlh8nUYsbZy1Ow45xUdT8LiT5iNgQQZQnIGPb?=
 =?us-ascii?Q?+4eQjkNHYtFq4Ncjwh06jhKAINim5dO8O4S5FLicLhCgw8HX/gYrMYaqqZV+?=
 =?us-ascii?Q?c4RQ9FPHVpup3nzzdKFxL/46kTZymxd7Yjq5e//w/OJe9ltgapT++pzBouRG?=
 =?us-ascii?Q?C3JdZzdC4LZSCPK293Rjf5n/ENJWa5jRTEQK+Vvv1S/zodQy4sp8clMFDbXg?=
 =?us-ascii?Q?79Pm9yJ5Cyh8uBBFDuXIfqCMCOELNTuxvfmAyXb1sTsdR3H8gZLy+ZEc/+XC?=
 =?us-ascii?Q?g2jmD8CHy0YvnXkn71/QQsIaWnhec0eXVtKFMSzb2gXNsZ1huzk6+y07Qr9O?=
 =?us-ascii?Q?b0GPP2kVcPSRTD9VClqt0BuqxCYvXoHrqBA9+cXIt2xfxVFIJZ5e+UbvLQQ7?=
 =?us-ascii?Q?deUgWu7Ptefju2XGnOkybnIW7Wqcu5J37JtSPDD8iD2HynhexsElxtoPvXZd?=
 =?us-ascii?Q?6M0WAlllqMxEeRxGgIqhlh1BwSLE+i1tb1M3ZEYg/N6gApXg5lmphPCAbS0N?=
 =?us-ascii?Q?llnghA5bQ6jE5/5V9Y/E/zdyICauHDqtwHIrMB6inVfgru6N/BjLoHdmOz8J?=
 =?us-ascii?Q?SnY1l0gYKVyxjDJd1LAshKkzfiWE/PvclnRzDVdyBRDpRTD/12BwUNeDudcS?=
 =?us-ascii?Q?MYGoEtwgPy4qo2MIw7Duht11MdiPuAbJeX7QMvUTljnhk6l+GmkKLiuwEUdF?=
 =?us-ascii?Q?E1YrplUyUxRXPOOn6TW1LJGLj2NiWy9m4OIkLUhENYkkT/sjehJOvCpr16R3?=
 =?us-ascii?Q?ifG85igXM1LLfxMFL0bvvFHVJhqkPo/nSG/TimS+4g3uPnhcsB/3wISjivmC?=
 =?us-ascii?Q?mu0P6qKcXtCiTtV3qFR5UxWCMBQ2qliVELFBSS5J1FlS0GNwe4d2xt2y8bzk?=
 =?us-ascii?Q?DmC1JB0QWANYqbx0PsHjQhzZqZWNST5mRZaMTQh+mjMFm+IXpBm4zmW5fUE4?=
 =?us-ascii?Q?GwqmDDHRrlYZLvwUnPKcE5jPQFjfmHr1dIaZgJwsasENRO14a1bykzE7ROD8?=
 =?us-ascii?Q?sRWUeogp2eStIcbBDhHHihDDNVOVgd7jT9OHTGGhEO0C61SqpmxKhb2NR/c7?=
 =?us-ascii?Q?K/gH/mlJ/PRClX/E9YnKY22CidXiEGnJ2h4fccKUrlXgUk6in1xUj8FvWVm8?=
 =?us-ascii?Q?mHzjK/gK9wojkMPu/gRE9XBX9BIroFeqF/YFvksh+PnJjVkIaxZhC5ymHRpE?=
 =?us-ascii?Q?7SC9wl1Fk6zhWR24GngTZYv8IwYCOx6OBdG47EhHld6HAE61iTGKaXi9znqh?=
 =?us-ascii?Q?pVU27b29jVbgloVEQcpvSNH39piGPWFc3k34w1KVTMeTbyR3+TSNo0CQOQpw?=
 =?us-ascii?Q?QdV3RDTSdH1FFKPOqmBD2nZaaYYv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 21:35:59.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fd1a28-1975-4060-290f-08dcacf1c649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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

We only need to skip this on modern APUs.  It's required
on older APUs as it's where start_smu gets called from.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3502
Fixes: 064d92436b69 ("drm/amd/pm: avoid to load smu firmware for APUs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f78b4f013ed4..62df787d7b28 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -631,7 +631,8 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int r = 0;
 
-	if (!pp_funcs || !pp_funcs->load_firmware || adev->flags & AMD_IS_APU)
+	if (!pp_funcs || !pp_funcs->load_firmware ||
+	    (is_support_sw_smu(adev) && (adev->flags & AMD_IS_APU)))
 		return 0;
 
 	mutex_lock(&adev->pm.mutex);
-- 
2.45.2

