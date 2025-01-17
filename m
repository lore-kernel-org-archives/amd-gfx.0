Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB30C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 14:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C74E10EAFB;
	Fri, 17 Jan 2025 14:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDD1T9zm";
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2D510EAFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 14:08:46 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2efdaa02378so462023a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 06:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737122926; x=1737727726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZ4OBPhyEwgWHfaXc5OF6OxfaDxBFg4Q1tXy3nNOQ1g=;
 b=YDD1T9zmFVFaXAQ2/lR4nGgzcNtjg4f8ipNcQ/RqDKicTqLYfPFhQZEp7zDYbQWNyU
 wbGoBLw6rBhQHHdrwk5NKkUbOzC360DujSw71/EO6lMMRm/NL23weGhW0PWvtJdnU7hC
 J/+sh07m7c0gIDOxUzwUs7teqwe4UmkwCy2RK9s/ZDN+BDRoZUs0gWyWk42nKo5h7gQI
 5FWmikKQSfQ1ihIeMk+RVMP6PAYzXAxvwGw0E8HX70JMPCAgyitrYYRc1hSpu/V+gtZn
 8teSbPDNakbh+CZYVPhufI9PIAKydIqhwGw+4h1GsnP5OIVlQGTbPG4wQ5MlIjhGUHvf
 xo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737122926; x=1737727726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZ4OBPhyEwgWHfaXc5OF6OxfaDxBFg4Q1tXy3nNOQ1g=;
 b=sO7SRQzmuMbfV/vmYttihwOD2gnSzF/UWsqSHDrn9zriZg8WITrvXk17za62I8jCYO
 ZmHEyPd2ShvVBdcErappfuZBchfWDW9KVyOxZa0mP3pSO3mZmbuR8i6smU2hpDemF4lF
 BDcb+nWdqW/rBx6jaEzB+vOvXvIWBV1QaRtgfq8vXhtliz910/ZHaRRocy2w5xHm+8Mh
 XZJoNZspCNtSNRJ96cZACUcQa6vNUMEGX2GPVJg9dYtfM2RQM2tGSEnQWaRkfw3qNEgQ
 7J/WnKiv7ZZG9W6aoRq0ADMqiXNxIWM6E9hQJ1/aLJKMz0v7qe0kmV9g7EBeBmM48Eam
 QT6A==
X-Gm-Message-State: AOJu0Yz+sBLpsbeKMWa45k6E+sHyFMRrlD2I5CZppcpRX8qbYWUssKfm
 ZBgFzW5DxQnNIwlHfHToPEYKPNT6qUVGCBebpBVnnzydZoNiVTAr6E0MwTl1rmFfXs8qpzMsANX
 RG7K7P/Tahogk6BPRBnKxGtlFyWNrb52S
X-Gm-Gg: ASbGncts5H4cxAka/wSBvZAPZcPqIlH0q1H19Gyx9zGgtCta5QNfmMmzH8164lN2bvC
 bI+kFdeaXl4/y4XQIk+E2mIxDjlXLEHpwlLWLDw==
X-Google-Smtp-Source: AGHT+IGLKweKjY4U4WHaAdEn6GOgoQ3IBfazmjyKJfX6mdMOzHMzfOpPPxSbDbfxrnXFPIHak/RncldKxWnw0KRWnlc=
X-Received: by 2002:a17:90b:5444:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2f782c55039mr1465929a91.2.1737122926060; Fri, 17 Jan 2025
 06:08:46 -0800 (PST)
MIME-Version: 1.0
References: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
In-Reply-To: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jan 2025 09:08:34 -0500
X-Gm-Features: AbW1kvYxxQ1uB-obBDmzrgcA0Te2TFg9BeTEYaZu858fVh0J6-Ut6R4KCweg0Og
Message-ID: <CADnq5_Pj0NLqwiooxyXULERo8YQTh1TN76FVnM9MZt3FCMFSwg@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: Pavel Nikulin <pavel@noa-labs.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Jan 17, 2025 at 7:27=E2=80=AFAM Pavel Nikulin <pavel@noa-labs.com> =
wrote:
>
> I think it persists as of 6.12.9 and today's firmware version from git.
>
> Hardware Asus um5606
>
> It only happens when the AC adaptor is disconnected, and the screen
> refresh frequency is set to 120hz. It does not happen on any other
> refresh frequency, or when the charger is connected.
>
> It might be happening in Windows, but at much lower rate, like once in
> a month. The windows version might be applying some mitigations.
>
> Trying to catch what may be a prelude to hang never worked. It's just
> instahang, without panic, or anything. I cannot debug it without
> JTAGing the CPU, for which I have no equipment, nor am I sure if there
> are even JTAG headers exposed on the laptop motherboard.

Please file a bug report and attach your dmesg output.
https://gitlab.freedesktop.org/drm/amd/-/issues

Alex
