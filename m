Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE6CC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 09:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27C210E445;
	Tue, 31 Oct 2023 09:23:48 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6853910E439
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 08:57:37 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-409299277bbso34300925e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698742656; x=1699347456; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdIgMt0Zd5OrTAXhCgGiW0ACxcmVYMBjRSImafg865I=;
 b=cXHctjLAsf2/BYqILuKbAzBxXkpGV3ztF2TzgLObjfkv17zfO2/Fc8OJWONjNyVIzy
 o3TE07MIOdDGcMKnpyXHOhHk1D3/1BoyjoSjECasN0indGT7lMsQEV93sa1hP6EZfoEQ
 jMYs6ydOBUla++L/NfnmctvG1R3nFiv52EAguObU6VjmlurRnbAGeKcXP/Pn7tA0DV4c
 FEzGfeOjZvVpKT9FIqAH5N3Rgc1FhYlUsFL3Cn0em3XH6YHV0vFzWEvHl2/mGscsz80z
 aX5wy0kGOIYOJ/6ABOhfk5GD0OrlzIQP78Zl4HCnyShyejL75ewOtmDRs8LxW9bOwexf
 ug0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698742656; x=1699347456;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KdIgMt0Zd5OrTAXhCgGiW0ACxcmVYMBjRSImafg865I=;
 b=UKX6zP0XwCMrbKRXarr8Lv3pEK3EeGUqw7Xoiiu2GtpATnxeAgaRpnQwAMiLwOtHhL
 YlFhlAntaac17o0jXNaO9imPS+2j6LepEwtqT7siVfwGRNNl05eKKmbwUJ1XTfIMwmAp
 /ZG+Xu5BG0vDAPl4umMNb5GTgMOx9omEzIEvMxhhTx/1udyiPsc3I3YeLDma1u2byj7m
 dVkxhZyl34HEpQNVcqnD8dObm0ot4aNnJTUljmPDIDqyisWm3klYEKFCNzbUrNyHotCt
 5nQ25y5oSDeSwvkv4uS9Umy98+nZv0+GbVM3U3PmP6gm0Msf9xheeUsQvD7XGzMFcodj
 z+rQ==
X-Gm-Message-State: AOJu0YyCKvp8pYpx+Htu08x56dl8YwUcnXOv1yfeW7/7mEubtkG4lDXJ
 tclwz41g9DkJTlEQhWf2OLHuTw==
X-Google-Smtp-Source: AGHT+IHAStacHa9biIkH81dxXEV2xdyUtO+PorrqumPvn5b6OJ2e/L4MwAP8DCM+n0AjYZ8UXx694Q==
X-Received: by 2002:a05:600c:4f92:b0:402:f55c:faee with SMTP id
 n18-20020a05600c4f9200b00402f55cfaeemr9229980wmq.26.1698742655548; 
 Tue, 31 Oct 2023 01:57:35 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 b3-20020a05600c150300b004083729fc14sm1096849wmg.20.2023.10.31.01.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 01:57:35 -0700 (PDT)
Date: Tue, 31 Oct 2023 11:57:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: stylon.wang@amd.com
Subject: [bug report] drm/amd/display: Add interface to enable DPIA trace
Message-ID: <961dd9b8-6000-4af8-ba24-15688723e372@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 31 Oct 2023 09:23:45 +0000
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

Hello Stylon Wang,

The patch 71ba6b577a35: "drm/amd/display: Add interface to enable
DPIA trace" from Jun 30, 2023 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1041 dc_dmub_srv_enable_dpia_trace()
	error: we previously assumed 'dc_dmub_srv' could be null (see line 1040)

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c
    1033 void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
    1034 {
    1035         struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
    1036         struct dmub_srv *dmub;
    1037         enum dmub_status status;
    1038         static const uint32_t timeout_us = 30;
    1039 
    1040         if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
--> 1041                 DC_LOG_ERROR("%s: invalid parameters.", __func__);
                         ^^^^^^^^^^^^^
This macro dereferences dc_dmub_srv.

    1042                 return;
    1043         }
    1044 
    1045         dmub = dc_dmub_srv->dmub;

regards,
dan carpenter
