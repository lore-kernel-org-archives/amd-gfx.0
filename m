Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E0C5AD5A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 08:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B1810EEAB;
	Wed, 12 Aug 2026 08:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="foub3Zzd";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E0010EEAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 08:00:27 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso587870a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 01:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786521626; cv=none;
 d=google.com; s=arc-20260327;
 b=pPO3fGl+/L10m9dX0ZVZ+1HE9KTk0lPfxgP5+fjtpsPV3chD+nzWZ4XPkcYWGwCLyn
 sqy6R3Ws8TodOp6P+Oy1EQHLvIm4aARJ+Jrohg2HAokBPY0d1wUQ1tL+ZpP8mrlQXOlg
 JtHOTu091SmfyfXiWxrJEdEA2LRD2ylZOXTKqYNHLd2BXwUNaVep/hDGq05cpNt0LNz7
 CmIMwJFuIdu/erAQ1pPWVGQDScX9MB5NC4z/IGjWp+hgj+3U+8fxXjV9X7f9rc/VD3M3
 2hTxjObgoWyAx6l+Fsf5ow+8tlXpJjTECeeCT5AMdcYuQ7uIYkJO5DBwIqn7HINvhi+a
 PUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mvalizAxp21DBKeIlbkk7mK/eCXx6Z0bUW51GnmtBXQ=;
 fh=Qty4EKK4rmMugCvjWd351KSI0ptJOGpINmdM/vXeeSo=;
 b=Hb3pGnkd3YbQBDIprEp4sRaK6yhYYJ5aQFEL6v5ww6DEH6Z1e0ExViVX1hBEEjkGuF
 N85CCs47iSUQ3754Txqu3nkOLw6WCQqzHiMtt7ItpqHQv2Np+ClcY6p7B8G7crHuyULn
 ZtPmLicH2fqwL14M2A5CfgQblGaztBDbGtm6CMI7r/BcHkgvba5KZbigKxmDZxM1Mx9O
 C7qNoNQSW6GtC70YB0evOLrriewV1c46Flq9u1qUmI68+Rm9z3QzxuQlyE8NjMpsv+hq
 fzzuU9vMKs3W+FUqeH85t3DVtaaQPH2L9ducp1QiL/SYQLIco9AqD/0fGkv0SEgVlNJ7
 EtVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786521626; x=1787126426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mvalizAxp21DBKeIlbkk7mK/eCXx6Z0bUW51GnmtBXQ=;
 b=foub3ZzdAruU9Y4vbdyLrsA0vJNbC6WmhnB8vvoyizWHjetqelLYCL7E+bLy6USq9G
 B2zrJjp1hram7qeaWFyP41ryUbW/VZH9+gQcactyWNBIvaGWjQBc3MTZidKl05JuxPmi
 8zB3NfqLkCDCHxjNsdFDHV0OKFfFRzMvvO1Njv+leFkZ5X4rn/pHxyglhJ5IoxFiXAq4
 4ePpNPJwq1vvsl4prUNpUvYKF5TjanaCAD9qOZQGgtpWnvyMd33Ov9mZLp22S+O27DhZ
 UW11XTrw4R4JTNpzG+pH3xazlrcZFFBkM7qz0Rm525bCqAAfRo4zo7Yl9LdhGDVJrbKX
 Dj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786521626; x=1787126426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvalizAxp21DBKeIlbkk7mK/eCXx6Z0bUW51GnmtBXQ=;
 b=fBRcvv4L0SVT3Y6jtJqS6hVX2apmW0ZjA/Z5j1e/WMBvI5fVPS6oRkT11Iz+N+hYB4
 nqYpDKx+ZdxSr8wT8oW2FB4rmT3/pwC6mttTw97xQyE2ZirYkpqXdfDNEKg7YHfcCQx2
 IcQct0DhHQ21NRv8aUCEdoeOwxwwURAwQ3ByKauay3RPMEyUo5eHxLDLuHf20kQnl+4M
 Hfk8WPY7sGzAtv6prLXWmWPlFWKoHhfE/xeoLDh1SV3ub7WJ3b73UwMJvX4XBZwdcjMZ
 G7yjf75pXU59p2QLiGPytPh+NJu2WOnoR2nv0Bqi/VTOSjCOAXhuUTG2kAtM8w3pIPIm
 p8Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqU3vlke28FrDwmBVeakYdX+EBT570r7DleNL3KdMxi0QkwwSVtrCf5fOibkqr3NYPpaC9+pTL8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcnvWECciF6S9FTsakP1r+FGpwRShT+ZabArbvWguYNc5/XJDX
 xI32T3mwB61Jn8hUX8BVZRzdGAYAoDXpB4NX/khBoHIQgKJCRNTG3mIwwL/XtvtRrRpk+tlAJUz
 +tky5uCSeBqHYnGmbZ/8H7BPTckVVNRo=
X-Gm-Gg: AR+sD11i3PWaWaUcT5iaSOb2tXKM0BZIQbMkQ1WYlBmWCA0VZjnQikx7+maE128s0X2
 /zKTMRzwh/nKTGTiaE2cZ7FcQCB+eDvE7Ama8Sk+j5qrkxSx4bUNB2jLwNSfvWi7ekWSjIekUuK
 AmZjfkpceBqxf+o/Fn55Zd66bs7mK6ZpY6xFZnOS+5maGc+/yYwBh9NNQ/LrQ4WDQb3/RmN4D2l
 3BOdKZEluyQ9i0JwZLN2MMil6PcNnyFP6v/GGrWaosbIWpOYw5y8MloqDHklCpI9NfIJ0XegJm2
 i60DtZyy4+Xp5roX754qwqUVDbt/G0s5bdAk+o/gmldu9zT8bQMooSQdwP1AWB4ys9KPdix65KA
 xhGPcSJWXnobKFxO5wsyqLmTCfrMAFGKI
X-Received: by 2002:a05:6830:81e8:b0:7ee:3604:4dd0 with SMTP id
 46e09a7af769-7f3b8d5f465mr1140306a34.14.1786521626438; Wed, 12 Aug 2026
 01:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260730065300.2056809-1-mikhail.v.gavrilov@gmail.com>
 <5f265620-a932-4951-b5c5-0b05ed3948ac@amd.com>
In-Reply-To: <5f265620-a932-4951-b5c5-0b05ed3948ac@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 12 Aug 2026 13:00:14 +0500
X-Gm-Features: AUfX_my17Jacclh0eSo3RBB9uv6IhLYIAcv1yS6b6P4FNVtulaeUnyQSyHhvMb0
Message-ID: <CABXGCsMb61yFTTh852C_AH_G3fwDSDRrYFprYKn_zwwe4Ex9+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: make DC_RUN_WITH_PREEMPTION_ENABLED
 misuse a build error
To: Tom Chung <chiahsuan.chung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

[adding amd-gfx and linux-kernel back to Cc - your reply went
off-list, so the tag would not have reached the archive]

On Wed, Aug 12, 2026 at 12:37=E2=80=AFPM Tom Chung <chiahsuan.chung@amd.com=
> wrote:
>
> Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
>

Thanks for the review.  Repeating the trailer unquoted so that tooling
picks it up:

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

--=20
Thanks,
Mikhail Gavrilov.
