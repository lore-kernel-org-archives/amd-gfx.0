Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE76C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CD410E244;
	Wed, 19 Mar 2025 17:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZU4QTNBb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FC910E05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGi2uYRITLs9UiXuSkE3xuAP7X0ZhMnBMTIDdZZpG2wW46TcrhU/I0Ngi14L4FatbN1iIHt3alH3PRA5ImgD0i9IkslIiesRTDzGMllM0ZnaWB+os3M69dNItL6QazmHP0mMzKsU/qtfIt011sXOq7ATLzidDFeaui5ReGZqq/c4jtc1aqbZHoyXAKzesktiR4XkdxRbUEw4uMItp8Po3+KydoZhqCq2TEHWTRDU7TF8eQc0p3b8hucu4i4zISxVF1JN1hYLcF8tq3JSdgx/ZegeSc+04ei7NFaD7SqdUB1CjdsET2FfV4Vyy1JogtWQa1fPlPEU8/w/JnUje3gIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTbb6wIBHoHtiUJywjFVxVZO7zhfazEvXKVHRbpgE9g=;
 b=DFIzfkfPfi/QjUjqpqZ6Nw0rsfZF05jubsr0pwwmxX2jeTfMtSRY903nHjBdOgAmSSgzXW4vMqaTOExSno9XaLJ32jeUOVqYJKAXy5HByA4BuMSn2h5XpqzXscxZKJ30NYEfFeR3J2xsGhsy6Fa+gBSuMr9XiEPURL2rIxuwlDAYzdUonHBike0Gc8z6RgY7YDTWa8Q7ntNViEdUlqXfR7iOUFfrq0PBipcX/dhSXSewx6LPx30gveX7XykQoGtFMJBykm7N5KpZNLrAHt0N1kMXaM80JuTOvYQwbQ8MwenLrMUlFJ/GsiOwFymG0sBeZwUGapEkp1H0KhjuisI0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTbb6wIBHoHtiUJywjFVxVZO7zhfazEvXKVHRbpgE9g=;
 b=ZU4QTNBbtUBTYwEf1xu6t6Qd5hbJM8kQKMFvcBtF/YsWUoXF0iehlRnHlpwNaPJY5s+gWxR9TJ9uf3S83SqVbV4qIAOhhgzo4QlY6QPmWxhNUKN7EPkg/M/e8hAlcbO1OT3XEM8s9BFIqsNloEgc2isCy9rO1ux77sioUBF/G5g=
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:22 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::b6) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.8 via Frontend Transport; Wed,
 19 Mar 2025 17:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 17:57:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:19 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leo Zeng <Leo.Zeng@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Add override for visual confirm
Date: Wed, 19 Mar 2025 13:55:06 -0400
Message-ID: <20250319175718.2578234-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: cb83c3e7-0dd9-4cfe-fc53-08dd670f7f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TZuYuCOjyvDICNZ7xTT5ynjUAZ0pOLgcjcHx9nQKbhnzRoWvU0taqJJ8+Ptk?=
 =?us-ascii?Q?1pvEGFg6QskCNO4Tq2W3RaV0OywtEafZbPDRKgBUo2ktl7kKwfhqt6C5hC2C?=
 =?us-ascii?Q?v1uB//OB7IwSGb9Jb7Y16a7esJtj8iCHoVArAtlhZjgkaO6GvWb05ZPvBAeo?=
 =?us-ascii?Q?i20/MJNexp8QczdcEK5DZkiSk7cb9b8lcIClPvCclrjNcUpK/2ViY2lf2B4r?=
 =?us-ascii?Q?q86s3nT6hW34GgMNKDfkSnLteOwGtgqNf6TRtA2m5T4XtAVAZs/ejB8Zq0I7?=
 =?us-ascii?Q?s1wfTiFaU6Pvzi0Bq3b1Mjeq93Tu+b/dEolygFv4iSv9i0cXyWzCOuiXq3Lt?=
 =?us-ascii?Q?Xmd04xm0CvSMyR/+aKjRoM9SZjAtYXvyxuYa0zhXfzdz+mJN3svrXJX+4CF/?=
 =?us-ascii?Q?baflzfiKrElT3VtRN39m8svit0ZDKw/uT1hSB6TU+r4OyaIDjmAXB9/Wh+s1?=
 =?us-ascii?Q?K9GKgHsUIVUF9J2zoAdwYUrVRFc86E1qPzfuvwBq3PZ5oos0t/dC4xPN3hyM?=
 =?us-ascii?Q?73DrD4UA5yVXCo7BBxwTyDYoS+lKMTgKJ1CyH1abp4crbrtBIpwl6AcE4+2z?=
 =?us-ascii?Q?JOsHxlEcI+Fb4kv5gKpxIak9vbMiA3j+Z53Qj9Et4bDu0bFLv3WEYDd1oBTI?=
 =?us-ascii?Q?KAdxdx6F4a/w4IkLfNh0N2Uamamnx1PgKaAftoe4keKmz9teHjCfdfKeYet9?=
 =?us-ascii?Q?si6o6ICCOvRk9i0R1Q3fcBh28nUBqwIRBbOP5ul+SFN/3zbrqxWLyQzrS8hD?=
 =?us-ascii?Q?admlh4hrO9skIMqqPj3CIU6cie6RKJGKYVqomMDkpC0obnE6LkCWer6XtAdQ?=
 =?us-ascii?Q?+HMiv1Q+9orHTijYp3xFoiiwJU7qWSuTaQOOfxhIcOxe/nqzSA8fpXLGfVyC?=
 =?us-ascii?Q?3A+BxbFUOYpXA9mtnzc633YmRMt5yLYMYqhW0O1YsnVp9Cmv+Bt2clIdt+Zb?=
 =?us-ascii?Q?KNTfl5mzAcHrPHMe02AwFcSLslmaGhkddzWQSBdKMGwaKIfk91ZfQWK9Rmp1?=
 =?us-ascii?Q?RyFhIF8tF4HBVcwjp7uJ+2Z1Ta42qGBriW1T2yruioLIhClM2QJZO5MZwKkG?=
 =?us-ascii?Q?XISUURFNXo6MO49/9lK59worlPbB/1umtmrDf4EEaAdj/tBdoJu4GI3M/1pP?=
 =?us-ascii?Q?Y2v8qMQgYt5Vz+J2wJna+ulQ6f9LFFxmvuPp1s7B7STbcMZ572WJTIN2JceS?=
 =?us-ascii?Q?vpNpDOFMUXiEHCrlc7Q7OUHMRY7lsqBvz4gSrOM+m5wMNP97f33q9J/l7kIR?=
 =?us-ascii?Q?WKC3dqHY36CwN5cGBAUB8cQi63JUm37HD+nlGg49cN/F8tyFf09j6wlUSsun?=
 =?us-ascii?Q?QkCyHG7WQ38yk2bJbJ8d0u9NP/ivZeYe8EW3m0BB03pDKBUBAAB76z22FKAc?=
 =?us-ascii?Q?fE7dafJ/Te4W3kPsUtG2LLI+qcm5D357AkdXRHgcGEg2G0SIReNEgKKFI0zL?=
 =?us-ascii?Q?cvr40t1NEP6krqD/oc6FTm196qXNsRL5cfu6u+xKvrotpt5nET5e1KcbzFNQ?=
 =?us-ascii?Q?b/T0dkDW56bULj8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:20.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb83c3e7-0dd9-4cfe-fc53-08dd670f7f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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

From: Leo Zeng <Leo.Zeng@amd.com>

[WHY]
We want to allow the display manager to override the visual
confirm color in DC when required.

[HOW]
Add new visual confirm mode VISUAL_CONFIRM_EXPLICIT, check mode before
setting visual confirm color.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 28d1353f403d..5a44f5da68dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1192,6 +1192,12 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 
 static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
+	if (dc->debug.visual_confirm & VISUAL_CONFIRM_EXPLICIT) {
+		memcpy(&pipe_ctx->visual_confirm_color, &pipe_ctx->plane_state->visual_confirm_color,
+		sizeof(pipe_ctx->visual_confirm_color));
+		return;
+	}
+
 	if (dc->ctx->dce_version >= DCN_VERSION_1_0) {
 		memset(&pipe_ctx->visual_confirm_color, 0, sizeof(struct tg_color));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7c2ee0526926..78dd4d1f51dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -496,6 +496,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_HW_CURSOR = 20,
 	VISUAL_CONFIRM_VABC = 21,
 	VISUAL_CONFIRM_DCC = 22,
+	VISUAL_CONFIRM_EXPLICIT = 0x80000000,
 };
 
 enum dc_psr_power_opts {
-- 
2.49.0

