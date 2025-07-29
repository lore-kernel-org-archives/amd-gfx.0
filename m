Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B00C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 09:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20CF10E1E3;
	Tue, 29 Jul 2025 09:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="A7Q4pR8f";
	dkim-atps=neutral
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABE110E1E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 09:49:57 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp3-g21.free.fr (Postfix) with ESMTP id 3845213F88D;
 Tue, 29 Jul 2025 11:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753782596;
 bh=x7iMsG4KaHTbOhl7VPW4haaO7v8fmmoQfUnQctezWxk=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=A7Q4pR8f5XyVZXsKdWa1W2dt7RQY4+VZqztPJz6UucYdxCV5ea8mqeTGzggZ2+NdU
 6fbQi/18PymrZVYM3VFGLYIOVq6eI45D2rP0xI2tHmpDaMc+WtprZp0vWfWPfkRg7+
 OVHe5M2K03hCrypjG3ePpIkb+b7HsEhKmLoiMf4tKq0SIyakxvA6YDvmEmUqBQKtWV
 xHZvrVbvXYZnVkRcOTsmyDXyeUQmyMX2iI5guEqDQEqgcSIKtxuVNhkDl6pHmvtnFU
 0jMkztNoNJYL5I3D0DQRkotJbE162Id3Ux1R3D54M2z2X5KMHdHkxuywnKj6ZzqNqh
 7M0V0MWMKToRA==
Date: Tue, 29 Jul 2025 11:49:55 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <2140760933.194259033.1753782595813.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <CADnq5_Mbr_dU3Xg39wj_DiUU4pRbS_tx23eOw5SEEFvMi6ReBQ@mail.gmail.com>
Subject: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesOS)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [88.120.94.119]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

> De: "Alex Deucher" <alexdeucher@gmail.com>
> =C3=80: "Yann Dirson" <ydirson@free.fr>
> Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> Envoy=C3=A9: Lundi 28 Juillet 2025 19:20:13
> Objet: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesO=
S)
>=20
> On Sun, Jul 20, 2025 at 10:39=E2=80=AFAM Yann Dirson <ydirson@free.fr> wr=
ote:
> >
> > Hello there,
> >
> > For a few months I've been experiencing occasional freezes of the
> > X11 display
> > on my QubesOS RENOIR laptop.  The setup is pretty much standard for
> > QubesOS,
> > with both GPUs attached to dom0 and XFCE running there (and the
> > dGPU being
> > mostly not used).  Kernel is QubesOS' kernel-latest-6.15.4.
> >
> > Those freezes most often occur while the screen is blanked
> > by xscreensaver (suspend options fully deactivated here, as suspend
> > is broken
> > on this platform): in this case moving the mouse does not get the
> > unlock banner
> > displayed, the screen stays black... except the mouse pointer is
> > visible.  I can
> > also switch to other virtual consoles and interact with the system,
> > but was
> > never able to collect any evidence of something wrong being
> > detected.
> >
> > Occasionally it also happens (like yesterday) while I'm working,
> > and the X11
> > display just seems frozen, no clue if the input devices trigger
> > anything in
> > there.
> >
> > I guess something goes wrong but gets undetected by the driver.
> >  Any suggestion
> > as to extra logging/debug features to enable?
>=20
> Is this specific to QubesOS or a general problem even on bare metal?

Actually this is my main machine so QubesOS is running most of the time.
I'm only booting bare metal on this box for targeted tests, and
never use it long enough then to see the problem trigger.

--=20
Yann
