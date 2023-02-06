Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B86C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 14:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E2910E3DD;
	Mon,  6 Feb 2023 14:22:36 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AE210E06B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 14:20:47 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 c4-20020a1c3504000000b003d9e2f72093so10901044wma.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oz3yUN8JKjMb8lpX6PlvmO+h18eeXhtEP5GK2mCNaiA=;
 b=ftGEyUkgrvQhcg8/WE49kCbjcKG/LW12KjAsSGiUaXWUsAMMsRQrRlswfQbTxts6jt
 y4mlwON6fKjb8vdJuuUINsuFEBYz9zRfpjBoLB9LuyP897xu0lNIZ8vw3G28v01EI9Ky
 Y2adWy4yZAatdh7C/XSbZt2a1GP5GgZIyv4u0dgTi82lhYozWHrSDBdAxAYv85q0mi6S
 5JbrmcQqsqO0wIkFPm6jrKE8FIQpZp2qmF/QVvzcBxjV5Ez/EUpIglr3BLQClBoEZKQ7
 ylEQ7jCz1RdPOpX909i39Mfcr65Hjq1VyctJkKo5U3bTXnsKFhWHLluHtN1lIuhD607i
 sNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oz3yUN8JKjMb8lpX6PlvmO+h18eeXhtEP5GK2mCNaiA=;
 b=vSp21xm65HN/DNnNIS2uvjjaY9LO+YjN6vr4UXccwJ3jMhFwQ/zCrr9X7N7X6K+twb
 91O2ROYbQMMGuJpsTO7C1f485kovL30TphodICfvyCCg9qgI3oaD0a5vZWnVhl5Uv1Ad
 C2IHhVCus5jO2bPF/9RoyzXLP/2nlQvzKk/zozuV6z2B+yhGnW6n7+lrf7kzONooc+F3
 lRUlqkfH5wOMLgXUfpU6TAummXZ9scRyUZygOIM+KRq5fX8GViRkGas70Llk0Dpdc+7d
 5MgkqErZzFY8T9TDFuHlebML8NXG+pmozhcIQGUT4nQQNhgTNrEylnF67+iGieWpYCeK
 gq+w==
X-Gm-Message-State: AO0yUKXo6CzdDZ9t7uijAqDTpIX0BGmlrwF+Mt8EqNEbJpHO42iJRLrl
 YhQkClOPr6Bd8DNpjzZXgshIvTxBX0M=
X-Google-Smtp-Source: AK7set9ByajIKRalKICrUP4Sp0gSLlyArjtwYmTekkIML1sPaazPuVoRTyrUkHndHFWAqwmpZEcWaA==
X-Received: by 2002:a7b:cc12:0:b0:3df:1673:90b6 with SMTP id
 f18-20020a7bcc12000000b003df167390b6mr17743701wmh.39.1675693246136; 
 Mon, 06 Feb 2023 06:20:46 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c470900b003dfe549da4fsm11477901wmo.18.2023.02.06.06.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Feb 2023 06:20:45 -0800 (PST)
Date: Mon, 6 Feb 2023 17:20:41 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dillon.Varone@amd.com
Subject: [bug report] drm/amd/display: Disable MALL SS and messages for PSR
 supported configs
Message-ID: <Y+EMucnHeyZgPJY3@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 Feb 2023 14:22:34 +0000
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

Hello Dillon Varone,

This is a semi-automatic email about new static checker warnings.

The patch 0bed85e48af1: "drm/amd/display: Disable MALL SS and
messages for PSR supported configs" from Jan 4, 2023, leads to the
following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:257 dcn32_apply_idle_power_optimizations()
    warn: variable dereferenced before check 'dc->current_state' (see line 249)

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c
   248	
   249		for (i = 0; i < dc->current_state->stream_count; i++) {
                                ^^^^^^^^^^^^^^^^^^^
Patch adds unchecked dereference

   250			/* MALL SS messaging is not supported with PSR at this time */
   251			if (dc->current_state->streams[i] != NULL &&
   252					dc->current_state->streams[i]->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
   253				return false;
   254		}
   255	
   256		if (enable) {
   257			if (dc->current_state) {
                        ^^^^^^^^^^^^^^^^^^^^^^^^
Checked too late.

   258	
   259				/* 1. Check no memory request case for CAB.

regards,
dan carpenter
