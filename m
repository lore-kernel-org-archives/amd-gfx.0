Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF117F8DFEA
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 08:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C0810E94F;
	Fri, 17 Apr 2026 08:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hs0EBQnr";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E9510E94F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 08:36:44 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ba840146so4340635e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776415002; x=1777019802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e8RX14GBAMHHH5TyQ4Eg+UtaJeTWduPWuOMQeyRWh9E=;
 b=hs0EBQnrBlKuA1cx24l9qqBGHWiuxpCAcggDl3e+NKwN0qPJcKXR+BlIMIqEp8nPTp
 qHJDymTEyfgnSjR6h6rB4pDYD3L3HWo4bWVtcHYg59a96QJypIDTW8wg4q5f7lgQtS8J
 Q5Sjh61XwZXCoFxDoDt8abuqnNDBmp4mh4LReflgVxC1j4YfVEgT0j60tNdB6H+5R753
 a5Z4/Ei25xl6Y16W83apYunmgEGOE2XM62HbqwFolztVr4bzsO2NhHx9Ypn4ZRiZvktX
 257VEOFaq0iqSSZy5kzmW+YmfG93Dj0LTYfFYsuWKyXtA2inJW7+BbWy4urI2AKcdL+B
 RzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776415002; x=1777019802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e8RX14GBAMHHH5TyQ4Eg+UtaJeTWduPWuOMQeyRWh9E=;
 b=XIOlOyhq45EmuRiIYXEscBRCQ8+8zGYN9hSr7Ynk+jS9huRdQOmDS/LPL1khFqYB2T
 fgmWX+Hey3ACoSZGQxXYA5K+tz4sbX653LPX74u+l2oovRFDY8y17HComPidboejyrU1
 UIX7R5UFHh+JMLquLzfUro1EcM+KE0p8jfHc0wur+nfuHlUXNpHLh8hjsNriZzEX/0Hz
 zYnnMDiPfqeN7vtxjHUIR1pz0l6yISUWXisicyfVUQYMmrNEY5bqULnKYRa8twuXwHHS
 7iaSuhgXIQaHBY9HcxS0pvTMTVEgOwMfHh6t7PQ3iKUaGCOyJ83TXIMZ/tGfFJTPkDYa
 UDYw==
X-Gm-Message-State: AOJu0YzsvawpZs95uSY+MAwEjbFQ8+7GTdayVgaKLjnaJqcdOqLYHWuS
 n0xDbnx9vCiORIFKTqHmo3DtelPJZfsHcjTXQgh5nmIqwI1bjYBVLH3hDQm1pw==
X-Gm-Gg: AeBDies9U0j6r8VhAlcFuBW7XMz/5QHmH1BurHjw6J9OnQqJA7qRxGZCfGyl72XLk/n
 o1+QyYwO5SICio0Zq4S8buWpzyGV9Wsq45l3KhhGbjcAGJ6U6dFsXGfUZNsgCYVC1/tGNjH6IN/
 Va6Px8gtnPAeBbUuRKOQdRDB6OcnrM0AEoqfB0F/fbRgteXhTYeTEfgJoDABDTjbVcRTtH2mWbx
 pypOE+HvBn+LrcMrtnWtSSkt6OrKiyg1NGhVMhq498MKOGpcC+k7JGbhvIeLFgoo0cqfjcW+8iy
 o/0bYiTGSefr5p7tXv4nHaPkICef26y0ra7EE+10kHHv2cK1C5v9ttO/wZNeqIuNFFhpSTGp1X9
 whVJUYmnEoEzydCL3+8r9Y4NGAohzr/hfWEwiAQSa4LAN3x9pKC719V3OSZyTB4IJgv0jf11rBm
 WCd2ECgT6k0slKyldjYEwOtHa3I32MA74qZB+sJonyyVKols/1jNSFSlLiJWvoRy1RlPDWRJLZI
 6CHwifdn8I=
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488fb784843mr18069185e9.24.1776415002123; 
 Fri, 17 Apr 2026 01:36:42 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1070bfsm27989615e9.7.2026.04.17.01.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 01:36:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6/7] Documentation/gpu: Add TCC,
 update TCP in amdgpu glossary
Date: Fri, 17 Apr 2026 10:36:40 +0200
Message-ID: <4874819.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <b7656601-bbcc-4dc0-bbe7-7ebe8e5ab777@amd.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-7-timur.kristof@gmail.com>
 <b7656601-bbcc-4dc0-bbe7-7ebe8e5ab777@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, April 17, 2026 9:24:55=E2=80=AFAM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 4/16/26 22:26, Timur Krist=C3=B3f wrote:
> > These are the L2 and L1 cache on some AMD GPU architectures.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > b/Documentation/gpu/amdgpu/amdgpu-glossary.rst index
> > 033167025fcca..d553dd599c966 100644
> > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > @@ -233,8 +233,15 @@ we have a dedicated glossary for Display Core at
> >=20
> >      TC
> >     =20
> >        Texture Cache
> >=20
> > +    TCC
> > +      Texture Cache per Channel - L2 cache attached to the memory
> > channels. +      May be used when shader cores are accessing memory.
> > +      Despite "Texture" in the name, this is used by any kind of memory
> > access. +      TCCs may be mapped to TCPs, depending on the architectur=
e.
> > +
>=20
> Good to have, but maybe put that below TCP. E.g. L1 first and then L2.

I prefer to keep the alphabetical order for consistency with the rest of th=
e=20
glossary.



