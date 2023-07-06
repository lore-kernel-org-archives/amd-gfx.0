Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8126EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 10:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C60510E4C1;
	Thu,  6 Jul 2023 10:06:06 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3BC10E4C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 10:06:05 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QxXGx298Nz9sxL;
 Thu,  6 Jul 2023 12:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1688637961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+TPcpztsdR5aTfbKMwSk4AYd7azueygVG2NMRcZzm4=;
 b=CZTMiHuLJnEet6mm5B2Okb7nXPFghx5rYOqGZcJFrclANa0z/vaqGTK3VUCJ/Iw2i4Cmhp
 ENCP6sWtGYVvSNlGLNLD7Hejq6+lAinTJRp/MEioh5iYO2eRP1E6hZZ5z28MHgClQt5Uny
 GXo/RdGqUF/9DZXpFk1XVkQ6m9srPh2rDk2i3OWkOLfJpxPOcwgIwbjR+ChLAvyIaG/Boh
 5bc29vC78VwUnODhFDXNyj+JHhz2lrhUDrDfvX9HEWNitUDkniM8cjnSrLbdLYSjp/wlEv
 ABHUlpN3ND1Vlit0BzoR1sxwt2gRUA0juluki6acTzbUMC3UoafXNNWZnoopDQ==
Message-ID: <dc331ebc-7032-033a-0076-b80472920e79@mailbox.org>
Date: Thu, 6 Jul 2023 12:05:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Content-Language: en-CA
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 969a76fb3653ebc5c25
X-MBO-RS-META: foxtese1k8ikcqe1tadmj8hes7cdtoc1
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, hamza.mahfooz@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/5/23 20:07, Aurabindo Pillai wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
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
> 
> Fixes: de1da2f7fe25 ("drm/amd/display: Add monitor specific edid quirk")

Seems like inappropriate use of Fixes:, or how does this commit "fix" the referenced commit?

(Also a bit surprised to learn about that one only now, and that it landed without my confirming it actually works)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

