Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6DAC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801A610E887;
	Wed,  1 May 2024 07:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqCEJIV5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670E010EF82
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH/SUUD/KcH0OiV+ZRRfTtg/GoK7B54b+zkBqdZ8+8pwVPoQwu/75O34e7w/pX4kIDCDPb83r4SNVDdCMo9EW0UTtYwHzLAzak3I7QoVGDCRf03vuAMH/NV1GPbXkxrWQ81XEvgmWNQbxLgKvmiw19PyCr6vlO101TSIRyj50WNqivyY7avEqQkrQHh9e9ij8JT74wP3JjtjnxeldBIi5OsenKuympqmQPJIfmn0ui70FQyRHOcvnqSoE/TpSmroAsyS9Y6xvvdeBozAjF4IKnQn9DUiAT8nBlSfEG+qqeD5e2FiNfPz50MAuNuT0/6omki6uxuwJpd01lqn3IkooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEn/PaoW39rG2OOzIGSF713NHprleq46g8ra9NXBp2Q=;
 b=FVgEUbNK9TLDjui4QCVnMeg8+92FBmAT6O8xVBZ9F+mvybt+d7tqkULlko/nlL4yVsKyS7AuF6kdkj6vMsOj+iRakqtuu3ybNJyKytMs79LRMxC6rdh4Vm6YaZFT9bV9qpvSfvaKecR9d12Cd4OSnyVl5n+3PvSpWBkV+LaTlAX7la+jKN0muEJc9C8aG6JHVkjmd9Er9Dc3Txe0ZqF98dc4SXg4AlCyY/6s9Rm3Plrvy2SPyw2VmzFbSDQAAac7MQxzldXFCN5KIDeulSbYvCDqpc1p3gnV5RF60TckvtvqVdGe39vl66+J5fDep+5/HuGud6MUMCQIXqiI50Zj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEn/PaoW39rG2OOzIGSF713NHprleq46g8ra9NXBp2Q=;
 b=hqCEJIV5d+ciwAav5JAUtB4HdsX93lS15QJeU/bn02pV00RMxbKBFs/UMmeqRIirIO7iYStRToQPbaz/fTFvQDo/Fbkr0SQ0gWA3a5M92KefopaClCvHuEcgBdYHzEAtJDfbth6/sbqE7kp0sD1P5Kc7YHTZQx/nAMjWSTijKxU=
Received: from CH0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:610:b3::17)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:17:23 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::85) by CH0PR03CA0042.outlook.office365.com
 (2603:10b6:610:b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 07:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:22 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sreeja Golui
 <sreeja.golui@amd.com>, Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Subject: [PATCH 06/45] drm/amd/display: Providing a mechanism to have a custom
 pwm frequency
Date: Wed, 1 May 2024 15:16:12 +0800
Message-ID: <20240501071651.3541919-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 203e814b-a476-40c4-e73b-08dc69aebf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I/bqfA2wru8yRPvfeNyslk5lgFbxYLBcR8ZGKrJo3Ob4rRfzbDDI+J79kSCZ?=
 =?us-ascii?Q?YYhjLMQZ/xwjyqUlPPnT3UUZskJFdNsEWH2qVHrRqSoqNah2wjUITtHk7QMV?=
 =?us-ascii?Q?qovpJZa34dLXNDBS2stSPwzKvM36OHAqph3Rj2F0VSDQKufkycl4SPhzl/rS?=
 =?us-ascii?Q?ZpDFN1sr4yu5cKvZYKPcKbalBW0daYugohUQpwZb8i2MdAUi7Fpuah6dgWEQ?=
 =?us-ascii?Q?2+PEVy8h4/6raWtg3U8QitSNKDNXUSx9yI40VslHXddF+C9mnUFnzvkX/7e5?=
 =?us-ascii?Q?mKsfW/fdTmX5PONtlDI785L1/NLIH376L9wWEaieI/NfNNeRu/CtXhEvk34S?=
 =?us-ascii?Q?F8aTFBRW+vnEDIKgx9y3xQ4coBgttSNDIOQiJVZEJTU3L5HDP8KWqz0ZMXgg?=
 =?us-ascii?Q?YKNBDm44TEG5E7s1OOLoueIPFIDhvkwDlorJZEkhP/7JGH9uLAXc49w5Y6il?=
 =?us-ascii?Q?1/Pfin0lCP4GsIE2/x4xl7/dKPoMPpFgEAchW4mE61n3RDRJXHqkxFOdxelG?=
 =?us-ascii?Q?aXYZMJekLbi1Bn403HCHpyCN9zS0nLneZS+dOEdFhNYg7WZfp5auvy/kWEiZ?=
 =?us-ascii?Q?Gt1o0wGnk0DJ7nfhl9TSO7OTD/jEI1GGdQM87k6m2YASmv5w/b4TRLv+99g4?=
 =?us-ascii?Q?RjpPAWjLj/vec6yfxWlFhKaLIyilq1FGOUghdHT9pEfuWWYO2gcJiIcX9Tyf?=
 =?us-ascii?Q?NKc96IO9llsG9X0Dr90COVyjhhJOSk2392Bi+5EudpG57RhXDloEUUSoklYH?=
 =?us-ascii?Q?TgiF746Ym/t1FfCzPmxNpemezZ8oei57N1P5KQ41xR7WuyTlLsKr+LZ7hJij?=
 =?us-ascii?Q?sDa2CqoK88I9bJHq2lA6CFuuUzDk5eRcHDBmckN8ajq+8GQN7lBJjDHZzoYv?=
 =?us-ascii?Q?MhMIJrNEhWBnPz7Ofim7M6USztgunBQnryBuPcHN7VAAq2cGwtT2JorGjOfy?=
 =?us-ascii?Q?EkG8LzodOZcTVgx+gbRtGrmdPuVr/VOwOx9W03tJRUnsYDmeHzs9zhN8bZiw?=
 =?us-ascii?Q?Lc9mAzHqgPNuCxXHOaxZrG8iDbQaXcNWecsDy1Kwf+5IWbro3Xd3UP0vUbGK?=
 =?us-ascii?Q?UHMHvHpn4NUKJx2wnSQ7YvKsUXa7R/wbxhDUoFldRUuGQ4pS4RzTNRCCRvUG?=
 =?us-ascii?Q?+mrbs2dFhpcm0dfhcygca0ZflVHzH2ou/djwUAArz2qvWocxI83v+5vWKBla?=
 =?us-ascii?Q?BDy11ZZWjjV9xR6ZhMQ54JO/C9lsXoVu21f5bf3RWHgtvoh6DQWLknurnjfa?=
 =?us-ascii?Q?Fq9IKX5yV87uwS4MHXLfKipeJyR47EAaqQj+9rblmg2JLICTMV0QkchgmF62?=
 =?us-ascii?Q?C5wmkpKKQhmyKZ3Zd9T/x3K3Nsw61BZ9i1G/uj2f7snLl69vRUSJZFfhjoJc?=
 =?us-ascii?Q?S9iPaFXBN2YzzH+6K02MYkjxFZUq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:23.1235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 203e814b-a476-40c4-e73b-08dc69aebf24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

From: Sreeja Golui <sreeja.golui@amd.com>

[Why]
Providing a mechanism to manipulate the pwm frequency on the
individual GPUs and monitor the transition during the switch.

[How]
Added a variable in dc_debug_options data structure. Using
this variable to call the newly added command on the firmware.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sreeja Golui <sreeja.golui@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    | 14 ++++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.h    |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b6e92dda4b2d..235e43e10799 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1026,6 +1026,7 @@ struct dc_debug_options {
 	bool disable_extblankadj;
 	bool enable_idle_reg_checks;
 	unsigned int static_screen_wait_frames;
+	uint32_t pwm_freq;
 	bool force_chroma_subsampling_1tap;
 	bool disable_422_left_edge_pixel;
 	bool dml21_force_pstate_method;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 20c6fe48567f..573898984726 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -70,6 +70,7 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	struct dcn31_panel_cntl *dcn31_panel_cntl = TO_DCN31_PANEL_CNTL(panel_cntl);
 	struct dc_dmub_srv *dc_dmub_srv = panel_cntl->ctx->dmub_srv;
 	union dmub_rb_cmd cmd;
+	uint32_t freq_to_set = panel_cntl->ctx->dc->debug.pwm_freq;
 
 	if (!dc_dmub_srv)
 		return 0;
@@ -96,6 +97,19 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	panel_cntl->stored_backlight_registers.PANEL_PWRSEQ_REF_DIV2 =
 		cmd.panel_cntl.data.bl_pwm_ref_div2;
 
+	if (freq_to_set >= MIN_DEBUG_FREQ_HZ && freq_to_set <= MAX_DEBUG_FREQ_HZ) {
+		uint32_t xtal = panel_cntl->ctx->dc->res_pool->ref_clocks.dccg_ref_clock_inKhz;
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
+		cmd.panel_cntl.header.sub_type = DMUB_CMD__PANEL_DEBUG_PWM_FREQ;
+		cmd.panel_cntl.header.payload_bytes = sizeof(cmd.panel_cntl.data);
+		cmd.panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
+		cmd.panel_cntl.data.bl_pwm_cntl = xtal;
+		cmd.panel_cntl.data.bl_pwm_period_cntl = freq_to_set;
+		if (!dc_wake_and_execute_dmub_cmd(dc_dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+			return 0;
+	}
 	return cmd.panel_cntl.data.current_backlight;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
index d33ccd6ef8c3..8cf0259e211e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
@@ -29,6 +29,9 @@
 #include "panel_cntl.h"
 #include "dce/dce_panel_cntl.h"
 
+#define MIN_DEBUG_FREQ_HZ 200
+#define MAX_DEBUG_FREQ_HZ 6250
+
 struct dcn31_panel_cntl {
 	struct panel_cntl base;
 };
-- 
2.34.1

