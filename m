Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395AFC79F83
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0AC10F43D;
	Thu,  3 Sep 2026 07:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NPLNc+rj";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D010A10EC92
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 11:26:38 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-90e828b309eso32339416d6.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 04:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788261998; cv=none;
 d=google.com; s=arc-20260327;
 b=squGxKWDICWxlDFiJDYoX2K3G8LWpb1Yt6HPQ9k9N4GZcbnVUOsy156+9mLZLA31nF
 3kpbbwpjSvub9jltccHz5a7vZ5mMTK/XtqXSvd3m0YeBjd2LoyDw0K3XjNjv+q9qncuw
 52WYlmUSNzTShvWuPXu3bUibSPKOfs/yT9CDtePphm6E3bzzkGafyU8OJCF8vMO7NQ8L
 YZz4PdUrlRqrearpyn429I1OuD0rpZ+Ghy0p/7Duf8RFegvp5jNqstyX6sdg6Fnd/vQs
 Bwlz/SwDwUZ1L6LEbs0hAprlvFzV31Al7c7dCeUeCoyoDYw7Q9l+KQfc5MDfBcwoph1x
 HlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=giTslEtXGSQwPV9RRaIioNPE/e48tpcU8ObIsZM9aC8=;
 fh=Y+HHpbqm04TUfQSQw44e2FGRktaZ18HQAC88jumeIFs=;
 b=by6cFOkxTUGEzKMddwqFraLuyikRKwPT3RzqiDCGPD/WILrFAuOafdTrXmDt0I16tV
 JAF9hIIRnbvXGnBt5EttYb5/5pJh3+eiT/koyyd3rtMNE6MLZUaCIWvv8UKMl6C72zyA
 LEOWdZeBMDVvwv/NDhdeV8XVlbs/8snYTYvyHxWc+WhYJtF4IKqb5bF0ql0Z/QcUShcw
 /dd6IRIBBD8GtcvBFJOiihwYTazpClJuF8utvgTMe35l07bRXYAkm4HqaFYras4+abX3
 NQkMg1aNOQgQYx9XY1aFlspe7zldnpz7/wUd4yfVeV6Ggx149RVlU32Fsc/k8+E0Y6bv
 SimQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788261998; x=1788866798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=giTslEtXGSQwPV9RRaIioNPE/e48tpcU8ObIsZM9aC8=;
 b=NPLNc+rjJRiIlPs46Ctijb84vLQzItKM39ZWNSwue+A03FLY+WwrwEN2qeQlZ5iJFJ
 W86FRk6vOKs27hPL5ZisEdFL47UHd7DtGT7G+qo4XFYrZO7bbVZ+hT0VD3JM/WdidxsU
 3e0m7CEU68E2wE4oqSxUsmQ97yarMJUkO/iXFs+/TVBo4VbnP/P4VjIQMTJ6qigE7VI0
 JXmi3/08LBynJtiqoYwd1/ko5Nm5Ak6ltj1d/B25YhIsgG1JAcE1IW8a4W7I/FrUANVj
 JVsUYEeYYZrsxKoL7mFP5ADPnpmq1JN/A+ZgS+F69u6fsbL2mgrCfBk5wnGfHeApCONw
 ZRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788261998; x=1788866798;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=giTslEtXGSQwPV9RRaIioNPE/e48tpcU8ObIsZM9aC8=;
 b=eMmaJC2WH8n0UN6ASh6PvFfIN+8npE3ZGckFiV7ZbusMwpBvMRe1OsnW8wNUD80q0i
 SOj/HdoM1BrwyFzvQr0PEtoMZDE+OMU2++0ZMbqfJkz9rai6ox3DN7NLEoFDop7ZIXz6
 gksensiwPDoGRDYauREZtF7bflvQJiJt19/UJhEWIC9dDeD9/Fkybg2D7eFoK2kH+uAe
 PJuCljb5NNK8m+dauY62cG8BFuWuBZ9p4XaPo/Y7fvkVzGPl/Ozj5n6mXhjsFpORPx+G
 4GY9pmljfRFxpNoXwWm4VAvxjl90zA9XReBxszSfnNMd88zgxNJIoeZt8PcFi3QguhdU
 PRMA==
X-Gm-Message-State: AFuF++lcMJ/orXhSXRhkefjZ7439l1P2XLSrZd3Fm315U9GDzPZ3/B+O
 r42o8NSa7U/hXkEPJB7exkAU14M9LVNg46mHGYrqrEM1qXi/X4bXXZbK5MyXDb8bGxmfyqJzIUl
 WPws7YRFRy7jALBR+m9PRanllpvp4Ng==
X-Gm-Gg: AR+sD10MlWgVDIM9Gk0OcBasKPNZuaY+a1bbpek6k7iN0S1zxAlHHaVaT47tQlQVb2Q
 ctg0e9xO9UBRrkjgEw4Vicq1lYBl7Qiy+bnmHWhytzKFi9DnwwFjJ2yWF/7YLgpMy2iRqUCSBaT
 d8rsV0YHYwFhEe+BvYrRiaOLO2p7G/0E5JcO/fU83NEeoSzyv0tDzOYWuAm9OLdIl5bdjNCFgpu
 iEPk9trL6WPwsMySW7njLKIs89LU6+e+sxeuEYBacP+NB2aF3HpfxWduOdW3j209a8oC5MASYtH
 r4kV4S97lOhIq9OUuVbkSLFAAie6yabZg3lOYs51X2sK
X-Received: by 2002:a05:620a:440b:b0:939:5551:1e09 with SMTP id
 af79cd13be357-9395551236emr206040185a.29.1788261997538; Tue, 01 Sep 2026
 04:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com>
 <83f89e11-b265-4d12-97c0-f158e0b5b82d@leemhuis.info>
In-Reply-To: <83f89e11-b265-4d12-97c0-f158e0b5b82d@leemhuis.info>
From: Robson Candido dos Santos Alves <robsonalves.us@gmail.com>
Date: Tue, 1 Sep 2026 08:26:00 -0300
X-Gm-Features: AcwNN1UAl4fHdpkC9IMZ4Sd1yE0VyhaIPoDKzGW1bUu8pkc_c8sFdn5XOcj-MY8
Message-ID: <CANkdJ2Xv-RrTGYt-YyBH4ShE+h05tj_J4ipw5s9X8UdLd1HnWA@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: "pixel format with alpha exposed but blend
 mode not setup" warnings introduced in v7.3-rc1
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

Hi Thorsten,

Thank you for the quick check and for linking the fixing patch set!

Good to know the warning is safe to ignore. I will keep an eye on the
series and test it once it lands.

Best regards,
Robson

Em ter., 1 de set. de 2026 =C3=A0s 04:16, Thorsten Leemhuis
<regressions@leemhuis.info> escreveu:
>
> On 8/31/26 15:46, Robson Candido dos Santos Alves wrote:
> >
> > After updating from kernel v7.2.2 to v7.3-rc1, several DRM plane
> > warnings regarding unset blend modes for pixel formats with alpha
> > channels started appearing in dmesg during initialization.
> >
> > Good Version:
> > - Kernel: 7.2.2-070202-generic
> > - Display Core: v3.2.384
> > - Result: Driver initializes cleanly without plane/blend mode warnings.
> >
> > Bad Version:
> > - Kernel: 7.3.0-070300rc1-generic
> > - Display Core: v3.2.392
> > - Result: Driver emits the following warnings in dmesg:
> >
> > [drm] [PLANE:44:plane-0] pixel format with alpha exposed but blend
> > mode not setup. Please fix.
> Thx for the report. Not my area of expertise, but I guess that is caused
> by 9813e158d13d ("drm/drm_blend: allow blend mode property without
> PREMULTI") and will be fixed by the patch set "drm/atomic-state-helper:
> fixes for blend-mode-prop warning":
> https://lore.kernel.org/all/20260826104143.39077-1-mwen@igalia.com/
>
> That patches are afaics scheduled for inclusion in 7.4 -- but afaik the
> the warning is safe to ignore.
>
> Ciao, Thorsten
>
> #regzbot introduced: 9813e158d13d
>
