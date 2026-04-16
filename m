Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62147F8A171
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 13:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EA910E8B0;
	Thu, 16 Apr 2026 13:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRk0TsDw";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7515B10E8AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:35:27 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12714f01940so413466c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 06:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776346527; cv=none;
 d=google.com; s=arc-20240605;
 b=RXbqJEuoEYWRTgKhVKIsD+y/yZ0JiPFSN7dkT2H4CCu8U4jnO9w/VrbWQYaYI0DpHg
 VXiWnQR3wGjHWUrlETuZQDciB455VHeTQEhweHQ4TLHmkbQ/mHPTRbbb4Hpu77E7g8rD
 BHo/+lU2AmRgYqbMeKVhyCOyllCB6cCQU0Nzev1T2m2vqvwoylUJ40RwSXLi+8yu4OVY
 hkWJHi3piAaLBCBDfNgeMeehEhfwLFqCQ0rEbLHURW9QqXTopgtFCWgciCnflU2BVVUt
 pW261s8alvWahTSg2HdaCMAwTkitwsorDmy7j7IgO9L0lBEmYRzbgqx5cxmr7JMsLA9/
 DW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Oy4+G0ZuUUtQK0Zj0ykNZS4dlqRdDksHxI6JcZXjxY=;
 fh=lrtDdIhurDlFI8d9jSEmf+aTdzZllqCL/AtZVSWa3Mg=;
 b=H4Ttdc37z+++Ft4c/GZS7DridVyftmKrxMA0g6ouvjII1CvqGgvHChmBZmCFEtKrpa
 7soiiEBZ7LAmlUxZHstFIcofRL1P7CM/8Z2nnjp9U2T20dXV/VOkXfmjvUkYst13slll
 X7QBYUPk3X7QPXcuW/HZWBsDhHZUbBfYEfSubNkPyj6TvAiB2C2UraY6wUkhZ0HAlZ+4
 +GMpucFCcXf80zjpqEfLhIq/NtFVHHx8GoDB+GSx7fnnqlCoxdqiWzjYuZzGbsDZYDO2
 z8kPUJBPeu5JF1hDaaBmHoJtJmBfmwGw7mH70nsqsEWXKBHX/r9m5mchVTcwqRrAYfc8
 Eh9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346527; x=1776951327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Oy4+G0ZuUUtQK0Zj0ykNZS4dlqRdDksHxI6JcZXjxY=;
 b=gRk0TsDw8ZA6ACTROSXXpzsVH59s19Vlz2XMtStHRIAC+QfEF20S/i31B/nfVGMu2U
 lbKSnrs6f4UFSNlNAMFUOiM1xlMXDsubirnMWE/FZilbMAGYitlXq/p/GwI2/od1afNV
 AO1jr91VbgjwcCtn5KRBcaubDl5bEhZiu8x5mj/EPAh7IxJUb2fR/Hh6hsaVDOiU9+Q5
 5KLwd8L5uMIr6OzD3KtSpFn4b1YNaRO8rjaaz24ZtRekEQUH7Jd2qWUchFzhl0Fv1D7q
 ooJeI7qoxvPOkjExc/uMEfdEzNVyMYsOh7xabD0bfgFd6TYjCrO/iOWLhJXVYR3sXaxh
 yzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346527; x=1776951327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Oy4+G0ZuUUtQK0Zj0ykNZS4dlqRdDksHxI6JcZXjxY=;
 b=jwU7CHOKaUPcU+Tt8wtg06A2P+sYhvr1Day4UlJ6lu/F8uR7mj0A9I5Q4sIMknPapX
 EXjO9yXDK3ZshCD76DIiMeTuWXrtd7VscIUyhl4x0stnIC6jJAh6hDunIGE3lW/+oegY
 2WXhGbUKeKWhxNJ7PaRQQGspKuZOnSiq6wRvnUeRaJ0RQIiBtYbsIJobnraTLQw97Fk8
 DeOjd6EEG3HKpNjtRXY9Tg4EY9HP/SFm9BV0LmG1mz/jVqNG6tYQ4Yo8dkl0IbuB6qTm
 76yHejhzTgUQlWnEsMK0GUlxa1jrbWzBeQXwEnZyZOHIxObF9KGwBzyeRmE36Hdj6DaZ
 r66g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+FREBR9y1hbam0g13MgeziQcSpcJSf6bQ+KAWs6iixKjn2cjLZBiRvSQas7UdpG18iMBQQ1AK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+jKt3U17QEYzEHei3oj4tlCEv+XJbn5M14v+UDn7WYVBe0jcc
 8M0NI3/Mo2cP3DmAvgpruYrFdYpZxw7ARJn2Sk0AvCqAU3V8VxBy0pjmG58k5dHbLkd5CcE0s+u
 5zeqF5rPXCQyOE3PvFls6t1G0Grei+7c=
X-Gm-Gg: AeBDievgNcTL+UHlZk1yhbVVT8zHD2KmNpS4q/0pYZVYe55/lTFzTedFk9FbE+rVqbT
 i4Wk9jpYXpukInkNTBJd2m9JXzGjVGVhpY9tyJBsTBa0fQDwCTegKuXrdrma2lG3P1lQV86bmdt
 7zQTilkNw3EwWXCMbmv12H5b6Is0EXxy725hmyQJK/wgVzSm1FYLWLGifd4TCC+7HVZLbvV5OLx
 Scv+StnNpdGXwGg6LCZ+BwM2lpUn103ag0yZm16wnH/UPMYEKa7rcDoLN+ZoevEIb7Iy+3MOq9Y
 kLEuAQu458uA/9YfQsglTvQSm/qlYBmANOwvxZxx6k6/H2hfQ0+CIz18KALSTyKHZm2TH2rmS8j
 kPFmg
X-Received: by 2002:a05:7022:6ba2:b0:12b:f899:7178 with SMTP id
 a92af1059eb24-12c65d48852mr517658c88.7.1776346526424; Thu, 16 Apr 2026
 06:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260416045025.1825888-1-perry.yuan@amd.com>
 <BL1PR12MB58981E8785647FE677A7165F85232@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB58981E8785647FE677A7165F85232@BL1PR12MB5898.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Apr 2026 09:35:13 -0400
X-Gm-Features: AQROBzB-lQbQNZXFsqqnX1ZHlI7g8msy5sTUwRFn3X1YOy92fjy6YArtOgaYG-Q
Message-ID: <CADnq5_NJGsGhP4vSrihAKPpey0hBAfKResXqq_mf3yk6Q5Pw5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
To: "Russell, Kent" <Kent.Russell@amd.com>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Thu, Apr 16, 2026 at 9:34=E2=80=AFAM Russell, Kent <Kent.Russell@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Not sure if something git got messed up here, but it looks like you're re=
moving
> > -#define AMDKFD_COMMAND_START_2               0x80
> > -#define AMDKFD_COMMAND_END_2         0x87

That's on purpose.  Those were not supposed to be here to begin with.

Alex

>
>  Kent
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Perr=
y Yuan
> > Sent: Thursday, April 16, 2026 12:50 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Subject: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
> >
> > Move `AMDKFD_IOC_PROFILER` from the secondary ioctl range to the
> > primary upstream range at `0x28` and bump `AMDKFD_COMMAND_END` to
> > `0x29`.
> >
> > Fixes: 4abe9fd1e763 ("Add kfd_ioctl_profiler to contain profiler kernel=
 driver
> > changes")
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  include/uapi/linux/kfd_ioctl.h | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_io=
ctl.h
> > index da93daa3283c..1a94d512df35 100644
> > --- a/include/uapi/linux/kfd_ioctl.h
> > +++ b/include/uapi/linux/kfd_ioctl.h
> > @@ -1711,13 +1711,10 @@ struct kfd_ioctl_profiler_args {
> >  #define AMDKFD_IOC_CREATE_PROCESS            \
> >               AMDKFD_IO(0x27)
> >
> > -#define AMDKFD_COMMAND_START         0x01
> > -#define AMDKFD_COMMAND_END           0x28
> > -
> >  #define AMDKFD_IOC_PROFILER                  \
> > -             AMDKFD_IOWR(0x86, struct kfd_ioctl_profiler_args)
> > +             AMDKFD_IOWR(0x28, struct kfd_ioctl_profiler_args)
> >
> > -#define AMDKFD_COMMAND_START_2               0x80
> > -#define AMDKFD_COMMAND_END_2         0x87
> > +#define AMDKFD_COMMAND_START         0x01
> > +#define AMDKFD_COMMAND_END           0x29
> >
> >  #endif
> > --
> > 2.34.1
>
