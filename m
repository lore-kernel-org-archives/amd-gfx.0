Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7888CC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 13:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB4A10E08B;
	Fri, 12 May 2023 13:30:04 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6C210E08B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 13:30:01 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3944816b579so1266251b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683898200; x=1686490200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JDutltqqHj0Zlip2v5fYn0KmBU4H4kDrxmxIBeyVuY=;
 b=N6pGoZZQy3VC9dPlM+IpCkeONAsP7rPT8XJ+f7OPs8G11qWJiWfhlkg+dEcrGXTs9e
 YiwA2t5zyes/7h/sOaeT8SFAdk6+H0dDJOCTdQHS996e6bfnWrML8tJDbCSDV2KYSoLR
 ehO8AoKIJE9k3ktXO7W1IfUIkwW9gLWCQ12y3MhfmROakqoaEAg7uk0iIvR30EidFHC2
 QTXEW9TeXjusFP4TQyeoXMtSsSs6LG2SDO1kVyZA3NouqzT2rodPFiwbXTq0iD/SZeKI
 kuPLKjzNGDOuSWqFaIbCBWo38zY5RzykwTZMDih1OyLRLHMyiqs36w1Mn8yd9xxO88ev
 0ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683898200; x=1686490200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JDutltqqHj0Zlip2v5fYn0KmBU4H4kDrxmxIBeyVuY=;
 b=da/hm0ofA4OF6B2LcWuPzs7l0dtg4fheAHtbrXqjddGI2WjlA/YDbJboozTDVKnb50
 H066n8m9phIpGcyV1u0h3pTMMhTNiSgtQejv7irpMJJ9JaudxGjGVfiAiA5JrpiDtqjd
 MYAYfkuXCAN97hElk5mkxDf3zymLGgqlxio6WmvUgb3h5IgmDuaRlxkNbEBGJbV5/ys6
 +y2YymQ9ZEXwwZ6d+05rglW6otfnKT+Q9gq7RVSCGjJ3CyoQn+X3dHgFRgv7Fgh4IxT1
 mKj1SWa+aq2HTz55VXykC4FrcRqxli5IauboMb96zhx9hhhxxTBMK1FK5xvG7cCwiBZn
 U06Q==
X-Gm-Message-State: AC+VfDzk8rk/L9CeTFSuFw+uEsMlCDZXym5CYuf1QUKiIn+hUWhlnswj
 DnXDm+n+MadHox3GsS8vkfddFPO7KWpw1W+/gfumO62n
X-Google-Smtp-Source: ACHHUZ7f02yLJi7zI+v2ldByqo/0MceJ0yI/7YiZp8nHZ/1dCH37FF2lk1Ah0ZHP8wCmQktsXec9mI0uR+4jw4OuR3Y=
X-Received: by 2002:a05:6808:10b:b0:387:2f12:e71a with SMTP id
 b11-20020a056808010b00b003872f12e71amr6491831oie.34.1683898200568; Fri, 12
 May 2023 06:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
 <20230509164947.455753-2-bas@basnieuwenhuizen.nl>
 <0c6d481c-02ba-cf89-3333-4517255b8042@igalia.com>
In-Reply-To: <0c6d481c-02ba-cf89-3333-4517255b8042@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 May 2023 09:29:49 -0400
Message-ID: <CADnq5_PffhjvYv4yLPQtN2gggJ4pbTcnqy=qPBkPKfjATnFx0A@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 9, 2023 at 1:04=E2=80=AFPM Guilherme G. Piccoli <gpiccoli@igali=
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
>
> BTW, I couldn't test this one since I don't have GFX11 HW, so appreciate
> if anyone from AMD (or any community member) could give it a try...

We've tested this on gfx11 and applied the patches.  Thanks!

Alex

>
> Cheers,
>
>
> Guilherme
