Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44D9CCFA13
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 19:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A73F10E2E6;
	Mon, 10 Nov 2025 19:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A3UT/sUp";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7839110E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 19:14:33 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-297e2736308so1534615ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762802073; x=1763406873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwHDw+RWhOlZP/amR1OZvDu5iuKr2nALD25XBBx4YF0=;
 b=A3UT/sUpESPFfaYmXplrLgrNfrUw3UryR+7LgIhdv1MTQBUUuh9jzYxOTeC4G89pnw
 z+v0ZL1deNh6mXAOkkEcinqZc/3l8/huje/B+iJDjHAR7Zp/n+aYcMQx90iPUo1bi1Ow
 0m3MNR/DYbRXAiSJsq3yKM06YUDsJ4rmWToHFso7DZDJ8zBvqeZ6oiGAnwGqRMUULzrs
 lgtFDYeew6+pyhbdxZ5AgMZtHfnpns0jLXRngq/To9NE9hUdsCn+9JH6hH4z49rERSIS
 mSxcQpBmyMtv0CXVQT/ueBqaN1Kiuo46MO7UYcA8iVjdU/xFLKvt0fv3t5jW0s82kiVG
 5qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762802073; x=1763406873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwHDw+RWhOlZP/amR1OZvDu5iuKr2nALD25XBBx4YF0=;
 b=m/BznTAw6aqKGPLbBFY3i993AtlNc2mhbbcy+p64Sm3eP57PQWNfVIyWImKgddVya3
 VTykT6zN5TzHIZiUZgK99fK6lnyJ6+/WhLLpDvBh+Ncj3LsGhaOxs3J8efGmEhl8oUDN
 evkTuo8LRQkaMTEPpHeDiuQZIxIQ1FN+2uc29ySVpxcNxaX6GlcHvQ6TAqo/8qflFNbl
 KcGyUyEVbhIVrCCtN3g4nFA8QBzz2sVCvhXyZcYq2qOY7TIuhTT85C1tY9P3ibqpQeKl
 1459hZGLJOC4ljxJEJHCP0PSn+PzO0XJneAGOMA45BmFFW3H2UbCjhE80dQqEn6UJj/2
 eWiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvPk2KgnI1rasiE72HcuBK6TQDxb4jWtjxf7rimpAni9FAuWChHcaibyUR3DZmF25FWhXUJEUz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFoIBvVj7K0tKdz6HKm7WzRp4G4jJEw//clliXWWZoncNSPgS4
 CYatNh2MbJl40Oh1OVM4T3xBUxHbyFcYpVOs3LukzpwxxhjZdaw2c/unlPbwxbf/1xM00sxElWD
 K/iR6bbgxLTkaF1M8IlPL9MHuAXz1hzE=
X-Gm-Gg: ASbGncsY08Ym+fxYs5JCtyksAT60zqxfcXTpIL+bAAiT9Zk3Ad97MtPIqTtUPAVA9bh
 bSGHBiJW3T9nqEBQe08yAHIivEoxPV4cIhYzHuR53P/yFjQ7Z6oMrl4I1CZGoX5oNF2KJjMpLaV
 IKGpHvkp1ZLn0rzETLjfGRYXzXMzfHniI+0hyhJc21/Cmz3kvjO5prsPydUYBCMUh3+ajOThXmn
 jsN+xh0+aHq7IRqj/rhAqbFDvBvZsO9+ot55a7+Mpd12rUdefSzKP2DXaD036r8oyWHQEo=
X-Google-Smtp-Source: AGHT+IGmoL24a5e2UsUDRuk9UBkWxVYKGDAVprVsr0fIJMe2VdBvfjSPwHiQpCu+jnl/LPBTuLwZI1mDrMEaljJsm48=
X-Received: by 2002:a17:903:1cc:b0:297:fe30:3b94 with SMTP id
 d9443c01a7336-2984107933cmr1991405ad.9.1762802072864; Mon, 10 Nov 2025
 11:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20250325210517.2097188-1-bradynorander@gmail.com>
 <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
 <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
In-Reply-To: <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Nov 2025 14:14:20 -0500
X-Gm-Features: AWmQ_bniXwWbFIcQl7Z57OsTSHw-cwzsFFjBwmNKVxkysJ2r-AhfWVyV_dkSDOw
Message-ID: <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Brady Norander <bradynorander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 sunil.khatri@amd.com, boyuan.zhang@amd.com
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

On Tue, Mar 25, 2025 at 7:11=E2=80=AFPM Brady Norander <bradynorander@gmail=
.com> wrote:
>
> On 3/25/25 6:12 PM, Alex Deucher wrote:
> >
> > While you are at it, can you take a look at
> > drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
> > drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?
> >
> > Alex
>
> I think it makes more sense to handle that in a separate patch as it is
> an unrelated ip block.

Sure. Can you send a patch to fix those up as well if needed?

Alex
