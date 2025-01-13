Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72C1C02183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 17:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E83610E769;
	Mon, 13 Jan 2025 17:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="c7cXP3fR";
	dkim-atps=neutral
X-Greylist: delayed 34975 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jan 2025 17:50:07 UTC
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com
 [51.77.79.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D2510E763;
 Mon, 13 Jan 2025 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1736790603; x=1737049803;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=c7cXP3fR5mLxlHKXOdApExXkzBX9ovBX0r9HBK2WUo1nMcfT1DNpDZrMhe9oK+Lz8
 GwWEWgd6hGJ1NViWTr+5K3JOWpkHbCFlGOlOkuP2iKnclLWOuMOE6cIA7C+GUeuBoZ
 NzbCmg4LSWqdUJQZiFvMHYpzeiPFmmvhAwsUnYkq8qmAnlm07WTqgf0HxlJCsVKfJR
 TSUz86i7fr2PKef4gwz0j/iuvC1yjN6ZMnP2X2NMbunI2CNGbp+mbQp8SwPfuOiZHE
 +ox6FHyCK5UVS/4vzURjyXAKjmVtOmSmgrCsMU9b3yderZ65+OzVm6LovcWFmo4pia
 tsqexFft3KsOA==
Date: Mon, 13 Jan 2025 17:49:58 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 09/45] drm/colorop: Add BYPASS property
Message-ID: <GLU-IG3JEzIdQqmDxAwhuMpP-ETTYkVBCzQk3nyjEkjJFwoB_gODNd_VeNF5viGDoUBCOXTgQ1Z8eDjVSqq2oQ7U7QKihx1N300q17dbDrw=@emersion.fr>
In-Reply-To: <20241220043410.416867-10-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-10-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 70ff4f333a1da35d24b3ab5cdd2037a335b02111
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Simon Ser <contact@emersion.fr>
