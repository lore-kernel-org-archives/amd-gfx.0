Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40BCC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5130B10E8B4;
	Wed, 10 Jul 2024 19:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o4fCDozy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BA010E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsleN8zl/C4/WOoCteadQHfeHevxUcCyqwpMlgWhT9bj+D/hHOUG7baNc+dC5OZESKn3lCK53lSlOmwRIV/7InOo43SjYaSc8tpnJWcRzOEBYVygBi6qCFqBt3857HQNvrt9/bdqGaQk6ZB1YvY3uACis9gR3ih8Yt9O0S23H93A/PcM8FMu4g3qfsN0DyuFSWQYF/ebwf8SYoyWB546jhMV2fN7o9g7O++SDxaEFFsPBkevgAJWwNZyrn13HOSy4RMR/NTp5C/Fychal/Y/O8X9XNQQhaj7s+2V3JIqkESU8cxOZxN8XgLuO38xKVGWHbTE8R1/ULhA1A+libcyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STS25/HnaRfmcLO992T8MkdapZ8OExDKSSEv2STjamU=;
 b=MmcRTzxHp/LWnUJMgiVYZA7KQftBosrIqM79dhKjPd8WM2mfGp0rM2wij6FYDOzLywH4FpD4uESD8K6gbEpPb7cMtEVeUwv5w6nUMwr8IeHRAT9T+Q5NnJM7wjnJ6JnT0tTts1+poyRJa9S78d8efz7CN0AHG5+8KV4kPTFkfjrPgibXadjnIQ3l6WZ2hxyuWtvBPkakPxrZSmg7TxDLaqI5KJfY3SV7AWzmAz+631jvrv/E5oF+kiAxJcZyYHLFfEs8/FiX0iGHDKkMlSpaMkFl3omvN70hA/5z6c1+avtRH+cUxNzZGFt/T8LG2ZQPPWV4sZ4CI7K7tQvXZeFDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STS25/HnaRfmcLO992T8MkdapZ8OExDKSSEv2STjamU=;
 b=o4fCDozyvPjwtI3tjwx3Tmdt8bS0LaQNNs2ft10ui5EVRLfR6gFxA+nX4puaWJVVMR/N2BtitbfKSjK1lI1EMAqhhwnaKq+6I8CC3fZVjDpTylkyY9tI8dL3q+ZcoqJvHxfdkpJOaqGd65V+0BhmYoNq99QyABZ3KbhFEF6Ez2c=
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:39:06 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::42) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:03 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:57 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 22/50] drm/amd/display: Check stream before comparing them
Date: Wed, 10 Jul 2024 15:36:39 -0400
Message-ID: <20240710193707.43754-23-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: c46c5ec5-9456-488e-9497-08dca117f596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJumvADm+WGLpnACmi2v6kWnTopHygzhN4dxpzQ+7lrybwkjqJFP1Ow0zHwX?=
 =?us-ascii?Q?DkF7H9y81a6baYrwWeXPQ4/pmSdGs8YLutl5lAJvDp9Z5otNAfwloee6RJ8K?=
 =?us-ascii?Q?VSeoneBY4sOIqbHTsClFO191cNy7rlPLl3c3VWo1hq4bfwNb/CuSPH0ftzE5?=
 =?us-ascii?Q?CG1bbHxQAqLL7F1MIIApcvKAVdfJK9Y3Sxw3lJhTyDlNjUhG6kDJyddurATu?=
 =?us-ascii?Q?m+SEj8nRrGoRto3GHea3NeXTgE26zNcYXrCQF74nevjR0ShLYcRVDpGw5yS/?=
 =?us-ascii?Q?yDJ8vz94psz0T4lhCkxhX5ohGRCyMx3msdH/qPgE5R2CjafaldlDHzQBATCc?=
 =?us-ascii?Q?tnBeWwgHKuIXxmLxVoXE47f3lQlfsro0Y7804+PNfi8zIoDqfwEM8AEMhrT2?=
 =?us-ascii?Q?7qQ370/O6NDbklcUBGfZplFIHY/Em9fkZqw9Jzy1vZduO8ZRvPQ05HaLBwSk?=
 =?us-ascii?Q?XMqwR6g3OlHxh41WuvF+lTspuscNMCxmrLj3xh/7EO1e8Sn6rFSrhrCdIRkB?=
 =?us-ascii?Q?JMsldDVQeIbEH/0jskkjk+XLDlsdvYYR9E9evpUrBAmqd9OKn1qbSAi39nS1?=
 =?us-ascii?Q?Kwg8XownDg9UcFfG8UJrdC7rwVv7AnT3DkT2E1qkELUU1L8ZqdHdnUvslhO0?=
 =?us-ascii?Q?dtu9+kHZ0tpz9agQd/QQ0K/iBInwfEveJ3Gc3nQaz8aQvtGeJcWeX0OGxObf?=
 =?us-ascii?Q?XEKb2907vDGAUlTt/F/iLpOf1oTP8HF1SjImS5EWNXfWMjhe0NrQw2/NZ5nx?=
 =?us-ascii?Q?ZXq+fsASHbtx0dHdkY+hSZFw5GiJnJqbvtGbBkd8uXyHcC+3PCv6VAGoFDW5?=
 =?us-ascii?Q?mLaMvgsPPTS/lbgqfuAeY8bxIMzXscRY8TyHH3kuwsne3iU8QwDZbAz0sRsw?=
 =?us-ascii?Q?1iDfUDDbDydBR4uZE0HFyccqg2G+++e4IPTB+/BG6ihLH8VzTPHe1sBo4vV3?=
 =?us-ascii?Q?xNcoId7JTxpcMtr1YIxJSF9kqS5GgPiVxmq7j/sLxuPK/37729HlyUJYDqvg?=
 =?us-ascii?Q?K/citpymQHlYtlk2MfH62r253N6YznwmQHY6PmJIjknp7w70w4bjY/hXVpAt?=
 =?us-ascii?Q?uvqjltnF+OkD1KQy4pJgTY/5oQx3d1ghMUTDFJ8h38qhO5hM81ZGBWqqaVKC?=
 =?us-ascii?Q?BQ4RGvznlLXeF0nb8wVvRZnVokrDWukZwfRYg8LJRlhMCLANZFxDSZNQosm1?=
 =?us-ascii?Q?JLGIeW2hdlY72ULaFuQdwHKLfKsxjDF1xyY8PGAiDJAdn3cbZ7sRW1yXRZkc?=
 =?us-ascii?Q?auadeufSCggkdRRvTsKCItwOTTV6PQJZfciZhwmsW38lev61KTzpIOBRTDDT?=
 =?us-ascii?Q?6sbanyhbk9NJhN0tAbWIA2Po67J4RT38Yf2Y09K2vUGRs9g+xryPrKYgR7oO?=
 =?us-ascii?Q?DUMq83UzXmX6eRpnoA4MzLLRtJQhdQREnduDGCSXsAYUSmZ1fE3AfUZy/gCj?=
 =?us-ascii?Q?qXjwvPleKZ/tyRFfCr87O/MDwuXGR9aJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:05.3717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46c5ec5-9456-488e-9497-08dca117f596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
amdgpu_dm can pass a null stream to dc_is_stream_unchanged. It is
necessary to check for null before dereferencing them.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bcb5267b5a6b..83aa3d8a997a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3241,6 +3241,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
-- 
2.34.1

