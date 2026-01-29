Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82356D6B094
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 16:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0978310E19B;
	Thu, 29 Jan 2026 16:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DO/tmNFl";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2723010E19B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 16:39:17 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b71a4fdb86so87414eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 08:39:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704756; cv=none;
 d=google.com; s=arc-20240605;
 b=DVMN5oWlIs49TocMnxJOa/+RJBIA7ZVtPOg89AloROUWLN33Yv/FP+MVgoMjF1jLUG
 2xxG5dUHCFHJJhX1f0U9tcxWBUVbXlVzQRaB4Z4rc3QMt372lVRUAtdWpsb89ju4dWLZ
 2LhVKsCVzF72cORrpJCuxZ9sxUx0FDMx60gFfHnV3/QNBd114nYmz2NsVu+xCqA9efHS
 f2iETNGBWOxu4Ev/56ckL8Lt+fPQBd6vilXsHcHwfc6Xl6zjcIC9OtT4NVp/Fs/u94tg
 I2hGzgRVuHq8G/AWKRzkeAlA/52OoGPMQ8ffhgC2+SDHylBPreuQwK/rcGFOjQLBQD+7
 qhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3NQKLmbHg2aGU/QzVatKkGvzn+x17Say9stYxeiONy4=;
 fh=ftIJ1tWRMYE2QRV9bfYZjYC176J1L63Xzu/+vL0XBi0=;
 b=MvIgbnL6CSkYskzWkRPpfwTssDzhKappmclE0n63mF0Bgt9iM/MAlwYd7C9cMEA24D
 K1pqwVLvbd+cbZ/JWX9pVD05fqKjOMxhwL1WSv+HjQ0ISBQpfYcsDjh6Dq403gXGKUGJ
 RcBmTUBDOyka5vNktUk5VJzvA+Rja+7rJbACoiaTgz00ptKVxz2eoS8RJcvCJlmpP/IK
 bYlUxP/Jw0cJfPjY6gto0T6QZqKlmzk0tbez7a98J11GlQghVKtyZp8zToZyO5xQ/h/S
 5yUBsj2QObg3Y1nXa387i/yQU9al+T0O8Z1PG/wxuUZqrmQ58harBBqfls0wpbDtizIv
 /XrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769704756; x=1770309556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NQKLmbHg2aGU/QzVatKkGvzn+x17Say9stYxeiONy4=;
 b=DO/tmNFlqJ46jSQLCaMDmdik19d+GR0PbIbkxBFUUD3+9S5O3Hh/obAIVBkK+gy6+l
 jRXvrWsMspxaPFOhsanmDGr7AdQnMSN3Fb2zD+fIr/xsZD5lBWaFflH28eAsy8o/Kj52
 D90dNFQfZiJPbDvpZg4z6vQYBTa0iN+nhnJ0b9rgXWpXW1PLDuNjgFfp/Tk8dEgImON0
 E/RSqUyVemHi8O0skpAnu3lJDbxFhRkqLXSuMQx7zOPuec9RJeTs9cUP8Mei/+hyueo4
 ESs2jB6stck6eZNF7ZhkJeBQf2mm3wNp0lwSWf9lTUI9drOWKtpOHYzTQBCHP4r6+Ded
 6JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704756; x=1770309556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NQKLmbHg2aGU/QzVatKkGvzn+x17Say9stYxeiONy4=;
 b=wPh+QNPgcK2VWoSt7dojQxtj/qOFaltANDp9ASeclOQAdBjQUwEakwAvJlLyXMd+36
 sG1/YWfOkK3gX1m9NJxk6IjiLXahor8kx902bwnGtziF9TZ7kC9SM9Gl0zbVG1LmNZRj
 SA6lIjt0Ret7MQtp0mHibWCOeY5uffkC7f4X8gQvVHO+TQMQ/EYa2R1tmozquNRuPOB8
 dP69zaGyF7kDL6Izces/k7yvu71xJV9mOFVBFOy2mSAiC1MtEqvC8kQWSoAM30j5C4Bu
 kYgnBVYwK345imkjP+d++yOVPxs9hfzoN1ykZfxQZwOqCbZoraG3us4DjJAErIc1Tj7b
 XUgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQK23NVnPendKUtCvYPvaYCGO0/9plT9QH5xEXWtkd3M0x1/SZnJk5pj2oVTtbbynqf/ZiGDPT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqzdF4KYjE//QpYUnqTIx3L8gWR9ImJbv/AxRiwtb8XOL4EbVq
 oExcoGvFlsxy7RJ5HpIjScP+e333hJKul6tD6HHIPYULBJFcKwKn5W+LShpsG4KQaQLkXQRTidz
 V8VLMGbRgQ7B/2ZJc1PhwpdCypMrtwchjLA==
X-Gm-Gg: AZuq6aJl4MruBuWAsLf2qKoBA/yR4FP6sLLpmtq+C3PSpZ+I0KZtbzCj0WU8Z0xnZSG
 ZJZ6mNRW/AsluREDt7XoW822fElHltqPLROfkUhxPN50Ulp/DTOMzpioiTE7r6nDkeFTgIQHr26
 EBTKfM1cnDzlqSfkmE8spYigONrcZt5eCCgV9bFDGWPi1iRK7/iZjCiQVedvq1kPjD1Utvl8aHz
 +0/eH1lncOfRZqBQ2JxbOJElM8tIZNbOczVukLB0xGeQAfLZPi5BqOUr2C7gExnTPcDeiTLzK4D
 tCQQnhg=
X-Received: by 2002:a05:7022:6b99:b0:123:308f:667b with SMTP id
 a92af1059eb24-125c0f954b1mr31887c88.2.1769704756190; Thu, 29 Jan 2026
 08:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20260129043446.33377-1-alexander.deucher@amd.com>
 <6fbe8046-cb00-49ca-8bc0-c1f3b747767f@ursulin.net>
In-Reply-To: <6fbe8046-cb00-49ca-8bc0-c1f3b747767f@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jan 2026 11:39:05 -0500
X-Gm-Features: AZwV_Qgr8mDVtVwhXoKdftQDq1jnQ0Wf1XvwokEjgAsN9y8Ny84AFuhrnWeNl_A
Message-ID: <CADnq5_O-Nq8Y+9enz11gqbFOnJsL9Xmf4F2hxJ3vx4k5OOD1FA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx10: fix wptr reset in KGQ init
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Jan 29, 2026 at 11:27=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.n=
et> wrote:
>
>
> On 29/01/2026 04:34, Alex Deucher wrote:
> > wptr is a 64 bit value and we need to update the
> > full value, not just 32 bits. Align with what we
> > already do for KCQs.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index e9254ec3b6417..ef7d91a4437ec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -6883,7 +6883,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu=
_ring *ring, bool reset)
> >                       memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx]=
, sizeof(*mqd));
> >               /* reset the ring */
> >               ring->wptr =3D 0;
> > -             *ring->wptr_cpu_addr =3D 0;
> > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
>
> For my education could I ask if this just about writing the 64-bit value
> or the atomic part is also important?

Just the 64 bit value in this case.

Alex

>
> Regards,
>
> Tvrtko
>
> >               amdgpu_ring_clear_ring(ring);
> >       }
> >
>
