Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61D5C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 10:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8901010E35A;
	Mon, 23 Jun 2025 10:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="PE59Ds7I";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZp70wh1";
	dkim-atps=neutral
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Mon, 23 Jun 2025 10:51:09 UTC
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC9810E35A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 10:51:09 +0000 (UTC)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 29E0911400FE;
 Mon, 23 Jun 2025 06:46:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 23 Jun 2025 06:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750675567;
 x=1750761967; bh=m5CkggPpUVWXjp48bzk3LHYRCzb1DoKBlUfDRNQ2rj8=; b=
 PE59Ds7ItAEnHG5ITeAsdEr0Gwn5rpFdAlefqkZZpC+jOblNese/2iAUmMQQi32Z
 693g+ATvmK50wGsfnWR8bGM4M6KTgdQ8FSJ3I4oeqz+//nJDdtBpFuQFopMHP27K
 IIFgEEBXMGXiHIZ773qdIqjqRq6FlcO5BhozHeM/N5RC1Vknh+iRrzDDlHeHr63S
 uthEdJ85uf8G8fDb9FIRWuwS96iwglIDM251DcufSQyDuJZTl6Huf1lCbPoASYrJ
 3LFlmJ3x7dMeirnOERQiYaQgwnISZMrRZH8F2XrR8ut2C/4wTONNDZENX6Ea8sYC
 eAu9Ct4/Lws5pVIRVtM6yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750675567; x=
 1750761967; bh=m5CkggPpUVWXjp48bzk3LHYRCzb1DoKBlUfDRNQ2rj8=; b=d
 Zp70wh1f/CMKG4KO+j6kP4NtYYUJdx8GLYry5bbZ6OGgIuu3scFRrWyC8BMabiLE
 GJIV4yqrnepfAZkAGkur2JuzVQbz2yLCNq9/QfWFee/9t93HfvXDxuWVjQQmWHYg
 SRgi47eTsagQbkumz8fTRjVgWnpyZVEaeNQ5AynYcNcNImwb7snGaTGlFUdos+CS
 XP4o0ZibdnGxfsAbK1Q12j0HpYB0TKL1HcKKIo/p17NlRPoOMhYwTGUSSM+hChU/
 An+/bFgosbZd2pKFTtxOf+RagGmF5c4OBXazwsdANcUqhPugdkkYz7dgRm+uay8t
 /5rfRW6RSG9v6wHEdpJvw==
X-ME-Sender: <xms:bjBZaC4vPzHgCZ3twAEMg4ui9EDwi85Jk7_cdsQaR5MhxBu3Fo48aQ>
 <xme:bjBZaL6GqGabUL52rorU_TIXY8xh41YuZpLmHI9EGjy26cs2G8hQJ5wlHqqV7fN1h
 2JoZd7aOvLJabOSI0I>
X-ME-Received: <xmr:bjBZaBdrWBGdtojEx-4dSKPXeVjZfcXq6zloD2FdiKYJO9qT2bTluGx1T608HAQQLjW1zMfYeyw-lI3OCwkuhzf3oLlOuSz_MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieekvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhrihhs
 thhophhhvghrucfunhhofihhihhllhdfuceotghhrhhisheskhhouggvheegrdhnvghtqe
 enucggtffrrghtthgvrhhnpeeijeelkefhudekueekvdejtdeuueelteegvdeuveettdek
 jeekiedugeegteevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpegthhhrihhssehkohguvgehgedrnhgvthdpnhgspghrtghpthhtohephedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhisheskhhouggvheegrdhnvg
 htpdhrtghpthhtohepkhhouggvheegsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghm
 ugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhope
 grlhgvgigrnhguvghrrdguvghutghhvghrsegrmhgurdgtohhmpdhrtghpthhtoheptghh
 rhhishhtihgrnhdrkhhovghnihhgsegrmhgurdgtohhm
X-ME-Proxy: <xmx:bjBZaPKu88JTUsUPF10P8L8fR3FBLkbWNi88OefBLjt6skzp984DEA>
 <xmx:bjBZaGKtSlCpE93EXTgBIY0_VeN8hB-d2Jyfj_IlDrac9rr7zRqs1Q>
 <xmx:bjBZaAx70JpPXqigjiGCfzWfFmtzQUGRtrTX_d2RkV2nTqXQSgN6uA>
 <xmx:bjBZaKK9_oKqOqnevoamjkfGas4KIqE9W4L4LvDBcEUKPgEgnVKNQg>
 <xmx:bjBZaMuG9clQnzsvL9E5JGE6gUplIIlYyYupkE19dUIJKKGBg49X5PoT>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 06:46:06 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 03:46:05 -0700
Message-Id: <DATUOZZD8316.2INSL3KL5RA80@kode54.net>
To: "Christopher Snowhill" <chris@kode54.net>, "Christopher Snowhill"
 <kode54@gmail.com>, <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
From: "Christopher Snowhill" <chris@kode54.net>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619125507.54384-1-kode54@gmail.com>
 <DARA1U86AS72.QOIEVZWCFPYC@kode54.net>
In-Reply-To: <DARA1U86AS72.QOIEVZWCFPYC@kode54.net>
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

On Fri Jun 20, 2025 at 3:10 AM PDT, Christopher Snowhill wrote:
> Here's another alternative change, which may be more thorough. It does
> seem to fix the issue, at least. The issue does indeed appear to be
> no-op plane changes sent to the cursor plane.
>
> If anyone wants to propose style changes, and suggest a proper commit
> message, if this is indeed a welcome fix for the problem, please let me
> know.
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index c2726af6698e..b741939698e8 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1087,17 +1087,22 @@ int drm_atomic_set_property(struct drm_atomic_sta=
te *state,
>  			}
>
>  			/* ask the driver if this non-primary plane is supported */
> -			if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
> -				ret =3D -EINVAL;
> +			else if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
> +				ret =3D drm_atomic_plane_get_property(plane, plane_state,
> +								    prop, &old_val);
> +
> +				if (ret || old_val !=3D prop_value) {
> +					ret =3D -EINVAL;
>
> -				if (plane_funcs && plane_funcs->atomic_async_check)
> -					ret =3D plane_funcs->atomic_async_check(plane, state, true);
> +					if (plane_funcs && plane_funcs->atomic_async_check)
> +						ret =3D plane_funcs->atomic_async_check(plane, state, true);
>
> -				if (ret) {
> -					drm_dbg_atomic(prop->dev,
> -						       "[PLANE:%d:%s] does not support async flips\n",
> -						       obj->id, plane->name);
> -					break;
> +					if (ret) {
> +						drm_dbg_atomic(prop->dev,
> +							       "[PLANE:%d:%s] does not support async flips\n",
> +							       obj->id, plane->name);
> +						break;
> +					}
>  				}
>  			}
>  		}

Upon further testing and reflection, I have come to the conclusion that
this is indeed best handled by a kernel fix, rather than breaking user
space.

I attempted to work around this in wlroots, adjusting 0.18, 0.19, and
0.20 git with similar patches. First I attempted to stash all the
written properties for the atomic code, storing an initial value of all
0xFE so it was always likely to write the first time, and only setting a
property if it changed from the last commit.

This resulted in whole commits breaking for one or both framebuffers
until I ctrl-alt-fx switched to a tty and back again, and this would
work again temporarily.

So I went back to the drawing board and only withheld seemingly
duplicate plane properties. This "worked", until I attempted to play a
game, and then it started glitching spectacularly, and not updating at
all if the game was doing direct scanout and vrr.

Clearly this is wrong.

The wlroots library queues up properties for each commit. On every
commit where the cursor is disabled, it queues up both fb_id=3D0 and
crtc_id=3D0. Every commit. Is this wrong? Should it only be queueing up
the disablement properties once? It also queues up the full plane and
hotspot properties when enabled, even if the cursor doesn't change
position or appearance.
