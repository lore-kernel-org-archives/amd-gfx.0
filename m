Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480A9C433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196FF20768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ma5olXVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196FF20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471CB6E265;
	Thu, 13 Aug 2020 21:35:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E0A6E25C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlKyQlqkeNPepIa3H4dz1SQNNgZ7VK2vLekrOdCXv5NavE2cWCsPQ8hUVJP0lbMviZD44lRLXb0IQmD/gt5+bEJNzF6QgoNd8qmVAoFaRFuxsjwMAW2m8SUS2XmLQ6UN1KLeLajFebgkscpSeMV19XyXWnsokpk6PzOUBrRlDkeETxzvT9SyBI6rfSkUWL2M+rv9zaK3mPsQIn7iJBf11p7uokDVQqXlW5aP8abi4uImRwLUP2b4j/DzpKi56su+pisXZaQJKlz6t/7kUivtAWqwslyyvUw7S/3mstcDM3UrX6siSiU6uXTtx8Nqw2sfDgmNUtQ4kjU2vNfNPnqTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqoDL1Qvh86XEjWfQU6pjEiDLkeh0LoJAsw0pE2N7G8=;
 b=NQUSj5oQBdvGZCg63pSnOd4nPaZEeHsEnJwxQbj//QevT4aUSjPNB62RsQ0yycjM8zbIpaOl+iuNw7ugkJgokmLSRs24M1eq2jLDNV3gH1DEKCVief6cJXuyGlzGRwRTN7yXJAq9YMoHJzeKOERtpc4CsZ2RVXYwUkaXIRiV/42fhWTANQed3zRD9OjkCzSkoYUV0UleF8ZcSHITRYJpX7vRkoDNcVigZcNHITZrrU3FBwCi9EvgutHA0fyFLnLvGD0KhOqZSclLzAnUgBQcZY5oNH3tzOxeoYbmbfKiqYYrrKLCLxkckAatH1TDbLThRC8+gSgTslWIzicRvIzkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqoDL1Qvh86XEjWfQU6pjEiDLkeh0LoJAsw0pE2N7G8=;
 b=ma5olXVfAbESfJp3SeHDtoA0heXjpyImZ6faf86KkIbrliA7Yb4mWmpnLQJmvhCePlPiZbbkrC4am3xMBkvWje7Ku05EkB935ZuPlgQmnHXLzNKhS7vUjO/FixPek7kfn8/s/Kqo7AykHFfiDhpmGYkIq2Z9g3XVmFdbny/9QCs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:30 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:30 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/17] drm/amd/display: PSR eDP p-state warning occurs
 intermittently after unplug DP
Date: Thu, 13 Aug 2020 17:33:47 -0400
Message-Id: <20200813213356.1606886-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:29 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab7b5135-36c3-4043-6d30-08d83fd0cd40
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355AEC28C9154A289DDBD7E98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfsAVaBuFhEXACKDYgRqn8nmO9TAlibC/iYYmX9Px8wtiK4HQJs78j07l0xcWjwU4g+gmbgewXdc+ztYhUvJd1WEwRtVWT1jTMjLgNLCx23Zl1pHYaOnTfdGMSZTP6HP5lOE3GENDS45oOYldgA3hYI0T2+bitwJA2JLYIEBSQV6vo6GzM+ojkeyRfGlrIh0hldSRE2xfsMaKq6Rjxo0fjPBit/9TGqYIv9ixoU1VKaTU3B8wk4GqxqUpNQ2JZi5M0IoJ8+++aoDAPq5CcrmnIaBi2pYiCyTbVI4cfRaKNaBf77E7h9g/Q/n+iOgpPDA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ejlvU5qzlBZeVMIUtJ04vcmJ1JVFkGz4jGNRexOkvmTtWhihbvkYsZVDRcF17EBeGY85rYltem5jeSj7DAlMBnEUXfzZyE0QHlLPKaU3YdGH4TKbJc0YRf1Mki77vwL794dIdsyK7bQYD4akO5bqFCEwT5ZHHO2SqTxZ3r8grx9+obNjV217EX34DyxjzP6TyfOVFVjW+Zb1s2cqihndAa21BXJ24inLf+QHKX0o1+ho5LmZhBgBa6mO4m8myBiIxl86LWwP8DWaNp0XrMqFmvetCEMIpNMpPqDjYngwp73yXnAeQALVuaJA8edExP+5c9YRtMoZHuiKaijjfPugupEPEMO+gWGHvWPIXs82z6Do4NSL8GPoc4/sofESPppV94VbHLqNgrEMM8fnqq2T6wHiKOdRumsVJUcjkFs21o8c90pUCFXtdwXCu+a0L7hSWtqze2gc6f4ogmgjaAvUEV4KpWD8Xj3ValAqY0eiCekAf7CodhMtShkIOOG5gZYksJhf1iGv2jFs/qmHlbPN45PVS/LQQ1ZddARvfkL4nBaHJAydtsLpoIhIJME9PUaIOZee/HnR/FBv5JsLyLB5kkpLsupuAQmzPx3dSx/VX5JBWq+4+0r+ZqkmWAXlBQ+eevvjzHClCufiLjzr5DNxhW44YJFIHUliKc8+49GMajuDWwNmZc3NPhAYSwA1Em2Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7b5135-36c3-4043-6d30-08d83fd0cd40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:30.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fng96aCkZQ8zrSxAyRtAjmmJwfcxIbJGyel7dxZbIyCMyLzBr2gYL/8msmHh0jJ2H6kCKJZ0LRYf5KQYPD+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Aurabindo.Pillai@amd.com, hersen wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
with eDP + DP, each display use one pipe. after DP unplugged, eDP switch
from one pipe to two pipes -- pipe split.  dpp1_cm_set_regamma_pwl will
be executed too. The duration from switch single pipe to dual pipes is a
little long which could let eDP enter PSR mode. upon two pipes for eDP
are setup, eDP PHY is disabled. front pipe is not really running to
fetch data from frame buffer. i.e., dchubp is not in normal working
status. execution of hubbub1_wm_change_req_wa may cause p-state warning.

[How]
disable eDP PSR before dc_commit_state. psr is disabled when execute
hubbub1_wm_change_req_wa.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 24 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6165bd51f5a6..9894d5718ed6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -171,7 +171,7 @@ static void amdgpu_dm_set_psr_caps(struct dc_link *link);
 static bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
 static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
-
+static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
 
 /*
  * dm_vblank_get_counter
@@ -7535,6 +7535,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
+	bool mode_set_reset_required = false;
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
@@ -7611,19 +7612,21 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			acrtc->enabled = true;
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
+			mode_set_reset_required = true;
 		} else if (modereset_required(new_crtc_state)) {
 			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
 			/* i.e. reset mode */
-			if (dm_old_crtc_state->stream) {
-				if (dm_old_crtc_state->stream->link->psr_settings.psr_allow_active)
-					amdgpu_dm_psr_disable(dm_old_crtc_state->stream);
-
+			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
-			}
+			mode_set_reset_required = true;
 		}
 	} /* for_each_crtc_in_state() */
 
 	if (dc_state) {
+		/* if there mode set or reset, disable eDP PSR */
+		if (mode_set_reset_required)
+			amdgpu_dm_psr_disable_all(dm);
+
 		dm_enable_per_frame_crtc_master_sync(dc_state);
 		mutex_lock(&dm->dc_lock);
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
@@ -9144,6 +9147,18 @@ static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
 	return dc_link_set_psr_allow_active(stream->link, false, true);
 }
 
+/*
+ * amdgpu_dm_psr_disable() - disable psr f/w
+ * if psr is enabled on any stream
+ *
+ * Return: true if success
+ */
+static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm)
+{
+	DRM_DEBUG_DRIVER("Disabling psr if psr is enabled on any stream\n");
+	return dc_set_psr_allow_active(dm->dc, false);
+}
+
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = dev->dev_private;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ebbb8182228d..a2084f279e7b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2948,6 +2948,30 @@ void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_
 		dc->hwss.get_clock(dc, clock_type, clock_cfg);
 }
 
+/* enable/disable eDP PSR without specify stream for eDP */
+bool dc_set_psr_allow_active(struct dc *dc, bool enable)
+{
+	int i;
+
+	for (i = 0; i < dc->current_state->stream_count ; i++) {
+		struct dc_link *link;
+		struct dc_stream_state *stream = dc->current_state->streams[i];
+
+		link = stream->link;
+		if (!link)
+			continue;
+
+		if (link->psr_settings.psr_feature_enabled) {
+			if (enable && !link->psr_settings.psr_allow_active)
+				return dc_link_set_psr_allow_active(link, true, false);
+			else if (!enable && link->psr_settings.psr_allow_active)
+				return dc_link_set_psr_allow_active(link, false, false);
+		}
+	}
+
+	return true;
+}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 772b3a647700..f3ac9e3df760 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1265,6 +1265,9 @@ void dc_unlock_memory_clock_frequency(struct dc *dc);
 void dc_lock_memory_clock_frequency(struct dc *dc);
 
 #endif
+
+bool dc_set_psr_allow_active(struct dc *dc, bool enable);
+
 /*******************************************************************************
  * DSC Interfaces
  ******************************************************************************/
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
