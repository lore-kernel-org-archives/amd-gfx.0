Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB817CD6E72
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C890113CFB;
	Thu,  4 Jun 2026 07:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="Jz955fD8";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C7111208B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1780503735;
 bh=wGxgAQwcjweBt1joUDz6N7yOUq13v1bmpae5T1zCRVU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=Jz955fD8YsMTRnyLCPRjrx2VocqPW6P2sKxDJA/F5zbGSVGa1j7c7oSe3shqwYz/G
 KN/xwJ+z9vwwmtHIlOdtZQlvdta3GDdBx25ToSIFeeNJywqmCvoEOEosSOQFbBbQgE
 bykQbPRO6hvMyRw/ujp/egqZ8CX6bg4Zz4IN+LHM=
Received: from [127.0.0.1]
 (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com
 [IPv6:2607:8700:5500:e873::1001])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id 8B92E65987;
 Wed,  3 Jun 2026 12:22:14 -0400 (EDT)
Message-ID: <56ddd82d81e14d5b14247e2066955bc21223951a.camel@xry111.site>
Subject: Re: [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Date: Thu, 04 Jun 2026 00:22:12 +0800
In-Reply-To: <20260603105137.drm-amd-fpu-guard@kernel.org>
References: <20260527144428.1095001-1-xry111@xry111.site>
 <20260603105137.drm-amd-fpu-guard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:56 +0000
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

On Wed, 2026-06-03 at 11:13 -0400, Sasha Levin wrote:
> > [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
> >=20
> > As the mainline already contains the move of FPU guard which should
> > ultimately resolve the issue, it seems better to just backport the
> > final fix instead of adding the temporary ad-hoc change back.
>=20
> Thanks for the series. Unfortunately it doesn't apply cleanly to
> 7.0.y.

Rebased onto 7.0.11:
https://lore.kernel.org/stable/20260603153920.249671-1-xry111@xry111.site/

--=20
Xi Ruoyao <xry111@xry111.site>
