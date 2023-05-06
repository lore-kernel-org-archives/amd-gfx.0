Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3964C77B7F
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 10:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F298710E25C;
	Sat,  6 May 2023 10:33:42 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A0210E192
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 02:10:15 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7516ac80c6cso215739185a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 May 2023 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683339014; x=1685931014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOaC9MEkRaLhLHUD06LqvjQSum99bpKoe7IpfPgthh8=;
 b=QLvhgWOj5JHmF8JoGCm+SOBS0tDTzZ6HarpTZe2YWoaj8xT46V1tShMnZv89NvVNxN
 64glMBPHSra7kbQFIej2HtC2ltApNZBYMI/fpVyGoixPKsmKanozLZT+RsxC1uQ7O9Rv
 3rn9TdZCP4B2n5KO1j1BqcKulxn2r7+wfV5I5uLVzQ0XyM1IzJrM8qzwsNbmhzdA47Iz
 3nb28dqhlBn6HNsi9yH8b+Y2NHInlZNGJU+iM84H9HZFnOGbKhkL9G4zCr0l9rZe/Yui
 ntqv5KhiwzzYtg7Gmkzz/tnGAucDmBiOcZ41p0+VRSpVG+TMNB1pqTx/Y4jmH9TYfZK+
 sfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683339014; x=1685931014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOaC9MEkRaLhLHUD06LqvjQSum99bpKoe7IpfPgthh8=;
 b=ELTS11nmsVOOk0eAPKNuMQz3nFja75Qn2f+OR2GuYZjO7juBOIit09Za81WcgkNTe5
 zK8OBQKkKtac5gAMo2ejthUJJhV9B+xqLV5/1BmjdHHlBAmp4nAeyPf3KAlwQIDGaXLd
 ZKc8KVGQMp3Fz78BJK4lO90Wqv1Dv2A3iG1CeQ7SmCKIIWkMS2WQqUtfM6SXIpS0BdHq
 7oyA+lq2MEe1Ed+MuE1/g1f+JBrNJ1669DdIdG7UY2APwOmOyfb7NWTl3kaKsgMccD1W
 L2d7sua9ysiGDP2ktm5V50yFUKaaumthOsRTBlnLGWpNLJhO05giiP9vWvTw6F72mfWd
 7UQA==
X-Gm-Message-State: AC+VfDynPRxVfCubUhfmh7TcetAfRi/rxJdPZN3O9T7YzVsLFtLcUDpM
 6xxYkJUOTT42Il8YfbSY2b8rCRdDuNzyL5S0/G0=
X-Google-Smtp-Source: ACHHUZ549yiZsi7y3pNqx0b6blUNpGv3O4UbuBmpK7aOn2kIUcFOzOqofjra/P84fU7NiNzTR4Ui57pCvmYh921acGk=
X-Received: by 2002:a05:622a:1493:b0:3ef:64d9:f0ca with SMTP id
 t19-20020a05622a149300b003ef64d9f0camr5164391qtx.40.1683339013782; Fri, 05
 May 2023 19:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
 <CADnq5_Nx2H+ywnFZmwix8tRc3mk54Nw=4L60ibtWybiO0CJZuw@mail.gmail.com>
 <CAG=7Bt8xY_SHQwNCDgFCSNczBPxjUwjf_yvR_Ox-_XS+DVuJxA@mail.gmail.com>
 <CADnq5_NEznbC8FDjaA+WPqTMLX7nuN7MdvdFWDYNXK_F3y=hQQ@mail.gmail.com>
 <bb96bd81-b62b-4f1e-25c9-a9ab66841988@gmail.com>
In-Reply-To: <bb96bd81-b62b-4f1e-25c9-a9ab66841988@gmail.com>
From: Braiam <braiamp@gmail.com>
Date: Fri, 5 May 2023 22:10:02 -0400
Message-ID: <CAG=7Bt8MYnqzDbfqPB4R92aBiFV_uZaShatM9WAxhKA4AZ5Y1A@mail.gmail.com>
Subject: Re: Is "perfectly equal monitors" really required to reclock MCLK
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 06 May 2023 10:33:39 +0000
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 11:22=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> Totally, as far as I know VRR is currently a complete show stopper for
> reclocking the MCLK.
>
> But on the other hand VRR could potentially be used to artificially
> create some overlapping VBLANK period to do the actually reclocking.
> Interesting idea.
>
> We might want to ping Harry or somebody else form the DC team if they
> have thought about that yet.

Did you hear from them? I feel like I'm wasting a feature of my two screens
by not using VRR.

--=20
Braiam
