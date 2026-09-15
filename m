Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE542C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D8110E793;
	Tue, 15 Sep 2026 21:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AVZpDY0v";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1817310E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 16:38:52 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so156845e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789490330; x=1790095130; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mTDvtPFQggoQf4cXx8Wad+QLGOoydsdaoqZ1S/WXXmU=;
 b=AVZpDY0vr1Gokz6nmyVKZnUVerlkjaTCb7vkluJA9D0rX7fPACtdreu+cYh66FTmDB
 I5tiCulrbzfx8mob9GjY6P7dmFBjRBxkT3aBxWFD9faBbG1OFneDSD+zLOkdegVSNPA3
 6a34TLsLFSDNpTy91SrY8T4wSl3ZXhZPBPytFzHFoz6RSLR0uznQF93dzCqeCKVlpRPT
 f5DTNWGZfddwveVlfBvcbTGlRQdGFcyT3cGfBUWaiCy0/SO7IM6jWz5m/c27jDTMZo1n
 nm6OYtiqW4eL+hEeFqq8ouerAAEi7gixvRlWooi9r/7vRpS57KQhC8ktMfSAZmHX1e3r
 em4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490330; x=1790095130;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTDvtPFQggoQf4cXx8Wad+QLGOoydsdaoqZ1S/WXXmU=;
 b=YOeICMtrhWn98ySoIrp3oK6qhPrKtxvDjb/PvPmC/XCqy1llX/yQzfTbVAxAhRL3So
 FQCKLwrRbwTqc9tc0VThTJvLXNbAs91hJqytjr65SfnAovZrPeQd2a4g1v3iWNNJAu5c
 MgYZzzxZpL9wBU1xTT6ATmNOEub4gjAk46jCCPAWTHF0ZYYEPKtFi5LpjPK4w0e8EqPz
 SVYiX5zIApuIEZHVqB60xG2cOou9ltDJnIVBydR/8Mlse32RJVI6yeypM1nGf3hZgwIK
 ZphgBAhqqV1wygdo42tkXsvKGw2DfDcTSmk1HFXTIResoza1uVNOQvW+kRaUSa/zCQMI
 6khw==
X-Gm-Message-State: AFuF++n3O25e8Y+olElUSoUjLhCn5rDQDU37tm0SwWvduKhryK2snFkq
 8FJIJqU3J1B0DQdqV1fx/DwKXff9CGWq7WuudEvFqKyqPIhYPEChPhGB
X-Gm-Gg: AYBFou2UBpctzTVfbUMnGwS0b5oqO/ckzfu0l2vj0/HU3Sg+4J63ax2Zk4m5V9UHSEe
 81ht2aU8p/a2yuTCrwMUhWPwtk7iZWmifwzrv1io77Sl7yFxtGdBLefV524eBiC1W8hLVB4JEBk
 8y1cLiOLrJDhlr0T4A/uqbSaCCxFR9Wx6UDd8JjclQquPiT6ZSedJ3kZXUxmkGwtKRcolQxzdBX
 S5FFOoYmdHU6mmrv9tt9GRwxSqS1CgfHG2O/ifpfSZko+RkLg9feQQvjOgGCwmTpbPZK0/dxGBa
 x2y65iwxCmPdUwSJFkEJqt5smNDzUe4upzcHriroX6WfjELlmgnBNPqnqr7vhaFUmnxL4OLTk4J
 JRg2kK7Y6UTR+FMpuFHrZYVr7Do7wpnkMfG//dw4LIHNXtRIwS+Pp3/3wCBtrNM1PyLVx4ayTya
 xjZUCpbjmalm96ANVdS2pYj3rhyNR35nxZ2WqqDgqnQfAxrumbYjUVsGtFORqtOn9NKXk=
X-Received: by 2002:a05:600c:350d:b0:49c:fa20:cbfb with SMTP id
 5b1f17b1804b1-49e7a66b28amr95234905e9.18.1789490330275; 
 Tue, 15 Sep 2026 09:38:50 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da8e06sm2642055e9.9.2026.09.15.09.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:38:49 -0700 (PDT)
Date: Tue, 15 Sep 2026 19:38:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dominik Kaszewski <dominik.kaszewski@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Remove sink usage from DPMS
Message-ID: <aql0litI1KOTQNLk@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 15 Sep 2026 21:01:04 +0000
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

Hello Dominik Kaszewski,

Commit 8fa813b7fd1e ("drm/amd/display: Remove sink usage from DPMS")
from Jun 19, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:2423 link_set_dpms_off()
	error: we previously assumed 'stream->sink' could be null (see line 2412)

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c
    2386 enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
    2387 {
    2388         DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
    2389         struct dc_stream_state *stream = pipe_ctx->stream;
    2390         struct dc *dc = stream->ctx->dc;
    2391         struct dc_link *link = stream->link;
    2392         struct vpg *vpg = get_vpg(pipe_ctx);
    2393         enum dp_panel_mode panel_mode_dp = dp_get_panel_mode(link);
    2394 
    2395         ASSERT(is_master_pipe_for_link(link, pipe_ctx));
    2396 
    2397         if (dc_is_virtual_signal(stream->signal))
    2398                 /* No real hardware to program for virtual signals. */
    2399                 return DC_DPMS_SKIPPED_HANDSHAKE;
    2400 
    2401         if (stream->sink) {
                     ^^^^^^^^^^^^

    2402                 if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
    2403                         stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
    2404                         DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
    2405                         stream->sink->edid_caps.display_name,
    2406                         stream->signal, link->link_index, link->sink_count);
    2407                 }
    2408         }
    2409 
    2410         link_wait_for_unlocked(link);
    2411 
    2412         if (stream->sink && !stream->sink->edid_caps.panel_patch.skip_avmute) {
                     ^^^^^^^^^^^^
These places check for NULL

    2413                 if (dc_is_hdmi_signal(stream->signal))
    2414                         set_avmute(pipe_ctx, true);
    2415         }
    2416 
    2417         dc->hwss.disable_audio_stream(pipe_ctx);
    2418 
    2419         update_psp_stream_config(pipe_ctx, true);
    2420         dc->hwss.blank_stream(pipe_ctx);
    2421 
    2422         if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
--> 2423                 deallocate_usb4_bandwidth(stream);
                                                   ^^^^^^
But here stream->sink is dereferenced without checking.

    2424 
    2425         if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
    2426                 deallocate_mst_payload(pipe_ctx);
    2427         else if (dc_is_dp_sst_signal(stream->signal) &&

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
