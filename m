Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D668DC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 18:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384FB10E077;
	Tue,  4 Jun 2024 18:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XfKdKvSC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221FC10E077
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 18:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdd8MfPF/IHcOeTkJk2t/nEvo7KYw6iI3kk9AlN72UgG7i0HfbfFJosA6hEPZY+26mmzrh4RWXr0AZfp+AVGoJf+3hB4Zuz26yEfBpBPPW/0yuc9cgIuLcIe/1ovw8mOwhyL+fnsmu2DIdCCPsV4eP1DYcI9Jl+husgo9CFEsNnm1Vn4Ms5Sh/dQhdgOIJ8Lmm7/+P3Qwb3e8xHdieXjx6078b2UdGuihYTldwRWhAeUeE6yQtJS/LUbDX2RDhohyujyBOP71WoV6H9naTnzrrgMFLasMzf+pegnoK9jjBHEMeEybiD+qNtABUEFyj84ZKv/OAd3VbnD1eZhG2wyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/GQeEbRtTAOjeVAIIb2Lc+SbSIKfjEZ+HAeIQ+/83Y=;
 b=XgWhRFviPstA/8ZsAurYO37XUs2ttDSWJW+ql47DD+76YNJHJGZLknnCowdPTcAnMkev+DcBu4CuOVNspvoF82KoECQswL8AFlt4KUnKPSsZ5tzbEukxRGFzDbUL3bhCS+4plF2F2j8bTxvdsy5X3uywK6JUFbzL/0n4YIzsqyCiAmscbyl0frxULW7adefndnRq+B7/sj8IlN0ESb0Q/oO6gsbEj6kY7uY83xyPwSgT9YHXPoKXvT2rviqN6Ld7tRT8y7vk48UyxueaVjeZYWr4yvV2RQh/hm4XYBIYQOVlrpYjSrlh/buncbVM7gKokNCVWumhhYK7vKEVYqt2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/GQeEbRtTAOjeVAIIb2Lc+SbSIKfjEZ+HAeIQ+/83Y=;
 b=XfKdKvSCH2wqHcEdA7AjCmlFykCY/9rRM9ge4t1U+Mo+wPzCO9hibLTAXokDO2rXVQKw4Gq/ogOh5x6CzgHd32qYJU1THmcnIp2fmSLH1CmQeUrmV7/P9J3/yKpyD9Is0lg2oSqZ1mgKiWfMCR1okjZILTz2Jm4vR+leJSAZxRE=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 18:06:34 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ee) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 18:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 18:06:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 13:06:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, George Zhang
 <George.zhang@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, George Zhang
 <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 1/2] drm/amd/display: use pre-allocated temp structure for
 bounding box
Date: Tue, 4 Jun 2024 14:06:18 -0400
Message-ID: <20240604180619.600760-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1c3525-8826-48f1-0758-08dc84c111b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KhjfO0TtXWjSRnLqqbNVfTIx8lp0HQDFeo84ZUgcqZA1DwXhaQxxLkdN7Wij?=
 =?us-ascii?Q?sbMLmbkJfGbGZ7XP12YiBVmh/DuUe4NCeehuxWw5drQ5pKWTV6pjyX8g347r?=
 =?us-ascii?Q?q1lFGUfJCinAo1vIyp0wzilL7S3k56ThmPoJ1S8XMigy6iJMCDXyT4uiql3I?=
 =?us-ascii?Q?+hX30Db0Yv4ZbmkrRSvIX/wEu8Ky/G2Q+1giRXbZX6qFxipQ+KMA/nS/GaXd?=
 =?us-ascii?Q?HpyWDhrIvR0xFuVuEWF4njN/zNmNvpmENZCqKb7UzyVussvA5KiVWbJlNPbO?=
 =?us-ascii?Q?jGrkRonGr6kP+uaFC0xt9fMzNv1S48Ol3oo9F2TRAFoAkIwXoVwtxDmZmh/P?=
 =?us-ascii?Q?uHH3JnEuXOgdJPxMBLT40om5ewmwJxMWLU3E08wdaAB4RYq4xTqi6/PP/1Aw?=
 =?us-ascii?Q?7uboK8iYBEMyiTrLHiTukqk6yps6GYhoOFhaf+UwKr+sV6FWk2ZmY84TMCKH?=
 =?us-ascii?Q?9WE+I1IAXd3esEaTq2xfQip1L0G6qF3J8xpPBiLgWH5oZ85mK1L0HLpKnU+w?=
 =?us-ascii?Q?twae3/HrVBu2WLPNXrp6sfhlJLQW4mhk29QDUUSHC2SwYpRN3S234BXa7r0j?=
 =?us-ascii?Q?Te3oABOu8g3zsGdu163hygWZnfoMca5LzEGG+E00wvnGFEDwouyRWcDzuSvS?=
 =?us-ascii?Q?iZ+cEOEAfdghgIHCb6Tf2AfBZY5knrptOix9AA+/swmhmryFCAKUC2Q8pE1M?=
 =?us-ascii?Q?LSZX8mrZyYfQi8D28F2pAx60DeEs7wCieUFJVEXoIZx+FQhWVBDrynKpM2in?=
 =?us-ascii?Q?k49O08hYtvC4++91/Z2gGHfROHSNRDE/uOdjddcIP+UR20PrIeNq91P8u606?=
 =?us-ascii?Q?88QVapUpv+kxx+FkZSnGUFyEhbj3S7M1srbv+W7Pdm0vQobkWQXm/PqRQrkT?=
 =?us-ascii?Q?XaABkpKo9BLeZq4f/GbMymfgS6OPSnQ/9UpPe4Uh15TKamfErhRWPMaHdgJ2?=
 =?us-ascii?Q?Mge/3b0HG6crLZSMRjxyRYQX6WSnQ97NJ4wHbh56T4+VyZ3QQA2M0/ms8htr?=
 =?us-ascii?Q?xe/oKh1ot7NNi2vhqr6gk8naCvUetx41lNFmfttKhQEYfxhwsaWymlTojj/l?=
 =?us-ascii?Q?7oHc1yquKq+t2o6IbOmEzOPBK495j1deAuWfzZMP9l8EfHgZ9fmn08SRCiPX?=
 =?us-ascii?Q?VCTyRd9lix05aZOiMRESJ3cckl7K963mwWp+ZEc2l0c/O1ADIbzFZMBruTS5?=
 =?us-ascii?Q?XSllhy53NBx4JabsnPWkGxKBzgoellCohzkso9mhOzM59B0P4nuKf2tsRZ6/?=
 =?us-ascii?Q?z5YL2lS1Lq0qgOyFGfSpXK9SxWVGbGgWoJ2w9iaRG+SYuJ+L3SI+c61Tv+43?=
 =?us-ascii?Q?Jyb4RmGres78aQAi6JG4ycRAzONC59TfuozDFD691BpZXt5LieDgfikvS+5m?=
 =?us-ascii?Q?4k9ZgCA2pn6e9tJAgTKbg/WPdECb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:06:33.7480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1c3525-8826-48f1-0758-08dc84c111b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

This mirrors what the driver does for older DCN generations.

Should fix:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
Tested-by: George Zhang <George.zhang@amd.com>
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0ed01ac460d..d843933ad731 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1444,6 +1444,7 @@ struct dc {
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
+	struct dml2_configuration_options dml2_tmp;
 	enum dc_acpi_cm_power_state power_state;
 
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..7a8aa9396dea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 
 	DC_FP_END();
 
-	kfree(dml2_opt);
+	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }
 
 static struct resource_funcs dcn32_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..ef30e8632607 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 	DC_FP_END();
 
-	kfree(dml2_opt);
+	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }
 
 static struct resource_funcs dcn321_res_pool_funcs = {
-- 
2.45.1

