Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7586C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7851B10E552;
	Mon, 28 Jul 2025 17:20:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nl8nYrsg";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A1C10E552
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:20:26 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b3f2f8469b7so384240a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753723225; x=1754328025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZkR29KdQ3D5UjXDnmGP3ttpyZtkVknzL40ggzHF33c=;
 b=nl8nYrsgTek7314cooFG293qMPUBBCso03dBnyXpZXgPo/PzkNL6qGNn6EdidoQNKZ
 33MB7utEjKXcEBWaznY28AIq3eUVJlzEvqHCK2697PGu7SUoX9C1WD5mf2/xztSC3VrB
 8CYlUqUVcdlxfg5BphuOiz+p8jFkVjy5zYMtbhQtn9MSjg+rbh+EAAHNCbFehbMgfpgK
 hI3zjLlHhWZyN2QlKBZrSGBkc/+D34H499+pgX8mt9z5rogUmPCXiD3hiZU3nH23qaqh
 Z6C1BMYoaFlgPmHrKEscJLbFRSXooJEH+DUDYBMuOt9wZPedCKF8DyNjRzatZwRAVuc1
 5Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723225; x=1754328025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZkR29KdQ3D5UjXDnmGP3ttpyZtkVknzL40ggzHF33c=;
 b=FRdlYal5zk70ttQCp/zXxPMQkw9lWSO2yJPHDEwFpHOS2OMgEgwe9Pmni5jn8jqnz3
 +IXeRaNXDkBH+U66XDCnxB/Qf7hwT9byosa1gyK49AqLHrqtuiQzwgnKdbHxrkvg42KX
 2aJnYAmC9N7ZGPL3mtQhOeTQHoddtoCoaSkQbP19fNSiLCWLfc1ACQc9WW4rHuKOsfAU
 SqY+O8f4Pjr4Sjr+yW1lT8Fq7NGJ25pEnwLWdK90t0ZGJusujzAShG2u+2GIgoqqaa+P
 mAsZmRyXjCadnuUbOyFyCYWiFRDUcXVgSB6JKUVw2bKm1TVB24vwkXlTgYXjau7HgziG
 GI6g==
X-Gm-Message-State: AOJu0Yzef5Q+WAtf5sOIXXN/EEvAp4tKcyu/puftm/zCrWmwLi8W/9aj
 KLgDaQSm92L835RT9ZoiR9MTxw914vN+lrPG7+UfIw2klPtXKpFJKvXGS7Iu3Xs6hPSZCmvNzwB
 KK+3pQZbgnxZE3pp9mJPiLgUbrk1JuDAaBA==
X-Gm-Gg: ASbGncsJOCp/pGlPE4qTJZGaaun8xYJ7WOL2yy0oM4fP+uh811smQrcCplrTs/qMztd
 WUeSLtI6G8Tha3TqQx7otMtPQMyvt9VZphmmzQzcTRYTax3Mbv0mCc+8Owi4XFfudL/ESs697UG
 O1Q9IHUvocMvNZ2iXwYyELfdmYtBJqCkFRDsL1wjrzqBWPc+75J9XHLUBusz0EBUODwTQhCE3dc
 BRBiSi4
X-Google-Smtp-Source: AGHT+IFpMMBLTlbSC3lELBkumVe+oaQenL+7GWUGySxJnEW4Cis0bt89+YfuB0shrRLXhyOblLEXxufF5hoGXiD+rBY=
X-Received: by 2002:a05:6a21:6d88:b0:233:f84f:6097 with SMTP id
 adf61e73a8af0-23d701ee6cbmr8244171637.9.1753723225509; Mon, 28 Jul 2025
 10:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <1183390756.152871261.1753021573282.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <1835198865.152908048.1753022389600.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <1835198865.152908048.1753022389600.JavaMail.root@zimbra39-e7.priv.proxad.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:20:13 -0400
X-Gm-Features: Ac12FXzr1nuH14jFxz0PKWKJWvDZ2d-AT-4g3wJ82VykWk0lhh6FL6sxCdsRkqo
Message-ID: <CADnq5_Mbr_dU3Xg39wj_DiUU4pRbS_tx23eOw5SEEFvMi6ReBQ@mail.gmail.com>
Subject: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesOS)
To: Yann Dirson <ydirson@free.fr>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Sun, Jul 20, 2025 at 10:39=E2=80=AFAM Yann Dirson <ydirson@free.fr> wrot=
e:
>
> Hello there,
>
> For a few months I've been experiencing occasional freezes of the X11 dis=
play
> on my QubesOS RENOIR laptop.  The setup is pretty much standard for Qubes=
OS,
> with both GPUs attached to dom0 and XFCE running there (and the dGPU bein=
g
> mostly not used).  Kernel is QubesOS' kernel-latest-6.15.4.
>
> Those freezes most often occur while the screen is blanked
> by xscreensaver (suspend options fully deactivated here, as suspend is br=
oken
> on this platform): in this case moving the mouse does not get the unlock =
banner
> displayed, the screen stays black... except the mouse pointer is visible.=
  I can
> also switch to other virtual consoles and interact with the system, but w=
as
> never able to collect any evidence of something wrong being detected.
>
> Occasionally it also happens (like yesterday) while I'm working, and the =
X11
> display just seems frozen, no clue if the input devices trigger anything =
in
> there.
>
> I guess something goes wrong but gets undetected by the driver.  Any sugg=
estion
> as to extra logging/debug features to enable?

Is this specific to QubesOS or a general problem even on bare metal?

Alex
