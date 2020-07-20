Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6C4C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 09:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1682080D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 09:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvcroGZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1682080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C256E282;
	Mon, 20 Jul 2020 09:00:16 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54D16E282
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 09:00:14 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id o11so16999489wrv.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jOyk8f3P4M19tloOO9wscwvX2NjyV1+s+TY4dw3yFR0=;
 b=KvcroGZ7YMaGH7S1JamjHyMYWzizuE/OMBtws3Ni1NGJg4ufKQJVb0iTOFrbv8vrfM
 p29Ae6/NyG8bvpp3Ujxu9oHxUETe/gckjfk6+UfzF15c78Fzle0lo7hYtM9bsLxllzV9
 JZ4HIqi2/reuka8AOv9X+Tu5EnoXlgFX9pZCEFXtNxL4HmATGTOOtJtB3X7EqCTDg3zs
 CnwqK8k/QB+ZTSvWuRsg8y96mO/oLrq8rMOOXaV329wvBICuZTnxQTFqbYTU3tCbAoLi
 oXCSjdEbG5GhYBYdYluGTTBl3E6DDKw1oaDDkLlyXgwS9U2ZPMa/HTsjMZnrEVGuQ+S5
 BdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=jOyk8f3P4M19tloOO9wscwvX2NjyV1+s+TY4dw3yFR0=;
 b=G0GxaK+3PiXP7mrnVLznbXz1E8XNh/04ycnVb8LlCDybLi9oJliI6BEhXMREDHSbef
 hTdU1z+KcuLIyp4StsM461Fm3+RkKocOr8WEa6flnGf4yZPLn58hmhJFeFv7LER1p7Ak
 JnRQ3QnM4UFnp1UbyiG/QWEm8246tJLv4vI4KIsUikMN4/Y6l25fibarmuLUnLKKPwlA
 cZnX8TvVrS7ZGftA8Nm0ckT/W+y3injv5Ip8XPRq/dfEECJEtkrmL5FYPy/FtXOWn0YX
 D7p3TlIczyJ8P3/8lpdbH51Q31IKbbdNTsGFOSkLIB85qE4VWHnyTzsRYanaXjhj+6cq
 rLiQ==
X-Gm-Message-State: AOAM530oAtMIRybdwSn5WlwtYB7kjW/7hv8bZ+f0x4py6JbWocnYQ43K
 CsYiMg+0Zi5FzTz0EfSUTlMr00iL
X-Google-Smtp-Source: ABdhPJwk3kIbV7gWx0wc9Uk0ngS2kbVb7ozXrHSitklGIVX6Yrmi0rUedyMWa7IXot9QFqUg0mHhUA==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr8137520wru.47.1595235613211;
 Mon, 20 Jul 2020 02:00:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s19sm8708171wrb.54.2020.07.20.02.00.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jul 2020 02:00:12 -0700 (PDT)
Subject: Re:
To: Mauro Rossi <issor.oruam@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9139d78a-a242-f973-31ac-a07ce6436396@gmail.com>
Date: Mon, 20 Jul 2020 11:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Mauro,

I'm not deep into the whole DC design, so just some general high level 
comments on the cover letter:

1. Please add a subject line to the cover letter, my spam filter thinks 
that this is suspicious otherwise.

2. Then you should probably note how well (badly?) is that tested. Since 
you noted proof of concept it might not even work.

3. How feature complete (HDMI audio?, Freesync?) is it?

Apart from that it looks like a rather impressive piece of work :)

Cheers,
Christian.

Am 16.07.20 um 23:22 schrieb Mauro Rossi:
> The series adds SI support to AMD DC
>
> Changelog:
>
> [RFC]
> Preliminar Proof Of Concept, with DCE8 headers still used in dce60_resources.c
>
> [PATCH v2]
> Rebase on amd-staging-drm-next dated 17-Oct-2018
>
> [PATCH v3]
> Add support for DCE6 specific headers,
> ad hoc DCE6 macros, funtions and fixes,
> rebase on current amd-staging-drm-next
>
>
> Commits [01/27]..[08/27] SI support added in various DC components
>
> [PATCH v3 01/27] drm/amdgpu: add some required DCE6 registers (v6)
> [PATCH v3 02/27] drm/amd/display: add asics info for SI parts
> [PATCH v3 03/27] drm/amd/display: dc/dce: add initial DCE6 support (v9b)
> [PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 support (v2)
> [PATCH v3 05/27] drm/amd/display: dc/bios: add support for DCE6
> [PATCH v3 06/27] drm/amd/display: dc/gpio: add support for DCE6 (v2)
> [PATCH v3 07/27] drm/amd/display: dc/irq: add support for DCE6 (v4)
> [PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support (v4)
>
> Commits [09/27]..[24/27] DCE6 specific code adaptions
>
> [PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support for SI parts (v2)
> [PATCH v3 10/27] drm/amd/display: dc/dce60: set max_cursor_size to 64
> [PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specific macros,functions
> [PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specific macros
> [PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specific macros,functions
> [PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific macros,functions
> [PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6 specific macros,functions
> [PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6 specific macros,functions
> [PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific macros,functions
> [PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6 specific macros,functions
> [PATCH v3 19/27] drm/amdgpu: add some required DCE6 registers (v7)
> [PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scaling Horizontal Filter Init
> [PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DCE6 macros,functions
> [PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DCE6 specific .cursor_lock
> [PATCH v3 23/27] drm/amd/display: dce60_timing_generator: add DCE6 specific functions
> [PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers (v6)
>
>
> Commits [25/27]..[27/27] SI support final enablements
>
> [PATCH v3 25/27] drm/amd/display: create plane rotation property for Bonarie and later
> [PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts (v2)
> [PATCH v3 27/27] drm/amd/display: enable SI support in the Kconfig (v2)
>
>
> Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
