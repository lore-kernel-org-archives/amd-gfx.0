Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEC060F92
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FEC060F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3DE6E820;
	Tue, 12 Oct 2021 09:30:12 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FE36E820
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 09:30:11 +0000 (UTC)
Date: Tue, 12 Oct 2021 09:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634031009;
 bh=eWStb7nPutgDWBdNm2x4K/JSDIu6EAFpb+Aw2ZYeC3Q=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=hZg+sZKYA+u/Aj6Fl4ZvZE1X5W0lyuHOftbgP0k8SJ6/jC1tDPwUwcY8ee5hUvPk5
 FSwk/+zKUWrjEpnIrsHaYthpHpkI+EIasO8UH0hR/1DZG+98eOO8qQuyBX8Mv8lgOW
 rmdF5+JfJ2C5G72qpaYbEEvH0+F1AzBeIDMsPwI4CnJ2xZygIhGEleKYUf8zxzPUTL
 ziJ8HeD5qDMMgpXXW5b2EduYor62fEwLhWvaZO0lSjuCDwvDn6GuwiTVyOAu7jVO1p
 WJ1DEHLr+5Foj5+3+lxVF1U6ZvQI5rIrxiROLLv2CZ2sbv1NBmXtExbU1imHs3oB/3
 bJWZUMwhwjBPw==
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
Message-ID: <jifB9-c-aPA8TwF8vvsAEZXzXzEyZA62B4vfCCFx7sTY4x401jRFHCLupo_ww0ByEFoqPg2OnrUj97w3u21oHaH3b_-0Fv_MN7FlESvbWmU=@emersion.fr>
In-Reply-To: <b364ab7a-96e7-6165-f616-908b333e7117@molgen.mpg.de>
References: <20211011151609.452132-1-contact@emersion.fr>
 <0ad9c8ef-974f-8b94-d8c9-35efd9f1f1b3@molgen.mpg.de>
 <L-g5Eua556aLUOp3ikTg8s3Te9CMSKsDoO14SNj3-A7yn0jRNgzGovqdBFKgpKavD_LtHh6Yeig8FOO_kLG9uCcFxP5887tZWH3NROlQtyY=@emersion.fr>
 <b364ab7a-96e7-6165-f616-908b333e7117@molgen.mpg.de>
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

On Tuesday, October 12th, 2021 at 11:24, Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> Thank you for the explanation. Then I misunderstood commit ddab8bd7
> (drm/amd/display: Fix two cursor duplication when using overlay) from
> the Fixes tag, as commit ddab8bd7 does not mention Chrome OS, and also
> does not carry a fixes tag.

Yeah, that commit message isn't 100% explicit, but "some userspace" means
ChromeOS. See also e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay
validation by considering cursors"") which reverts a patch relaxing the
checks introduced in ddab8bd7, and mentions ChromeOS explicitly.
