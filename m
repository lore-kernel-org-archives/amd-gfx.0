Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688E4E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 10:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB4D10E3D0;
	Fri, 10 Jan 2025 10:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dbVNcgpy";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E08910E3D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 10:02:42 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso14038555e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736503301; x=1737108101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltjS9ITrru3VPzU8iMRu0ZlmsppJU3x/QmRbCvj3YcY=;
 b=dbVNcgpytOoqzy0sZgdqWzA2fP40MQkV8Iv0YG0R2R4x6zyLEZ/fqHOh4iqqoqZWqc
 qXcXj+uQ8XBTJ76RCRUah3gQAFcIvDsEIBMl/s3kgBteqAcAiZlACBDFi1SoJlc7+MZ6
 YCxolGTWZ2nHqyL0ZlVSaLPHCuLQeIMAZGm5g219edhInrEPyrT9GFz/yobL0pIFOrNC
 /FdPntnfBC1CCGPlneZId6inC+Jr5jzwkfUTsxF2giIlZ3q1yG1rGKXJMvwSlheb2WsJ
 ql0kPy38cNU6XcTXBUMw0ImnQPwhk/uhIXFDd9gio12naIMdGPcC7t4aueGWwzz3ppZ5
 UYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736503301; x=1737108101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltjS9ITrru3VPzU8iMRu0ZlmsppJU3x/QmRbCvj3YcY=;
 b=sbT84Ul0/PluloxcHN0ionH4ty2sTt+5sAfyC3Xj6F5cUOdA6KSYHpKiv5c9hCefVL
 GYUXEbHLoudkINp5o/UL3KGw2kwx2O34sSx6aSav7oAPGpa7JX2KqAZTyZOFjTySMOor
 H4dpfO7DRsK2Y4uMt/siS0lBMxtFNPY3h+A+wUIWd4HB7Qs29YzTaghHgfGrMTCfxho/
 jDJX706RKYeTxGjeX8cMKh6rLXT0au4J/VtVz39VYBo1/g/i0gUojkMRLcksCePGRBF9
 Ha/uQAGQcCN4f2x7SubxteAlJnIN6E8T3jk1yIuewcP5Zt0+uer0P1ocYPOn5kz0bcFl
 sEOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVUdsRgT4RWEDdACUYposh4av87ncEEnMMdsXBhLBzEFHBeZ/MB+1zj5qbZ9gRdN9RJiDAPyoN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZEWhz9KJpz6HG/HuNNP3Vo6jbykTeDjCbHmvqEhRvXQkdfITR
 bzKmn/Bj07/kfa+dY6cac8dFErMfdBUL134d4op2QI9IxA0O9G0AAKCXQBL1QDSWkJrbGA+p+FM
 JAsOI8g9m6JaNOrgQfsQfVUunHS8=
X-Gm-Gg: ASbGncvV7d1lQpMro7enClOensWdif7vQVAs1vSAkT8KdfCx9+DqsTwcX6mMHKHnfqs
 ESvmbGYMIHwqDhKTyNZ3fM0GpzlW4H5atjpufjN4=
X-Google-Smtp-Source: AGHT+IFg9gh+ZaiDKRtHGI1x3x+Vc7T8yvhFwWXUKy/L3HyuTbzKxNy8RzQkk/QBq/ILWrd53Ddua8VffcxGc1kZXQU=
X-Received: by 2002:a05:600c:3588:b0:434:fdbc:5cf7 with SMTP id
 5b1f17b1804b1-436e26f4aecmr81992755e9.27.1736503300915; Fri, 10 Jan 2025
 02:01:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
 <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
 <CA+b5WFFkhQUcFO_45_6xmC4fk_GEFqbASt9rhGqBBYsothsHxQ@mail.gmail.com>
 <ea8468ab-430e-4336-b1c5-6f6bc566950b@gmx.de>
In-Reply-To: <ea8468ab-430e-4336-b1c5-6f6bc566950b@gmx.de>
From: Mischa Baars <mjbaars1977.backup@gmail.com>
Date: Fri, 10 Jan 2025 11:01:30 +0100
X-Gm-Features: AbW1kvaVcVVbw5zRAzx8uOOsYdGfQcjkRFsnwDrEDiXOjFPF-L7d5EzYI-55bX8
Message-ID: <CA+b5WFH6e18oJqCOokKpBVBqOdAHCiN5DUUfRz29h2bWLhKx3Q@mail.gmail.com>
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: Armin Wolf <W_Armin@gmx.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 platform-driver-x86@vger.kernel.org
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

On Thu, Jan 9, 2025 at 4:08=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:

> Sadly the HDMI forum only provides the HDMI specification under a special=
 license which
> prohibits implementing it in open source drivers.
>
> Since membership inside the HDMI forum costs 15000$ annually, i suspect t=
hat the HDMI forum
> is abusing its power to force people to join (and pay).
>
> I can feel your disappointment, but there is nothing we can do which does=
 not land us in court :(.

Let's hope this will change for the HDMI 2.1 specification when the
HDMI 2.2 specification is released. After all, I already do have a
software driver that supports HDMI upto version 2.0 (September 2013).
It's not like HDMI is entirely unsupported.

Thanks!
