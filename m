Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E24BC36005
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 20:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A890110E120;
	Tue, 25 Mar 2025 20:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CYMYqJ4U";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1115210E5FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 20:38:23 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-301a6347494so1499460a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742935102; x=1743539902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXTPcUXqGt1fhBFrHqeVecRiPrIlJ3rKRHVCNGrKTuk=;
 b=CYMYqJ4UruYvasbK9xftIKq+iEIi65d/u3/Wpb/5dFiSYrWI555PIz0C7r/4JZrM5x
 o8UZcBVFImtGeSRW7W4z7dxMCKHXmD/bi7JihKZe0JwVZWyjj2htn6yBDHy+0LqOVn9q
 rJLrgGS/vbwrmDTK9Qfo0Xs2k6vmx8ETxQv49jfcl3Hzw2tWNjIVmto4C9X4zxDe+pN3
 JHBJtvqyzbv6eUDincXP2Q21uuNv3B1nzsk3+qhCUP9Tt65SIUqfhNXEfJDzHHrf1YjR
 lvL1lrT+cngsf/oa++rcOqG1omTgMb3zZnXtedMPaqzJOUWB+uZcW2MqwJkQqDdS9Fel
 FOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742935102; x=1743539902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXTPcUXqGt1fhBFrHqeVecRiPrIlJ3rKRHVCNGrKTuk=;
 b=vQxHRap9by9BJ6K3xb3j6q1AoHDa2HqBOHDsCMMForOcK3RAKkGZE+hHkuWHMRCFa5
 y5+3yMSnQEhMtMrffkBYyHFbT8VcOSGKRdIqV1nR3zgvehKNVVMkkRcajJgHWsdpxwZr
 SNeHPZEZ0Oj9Sux8FcCYvIxAmod/o37cSdz3v/y/2Ih+JtwMUznAaWlkUT3Nxv/kfcaY
 sz79dWjxEBpZfc1J/0dUQ7AHF3AGG/lR9ou8JjpV13sEwgRy1GaXEXI2Xop0Oe5RE8Oc
 1CN7D7jkO+9x8zRxtCN35AmWVRlaKQ5YZ3eI2BDJ81siuuL+jGN8xr6qTGIIG3TsCtRK
 62ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuwAYnM5zhlIZMdwObYsxj+J1JYy9ebLocCbDa0v9H/MfGBtG/X8VLClJddvPfHWDBA3uNLH1l@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLYXtOXcKeL1r69XSRNktEpEv5ECEckrp0s0gdcptEzTwPposk
 qBq+qXZkUqI8YoYcYnYODN+Q6mBkYVA7dnyqvcEx7klgtgET5X3qkPdsBxR/c3XmsPSx0X5tVvu
 Hlp0mmOC3fetI6ShZAUlplE1dZWJiIw==
X-Gm-Gg: ASbGncuu4gpVmlI2slCE487ovCepO45C8DzF2d2IFykXaxeyayiWVj19qxH47GPWuaR
 i5VJ1sfKpB41+IwOjol8T5Wn5QswdSn4w5fXJSEXDKCh7rzh0FkHyFhiRBTaDR9Ds3iaZHXowfs
 CHGhhqqrrPMKJdXKgU/X+5Q0JKRA==
X-Google-Smtp-Source: AGHT+IFonAuSDPlhGjiLgRlnQeUzLgmmclW6njsaWuT0cRVUuOUDWscUuE1JJ1pGJd1j0su1shtP2YDZmoFpqDhCpwk=
X-Received: by 2002:a17:90b:1b09:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-3030fee39d8mr10712815a91.4.1742935102182; Tue, 25 Mar 2025
 13:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
 <qb3g5stqctrdwfqwbrlwzuevcuxvof4z3yj2iigfuv4mrzpbc2@ubfz5xidet53>
In-Reply-To: <qb3g5stqctrdwfqwbrlwzuevcuxvof4z3yj2iigfuv4mrzpbc2@ubfz5xidet53>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 16:38:10 -0400
X-Gm-Features: AQ5f1JoQ5dBLlGDTzrh5qlZ_9H5cbAyNVdyzEHtwOPL8GIowUNTTU7WsqWBol4s
Message-ID: <CADnq5_Ns=MMiO=VvWpT9Gr6Kb5grqXA5TR_omYB411m=K2y-SQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx6: fix CSIB handling
To: Rodrigo Siqueira <siqueira@igalia.com>
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

On Tue, Mar 25, 2025 at 4:16=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 03/19, Alex Deucher wrote:
> > We shouldn't return after the last section.
> > We need to update the rest of the CSIB.
>
> What is CSIB?

Clear State Indirect Buffer.  It provides the clear state that gets
put into the hardware context if when user mode puts requests the
clear state in their command buffer.  Driver programs this explicitly
when it sets up the kernel rings.  Driver also provides a pointer to
it which is used by the firmware to load the clear state in some
cases.

>
> What happens if the other CSIB is not updated?

The clear state packet submitted by userspace won't work as expected
if the clear state is not properly initialized.  In this case, I'm not
sure if there is actually a function difference since the driver
always initializes the clear state at kernel queue init time, but best
to make sure the buffer pointed to by the RLC is correct.

Alex

>
> Thanks
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> > index 13fbee46417af..cee2cf47112c9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > @@ -2874,8 +2874,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu=
_device *adev,
> >                               buffer[count++] =3D cpu_to_le32(ext->reg_=
index - 0xa000);
> >                               for (i =3D 0; i < ext->reg_count; i++)
> >                                       buffer[count++] =3D cpu_to_le32(e=
xt->extent[i]);
> > -                     } else {
> > -                             return;
> >                       }
> >               }
> >       }
> > --
> > 2.48.1
> >
>
> --
> Rodrigo Siqueira
