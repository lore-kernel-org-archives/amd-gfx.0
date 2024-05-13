Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B562C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AD710E94E;
	Mon, 13 May 2024 20:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oXlp6ZkI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A5810E94E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8h1AJotr7g5i8Z6AV3qx33Jf042AT+Tx2XWMdli2nrBArnCnC1nNv227TlegHx7mzCfS09MEy4kYh5HKAnsXF/NFkUCawHmDL1+KvWd/gK2L2WJDpbrKeeYq7s6WtVEbw8ivueJPc+U34E4nrheL5GcD6yK/DKzHiahygQzRrBvY+DeactvaiPBR4A8hmbTaf0sVUpZXW6AMyJI9NiUC3IZlNMhXLD4R+rnqN+b/dPlP5NkxjMR2nDaY+YkjFm5X2kCfTUA4AZKOr4czPbFpUizMGL0dr9Xv8b4hvncFeiV3wR0d1hXcmMXcJvEDh3FHFlPoR+sZ8EFCFiA0ufvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXwYfBqVMbUXTaBU+miIZA9sd85FjwP5a5vPfBDbYTw=;
 b=oL+fMh0qah4nO2WmI52yV/evbAIehK3PgjWbBa/r5SyIyGqMRF9yyQbdD5NbiPh+/cCZCy2Ibv5WcQj1C84MBYpeZ8jcYoMyOvcBgW+l5h4mE8VZfFq8t7F0IWvmn1VuwnohK8OFa/i9CpFt8VdWj1ko9NyV+w8nEGixLiwkxitI8C0aNw0dziL+zVOMEUSa0TuqknJjKymEz0NyyimiUDJfPtTI7/eaeLmlB6nJA9GwjG4HzVd3UXpYUAwAiGjOzwoWbjdUz4UVVZspUED48G/Z6pDkZ5WgHKqDiMTXJAZ4k2xYVI09rp5EFyTV0ZMXe0tk0GNwYc7Q6pvK5L/SbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXwYfBqVMbUXTaBU+miIZA9sd85FjwP5a5vPfBDbYTw=;
 b=oXlp6ZkIl9LhvytiJPbftApCxG0TJIAmpuLI9jDP4UNPE1tOu42rK0gpo92dotO9fLqwQsvOckCJa+0Yw5+u9/k6fkzAE2GPUtcpBX6fg/Hx0GCLwU5zwG8N3ZoVv8+ohPUOSPEr7Miaqeu/ZEqWUpTD2qIHrIYQSv44jUIwH/w=
Received: from PH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:510:5::23)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:25:35 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::2e) by PH0PR07CA0018.outlook.office365.com
 (2603:10b6:510:5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 20:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 20:25:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 15:25:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx11: enable gfx pipe1 hardware support
Date: Mon, 13 May 2024 16:25:14 -0400
Message-ID: <20240513202514.141828-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513202514.141828-1-alexander.deucher@amd.com>
References: <20240513202514.141828-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7dfafb-8445-4f71-bb69-08dc738ad882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wku9aNJo5C5XnmWgUBuBmwOtkPEalCPa89zTUQvmW+Av7dVEeAP/dfc9os0d?=
 =?us-ascii?Q?R49FY4IGYglovWLOcIcrpnhgn5PjQE7sPp1XhSwsfwR8ZM+TWBBakqDiInCx?=
 =?us-ascii?Q?u4DOgJAtZu/M4pd4jlExAg4pD5fZN8bAB6uy1Y/txIz6lwue00X2Wi4/yr0p?=
 =?us-ascii?Q?BwVAhgIw0usfYl8s7HJdjqvlznssKJYbwFdgdDzU6hnyKY+PHwSCFRcCLdc7?=
 =?us-ascii?Q?G16E6ecuHJ/3xkTzwtpFC2g2PPxheCx/o0/fnO/jCC7SzdLNY/tMUvuABjxN?=
 =?us-ascii?Q?6Qhh8QA25VSDSlFBmwYPRx7cYtpH3CnnLph034baLGabD9avfAlOv3NKyPYX?=
 =?us-ascii?Q?jjPCABTtKnstUbbEvcjwtUAFtjVYmsIgSvWna7/6rRtXdDkppeI/bSbNXiId?=
 =?us-ascii?Q?twkEezepxX589Chl6NBEOB/vm7R46y+zdWFnVSb7GY5CGzR1NqJ0KiSiUC40?=
 =?us-ascii?Q?X3YjChlHvMXNrDcVv3i8r8s1YFDLzE0XgAIYwR0N7vWpR1vQRzR9x0adgcVs?=
 =?us-ascii?Q?6xdR6o7bEONcTMDxZhO1nTYTwT7chx2+lEoZg3a2UX8R3Q2psa4QcUEbQXFQ?=
 =?us-ascii?Q?FT7ruvtHc+UZuUl3DG3EcX+KZsdwvowuUGYCaoanPUIt3feFJMqpD/t+IZis?=
 =?us-ascii?Q?p0leQ2YFVCgtKdNWszFREkVhMvOUTjc1RKPWeMZio+/678uvqgYYbvxNREhj?=
 =?us-ascii?Q?fMpVFpQAQ4Sciwmp/1ePIi8RfB2NQWZ5vH/8G04MhL5LuZE46RFPsbTFqby4?=
 =?us-ascii?Q?Ht15xJ6xoApLcLe/SIPa4pC3Nmesc6Vt1ELcppbiLn1I6dRoKGzyb2J1L/zw?=
 =?us-ascii?Q?ORAg27kZa+5IGf1zIlKBFk6cYBkdu1iRI1b09NCHpWqbi2rioBlrwhqVR172?=
 =?us-ascii?Q?KJkKE2lulTL3o6vbyZN56/+Tmar9JJqjoXnMcrIYOS4NIL8rf2xpGk86awev?=
 =?us-ascii?Q?EmgKeqW3DR6guhTL9fPw4bnwe2WXvwcwkxyn1nexche8+2lJ6zZ6UXUr3ZkR?=
 =?us-ascii?Q?Qpw4tMMh7krDz39TcN8EDCdBKInvahq7Zj71A3QC7J5JSZQdh8Vv8l0Wp+Hu?=
 =?us-ascii?Q?WNmveH2endpWK9yvHzfQvK/ewB0NRHfmOdbkemMiR4O66qx67HbcRe9aOC8d?=
 =?us-ascii?Q?d14cvFtTaLTE80pII6Rljc4msXHcGISgnkhzcS6vsBfV61K2FGsIitu+bH39?=
 =?us-ascii?Q?DKadABM+BLtkKHnUiBgs3rlr0PJJzTgT6vFgDryrXc24d7RwKs/Iwe+zQuex?=
 =?us-ascii?Q?pZhsfH7Wz0CsMybHU5QG3fEeiTyIkIriZxRlTrYQbJEeOQr+V8uWMxMR9iwP?=
 =?us-ascii?Q?gDxdvixfqo/R0quRw/FY174FDNd3D+dSAh8xVm2/NdcYbfFkKPazO1vLDNRO?=
 =?us-ascii?Q?kacDbHJFId5A/WStrjxeIPy/yeTw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:25:35.3332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7dfafb-8445-4f71-bb69-08dc738ad882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

Enable gfx pipe1 hardware support.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d750ab86e4b27..96f441917b719 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -51,7 +51,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 
-#define GFX11_NUM_GFX_RINGS		1
+#define GFX11_NUM_GFX_RINGS		2
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
@@ -1342,7 +1342,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -1353,7 +1353,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.45.0

