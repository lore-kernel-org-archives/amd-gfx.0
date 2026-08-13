Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1553C5CFDB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 08:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CC410F1EB;
	Thu, 13 Aug 2026 08:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="fbpn74pA";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045B710F1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:35:51 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so2111686b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 01:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786610150; cv=none;
 d=google.com; s=arc-20260327;
 b=ToyZMP2bhcyabAo2a6a25/kiEL/Ke5TM3MWTawsK/yBw9o1m8aGt/uzUuT8auXabhY
 7tgoiG5m7++Sy54ruLqKXCyzfY6ZF529LcTxmK7Jv8BHCDGiKRcicUMDAfRonkT1sy4m
 eUnpjkpgfVjh2tVJWwLjJrDhJFW50Npqi/en7Gu9gvX84JPClYt2sOnMj4388JpjM/rS
 kMBewpl0KnIDkKP2tFHefAwxDBSNN8unQXBuflIFxeIknHU1NXaow7v7SbQT9yEke7z1
 Yz82tiDnFBUqyt4mVR6g/k1vwJiAKDpUZEw3wytjH38TCJSBf9G592Mt8zrjTjLGmffK
 VzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qhR/pMq8xWRuwAQYE6AYpZffXsZYHfwbKQnydA1sV0E=;
 fh=+ZvQg8LeA4/TJFdPEYEckOT5jDjEMvJILYKb+aVkFJ8=;
 b=j+I7wS1yUggj2/I87AXzMMWn8GjrXviwOXAV5uda1w6RaavaQV3Ci3kSh8Bh23jue/
 N7Jm+EtvJG4djDHCOpgFQ9OggQ/GzXOF5EDamVWVyFnyQFvyx0gS7iUEx7EQS+s6QByk
 cOXGA0cGfZLewEURxr0i24dMTo6qZclcffdMI8ZzpgAIJrTlMrp0r2wD4Gt44WLK2fq5
 qNMhyMtCS1PMjtyg2DocInh9zMxyAerTdUwpPi4ALwS+4zKjCsSdZtmlvpzG2gitvWE3
 yoYeSu8yycpRWV9SagGOTx3rCp8WzPCsc/0lgDyPPaG7EUJJ9mrAHWXjpDiUqfRD+GyU
 fHxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786610150; x=1787214950;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qhR/pMq8xWRuwAQYE6AYpZffXsZYHfwbKQnydA1sV0E=;
 b=fbpn74pASFPbuFUE45mpBG8eYUWgtzcQ06rywB8KZsQmpnN9D8B82d9+CV8aA5b9yL
 KPppyJnxmbd2FCHwcIdmokipJMUPI4nsCMwGxOa0j/+ZoRnnfO0sgM04HPuod+PlJ9nd
 v/c7uNQeb0iLBEEys4q0kP7goIv5LdiElVIxIEDKJAB7zO81kpCJ7dpQXpXNAKRdPoVm
 vBYUBrEulCEJ37gOa2EAhQUDesmt1mr6ni5i3BikNV49JVH2G8UWy2gzcHpwJzr+AqJE
 6Tdun0uTJaly6wl2UbuisqAgHaqg7E8pztEMmmqaZJ+dTpwYmJkT1zh8pYwkaYrQ/MQ7
 J4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786610150; x=1787214950;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qhR/pMq8xWRuwAQYE6AYpZffXsZYHfwbKQnydA1sV0E=;
 b=tW8XAAbtYoXPcNzgFXD8VG2OrYc6RoTLT5Ro+zAxTMIbePlTisE4hhiX33IzhcFC8r
 F5iiyWfIDG9Cr5ga2IvW1QvwSEbOwDbAJKPLLzFhQZ2RYwdBXirA9JHajmXAyh/5oJFr
 6QM4FMCuA3t5FjzBX/5PjSM1BZTk2ZMr1X/vrIBl6asF4Fy0p0GTQfQCfKwPMozY+DK3
 WPoZJS8vmQBU/f9ejpvBv+/Ekj0rZKgH4RIKTryz83IDTjUATFHr4XKpBi9lRmT9OPgh
 XpmNExx/nF0AlSK76NyjT/IFrdkhVA0c6rL8cxOZcMcryy9c7EBbNF62SEo0GgAwEcjM
 pPrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RruQIBmvg6gXRIDLeUpJvnlKNHIN7dL02akg3nOF3+OPFxcr7yohoNLrBzTJ1fBrYRFPI3nAvU5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+8fqE3G3OUMpoHoYlgfYdjU6C/SvqKzZi8XKi6tUEkEIhxozo
 8WBjHLNUD3ybisMi079MgQtIJG6pf4zdxGTphowp5jhWo2IvCDBvE8Q1uA1DofukPsSsiA12J7U
 ohgJxUTpLv7aiKxwbD5IfkIPpJ4kWIKc2cfxEthGC0w==
X-Gm-Gg: AR+sD138LXe6/JeXS0Gny1fntSyzj+3bg/WlXuRv4q5FUjmERQ3oqeU7uvgrk1Lfjc9
 FM69FzpoeyNdqNcA6OxPdDtnmBhe7DTHtXzwK+NHqRrv2H7myGncW6cuwcBv0tiurD4svF6gDeK
 Td9JFv0gXuLciJcOf6zcR7V0yMPeEKRzJUMT0E0HvST6hTIqc79jG5XRp/8yAdVme0Gu9X4YMvw
 pFizTg9l/WZJ5ZqNbfqFMva9aOk8nQ0acJMJ3PNF4qiHXYj9gRjLGSeCIrGzgYo5x+35Ytv7W2p
 qz2D03te5nZGu4z6KZ8uhXw481fW7nHTMThhsTcgX7Rj
X-Received: by 2002:a05:6a00:1da5:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-84fc744db5emr4187647b3a.5.1786610150481; Thu, 13 Aug 2026
 01:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Aug 2026 09:35:39 +0100
X-Gm-Features: AUfX_mwpP6c1PRTeqjm78CTc7zKe8fxHsiMH1wJibE82I0ix7CJ_6B0W5ARoaVE
Message-ID: <CAPj87rPsEUKEtOMzpvwnAJ1AHG=TyhLVu75kByPLwqbJ5yK1sw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: Derek Foreman <derek.foreman@collabora.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
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

Hi there,

On Wed, 12 Aug 2026 at 01:43, Zuo, Jerry <Jerry.Zuo@amd.com> wrote:
> Below two scenarios belong to static/modeset ALLM

Thanks a lot for these clarifications.

> #3. Gaming-VRR
> > Is it mandatory for the source to set ALLM when the sink advertises ALL=
M
> > support, and game-VRR is active?
> Mandatory to set ALLM =3D=3D 1
> From spec 7.6.6, P240
> It is spec mandatory, and we follow it.
>
> #4. QMS-VRR
> > Is it allowable for the source to set ALLM when the sink advertises ALL=
M
> > support, and non-game-VRR is active?
> It is QMS-VRR, mandatory to set ALLM =3D=3D 0
> From spec 10.11, P456, 240
> It is spec mandatory when enabling QMS-VRR, but it is not yet implemented=
 in current change.

This is the interesting part.

> > > Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
> > > doesn't mean we're playing a game. We might be using it to play back
> > > judder free video (where we'd like ALLM off to preserve the sink's
> > > image enhancement), or we might be at the desktop.
> > >
> > > I'd imagine some users would still want their sink to use all the
> > > image enhancements they saw in the showroom even when playing a game,
> > > so I'm not sure any kind of "auto" decision making in the kernel make=
s
> > > sense at all, even based on content type. It's a very subjective trad=
e-off.
> > >
> > > To me, this seems like something a compositor would want control of
> > > with a simple boolean property.
>
> ALLM_Mode is a protocol-level HF-VSIF bit; like VRR_EN, the driver derive=
s
> it from existing compositor-set KMS state rather than exposing a new bit.

VRR_ENABLED is a completely separate bit though.

> The Gaming-VRR case #3 is not policy at all. 7.6.6 mandates ALLM_Mode=3D1
> when VRR_EN=3D1 and the sink advertise ALLM, so it must live in the drive=
r.
>
> The only discretionary piece is content_type =3D Game =E2=87=92 ALLM (#1,=
 #2),
> which CTA-861's latency-minimization recommendation for Game IT content
> makes a reasonable default (Appendix G lists it as allowable).
> To avoid per-driver divergence, that default could live in a DRM helper,
> with room to add an explicit override property later if a concrete need a=
rises.
> It can be planned in the future.

I really think the burden of proof for implicit semantics in KMS
should be the other way around: do we unavoidably need this, or is
there (currently) no other option at all?

I don't think ALLM falls into this basket at all. It's nice to have
for gaming (and mandatory for gaming VRR mode), but there are plenty
of different scenarios where having it on or off is a legitimate
choice. For instance, should desktops imply ALLM because they aren't
going to smooth your text into oblivion, or should they not because
you're probably not going to read text on a 49" display? Should all
games imply ALLM because you need the response time, or are you maybe
playing Myst on your TV?

I understand the attraction behind 'we can just stuff this in the
kernel and it will dtrt', but hey, that's what people thought about
Broadcast RGB at the time. Or colour model/subsampling selection on
the wire. Or or or ...

Cheers,
Daniel
