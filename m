Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BF4C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA0D10E8C7;
	Wed, 18 Jun 2025 15:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3XqycxvZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7192810E8CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFfVptSenMsIXu6OtQKnUjWO4cjgGpbuxJ7BGjgkZe+hcp9xrZGSd4sZAJ3sUTUHZ42wZe+l07nenURfY3I4riJTiJmT2i+A9yN7hpI/lAmTgngkKwOpdkUf9BZ+7RI7PHfpDRctf410a2pxKQCJre0qpqxiI2Fus/wYXUGcwG1kyKf2i8o3GpqLrIv/O5NOGHftP3upgoa7ZZbSauA/fyyJo+b4VsXsY/nCncyq2OUfdgd1qwpofCcrCT9aUaUU70KqselD1rDMjR1oC5wq6u2G7QMawGLRBwBYLvpAy+DIgdVYQ1qKRn4I2a3Ex1DpOOZ2B/CmdtxFZwMp4CUHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI/domAe5WVfni4s/3Nv3VKuTXSD7SKZ5Kwqp+PmRFY=;
 b=LsUjYVhdNs+Tw0kdyGCTKQhoV0Sut1AwMlsvbP9ytuXGuKfPaH4X4XFALPx7pVb7GamfXQPJ9XVkn8BlpLbujrru2Jl4+GAKjBeB8NajOFJD3hDyTzrWQCkX6AdQyaWlYUnH0+y5v8Lrc4gmWC7WL9cwFVKNMUKEXDDIYR4HAdFEocaqC5/VY8XZbiUj/DDwMEcavSNYXu3lTrwGlusgJVHE/jSO8h3A2Is493N8XvMCqS6luXiIB0jQTw43qS+CGTJJOS4jRiBmdyQMibfcLXplHvmrrwD71VJ/CDb+9a+8muPU959nGSaMub5O7zHCWe4MQzRSAl9elkeSLXGeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI/domAe5WVfni4s/3Nv3VKuTXSD7SKZ5Kwqp+PmRFY=;
 b=3XqycxvZGo8dKlJCNyalpB3jgcKD6IfhBAjursuuFSG2G8tbok1e9ERw7eHum68d0x+UXoTaiYYvC6YOOzLACkJYUPM955iyxm0rlBIoYNSflFYKI63e6DSPS7xrCwiBcB8xpTjQnTwneQ5Ko1HOo+jEmckMxtfFqogyVS+VRLY=
Received: from MW4PR04CA0128.namprd04.prod.outlook.com (2603:10b6:303:84::13)
 by IA0PPFAF883AE17.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 15:55:10 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::4d) by MW4PR04CA0128.outlook.office365.com
 (2603:10b6:303:84::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Wed,
 18 Jun 2025 15:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:55:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:58 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:53 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 08/13] drm/amd/display: Rewording Mode Validation Result
Date: Wed, 18 Jun 2025 11:33:56 -0400
Message-ID: <20250618153936.6472-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|IA0PPFAF883AE17:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b525244-14dc-4cef-4d47-08ddae808127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?12g+TohJtlHTeCzqZt0As7FEI0562rYu+EZ1ehK+MDFud2kAurXvwf1nW1HF?=
 =?us-ascii?Q?811cW1ALrS5Ce1Gn5Nc1O09PtG5pcCUoM6/4i7TjgZRH2FUN3yb54oMDAVt2?=
 =?us-ascii?Q?ySH2dS0DCFcZLE7kRSLEPheAns8m/B+lMiXqOmIxoysmjoA84GF7roBXFBtq?=
 =?us-ascii?Q?j2kFtcXO+p0kjUzU964D3crgcGfXewjusETr8UE+hTvBVXRHxYQXEWVh9nX3?=
 =?us-ascii?Q?mqY4yF2yLrV8bgY2fI+5s7GC+UnP3JS1YAtWMQUYnPsaTAAx7540kL4ZGtku?=
 =?us-ascii?Q?nzriFOw4pjccrk46eD/FYeMdsJWe+5srcSQfB/x6BSfeI/n0U1Ku+FclB0GS?=
 =?us-ascii?Q?cTSXB1/zh4P1xmN6x3XSvnoYQcib/ctHg+2+Cqrz9ptK+EVkKdMcMcDe3ZfS?=
 =?us-ascii?Q?xzuAZE56CdIlTxdiwjfBGjC6PrCTMTs6BeQTIwrO/h4wrVmd6RKDwLTjL3nh?=
 =?us-ascii?Q?IMiCOSL7lbRoV4D27/7Kl/Us+KpMhnhWKj59DYmy1YJxIWYEFCSEDd+syAIp?=
 =?us-ascii?Q?NzOkqcZA7slck1sfbDUTCkeC6do9lOtNo6+XLNOL3QoE91Xj3iwwmitkoYhv?=
 =?us-ascii?Q?FBUxEIiSzT/W84tyjePhLQkBtP/n+/GgmwNBuRIkIWWhaO5b4iymZFXu8IJs?=
 =?us-ascii?Q?sQaAC97MMpf17kVbCu7n5eBbCf48ajJWUU1zvNcEVQMajE8yZIokaVfDDa6B?=
 =?us-ascii?Q?y+l1yinTZCyswlZ3JILHFQZe+JlOMUNIOS1P1IUl2GReN9Q7PJmGSRf2d20J?=
 =?us-ascii?Q?DlT/QXwbHQkQNZqHRcGZEMjMAkFVChK/PbZDlKtgKHxRuGPpI0NApC4m2tmj?=
 =?us-ascii?Q?D9z1VvG110KfTqGc1b8C6R0v884ZocsC3OGUPIsGtB/9sEsCFAEEpFfMow5M?=
 =?us-ascii?Q?9bPEAaxANCoJoXAPS10HYlssixUsHP1+pBZ92ITiwbrExVF89zKi7HDfyTi8?=
 =?us-ascii?Q?fsjjxZUUX2MFNqRAlqwoOH3qzOfRdy3E+PJ3u2pWyGgTQNajX8nyDmiY8/U6?=
 =?us-ascii?Q?/cLvAxFCNMtrbnHK5Gi6QEWuLVld/NeAlgRmUsz4pJr871iL7jgXNQqxTKMF?=
 =?us-ascii?Q?Z1Md8gE8CK3mCsVlrGnJjUVdVNukrkbiiiKH1BiY0UffDQeNjMfSo1xMDoO7?=
 =?us-ascii?Q?RY95nI00aa465QDYEI2DVjEUAFeBjC73n2BuyhiMBz2n7+ioHMwPnEe+Cvit?=
 =?us-ascii?Q?+KobOuR1uEuLsX5ExAPjRrVEYAhTcMAzUpbnM8lPfrTTmAHGlgJ+LIT2mxPv?=
 =?us-ascii?Q?1Dhof9KIaArV7xaPbYYNDbdldLAibD0IRhHipE6ZbDvTiLorXK8bSwRGLdiy?=
 =?us-ascii?Q?ZUzFGnTBMS/8etXvFilVZuzbv7yZbyclFf/1sk3uhHi4wLuSEZGpUnB5e2NX?=
 =?us-ascii?Q?oPxfdmIQk0+m7RRhzOS+ZtOhsN0kn2ylpE+/7ePNyL8xGke5ShG0AD7iV4HS?=
 =?us-ascii?Q?zltQOpFhZRgWvG2hZ+J8SHq98h72wek2Fuoedtc7oBKTnzqK/Fo2+MOs6VFw?=
 =?us-ascii?Q?echqzlljTsEv9KWGAK89Qxoc7VfoxSo/LFy1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:55:10.1504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b525244-14dc-4cef-4d47-08ddae808127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF883AE17
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

It is normal to prune resolutions that exceed hw or bw limitation.
Use error oriented wordings could cause misunderstanding.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3972427f4796..c380aeb66ddd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7624,7 +7624,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
-			DRM_DEBUG_KMS("Mode %dx%d (clk %d) pixel_encoding:%s color_depth:%s failed validation -- %s\n",
+			DRM_DEBUG_KMS("Pruned mode %d x %d (clk %d) %s %s -- %s\n",
 				      drm_mode->hdisplay,
 				      drm_mode->vdisplay,
 				      drm_mode->clock,
-- 
2.43.0

