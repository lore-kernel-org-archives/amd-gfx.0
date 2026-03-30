Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3101061B1F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 19:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0986210E64B;
	Mon, 30 Mar 2026 19:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AT+gYGKr";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF7210E64B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 19:40:51 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d750eeaec3so2187786a34.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 12:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774899650; cv=none;
 d=google.com; s=arc-20240605;
 b=gDS+/kU8RKU+fczRqIi6Uu3p2vFOItSG1Pc/ujA13O4qv+KSFGwMDZ4Xi402O62TIF
 41EJGMDYCgeVMMWJnK4KfWEgQt6yuF8p/TnICL7NeiTg+ACQl2BcAosRn3cLehic9GiW
 ksq0CYeH7TlLDDjfmEH+586QUM3DMoM5KCB4QIjhoywkz7BLwRAae5SqKjHzlOXkpU6+
 aL7mrYf7Efdf+IGrNSzkIt4YrtOlfbH3NJzIwP2qR+7sGYAVGX23Uy+yaDP0T4RagOWE
 Q7MDjwaQNbPG1iZJN4r83Gk0HEjMhIlGB5HJvikiw47ewFPGsTCGbjjX1XxiWNPC/RcQ
 /GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
 fh=N21XzIw5LJAs+TWnmFpQeP2hygEi0JSUfTMs9naUTOw=;
 b=X3r064Ha4//6a17ipPbLSv0lCMJbJ8VJfStPkOimnj3KKUK2jLSFSJiY+o1ywIImBJ
 CqmZ0OHRvWXfw+NLB5U9k0szM7ZFHeaN+aM4eaCGdIraFYeE0WuAMea6OtZzQkZYZRVT
 SaVLXou9bmU2jvom8zoaU1HcOPl3cyKX+lGoHsyy6F+SdgfXLPd/O07wjKFHa/NwKASS
 qBIntz/WYz/tpprdcwqMGlm4NbqI92j2d22JtkQGOuZEI1tAzQ30bspQAPZeie0Xuizn
 wHus8MgcrVKGI4fJwIGNkNtIdtQFsOqnHOnbJT17JGeBEEuoYXXKcbYRVxsOjqQDUXLj
 waWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774899650; x=1775504450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
 b=AT+gYGKrWkuJtvN+YwbqbfsiBs4uollLLa/XqfWrHQfoX/9fPavDF8PzaOn9lKp/IM
 0CLfWUkLnN0n0FXui43XPkgCgv0ioB7g/E19XglTcQl0Db1CqjYsLOnY868jxIMdCpMA
 TSQ6Ml5mCF7g3n+EzOb6JV5mFb7zaqEtipPpiYzMi6nBPF2pfBHCQAORarg/kp7PRy8U
 5oC0KYxHaJ+5gnHJ/cVFeTqZ4sUubUC1vTUpaTYlVyztIxCVGIP7bF3N31cvQYxodjNY
 PDcSZTqP5QXPLjLoVQi7184RQ5JKsQK5vDCtEurtX2rS8+PgQQFEkCD17zu/W+5Do8px
 z9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774899650; x=1775504450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
 b=K1uYzeV0dAG2o3THTdrVcrtjRZMMMQGXpnfexjrVpqTfMpRi5/BmJRcgCfe+iUk7EI
 nEc0Qw5C0BOH38n199DxpRZB3slFX1DnYREDi40oB68QUNEJzz3RtJA3u7hk/xu3fOQ1
 t58CW7s7UUj1r2HJqcpDOLoc0In8W+gw5Rpjlv9L0hggQ5/y5ZEkFWZU0UaH+0II2gd7
 gsk1CUfam0VTOAspM60UcU3bHQUYS1YwlSvABOg8BJU9i91EdUFagEucinBZjW9oMB1k
 gWQkAn6o8JG5gpIRIzIyoJm6uMj+2GeM2QrZn5D654bJ/x6KaeJiVHDtWgmj480RoZWv
 CSDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOSl5ycAp/a6hvFyy6vwwxiI4dglUl6jgMTVs3VugYr0aO4RDSoCZL7MoE9gBYTl5uOFZbmbT7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7g4LLMH2Ms92wSFYjQHZfzapNd51QAFMfZylwV4VtckKvZjZF
 wgoavrP91Wn8Vwo1fw/+fKjVDGA0s/SXM9WRVLrlDGyiV3GlbogvY8gvqLY1tBVeGI//oZ2pufN
 Hv5ORcx62WdUN1zvAY/CkRW7jhtB3f7Q=
X-Gm-Gg: ATEYQzxXXGWRDJVY1E9kq5FXBDE6pcOzv81gD+Rjb6/nQRgfHOjDyePlNFMJU7RlABH
 /+NzlEWTyWfIO6fM1hu80fxMWpzjXPBH0jD0L7pCUhiyhVlHSgvcEV2UrsvSz4GEc1Q7226NHXk
 H55Dleloq8SL2/BzUIbJT9EkyKE1Oh8zQzJSx0ISJ4cgoAEzZrMJjANbrT6hiZPGltAvtY6ctE+
 YneM8m07UoquSVYNCkxkZE9QdyT6RNVt/XRmDgcetYIv9ccvCZpXZbD+9lClYxSqGveUdy/rTyd
 iOPQUhcnBA==
X-Received: by 2002:a05:6830:67d8:b0:7d7:cc53:623c with SMTP id
 46e09a7af769-7d9fad8747fmr8039420a34.7.1774899649966; Mon, 30 Mar 2026
 12:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com>
 <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
In-Reply-To: <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 00:40:37 +0500
X-Gm-Features: AQROBzCNLSSWm2n2ptMDD0gOB6l-aEGg2SU0scPbi356emx3GUuYWX7qeZGkREs
Message-ID: <CABXGCsOguZU1k2zS7ngbAMYU10A-sWtoQLQ7P+ThiXR-7e_Crg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: replace PASID IDR with XArray
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
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

On Mon, Mar 30, 2026 at 10:33=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
> Sorry, I didn't mean to confuse. In v3, was only talking about
> alloc_cyclic call.
>
> As per the call trace posted, amdgpu_pasid_free() has a chance to be
> called from irq context and that may still use irq save/restore
> approach. Eric/Christian, could you confirm?

Hi Lijo,

You're right, xa_erase() uses plain xa_lock() without irqsave =E2=80=94
I verified in lib/xarray.c.

I've sent v5 which uses xa_lock_irqsave/__xa_erase for
amdgpu_pasid_free() since it can be called from hardirq via
amdgpu_pasid_free_cb.  xa_alloc_cyclic() in amdgpu_pasid_alloc()
is kept as-is since it handles irq-safe locking internally.

https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmai=
l.com/

Thanks for catching this.

--=20
Best Regards,
Mike Gavrilov.
