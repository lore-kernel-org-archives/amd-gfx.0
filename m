Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9BEC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 09:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178E710E8BB;
	Wed, 28 Feb 2024 09:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t44EJYcE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E496910E9C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 09:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/GnwLGKoDu0GqtO0PV2BFd5aBqxuTaOdM+4EY+kgroFlDEYGsIAd0JnaH2AOXclvu0dwjMPWw1m+vYybzc4R+lB9zgC37sIEb/zyDsVka50xyEhMwAFXKfXP/DsOP5RqFVI+ug4/yQMbHmyOln78fX3IWfy0oLuHyUpNrqnIA9Ki4AhTSszYkLPQ1fCobRy5WvjbUeOmeFeLy2cskwzcT+TnK9CURxO0WG3ea659qu8vpJ1/iBiCzHjjX7N8Ikh+fNKSefHv/WKnoe7nHZwUvqPCJf37nVszRHUU/ASjQdnLKty4nXqkJxuQqQlZItI/96nVdRvM80IfULuYAIr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZUuFVcRTTETil25jA94qgutlkYI7BBKXc3QPp5UQBA=;
 b=GqzW/H4IxTCQ/rjNrTdxRmDE9EHy9cy4S1VpqTxnLRF9uRJjKEORsSdvX08HXOJ8GDGR+7pgNLAQ6vFYKdP14G94LQpP+hBu9UdtxCgvLmmzobJiDztku1HBAWF7fOXlxurkiSRHklziDMlZIgb7qyEVH3udkCS4DJsXYaqHQFlxkjZ5jtkt3rTpwQTwKouMAvQcLp4+CKST8hawu5IuUt+0xIUQ9gBH+keJZFtotS+9NdbnsnLDtW/S7cO4RjDDdzNjYv74X3Oac11KOVfqeYsM/5i8n+DPktqZQxlF1jk6B/nYM2z2Kq50CLvwm/i1pjOyJpVp78vEvAZZUDpEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZUuFVcRTTETil25jA94qgutlkYI7BBKXc3QPp5UQBA=;
 b=t44EJYcETkesZOVxaoX/Zc0kAdl2u1aYUaSJc2v8ctAVgwHefAY61xkB1/KUicqZm+yZWGhsq15vDVlkgjuhkT1LuKfCv4MDj7ear6OmGCcYS6yannc5nGgPTScl6bHMRJM4T/rRvz6FlA5yi93loPspnhVlwnEljoaAC2yuj48=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 09:17:50 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::59) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Wed, 28 Feb 2024 09:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Wed, 28 Feb 2024 09:17:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 03:17:45 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix potential index out of bounds in color
 transformation function
Date: Wed, 28 Feb 2024 14:47:28 +0530
Message-ID: <20240228091728.3237681-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 0634807f-bb56-4110-8156-08dc383e2257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jycYsCZ6Y8/f5thohcsNFzMTHrbpI2MDvW7GyIMsx/aBSj1wzviDsnUOx0ptXBubX3zoOUGejHC46dR2Fuq5CAINlGDZ2zErIXssva7GyROyVlT3VKQTEYcf7zaAmchYC1PmrGtq/KRH0isie/T8g+flr4SAUFg/lyORHLLffeYPjmFjCNe5SoN3JCVSGftkpdGfEUH+RVFvOW1h/BYcJZD63yz+04GCkvZfNsKimJt+Hlh343/0WmveLvPoFaipOQILOUmisfOwR8UjzSfnGKeMfoQQZdGPHWGVhpp4IqLFu63sjQsAjk9eZHCkHD4o1Tb8u5SDXCstTK4E1DI0odDldy+4D1qSe8z0mopAmxIRptVbbxoioRsOLDNEw9EjX5WnTW9JH5BgSS5R6h7DYSckg6U/0FOKfls6ZPLMZ9jO1bstun7fkOze7piteSYxfMrS0iMWN/XlqLFxA1/KEhdClfM+yKnH4OLgrYZ1EhcJHIPBbDmml+9m3EsP9D+ep4xnVcb4yoXqT1x0srYY3k9lSL4/XFudhbJD3QHGaRSDoDXsabiKeTzKwqlojzVWCjpxXrQ2rFhGJiz08SWbBoZI2fBMqPayNdXVYeNUnRHbJ2wnGwLfCKrrfb/h3/qMsGVWs0gSAy1PAYZqgw4M7+xi++1cH4rfe5+dp6JAnxYRX/BDz9yvzViTz+sa344JjjFPJQ4OObSNq/wMLrI7mf+VBw8zT6drn1Bs5WYEP9GJ8rEEcgDvHpxol9Ao4n+9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:17:49.3649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0634807f-bb56-4110-8156-08dc383e2257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

Fixes index out of bounds issue in the color transformation function.
The issue could occur when the index 'i' exceeds the number of transfer
function points (TRANSFER_FUNC_POINTS).

The fix adds a check to ensure 'i' is within bounds before accessing the
transfer function points. If 'i' is out of bounds, an error message is
logged and the function returns false to indicate an error.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:405 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:406 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:407 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max

Fixes: b629596072e5 ("drm/amd/display: Build unity lut for shaper")
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Charlene Liu <Charlene.Liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index b7e57aa27361..b0d192c6e63e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -402,6 +402,11 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS) {
+				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
+					     i, TRANSFER_FUNC_POINTS);
+				return false;
+			}
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
-- 
2.34.1

