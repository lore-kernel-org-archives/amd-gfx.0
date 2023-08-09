Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16736C001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5269010E422;
	Wed,  9 Aug 2023 12:07:49 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A88110E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 08:12:45 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317716a4622so5124672f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691568764; x=1692173564;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K77ZM1EV6CQY4o9X0wlpaU8dMwrRj5046b396XAXHck=;
 b=ENQ+7oshNk9aSh5msgIw9c9z51+3+fTG8RGPN97Ak66sBXhhnFf4LvgXdWmz/wHePX
 GqpssFjqSVwsXvqgRsHsX8IMv6jnk+UB05K881JwVdPsyZ5RtkUklL/eqFmc8IAsB6n+
 RuxNZB5FI/z93pQpMNoZou+3azd5XJjI2cSJTgg/u7NMSs6wzSfQAqZO2a+gJu/aoqbl
 k3XbsGGln9HEdtqtXOLP3PRZrzfYTsmWeBh0hWyN7Mgens+hV2EmW3facm6LBb6vTRMK
 sJedJb8MA9WLZzgindsOgLPxQgHkZ9f0w0ycjXHxL6rAtskTrFwdfWl1ATfZ9jUiXnjK
 /i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691568764; x=1692173564;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K77ZM1EV6CQY4o9X0wlpaU8dMwrRj5046b396XAXHck=;
 b=jRdLKeViW+g6lPZIcW0Z0TRQLq+Xy4SpgqxFgJh41yfuLR1I8wTQ/NACZOYt/AkNGR
 IC/0Tn/bCuZVK3s/Vry1fMPI3b/dzFwaUFVmtSaw/rU4w0daR1rNmPDvx1x0/lnb0KJJ
 5Df4dD4B6dmxny242o8puPsskWtK4wA9A7rf+VpQZxiUcs5rVuhJ7fb/k08W8J2bp1ds
 4biD0dwkTIErdDxKZKrimcqglRtfd4RM3NiNGZqahDMbm/yv+TDiPYPeqr8/iEnPHJp0
 sTgpmnka9KsdGyfFp0BBfryOWc0V9aiWz3/AVI0sTswOfX2KlJhn42oBJP88Job/ZU84
 W1gQ==
X-Gm-Message-State: AOJu0Yx7NZAfXctc36QZWaQsfW4r86BVuLN83H3ZuJ8ZPSM5AzN62ATM
 KEHahbyeVePHjDg27q40wvXG63zYzXtIdGaVIQ4=
X-Google-Smtp-Source: AGHT+IH+5NL1JJdLH1MsKZPC6rT4NGAWSMs87MFevgJlgrmu7TsQ6xs+caJyd7dRWzI7F54hHGntSg==
X-Received: by 2002:adf:dd84:0:b0:314:5376:f0d6 with SMTP id
 x4-20020adfdd84000000b003145376f0d6mr1351481wrl.52.1691568763762; 
 Wed, 09 Aug 2023 01:12:43 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 k18-20020a5d5192000000b003143b7449ffsm15988143wrv.25.2023.08.09.01.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 01:12:43 -0700 (PDT)
Date: Wed, 9 Aug 2023 11:12:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bhawanpreet.Lakha@amd.com
Subject: [bug report] drm/amd/display: Add Functions to enable Freesync Panel
 Replay
Message-ID: <71737db4-e9f8-476c-837f-3163aabe7dc1@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 09 Aug 2023 12:07:46 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Bhawanpreet Lakha,

The patch c7ddc0a800bc: "drm/amd/display: Add Functions to enable
Freesync Panel Replay" from May 12, 2023 (linux-next), leads to the
following Smatch static checker warning:

    drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:849
    edp_set_replay_allow_active()
    error: we previously assumed 'replay' could be null (see line 841)

    drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:932
    edp_setup_replay()
    warn: duplicate check 'replay' (previous on line 904)

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c
    834 bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
    835         bool wait, bool force_static, const unsigned int *power_opts)
    836 {
    837         struct dc  *dc = link->ctx->dc;
    838         struct dmub_replay *replay = dc->res_pool->replay;
    839         unsigned int panel_inst;
    840 
    841         if (replay == NULL && force_static)

replay is allow to be NULL if force_static is false.

    842                 return false;
    843 
    844         if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
    845                 return false;
    846 
    847         /* Set power optimization flag */
    848         if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
--> 849                 if (link->replay_settings.replay_feature_enabled && replay->funcs->replay_set_power_opt) {
                                                                            ^^^^^^^^
Unchecked dereference.

    850                         replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
    851                         link->replay_settings.replay_power_opt_active = *power_opts;
    852                 }
    853         }
    854 
    855         /* Activate or deactivate Replay */
    856         if (allow_active && link->replay_settings.replay_allow_active != *allow_active) {
    857                 // TODO: Handle mux change case if force_static is set
    858                 // If force_static is set, just change the replay_allow_active state directly
    859                 if (replay != NULL && link->replay_settings.replay_feature_enabled)
    860                         replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst);
    861                 link->replay_settings.replay_allow_active = *allow_active;
    862         }
    863 
    864         return true;
    865 }

regards,
dan carpenter
