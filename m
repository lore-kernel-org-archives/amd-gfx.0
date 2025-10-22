Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7943DCCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 13:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2176510E782;
	Wed, 22 Oct 2025 13:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOd6C8Dk";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7116910E784
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 13:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a130b1Zge2M1Tfj40mKAk2HYOnT8NHbVAOehlDFZ464NItV7uUmdDyEjP+0T6gM6LYRT5wOd22IdvXZwemhXB3ia851ZJVAqvoMCP2YUHjzxAncoDt53CF5y/W0HzcruakbbsCVuOjVHwgBSd0rWGjIIUU/My3o33wyouzLGmBt+oDZFy0/+5Cvq4TZyK0uz3K7+vmoouqWbTZXUUp+mYc9r66WBKivwBLr9dwoQvfE2fj29NVYAOKC24wyC0gfPVip26cN0CIuXvKKcJ8Z4dbs0jeScHPCjfYzJUmKaSCZNNErJ5lC5vFmA/DDLuaJcRj6fo26aZiCJCoJocJIfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euiMRtczYtTVG5iKLAkssqHwjVV+H5byr+O6kPT1yc0=;
 b=I6JK4BIB6FTRayZ2Si/7nnFOKWKrRGFktBL0eJk3wbeAiJtivCPM9BSJTSQRNTvs3eykI9B4NpSMjxI/BAo6TP/4FPHp767spTBLU0joJZ1yUp5x/Y9V9bqioeJheXBdMkN6+BFSaAwFnRbwQkZkedmfwDMLmvyzmKDRajVNTm+VVz6dOwhyhQsveoY2XkC9AbVOFwnHDSH0WJ0VEHNh6YV4PADetbRgFrTg6eUWduqnbRKd41+kSFx8zN9jbKJZVfb4/NJV6n2zAg4BBVFrUV0QjZ572T3kUiyRvx9XGXGCWdqDT00Niee5ME5ORO9O1iGZtNYV1EWFut0yeHN4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euiMRtczYtTVG5iKLAkssqHwjVV+H5byr+O6kPT1yc0=;
 b=gOd6C8DkBr4VbV6P2nm8CdEAyQ2vtnqf45lBZC55iAKJgowUVV+P5RVEKMsGB35O6alWrnNwVVoUlQMzOl36PeNQl7X36hs7TYHWpn7FgbFPwrljYDEyEq2jHBVzOjcBu3O61IPZ0LGX0ufpaMoaPcf3pbgF23orV3fEIp8/GpQ=
Received: from BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38)
 by SA5PPF50009C446.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:23:55 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::5d) by BYAPR11CA0097.outlook.office365.com
 (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 13:23:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 06:23:52 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: fix SPDX header on cyan_skillfish_reg_init.c
Date: Wed, 22 Oct 2025 09:23:34 -0400
Message-ID: <20251022132334.977886-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022132334.977886-1-alexander.deucher@amd.com>
References: <20251022132334.977886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7183a37f-389d-468d-c058-08de116e401d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?38OZXVBTFQMTqLXFSkEKA6k0D7StAeM8UbyD9F5E19e1iMq7nVLTXyBBpGNN?=
 =?us-ascii?Q?BalY22805wvc2D3bgZpC+uiT0goI0i3CtzZgH9kErHMMuA/ZhqecmZW7y6um?=
 =?us-ascii?Q?K3Rb9p/TIg1752xXWLTUndGqTmcWKRblLEjQx1gQvfKkvXyOKIBrSc1ytUSd?=
 =?us-ascii?Q?Ze3dbFU8Ss3BciUaoxCfIpxCjEKrnodHZ+EnbXKpg2Wqbr0toUQntjs469lw?=
 =?us-ascii?Q?TrLHFtszr4/gSg04aGARD9JpTSkBLe7zRgTFyMpTNB/4yj5f2uxroxy81Egx?=
 =?us-ascii?Q?bL7WrGl2KA+l6IlvVcRfob2wiHX4rSfrHT69PNLhczHepLmDmaLnBxaPOGej?=
 =?us-ascii?Q?aV0KdLW+XKgc8oYBBAduE4dMlkL0W82FruFsE1+XXfEBMPXt66b/m8sYHBaz?=
 =?us-ascii?Q?BkFZwT9FEYhs8HBxMptlMtGYRNPegi6ZqVLcd9ZGvZLnke+VE6LsfbHBnMFQ?=
 =?us-ascii?Q?MD7FdqiNgOEmBg218R7TiTFtTw5SfUwvwBNt/RKc7IPYg/+dDq0NaiybK5WZ?=
 =?us-ascii?Q?FBSq69ceG6QtbOuvkCZdnrcrCYJdt1ruEyiOTnukxFcsXxgl7CFy81pl4GLG?=
 =?us-ascii?Q?x/bQHpeavKdxp2950o6cQ5X2gdtPzS49U+wfISnl39fzZ9Eg98VclqJSpYb2?=
 =?us-ascii?Q?CYW0hY6UuQpPq1akWS8T1RH37fPXN6Zyugq87rMgfqHftjstEXf0wuwrd3DQ?=
 =?us-ascii?Q?ZMAN7KheuWngstSglh3nMxAhKMvF3fi2uVNxE2MMCQVMkjwviQ0MQNgUGdog?=
 =?us-ascii?Q?UJLTZW0+VNk7+9nukKjx0B6XUl4QiwGTAtgjM/yAA2TJOIMFJomAAQLs2/lY?=
 =?us-ascii?Q?XXgUQA79WB8hEIAGQTz4kM+dUPZhXgZ0kvRiUBbL6P2I+n6K4WhH9IrtPnBD?=
 =?us-ascii?Q?eQMP3n/2/9T4L9P7udBDBGiO52/LxDd1exwCpqvo9wG4foX9zzuZmt2NKmQ+?=
 =?us-ascii?Q?1X0bcYjC4+BZTxbw04h7bog2UoZSabCsplbJ0ki39a8hPsZEVHahmX3uGdc3?=
 =?us-ascii?Q?UVJ5XfWFwEy3wDIANN5pYupHD5eKiOtFTbjWPTqRhOgxUXKqJq2dn3W+MV6P?=
 =?us-ascii?Q?JHzz4X5r3xK6WHESOgOvmF+Rq2/aON5XLFcA6P12QcBSGCo+RQSGyylvXQYz?=
 =?us-ascii?Q?0hWK+Pc27g1moKwfXpcZ29XbJacaX7LRqqGcWoTTXycIT41ZRtqt6c8Ia48H?=
 =?us-ascii?Q?GTl0+LPyRwi/agv5ovjE1PZPtdLO0Jaj6h5Dlohc4M2aV4475i5MKflZjQKj?=
 =?us-ascii?Q?OLVIzmSTTP5icqbeylK5hU579kQ1cmjGbYvnpieifsZ8qW+TpcQNgq6c3695?=
 =?us-ascii?Q?KbaJmiIQF4qdd8asBpleDtndeHxdplj17K3ndR1nN0yRtwuQx+yE1K79dgQx?=
 =?us-ascii?Q?UgQMtLv+EptZv9lDOXONkpE5DmeTKYLzQCrUgEZMi34lbI6WKtMXswtfW2G7?=
 =?us-ascii?Q?sdPq/IByeiljRs9yTX3ZD9roQoeBmxOjn0AsG5qFZa1LjB/6xy5Mhwehv95J?=
 =?us-ascii?Q?5MDTVO4Np3SXbEc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:23:55.1622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7183a37f-389d-468d-c058-08de116e401d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446
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

This should be MIT.  The driver in general is MIT and
the license text at the top of the file is MIT so fix
it.

Fixes: e8529dbc75ca ("drm/amdgpu: add ip offset support for cyan skillfish")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4654
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
index 96616a865aac7..ed1e25661706e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
-- 
2.51.0

