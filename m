Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F67EC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045D610E6C5;
	Tue, 11 Jun 2024 16:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwhwF2OC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43BC10E13F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7PoHnTqglwt+Mx/gAHybAGtDEsA54MM1QHHlCCnMz5VAPSoTMi+9Lda5GVD4uo5Z7p9yi44F2Ezbw9akEYr3GoccsO0jv9ZudWfVIVAPY+ZWxEkb/giRv1BD171ZGTfCxSJTsCtcES8QuEfI5YHHIkyU02ZF7VL5bPcXN4Krp8CqJao8OLaqBTCkmjMsM12Rs3wPh99hEVIZtLGfebfyUtVFIxP1zlW2HSDpds0hVPdPxEPvzwsrRyhDUntNlpWudEPlRyMWQyaPu6uoC6dSM38cstlje1bqW1jzuX5W58c/01jpgVFfIRe8tcbvIS7EnA+K2eehgNpH0PwCMnByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/WAZYLJZFQb7s1TscYt5h2jT2cqeOJTSfYZmAWYaw8=;
 b=cqacLOu8sCxVsTP6qB8rapgyALHaVuA1s4iU5IQQZoxChlCAkLhvGvycJdParO69+Cmv1K9txzqHbc4qn2ugCGguyRt0pgRyBR17ql2VuNLBVIDwy9ZhD1b3LLR+1POTwg2KKBOZ0waivASrpVGthTseivA8itTcIbWENIkuZFqsWQDypo+8Qpp8C5KMeqwPWVu3bOPQGFTUeTmcD0/rvbD2tnV4i0GggfYXzdsSMR/PO+DJ3p7AfVB2NvgBTO+M/s7/Ndaikl+CXUBupOSr0Qp2OYP0lD/a+5YELMJmUE7g26Ex/YwihynYSGpF1VcSAtW38umwMzdyrbX6Xw+gqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/WAZYLJZFQb7s1TscYt5h2jT2cqeOJTSfYZmAWYaw8=;
 b=jwhwF2OCExGpnHKZAhWuQFrY3aVXtcZMVj3/IMYB2RRX6ZaTNv2UKUt7zDSdYJu7VFWhgj3qJ+7+QaiQtgcJ5PhSybwpLN9VQR6PxJm2BbFEOhN//LjscD6wlONNYX4jI10bDkFTWy9fjW7IqmOmjcglxUQs6fjmhimQ53oKkLg=
Received: from BLAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:32b::30)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::61) by BLAPR03CA0025.outlook.office365.com
 (2603:10b6:208:32b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:17 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>
Subject: [PATCH 01/36] drm/amd/display: DCN401 full power down in HW init if
 any link enabled
Date: Tue, 11 Jun 2024 12:51:04 -0400
Message-ID: <20240611165204.195093-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e33780-0611-4737-ce21-08dc8a36daff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZX54FE8yqr/MnmDgRHSWGeV7QAZ5R/SHbOuhhImKfnsCBtS2g5v1LqP6Pnb?=
 =?us-ascii?Q?nUCWtO2XYd3gkYNA+ZANaNlUK08+FRbXhWDYZ0/6Wk/6lKrCaNMWlSoUeelf?=
 =?us-ascii?Q?SLeptxDVKB30n+98xsKGQjLKzYO6JDgfH1uf91IKWFmNVfmxp4ZvzWPZKGjC?=
 =?us-ascii?Q?kzxwR2Wd0k41kUkjtsWFlFBriEJP44NNlRvRgZGNn16v0Ck4C6ZadlrwvaDL?=
 =?us-ascii?Q?6IMe+OHXEaXwklaihRvlgXDHKBPyBqUFdHTqgGRmk9xJwgRCVqNiznSJeVZT?=
 =?us-ascii?Q?zK7DxNJRq4UBKei2zOLCEpuxDOnUZ+ruV/Xnl72N4zDkD0DkyjeHxjGm2zw6?=
 =?us-ascii?Q?0ITQQepG8wGXYkxvWw6iTYGP36dsvgjRoWjAAjwIS9b078LcGjWEXlIibIb6?=
 =?us-ascii?Q?SMPEV2vb72UidxILy4jAmLhhncPUv8R+4plo96RURvDBsAiANCxT+c9vOBfk?=
 =?us-ascii?Q?0Om3NaIdfITwLfvQO9WkwuHROVfmPXalYmXU6laymG3UUmpqP/KCrSPqYVDj?=
 =?us-ascii?Q?B0RI0TnKWa0XNeuBai7lRvYP14fzgH9MtvS8U8XsMnKMYPJ/0Ni6qf1wfXi4?=
 =?us-ascii?Q?zJL6VaiWW/bvM9Jdh8Guy4k02q7gyPmWh3a5zKIcRo3B9ePJgQXefWY8hVDY?=
 =?us-ascii?Q?gVlmhda63rWpIEX5tS/Frf5wfenDvZFJTXFEH/7xuPKy7wXUCK1gB5/fGCC3?=
 =?us-ascii?Q?+gVXiOXf0275h/vSP0Egc0onxAhr/YTuKAVKiPwfIsHH4p/zMiCdIi0WbpnU?=
 =?us-ascii?Q?Rbcr8nkqg5799fB01lMQ6DW7kNm9V1I8c3XFffy3ftdByV7gDGhNwCPgV5pv?=
 =?us-ascii?Q?MWU2SP8K9zUJbFId24CkTRoSQZ6k6dkTrPg43UNrmq6hxr8RsmIG//QZ64aj?=
 =?us-ascii?Q?gMzu/HT+3G9O7g9xM1tMXwor+BrCi6LMIzlzFQ0XuPsDNUF4m/q2RG0CQpNP?=
 =?us-ascii?Q?2tfzJnmaZSc4CxYOndxxH/N4OPAeCPnrK+bqNCPgCItSCkvnLl8O37jJ9IKV?=
 =?us-ascii?Q?FwyKrbAzWQoP11q37O2es0FnWq48KGfeSLSrOYTbE2dqbVcjhDtqedXBhbQ6?=
 =?us-ascii?Q?/xHud0hR4+EuCkJteRdO0HbR7a5Q38DKxB+2Nn/FENSQoEvtDVJrk/C1khNk?=
 =?us-ascii?Q?2BYD4nfWlvZD1191SzV73Fm5bAdIzO8e+kiFR0+3haMCKB0+t3THtoZrKpOZ?=
 =?us-ascii?Q?lOvKqYIwYh2wx9cmdRXb2jYIjcg/yzYKld8tkKQUrs7vn8D4NjkEXlN+hAjx?=
 =?us-ascii?Q?YbpZuhjgMjB0MqYbKalJnLr2haVXu4exyTpAmlWpXqBNEqrhXA/eI7J8nxOm?=
 =?us-ascii?Q?nImluw46x5WE2Au2hZzHdqm7Lju5UHovF2+9QX3cH9OnOy+c5QzSQJrVSFLw?=
 =?us-ascii?Q?tcMHWH9z58n0Sv0zg1KC//yNJ7CWmDHbvpw0Unx9Du3wIFSSwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:18.6051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e33780-0611-4737-ce21-08dc8a36daff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
During HW init, certain operations the driver performs are invalid on
enabled hardware in an unknown state (for example, setting all clock
values to minimum when the GPU is actively driving a display). There is
already code present to call HWSS->power_down during init when any link
is enabled in HW, but that function pointer is unpopulated for most asics.
We want to enable this codepath for DCN401, as it resolves the issue with
being unable to drive certain display configs on adapter re-enable, and we
can restore boot optimizations.

[How]
 - add power_down HWSS function for DCN401
 - remove debug bit to disable boot optimizations for DCN401

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c         | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index dabad7feff03..1cf0608e1980 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.fams2_global_control_lock = dcn401_fams2_global_control_lock,
 	.fams2_update_config = dcn401_fams2_update_config,
 	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
+	.power_down = dce110_power_down,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index ea803df8645e..7781a0342d67 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -733,7 +733,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
 	.disable_idle_power_optimizations = true,
 	.edp_oled_no_backlight_enable = true,
-	.disable_boot_optimizations = true,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
-- 
2.45.1

