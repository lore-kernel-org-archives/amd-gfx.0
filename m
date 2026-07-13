Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2DFC44508
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6689610E9A8;
	Mon, 13 Jul 2026 13:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="tG5pJQmJ";
	dkim-atps=neutral
X-Greylist: delayed 530 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jul 2026 12:53:02 UTC
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5994210E5B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:53:02 +0000 (UTC)
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id A053D72115E;
 Mon, 13 Jul 2026 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1783946649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgEj+hlesutO2TABPDrMbzeDDerE/w69AflsWMTTjFk=;
 b=tG5pJQmJMVcorEJaatwv338gJ9+qLJ5wwIm6eaS5yJyTgxuKxutGr3z6Iv2gA32reIAhFz
 GxDJsgmA8heVA3N72c2vRjr8zbnK9MkSULrREYdJkZkUloDYkO5pB3CsxoLyw3/Al9cpYJ
 pBu8hxC0GPyZGxxQC66mHKtSgwnGZwM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1783946649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgEj+hlesutO2TABPDrMbzeDDerE/w69AflsWMTTjFk=;
 b=TPPywwcTKTenOWCYEr6w/L8ZXVGtNbH/WA+32mrZEr0GsC0VVWf5svUHu4ZGk41X6tcg+1
 DtxKUTXizgVLqpmUtlxlbW04fpTrsxNl2HB1TiShfLfglU85gAlnRdVWIcHRjCY9q+QPQG
 iLnExxSww6LhfYIJo6o3bNDVg9WNhs8=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=lionso@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1783946649; a=rsa-sha256; cv=none;
 b=pznrM5Ej2MwpfGVZEkZ1uPI4xcHDdYfSaDFXWaahnqPDViavnjRyOrvIE+T3pvtd5ra/1W
 lSKYCG0iqDbnu/sMl2ZfsDMsIV6z5IqbHMux7nJeYLqPk9mBqcfSUPR0hxO9LWLX9Q1Yb3
 lwSTEiuLphyQW8HMZtmL0mps7oXpsNQ=
From: Lionso Alejandro Pacheco Vacacela <lionso@murena.io>
To: Timur =?utf-8?q?Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix preferred link rate for NUTMEG
In-Reply-To: <2230825.9o76ZdvQCi@timur-max>
References: <20260529090909.13206-1-timur.kristof@gmail.com>
 <178379850751.8410.12007342378134020217@murena.io>
 <2230825.9o76ZdvQCi@timur-max>
Date: Mon, 13 Jul 2026 07:44:05 -0500
Message-ID: <178394664580.29425.7247796926102969641@murena.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Jul 2026 13:09:32 +0000
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

Hi Timur,

On Sunday, 12 July 2026 19:44:31 CEST Timur Kristóf wrote:
> Thank you for the testing!
> I would appreciate if you could verify that the second patch also
> works well.

Happy to! I applied both patches (1/2 and 2/2) on top of v7.1.3,
rebuilt, and re-tested on the same machine (A10-7850K / MSI A68HM-E33,
VGA on the onboard output). With DC enabled the NUTMEG link trains, the
CRTC comes up at 1360x768@60, VGA output is back, and it happily
survived a bunch of reboots. dmesg shows "Display Core v3.2.378
initialized on DCE 8.1" with no "enabling link failed" this time.
Nice to have this old box on DC at last.

So for 2/2 as well:

Tested-by: Lionso Alejandro Pacheco Vacacela <lionso@murena.io>

> As far as I remember the regression hasn't made it upstream yet when
> I made the fix, so the hash didn't exist in Linus's tree yet.

Ah, that explains it — makes sense. It has landed since then, so it's
really just a matter of refreshing the tag. In Linus' tree the commit
is:

  a62346043a89 ("drm/amd/display: Fix coding style issue")

and it's an ancestor of v7.1.3 (it shipped in the v7.1 release), so
pointing the Fixes: line at that hash when the fix goes out should let
the stable tooling pull it into 7.1.y on its own.

Thanks a lot for the quick fix, and thanks Alex for picking up the 7.1
backport — much appreciated.

Best regards,
Lionso
