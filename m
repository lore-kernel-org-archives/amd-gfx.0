Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7BDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F8C20723
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhkpnlkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001306EA36;
	Fri, 22 May 2020 19:49:31 +0000 (UTC)
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com
 [IPv6:2607:f8b0:4864:20::941])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BB26EA36
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:49:29 +0000 (UTC)
Received: by mail-ua1-x941.google.com with SMTP id z12so4195272uap.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A14n6E5LbDL70QTllhc6iw+LuRHOg8oKKYe4+H5A8zg=;
 b=nhkpnlktU5dw2w6lxMnTa9Jlp3+WVrhgHl3+ZQrqosuTpBsLX1tDiuP9Od6wDx1Ixq
 woIxdOlOP3VD7U30n2FhK4tvyzcU/SEWV1zbhFvSg+bQFCx/rEGmokPyRla7Bi3wEdzb
 s0Zhq10+lU5fUChBBUazA7glTpPIZ+DSNvNaNQmYiwBMImfNLnsu6dBBomJ9fU2YaE0G
 B/HDbSqRNeRi6A2CjnTDrM0/zuAde2mz7Ibm9/1cKExy9fFyxqegw91iaqzso4hvo0or
 dZWhAScymdKndcoIxSGuKd30e6iaF5BCiQBSd98XZHrj/uGO9X7COVQjkcCv5VL3ibBd
 HKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A14n6E5LbDL70QTllhc6iw+LuRHOg8oKKYe4+H5A8zg=;
 b=Ki8U6qoaeB9J9ttnCyc54QFK7p7o9Ckqvm2ugN8iw19ZiTiPCedHjYQ9+4rMmcgduk
 ToO+a8P52uCf2NpNigVq1Z0a+smcTzJYUZDgTh1zc6F/cHNXuTSP7Sp8o3g7tAxC9D+h
 h+cruRcKFNyk5Dn6wjZ8e+40sl1WvqEhYqOX/xx7rM9qYKEvf8lY92ceGZKU1WLQTHtn
 Wr+qRll5vHgXmPYzrGkXTVdQWsN38ey2+Nb2K8o0oYgbsxa9ssdDojgv/e/yfkK2cyeX
 X6852OF3j7K5zUjaCOZ7XPwgEa2Qx3yoioqyn+Jl5SZy1ZSlPOC13PmOnH4GAruYljLO
 kNpg==
X-Gm-Message-State: AOAM533/riGMzORT8I1HtTfjvhis6Sop/r1Tf4y2Gn5iPqmc2phRp7ZX
 gwfAci9iwYk19EUzf8aKPv/f5BMmOsCJXQL7lNo3s3U2
X-Google-Smtp-Source: ABdhPJwwo4zQBSR1LD5BEJsInFEOX8Muig+NzDyAlyEElvDwiBDs69H+Kp6XfUNtNoSYmRhHIRnFDnJF1RgEtkf8u2g=
X-Received: by 2002:ab0:b93:: with SMTP id c19mr12807999uak.69.1590176969003; 
 Fri, 22 May 2020 12:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <yNYwUfXpw0k-V5poEVGOZXgeP4zwnuUn8MEJYolwxL7VXfEa99STFAtLPlqlbElXGpqH5a5oyozz4XfnSRg1DCFzqYFbEHTiF5UtwGAmviA=@emersion.fr>
 <CACvgo52rE4E+6B7NNM8=tPPsu3ouOP9MnY4CNCsDsN8U_odSeA@mail.gmail.com>
In-Reply-To: <CACvgo52rE4E+6B7NNM8=tPPsu3ouOP9MnY4CNCsDsN8U_odSeA@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 22 May 2020 20:46:31 +0100
Message-ID: <CACvgo526v2Mv_U40k-xJyvMQUs-F87brcn+d6jtUrQ57Yq-j2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix leftover drm_gem_object_put_unlocked call
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 22 May 2020 at 20:43, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> On Fri, 22 May 2020 at 20:38, Simon Ser <contact@emersion.fr> wrote:
> >
> > drm_gem_object_put_unlocked has been renamed to drm_gem_object_put.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Fixes: e07ddb0ce7cd ("drm/amd: remove _unlocked suffix in drm_gem_object_put_unlocked")
> Wrong tag it seems. At that commit, the amdgpu code uses it's own
> wrapper - amdgpu_bo_unref()
>
Alex, team, this seems like merge clash.

With the Fixes tag dropped, the patch is:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
