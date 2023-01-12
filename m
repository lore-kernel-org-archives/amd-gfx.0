Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5526C61DB3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 22:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D13510E942;
	Thu, 12 Jan 2023 22:33:56 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F5A10E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 22:25:22 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id jn22so21591430plb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=content-disposition:mime-version:message-id:subject:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bj8YNZYj773EODRUgqHFXApSaiD9KuR4jPUiwE8KcAo=;
 b=oL0l6AyEgEXf+sREiti4ml1oEbzpS6BUwIZVV1G63ij1HTMvCtqAu0LaknGOkfMsGH
 p/UviPcDu2CY4MdRx/VKTKArEYyiHa0vD6NvNJSk92L/L25OeCB3PrdqYpgwro0SHwhv
 +AJvCee9Q7DU6/iL9PyTpgzmxCgdJmDiuD5uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bj8YNZYj773EODRUgqHFXApSaiD9KuR4jPUiwE8KcAo=;
 b=W2l7a4YIF7NYsmYvI3frDQxAzD1MgSpSUMzVvg7dnvvD4TafwTG/cvILn2EFoRWRmq
 1HPfpjNuiVsqCKwlVE/5soAg/oEwTHAGrbv9ZjiwwTYQ4BRu7dJ6v23KbLrqUu1RH//l
 AaADMVfuK6wzAcbRmHqxpb2hRuiS96nEoGhHJWzE2yiJ305BprABs6gqXjqI84WQVURY
 g6luE9B6q8WLLIQGQBBIym+OGjHW0Xbmn765AFf7/Vw+dqDjY00DfQ/NZdCfNdz2QI9V
 3T4Ye/zSzzh0HrgCbZCPGZFq2mL+Ew33Vix6w1zS1KRX7XgVOzT4H79RsBXreEaLIjMU
 kUUA==
X-Gm-Message-State: AFqh2krhQPzKgum/OsJYW0NRfqG1CI8au7vAb97rZP9U8bFIsWzTf3ca
 ETiTHl8pbY9ZCFlwSYDbfQT7bg==
X-Google-Smtp-Source: AMrXdXtfGsX9cI/jSo6TyoHbQX+mIPNPV0+cKVX+LPemtsSZtxnLciLhyi8qD5itmK1Hq/uY8ur9Ug==
X-Received: by 2002:a17:902:978f:b0:189:6f76:9b61 with SMTP id
 q15-20020a170902978f00b001896f769b61mr15951500plp.39.1673562322119; 
 Thu, 12 Jan 2023 14:25:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a170903230800b00189ac5a2340sm12710681plh.124.2023.01.12.14.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 14:25:21 -0800 (PST)
From: coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date: Thu, 12 Jan 2023 14:25:21 -0800
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Coverity: dm_dmub_sw_init(): Incorrect expression
Message-ID: <202301121425.FB249B61B4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 12 Jan 2023 22:33:54 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, linux-next@vger.kernel.org,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersen wu <hersenxs.wu@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-hardening@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20230111 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Jan 10 14:32:57 2023 -0500
    a7ab345149b8 ("drm/amd/display: Load DMUB microcode during early_init")

Coverity reported the following:

*** CID 1530544:  Incorrect expression  (IDENTICAL_BRANCHES)
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1951 in dm_dmub_sw_init()
1945
1946     	switch (adev->ip_versions[DCE_HWIP][0]) {
1947     	case IP_VERSION(2, 1, 0):
1948     		dmub_asic = DMUB_ASIC_DCN21;
1949     		break;
1950     	case IP_VERSION(3, 0, 0):
vvv     CID 1530544:  Incorrect expression  (IDENTICAL_BRANCHES)
vvv     The same code is executed regardless of whether "adev->ip_versions[GC_HWIP][0] == 656128U" is true, because the 'then' and 'else' branches are identical. Should one of the branches be modified, or the entire 'if' statement replaced?
1951     		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
1952     			dmub_asic = DMUB_ASIC_DCN30;
1953     		else
1954     			dmub_asic = DMUB_ASIC_DCN30;
1955     		break;
1956     	case IP_VERSION(3, 0, 1):

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530544 ("Incorrect expression")
Fixes: a7ab345149b8 ("drm/amd/display: Load DMUB microcode during early_init")

Thanks for your attention!

-- 
Coverity-bot
