Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B73C3ABD4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 12:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39E110E3ED;
	Mon, 12 May 2025 12:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="GC5wlGEg";
	dkim=pass (1024-bit key; secure) header.d=nordisch.org header.i=@nordisch.org header.b="AdMM4hNg";
	dkim-atps=neutral
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59D410E3C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 12:23:57 +0000 (UTC)
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
 by tengu.nordisch.org (Postfix) with ESMTPSA id A7D7E75B78A;
 Mon, 12 May 2025 14:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_ed25519; t=1747052635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8sGhJv23kMs+kISWcYgOzjBGMG++Hyi5fvZuvbmDB8=;
 b=GC5wlGEg7snkLYqnFRiQEt02L24hnUuSbfQeNEnPt071PoaqwxgQrFfF3a+rNRp4mMuMYN
 CLU7IJhW8wpih6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_rsa; t=1747052635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8sGhJv23kMs+kISWcYgOzjBGMG++Hyi5fvZuvbmDB8=;
 b=AdMM4hNggD8l7vuoayXUNewtAjHzh7qrBAZmUJgM9sBjsFi1z/P7Rvm1t2d17uxDEyX0fM
 YWszhWpneWZuI39ByEsKnywKQQEh+4GdL8AKkbtnjSc51QW2WOnDfjWi7lqykSgHMQcs5a
 2eBMLuckd8Hkht1vG4Q5NiMZmgUp0so=
Message-ID: <45fc722f9b113fe32d29c5f45466b41faff34a59.camel@nordisch.org>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <amd@nordisch.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Date: Mon, 12 May 2025 14:23:55 +0200
In-Reply-To: <6023ab4f8c490594a882704fa0e1afeb076c2ad2.camel@nordisch.org>
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
 <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
 <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
 <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
 <6023ab4f8c490594a882704fa0e1afeb076c2ad2.camel@nordisch.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 12 May 2025 12:44:26 +0000
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

I opened a video in clapper to take the browser out of the equation and
started working in a terminal. -> kernel oops. will look into setting
up kdump.

Mesa-25.1+git1019.7c4f501e9-39.1.x86_64
kernel-default-6.15~rc6-1.1.g42f9fa3.x86_64

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.


