Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F09EC7EE22
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 13:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42CC10E1B7;
	Mon, 15 May 2023 13:04:56 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313C510E1B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 13:04:55 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QKfjD11sHz9sZF;
 Mon, 15 May 2023 15:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1684155888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aReNDZORAsT9vC55Sza0lixh/dFu7bUAxE370evU9U0=;
 b=HSExI2TLDxPazFnZAhnKWQUKsI6/VM6N+LUj1nR7G4Y7GRJ6gfBbOk0RF06aColi9xPiBa
 /U/Z1KcwTbjQVNFIwxzbB7jsVd28JkDLRx/6kDpAsD0MmBQ76sasbnfF7UjVXE9++vChoi
 xtWF6odERRxAzWeNS71fwHdE7e2pCu9R+6ckEDKfYPcgP1qN5lm0mOe5CKjbgBrW1kTjSx
 FrkhdrEpzvkaQo/r5pecksfU6TV7Jg7Hz+P9IU2N2XVmg4qFw7cvDVuVZTmDRtOB+JQ9/Y
 oiaR4fLB7SbbHAtblk6utPSe3Kxcrc9ULpFftEnT4Az7zBQkXUn/ElwbCAmWdA==
Message-ID: <bc4d10f2-6ded-bed3-1d81-7e09292adf6f@mailbox.org>
Date: Mon, 15 May 2023 15:04:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH AUTOSEL 6.1 4/9] drm/amd/display: Do not set drr on pipe
 commit
Content-Language: en-CA
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20230511193945.623476-1-sashal@kernel.org>
 <20230511193945.623476-4-sashal@kernel.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230511193945.623476-4-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yjitohq9diod3ii4o71ztepm4eueahaa
X-MBO-RS-ID: 14971900af013488b0a
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
Cc: felipe.clark@amd.com, Aric.Cyr@amd.com, wenjing.liu@amd.com,
 dri-devel@lists.freedesktop.org, Jun.Lei@amd.com, airlied@gmail.com,
 jiapeng.chong@linux.alibaba.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com, Alvin.Lee2@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, mwen@igalia.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Dillon.Varone@amd.com,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, qingqing.zhuo@amd.com,
 Xinhui.Pan@amd.com, daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/11/23 21:39, Sasha Levin wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
> 
> [ Upstream commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be ]
> 
> [WHY]
> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
> pipe commit can cause underflow.
> 
> [HOW]
> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
> optimized_required.
> 
> This change expects that Freesync requests are blocked when
> optimized_required is true.

This change caused a regression, see https://patchwork.freedesktop.org/patch/532240/?series=116487&rev=1#comment_972234 / 9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net .


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

