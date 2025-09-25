Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864BACAC5B5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 21:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A3E10E9B6;
	Thu, 25 Sep 2025 21:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqHFmh9b";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9E910E9B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 21:43:19 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-26987b80720so2124885ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758836598; x=1759441398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nOmLFKOAIMSQlGVMu0WmYiSo2ie0tBhJBjaBM6mUfo=;
 b=SqHFmh9bSG1IJoGk4oTbKhjXSQTuDaGmysEhi51AwQVcC6TrEQ+02vwWOMbtBTd/3u
 wSKiVV5omEYNDC8YtoGVJ383gqew8wjS9VSG5qCynjaA1nPZcIg8wf9nOJe1Dz08pdAb
 lGL+zphD0t154jmJ1IsxXLK59tMLYeXdi4/K0f1oUuTLNH+KRsIEggme1TU3Mi9a0XBs
 S4Pdn6Hh/bXhFfEmeLYgaz+6y1FuYvEa4xw31hfi1lXOKY9/TnqoJ0F6GFepw8a+DwOw
 6aaOZX1F8aiyvfdNKqYCR6BHOHCx3Oe2Gh3Iz81/Kw2ZUszOP/3i7h6QumFOpgDce++p
 cPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758836598; x=1759441398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nOmLFKOAIMSQlGVMu0WmYiSo2ie0tBhJBjaBM6mUfo=;
 b=pdtRZ9zgfDivIG/hwMQV3OvopzK9PfzfL0qTBCthBqV6YvKU7IzM3ZOdwGNb33EiX2
 Rsf3unxLg2hzcmhxL99cJ9S1gq8tGKra79nn2ba1GiAa7FyAa+OpBoa5rEK7NZgLCMP0
 uvyF7ea27REZ60MuBX9MToYPtCAqTsDGE1kNG5PTsk78F1kqlMOnTnupvG0UFjWQ5uEm
 +kFN0cCb4RrTy19voVyPfYilnO6sQTEROEgdugd5NcKX5bMligLkrnsHWjjZrDy8EnZp
 TcN5HHL2xYNbimddk091ApoE8w8u7mJ2Zjppyy6oTTqFcjIpLTr31AM4INtAImRfp4/k
 mzcA==
X-Gm-Message-State: AOJu0YxBKl/g3KFWv2orxqtQdLf0pVdDi2VNs+7Y7/YzeQfnCq1UcI0b
 31dPQbU7F/OGu9hrKdgI7g53gljtQU76S50iSdA3gx+dwpUj2Z3EYvbYfPsEwBd6sEqKdXLZO69
 XJnRHiVvQ9T1oPXdNssbX7ZaJkrcqaOH7zA==
X-Gm-Gg: ASbGncvZmUIb7lbRB7E4Xp8r/H44/pKc2KW5foDQuzO2GeoKg2mkJqU13UwzchoXHXd
 kLyHLVsz6udQjWHnC2o5rLTK4oZilXzgtpwxvfeQnRbWFfEzbxD/uXbxWqAoAvXLeC78IR4Q163
 g4CLjQr4EmZaBC5s28jdVFy08NuVtB4AWkjiXAKIdYFDXI8RYBrix1K80QYXEA55SegDGSiFtJ5
 veLdYU=
X-Google-Smtp-Source: AGHT+IHEq0yWObrzzYTT9yVIXUcrJcLI7e8ffCV2b3wy+z21xQm64/CByJuVwZvSGuXmJueFKRlbbZULR/CJChKVfEM=
X-Received: by 2002:a17:903:238a:b0:27e:d4f1:fe72 with SMTP id
 d9443c01a7336-27ed4f20977mr32735785ad.3.1758836598527; Thu, 25 Sep 2025
 14:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250925184525.43290-1-timur.kristof@gmail.com>
 <20250925184525.43290-3-timur.kristof@gmail.com>
 <CADnq5_Pq2Tm4qW56QrY7DTr0_8h40gn3SdNeMyz=zqj8=D4UNw@mail.gmail.com>
 <CAFF-SiU6eenb39GdZUuPK=4Jf53UqWU05Lt3oTMtie0EtYkbRQ@mail.gmail.com>
In-Reply-To: <CAFF-SiU6eenb39GdZUuPK=4Jf53UqWU05Lt3oTMtie0EtYkbRQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Sep 2025 17:43:06 -0400
X-Gm-Features: AS18NWDuU9tai-DYTw-UNw3itXBdch2CEE3VxNgMoAYiq38SCKDjt08w8h0bR0E
Message-ID: <CADnq5_PeLv7_oS1CARaHMet+te0JP0z3=hrnx3oh=EG+JtuiHg@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amd/display: Add missing DCE6
 SCL_HORZ_FILTER_INIT* SRIs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
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

On Thu, Sep 25, 2025 at 5:33=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
>
>
> Alex Deucher <alexdeucher@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2025. s=
zept. 25., Cs=C3=BC 23:28):
>>
>> On Thu, Sep 25, 2025 at 2:45=E2=80=AFPM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com> wrote:
>> >
>> > Without these, it's impossible to program these registers.
>> >
>> > Fixes: 102b2f587ac8 ("drm/amd/display: dce_transform: DCE6 Scaling Hor=
izontal Filter Init (v2)")
>> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>>
>> I think it would make sense to just squash patches 2-4 together.
>> Other than that, these look good to me.
>>
>> Alex
>
>
> They make more sense to me individually but we can squash them too. Do yo=
u prefer that I send another series with these squashed or will you squash =
them when applying them?

I guess they make sense as is from a Fixes tag perspective, but from
an overall functional perspective it's easier to just have one patch.
I'll just apply them as is.
Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex



>
>
>>
>> > ---
>> >  drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_transform.h
>> > index cbce194ec7b8..ff746fba850b 100644
>> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
>> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
>> > @@ -155,6 +155,8 @@
>> >         SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
>> >         SRI(VIEWPORT_START, SCL, id), \
>> >         SRI(VIEWPORT_SIZE, SCL, id), \
>> > +       SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
>> > +       SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
>> >         SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
>> >         SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
>> >         SRI(SCL_VERT_FILTER_INIT, SCL, id), \
>> > --
>> > 2.51.0
>> >
