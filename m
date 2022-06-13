Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7720C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 10:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545BB10E3E1;
	Mon, 13 Jun 2022 10:41:14 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73B610E3E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 10:41:12 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4LM7QW3Xxpz9st9;
 Mon, 13 Jun 2022 12:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1655116867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0rIPQjiZcoQqfLRXeDwabbe9EyhgTIwv7WO+Dr0bZY=;
 b=VaCGltPL9r3ip7tRS2B/WsuULqWbIC5gvfMhPqibTDf9zlswNNp21ukySelwHuLDnIymju
 PgpW6osHyJIP1tAayTgE4muxhJSXL+gIbaaLtXgZUgJc0UBUVM46uM5en7sKP7a0Nyr6mS
 xav9IxXIOVb/hJH1u5Ei5yyTFjJgwiikCZeYqhb5MJcA39fxjA1inGLsBI6kk6Ie6hO+0/
 7hHHibaIEymFOQKq7QgzFQYS/5lPg9SW/RwNdT0kJ4DYeOtSxowW9OfzGjqTvue914proU
 01kdHr10kH1V72Kc4k+LAWKsyDRPy1ADzoGzuw6RatzhNSr1/ZMRVtiOLNvIug==
Message-ID: <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
Date: Mon, 13 Jun 2022 12:41:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Content-Language: en-CA
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220610205245.174802-21-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2c1130f6d7789e6861f
X-MBO-RS-META: 45jtoshf65q414h4dfxj7bjjoz1onwgy
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, Harry VanZyllDeJong <harry.vanzylldejong@amd.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-10 22:52, Hamza Mahfooz wrote:
> From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
> 
> [WHY]
> Game performace may be affected if dynamic memory clock switching
> is enabled while playing games.
> 
> [HOW]
> Propagate the vrr active state to dirty bit so that on mode set it
> disables dynamic memory clock switching.

So dynamic memory clock switching will be disabled whenever VRR is enabled?

Note that there is ongoing discussion about how Wayland compositors could usefully keep VRR enabled all the time, as opposed to only while there's a fullscreen application like a game. So "VRR is enabled" likely won't be equivalent to "game is running" in the long term.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
