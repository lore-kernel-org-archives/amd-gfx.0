Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C6FE9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 22:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F8610E627;
	Wed, 18 Feb 2026 22:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HO8IrBrn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0183F10E633
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 22:06:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B05961858
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 22:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C9AC19425
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771452411;
 bh=d0ECnb6E6NAjc35rk9eRekKo/IkQKEj1Ixpf/eUHjk8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HO8IrBrneAmxNTjOYLeEWMjdasEXwmMFxYm0imQf+s2RP4m9nU3kiXklACP8flaL6
 a9dY1PPaqKP4Y62SEgkLpUkRgvUVgvbvgkhHZAXKmGouiJOipQdKEfQ/PCL/Hd/D+8
 MaWK9CkPZQl52iWBXzTJRYBuyDO/RSq2KCT1XLx6odGCtU49ppSsZXEBlRIpkdeCXY
 Rs1TGfPkLThFHZBr4C//KoJ+S8Deng4ZmlNRA1TnIPiRalfZzgZ5Ku2u/p0PBoBOhp
 oSHCoaeK3VaPXwprTKYox2CmMDqWtdkM5O7+5MhIW2AXKKe16YzG8lcVRNRYnpYiGE
 fgu0/XrtYu54g==
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-65b9608a9adso393322a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 14:06:51 -0800 (PST)
X-Gm-Message-State: AOJu0Yz+NLOTRhyDPbLMUxg2+rJK6Pa4txI9hvltLJZF8HaeZRzXzTjc
 MBqdp5obzOMQs7xm+dyF37j2lk6Cc0R5cj1+USRM5t9WLtJw4T71oCZOqR+ItODaJBTHqUT3eBR
 Rwi4BJ/nKP5kydS/hbcf/d2QWpSpT/A==
X-Received: by 2002:a17:907:d0e:b0:b89:fb0b:6602 with SMTP id
 a640c23a62f3a-b8fc38f23d8mr933388166b.4.1771452410397; Wed, 18 Feb 2026
 14:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
 <20260128110806.38350-20-tvrtko.ursulin@igalia.com>
In-Reply-To: <20260128110806.38350-20-tvrtko.ursulin@igalia.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Feb 2026 16:06:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJc=UMdg1TiE34NNTAZ_XcgPdDwdq2aoD04eTqN2qJ=hw@mail.gmail.com>
X-Gm-Features: AaiRm511TmliQ9O7FFZ3UTrahqOU3lr21nuSiwaOb16syneP6pc_eCsqeed3qUM
Message-ID: <CAL_JsqJc=UMdg1TiE34NNTAZ_XcgPdDwdq2aoD04eTqN2qJ=hw@mail.gmail.com>
Subject: Re: [PATCH v6 19/31] accel/ethosu: Remove drm_sched_init_args->num_rqs
 usage
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Oded Gabbay <ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 28, 2026 at 5:08=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> Remove member no longer used by the scheduler core.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: "Rob Herring (Arm)" <robh@kernel.org>
> Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/accel/ethosu/ethosu_job.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
