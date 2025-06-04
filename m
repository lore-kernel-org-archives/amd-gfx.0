Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6732C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562EF10E83E;
	Wed,  4 Jun 2025 19:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXJMr5YO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6122710E813
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB3wunQ85tYVq14k7MG+uUjh9ePkuWuq3UiQZdxL3OX6M/+e3f15UIQWR23Q1ksfdsbrqYSrVrmnpIf+4FgSFwLYG0yS3ovcxJKa2AbldKITh0BbdxTKwzO/ni7yrKOFuViKBR799A0SnYE0MuxLQPUuyww23bBc8eX0oHz0OJiJ0VkmWiR3dp5gyx/UakcmeZMYXflalDh/pR+bKUsSvC+5l4Ky5KymCQ58GfLsV6bxCCozDbVZ3p+nVPtD3LMXji5F0DukPI7NOWgBlzqN/NIZt3+Nu8ILg9GWbj6MyCCW0SkSW9sSLp1xxzdM2HQbwnlekCS1A/IgqnOtqPVyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSONjQiZSkiyxeiWgzpYVBdE0n+14oDulrHNAU1Zd8A=;
 b=cCCnPU6w4UKKThvfF5ni6rMMO34cXc8QUMzG9Ta0kd0fBTu75l0hIzoxR/L71gC0eqjDIveE3Ybdif2ppJ6BXkfw9ulckLaMXxm14C8yZSi3KbAyYE/LBu71XlKUnHtKmm9WbUFJWo5RbvRDvR4J5TPBaWham1+pxx65CWAXR2qvIEcb56X05BGO7OQ+KMmQqaFL0XGNrBaqj8/63MDR6yeR+XRhae0iU2TeZ2P6bpyVXJlZ9eRUBjsUYjIxPCUjzgzxM6lvVsel5lTNyJEvNuaM5fXFkp8DC6V6d+56xNPJiH9oJY0LFzlHUyuOSLau/Yqq87wv/KAc9zso1Q8JvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSONjQiZSkiyxeiWgzpYVBdE0n+14oDulrHNAU1Zd8A=;
 b=OXJMr5YOOpBqKkoXsVSQyZtfryxgikH6A2sXlro5wyL/Q+JSm5sk9OPd+CNOVgO0L17QFWpsvq93x2SJTDFtq4H1tKLShiktXhHuSVpUlmAEwmHLd1f47Rr+AhN9CCoLCHQqhgGNghf32LQWpvtt+vf3agoBZe1j3uUCAyMnftI=
Received: from BYAPR11CA0061.namprd11.prod.outlook.com (2603:10b6:a03:80::38)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:42:25 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::78) by BYAPR11CA0061.outlook.office365.com
 (2603:10b6:a03:80::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 19:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:42:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:42:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 23/23] drm/amd/display: Promote DC to 3.2.337
Date: Wed, 4 Jun 2025 12:43:34 -0600
Message-ID: <20250604193659.2462225-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: c49e97f2-8c02-4dcc-cea6-08dda39feec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ccZtABusFHBgDZ2D9awkkkTkZJyMvtcWdi+TuXbKYkqns2Zkgh2C4HaNZyZe?=
 =?us-ascii?Q?Hi19IZyQJCw45ImfRMpy2UY7n7gEGOM/e9TDgL6rmGyfHNhSmCjXLzGldC0o?=
 =?us-ascii?Q?+QG5UIYz0AiYaWXfDFzwJ/Bu5+GIlrF5EaqrL01b28hx2v0gvb1pzFp+ksc1?=
 =?us-ascii?Q?x7PeKS2u4Ix+HvizrjmoE6g5XOTeNllIpKVvzTxZSAxdnVLRIn3nwXMUG9w8?=
 =?us-ascii?Q?b1tgfGIjsfj1yhJuOf2o3FabgaPkLccO78I2aI0ZSd7wPHUYBsCBT4iMSvc6?=
 =?us-ascii?Q?O663fzQIbtDuCC8BauDqP76TrPozFUihpF1YrIXOeIv5ggkyeDNAYE1JwmuV?=
 =?us-ascii?Q?Gc9mdPRsNFXWNIiKgaLg3XqDA72fJzDrHued/Cxn6tOQH8y6z3aYDFGe5qIn?=
 =?us-ascii?Q?JncTj9hlqVfYQR72GXeNUvZzKSu6/IWVa8oUfvnB4GMxsoaTHv08nTvgm3ym?=
 =?us-ascii?Q?3nnJ68j+8aos5VZezU1Ph5+c/kBjJeQGnFbeqGGZ3dBIiWNzkaAHCjepSFkF?=
 =?us-ascii?Q?Uv2g01afVc2hrFw8w80OktDeosE6uAM1N2OEcWlvFrfJq06B4saKk09l+OYF?=
 =?us-ascii?Q?LvIQATEUZKcGCplnbeuBNvnsNAb8ZP1hZi7jrIKKkgqkikOx5sg7Ycvbko9a?=
 =?us-ascii?Q?BvGLBDVjcOpPg9bHoyIbnRGQyEQhCRn1MTFFx8zkXpDNkw+n5NIdmpSrVLpt?=
 =?us-ascii?Q?HGeFDGVJ29txOcf6MjOv0kEnjiQxakYWNFkMhX981ze5OV8PG05UmYkmMfpl?=
 =?us-ascii?Q?m/zFxMvsq4GuaaHcaHFRfGgReOjCrRgOLANJW5KLCFO+RdTjUexJtlDW6XU4?=
 =?us-ascii?Q?B1HD10jd50xKAoQ2y0wQ48m98iddk8AbNXOuHWt4hcqDiKnPVrJJkAvbRWTe?=
 =?us-ascii?Q?kN/rYa0iEqu3L0NDVg3IjCHMgV51cp18Jp/MOqhGEI3XgZzCbd3wVjxLmmZ2?=
 =?us-ascii?Q?ET3H8oX9ZalhNXy7wZ5sbPLaTU31zOQTkROmKxwUgvXagd+c4vmH2cKhipZs?=
 =?us-ascii?Q?OUfdjFKmgS/KZkzAtkTIgNf+o7L8yAyGUOZusgkYnuOhbewlS+7KW39VvyzE?=
 =?us-ascii?Q?h3dXhXKSS9F0Dp/inm7RkGBQfuAqD6ZRpXP7PEUhO0CYOlz9pZLHQsyTJ675?=
 =?us-ascii?Q?2cQgMFTEAC4gjZlarAr3JXhx+5T/apJ6Xf9/t/7iC7oVKjOgXBTzEWdKqZoH?=
 =?us-ascii?Q?tWZGkMN02cMwd1BTg/8fjNjM2V/jmUh1dXF2hnLouenxRsAeapjOB+qAJ04D?=
 =?us-ascii?Q?5CIAbf10ZiTWkhbnZiIUattEyCGbc5+jcTAWfszapse2MemljZjXWqi2Jc8c?=
 =?us-ascii?Q?NKlIzjG2q7CRutUtlpRj140fF6U12mJBjTq7gwuOyiWDAMy8SF13ZhMairWq?=
 =?us-ascii?Q?0jegUGUPMkTYvv9/RazTCBfL/2Cr5F7dw8p3wnMwOYmdoY0TqLmQCF3SjQgK?=
 =?us-ascii?Q?9FaiMhutiXctRlbUszrjKiZ3hb5gjHgEh47cip78NE0K+JAqOQkogZ2hDT06?=
 =?us-ascii?Q?SJ4SDbnsI4X0CPgxiidq0PWJLDAvUDu4+W6N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:42:25.6434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49e97f2-8c02-4dcc-cea6-08dda39feec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:
- Fix kernel docs for new struct members
- Export full brightness range to userspace
- Only read ACPI backlight caps once
- Fix RMCM programming seq errors
- Add RMCM debug logging
- DML2.1 changes
- Fix mpv playback corruption on weston
- Adjust dto fix coverage
- Add option to disable PHY SSC reduction on transmitter enable
- Don't disable dtb as dto src during dpms off
- Add custom segmentation support
- Deprecate Loading Bounding Box From DMUB On DCN4
- Update tmz_surface type to match register
- Clear DPP 3DLUT Cap
- Add more checks for DSC / HUBP ONO guarantees
- Refactor DML2 DC power instance
- Remove dml/dcn401 files and references
- Get LTTPR IEEE OUI/Device ID From Closest LTTPR To Host
- Add HW change required mpc gamut remap
- Add DPIA debug option for zero allocation patch
- Add dc cap for dp tunneling
- Remove dpia debug bits

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 74379edcc4b1..da024b0d0eba 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.336"
+#define DC_VER "3.2.337"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

