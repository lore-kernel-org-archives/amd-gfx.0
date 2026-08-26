Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E58C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 13:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6FF10ECF4;
	Wed, 26 Aug 2026 13:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKuhilFl";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D9C10ED10
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 13:15:13 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d6f9d13f50so1204965ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 06:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787750113; cv=none;
 d=google.com; s=arc-20260327;
 b=INmhM3wbK/52zrKmJfBHQ/u4P6wo8m5GRz7IBHu3vfkrG7awgEcBhL8FLjR1hbiDUl
 7bZpAJpW00s/NvvMW+0KMSb+RQV9sVVSYQ7ZcEjtnaOKgwEazDKXXGUW5sRwZGU1IloE
 rTQIEO8HjrFjLWJQSDLjXZBfiX+gDQe7HdvVMSCJkelxtZLsSQWyhr1G/0wG3CSzNHat
 ZMJ85vWrzPpNxV+s2su09Ocd3fD8Mez22ERnpwYvkj1NstYWj7VUaCcU/tK/bCj/89nv
 JwdJBeFDEMmY6dkrBjIHD2DYCF24Ls2KeFmXKnAlLSkc8cjZkyZUpDlV3uttEIeMLzMs
 8GPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d68A414WB1dkKupG8neXp1UtIKkBQkiVmGySNMv1upw=;
 fh=ymwoMRoHoTwyIuO2sshKrGksbZCNSwvasUh0LL7L0a0=;
 b=dYGxmpS/heM17qpdM12rOapUfrDK+NdyBAmJGRQ80u5s0OOxBV5zVSgWB3KXO9IZkO
 HjQ9XljGVBxOUmSZO0MvIksh0uJId/leOWlHTqoWRuEI5rClr4wpgHUrptoNCRcuG1wU
 SNha08Kj25xGVh9t64bSRjoz6fIUaGOcpHYvDXbUEIyJ4CX9R3SC3ReeUTHcutl8ed60
 U1LX81sJ5wTPw8WAMlBpbn77yV/1FCY05U2Koxri6WoFQfW1aDO3tZoB10DGZwFVAUtc
 ch11jGjsbvDGNTneRwsSM6NZl1iYbv6tB7P8W5r+ShdwvqjPd7kxoaLbx+IFEa6RUfHM
 HI9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787750113; x=1788354913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d68A414WB1dkKupG8neXp1UtIKkBQkiVmGySNMv1upw=;
 b=dKuhilFlkRTzoia/cpBY1+3/QKt1fSVY7m3Po38etWHJYgyACAcUfZjJhlfq8tF9v0
 R4ndaXtGRdmiRR24pyWefzYX5i4I97Lkkp81r2YoMDOPP220z/BJy7lySAVFlQCQ1R+5
 cHrAhnjJSLzh4DdQmokjqo4qLM5MzeUGD/vXqoW5gYyfumS6QmqgIfRVSp692GxA44kP
 N7aHDRtvxmqt1oPZsrxIOVLggHc1fsUEX7DNvu0f+Ckz5d8h0CXeXYqCiuUFLkII0Ils
 PqRm0sS+LjJE3k08H5GiDOVNcOvvsJih4OWZf1SZP1TFYmrSnfqiygP921Ev7LHImthT
 gHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750113; x=1788354913;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d68A414WB1dkKupG8neXp1UtIKkBQkiVmGySNMv1upw=;
 b=PgpeGyQl5L2kuYO4uVGiYUV6FxFwGSTdNKFBSBmlCWijfDlhCMh03kXRNbDC84miW+
 3XAEgTfO6tKdboxCAXqxasdNt3aM2MiVioWMw7Trmc8lSfqwJmKftTBIufaYD6oB4ms3
 jwJl3/LFpLQ0ILpFsOHff7bGdzxmdNacCcCgm4qDyviz+bWf8ZncMR5s5O3Qwu9xxdYB
 u56chdJK5mjAqnWVT0fk8uwUbdpLgLuVzYgYSFp4rLfDsGNex9Sb/+ji0hMLXfhWix0o
 CtE7RJ+cnYliG6+zoLygOrnijPsxXszcMVQ6+ChkRfN+BqnlH4R3SCNxcIUe3PG/7yyb
 joeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6JFrKZGzYXdee5lJFVigpAj2eV8aGqFKK/TCKRLRJXC4Q5xtcbMW8g3QJMl6e5DvZ7hzU6URc@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/LNvBxF7xPF7oWdqBr87JzsKYTY6xjgj9OfCSoXxX3kdnSQqQ
 K1flTE9lHsB2OoWAwvpwKiWO9sB2zk+LIn4Njlj2KDrEsr18mdDUU/sMgeh0XvW3fokuZb7QveU
 L4/6cLKJ7auUHcX07JBPYtwSEZX7rHcY=
X-Gm-Gg: AR+sD10cF4BR9kd8xF7JAda75QzN4dUM8Z2oUj3HSe3f/KvC98siAdadwc18wWG581f
 HiKjqCY4GVLsxOfHaNxbMwTtzmSYVpagP9SB5rCRn8M2f4wFCDlAvaZ4yG2bIXaOTSyislRfP7i
 kCBTf6IhMgJ5198MFSitT4FvDp+mkbXJtT1ybxd61E8FdQGBgOCW2Hnyh52oQPrvtfV4WbIPYSF
 8qFyKxMovyRzb2bRmxhj/Aq7R6hZC/SIguHCQixxvbXF8uIIhe3ifuSCVrU3M/Spq348i0GgjF7
 ZlwPpHtMk6V9H7Gy5Dv1mQLASu5JLk1mfoEGAWMmjszPv7WkyfP07WoT5ARbccs4fa9+c2vJiFN
 6Mc8kVUdu84UJa6V/aYfy49CYUf56/N0=
X-Received: by 2002:a17:902:ec8f:b0:2d7:1a3f:8db5 with SMTP id
 d9443c01a7336-2d71e51eddfmr1812505ad.4.1787750112568; Wed, 26 Aug 2026
 06:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
 <2026082644-monetize-tingling-0abd@gregkh>
 <CADnq5_N0AxaDZswgEQ7BEcKw8mF2hnSbAQp-w9U2Fy-MaEw8Rg@mail.gmail.com>
 <2026082654-gangrene-support-8541@gregkh>
In-Reply-To: <2026082654-gangrene-support-8541@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 09:15:00 -0400
X-Gm-Features: AcwNN1X4LudWVwUaEUKscYc-hvggQoTSapOlPRsnZqqAC9NLjfVJYKctFGxUoHc
Message-ID: <CADnq5_N+bXX2cFjxr0xHX9Yso6+OHh=9i=61boEsRedYwid9aw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@treblig.org, alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Aug 26, 2026 at 9:09=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 26, 2026 at 08:45:29AM -0400, Alex Deucher wrote:
> > On Wed, Aug 26, 2026 at 6:21=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 11:27:41AM -0400, Alex Deucher wrote:
> > > > Applied.  Thanks.
> > >
> > > Any hints on where this was applied and if it will get to Linus "soon=
"?
> >
> > It will show up in drm-next after the merge window closes. 7.4 material=
.
>
> Sorry, but this is hitting me now, pre 7.3-rc1.  Booting and getting a
> zillion kernel warnings isn't ok, that's a regression.  Please get this
> merged sooner than that.

I assume this is the series that fixes the warning you are seeing:
https://lore.kernel.org/all/20260813143605.106104-1-mwen@igalia.com/
We are working on picking it up now.

Alex

>
> greg k-h
