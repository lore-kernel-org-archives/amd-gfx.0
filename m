Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5772C87FCB
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Aug 2025 20:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BF310E02E;
	Sun,  3 Aug 2025 20:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKjPeLzT";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE5C10E02E
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 20:04:15 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so2873788f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Aug 2025 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754251453; x=1754856253; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=crjDEJ47TB6RTJFWImlfyk12yYwXMf1QHH/hh6vDQqA=;
 b=NKjPeLzTFCNRQYa3pJrTUQ7t+zqXA1GykgflmOmqPhJsaNDJ4zh7pMWNto/w9yqLxv
 xvgOmbu9KpmvaWK86a65nKg4NY5g5pscZYz4ND/M7puoMo1spBaFtemI8R4kMwZSQGjV
 a3bNNlyg5nDKxxlzaiIF0rVUqCgROYKZJNdOiRDKKif8880Q9k42w5cnqPZuOV7/ZC8e
 1zwiNOpbontg5yeHHI5cfPYguxIZoqwNDl2lbQVrPFAEx83jmGdGv0Trj+QWzTRyE4zs
 bYbViU2Uhlu5yg0jbLp2qHfUzTFZgva+E0ew+IgjAASloNNxU+eNlt1IypOzMRChjxyA
 UGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754251453; x=1754856253;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=crjDEJ47TB6RTJFWImlfyk12yYwXMf1QHH/hh6vDQqA=;
 b=Uza0iWT0+itaWzwcBbEDx7HGTTbCUUYTT7A18+J0DSrga7sJPPgjXR/m7ai8lwy336
 yOAIfejdWLMnMR75llP0bdi+0TQ1DF3yn7hDChPIPMpbBYewNQ9kVam7JcxpEqOxxgF/
 GZ26f9JhsfhP8jgZaCN+TbRq/Ub2hZBQ/hZ1j52uXKZTRfvNG/zaMpklPYpvb8YqHMsZ
 dE/vvjg1IkEHd7v7CgMYGSV8+ujH+MxUKBN/KKp+3XPs51Erx0TiZaEUULPDrzvgVQOU
 JogU2afhUcTipC6PGKEf4lirt0usKAYW5Mm1WvKRDFN+LqBWBS5r/Q3L7Qk/vJuSEcWa
 VAIQ==
X-Gm-Message-State: AOJu0Yya7acviMek1q7Ligax6mWSQWh8aHpOPQSzqPYc+O3WKWuj6KUr
 9siii8gwgYFse/yNfcG8kwG27xAZwsu0VjJwmU7J/YdRjC9gTtMoWfNe
X-Gm-Gg: ASbGncu+7IXBdXg0aA29p0jcFOXP9eLo1ex2UfnCzhAhA6XWjPrDt5eyJNqcoWNSi/s
 QWFt1v4QmZ8gKk518doFaksWXAgHoajLI9YttmLEACCbUmYJVepN1JEJyMyuiV0OsuksihF3iKn
 z51fx0ZCbAuTax0aoYom0S1auZmZti8m1OUrvG7uDJ156e+XxNvtIPMqwv5SIsVWo9xP0nnw1wk
 EfnUpx1YS/6rf6buy/nmlNWFXYI1uMaWvjpOCoC+mj9Vd23pteWBo+ixdgmxXUZ4EMIqZw103Th
 yeP0toAFQINu3pV0Hgaq5dtJU8xQ1TYLHV+vIFDf9sqlG+CMoDtyufWH8n7RnOWHrdfdyEvNuJ3
 6dH/5GgNF3U3wTuOh9SZJeqbnpIB/OG/Z12qyfjTmDMEfXb/GA8CUxyME+ePcjwNPwzhC84O9Bz
 DsJiup5Yzt0F+HLT/0uUU4kYMtLbZd6IsJFDWUKWWTyzsrODPijeQSoFT2TAY3lA==
X-Google-Smtp-Source: AGHT+IEo1teG6WQOyfD412V7mX6z9LVf0heTJemafdtm/homOLR8ujreAoSyNaiDVFS6KmiM7xd7yg==
X-Received: by 2002:a05:6000:144f:b0:3a5:8d08:6239 with SMTP id
 ffacd0b85a97d-3b8d9474fefmr5450286f8f.21.1754251453244; 
 Sun, 03 Aug 2025 13:04:13 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47c516sm13153103f8f.62.2025.08.03.13.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 13:04:11 -0700 (PDT)
Message-ID: <dea7bc605a67d3d5dd910bed2c54085c4cc97d56.camel@gmail.com>
Subject: Re: [PATCH 10/20] drm/amd/display: Implement DCE analog stream
 encoders
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Date: Sun, 03 Aug 2025 22:04:11 +0200
In-Reply-To: <CAPEhTTEYcD4WmweMwBWHkawxxZzNCZgJPAF3enL9-_nJxh2HCg@mail.gmail.com>
References: <20250723155813.9101-11-timur.kristof@gmail.com>
 <a90cee9d-4be0-431e-abf7-e55da92c42d5@gmail.com>
 <CAFF-SiUrWyz68xPd4+mRB1SSr0F-MO8v_s32E-gw7zkKPS7D1w@mail.gmail.com>
 <CAPEhTTEYcD4WmweMwBWHkawxxZzNCZgJPAF3enL9-_nJxh2HCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Sun, 2025-08-03 at 12:10 -0400, Alexandre Demers wrote:
> Hi Timur,
>=20
> I agree with you about the coding style (the prefix), it was more of
> a general comment since the style is inconsistent with some other
> parts in the DC code.
>=20
> If the code applies to any DCE version (even though it is unclear if
> any > DCE 10 is in the field with a DAC), then it's good for me. My
> only remaining concern would be about encountering one of those
> special GPU cards hardly testable. But this seems unlikely.

Hi Alexandre,

I'll stay with the current style then.

I would appreciate a review on the rest of my patch series too, if you
have time.

(By the way, you can convince me to do some code cleanup too, after all
of my DC related series are accepted.)

Thanks & best regards,
Timur
