Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25552C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AF361372
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0AF361372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE386ECCB;
	Thu, 21 Oct 2021 16:25:36 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2296ECCB
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:25:34 +0000 (UTC)
Date: Thu, 21 Oct 2021 16:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634833532;
 bh=eUq94tkjYq1jkLnd5LywzXcEWNB8fqdxcKqzRAZY4p0=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=CJwFy3wf8HXIR2ycGmKgvQVDDbEdtclz3BBKPRPIph+7AnEczAIf7pDhJEKQmtGFH
 /qc/Td+KfHwBAIgbc0rHzeTpQhM3gpVjEn/OZ5i8lMS/r62u/QxA2YaN2Y7TT2WL0E
 cKd6f1nsjvhZArrN9pGLrk1GGtxT6ddadkw9R44Id2vHEgUX9DD20/nuLlAay20Tcc
 ur+9Y756GAFV006rwN0S61ufsauDgrTEol+3nvaLVUOd0noL+UWNOmPH8AWewzOv5N
 ZrbK3T9ZLgZcEGpvecH7wayprZM42RLNif5xNJADQuEOAaAwwPTJHOyTncU25S9qJ0
 Em2qMurbfUwnw==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
Message-ID: <UYRxgu-5B9thqvwg2U8bthxDUHNuXe0BBRyfs1zcBYG1uoBTIPpKmVczt20ZU1wIOFt8tgHSB4-qB98tQ28zcKZ928VF9AUNEpGkOY1b4wQ=@emersion.fr>
In-Reply-To: <20211014153433.169454-1-contact@emersion.fr>
References: <20211014153433.169454-1-contact@emersion.fr>
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thursday, October 14th, 2021 at 17:35, Simon Ser <contact@emersion.fr> w=
rote:

> This reverts commits ddab8bd788f5 ("drm/amd/display: Fix two cursor dupli=
cation
> when using overlay") and e7d9560aeae5 ("Revert "drm/amd/display: Fix over=
lay
> validation by considering cursors"").
>
> tl;dr ChromeOS uses the atomic interface for everything except the cursor=
. This
> is incorrect and forces amdgpu to disable some hardware features. Let's r=
evert
> the ChromeOS-specific workaround in mainline and allow the Chrome team to=
 keep
> it internally in their own tree.
>
> See [1] for more details. This patch is an alternative to [2], which adde=
d
> ChromeOS detection.
>
> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8=
hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=3D@=
emersion.fr/
> [2]: https://lore.kernel.org/amd-gfx/20211011151609.452132-1-contact@emer=
sion.fr/

Alex, are you okay with moving forward with this patch, or do you prefer th=
e
other approach?
