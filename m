Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE7E68948
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 02:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B01D10E0DF;
	Thu, 31 Oct 2024 02:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WaoPtNTa";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0531710E0DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 02:59:02 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-7ea535890e0so70569a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 19:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730343542; x=1730948342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyQTsj59ymXZCVvRxHQD+Wls2z9/M4HOX9yJ+RJ0o4E=;
 b=WaoPtNTaGHDw/8G3v5kFR+/skMbqgiJ0BheGFRRT2GJk36wlX7RUTwsDKKR8X7hdli
 aSgFDRRXpTShzmqWggpCKlZXdmi90Nj42eoNfJnVlmyVY6CzlHUnrXta5k5qDLCQSDZL
 M3wGgL6jUMrlKAalLJV2ECD9qqPv6vSje2ask7uXzcc58a4HEZZeEkU99jEMzHURa5Ns
 u+9RNn9ykSo8sn7AqsQITHCmKpycJkWmNzVUUKvnR9h7OHnGgX0KYD20l5lCJDn5vgk9
 B+P7O70iJudwyvjZW4fghNuL8NWjvZRfqDyf0Oeha2kWEsyo5/kM7tu8eLNXZgvxIRvo
 ZyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730343542; x=1730948342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyQTsj59ymXZCVvRxHQD+Wls2z9/M4HOX9yJ+RJ0o4E=;
 b=c4zrG/mp1Qh3BIMIKKrNAS7iHmURM66uFFjgFzAKmvvNMC5lV826d2sXLgT+G2vm2G
 VI8wc8ec60xC2Rc1eNwOzfhFSk156eKXwYpND8Wi+dJxI2kpngULkBda6+5Ite935ZAb
 4ocpTNp/vdRIt6fH2xlamWvlPN//xGbzu8/2tETyktxUWiQ8v8ooT/EdY/J7iskA/wR6
 +mf3IyAFELwSUD7TLQTgAO8CVC6HWi27uKv9wlcHgrBHEiz1QeucYM9NodWy9ye9Gwlw
 DN7GNSz8tm8zrlMVVV99YQal/iOuZzvOTeyDnt4oK1OBsLeQApb/Ee4rGi2GPtXcv+AV
 XFig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZJThlM9ZsLtbh0LkTajR6nccKcZqMVdDKEI8JTNvSEYQck2eRGumpkmOqLndD+fIZTlLYNNPN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL4nnAjYjBeMLIzrw0vbDKllcYJSrbHHgeEdu1Ei2het7mx0nK
 GfA9O5+jRyxXjHVLTar6mYTz/fJa0jMPo+4CglO2EtFMP9QbitXUZtYmNfnY7PbXNZ+bEcjjeLi
 BVGsSiSAR4iY12BKtS6cCgzxdhGvC6w==
X-Google-Smtp-Source: AGHT+IG5Huh5l5SvBFJegUEPSt1tbYfLuM73y5hKl9g80919hKQdl0ygJRUnrNoql3KjxFsaiACUdBJhLb1VEGgL8Vw=
X-Received: by 2002:a05:6a20:6a0b:b0:1d8:a203:95a4 with SMTP id
 adf61e73a8af0-1d9a83da881mr12742161637.5.1730343542294; Wed, 30 Oct 2024
 19:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241023210342.685808-1-alexander.deucher@amd.com>
 <CADnq5_M3ar8qGBFVF5p7YUbVsjZvzCdkDcJ-GM7J+T15vfJOhQ@mail.gmail.com>
 <CADnq5_OAwioJzxgonFEPNCHSWNOvmCowh=_OCQ-jcowP-Bcomw@mail.gmail.com>
 <PH7PR12MB599777B2FBF5C082AF2CC2D282552@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599777B2FBF5C082AF2CC2D282552@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2024 22:58:50 -0400
Message-ID: <CADnq5_OMxsiJR9LGNJE-2pvE1SoMtMJXJu1BxmYZh1qRf+1Bwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permissions
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
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

On Wed, Oct 30, 2024 at 10:23=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Is this for the whole series or just the first patch?

Thanks,

Alex

>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Thursday, October 31, 2024 12:03 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permi=
ssions
>
> Ping on this series?
>
> Alex
>
> On Mon, Oct 28, 2024 at 10:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
> >
> > Ping on this series?
> >
> > Alex
> >
> > On Wed, Oct 23, 2024 at 5:04=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> > >
> > > Regular users shouldn't have read access.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_debugfs.c
> > > index 6e6092916d4e..e44a44405266 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > @@ -1654,7 +1654,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_devi=
ce *adev)
> > >
> > >         for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {
> > >                 ent =3D debugfs_create_file(debugfs_regs_names[i],
> > > -                                         S_IFREG | 0444, root,
> > > +                                         S_IFREG | 0400, root,
> > >                                           adev, debugfs_regs[i]);
> > >                 if (!i && !IS_ERR_OR_NULL(ent))
> > >                         i_size_write(ent->d_inode, adev->rmmio_size);
> > > --
> > > 2.46.2
> > >
