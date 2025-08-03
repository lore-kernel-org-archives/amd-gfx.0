Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5C4C87FCB
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Aug 2025 20:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C6B10E06E;
	Sun,  3 Aug 2025 20:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iqKrkf0e";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2E310E06E
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 20:08:08 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so12151965e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Aug 2025 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754251687; x=1754856487; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5rfE9XizxzYHhGHJpdatqE11cFZzfhNVbW8M+4bRpB0=;
 b=iqKrkf0e/xIg5mv2/IdRMvhzrJi4M2X8hB+1MNX8+//raAp2XPV8Kuo3+4yHIlh+C5
 4hXIt5dNzUyGOMTTVgOpCj9fcI0VkwG+cIzlyESbW+gosY8iKBm9mexHafSUbb4wfgYB
 LjS7Ws+Ep5LPByqXeCFpJ+Pm+e8IhjGqdWHVs/es7H9e4YzenZ8AzszSjdvVYCkTXaJ4
 j1kSFSe+/vW3dzcu70HwccFIXu3lW4eJZv+q1n6NyJem3GGXFK4t9Ix8SD2I3Fy2Mqh3
 fncnbctY3frC69c1njqSXSifsuaBCzh5jei6UfiFkCbyU/6PY6Fw8zJLeB6+r7zsMGCT
 YhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754251687; x=1754856487;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5rfE9XizxzYHhGHJpdatqE11cFZzfhNVbW8M+4bRpB0=;
 b=vszJeCGDjjU/8+tg8QEMsFW+J07eJRGLtXO5JdDPXVHew8oe1w0sYeVFN5aJ4Ynhtg
 jIvuM+UFX/TdNEm40+2TBDU0BN+XEHh2Utln0Y+ijV+pnZycebEOkRAKhYjFjmIoTeA5
 uxuV0xFog31ezYNuE9GE1NvSm9KrwqtU8aI63AWB4vINQO0ZH6TC6JkDMb1VY2JiPVd5
 ONQi30ZNPSsSZ+cOwqhp9bKigMXAVEeo9s56IUerNoFGNRPl2VN4sIkniOtj/CgdttxY
 crpShhbqHLVa3JHc1WW7BEsihyDk5u3jqbH5kUAdyKXaXNv7NcsDX8gtgb2uUoDwGTk7
 XhkQ==
X-Gm-Message-State: AOJu0YwnNYJ7jeKsbIojqjHXeSJGHnnKQ4Q7QjuJ+WIKjLI6N0kxb7Hk
 6E/ABzw2OgCDGs/O3F8tcrf2dO26fF7Y/tt8QesPFpdiJVpDL/npwXse
X-Gm-Gg: ASbGncu9EGfK4fuunWt/Q5UDQlva3twyeUcFelH/Hw/qLuw0xjPSIOsJA7Zw1adl/9N
 2ROb9iyqBb5sWqOe591YG0xoItlKUNh7exOeqPTMdi17Fv+9xDm7aqJMbKgdtq5PKN+FZtKuKYe
 hWw14zpUZ+bP5PwjChJa+4AejIVKsJ0c5AtJQhsc83xZjRHHtW50BRICaSbjT1pfiSMDo826M66
 QImolwZ+haOLlZTpeipx7nCkWQlV1YziOJ+Xfp0UQZ5gMP4S4+TfsMeVCKKndFJvvHqu1z66fY3
 sk7l19zfX07eN6AvJD1FjLAOHIS5t6ssnUppEctcN9MZiMTjCYCDgbriSR299HA9MnOf40BlvVI
 5oxVl3SDszHvDgFrDlE9lDNvmVzG7ySOptkHMsqWymBHOheKskYdratdu5sXfarxxj9e6uviEc9
 ahbtsfMuyE7jRwk+dpFd9pQuPh1GooVT9heJbfra42UulrcgeqbUm6kLUCecyaPw==
X-Google-Smtp-Source: AGHT+IHf9a+f132i0hHcCKLBAk7tg507Ap9uu9xREdFhmpJq6kWGneNSY9JxSJmUs/9sLReM9a/JTw==
X-Received: by 2002:a05:600c:4f50:b0:456:18f3:b951 with SMTP id
 5b1f17b1804b1-458b9bf7efdmr55898145e9.15.1754251686999; 
 Sun, 03 Aug 2025 13:08:06 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm13064324f8f.25.2025.08.03.13.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 13:08:05 -0700 (PDT)
Message-ID: <098b22431f51d462860459e443210ab16e8b90fd.camel@gmail.com>
Subject: Re: [PATCH 11/20] drm/amd/display: Implement DCE analog link encoders
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Date: Sun, 03 Aug 2025 22:08:04 +0200
In-Reply-To: <CAPEhTTEy9J9_zza9p-pnVVMGcxCrKkfOAdy54YVkJofCsNJTsA@mail.gmail.com>
References: <20250723155813.9101-12-timur.kristof@gmail.com>
 <382a6232-c500-4d5e-96d4-0444947130ea@gmail.com>
 <CAFF-SiX_FipFpaZyQaFEE5raFN2zz_yQPYUkBq2kRzLP1PHyZg@mail.gmail.com>
 <CAPEhTTEy9J9_zza9p-pnVVMGcxCrKkfOAdy54YVkJofCsNJTsA@mail.gmail.com>
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

On Sun, 2025-08-03 at 12:26 -0400, Alexandre Demers wrote:
> On Fri, Aug 1, 2025 at 6:02=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Hi Alexandre,
> >=20
> > With regards to the coding style. I already replied to your other
> > thread about it, let's have that conversation there.
> >=20
> > With regards to the link encoders specifically. Due to DVI-I, we
> > need dce110_link_encoder to handle analog signals in addition to
> > digital, so the question about this part is, is there any need to
> > have a separate dce110_analog_link_encoder? When I wrote the patch
> > I felt yes, but now I feel maybe we should just let
> > dce110_link_encoder handle VGA as well.
> >=20
> > What do you think about that?
> >=20
> > Thanks,
> > Timur
> >=20
> >=20
> >=20
>=20
> Since a distinction is already made in the code between digital and
> analog encoders, I would be tempted to go with the
> dce110_analog_link_encoder so it may be just easier/quicker to
> distinguish what this part of code does.
>=20
> Alexandre

Well, that's the issue. The distinction isn't really there:

- dce110_link_encoder does both analog and digital for DVI-I
- dce110_analog_link_encoder can only do analog for VGA

At this point I feel that adding the dce110_analog_link_encoder just
creates unnecessary confusion.

Since dce110_link_encoder does both analog and digital already, it will
make more sense to have just dce110_link_encoder. I'll make that change
in v2 of this series.

Timur
