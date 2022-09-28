Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF252C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B3410E4D8;
	Wed, 28 Sep 2022 19:40:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A3F10E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJZQ2ohGA57fTjES03qLQkKZRFbdfaRPr4aVcX2/VlSp+Xkol6NGxVhlNTv6whTfBh7/wkcqbgBPpIT/semkB/OAmGB/OAGBQtHOvRspMELdFRbDlZ/RZPKhPgRR1/areB8S49Ue7YqlytaW5mtz3hENdZF3rZ8Mv8l8TvNC2vU8FMeXirQtzpNQREOi2914WF3Ee41LP6jLsAt75L8MxTYl2bQ52KwJry/CyXPMqS58kBkMYjA8ur/aM6eZwb0dz1bfVxpal+Gv35XR+sOWXjn8x8J4MY/twIoNRuWR+Bxwc7yEHhul76ei1KSsUB7irJPovgHAZf0MsACtQNnZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1scudNs21SiQ+of0ZW3513OijuriWKBgp/QNqLPSDE=;
 b=Vtzi5n9CtVCfNWDWM9Z/abSHzD/e1bhkf6cNwcF2uFFQW/9qcqdpMczFo29W6np6DgDHQoIHup1MK9E/haSrst5RxuWAvccr9JY5APu5jD0yRpGuWO0evLdsNP5OpzFdgg90D4CI9LQU5FQlvp1TvIjmMsm93NL3Wrum9tGKdyua8lzi2B960LybDTUa7lM4UZ8nr7pocA08HjTvAZVbcFJTHw9dAUmjsDoAbpTGwJxq3Y5YoaU8E0TvSYMYcEgGpon7xPql3hhelpAGkrSwtjcUgEs1cNyc6Nc5i8ptqj5XQSgG3K+goi8GbJ6uz/MU7BVXnW3syQcUzxNWRJgJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1scudNs21SiQ+of0ZW3513OijuriWKBgp/QNqLPSDE=;
 b=FtYWKjXMkUBW89PmuNfa9VFPJDb+47Mj8UtvbJw77qsgeY3ONXX6HQoPkmohWNQTieUsOx4I8Sn6wJ1AsNAp8X6IOhL64ZScLJdw6GGi/D9skNZGyZj8pbd8njvKPuP+mVcmxdpHVR+FOcCNQlyDRVCVXlq+flRiDTS6aRXMPDg=
Received: from BN0PR04CA0167.namprd04.prod.outlook.com (2603:10b6:408:eb::22)
 by DM8PR12MB5432.namprd12.prod.outlook.com (2603:10b6:8:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Wed, 28 Sep
 2022 19:40:44 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::a7) by BN0PR04CA0167.outlook.office365.com
 (2603:10b6:408:eb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:44 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:42 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/36] drm/amd/display: Program SubVP in
 dc_commit_state_no_check
Date: Wed, 28 Sep 2022 15:39:53 -0400
Message-ID: <20220928194028.144879-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|DM8PR12MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d6f6cb-a12a-4fba-8bbb-08daa18955a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wa4KkLCT00rgqBxPoidhBa+mmJFMq2607Nn1z9p4/h50lLe5cwmrIjnKh8NMV8kzoNNZyo8Peihfr93Fti0zXdsS2s7G9tDhg/yqnws3bBwcG2rE7WqcPy0HzgenRZOuqlCt7784MSX2TMnET6HYKlU4ij3SkC6mJoBzBmw7I2+H0I2j8mo+M9llsdgQlwJIt2iQGN+ISWqKUT8BkksdNkBXn0WVq+BZkuL/370Ah0Qo3vo1ohLSkA8nbnKtNX7CtTGkdsu2RArxV+AU3jm9ismUbqXxpMR4D14KJPAISFT72a34vtehx+yZagYgtpDk6kx8ATkYGWWjavigVjY/hPBco7qMgl9ofd+CVIpV8xL89ZcgjC/3gmPjiNuQG7c3X+p8BOmWUtRNV9JoTG/AWTFOr8DwAVRRrXExp7LfyNGqKRA8zagcx6c7zdQV+dTYTH+PYH09CQh4iFxrFI/smAPdJR0ccQg2u+BcG1wxzgXGXqPyQLfBilmycUALuJR6875JntJG9OONDpjF+b/zX/chOjvIVtlHn7M8JaP6T3qA+5VWOQW4Z+Mhci1olenh0WLL4HM2anPSG7CA7duPJoKW1vYdkPzTM8CSTeKrz29t3lvPn9Y8+qwgzZ1Ku4T8qVDNPtcHAfOFZRBJcvNW49y/y6uLF5uNQffhZOSzBdyCreVkqkNNoV02mgzcFHBtY86xmL6+BFi7G1eLuRtrZ78/LyBXNUNkH7cWnoSI8lB0+PVsee6nyX6QJuFxFR/Icv8OAhxQ/pOLnJgAnSRguKAfqC+DvdLfJpNltnPGp1TESdlmey8xAgSi6YooQ+i+E5UxOocrD1A6ZB0NLA4W2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(54906003)(81166007)(8676002)(6916009)(356005)(426003)(478600001)(316002)(36756003)(40480700001)(5660300002)(4326008)(41300700001)(70586007)(70206006)(82740400003)(8936002)(47076005)(2616005)(83380400001)(6666004)(336012)(36860700001)(40460700003)(16526019)(7696005)(186003)(82310400005)(86362001)(1076003)(26005)(2906002)(44832011)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:44.5069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d6f6cb-a12a-4fba-8bbb-08daa18955a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5432
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Why?]
Currently SubVP programming is only done in commit_planes_for_stream, as
it was expected only this call would add/remove planes from a
display.

[How?]
Add SubVP programming to dc_commit_state_no_check.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 258ba5a872b1..2584cb8f44e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1734,10 +1734,20 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	int i, k, l;
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 	struct dc_state *old_state;
+	bool subvp_prev_use = false;
 
 	dc_z10_restore(dc);
 	dc_allow_idle_optimizations(dc, false);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		/* Check old context for SubVP */
+		subvp_prev_use |= (old_pipe->stream && old_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM);
+		if (subvp_prev_use)
+			break;
+	}
+
 	for (i = 0; i < context->stream_count; i++)
 		dc_streams[i] =  context->streams[i];
 
@@ -1777,6 +1787,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe);
 	}
 
+	if (dc->hwss.subvp_pipe_control_lock)
+		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
+
 	result = dc->hwss.apply_ctx_to_hw(dc, context);
 
 	if (result != DC_OK) {
@@ -1794,6 +1807,12 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.interdependent_update_lock(dc, context, false);
 		dc->hwss.post_unlock_program_front_end(dc, context);
 	}
+
+	if (dc->hwss.commit_subvp_config)
+		dc->hwss.commit_subvp_config(dc, context);
+	if (dc->hwss.subvp_pipe_control_lock)
+		dc->hwss.subvp_pipe_control_lock(dc, context, false, true, NULL, subvp_prev_use);
+
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_link *link = context->streams[i]->link;
 
-- 
2.37.2

