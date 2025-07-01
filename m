Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A787EC7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 15:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F03F10E2BE;
	Tue,  1 Jul 2025 15:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtqO7fac";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366FC10E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 15:30:27 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-313bcf6e565so792217a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751383827; x=1751988627; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeFTYrXalem8ScDfhl4szjXOeLFbMsQUCu8HC2XlHBE=;
 b=OtqO7facT7bilmXUxiiV18EvZmSHTkwmCdNdkHhf6dmHlR0xIOgf/yZDwnXks2EPmP
 W5g7s05XPY+TDiP1Vm7+HLZh6/6zLSKQ8jXH6WeAXxJMhCP/+6S3Hx/7w0izPNKX36B0
 sd6g9wdjrRIvD8yxkLACPM/hDTzy7qd++fbkKknJ8KqhBZJAXCr34w9j1WRk63N6hDXI
 4mwSZjHWcXrzV+l1huZct2Myzld5P3toxsjxDjQln1tmdF42/rrAZyD7avBgIzxicHkA
 uhO8sjEPYxNxiuT/9xrXtFx+fUmJ4vnsArqmvzU3n9FllzF8twCN5SkekPMU8hjPGFti
 fJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751383827; x=1751988627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeFTYrXalem8ScDfhl4szjXOeLFbMsQUCu8HC2XlHBE=;
 b=g49/F26CkK5Y8fDoxWRso2U9YSRBCrApNg8uX6CYalnFY12Njl+QnwTISr/o+Enr8m
 UEOitL3BpqIkM/y8lrf9d5XdWUEsgfETEdB76coPJF61+WRA7JI3Mxw5t0CP2MTJ0/tG
 bOyLDgEW+Z6ief4W/kt3krF1f352LzbzaKP5K6bKtkHl53fumQ8UL1Vd8r5090ctz4Gp
 5XA1SsqsCpchuycb5gIqKX3L4EOTB1QcWfoouL5Oi1cm1Ta24EqhbeHSJygr2hIC4hMe
 g1EaXWqMREDGdqC0oArH3G77C0NEjykUmi+yrMPRWUB7hp3b0XX68ejmvk/5JgDiCNHs
 2NHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNTg/thDJTwkc/Dwzhl1R+21aQKqpgvft11FCrvvv9ytXa9vMuzN93kEt1vue5fuKylEtjKiio@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj++s9vff0Z4ExakWSZsVgQMkJuHoptjxoFlApXWYa9pncCEZH
 67fqE7pZ+CjqyMUQVI8nW82QqvVrhMYAJSkYCGcJvnIOzuIwVzyH/93XqswNFyUzzWbVemFQX6A
 ya2JSOjR66jvoIap36OtsNSn1OQFP9E+X2rID
X-Gm-Gg: ASbGncsXusE+395dYnWaZGyV+0hDjxJshq3LCAsd7zOj383iFYveoeKVr1hC2jAseVl
 mbl41ldCgPXdQrAFk4LKlOtMxADLgo5NQutEVU8El0NsyP0uQiZpMhnH4eQ7zCG+f22UsQzbYei
 3ra/rKff9dbLUYen61Jsudkw7TrOLbrQHDFI11U9Sm7XVf
X-Google-Smtp-Source: AGHT+IHMBv1ke7U2NHbxrgmESfDKOqeYjLV28oIa5Lh137wcK8rKrD7P47rwvSFnuHHZDtJb800W44LRegUwdz2Fy38=
X-Received: by 2002:a17:90b:4a4c:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31a8020421amr1800279a91.4.1751383826529; Tue, 01 Jul 2025
 08:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <df174d51-e008-425a-b952-b3fdd12faf36@gmail.com>
In-Reply-To: <df174d51-e008-425a-b952-b3fdd12faf36@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jul 2025 11:30:15 -0400
X-Gm-Features: Ac12FXz0Lt1o5FWY5N3A5wN1crK6kyO7cUgcO4bGtz1nCzUBt2kTKvlze5Rq__8
Message-ID: <CADnq5_OQG9Ue80Y6x6CKh=Y8j0No=OJh5CvtU5p6tBMZBU30oQ@mail.gmail.com>
Subject: Re: [PATCH V12 00/33] Reset improvements
To: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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

On Tue, Jul 1, 2025 at 11:26=E2=80=AFAM Krzysztof =C5=81opatowski
<krzysztof.m.lopatowski@gmail.com> wrote:
>
> Hello Alex, I'm having trouble applying this patchset for testing. Applyi=
ng the first patch errors in drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:9579 I =
tried changing the base to commit: (6.14) 38fec10eb60d687e30c8c6b5420d86e81=
49f7557 since it's what git merge-base gives me between Linus's master and =
your kq_resets branch, but no good. Would you please rebase your changes on=
to whichever Linus's version tag you see as appropriate? Thanks, Chris

You'll need to use my drm-next branch or amd-staging-drm-next
(https://gitlab.freedesktop.org/agd5f/linux/-/branches) if you want to
apply the patches.  Alternatively, you can use the git branch I
provided in the cover letter:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=3Dh=
eads

Alex
