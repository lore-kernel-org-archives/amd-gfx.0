Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDE1C36000
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 09:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C2110E5AB;
	Thu, 20 Mar 2025 09:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJw6FPZr";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC7E10E158
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 09:30:13 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5e5ea062471so81111a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742463012; x=1743067812; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aob35BaB0ufxNThD8dz2Sgbm/IOHtRTWoitlf6uqNWw=;
 b=iJw6FPZrYKLS0uqxY8NrBx5pMdzYpRuB4BB0h+zucfgtsTbsvEGWbRmMFys1OeVyn0
 Bn1uWIPJ9mfkl4aVm0tmILBzTP8oV9OxIdCx3hIHXSVieEfrMaHo6INiWKZ7Kajoi0qG
 3NdZmfTlKdHjpWu8XRRhMby8fa8bo12xskYbgTvmxRkqU45K+wSXQ7IDeCaGKHpbEYPs
 2by7USV+3m4JKPW5kVC5X0W4FtgZib5iMsKKwsiTIhZHKUDEg1Ngbjs3ggNNOzgk6mY8
 mMRhzhthvjBovkZGWRi2cUdbpfOAgGvR1/uOyKWaCt8W183RYOZggVIPtA8+96+ej4sV
 CPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742463012; x=1743067812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aob35BaB0ufxNThD8dz2Sgbm/IOHtRTWoitlf6uqNWw=;
 b=CvEvNv96F9FTmRn6PoQ0/mkSX1j0Gs+PTPFcFznaJZ+Ni2x/wiqMHEg8XuOUZHwKsg
 pZfDX2UfTnIXdBLlDagudDe1+v3OB2wlEbqIVvA9WW84YyTCC9OuZrcJNz8h/KHOVWPF
 Y6WD2PYRehsnA54CFGbiRG1J46UHd7GWzVAnGS+CMaZLdPAbk16+u1ZUylAP1WSTQxO2
 ySAL9riLCNLpX2Y7HidGizbZYg/KnHdJm/9D50mCksUSQuz1p4pgpceje5EhjINRULvY
 dNrrEkKwyRTh4AByCIi2X9frYESSW7usfKLxoGUqfSdwOX+C0vBjyx3ABk3/NkG3k0ll
 KHNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBYsURNl+fnOknWdtHl8I5igz3Svl7TXCkXdvvFGPNhiVpkhcEkpYxv2ekb5Z5iH8WKQzP6rpA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFRznmXfA4EEYxBgC1nEYWOYoYovJE7alSYebm40B8TP2tMRnW
 wBncnqszo0TDNQlExhpfuoHz6Z5rI/IJGoPEp7p3nk2ejnnXlhJ7OnrdUlqOfoj1NPocdKhY1rO
 uAPvL2ICOzlAPZKrNa0RPsG2b4oI=
X-Gm-Gg: ASbGnctaL3nB2b2CFScSY+8MhBdY2M/MyEdv+4xv9HUrPIUAKTjEAnhReFiA1/pn47N
 jsfiw5KxJxuRruVpXBYNd1zqs+OX9HAWpuNyZ5Y+HAW5VNvPvxUzDtZKCWQngbWl6iWph/q/LEj
 uZIpq6qX9Ru+x/8nJbD6WG+ost
X-Google-Smtp-Source: AGHT+IGDMoLqQKez1fF3Q8CkiWJClRJTfS8jbfolmDPdyfHjq+XUYJats6DrssZj8lj3nxh2QV7Z7cmjtbVSf6rjFZY=
X-Received: by 2002:a05:6402:5193:b0:5e5:e17f:22fc with SMTP id
 4fb4d7f45d1cf-5eb80ca3ed0mr2437689a12.2.1742463012018; Thu, 20 Mar 2025
 02:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
 <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
 <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
 <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Thu, 20 Mar 2025 10:29:59 +0100
X-Gm-Features: AQ5f1JpUb9YVYPg2SmzMJurY4ah8pVXm87X3HdORdt4ZVcNy2M9ah9pPVnYpogA
Message-ID: <CAFqprmw1DMCqOUtK3=ptBWj+0Q1K1XvY32K3s=NG5mYzqm+dww@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 20 Mar 2025 09:51:20 +0000
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

On Thu, 20 Mar 2025 at 03:38, Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks Tomasz.
> I confirmed that this change is not in the latest driver-if file.
> However, this is a fw interface provided by firmware team, we can not change it.
> That means the interface is different between the smu13 and smu14.
> Let me check and get back to you.

Please do!
I honestly find it a bit weird that the setting interface would be exposed but
its limit is not. Especially given that it actually works after my change and I
successfully get the stop temperature limits after asking for them. Just seems
like something has been missed by mistake.

I'll be waiting for your info from the FW team with bated breath!

Tomasz
