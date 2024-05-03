Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47AEC25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 10:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E31210ED9A;
	Mon,  6 May 2024 10:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PLmQMmxO";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7301125E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:11:16 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-41adf3580dbso18705505e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749074; x=1715353874; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4BE/naA4kFlOa3PLPXU2yQ86oZlmEGYIs0mButmHk+U=;
 b=PLmQMmxOH6r66YEj/orWee91KlmaTx4R7nZG7R9fsOOG885Z73ye5z6RqLdEwZ5J19
 Yvwc/CPx8cfzNHxODBeG+nD0kCOj4r99XiABdXOU/tHubgzpINUKWKdgC+jiJZhr8Cka
 ExW8oaPHJjS2LSfbXcRUjcdcX85CAPY+bjY+vi0XQ0PrZsqJHsdNRJT1yELayDV8DoU5
 uzOIAZshwGi/82JwYebRwExRxwSieRInYzvRRchPa3vnTrQ9UzTqxUDOVm3WGQgKbXO9
 OU3vxzDYIQgGROPhDXNVF4Nmhob6k2i026xpC+KQypJm7Z7J0iuTxxwpaYPwtUtlOsOq
 bYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749074; x=1715353874;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4BE/naA4kFlOa3PLPXU2yQ86oZlmEGYIs0mButmHk+U=;
 b=UViZ+kxeuoTMJQPpI2RFfxqNDjC/FeF8okfUBOx4rKc5fW3FAO4NrmxECj17NxP2D7
 Yv5qMS0Nlc2tOtnU/2epMLsMdiWS9fVkFueGtGbO3g14DILpbos+XmFeCSJrC1DXqvR4
 wxnnugF9zzKVeaUSVnCzoY1/hiGNRsmc0zs2iFtWXRSN0T5GWE2ooxVbqBfyf5TIP1g9
 UOERazOHqHFLOIg2dDWNDJf/tXG6MJE4+YwgldDX4U+ktTNOfIYd6BMkIjkxvaYs78x7
 O3JoSutVgLm6qMFf0wII4Lfh3frcgaHabx4rHVYs82t3rI2d7DTXnxKbzt7LBQnzONfM
 d8fA==
X-Gm-Message-State: AOJu0YxdVXP13sPFekhLPXj5Ex/hE9HdLiZuxsI7prwTPlPBf65zOZfv
 eBDlfGjUFWJKxkZciEsDXk3Rk5ZOxvzg0XFD0jW7P2hwCGJvqaZxPWtpH6XKoME=
X-Google-Smtp-Source: AGHT+IEmgLkq6SSibxs4YhnqswIzHh7iBA7LihwA2JmzdnybrKFZ88LrCXYKTea1Ybv7voURaoCcMg==
X-Received: by 2002:a05:600c:45c9:b0:419:c9e1:70b8 with SMTP id
 s9-20020a05600c45c900b00419c9e170b8mr2830517wmo.13.1714749074356; 
 Fri, 03 May 2024 08:11:14 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 j3-20020a05600c1c0300b004186f979543sm9756926wms.33.2024.05.03.08.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:11:14 -0700 (PDT)
Date: Fri, 3 May 2024 18:11:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: harry.wentland@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Separate setting and programming of
 cursor
Message-ID: <83497c8a-e3e4-4406-920a-a21f047c72e6@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 May 2024 09:59:59 +0000
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

Hello Harry Wentland,

Commit f63f86b5affc ("drm/amd/display: Separate setting and
programming of cursor") from Mar 15, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:398 dc_stream_program_cursor_position()
	error: we previously assumed 'stream' could be null (see line 397)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
    389 bool dc_stream_program_cursor_position(
    390         struct dc_stream_state *stream,
    391         const struct dc_cursor_position *position)
    392 {
    393         struct dc *dc;
    394         bool reset_idle_optimizations = false;
    395         const struct dc_cursor_position *old_position;
    396 
    397         old_position = stream ? &stream->cursor_position : NULL;
                               ^^^^^^^^
The patch adds a NULL check

--> 398         dc = stream->ctx->dc;
                     ^^^^^^^^
The old code didn't check

    399 
    400         if (dc_stream_set_cursor_position(stream, position)) {
    401                 dc_z10_restore(dc);
    402 
    403                 /* disable idle optimizations if enabling cursor */
    404                 if (dc->idle_optimizations_allowed &&
    405                     (!old_position->enable || dc->debug.exit_idle_opt_for_cursor_updates) &&
    406                     position->enable) {
    407                         dc_allow_idle_optimizations(dc, false);

regards,
dan carpenter
