Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F5606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ka5sAEOI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86B2112987;
	Fri, 27 Nov 2026 09:59:11 +0000 (UTC)
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com
 [74.125.225.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3036810E416
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 00:06:53 +0000 (UTC)
Received: by mail-wr2-f10.google.com with SMTP id
 ffacd0b85a97d-48ded18b8d9so1938602f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 16:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795738011; x=1796342811; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JHqtsUs0ik0BieRJ8Sc/408xRW33ZRqGcrC9WKJdgzo=;
 b=ka5sAEOIFn1dxC0P56Qt7ALzTKZtPShFN0fP4q9MnWoviTcMOkGhDPD3SBqdWIgWs9
 xeXWOkXHqIjD5X8beAlRiXHRGnDupBl0d8kIZkqRDLjLAuj9psxIWi7P2KtBmzB2n4Sy
 xSSHbvtfdob/Tbj50EsCPPJotNKVaOhog9WCLiV4E31Vwm0BZMW3YEAKxO0A7T4F+ihg
 dIRIvUtvIESoCo+4d05BI48spWfDwi9VXn90gnLGvl37wIEVsaTLr0XoXggQSbK8TEd0
 1kw8SvvR80UQjz8X20V5of6+lqG/g74wznEGywLpaWNlMKQXOdJnEIcoFD44AWlqaTly
 1HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795738011; x=1796342811;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHqtsUs0ik0BieRJ8Sc/408xRW33ZRqGcrC9WKJdgzo=;
 b=GYOSD7CjUFfXZrWwlDpNTNFodRG0yJ5Ui6pA4EIoNM6JqFznISSvYo7L7H1u4duAnK
 fogF63twC5u7f4pmvFVkgILmwWZxz5i42yoj7O6fd1LClp0cmMyCIV4VpnZBa0f9gb+9
 Yknhys6QcK6dEVroKslxV2VYRrx1fUZZBZMbxr/GJVh9vX8x3IRR/3+IPqWBo8M2A1aR
 /XcHDY7jGI6CpT07W6zhEySfXTZv3gxxXNDLUgu44mGgzMyXA5Yr6EWJzwfPpYPejsOK
 2VqpNs5n2mdgvV+r6tGUSmXkq9nbP1/YRFaBQ/yzlcVNNtuQ0SRds0rLGHSsbnTMTdBM
 YiVA==
X-Gm-Message-State: APuU4Z/M3r8Pl+IU4OGjajvaKDpyOdSdDMx7zLa49Z5TeGu/fHZM1tIp
 PYtUhELVhScodSdLt3XvRRhFxenCqCqBPm4mQ0x0JOTE0OANFUPwZbXVpgQ3naeMqYU=
X-Gm-Gg: AZFdTZe4uyBTILvPIROCsVSE98S5Xre/TFGh+HU64wNf3ChZeZ4YEG1yHGrZ2zCTng6
 KHJ1e82Eei2/sKilq59dDoYMS04S6YV/kftPTouUxyTHrtKM+kLiWrRiTE4p1vk+C0UTWKGiSdX
 bh7uZiSAqaMKITefw0l49DwoQfxiEcfAxc7scuwq6QBte9vm3E3PuO+p/F39FcV8Z7z3exOnqJw
 H5wp1CUXFIXjZv07Uqn28SWUfkj1lfkeDP060V4qPSh9ph61wYrr/XB1AauWp6qkpGvMl1SvQs6
 lWDl/6mJrrKhOPjHItyjrKl5K92WESuvuDD0DT4tR90zmhfqyDsUIbQKY0e+r0TJqkTdu8/LkIN
 Ws716V0C3wmG8pvLQBSSRWwm/ao1ME4SYQTbKgm4dVX6BpLIrOuwxx38z6R3pgG4CEeBCdkP7Z9
 /xt93AU62C3qejyt3vZFLezDb71KqLe+qIgi/uFPPIurTmbEy34lhrATuDKOMKf1EYw/4CUHglK
 pewInKaOkCvOMx406jE1sZm5TDgef9t/7nbcVLf08wC68j4KOlH0nopekAkCdQz6U8QGwGJw7dR
 3V8NHMy/UkxhDLD4UBMey+1irVThFWpxllfDfa0Dv+tcZ3a2SDK0gCoaQQ==
X-Received: by 2002:a05:6000:4381:b0:4a6:5a2a:f5a3 with SMTP id
 ffacd0b85a97d-4abaa9773abmr47659974f8f.3.1795738011470; 
 Thu, 26 Nov 2026 16:06:51 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm45145550f8f.11.2026.11.26.16.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 16:06:49 -0800 (PST)
Message-ID: <59629f46-5add-4fc8-aefc-c9e02b4d59d0@gmail.com>
Date: Fri, 27 Nov 2026 00:06:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v4 3/3] drm/amd/display: report synced displays to PowerPlay
 on DCE <= 10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DCE 11.0 and 11.2, bw_calcs() computes all_displays_in_sync via
resource_are_streams_timing_synchronizable(), and
dce11_pplib_apply_display_requirements() copies it to
pp_display_cfg->all_displays_in_sync.

However, DCE 6, 8, and 10 (including iMac15,1 on DCE 8 and iMac17,1 on
DCE 10) use dce100_validate_bandwidth()—which does not call
bw_calcs()—and dce_pplib_apply_display_requirements() in
dce_clk_mgr.c, leaving pp_display_cfg->all_displays_in_sync unset
(false). Because PowerPlay is not informed that the streams have
synchronized vertical blanking intervals, SMU7 prevents MCLK switching
at idle or causes modeset underflows.

Set context->bw_ctx.bw.dce.all_displays_in_sync in
dce100_validate_bandwidth() using
resource_are_streams_timing_synchronizable() and copy it to
pp_display_cfg->all_displays_in_sync in
dce_pplib_apply_display_requirements(), matching the existing DCE 11
flow.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 3 +++
 .../drm/amd/display/dc/resource/dce100/dce100_resource.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index d891b3bfe2a1..1dd302ad19aa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -320,6 +320,9 @@ static void dce_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
+	pp_display_cfg->all_displays_in_sync =
+		context->bw_ctx.bw.dce.all_displays_in_sync;
+
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 97ea22af5d2b..0d25c2ddb661 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -888,6 +888,14 @@ enum dc_status dce100_validate_bandwidth(
 		/* TODO implement when needed but for now hardcode max value*/
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
+		context->bw_ctx.bw.dce.all_displays_in_sync = context->stream_count > 1;
+		for (i = 1; i < context->stream_count; i++) {
+			if (!resource_are_streams_timing_synchronizable(
+				    context->streams[0], context->streams[i])) {
+				context->bw_ctx.bw.dce.all_displays_in_sync = false;
+				break;
+			}
+		}
 	} else {
 		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
 		 * the DP clock, and shouldn't be turned off. Just select the display
@@ -900,6 +908,7 @@ enum dc_status dce100_validate_bandwidth(
 			context->bw_ctx.bw.dce.dispclk_khz = 0;
 
 		context->bw_ctx.bw.dce.yclk_khz = 0;
+		context->bw_ctx.bw.dce.all_displays_in_sync = false;
 	}
 
 	return DC_OK;
-- 
2.55.0
