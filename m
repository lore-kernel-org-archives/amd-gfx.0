Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BA5CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D9F10E967;
	Fri,  3 Oct 2025 20:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bWLNYAbh";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D996F10E967
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:10:46 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-28d18e933a9so4016955ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Oct 2025 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759522246; x=1760127046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpN5dWCrQHQvi8f9EQlEvGJkv2gjHWqz/fZNt51628w=;
 b=bWLNYAbhaI6P5CDnLp4fMj/NOJfHJMetemNnqu5T1cu6eU1JEEMGBFYmSRNyhMvDM1
 j1QJ6xfQi8lhfi7Mt0+ue2KEM4VhDEBEfsflZPUR9mH58CMmX0DzXQJH2Rl+vjEks69i
 Q7+lYmzEfFxLW4AhA6iOFjMCF8xYALZzsIjdPdI6cSHwQgzv9lM6kutov++tHvamU2J/
 GCjxl62GXnn4Uo4EpoqlV/31CWNKJwRFtBoKW/yILmEPGlTxwlLzQdLGSjtNVSPB0lPH
 zNhp9JrJIPpfX2Q6cdLPMD8+T50ARAC9CvUtzEw/xtlpDdF8YLEKw2FvL+3cQug1yN5v
 ceqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759522246; x=1760127046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpN5dWCrQHQvi8f9EQlEvGJkv2gjHWqz/fZNt51628w=;
 b=mQzvD+AcwONsCRE+fDK5SoD2XeW+6+g8X5ty5UW5eoMQsDPm7xZD4roKb6fW/9Gi7m
 daH0Ikomm9Y9PXh4CopyzW7maF3K7b4bfbmdoh/Hf7VhhrPBpmxnbE6NzwvSkMbbLC+M
 Qs/GplZhbsicQ405cjQ2ziyOX0xerL/mRQ4I9dScdRhoDUY0+g+go5z18BHtVjTJAD9L
 HEryTFA5L3PuQn6hA7opwjzU0TdyZfKiYO1EZdw8LY8WnZ5zP0DWiGjTCvVl6Qsg52c/
 FKdnMd+38rKaf+2g1gSPlJ3T0j5AOIS0a+sjQYO81ligRA+MKrrUOXVTiYKSXvZ7ZdJ0
 AenA==
X-Gm-Message-State: AOJu0Yxx5prAlKEs+KWAvDtL2Bli2Url2Dj2WOHHGuME+m7I+s/NP9nt
 5XxCLuRgx+kvvXAvWeWj1uIHxOXAlCzQamyiBHPtvmNoN4cVjQnqdzGyHl6XgOeHoRrRSGcNde6
 PrsXbsE2gUCLjeAwKNgKNb7Z2HgLK+QE=
X-Gm-Gg: ASbGncuAIUSgxBbdT9UXq/B87yJhCxJf5+hXjZX6wIT9RX6uhU+j8KQfnPnR3lV1O4N
 Vw0booDRtBF4MRSdYpR2qf6PNUDRGLN8k3KqAHj45zEqnqGhFe6430ZRtUlV+rcMy0KJSEPBBXz
 Osb5IJCIxo+W9di/He1cySqjse59bCK1yQusqm6nQ4K6CdCjTe8NBcclKajPwAyOkWyszjo2N4r
 ZMKAwN5CaPR/0mAt4VZ0ScUtVXnZwxyN3krMClUlg==
X-Google-Smtp-Source: AGHT+IF/gBSCiU/g9pMxhjR5rxlygNg0tVtK+KYhiZ3y+iCzYbOhGQQWCOugx+Ff1MNe9PI4rv/W56UuquaMYUNHsiQ=
X-Received: by 2002:a17:902:f541:b0:267:bd8d:1b6 with SMTP id
 d9443c01a7336-28e9a65690cmr34023285ad.6.1759522246208; Fri, 03 Oct 2025
 13:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251003200906.2204636-1-felix.kuehling@amd.com>
In-Reply-To: <20251003200906.2204636-1-felix.kuehling@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Oct 2025 16:10:33 -0400
X-Gm-Features: AS18NWDZKsd9u7j2wJzrpXxYUezj4h65_vASF-RZa_h15yLYvVdWlDWG6YPm6F4
Message-ID: <CADnq5_PG5sFL=iJhPAcn_b=a8NyGynzH8h8_OdnicyJEk--3vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix two comments in kfd_ioctl.h
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Robert Liu <Robert.Liu@amd.com>
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

On Fri, Oct 3, 2025 at 4:09=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.c=
om> wrote:
>
> Queue read and write pointers are "to KFD", not "from KFD".
>
> Suggested-by: Robert Liu <Robert.Liu@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  include/uapi/linux/kfd_ioctl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 04c7d283dc7d7..5d1727a6d0405 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -67,8 +67,8 @@ struct kfd_ioctl_get_version_args {
>
>  struct kfd_ioctl_create_queue_args {
>         __u64 ring_base_address;        /* to KFD */
> -       __u64 write_pointer_address;    /* from KFD */
> -       __u64 read_pointer_address;     /* from KFD */
> +       __u64 write_pointer_address;    /* to KFD */
> +       __u64 read_pointer_address;     /* to KFD */
>         __u64 doorbell_offset;  /* from KFD */
>
>         __u32 ring_size;                /* to KFD */
> --
> 2.34.1
>
