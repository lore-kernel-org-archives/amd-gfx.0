Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C3BC27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7511D10E207;
	Sun, 30 Jun 2024 14:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1j247eGK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA8510E1D2
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRualu6sLd6R80VLfjo0ZsgNc2KMRVW3FDcaNvxj6R81EOOOrIsBGQnn/xhgCNwcH9ZCk1a69eEcf7ofbd5W0HdUE5c950Jn0i6PwNeA8WVPjPNj6J8xioN14MgzfF+F/URHXZnKEfrYXFqSCH2RVqovTLBx5ZGNLyPTshVLy5oCE1ZjDxzETrFXIg7Ue5Uj1Tx3YkxFIC0n+IZXAhmZ54YMD7St8ysUfuknVUj/MzKfcHp9F486Prv3Ae5iysafgD/WRDCERncaJsu0+uCElyYHL8siIRdbvIbJ7YUQx8J3bOHhHyft0oKMrgtan8a6OmK/RBfaY+e/nXZHyAMVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72xr+lRIUtCiAcI18+CKlUEg6242NtJMehGQLwS4s+E=;
 b=ZwSsG6dIM4pwudgcQs14lT7Wfo04GLJmPDsGImSVDVfW/WSNaOuc4F3z9gkEVtzbfOhRplYu2Pn2TU9vwBTRRgDU+qLbO5RicSO7eYyIcjtL4UAMBfVQfCB6B6Lb6ff44UZMIseElOs/PUpalZOYS6Nw/erDgZg9WOtwwajeLwfSyfpw+i0RqNvPzmgpohA2wztURs6Z2Z7W89W/zmgwZnERc/r5pRyf1fk0XLcgHhn9HkVS7/do/hYirEnlje5aLGOov7fEk3RhQenORkIQmaXN4va3TejgKZtqOv0xEsJt+BPL663djc4DG4a7gTDQWSxIrYKhy12/9f7S8SNKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72xr+lRIUtCiAcI18+CKlUEg6242NtJMehGQLwS4s+E=;
 b=1j247eGK6oFemLJbb/ZnrvJ0QDtL8d8vsfQ+FyCf8YMpCUXUlwt28iWdvuAo6WezAIJ9FCuY6tuXgCeLY+xbnR9IC/1QGk2l2LtvDyl1vC2a+dj8AWd5qnltBUGRtgAOGY54RLOTDPw2FSIxy9OMMDXButyPMbiDFvHrNRCgJKw=
Received: from SN7PR04CA0027.namprd04.prod.outlook.com (2603:10b6:806:f2::32)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 14:54:17 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::73) by SN7PR04CA0027.outlook.office365.com
 (2603:10b6:806:f2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:54:17 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:54:15 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add VPE IP v6.1.3 discovery support
Date: Sun, 30 Jun 2024 22:50:45 +0800
Message-ID: <20240630145046.2021348-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145046.2021348-1-Tim.Huang@amd.com>
References: <20240630145046.2021348-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cab1fc8-26da-4bc6-629e-08dc99148453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XZsovuShAFDc1ynuNkzx9R6jqzOuA5UmZ/vVoeY47dnHtMaFpSjH6PIR6RfA?=
 =?us-ascii?Q?oRiGyeDEWxDyGYcnSsKlRxxa7iLigCyZJbsk/hzu5Yiz0zs6GQl+aqxBBnf4?=
 =?us-ascii?Q?4G/7792rM0Um+J9cdD1bYjmMcDXN9Fs0U0s213FqKY1UniH4Sg44YKWQPQbz?=
 =?us-ascii?Q?Iofqpd9h/oUJgdRYBePbEyagoLfXklbRyW3fxXbG2iH5jSN6S88iQDpbAH4K?=
 =?us-ascii?Q?OPn6vsJT+nXZy/CHk8EzaXtkKLJkkQ8FJJRYyhj7KfJ1a5WlEXF4wn/VkGWB?=
 =?us-ascii?Q?WpfKH5stcAk7ukQ4Fn2JZnJ/fksLwftWTkgHvxfJ9Ji/1Xf7xpno2tvHI1fv?=
 =?us-ascii?Q?JUmaNV5Y0a++d4eo3M4jJZ6xo8OmtHQkOqWgmoykEG1wPsQfpqKBTFIGm6je?=
 =?us-ascii?Q?fhSDKtukD0fg4ZtuFEakDf+xElmZ2qNs5VhFZwVhbO12FQjY08NkYdF73451?=
 =?us-ascii?Q?LYjha3aXCBP07baL0t4EBTtmAQG3Pfl0m7wIvgApTj0IXQ1/vo1WRciN5AAE?=
 =?us-ascii?Q?s6JHz4/UcfD4UM+chb9BaOcV5yptySjmFm8S0KSZVALUUsqdw0+o+/xYS5h9?=
 =?us-ascii?Q?jzDdpXyWIlIRfyUA4YbL8QhdiDlfJDf91kERH1Ko6qct4F9/sNenIqtRuunb?=
 =?us-ascii?Q?76l7XKpyXejW7Rjxh3mDfoyEXdndzog+SKGMAnnml/06Clu2T+hRmelQLErE?=
 =?us-ascii?Q?ghZV9N5953+TDe2fCfSpjZxfln+hqa5lyUAFaUmqQOguvLwf14+RFbPA3if2?=
 =?us-ascii?Q?bWOQydgTGrKk3grh6OelPEUfVZIHDBty+rVqbrxzqvaKY/nhl9Z1mHXd1tzF?=
 =?us-ascii?Q?2LaSUQruGtMXHD+Dhyw+wEyXjbffMex/QWVjNTji8nXbyv8JM4/q6M8v/Wyi?=
 =?us-ascii?Q?WVcGwXpjjTlxEiZGdYAiKp9iNtvLZJMgth8L99uiu8iF3736RHXJgEKAmDXF?=
 =?us-ascii?Q?+XSAmQ3qGWixnDVG0mHxn0xzEDxY3kN+DBGDLYRfLMnA1u78ICsEYCUkxUja?=
 =?us-ascii?Q?P3Ok9I7E+fNIOZV9qursMiBY36m15PUSP9MgwVlk+yBqGeF+v7eF3/SngGSa?=
 =?us-ascii?Q?zQ90/HEPd0tuRlVsO1cwu3BTlGq4jYGe9hL19eKz7nifJmURVCny1p+lZy90?=
 =?us-ascii?Q?46rFP9ArI6hZnmsq22/s789zqqe16IUkeDH+4tIMW58D27uzV+lvCU0qwp75?=
 =?us-ascii?Q?7HAJaKyg+V5/d9K9AzOgtL51SF0rvne74S0s9jZiA9dc8W89wK5MBFuz0yGO?=
 =?us-ascii?Q?V2OWHgtxJxl3w2urajLIDyeazSr/3TleUFFjLrBaIm0v0yXcIpiTOjXykvkm?=
 =?us-ascii?Q?V/AiDje/CdNduM633/c5tNYH1F5dGa1hF0c3qeflPkZsyLQmyhx9L80AaaxE?=
 =?us-ascii?Q?3tVp5KJoZZtRpDvpW0Y7CdZSjNBwaEq8yyDxlXk/4I9acpzshCGW/8S/vLe7?=
 =?us-ascii?Q?pFaMHkbvBOcnXLAAjSwbo0bE4W1gn4Bp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:54:17.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cab1fc8-26da-4bc6-629e-08dc99148453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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

This patch is to add VPE 6.1.3 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c9dc921d6a92..8f5de513d951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2363,6 +2363,7 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
+	case IP_VERSION(6, 1, 3):
 		amdgpu_device_ip_block_add(adev, &vpe_v6_1_ip_block);
 		break;
 	default:
-- 
2.43.0

