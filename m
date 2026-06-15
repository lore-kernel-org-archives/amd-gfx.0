Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F044CCD98E2
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6097110E2A5;
	Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="T0Gb6UN/";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC8310E158
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 01:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1781488380;
 bh=u3Aiw4YiS8VJikbLRVI5zqBMF0/XbmAbla4ft/2zHAk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=T0Gb6UN/q9xz/iMZo3+zY/Txk007UjbdC4u0yiV9sobWiRpCeeqrgJEvuY+KTDFyN
 7wNpGBOydnLqeqAz/XvOHQ4aj0B+Khe9TY0fAcxqQwXJiCwwUlIidmsDXrmamJSvZB
 ySPHM/R7ZLSAZSFWNPvhrPUwrPSOXnDIuwXSVocQ=
Received: from [IPv6:2409:8a4c:e12:98c1::376] (unknown
 [IPv6:2409:8a4c:e12:98c1::376])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id F223165982;
 Sun, 14 Jun 2026 21:52:58 -0400 (EDT)
Message-ID: <e7026309150cd147be874d2521dbc17fe0ecb1e8.camel@xry111.site>
Subject: Re: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML
 to DC
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Date: Mon, 15 Jun 2026 09:52:52 +0800
In-Reply-To: <6fff98f69549a9069321a727f2333d3e4aa5e84f.camel@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
 <20260603210831.item005@kernel.org>
 <6fff98f69549a9069321a727f2333d3e4aa5e84f.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:22:58 +0000
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

On Thu, 2026-06-04 at 11:46 +0800, Xi Ruoyao wrote:
> On Wed, 2026-06-03 at 20:05 -0400, Sasha Levin wrote:
> > > [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to
> > > DC
> > > Rebased onto 7.0.11.
> >=20
> > Thanks for the series. Unfortunately it doesn't apply to the current
> > 7.0.y tree: patch 3/8 creates dcn42 resource files that don't exist in
> > this tree, and patch 5/8 depends on dml21_wrapper_fpu.c, which is not
> > created in 7.0.y either.
>=20
> dml21_wrapper_fpu.c is created by 4/8 (upstream commit
> 4bb2f0721ed8a2a70f864b9358bd6cd4d92199b3) which moves out the logic
> requiring FPU from dml21_wrapper.c to that new file, so the remaining
> code can safely use DC_FPU_{START,END}.
>=20
> The dcn42 files should be removed.=C2=A0 I'll recheck if the series conta=
ins
> anything related to dcn42 and remove them in v3.

Abandoned considering 7.1 is released and 7.0 is not LTS.

--=20
Xi Ruoyao <xry111@xry111.site>
