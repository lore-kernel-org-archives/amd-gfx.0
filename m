Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3890D13588
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 09:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF26A10E378;
	Mon, 28 Oct 2024 09:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=oriole.systems header.i=@oriole.systems header.b="FfcKPbvy";
	dkim-atps=neutral
Received: from coleridge.oriole.systems (coleridge.oriole.systems
 [89.238.76.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6A910E378
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 09:05:22 +0000 (UTC)
Date: Mon, 28 Oct 2024 10:05:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
 s=canary-202303; t=1730106320;
 bh=Gpg77EinHbeOgbpEgideC2qWTa61xKJ6N5zBOuUXwx0=;
 h=Date:From:To:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Sender:
 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
 Content-Transfer-Encoding:In-Reply-To:References;
 b=FfcKPbvyo74xWxcUBd7Ta4U/5yOunuk3HIPPeUQNCYYDuyYZMVFpqRqTeKsb94wHr
 sjNGCRy1NbEM0lHx5APiqgkxjVBJ0vqwFAa/BDRoNutEHSMkiY7qWs21xNAjyM0Y1k
 UdE87Fx5YZA/rUhnuFuNIED1Jdd/A7cnLqkV+JkJGtAx0kFjmO/lMex2faE75uV9PD
 6fB1EQy/BgiNgR2dB0XGcnNSmZvCt5TevilrWx3e3RT6FoXh9oGceJfL4XpkQdED5K
 NHrZ21ncGA6qNDoqowpukwzaz97lduZ7Ak0p9ztfQGOkit4L/6mXXc/uCPl9VZjhqj
 f3sPnuSKskEtg==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/amd/pm: add zero RPM OD setting support for SMU13
Message-ID: <u7ba2md2p5cq3csmzshtxwhutruns7pkovqsfspewsfdt6yrww@ur5azx3cekju>
Mail-Followup-To: amd-gfx@lists.freedesktop.org
References: <20241019143706.18779-1-wolf@oriole.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019143706.18779-1-wolf@oriole.systems>
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

On 2024-10-19 16:37, Wolfgang Müller wrote:
> Whilst we have support for setting fan curves there is no support for
> disabling the zero RPM feature. Since the relevant bits are already
> present in the OverDriveTable, hook them up to a sysctl setting so users
> can influence this behaviour.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3489
> Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> ---
> I've been wanting this feature for a while so today I sat down and had a
> look at how to best implement it. This is my first ever look at amdgpu
> code, so I've marked it with RFC. I've based it on the implementation of
> eedd5a343d22 (drm/amd/pm: add fan target temperature OD setting support
> for SMU13, 2023-08-11) and also hooked resetting the knob with "r".
> 
> One thing I'm unsure about is using PP_OD_FEATURE_ZERO_FAN_BIT for
> FeatureCtrlMask. I'm not sure this is the right thing to use there.
> 
> I successfully tested this on my own system with a 7900XTX; enabling and
> disabling as well as resetting the knob to its default value work fine.

I'd love to see this feature in the driver, so would very much welcome
some feedback on this topic.

Thanks!

-- 
Wolf
