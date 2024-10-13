Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A66CF2579
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Oct 2024 15:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE59410E35E;
	Sun, 13 Oct 2024 15:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="UzinH7BK";
	dkim-atps=neutral
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5585110E1D0
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Oct 2024 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1728832612; x=1729091812;
 bh=4Ka4WXN0N5d5+vx51WtE9dkbDZkLmYxFPeUK4Fs1qMs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=UzinH7BKzhKhZGDcIkpc76lWyZYjnJx+ni3eWRNOAVTGKGdCM5xa301TSYI4YXsuO
 E5EYqdd4TbrwMrZ2+JKhafr2ne1OyBX6AvKtPTVjyLNbeJ9fwykbTl1ZIl/3pKeGr/
 APVrHe8irIfQxuQc54cxG2ROAenRrHTERGMMVCTU/x8Ok/uj+DvvUdzjh3dJ/sQ1/H
 KEpyiGywaHFhWkJf92vsdotGu+7O3kihfx9h6z1ej1puMzEJHXDQ/nreeQVaexu0vt
 2IGJGgwVUDFIctJEipwDtGwpFJM2wXQn1INo4CETm2Kb05MEZUl913QQzGZJQ2QNUe
 TfZdvfHZf+lJw==
Date: Sun, 13 Oct 2024 15:16:47 +0000
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 13/44] drm/colorop: Add NEXT to colorop state print
Message-ID: <Ni2okIqR4shuoln4Q2B0dSc6dC0W5rDdZ0g8SPbIRMm22zMPU8hsQrnM1eb6G_ZB-Lke9R8VSR4mpg_NKiIu7yyMWyUlUjBgeFWjDZFOAN0=@emersion.fr>
In-Reply-To: <20241003200129.1732122-14-harry.wentland@amd.com>
References: <20241003200129.1732122-1-harry.wentland@amd.com>
 <20241003200129.1732122-14-harry.wentland@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 5461abcf7c839d07f99384da82d65c0fc7a08bea
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

I think this can be folded into "drm/colorop: Add atomic state print for
drm_colorop".
