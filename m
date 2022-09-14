Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A41ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA2F10E825;
	Wed, 14 Sep 2022 03:57:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E1F10E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EktgfiuETyqQRBoMExgDDCxVYfr2ZXk8sEi/2S7fHyujwXbeIzMcT6YsXzqOqwJnZJb0ydZafvkXPID5RCxYlm+Xw/BvgCuGBIiouHMwDgo1azcjEj+5vJycujUehL5S1BEel9zlS9NSSkECJtaXLQAqDhQZOzv4zD5V8EFT+gDAC3s2wgFbDt0ztdrwcN+4tSoE7Ox43rFfyyjALW1yzoTgfnN4ZiJ2mpx3W2UasR/m8UR+9DjB1I9tZ2GwjEetKsK0Z12uEdrV2KV/00pIy+SFUa/k8aE2cSh4VNsDs/JddsTC9ciOW7XptEP8VgE0K19/ReO4sXqqyFOgZr5HDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vr3O6ekARkUcnKkLCPHtLkZriXw4kS1ft1xVq1bu3w=;
 b=FbnSrWjJNBlAh1O4eHU4kMQA6AKTAKvPbdJuQa5O+Fi7JrC1HjvHYk6NH4IxrCwToqROXBT1XVRavfyVBDOjIrnYLCIP1qmhTh7rrL1w4eJ6ul9yssMF6OzW97LxEaPuVNsHWnkfiixPgpR8FrYjXvT6cJopL2AabBBfTHUUclaQrYGp169VPNO1KwbS98iARLplKxxCPKws9pFtw4YNTYrtgww5S/fO7R8uT8piN10lc1uO5cjj8zy+SK3JTZdhJNyOzBRQRTc84+DbiCzfgl38XxXQoqdxg954LX41ASAKi+mpYamWEgiSf/2L+v7JQVlkQaHOiimkk3uU0jio0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vr3O6ekARkUcnKkLCPHtLkZriXw4kS1ft1xVq1bu3w=;
 b=IKI2WYhDBjjd87Fb132CQcnEfI5cUbMACN3FOStYXfigwY2FFqOk5fEwNTnLRAiel4faCOj2hgdtQS2oxlvBc7D186zrwOqgaz5t476LSCEIBTzn9QlMNwgEy33pklRgcyQyT6d1hKmeCajujlQN2vBjU8fdX3Gkgwdwqg5Hcr0=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:57:23 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::d1) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:57:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:57:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:57:22 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:57:18 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 44/47] drm/amd/display: solve regression in update phy
 state refactor
Date: Wed, 14 Sep 2022 11:48:05 +0800
Message-ID: <20220914034808.1093521-45-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: a18eb2d2-78ef-41be-aaf8-08da96053b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yv5ePLGyDKy8PiEekUplTVld3LCD8EtkFgrI7CDZ8jQZSt/rQUKzrXDbiF1SkayY/Mv+oN5zSm7uh68a2z4gyuF4D7tb8XQuJclZn4StvmY2dQzC4arOAfuwN+yUGm8USIHGwrDzkeNeifRC51D3iUHEXA2DBHgfxc0qGisDbso0rR0WunWxb3LUTe9tDOT+XGrK5MNaiqSGzFp8XyH1xfigE2WuSQ7pBUn0xZsjlmzfMl6oHJ7R2b9SEGl6J1Ft6FhPwemw5NRUxvjjS8HzqmlubwssxfOz9GAgaCgePOCzrBpbYW0dUdGJZLjg6Wf9OxUf6Hlh1jyquQG9M1kJjdVpa+r4dlb1NL5sNqx2f9qhM/mQNXe2wKLjXwLHRU5HLXjtvH+D0O7Jsmb2hlegYEcH4Usy1IGv+2ZuftyDpH/o0ztSIZ99IfW2hcKY+J5Kmah/+zrC0JF1SMkOOiE+M6EmN39fGsKkLqoYR9Y2bpFPTi014KkLNW/KqjYkhsRQ/uBNyzyfhVyX1OhZyU1i5jAbb1HSUOrVfJMGbbSg/tXdWHwJ3Xe36YmbhoHzmUgBUEIv8mgRZyTacTPyk9iQpeBkmdQGpqLzcpwkGUsUFWzfGIEVbw3zvbo4pZhAuRGqYThiroX/m0Cdg7PYE/m3e2V2GFStyMRfunk1uOZCT/5eLNrnN+MH+n/jCYylGlX1/qSpVhfucG+BPQyrHdZPnNIeZXRK4JocJTFu6LDtC6mqR0m64wryk+nHDKgalDlpNXLieTlcKWixGu+IWI6iYOKLP6dI+Z+0N0FJYu26kTeYIj6FOhwwl0B1ZdSau8Ul
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(70206006)(70586007)(8676002)(4326008)(478600001)(5660300002)(41300700001)(83380400001)(82310400005)(82740400003)(81166007)(356005)(2906002)(47076005)(336012)(2616005)(1076003)(426003)(40460700003)(186003)(36756003)(26005)(54906003)(40480700001)(7696005)(6666004)(6916009)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:57:23.4820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a18eb2d2-78ef-41be-aaf8-08da96053b03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
There is a coding error when moving dp disable link phy to
hw sequencer, where the receiver power control is missed during
this refactor.

[how]
1. Add back missing receiver power control in disable link phy.
2. minor modifications to ensure there is no undesired sequence
changes in dp link enable/disable.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c            | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3118e6f808f0..7842df9f62de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7073,9 +7073,9 @@ void dp_enable_link_phy(
 	enum clock_source_id clock_source,
 	const struct dc_link_settings *link_settings)
 {
+	link->cur_link_settings = *link_settings;
 	link->dc->hwss.enable_dp_link_output(link, link_res, signal,
 			clock_source, link_settings);
-	link->cur_link_settings = *link_settings;
 	dp_receiver_power_ctrl(link, true);
 }
 
@@ -7149,6 +7149,9 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 {
 	struct dc  *dc = link->ctx->dc;
 
+	if (!link->wa_flags.dp_keep_receiver_powered)
+		dp_receiver_power_ctrl(link, false);
+
 	dc->hwss.disable_link_output(link, link_res, signal);
 	/* Clear current link setting.*/
 	memset(&link->cur_link_settings, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 55c98dbfcc1c..2341982ee0a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -3098,6 +3098,7 @@ void dce110_enable_dp_link_output(
 	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
 }
 
 void dce110_disable_link_output(struct dc_link *link,
@@ -3111,7 +3112,7 @@ void dce110_disable_link_output(struct dc_link *link,
 	if (signal == SIGNAL_TYPE_EDP &&
 			link->dc->hwss.edp_backlight_control)
 		link->dc->hwss.edp_backlight_control(link, false);
-	else if (dc_is_dp_signal(signal) && dmcu != NULL && dmcu->funcs->lock_phy)
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
 	link_hwss->disable_link_output(link, link_res, signal);
@@ -3120,8 +3121,9 @@ void dce110_disable_link_output(struct dc_link *link,
 	if (signal == SIGNAL_TYPE_EDP &&
 			link->dc->hwss.edp_backlight_control)
 		link->dc->hwss.edp_power_control(link, false);
-	else if (dc_is_dp_signal(signal) && dmcu != NULL && dmcu->funcs->lock_phy)
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
 static const struct hw_sequencer_funcs dce110_funcs = {
-- 
2.37.3

