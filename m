Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94359C3F6B0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 20:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F10C543D;
	Wed, 24 Aug 2022 20:01:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2021114BA55
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjzh7R1TQ7hJvodA8SfGdX6kh9ICXzv0L8BYenZVaQgBvNgb6cE9Vx5MvXyyIeXaK0/6IRHEuNQY4hFmahcRlHgIZDLZZAeDxfOMU5VOGPlG/qbo1RgE6RUhh46Bj/0HUvwvTRoQRC2fJ2BHqNwRlJP7M/vrZ5VDjZcnhBrogDjQpQMkxAJcI4HMwMCEjELmuXwmG+RFBfWliv6BnTa4qzR8tn/lGUbZ9dXNDSPsjFGowut5knQ8vSNdyN/IYX6wh8hlBxPy/VjN8C+gjoB+hqBzZli/bztYWU00QGoRSjnPOtSdSGlFgzHIyY0UOH++fnuP2797bCeEmnDwm3lHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjTT/XFcs/HUu99q0pioeOjR3JbM+4dJAEyvlpM1OJ4=;
 b=WTsfdXER/Evxt5MiP17Pt4ef2JgmQeJ/tBkOP0DgzvwK7o19l20cKZFPT+PuYzFtT2Fgm3YV/5kwPtCwUa30GvkuDLpPo05LFqPQ67RewZmA4qbm5FUlc8KnrcjnfmMF3MM6/NXtKTegVd1+1nKKfV3I6leeewWglloaf1a2AGWWovJnb3DNqE4aMyJMso/585vs22sXnb+QY+yjTCVMvqSLmgCk2/KbMnztnY4PT8/HOgqo6/SPD256SHuGD+67rJ0/8IZST8RJdxozwlaaIIqv+YR+wKSiJakAfbKD4qRJVX4E0XKTKt6wRT593amcGI9eWClO5GpHEDRyOZgVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjTT/XFcs/HUu99q0pioeOjR3JbM+4dJAEyvlpM1OJ4=;
 b=z2L5ynp7gh5DrlBp0s+/Lckh2kbV6yuyvQ2+F2IgoOKKXktB2Sm1H/OBf4RQKytSVw/ZQkn8sTcE5i97PIXkEjmUGCeMHLQSyuWKeI8tBLFcD9CsQgApn4MfxRFzOuGC32cwm96DtAYSkxJG17mVMkS819vxkPsVKPA4Cxf0rGA=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Mon, 22 Aug 2022 13:59:06 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::11) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:59:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:05 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:59:01
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: HDMI ODM Combine Policy Correction
Date: Mon, 22 Aug 2022 17:57:42 +0800
Message-ID: <20220822095752.3750614-5-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6254bd2-619b-4917-152c-08da84467a79
X-MS-TrafficTypeDiagnostic: DM4PR12MB5866:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQBy0Aj0FYu0ZcXCIqdFNrRLopciTsOb4WEHTtAMLWcPgIKcIDY1V4l2LFciJ0+y6pKiug6aoIg9w0ADVC5KLYJ5wNtIPscMr2Hxsrr9dVefY6eXEH8P4BOpLSeFN2TEmpk0yVoRdtUtqbS0xtE5RB+5QXD5PK9cGTU8keVWkd4BWryKo59z3OOCZmgq8XCjF5NOMGuAXvhUx9kdarBkSd/gtj1uPpTpJ68oN8hd9VuUSif1juBrP0KeIiMTfatDRL5JEaZBDrZZ3apFviQPLr3/wjvHMBHj/LRkUdigx68H3Bcrz9TyHeimm4jTGecRIFnKW0Yj1kXtlHDMdaRMS2Fv4GXo59Qhl6KLJZv0G2teGgYJslIK0YQB72ksQ2I/4rDLZZ/JpfMABhe5fTSi55ibOZXvMi5TAGOk4J+IW7p9Ffed2LJ3BT3r+fEsgihX1aMG+dU1vFeHrlje9qib8s8052hzB5s5l+sqOYPoAnoA4gQyzwuIusJfTrKTv9mu/eqsvL4tOt4NmOh4qbRHWvn4dES5VDL+sIQdEQ/oiFdorW2sxWVPe1kf0UHXYRFEUmdlqNUms2kpt7xBjJGyjW8mpNVnrWF5dFRjARN4X+4m9db091S4wqNGm1bsxiDLaNuKtQ0/rV/gE05wKHKQUWntACuMv9SDEyRL3XNZsnC8pMX7vYM1cJSGrHfNVTjWNmAqbhWrd48q/imgP38AxUOYd4iIQlM9Ti01Zs1b7K5PfRDh1t2ywKSArlVdYjmiTFkqwWR4el3Re7lkniUm9FNNjeJPHQCZNFMNpr9D9oDy5+KlPG9iH3sF43L2j8wQd01uhmihP4BXTcSNoLdh1f3/Xs1poxPymp3C0guSEB172bgyIyvqlNk7p+uraWT/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(82740400003)(86362001)(2906002)(316002)(81166007)(8676002)(4326008)(70206006)(5660300002)(356005)(40480700001)(7696005)(8936002)(41300700001)(70586007)(83380400001)(478600001)(26005)(2616005)(336012)(47076005)(426003)(6666004)(36860700001)(186003)(40460700003)(6916009)(54906003)(1076003)(82310400005)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:06.2898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6254bd2-619b-4917-152c-08da84467a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Saaem Rizvi <SyedSaaem.Rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>

[WHY]
Reprogramming the stream despite no changes in ODM combine mode.
Reprogramming the stream would cause intermittent black screen on
display which could only be recovered through enable/disable sequence.

[HOW]
Fixed bug where we detected a change in ODM combine mode despite ODM
combine mode being disabled. Also removed code which required stream to
be reprogrammed once a change in ODM combine mode was noticed. Lastly we
do not support dynamic ODM switching for HDMI TMDS and FRL on DCN32,
therefore we never want to change its ODM policy.

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c     | 3 ---
 drivers/gpu/drm/amd/display/dc/dc_stream.h            | 2 --
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 4 +---
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7dbab15bfa68..29f27e3fe3ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1904,9 +1904,6 @@ bool dc_is_stream_unchanged(
 	if (memcmp(&old_stream->audio_info, &stream->audio_info, sizeof(stream->audio_info)) != 0)
 		return false;
 
-	if (old_stream->odm_2to1_policy_applied != stream->odm_2to1_policy_applied)
-		return false;
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f87f852d4829..9fcf9dc5bce4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -268,8 +268,6 @@ struct dc_stream_state {
 	bool has_non_synchronizable_pclk;
 	bool vblank_synchronized;
 	struct mall_stream_config mall_stream_config;
-
-	bool odm_2to1_policy_applied;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 8b887b552f2c..1524b6d1ce34 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1904,13 +1904,11 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		res_ctx->pipe_ctx[i].stream->odm_2to1_policy_applied  = false;
-		if (context->stream_count == 1 && timing->dsc_cfg.num_slices_h != 1) {
+		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal)) {
 			if (dc->debug.enable_single_display_2to1_odm_policy) {
 				if (!((plane_count > 2) && pipe->top_pipe))
 					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
 			}
-			res_ctx->pipe_ctx[i].stream->odm_2to1_policy_applied = true;
 		}
 		pipe_cnt++;
 	}
-- 
2.25.1

