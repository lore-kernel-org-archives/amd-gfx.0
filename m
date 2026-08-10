Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321AC5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 13:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659A210E87F;
	Mon, 10 Aug 2026 13:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TaYBIyYU";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7644810E87C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 13:54:34 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6acbbcd3798so1127144eaf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 06:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370073; cv=none;
 d=google.com; s=arc-20260327;
 b=TIHjzXIPe9wFMYxE4poAsNRrLCdpDp/p0qdGdYrxCmLSdSjKgAkrDNuPKprAtkaJsD
 3wO6R+haCtWEpdsnvBVh485/e7NAFcFy8lZlI1mqy3xEH6mjkzYMBFDmo47UToLcPDqq
 XWEysIBUJXEmvfoCVHeAXT/ks9kEBWj88O8xqi6x7MzKcb+vWIUf1pMVvDvq6Mg5bgF8
 jLQUaXkbxvTwjXRPMdtomE4l1Wg8aI0fRrvApIZwMZnCLrZMgdEXWqsiVvVQsEZPRKZU
 YdcPSYgEVvYXOurvr2tPZriANOTXKfePfWmDJeQXvSxYG9dMLHyLkWD7/rYRXbnCxMZw
 uWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p9xyAn8Lg0NoyAHqpv5vJx0s8xXpgjfKFjqU6aFd+h8=;
 fh=nYgB0i+DcyTuQWXq0ro9pLVeXSCZKaIcMF/FDp9wEwk=;
 b=YiJwphhLKGQyUGYYqZjizqDAXnxllEgsz+Kzv3N+YP+EhkgRlh9bpa/ighEg5wsiUc
 aAx4hBOP1m6KvvKyEnzp40n1+pArOrwNyz5BnJsaxmyQjwcNnJW+JUltzv4KILOEZd0D
 cEg8epMLAKq3EEsImQvsJlMfNAUsZkfv/JicvdiXWJjmNDiaTwSJ6Zc2X1eR0v//8AY+
 IcW35RZPLDvgNmpnIlXD1ZF5rTxRGe/cDcwY3cfokMMqlhnf/RFsxDAQ2CiY741i73NR
 TEUCImXUSHN5FbaF+qwxG+BnWIEKie3iINn7Q7g5WXw7eaMJSJ9J2peeDCqsSJjrZXud
 0j8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786370073; x=1786974873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p9xyAn8Lg0NoyAHqpv5vJx0s8xXpgjfKFjqU6aFd+h8=;
 b=TaYBIyYUVelSyZa/0P5wPw614sHWxzNjQ7fbq6FvlUkvTlb6G8uGYaqP0if4vIAVC8
 1aMa3M5fJfbUvE/N96mhwgfAdPCoeUFGQhQONXpW9cZPAVat7toY/jeoFOmds+BA6Rt8
 4ieVu0EF3G3fy3ab46496ETyCzMT+FjD8bJeXt2LIOiYKcfdkzTvAMEHJCvhsIAEE6dV
 6AFXQC9BMIGgPZ49um/XxNgm08+dOCWWhLZd2oP9cS/yL4neZv3wOGCEY/9J/XhzDZTF
 617HeNhKE+M08yGde/9KtnM5QUpjpVzHcee7qjGmo1wQe53YQ/cGVhsGU2OOA1IuNQF7
 VR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786370073; x=1786974873;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9xyAn8Lg0NoyAHqpv5vJx0s8xXpgjfKFjqU6aFd+h8=;
 b=ZIDuTLp/qi3YjOew0P7gqwbzjcPRIQdB0QqvfrihI2s4QcYTxKcOm0qRfKfknKZuLa
 bDMafB5hnYukHIoUb5KSsKcVtHc9XlvB2QBB6Mr8KRk54A7caHC/wLXgx1fCeRghhII3
 C/unqutS4rfeb3y1R8mnN0n3TpVGUFO3EKoPLpi72iix54/iyXaDP3A4HwXV+vEVqSps
 CVulZaf7s/pqIrNbiUJqALdYiCbamoSOplVhoDzRrv8Lgu6M2xhp75OlJQRqHvKWeYf0
 MOickiavVoQTZLN1Zo20wuOlJz/WvwHrMPvoU0fBamyVyv1ussKYeAfIYCQ2sju6IP3p
 n3ug==
X-Gm-Message-State: AOJu0YzS8cyaxRdhSy2MkpWefhV71Bre8Jwca6yxleIRy5lV7pSqCy5r
 HeBG9KTeyqzUl6HJtTUvJhoIZfIGs/6F6J0V2slCwFLv8H1qZQKPC9NKIc49fElPmdGaRAyZ7f7
 OenHHaITlUCts7OmdVUhUExxySa02p/I=
X-Gm-Gg: AR+sD11W9bwpLwgD61eVt32ANMG14CKYh3I4eqEulmmtO40WTd1c5VOZETZPiSWb+/d
 b51jYQlLA8NNJCs/GK7PGu3jwzwetZhBYCU1+TrLR/2VPk/wUcaKrHB9F/6i5d1p4vcMpA8icP1
 nSAcLPy1OWkwpA5v6ISBcI2uf6ZJA6UFNRNzv8uiOO/kU41MtbkNmVxnZYtG1zHLkuyyl4Cc8PT
 vdJQoouUa8d7YUJMt5AurexlBsx7Eq0aqCRLKNZ7kkyl+4k5P4jVI6N4xUXqgRWIEtLn+Blxyo8
 ktXp16D5Mh7icWEIJDyMHjaKZvacEFgjxOilxxloQUHOo5u/a3J7+7Ki
X-Received: by 2002:a05:6820:61b:b0:6af:eac8:3d92 with SMTP id
 006d021491bc7-6b020d07120mr16152598eaf.0.1786370073399; Mon, 10 Aug 2026
 06:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260807182724.51018-1-edu042sjroy@proton.me>
In-Reply-To: <20260807182724.51018-1-edu042sjroy@proton.me>
From: Nathan Lucas <nlucasgit@gmail.com>
Date: Mon, 10 Aug 2026 07:54:21 -0600
X-Gm-Features: AUfX_myUu-ArGszJDp2Cn1wiukv0NiNHLNsp-_BYLWCFlqUSwVDuG8CV7uE0xUY
Message-ID: <CACNCB+=r4dAU4+WF2wGzsedbP67ZztWb8xE=CHgAf92BUhmxzA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix BT2020 YCbCr limited range output CSC
To: Satyajit Roy <edu042sjroy@proton.me>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, Ilya.Bakoulin@amd.com, 
 dri-devel@lists.freedesktop.org
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

Hi Satyajit,

On Mon, Aug 10, 2026 at 12:50=E2=80=AFAM Satyajit Roy <edu042sjroy@proton.m=
e> wrote:
> Add a separate output CSC matrix for BT2020 YCbCr limited range. Scale
> luma by 219/255 and chroma by 224/255 while retaining the appropriate
> limited-range offsets. Keep the existing matrix unchanged for full
> range.

I submitted a patch series about a week ago addressing the same issue:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/149741.html

The patch specifically addressing the same matrix as yours is:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/149739.html

This issue also affects DCE as the incorrect matrix was copied there
too. The full-range matrix that was retained is incorrect because
it has a limited-range offset for luma (0x0201).

Why did you use 8-bit normalization?  Other similar nearby matrices
have been derived for 10-bit quantization with 1023 as the denominator:

COLOR_SPACE_RGB_LIMITED_TYPE
COLOR_SPACE_YCBCR601_TYPE
COLOR_SPACE_YCBCR709_TYPE

and in DCE:

COLOR_SPACE_2020_RGB_LIMITEDRANGE

As an example, COLOR_SPACE_YCBCR601_TYPE and COLOR_SPACE_YCBCR709_TYPE
both use 0x0E04 for the R-to-Cr and B-to-Cb coefficients:
  Round((0.5 * 896 / 1023) * 8192) =3D 0x0E04

Your matrix using 8-bit normalization:
  Round((0.5 * 224 / 255) * 8192)  =3D 0x0E0E

Thanks,
Nathan
