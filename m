Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B00FC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 21:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD98A10E0DB;
	Tue, 28 Jan 2025 21:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HhPxOqrz";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7439810E0DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 21:48:38 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ef05d0ef18so1449257a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738100918; x=1738705718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7a3Lwo5a4x+5aF8xXm3mkH0CSj/qRsbaulbtIWRTm9I=;
 b=HhPxOqrztTYyxaj9cP6Q/77jN/hs5SHSwiVuXCJwhHULpb28YjD5N0T4jQwWlZCb+r
 VJ7CB/o4hOLG5yCfap5o3cnerFcycooJ/L4t3Fw6a3bYwsx4ejmC+26q6loZfUi4zH4h
 b6jdIEkdwPb7ZbCQmuXgDfspnyd2euJ7hV8Ju6uQWQkZuQs/4xTFjK+VIgulufLkBWcU
 vQlKpxlvCzShUFJ7mczjG0YiTsM/z0sNPId++ryLtJiS6TAmfv9XMYct28fLWt7SuieR
 V3292VKNYkDaHCYRTzsJ6CSY0mZ6fs1cZ9ZfYTvcnJsNE+9o66d+DbOl5YREITFHsxXZ
 4ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738100918; x=1738705718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7a3Lwo5a4x+5aF8xXm3mkH0CSj/qRsbaulbtIWRTm9I=;
 b=HZJ8qBUz4ZiSOK5AhyYWT1vbS762cc1zgv6WKjVui+jfDi4ML13mywzQJp3+u9Xp5t
 wnhgMlh5DxYWjPaipkpczQRCkl3M8eKaZFFKi/ekfjj5Y0BtQuAmHcUo4QEYR/PTF/81
 Zw4AAEYNyl0XQlVwmi2Xjw6HW8yGa9ab5MwRMWX6DHZH7TOlmPty8VK1wtbxoeFtNDl0
 3+RHFumPINRsmOw2/MHlitbAtvZadmPwaWZcVqARUm9Z+UP9j9G6UTdeX5FfHCLtv2lE
 qkkk7iOFD+mcQQXZ/6jRv6a5lrlb96Z6+TWNAAG6hsWSwx1i7c3VugV1FKJHzmuBGjZB
 bDAg==
X-Gm-Message-State: AOJu0YxNKeokB+ByGIiVE/itD0f4QlxvMAPqjerNajKgt3eagai3VbId
 OAr7vFL7urvVwqkZXsEiXnlHN+VTGj6XMOpAPscMruDhzZjLL2cEv/7s3ofYVYg8+fDBEMgL59D
 uGI2qSlzLBkUkpaoFVMSrEjP+t/oX3VLo
X-Gm-Gg: ASbGncvCdz1adeO+3ddFGVP/VqTp5ReaiS4c9V+SNQ7WfsvtNsxgDqIt8H57qiPVjUL
 bRFPrLllAllUbSLErWt9CCzNMra4tCzcmmCe1fa1Mhdb3/kn3Ek4WezG8pFCocoInFV9au9FN
X-Google-Smtp-Source: AGHT+IG7c2tp3T7yT5iPHGShNEM367mNAesIC25y43rMmtf2ZgvsgfaHPGGtPtMWyGW1yl0HxuUq0MxkanadAVCxYWk=
X-Received: by 2002:a17:90b:280d:b0:2f2:f6e5:d28e with SMTP id
 98e67ed59e1d1-2f83ac5e878mr325706a91.3.1738100917964; Tue, 28 Jan 2025
 13:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
 <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
 <20250116173734.256704ca@ryz.dorfdsl.de>
 <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
 <20250124110225.6a0a87ad@ryz.dorfdsl.de>
 <CADnq5_PwhCK0DfUrEgmdpoFmcBcS-FobGf8p20fSDHOrPTFrNg@mail.gmail.com>
 <20250125193837.373438f7@ryz.dorfdsl.de>
 <CADnq5_ODfJtaRpQpkSbkSuCQobHyz3QZ-CO2KkPuaqHBuupKvw@mail.gmail.com>
 <CADnq5_Pg2JMuJ13ow0AcVgMqUvin6Oj41hmWYqP6+Vrjq3cMWQ@mail.gmail.com>
In-Reply-To: <CADnq5_Pg2JMuJ13ow0AcVgMqUvin6Oj41hmWYqP6+Vrjq3cMWQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2025 16:48:26 -0500
X-Gm-Features: AWEUYZlAja5BDeoknvkPK085fYs5ypEz9_HzMff1WVKDr43Yf7d8ieCjavrPsSg
Message-ID: <CADnq5_N1haZfWYVERvErJ_VHs3-8YQ1fP0QE7oGhdHNKrMcYXQ@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
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

This looks to be the same issue as this one:
https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Please follow along on the bug report.

Thanks,

Alex

On Tue, Jan 28, 2025 at 12:06=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Another potential better patch to try.
>
> Alex
>
> On Tue, Jan 28, 2025 at 10:07=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >
> > Can you try the attached patch (with no other patches applied)?  I
> > think it should fix the issue.
> >
> > Alex
> >
> > On Sat, Jan 25, 2025 at 1:38=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wro=
te:
> > >
> > > Am 24.01.2025 um 16:40:37 Uhr schrieb Alex Deucher:
> > >
> > > > On Fri, Jan 24, 2025 at 9:17=E2=80=AFAM Marco Moock <mm@dorfdsl.de>=
 wrote:
> > > > >
> > > > > Am 20.01.2025 um 11:35:07 Uhr schrieb Alex Deucher:
> > > > >
> > > > > > On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfds=
l.de>
> > > > > > wrote:
> > > > > > >
> > > > > > > Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
> > > > > > >
> > > > > > > > I'd like to see the driver messages leading up to that.
> > > > > > >
> > > > > > > I've now attached the entire dmesg without the firewall stuff=
.
> > > > > >
> > > > > > Does the attached test patch help?
> > > > >
> > > > > I've now compiled a kernel with the patch.
> > > > > It doesn't change the freeze problem.
> > > >
> > > > Thanks,
> > > >
> > > > Does setting amdgpu.ppfeaturemask=3D0xfff73fff on the kernel comman=
d
> > > > line in grub help?
> > >
> > > No crash anymore.
> > >
> > >
> > > --
> > > Gru=C3=9F
> > > Marco
> > >
> > > Send unsolicited bulk mail to 1737733237muell@cartoonies.org
