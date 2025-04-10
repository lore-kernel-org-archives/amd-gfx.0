Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D18C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 16:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93A910E372;
	Thu, 10 Apr 2025 16:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YYgz/ey3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A914710E372
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 16:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWAbsNM1Dp0MpZqnKnFo+glBhica5NhJ7MUVAKmc2TU1zYiG0eFADxYPljmX13B9roUvNTVhUC08VA2Hzmdu8KyV61s0i0AjxA6IUX4rDaPpYTs2ghpHYf2ap0o9KpT4hDEovTQx/PEwSPGGgaVMH1+AJ575gWbWw76U/o8ET0gYy844bA0fBZjWtjiJPR/1Bl96hi+RwyiSCDN6WXo6/ghbP2iFiAnKOXTLgjkSGy6+MokOEK3uppaBqdvxkeGpkfd6/IIy4ZFzoKVG4UTZltRDtcEGztiZw0gX+k8LZW189VofEoNAa8Oni6ySvAx9FO//6fUcMBV+oBOabaPkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kK4V2GXFot8GYq4vE0LzQySBsFL6VAc3uKANmvDEIM=;
 b=Iu8NJXWhzyh9i2IRcID0STdH0MHXLUD+sW11f9PTkFMzGiYsrmETb8+P9hyrpVKA7NIzJAjrxm2SR8eiGjQgjxLHSLlvh/ivj4VKOYoZGTPKQgpfkMURK9HUbULe/uG5jo53hryUzatxbgRNcTGsnCv6dlkjeadYLOMXMYomKZqsjS7OVSzuEMnlHjHB4ihV4xc8Q5Ryn8YRnXFE3HgjgvWzDBTiRB+F33BCNrXl0J7QlZ3o0fZGFoX8KWv4BJ2yJaDJbjjozp6dqKZi1upoR4b/uMwZwVKyUxAbvWdyKL0Nbn9jB9jbn0A2YIjnAFyiKrSoeLAx6lDVz3+7t8gmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kK4V2GXFot8GYq4vE0LzQySBsFL6VAc3uKANmvDEIM=;
 b=YYgz/ey3pktaqZGwxBFjUHSc2bnP5wXgCDGzJq+0Xi+CR0zSYcel3lbUA1+eszeKvYw0jHZ9yod8CP0W3weVPjOcBrqClRnca+MR+3gYNc8S1+4dhSgfuzAukJYqTooXylVsUteIk31h1+XYrAjdR7GhpXk/TYRrKF3qQlEXPTE=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 16:45:29 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::6) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 16:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 16:45:29 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 11:45:27 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 1/2 v3] drm/amdgpu: Add fw minimum version check for usermode
 queue
Date: Thu, 10 Apr 2025 22:15:12 +0530
Message-ID: <20250410164512.2750-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 706ed351-9650-4f57-5e5c-08dd784f1a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V7U0HZuoWNDVCnAviqnXMHG9TUrTOeB2/MZrZP9SQH4Ncbac7mxvVdFBZZBU?=
 =?us-ascii?Q?CBpRpEjDOjNe80FNzf2Hq6gLXWjjB5sPwsOraDpQhpKRr0KFPRBvkKArNHOH?=
 =?us-ascii?Q?UKZP4EtL8gj8Ot6R9lxk6Jzj5bJgj9QDRwcOo850RSrEroO2PszAmggigNuM?=
 =?us-ascii?Q?32+lxzUkwssjhi/XAMFoPOTxTXVqfXtNBudhVz7v5m25BTevaA4Li6EqfQj0?=
 =?us-ascii?Q?gSN0cCaJX0IKeUtCSVxpLREyD33NrqSDzQTSC9Cnzk6Me0zds5W8w6eGy81R?=
 =?us-ascii?Q?/SYkp58IklZodH7JwYTUckWKPQt+j50Snpo9tU1ytrVTbPedthCAtKd764hi?=
 =?us-ascii?Q?b0gnWBzNoGrQ5/9QrdUa/jTzubGcDKMdn63CwxrKY3upBPRmAuLlU2+ovChP?=
 =?us-ascii?Q?vx0xMoHaYYoPPoOr4lF0DtIndo1ACOSx5iMs4z6yyXW4CxgySnRExgLmLJfN?=
 =?us-ascii?Q?sSspRbw7d5jHyYKrLASu8CCRYGF7nlOSmsHlQ3vJCnP82mP77UIpNhHuvTSt?=
 =?us-ascii?Q?7ikzzpg/f58ptXKI3zE4GQM9Nis0HZ4i/7ct+kH96sZhXsYKSx+1Gj+YqbN0?=
 =?us-ascii?Q?FBh+jA7ea/AjAZ9PxP8hd9+jQmZ/VUuFjaAXCQjSuD+yqV6ApM1CGqWcHhlW?=
 =?us-ascii?Q?3D34DhQBoAKzwwaD0tgKrHlDmUO0b1/ZHNKxsHVdxSDzMJ/YZfXkB694lnDr?=
 =?us-ascii?Q?YXhl6aNabq5RwhWZ2LNK4IBE1wguSU9ewkHYkm/PZgmos1LOeFI8Heo0XY2F?=
 =?us-ascii?Q?p+GMDSNyydtuEsYQgf3/oUt8ndWgs4Lv4zj6pBl5lXcT5yFJB6I/7jzhxQmJ?=
 =?us-ascii?Q?9fiwxLFXq+aVX30FlxU68C9mYEM3dL2y0evap7gbZ/QRwKXI2lcrJl6KpvYa?=
 =?us-ascii?Q?mZlmE1Kb3sJE1aiG2U75BGXzHDds/pKI4NrL3zdlId1nIZ3Z/AcvROIH8QL7?=
 =?us-ascii?Q?fmBtYOcKqFneG1QRvoEyJqtMomRsenFcou3Pns2xq9hcu29VYX2ZGSMPQ3T5?=
 =?us-ascii?Q?UZX3V3sIVUO6b+1rTgJ1h+refXnqS9iUlBVaU1lToyPQHv4spJkKJgMkiN85?=
 =?us-ascii?Q?5rs6DHgqu1nlNFxHYjRYw1dUq4roplOsnjH0oMs74olwu32yQs8wblUePq0g?=
 =?us-ascii?Q?iiE3KuaX43NehvRqwpX5UGPaOqRXSCt9YwnWNsWS+fWuCcL+lPIrbi8t8kas?=
 =?us-ascii?Q?4LoW0LiSUZJZ9OteKJ36cYVi9FChhmnshPgAv9b+aHUi1XSph0j9SsrSxuvO?=
 =?us-ascii?Q?KzCAK4CdzISPj6fG2aic3TGHq4CE5fnHwZFPuXRuJqmLEsfMvzBgw7rw2a2e?=
 =?us-ascii?Q?4Npg/9uW8fNjHZy7tPoGnNzDJMy47InktQPX8rIWt09rYMwrsGjKnqlNtHsH?=
 =?us-ascii?Q?dTFmigKXctLPB/pFTBOrLqgPFufywclK3M585cBQ0tAlw+7x2Lz8Y8gApSAg?=
 =?us-ascii?Q?Us5hSvh5cj5V/8f5lbj2qE+EjWc8ujpWYzZIG4KPxMzY2kWLtsV7gOeqsHsr?=
 =?us-ascii?Q?6Ayh0UzBwoPOt7gh0d8ZPb2SRTEcp2QxZsSt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 16:45:29.6544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706ed351-9650-4f57-5e5c-08dd784f1a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

This patch is load usermode queue based on FW support for gfx11.
CP Ucode FW version: [PFP = 2530, ME = 2390, MEC = 2600, MES = 120]

v2: Addressed review comments from Alex.
    - Just check the firmware versions directly.
v3: Firmware version checks only for Navi3x(by Alex).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 91d29f482c3c..460bb06d2ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1632,7 +1632,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (adev->gfx.me_fw_version  >= 2390 &&
+		    adev->gfx.pfp_fw_version >= 2530 &&
+		    adev->gfx.mec_fw_version >= 2600 &&
+		    adev->mes.fw_version[0] >= 120) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-- 
2.34.1

