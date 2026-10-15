Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3453CCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779B710E2C7;
	Thu, 15 Oct 2026 19:36:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2448112471
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:36:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65D9443B7E;
 Thu, 15 Oct 2026 19:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC241F000C4;
 Thu, 15 Oct 2026 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792092984;
 bh=MXbE0S84Pxgj58dLgX8b3AApI7R+Js1Kyotp00jdfS0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pg7Am4qN4mYTvQ5JWpTGk4dpHowSOQVCOpot2yjDg99YdYg+VK/HMpdQ3EUMejUFq
 6lzOPN3r2L1iG0GxNhb/OjLA7PEhbfhKZR2aWMQimWsIxNnHGHs91wj0N5823aUY7A
 F7foBLP+abbTuRsjtaLMS5JcCFrCSIprlWPhK1pPrcAmUSJYyJ22l+Cs58bBS46jn+
 jzyi2iVCPljSZE9sQXO3dCeaT+IV7fpk0FpmGlvm/VC7du45OaFXREgIefiHwjcOZ8
 M1pENK6Z0rxBHzc+TGPnU/sl4vDrZpVXabeylaagAcGPOzsSe/p55auVSgVrYauaDT
 LbrNdSqjaesjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Jerry.Zuo@amd.com, harry.wentland@amd.com, mario.limonciello@amd.com,
 mgorny@gentoo.org, Miguel Mesa <miguel@miguelmesa.com>
Subject: Re: [PATCH 7.2.y v2] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Date: Thu, 15 Oct 2026 15:35:46 -0400
Message-ID: <2026-10-15-1-daily-reply-0003-amd-display-420-only-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014153914.275253-1-miguel@miguelmesa.com>
References: <20261014153914.275253-1-miguel@miguelmesa.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> right after login. v7.3-rc5 selects 4:2:0 again for those modes when the
> color format is automatic. Do the same here, including HDMI FRL.
>
> Keep automatic YCbCr 4:4:4 for the other HDMI modes, as 7.1 did. The TMDS
> depth fallback also runs for HDMI FRL, so a mode that does not fit at
> 4:4:4 can still drop to 4:2:0.

The first hunk, which drops the force_yuv_pixel_format check for 4:2:0-only
modes, is the right fix for the black screen. The other two are not.

Automatic YCbCr 4:4:4 is not what mainline does. 106b4a2a78b2
("drm/amd/display: Try RGB before YCbCr 4:4:4 in stream validation"), in
v7.3-rc6, deliberately went back to RGB first. Running the TMDS 4:2:0 fallback
on HDMI FRL links changes behaviour on links that are untested.

Could you send a v3 with only the 4:2:0-only change, keeping the FRL clause?
Please also get an Acked-by or Reviewed-by from an AMD display maintainer
(Harry, Leo, Alex or Jerry) on the list.

-- 
Thanks,
Sasha
