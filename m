Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF1C25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 14:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09E310F53B;
	Mon, 27 May 2024 14:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zn6sRmPv";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B15510F576
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 14:47:51 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-681ad081695so2316346a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716821270; x=1717426070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjFtUNOFrl0U79JGCNqNT+ZYkZGxyO/Act+0yAlRUvQ=;
 b=Zn6sRmPvmU38B6/WyvvNwwgil/izZ3GHRelpDmxZBvEo2MAdVSdLQqSTIbU/rdNflS
 ePVuZAZeCJ4JnqHqYJW0JMpRh3EpWvqVnhlczta+AVIKpPy9CYzZJistLYf7U9H9O7jp
 v3ec0/eng+vpSaZr/1z2XT4EzMYrSyNCEMFYOnsQDh0+Yn33qlxIBfTHVzxgTyj8hrNp
 ZwXyg6uTooWOUGIcm+q8acXz8ScSlySqwPA1fqlU2D4dPrbsYolYgFyFOHRIUZAyfz/N
 4Ved7JSEt+J5bFPEGnCmvFztYNM4vPxs8amfEOnYVNmoORuLRD6v/v1O+3p+UYCr673h
 Jhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716821270; x=1717426070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjFtUNOFrl0U79JGCNqNT+ZYkZGxyO/Act+0yAlRUvQ=;
 b=QBNqT1jfP50AeGKZTAnt1qx2Dqm5N56MBbacJUpKaPTW4+qERaYkIobvj2FFLx+qMA
 pZV+ekvuLAaUUhIcBma+J3+++p28Httf01xKWMWsceuqBnpfDhvlE8owIOPtPiEl//AZ
 ey6jkZjSn1c6RGtv7eonBbEpRplp3gbzTeZHnedjHVe536GJO4+Pn7WwF/QgZKzog8fF
 dz/t4fjNASugOG78jZddy0o+GnjDbGIbGuiFnivWsOV14QWeUbeR/15bKhQMZ0GkvoFG
 1j8TxI5x0XlHFjRUeW8A5z9bRh/uu4FaRUhIiDF6S58vj0gqA3KyZb5s0Rq0hEAwt91A
 KoQQ==
X-Gm-Message-State: AOJu0Yy3hyO7uh5ghunh4forxUQrlfA8a0vYl3lPxDA7xUzBHzD5DUqT
 h1v9edrt2q4DD8MX+/bBAtEcvl1ZgszRh9cNTGT0c+o4vmtGWgylwxpaDjjzctXyc3Bsm+bjZH7
 IIrMPHBeNf09xAppsWlZWq5Xzp7WhJg==
X-Google-Smtp-Source: AGHT+IEVSc2MmR5l7594DpkjrAPxuHmOSf67npJxZV0C94+2CcYvoe0HEpuq+0h2HHllhaTPFVl4fkAS06cKAiX1XTo=
X-Received: by 2002:a17:90a:f413:b0:2bd:e884:bc72 with SMTP id
 98e67ed59e1d1-2bf5e944550mr9134682a91.5.1716821270524; Mon, 27 May 2024
 07:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240523071637.1114898-1-tasos@tasossah.com>
 <CADnq5_MAPCEO4mNouRHnPMy5-OPXyN1cjy4Ub_xVip4m8x4OZQ@mail.gmail.com>
 <d064e35f-4990-485b-9426-a4f5ab9f3375@tasossah.com>
In-Reply-To: <d064e35f-4990-485b-9426-a4f5ab9f3375@tasossah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 May 2024 10:47:39 -0400
Message-ID: <CADnq5_OX52-0Enb6E1qDhDZ-G-Sd3cgGF5hUouofgkq7VzK1_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
To: Tasos Sahanidis <tasos@tasossah.com>
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

On Mon, May 27, 2024 at 5:42=E2=80=AFAM Tasos Sahanidis <tasos@tasossah.com=
> wrote:
>
> On 2024-05-23 17:52, Alex Deucher wrote:
> > On Thu, May 23, 2024 at 9:05=E2=80=AFAM Tasos Sahanidis <tasos@tasossah=
.com> wrote:
> >>
> >> Dyanmically sized arrays used [1] instead of []. Replacing the former
> >> with the latter resolves multiple warnings observed on boot with a
> >> BONAIRE card.
> >>
> >> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> >> ---
> >>  drivers/gpu/drm/amd/include/pptable.h | 24 ++++++++++++------------
> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/a=
md/include/pptable.h
> >> index 2e8e6c9875f6..d1dec880d2d6 100644
> >> --- a/drivers/gpu/drm/amd/include/pptable.h
> >> +++ b/drivers/gpu/drm/amd/include/pptable.h
> >> @@ -480,7 +480,7 @@ typedef struct _StateArray{
> >>      //how many states we have
> >>      UCHAR ucNumEntries;
> >>
> >> -    ATOM_PPLIB_STATE_V2 states[1];
> >> +    ATOM_PPLIB_STATE_V2 states[];
> >
> > Can you add __counted_by(ucNumEntries) to the end of the line? E.g.,
> >
> > ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
> >
> > Same comment for the other changes below.
> >
> > Alex
>
> Sure thing! I have the v2 ready and will submit after testing it on
> hardware. I do have a question though. The following already uses [].
> Would it be acceptable to also modify it in the same patch?

Yes, that's fine.  Thanks!

>
> @@ -658,7 +658,7 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Recor=
d
>
>  typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
>      UCHAR numEntries;
> -    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
> +    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[] __counted_by(numEnt=
ries);
>  }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
>
>  typedef struct _ATOM_PPLIB_SAMU_Table
>
> There's also this, which I think __counted_by can be used here as well:

yes.

>
> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/=
include/pptable.h
> index febc853d2a07..341d4a4e8d98 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -497,15 +497,15 @@ typedef struct _ClockInfoArray{
>  typedef struct _NonClockInfoArray{
>
>      //how many non-clock levels we have. normally should be same as numb=
er of states
>      UCHAR ucNumEntries;
>      //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
>      UCHAR ucEntrySize;
>
> -    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
> +    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);

Yes.

>  }NonClockInfoArray;
>
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
>  {
>      USHORT usClockLow;
>      UCHAR  ucClockHigh;
>      USHORT usVoltage;
>
> All the other ones are UCHAR, so __counted_by can not be used on them.

I'm not following.  Why not?

Alex

>
> Please let me know what you think.
>
> Thanks!
>
> --
> Tasos
