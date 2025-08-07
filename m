Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207B0C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 13:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D6810E845;
	Thu,  7 Aug 2025 13:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hXwG+Q5K";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55210E848
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 13:22:40 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b34dde96cbfso164663a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Aug 2025 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754572960; x=1755177760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBLgWcNdKKL+c6CWz+xLK1vUo5/I98i0yfBsTzP5b0c=;
 b=hXwG+Q5KNQ7vlElioT6TOMamx7g+Acr7dMt28QtpwhF6PcOtNNcHcNjwRHCZyDgUjo
 rTRfQImSkT4VhnXhdjB3bDj8xDo7hbJxhxiDraoFrNuh0/KofnG0hhrNzlP0o6QNBseJ
 MqUxx5QSiUvpYwObjIPclsNruAKeNBmDvKj5LfgzYD9wl0sMyOSiUO3dlzlY+pG1bHhR
 7ueEqBdORsigHqC9uVvoKDqKZetbjJFHSdJEg6VfnAfMYWaY37uq7R+MnME7Tex1E+i1
 uG0OBscqhvudv9dqTXE/pnpf9YMPpU5nU3wgkHYZsb+H6PWX7sDwhNRy4XcrEdgGLymB
 TVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754572960; x=1755177760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBLgWcNdKKL+c6CWz+xLK1vUo5/I98i0yfBsTzP5b0c=;
 b=EDOHx+jw3tH+3S5RHwwMs9hNqIUnKS6n+zwi5LJqjfTz8z3mnceZDHKoWDiMJDbdrT
 vXru2hGc3UqqLeLbKmoSAnCF4BkuqMIklJCRzRjp4eRN2DBkhg+SFoEYmuy/bc5Dv+b/
 7w4q6j27hCqtxYdf4Vq7Setna1XWDMT8BOkSjxxFXqsPdIOm0Rwxhw7C6GkHWth2QY9v
 Rzpfm39SRW3KCwfkqta4cCaOd9LI3UObA5AVkzzZGkeYKwJkDJE0WKA78HfcCkC22auc
 1VkQAAi4rS410S/a64+CaedZOSpaZTlGlPqv6owgzQVg3NBU8Ugc+oIvCs6WGxlIvkfh
 myMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0aY6eZolBe+sw9p+plv7/7RKYRpYJdYzqVHtFXuw4cZ5DU+Cr5ZXdEfxoMhhEl48RX92dAjoB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4fwlxU9anPfGummgENgNUwtzH9IJFKUzZ5mC26rGKxl+WUCL9
 7SizneiThy8QTInEdtqAR1r1u8PMMnB2tBjy1iM6/bHarhgpoHnnZDHTSDCk7D9c6C4NZcCpAU7
 vBhZ/M9gjo3c0eNFPs4PXisGzgPcZfwA=
X-Gm-Gg: ASbGncu+h5eLeSOzawmiXxWBXSNfygCN0Ika/dNoh0GIG7gair09tbHa3J3aKkygofQ
 hYxIWPZYQ8kNf6OsSh7bUh8RHz7OFG8Y4d5PvU2D7Ph536kecz/F6G5+lHcKufKxFfo5HANsJLm
 AVgHNqFUd2gVbIAkGojxlxKJ/MWyv7ziNPV2Kh4LiHPlkCnnxQB6o1CJBxxisVnLevlLRA+IMvi
 T00s5kxigpp49daQQ==
X-Google-Smtp-Source: AGHT+IF8fR/1l9ddcOZBGbCKA93yu6s1R/ihS2oTPPuTR2cJ59KyKeqri4LkhBkM/c2KNFRlrjO7glXwzyyQIHjvpfk=
X-Received: by 2002:a17:902:eccc:b0:240:bd35:c4ec with SMTP id
 d9443c01a7336-2429f57dee5mr45038595ad.6.1754572960214; Thu, 07 Aug 2025
 06:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
In-Reply-To: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Aug 2025 09:22:28 -0400
X-Gm-Features: Ac12FXzuJJkCN1IGOiozt5mLOba8o-9jtwNjiMmaEbi49o_GzeP0ofj_YABcV-g
Message-ID: <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
Subject: Re: Is amdgpu open to converting logging to drm_* functions
To: Brahmajit Das <listout@listout.xyz>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, sean@poorly.run, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Aug 7, 2025 at 9:13=E2=80=AFAM Brahmajit Das <listout@listout.xyz> =
wrote:
>
> Hello Alex, Christian,
>
> I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
> TODO list on the kernel doc, and specifically this section[0]. Would
> amdgpu be open to this conversion. I saw that before starting it is
> recommended to talk with Sean and the relevant maintainer. Hence I'm
> emailing you folks.

It would be nice to get rid of the old DRM_INFO/ERROR/DEBUG macros and
replace them with the dev_ or drm_ replacements.

Alex

>
> I guess you can also refer to this,
> https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-da=
niel.vetter@ffwll.ch
>
> [0]:
> https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-wi=
th-drm-device-parameter
>
> --
> Regards,
> listout
