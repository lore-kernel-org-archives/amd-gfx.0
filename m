Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF01C43327
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FCA710E718;
	Mon, 29 Jun 2026 07:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="wKLpvsvU";
	dkim-atps=neutral
X-Greylist: delayed 327 seconds by postgrey-1.36 at gabe;
 Sat, 27 Jun 2026 09:49:04 UTC
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7858710E48F
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jun 2026 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782553743; x=1783158543; i=markus.elfring@web.de;
 bh=VwFrM84IIW0ScsqmzakXCjPu5EYta+yPCspaEM0iIWs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wKLpvsvUnDK50V1qqAFMVKr/U/gKeeDNKUpfp781l1HtEF1HAl3imfj7ZktOlzox
 Shx0jfxtkqGBrlM4211moqPlc4N6GlUIKVrM4CVQtsTe6fFOOuXcA/+u70PjhTuhY
 3bWID2URTAqSMNRnYhOZeuCbxybynNEhhvKGSscgjlanAcNor0ivTra7ikvp21RtE
 dYyTMn2RWxQG2pTZ3ePNPaaqSUSSkzd8P2dF30US5Zetn2XkfvkW+WPQoI6TSG0rS
 QRB+T6pGhLJUDG+wAQHY+8pXoXqRCgFq2p3fvEDIIUUp2/tXcz5cgLxTtYbvtzGyA
 xNz1eBERpv+yaOdZHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Madzi-1x9iBi0XOs-00leV3; Sat, 27
 Jun 2026 11:43:32 +0200
Message-ID: <dcc01255-8c9a-41db-80b8-e4482ec12789@web.de>
Date: Sat, 27 Jun 2026 11:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ziran Zhang <zhangcoder@yeah.net>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20260627092612.5282-1-zhangcoder@yeah.net>
Subject: Re: [PATCH] drm/amd/display: Remove redundant NULL check before
 kfree() in mod_power_create()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260627092612.5282-1-zhangcoder@yeah.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mLO3IeX7+Hca+FJxe+W2jIjNN7bs+PDUcU1XFopa3dzFPqfpkD9
 GOGAegJqZCDGbx1nWbbw6s/FMB4NubPAgyghs4iQf69I21wDju7VwGmkZnIY8etFu21Kvfj
 uBRPAO9u5UXNs7Phy83tllgeHDNmAIcsFo05YjAGbWVpaPGw6tilI8MmvQYLX/hJ0bDaxPG
 z8RtBJ8gCdNZm6DIqRzXw==
UI-OutboundReport: notjunk:1;M01:P0:gWZDnRP0/lI=;guZxT19Rj1hyouMIAzeWXvgA70E
 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
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:55 +0000
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

=E2=80=A6
> +++ b/drivers/gpu/drm/amd/display/modules/power/power.c
> @@ -270,12 +270,10 @@ struct mod_power *mod_power_create(struct dc *dc,
>  fail_bad_brightness_range:
=E2=80=A6
>  fail_construct:
>  	for (i =3D 0; i < MOD_POWER_MAX_CONCURRENT_STREAMS; i++) {
> -		if (core_power->map[i].psr_context)
> -			kfree(core_power->map[i].psr_context);
> +		kfree(core_power->map[i].psr_context);
>  	}

May curly brackets be omitted here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.1#n197

Regards,
Markus
