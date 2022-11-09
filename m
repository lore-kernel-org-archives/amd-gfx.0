Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2A4C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FB410E07B;
	Wed,  9 Nov 2022 06:15:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF1910E07B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbuhKbBNAsE2DoWeA1hVAESi/CsRaftozZP3hzFDXEFzKdiCMbHDjJZ8ucJkUZGq+L7iyiHTj7ZhiVl4DETJRoOIkDPkhx/Zv0kJpzhc8UdmBUllvyT06Yifp8icVpLDhd3jvGOR/e3O3J7QAvQEKos2XUKynLTqcsUoIWlsSe7T9mjvqDpbbu2GbNIoKHP2l8715nvjYxxpGFU4UB/qg1X2owu9/UyvwZhIRtUAH03zbpN/L1s1Zf+J3ZgmQNaeOe3/twfQsj6drHVa7TSIv3650eDZsQwx/4k2kbOTxiqhEcc6Ja1ybNDapIiNF/dlC4R2ochwsKjw4lmf3/7wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epYe+BPSd0M1vV5HcNBbgHHtDoEVB8uuHelavtZMlZI=;
 b=X9dXw6u1j76lkVmuaStadZXDmJ9Kh3lDtsC1XLwUev6nSFjRF4zhoeKhc1Sgu5YiFO7gpBQr6mMQNyBBbGM6/QBMpU9XcO+Au6Qr6HvxEg+OgI+8vjCOBw9E7kteb2d4ptN7rz85tFLUvKEFnXCskE54yPHPBgsElFicjhAlJ3tv6ti177718J3Xyu8SdhelD6fqs62bSCq0zVvz66zSUIUJYUiG3iTnNJ574sYtwXcts7bXO5Aq5vcmLu5rKkYBs3FH/ouE1F1jTHTUW1ZDd1JcMJXZ1w45IpBJs1y7IjZcPTjtqP2Q8qVHIdDKHFpSTVNt3DFVws1oxRoBghCJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epYe+BPSd0M1vV5HcNBbgHHtDoEVB8uuHelavtZMlZI=;
 b=gntbRshpHIrv38En6Ii++sachuJQjsqfCcRQzwB6n+JUX/flf+UJMYXN7DpV9SrS9FNhen944Juu2fmm5xdLBWZpkXvC3W+NhyjdoShOgxhfoKwgG3+frZOI1MKqkiTmB7bb9sNhDV00NhhjOtDA0yOGc0XhyJrM+YXwKBuAKwc=
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Wed, 9 Nov 2022 06:15:26 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::15) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:23 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:18 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/29] drm/amd/display: Use min transition for all SubVP plane
 add/remove
Date: Wed, 9 Nov 2022 14:12:58 +0800
Message-ID: <20221109061319.2870943-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff0ac9b-6630-49fb-6b92-08dac219cabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf2E5SOBIJNVlvLLXycBgp1aFW7j8w0i5OoFOS9DN+UzoIVU3JaHw0O4yBRx4xMEFEiGnbB2uxEmqO/l/HCT9iDHBN4DDj5cDJ6LnJAOJ6DMERC4jELNhIL5ykX+K2zIuZAEgFAugTrQb0ISQ4yMbW+oRapVW0MdDoKWPsCG2wZ400oRF2pPdG5IKZSJv3SqxBVgwiagJRzKK72MMRNVRL8DojJbt43JoWoU0MD5O5ub6stw6U7tYb5ToCtiUu/ks82MlIIiNitEIwlgJxCRMSILbkeQbKMj/Lp2OcOMaCwgODcAJwiso0QSgkqUmBP8SChFW6coPAlfAOuXxS5C9OgbCxuneeiaxA3r2TjJo94KOy93YTyLMSSij+hJKbzWytohTmSZQ73cD7ujD1b2CzMxWprbSeDhzY0f2o8+zvzMuR0QDg1/VueVChGsb+k7lmTxrhp99NIwGEjl9ARrJzLPupabexQTpdoW0h0gju0AhIdXJWYrog16yvvMXPrBhODUvVrEH/bigMZ+qJ187KDVFuMsycNhBFSDXM6AB/TQ7KMdOwA1uQx/qzRvD1b87KBWM9kqfRtdAzfZ6WZrlvyzQl/qmiPXvgc5fv12Nu/OlKSNRDZwEmJHPHDieGUxjVyCetlkccPwhIowYwzSwRwhrEUDegszYeegKRhkDx/LXajZh0pIq3wwLDIA9xQ5orHsEYSRxB259A749vnf9exzjI/OMcDkJKkUKy5qv0szKtyu26DZAbCD7e3H7oIX52aNuJXVWo7fS+mrsQtHQw2WW3j/rD7Hyz6nE+WOmIiJIMZKAiLwqtE6rEumotDO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(83380400001)(36860700001)(86362001)(81166007)(82740400003)(356005)(478600001)(5660300002)(8936002)(6916009)(40480700001)(41300700001)(4326008)(8676002)(70206006)(70586007)(186003)(316002)(54906003)(2616005)(6666004)(26005)(1076003)(426003)(40460700003)(336012)(2906002)(7696005)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:25.7038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff0ac9b-6630-49fb-6b92-08dac219cabc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Whenever disabling a phantom pipe, we must run through the
  minimal transition sequence
- In the case where SetVisibility = false for the main pipe,
  we also need to run through the min transtion when disabling
  the phantom pipes

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 31 +++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d90ab1867ed7..0a252a65a678 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3749,17 +3749,17 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		}
 	}
 
-	/* For SubVP when adding MPO video we need to add a minimal transition.
+	/* For SubVP when adding or removing planes we need to add a minimal transition
+	 * (even when disabling all planes). Whenever disabling a phantom pipe, we
+	 * must use the minimal transition path to disable the pipe correctly.
 	 */
 	if (cur_stream_status && stream->mall_stream_config.type == SUBVP_MAIN) {
 		/* determine if minimal transition is required due to SubVP*/
-		if (surface_count > 0) {
-			if (cur_stream_status->plane_count > surface_count) {
-				force_minimal_pipe_splitting = true;
-			} else if (cur_stream_status->plane_count < surface_count) {
-				force_minimal_pipe_splitting = true;
-				*is_plane_addition = true;
-			}
+		if (cur_stream_status->plane_count > surface_count) {
+			force_minimal_pipe_splitting = true;
+		} else if (cur_stream_status->plane_count < surface_count) {
+			force_minimal_pipe_splitting = true;
+			*is_plane_addition = true;
 		}
 	}
 
@@ -3794,6 +3794,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
+	bool subvp_in_use = false;
 
 	if (!transition_context)
 		return false;
@@ -3810,6 +3811,18 @@ static bool commit_minimal_transition_state(struct dc *dc,
 			pipe_in_use++;
 	}
 
+	/* If SubVP is enabled and we are adding or removing planes from any main subvp
+	 * pipe, we must use the minimal transition.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			subvp_in_use = true;
+			break;
+		}
+	}
+
 	/* When the OS add a new surface if we have been used all of pipes with odm combine
 	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
 	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
@@ -3818,7 +3831,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
 	 * enter/exit MPO when DCN still have enough resources.
 	 */
-	if (pipe_in_use != dc->res_pool->pipe_count) {
+	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use) {
 		dc_release_state(transition_context);
 		return true;
 	}
-- 
2.25.1

