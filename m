Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1441E77188
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 14:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828CE10EBCF;
	Wed, 18 Dec 2024 14:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmMjiqI2";
	dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622FB10EBCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 14:50:48 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fbbf456a63so335931a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734533448; x=1735138248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+Tb42HHv0ikkV2gYtHoTJkW2u7V1Tsdwe5E+MOaFLE=;
 b=VmMjiqI20p7EliddzbLlI5smz5YHbV/wQrzNc4UYqvIAXkKnQnXc2XYsEZtFZuh6o8
 F266vw0MMO38im2FoPjTfjlC/qVuF9j08H2cegZ5OFXhg+xJPn9b2dgai9A5K9vJS77O
 +eYlM99qhjzbMKt65anOOUrpnG470VpgtaZAwynrNgGhOhVNjQBmpP3Xne+c9xB70ZYU
 5FfOebO5aar7+8TND9H0LvVNaKrOEn97uabDjd7m9hn+Mz2C1BM0FtfvQsbGS9PXXBz3
 LIu4jDEwXmU+7Ew6srZJv5+M3YHoZKUES5sw3hhKgH2NC/gNtCcXFw6jItydcAfaWNKv
 TyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533448; x=1735138248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+Tb42HHv0ikkV2gYtHoTJkW2u7V1Tsdwe5E+MOaFLE=;
 b=V7bqBvDYpmoFd2dxROk6Kn05x4UXsqx4hg86sMdynihiRs0eAdtuYDim3G2BZ+Iya0
 YJA9cHSnOWLmQfFIN9XSfHZiYt01u/gxDICmlfrbrkDYISynKtRcectioXyLqImQLYWz
 LyYOQkeozFVu6GMWkt8h+1lL+OpNm2vXWs604yYBF6fiH3X5APPJgf3QFIetxlPIEqFm
 Ev4rdk1s7yuMg4cj0GdD/eYylYgZhddg8XN88WCvuGt7HQ+BnEbPiZtRZiz3lmP3jruW
 N0YyYp4y5p7Kqt6wpRSZyajJNrg6omEtPuqlWcPrnbNFVdHBiZV66iEl5T174gbL8pgx
 nD4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUNV+8e24jTH1eWOANogbDoZ/kaDA18DKcUBsga4NaxC25HGhrIwfLZbo8fCJ1/DNDZsYe3cdm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDAGExnTRrY80kkDzc715q9brjiiNq0Q2agngglzZ8FgHst4A7
 YUTS9cQRcRMqYFP9QIQXfI3v19zHOUE2XNxG9sxh4EnLGywUfbPYA1khhOuP/odJw2clULCMVTQ
 0eNtG746xq0oL7d1GmmZlwakrTyA=
X-Gm-Gg: ASbGnctGQr5y231rpULje5OXuJ6E0fcagzGaJXFnnJdeF9+eQ1Uot9HzhNrDpacqjUT
 HI+KwSjgy/W/XSv8k2eZ7inm/SeLiJTtdGMTyNw==
X-Google-Smtp-Source: AGHT+IGDjooTF9T6w/jHHLiJX2Q77jAzaoZUlGfesmuGoPzJFpYve+2b36VOWXA7rCmxIYhHcl9MFH3tIBW1RhTBM8c=
X-Received: by 2002:a17:90b:1f88:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2f2e91d4db3mr1753508a91.3.1734533447783; Wed, 18 Dec 2024
 06:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20241217172256.3668-1-michel@daenzer.net>
 <5a88367d-22be-45b5-921d-a9985a56357a@amd.com>
 <ad120081-8ad5-4acb-8fbc-51f042fdee63@daenzer.net>
In-Reply-To: <ad120081-8ad5-4acb-8fbc-51f042fdee63@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Dec 2024 09:50:35 -0500
Message-ID: <CADnq5_OvXjaLo1g3-Q8MsGxE8OQaCHMRmyxVWHnhRz_YeJg0RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in
 amdgpu_vm_bo_update
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Wed, Dec 18, 2024 at 3:59=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> On 2024-12-18 09:32, Christian K=C3=B6nig wrote:
> > Am 17.12.24 um 18:22 schrieb Michel D=C3=A4nzer:
> >> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >>
> >> Third time's the charm, I hope?
> >
> > More like the twenties.
>
> The reference is to it being the third time in amdgpu_vm_bo_update.
>
>
> >> Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
> >
> > Please double check if that code wasn't introduced later than this patc=
h.
>
> Checked before adding this to the commit log and double-checked, d3116756=
a710 modified this code, no other commit has touched it since.
>
>
> >> Issue: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
> >> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks!
>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
