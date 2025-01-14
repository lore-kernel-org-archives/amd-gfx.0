Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00691C02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 17:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4DA10E45C;
	Tue, 14 Jan 2025 17:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="APj3TrXP";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998FF10E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 17:59:29 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-467725245a2so52935491cf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1736877509; x=1737482309;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LXHsEntU5Ys95uVCIF8Zmb9U409KBpBciIBNlMO0m0=;
 b=APj3TrXP6ITSi1GObrL3ZYz2FkBuhDWwS/kvoQ3lLAt/JjeXsNtKHjsR+V6pQa1yZ9
 rOhwROkFaudB9P+yXpSaJYuFZtAANM+Qf7QDRcltO2BlkhejVSxoD3pbXk6OysCHWCoo
 KrgRDQoG4iXzcsw12yhgQlh3IhJUuTqe7O8RzP4YHvyzOSYPYIvoxjEz0WBh8hnffcMJ
 aLTIv9fhFr1V0SVQ22WtL0xUG2hERxVUjEcM5lOhgrdA1yeDUOXoI5o6+iC0E8OJA61c
 M4FyO+6NNmCaynQ9zuwdqza6qQLcj6E8D6kK/uLWzUg+1yc9goNDkpfwrM0JYqQiN/IM
 A1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736877509; x=1737482309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LXHsEntU5Ys95uVCIF8Zmb9U409KBpBciIBNlMO0m0=;
 b=VtPx6YZr1DCnpW7Ygq9l3bv6V35PTSgg95hqFmBxE386bgVaRXn9rsewZ1AkA0wDm0
 89mEJPnh0HQlJ7/mWPzuiGKo58no5f/PwLQf6fc9eSNunvAp1rTlJ7GiwD54n5cL0Bj2
 x935tosItAQwfJHY45jUyeetS7P0EvBiH8tovfAsvpfYrzBeSjGNUffG/fmkvtlHZzig
 jdLzGFBaHq+VTbxrXFrzOlH+Cqw8Toh4hATjFaC90hciHJjQPWx4xmZ6C7jbKZ78KmpO
 jFKYmItOIBjhryqpeWxt4L97moYfmo5J80J57+SEY0LzxnlYRit9rEorP1xsWhNLhePF
 3iZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMWTOdE8giYYIpXjIf7eUNnyNDcQDJXBWLUf0moHNX6NTGEHaIyZEFr0Wbf1PdQobF4KtvRQsX@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1unom0KWCeNwGMCJB1ddXbtbOxMZyaxNI76f1o08R3ayr94mz
 jwah7w9C7fYo6HnxrPkJJiWV7ffXD+q5JMlmPhe5l9PtF39fSfv492IzADeptrQU/3xucUfth6S
 VcMOatanvIDMIUumDziDyLQPg86M8ZsoVVYKZkg==
X-Gm-Gg: ASbGncsEZJaYlJ6nhYjgewPqqThaqAxK+vDv8ewskbrUecNAYrVulgg4pi2/U7WzBW+
 55IB7gmsc3qbAgWj6IE2dFgchpRN/b6mua6b6
X-Google-Smtp-Source: AGHT+IEWqpgKCTT/9ls0xmYdMPLOJRlFRN/Cz/iKnMnCoFc3cNEYBMkPMq7s1kBd0eoxzbWOzz7PqXH22Wfsdrp9eCY=
X-Received: by 2002:a05:6214:8111:b0:6e1:7223:19a9 with SMTP id
 6a1803df08f44-6e172231a99mr111298526d6.24.1736877508679; Tue, 14 Jan 2025
 09:58:28 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <uffsfaps6a75zmkyshkwfxgybcslqrnfqqtjzekegdptvwpugc@2ndpcuxyfp3f>
 <c64cb9d8-5ea7-4644-93c8-04a97b758fa0@mailbox.org>
 <h26quuebhpxwkc3fl4vtfteoqyvingnddgxbnzptfnxfg6xgkd@kkkmeqwplomv>
 <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
 <Z2Ki-lQH4Fbch6RO@phenom.ffwll.local>
 <q45c43j5kwwvemec7mcs4kqzt54pa3nz3jlhkcky2v63s2vfie@him4q253uw4p>
 <CAPj87rMFJ0JRvsKqZUsw_EGrFWr1VLO4Ne2w_bZ5cH+gs_d=og@mail.gmail.com>
 <Z2Rf7mpSuzZ0ObmT@phenom.ffwll.local>
 <07d08a42-c44a-477e-8057-721b270310cf@nvidia.com>
 <CAAxE2A6N0xtgZmzTR9FXMN79xxy3T8zfhh1sz73h1h8=0ycJ2g@mail.gmail.com>
In-Reply-To: <CAAxE2A6N0xtgZmzTR9FXMN79xxy3T8zfhh1sz73h1h8=0ycJ2g@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 14 Jan 2025 17:58:16 +0000
X-Gm-Features: AbW1kva4ALOA0LOORdEv_TRtbfcne3GOqf3wkUfOV14MfYux7kBg8wr6Hf20vFk
Message-ID: <CAPj87rP4r4q-wBx1dHsEkZ7=S2c2XsbA1Pz4Skw1ETt_2yD2Ag@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: James Jones <jajones@nvidia.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Brian Starkey <brian.starkey@arm.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 ML Mesa-dev <mesa-dev@lists.freedesktop.org>, nd@arm.com, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
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

Hi,

On Tue, 14 Jan 2025 at 09:38, Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrot=
e:
> I would keep the existing modifier interfaces, API extensions, and expect=
ations the same as today for simplicity.

Well yes, not just for simplicity, but because everything stops
working if you don't.

> The new linear modifier definition (proposal) will have these fields:
>    5 bits for log2 pitch alignment in bytes
>    5 bits for log2 height alignment in rows
>    5 bits for log2 offset alignment in bytes
>    5 bits for log2 minimum pitch in bytes
>    5 bits for log2 minimum (2D) image size in bytes
>
> The pitch and the image size in bytes are no longer arbitrary values. The=
y are fixed values computed from {width, height, bpp, modifier} as follows:
>    aligned_width =3D align(width * bpp / 8, 1 << log2_pitch_alignment);
>    aligned_height =3D align(height, 1 << log2_height_alignment);
>    pitch =3D max(1 << log2_minimum_pitch, aligned_width);
>    image_size =3D max(1 << log2_minimum_image_size, pitch * aligned_heigh=
t);
>
>
> The modifier defines the layout exactly and non-ambiguously. Overaligning=
 the pitch or height is not supported. Only the offset alignment has some f=
reedom regarding placement. Drivers can expose whatever they want within th=
at definition, even exposing only 1 linear modifier is OK. Then, you can lo=
ok at modifiers of other drivers if you want to find commonalities.

I don't see how this squares with the first statement.

AMD hardware is the only hardware I know of which doesn't support
overaligning. Say (not hypothetically) we have a GPU and a display
controller which have a minimum pitch alignment of 32 bytes, no
minimum height alignment, minimum 32-byte offset alignment, minimum
pitch of 32 bytes, and minimum image size of 32 bytes.

To be maximally compatible, we'd have to expose 28 (pitch align) * 32
(height align) * 28 (offset align) * 28 (min pitch) * 28 (min size) =3D=3D
19668992 individual modifiers when queried, which is 150MB per format
just to store the list of modifiers.

> DRM_FORMAT_MOD_LINEAR needs to go because it prevents apps from detecting=
 whether 2 devices have 0 compatible memory layouts, which is a useful thin=
g to know.

I get the point, but again, we have the exact same problem today with
placement, i.e. some devices require buffers to be in or not be in
VRAM or GTT or sysram for some uses, and some devices require physical
contiguity. Solving that problem would require an additional 4 bits,
which brings us to 2.3GB of modifiers per format with the current
scheme. Not super viable.

The design for the allocator - communicating constraints ('pitch must
be exactly aligned to the next 256-byte boundary', 'pitch must be a
multiple of 32 bytes', 'buffer must be physically contiguous', etc)
separately from the chosen layout - would seem to fit this much
better. And since there doesn't seem to be a tractable solution we can
jam into the single 'intersect multiple sets of uint64s' API, we might
as well go through typing that out.

Cheers,
Daniel
