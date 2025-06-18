Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1502C73C66
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD7110E8C9;
	Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pfN878Ul";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F7C10E8BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbM28yki8WoLcQwHDR1YQHnZ7zSWQLtK26MoJP0efNc65N9bV+mcwtUGM+fxLu0vUgJx8Ec1nLh3JFU3qeQSlENFH38/dG/qYNO7JFS8gdFIy9Bz66gLWIokgFi7cQqceEGdRYc6IEiNRQ2unWX5/mDBsMdHWkBBz4xluduXBwDqBg0DAZhVLMVq6vW1rpidbPN/yDLesdcTOFfNqiiN2nTb08JQVH3UrtAen26cWGlqA//+nyHLFvXN2dQe0of212gHsBFCHgHO2N/FH6rGERwYwsWbXUVUCjN84sEAJbGo8dG6M7n4hLaHCklZBl/hTytISzJiIhEv9cJaQ+5FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdiyNjipMNSiy0ynrAIvL9qCKoI5P4RmYDykBchVxzo=;
 b=ToTvsfAinUg68pO96yLQfvgDlrRVOLa0ej53Llr+35vXjtDDzXot7+/850qGAVRjGItr7LVmjqvi/L1/xmIiHC3HINoCZH/KHKmofe0C8+d/4xYJhKzwV4iSw6pKSuDw14RQWGJE8/mvUd/N84xf4JdwLnSV5Des3EXKnl/zLwPNjgaMJAyWg9llp+4MiaHa/vJ42e5nPK6xkVDnqF1N8TbJzTgEx1nRsjJ9dH+4r/4Xrp9Q7oO7WxVufGTCGwpgH8O9rFUknoU98ovAHzqHbbemXlB4cOtthk88ExLpL73HaviY0PY+c3SCOwJAp6Yp+shBwlJa1vd1Xp36rc9GTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdiyNjipMNSiy0ynrAIvL9qCKoI5P4RmYDykBchVxzo=;
 b=pfN878UlkAy8HqyKFrSVeTiZQPa6kOrJnVMfwm5TsB+ETvNBiz0psSZaCxjHl3J6pmdbZFvs8WzooMn268GZoFkfDTPxmZizTsHxUbpSz13YvthoZO3UOCF1uIe63NbOUBvITAhwdwu/I+P5AfBw3x41/2/20pPIgxXJyFe3mT4=
Received: from CH2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:610:20::18)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 15:54:51 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::a8) by CH2PR07CA0005.outlook.office365.com
 (2603:10b6:610:20::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Wed,
 18 Jun 2025 15:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:49 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:48 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Removed unnecessary comment
Date: Wed, 18 Jun 2025 11:33:50 -0400
Message-ID: <20250618153936.6472-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: deea8880-b147-40aa-4fa9-08ddae807598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cYZ/a+EjOgHt2dgdibzRHDNbA4qeXksGtCLCKA9LEFEGzAXlxDVcqSwbVIF8?=
 =?us-ascii?Q?KlT8h6TeTHw89b6agjfKUmY2jGMaFtERUiJsAQZz0SiABOuCvzcWqEw6pvXm?=
 =?us-ascii?Q?eerRLWOnqN3Q7wCEDXgMG+OdBxnRouCi53Xx1l+BkoqyTaQave8hAfy6SpjF?=
 =?us-ascii?Q?5GHsYBZLGsqZiZDE74QFFbzjtyjVlZwf5ZnifNqVA8iThIFylwrc2qtRF5C1?=
 =?us-ascii?Q?mZRVm6pGyRh3W7uNYDeJsSV2FE28tM04mivJA5vaY1iQD0+qC0rg4IzTbNIU?=
 =?us-ascii?Q?kRjSVr0vc47xXaTHqaYufFzAWQcAySzpbO+OA6XDCJyxQQrckKKOPqvPfc32?=
 =?us-ascii?Q?MttB+ysv+ntAIPbIhwY88WoFQqx61+8bMAPVtqAMdp6D3GaVsVQiKnM4jbRM?=
 =?us-ascii?Q?5qMFpHWFkS4C1p9o+WkuScjv40Ast25aMIyb3ohkULJHpVk1QQ/gQMZ/ITAz?=
 =?us-ascii?Q?ybphd+Budm1ocT+JdYSOyN8lTfAd501h8UEEEykFUPmjoj3RBrRmFHVertno?=
 =?us-ascii?Q?Y25vGqaFu9+ui5lUXzwRiTtKUzpfLfOodQ18IxfsUqQoz7ZMTA+X+6ImXZIw?=
 =?us-ascii?Q?8Uv65lFjSxDLPsFXXoo8lKJiEsTnHA/BxOid7JW549SjbgS/I5gN9Iyy9egn?=
 =?us-ascii?Q?YExwxOx0skfEMIZT/N7F4xD238tZElHIPdz+jv6S3//gkxRZUyov/Chp5+L1?=
 =?us-ascii?Q?OAW7R2t36wN5AePTFru7zRXUFntAhRbpq1JJdv0giv9PrzdGiZdQiPwu7yYc?=
 =?us-ascii?Q?OBpM4F0F3Fup2pq+YBiyVsiJvBlPRWKR+2eQMY92ZESzyGkx2qXGOdi42hDs?=
 =?us-ascii?Q?SGu3r/+tpuenU/QNbLAuopj05RgajVxDCiFjrxtbhHnQAyCrZGqWKdV/oZ39?=
 =?us-ascii?Q?6VMPH9LIQkOpCbMuUSuntsrQHuOwKgW5XRDn0pLXqOyz19fdagUQfGWUW7j/?=
 =?us-ascii?Q?5tFWkVBTL2ghQFcmqehktKJ8061ffnqLInSxAfST3oENIf2HnBRVujAaco2a?=
 =?us-ascii?Q?noNQV7EVMdP1xhtdkEVCCMAjauvx9vSYkP5CnFpnxFV0YAqzpJjNn0u19gWQ?=
 =?us-ascii?Q?4V1pV4To4wLAhyCgG3wFwBkG88CGDDb+4N9KpsturnvNc6JxfdJUWb3uq/qB?=
 =?us-ascii?Q?NmfwT/N9OgNkgtNSHqnx+qFr18Bv+aYxmKtAvItYcmtyYvl8SM0dnePd5nrm?=
 =?us-ascii?Q?z3k9E6TADxT8eQU4GoAfmkh8D6mfv7tMchKFHE2nC1mo7js5xjEWird5zijY?=
 =?us-ascii?Q?f9CgHSziqOKGVuL7TWduueABK7oxW6mHydfSSibe4wpeCrAU2PW915u4x3/2?=
 =?us-ascii?Q?c3y30mR32rPpQ2gdDFZEWygXHLLZz2+mDdH3IsgI+MTyCxuDbzLhUbOtHlwZ?=
 =?us-ascii?Q?GYyV02f0HG9NFJhYnIH4mxYpJHl9oyL/p0Dju/t3G252WrmYyh5QSs7SDwzi?=
 =?us-ascii?Q?gGqrdBBKnuaN2I3QmupNVgaAZs2bF/qmPfKNS3pDhLdb9lwXn6Spo7SLfMpI?=
 =?us-ascii?Q?LFskM+vOMfSw4CluBIDlpirYSBTLEKS7lwGv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:50.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deea8880-b147-40aa-4fa9-08ddae807598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
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

From: Alvin Lee <Alvin.Lee2@amd.com>

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 19f794e46e0e..42bc6e4cf509 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -735,7 +735,6 @@ static void populate_dml21_surface_config_from_plane_state(
 	switch (plane_state->tiling_info.gfxversion) {
 	case DcGfxVersion7:
 	case DcGfxVersion8:
-		// Placeholder for programming the array_mode
 		break;
 	case DcGfxVersion9:
 	case DcGfxVersion10:
-- 
2.43.0

