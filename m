Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2920EC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFCD10E6ED;
	Wed,  5 Mar 2025 05:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5LP2COb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FF010E6ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LddlV9YOjQCXpqt+oaaJg3gGm/yuqJJ+g9xvhIEP/OTWcBJvg8feUBd8nefk/dZlGRVAvo+bKDY0tnu4kRBsHKwuWzcjAltEUAuZgjLFcuQYEBS9y4WRxmsV51+FU038iIUprmXdAirp9+/JFt9TAcSja1vlGk2mPlxWFHcUs5GfYXCaJ7k8KwRqVPuu6VdjLDBjegAinxwcOrvnr1e7uM9mfU1fvhKKp9vsWrbeXGUfOlQq/ofzz3imNn2PdQRugcKxY1JqiNaqmyApeQyW2ala05a0S08hXLjqjAO6U6fIIjlHWJhVN2vOSv1A+U/v9RshJqSvwX9TsT05cf04sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bK0V80V0vfKdSo5EWWeTxZdF2rKBd9j5t2UCxlJH64Y=;
 b=Cic8x8X/vu6ItravIyhW+U2FGL7buGl/BnouIP4PcfEOaTeijjs56mdAsD3iuM/Eo1YycWNuX3Qn2d8CMMrKrMNAQNOH4Kjn909S19F6T/2LKFrSbkDYICtLY2DNbuhIyaj/Utzcp94Y7nob87j4r1ce4mtgVz/UaJYT6xStDnrFfqea+aj2+L3mrHU+QnE39tT77rzWU6I1P5AEpF9OjC/uhKhE507YwNJbPNGvRnppJhBCfH1P3AT9x3CT6MgxzhMJqyvYlPPmKLC9uqMlUGWg9U0iuMluHuw7A1noktiHpXpWDlQd6IubFLihgQAB5WD9HkGHwwEb8UZlQcKKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bK0V80V0vfKdSo5EWWeTxZdF2rKBd9j5t2UCxlJH64Y=;
 b=w5LP2CObfc/U9zEEoZQLnSYB30BEo/kmYoBfVlyCKXd5RpWCGXNdz/b/b4i4dNl9mRMu/vrV16ejtSY35Moqvdbfg8yuU0/Sgs6rvf8WHRcgZjzvi61747oFUsxd91KH1CU1pSOJ4Um9yljXvR/9P5QCEBV8x93LtMYBQGY9+UQ=
Received: from BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:17:19 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::a7) by BL1PR13CA0427.outlook.office365.com
 (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 05:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:17:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:18 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:17:14 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 20/22] drm/amd/display: Drop unnecessary ret variable for
 enable_assr()
Date: Wed, 5 Mar 2025 13:14:00 +0800
Message-ID: <20250305051402.1550046-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ed286c-d812-4176-b1ff-08dd5ba50030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H/9wY4Z5TM+xt2K37a4HyyYd5DrTUig6/eEtEs+z95v/SNWw3ygjPiMto6xK?=
 =?us-ascii?Q?ybcd3erNMmInrNwEyzHUe8VHBoSxwxSC2gVe09G9QPqsQas7dC0RTCARp5ah?=
 =?us-ascii?Q?WiLxYLbT5SSBSLo9525lgEGWH/x9yE2Psf5I6S6Xq6t8W0QTyzHzTXsswHEB?=
 =?us-ascii?Q?uFZ+It8ufsNUYwg2t+WJxiRiJoqMmF79URVViGUhx2vFPlkRy1/37A2TETUf?=
 =?us-ascii?Q?J5XG7p2mFYJKLiqqi/q2B3IN0+67k6bBldcJgPAPqHLEt5M+JVZwHqE/Ue+t?=
 =?us-ascii?Q?PeaxaXamlRT7d37lrZskV1YZ3mDT9Wxek9Q7qFx8gY6Dnt6UiQX8TLQ+IzLG?=
 =?us-ascii?Q?c2FBi9F7PLiGCRy5Mgwif2giJBygGTp1Ls8gIJUuauWQ0FRHDFkLiXrqKXH5?=
 =?us-ascii?Q?igU9tcRteJWPIvt/mvuuNp0NwPGQIR/uali2MYQ7JXDXNQoUs+c1dr01g7A0?=
 =?us-ascii?Q?s1V73I/gAslxXBqKDuP0zo38eIR4eH3zbl6UUm6qQF6mYFss8acSV1Kz/s+G?=
 =?us-ascii?Q?p6hm6JRVwWDuPm1ODiE1lJ6DgxLQAcmsgiJNc9IeiL3BFF3S6yFJvv9MygLV?=
 =?us-ascii?Q?c+/bdJLtWhC8eNMDeWZcFpVesq/+xeWwmy1ayuu1N+DWg7xFVVjfE7qQm0xI?=
 =?us-ascii?Q?YZsqawRTct/MYalxUArQkcEUAFw6zfW1Ogqvjl0AHlkwvxWBSvrfxPbSxvEQ?=
 =?us-ascii?Q?APKUjv7Jl617r0WCXOCIjgSX4cYneg+zmBrk/v66bFVVtBspMJPDs60jTYbD?=
 =?us-ascii?Q?FHJscq5sgrHMRp/P9lCZR1ERXYvWNVFqF24CP4vNhYUq2+H3FDaOd3BpfCzY?=
 =?us-ascii?Q?+GWsLKe7KzyXndmoUffpfna8JarUD4oN/u11MUw5jCQs0FpoXcbmDOarAyi1?=
 =?us-ascii?Q?mJ9h/SB+Cb7qoCejurksXqGW9CL4XlU3qU7Qf3bAHLNbbuvtI5CCCe/6TlQG?=
 =?us-ascii?Q?szvU1vtLlKv3SwFt9qXj9mi3RtJuL5iISOLSBMkTmgRWNPjrHdhJC492EASF?=
 =?us-ascii?Q?YfHBIsFx52CuBdzy/CV8uL1hm8/cbmaa5E2WzjloC7/IUEODu8nTNKLz7Cx3?=
 =?us-ascii?Q?QlcyIDpTVtEldtyyKYZ6jFbQpyn6YaoEILf+lIr3dvbtCTyzhhSwvOnihfdr?=
 =?us-ascii?Q?cLOWu4uhIiQ5KUv53BrvoVAgnOFnVtoBWQ8Jgy14ebGXiuaPjYrZV0SxpyIy?=
 =?us-ascii?Q?tbg6Y5Fx76dIX/PrgGV2rtC4WDTG4qBPBMl+2Py+pajNaljrLfdjkaR8TbZa?=
 =?us-ascii?Q?C88qSafPIuX1+qBr01AsTE/dnJU5ohaDs1CULPA/5BXY0vyUtq7LnjPY+/aX?=
 =?us-ascii?Q?L9n4uGJKWDm38A4YPkGfMbu7MAHtLzYAHv94QnQ3lpfbdWZwb6qzF6Lk+S7J?=
 =?us-ascii?Q?A9qna/oAj/guU2bb5mfET1JAE0oNx9K+6qSIqSyyb828xQV98QzRco79+g78?=
 =?us-ascii?Q?eIFH9eD5XjAClrSM5kyN0++/INYIrBhy3I5R6jiWndNLzksSti47c/fJ+BvT?=
 =?us-ascii?Q?HMnEHYUn2FNOOKE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:17:18.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed286c-d812-4176-b1ff-08dd5ba50030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
enable_assr() has a res variable that only is changed in one block with
no cleanup necessary.

[How]
Remove variable and return early from failure cases.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 6f8f21e123c8..a3e93b2891f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -457,7 +457,6 @@ static bool enable_assr(void *handle, struct dc_link *link)
 	struct mod_hdcp hdcp = hdcp_work->hdcp;
 	struct psp_context *psp = hdcp.config.psp.handle;
 	struct ta_dtm_shared_memory *dtm_cmd;
-	bool res = true;
 
 	if (!psp->dtm_context.context.initialized) {
 		DRM_INFO("Failed to enable ASSR, DTM TA is not initialized.");
@@ -478,10 +477,10 @@ static bool enable_assr(void *handle, struct dc_link *link)
 
 	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
 		DRM_INFO("Failed to enable ASSR");
-		res = false;
+		return false;
 	}
 
-	return res;
+	return true;
 }
 
 static void update_config(void *handle, struct cp_psp_stream_config *config)
-- 
2.34.1

