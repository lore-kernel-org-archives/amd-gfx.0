Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88867C77B7F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 23:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B90B10E618;
	Thu, 11 May 2023 23:18:29 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EBE10E618
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 23:18:27 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-556f2c24a28so12008547b3.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1683847106; x=1686439106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFtitCpnqSydd8ZY+Y/q0mnX79vMSXG9PW2SKOrJzqM=;
 b=T8hvbSQ6BK5BjQdkJvUQB0fETHlY7Zdme3Bq7D5Z83uSHffRAs5Utgkkpn9o25etq+
 vRP9a4pP1vT/2N76flnL6Sc82mIa1b+Qauuj7swJ3RHLnW+H1EbC5BOoan7WjizfnJB3
 PONYinoUQ6Dm6P7kaIoeXZn3862r/qZE7GwPvuKfoVjuvsT8pAXqxZAxPBjHDiNSoup9
 jAwrUrOqnmCnctqKxNlGFV0RHd6megdnLYSzr3AfAUbkR/skV2MwP9mgrwY7zlQVWKY1
 7CFDtNH9pFJsxUJUNV2v4UkWTml4kxoEsO7vjN97YIgUJZpLr191iHRPrAB2yPts4amh
 t2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683847106; x=1686439106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFtitCpnqSydd8ZY+Y/q0mnX79vMSXG9PW2SKOrJzqM=;
 b=MTwRMnIHTLeH1rEAF2NazWl3PAlc/AMO19PP3L+q+ORcSUkN9DvW4igfF85UV4wRi1
 wsD3ydKRa8cOtonAKbdxDvazaDYSl9NhiZDzD4WLsr7LwQhKHwU/aiigFl+4sXMMDwFe
 wP6tqdvt9eSoj6Kv/YNkzOmEp0RKqLePAsvaXDBodgrcJ3skLtWWsLyZ5vc6rHojs6UM
 fBtIN/aZ5cDV6Ked8C4reD92r933rAoFQk2Whh3t4HMpTLMLkpgqnit1zT0urtCABTx6
 xfYBfe20ph384d5ODxiTq9fc9tsUWxp7YZMeSmoxQz5iyIft1/eHJ/jLYLBYceB7v8wC
 u/6g==
X-Gm-Message-State: AC+VfDxwHDNUwaSgUtyqGlmmt/WMDl45lPH9AWCWEMSKu1WswBuWgZqz
 ejB2Is5t7szy/aKtHnFBDOYAgslUs31Z8HCv+Ot+2w==
X-Google-Smtp-Source: ACHHUZ4nZg4uB00DjF4naCIxW4z9qznDUl9Jm3OpogOKyiGDEQZ2RUY0sri1WwPfFe2rlwoERYGEtnZZ0ueXQZRfVuI=
X-Received: by 2002:a25:ae91:0:b0:ba6:d047:9658 with SMTP id
 b17-20020a25ae91000000b00ba6d0479658mr1768337ybj.5.1683847106550; Thu, 11 May
 2023 16:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
 <20230509164947.455753-2-bas@basnieuwenhuizen.nl>
 <0c6d481c-02ba-cf89-3333-4517255b8042@igalia.com>
In-Reply-To: <0c6d481c-02ba-cf89-3333-4517255b8042@igalia.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 12 May 2023 01:15:27 +0200
Message-ID: <CAP+8YyE-Ar3e_wJ2fEpm7L6BZEt-7Pk12Qbk21=_xhHYQcTAoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx11: Adjust gfxoff before powergating on
 gfx11 as well
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 9, 2023 at 7:01=E2=80=AFPM Guilherme G. Piccoli <gpiccoli@igali=
a.com> wrote:
>
> On 09/05/2023 13:49, Bas Nieuwenhuizen wrote:
> > From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> >
> > (Bas: speculative change to mirror gfx10/gfx9)
> >
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > ---
>
> Thanks a lot for both patches Bas! This second one, despite I've
> attached it on gitlab, you should also Sign-off since you're the one
> sending it to the ML (I guess heh)

Ack,

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

I'll add this if I need to send a v2, otherwise I'd kindly request it
be added when applying.


>
> BTW, I couldn't test this one since I don't have GFX11 HW, so appreciate
> if anyone from AMD (or any community member) could give it a try...
>
> Cheers,
>
>
> Guilherme
