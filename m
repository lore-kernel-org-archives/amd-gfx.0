Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F856C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9260464F9D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9260464F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kam.mff.cuni.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5305C6EA1E;
	Wed, 10 Mar 2021 14:13:07 +0000 (UTC)
X-Greylist: delayed 316 seconds by postgrey-1.36 at gabe;
 Wed, 10 Mar 2021 13:07:44 UTC
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98C989DEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 13:07:44 +0000 (UTC)
Received: from [192.168.15.1] (koleje-wifi-0044.koleje.cuni.cz [78.128.191.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ledoian)
 by nikam.ms.mff.cuni.cz (Postfix) with ESMTPSA id 78B622803F4;
 Wed, 10 Mar 2021 14:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kam.mff.cuni.cz;
 s=gen1; t=1615381344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=un/5UZjRn4gYkqxFK4G17AulEHU5k9ci4WXFFPWHjoQ=;
 b=K4xAU1iZrZNpABwJVPeCRAfO7zLa4L25NhBRbU/d/KmxS6Msg4kQ3TH3Lf3vYVjhcehID9
 ewnhwDrg7k7KEZ8msPyGjHfuomaJlOlsBZBxjQio5wjdnotpNgk/I9qvFoaNLi+DP1hM4t
 fSM7zLLhVmdvaLvZwDPPBU99vo0EOlg=
Subject: Re: [PATCH] drm/gem: add checks of drm_gem_object->funcs
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20210228161022.53468-1-ledoian@kam.mff.cuni.cz>
 <e7f0747c-cb10-692a-aa36-194efcab49ef@suse.de>
 <CAKMK7uEMgV=EN7EJh6tzpP6b0x4MX1on9Xoz_zACZVyMK-+QyA@mail.gmail.com>
 <5bd3c672-3277-69b5-27ca-898c8cb79f9e@gmail.com>
 <CADnq5_MyLatUasyU0W9_zQDSrkzfe96NP0YHkom6tthZzf3yvA@mail.gmail.com>
From: =?UTF-8?Q?Pavel_Turinsk=c3=bd?= <ledoian@kam.mff.cuni.cz>
Message-ID: <d6e92dd9-4ffe-0e5e-2bc5-d424dc464e6f@kam.mff.cuni.cz>
Date: Wed, 10 Mar 2021 14:02:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_MyLatUasyU0W9_zQDSrkzfe96NP0YHkom6tthZzf3yvA@mail.gmail.com>
Content-Language: cs-CZ
X-Mailman-Approved-At: Wed, 10 Mar 2021 14:13:06 +0000
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alexander Deucher <alexander.deucher@amd.com>, stable <stable@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 08. 03. 21 20:20, Alex Deucher wrote:
> Should be fixed here:
> https://patchwork.freedesktop.org/patch/423250/
> 
> Alex

Thanks, it works for me! I tried only the first patch from the series,
the rest didn't look relevant to me. I can try that too.

I didn't test it thoroughly (I don't know how), but the issue with being
unable to start X.org is gone now and the kernel doesn't complain.

Pavel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
