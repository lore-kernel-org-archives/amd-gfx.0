Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EE0C25B08
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621D8B947E;
	Fri,  5 Aug 2022 17:37:59 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C53B908E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:34:30 +0000 (UTC)
Date: Fri, 05 Aug 2022 17:34:09 +0000
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="DlUU02jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1659720863; x=1659980063;
 bh=priJFn7qK+yM87mvuBLEITz2RaXR3j5nFbOnFoiDhEI=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=DlUU02jYlmuBZREPFdIODi8MNy6s7oSefMWQlCjpd5p2O4n+PpmWPv5/5TQWNGKr+
 wDLh8zImlWfNPLAqVel1ZSqaNoOPSheW8Uq18a5Y9jZXjlUeewTyrmrppaYLLPlSkK
 ek7mHxzzrTR4c7YMDXd+GsqkwQkPleZdiHLmXm6L4l2K9xcudxMm8ByObkay2vJthC
 dNaF/XAthBm5xnRiGB5Mr0bRs6oR+pRsdUsPehw93kDQApfi3uhwJZTnVFoEDo5xPR
 3Ln8eeTc/sFtzx9N7iDMQh6d3qvDKotGoIK/ldCbAlm5qRq7NvBANPv7Vj3xffmEwJ
 3MYpOi+bPdeqw==
To: Melissa Wen <mwen@igalia.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: set panel orientation before
 drm_dev_register
Message-ID: <xI-NVvuRaXc7nwH0mpaawuQCjch9XHttx_WHUdA449IE17gUq2QxChCzWZTV6v64fItGWakt4KnFAEOwVX4ILsh947KphoLyrwID2g3gcAI=@emersion.fr>
In-Reply-To: <20220803162952.odxi24tb6krgt42n@mail.igalia.com>
References: <20220803162402.3412968-1-mwen@igalia.com>
 <20220803162952.odxi24tb6krgt42n@mail.igalia.com>
Feedback-ID: 1358184:user:proton
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
Cc: Leo Li <sunpeng.li@amd.com>, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.cornij@amd.com, Hans de Goede <hdegoede@redhat.com>,
 Sean Paul <seanpaul@chromium.org>, kernel-dev@igalia.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Have you seen [1] and [2]? CC'ing Sean and Hans, it seems like there's
a disagreement regarding probing early vs. setting the initial value to
UNKNOWN.

If a driver doesn't fetch EDIDs before exposing them to user-space,
then there is an amount of time where the connectors are exposed as
CONNECTED but their EDID and mode list isn't properly set. But maybe
that's what the GETCONNECTOR IOCTLs is supposed to do: probe the
connector, fetch its EDID, return the proper mode list. So maybe
drivers shouldn't probe early and should let user-space request probes?
In which case we could create the panel orientation prop with "Normal",
and update it accordingly when probing.

At any rate, I've tested v2 on the Deck and it works properly.

Tested-by: Simon Ser <contact@emersion.fr>

Thanks,

Simon

[1]: https://lore.kernel.org/dri-devel/CAMavQKJUpYP8jo2JDGMYNBGtbPSSO7z9BAC=
omm5JQoty=3DHPtJg@mail.gmail.com/
[2]: https://lore.kernel.org/dri-devel/20220530081910.3947168-1-hsinyi@chro=
mium.org/
