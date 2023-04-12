Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFB1C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 17:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D50710E8C3;
	Wed, 12 Apr 2023 17:29:49 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0857010E8C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 17:29:46 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 i15-20020a9d610f000000b006a11f365d13so5134158otj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681320586; x=1683912586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfPCKUUE0rSU2xccAhhwsQ4SYMeE9xy9VKDTQq2J+/I=;
 b=h0MK+7IORafuS0JMJsi+I7pTu0ez22+axvnpuKgJHzxYhgZRAfXJm0JMinY2Dx/L89
 k+O8JYgXFImV6p83Bn6YwyHlORE5oQf4LVeRCyW8lkQCuijH02z6etlYMqOVpYf9nOHM
 ZlE9qyX/SWslpL5QrQeCFOiglLiPcFEL5LtUw3URharojJs9izNtLzIGrOq6dS8Tp9lg
 CUi3xXwPXpleb5T9GdKJB3KA9OD72dL5thN50YlIQTXy+F5MIXWjfWo9n9zWIqSB8xAS
 SwVBNr0bVOejGedFMLgvMh6XPiz9wD/hyitylQuxAcQ6gKNTk3LHEy6s6DJIlj9HF8ri
 U5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681320586; x=1683912586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfPCKUUE0rSU2xccAhhwsQ4SYMeE9xy9VKDTQq2J+/I=;
 b=CB3O3f4KTaTX596Di4/sMvOeA1nXXctEspaCl3FZJxHoNhR7wrYmR7CwGCVepnPoYg
 RnNzFuGB3keUQV9iCpFEGSwDEV41WD9UEMHiM6ax4ruYkCemXa97IzvN2aKN9Zvw5Uhc
 j6lJa4es3vm+lORjFGTGg72F+YjV53qaXE98c3FRLuhFKBprlGv3b1SXjOATuoX7f6uu
 /b7UmYZ8YKUHx8s3ds+vNjndfTnBFMP/IH9M54eSYuRJ+HrHASwGWM+g+vfxwsJSIevq
 60fbcvMv0Gd+tKX+aLREfRvExTcXmwYMf/TDeEbUAas9M+qgZOzRt0R0hyd2ViO7WGRG
 h8AQ==
X-Gm-Message-State: AAQBX9fm2Ha1Lxsi+9ktEyJrCRBcJ3KuBI1peS+E9XwggYILbWo1EOFD
 BPtr3Z7mAnwcl9qhf4hautHup/r8jIrBnJ1UfD4=
X-Google-Smtp-Source: AKy350Y7SXDAwsP8fXewh9qFud3onI/Uvvw70q3Ibstz0g5KecWwpyFZfLXuZMMRh4QIudsxZrBsir8tDfiZaPDXAK4=
X-Received: by 2002:a9d:75d9:0:b0:69e:aa7:6b71 with SMTP id
 c25-20020a9d75d9000000b0069e0aa76b71mr1008476otl.3.1681320586052; Wed, 12 Apr
 2023 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230405112921.3690452-1-aaron.liu@amd.com>
 <de75d47e-169c-3302-8501-f0bdf5323346@amd.com>
In-Reply-To: <de75d47e-169c-3302-8501-f0bdf5323346@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Apr 2023 13:29:34 -0400
Message-ID: <CADnq5_M5uvtiVdwewi7JoTHVZQBHffzQZgsu3FAbbP0nXcYn7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: skip kfd-iommu suspend/resume for S0ix
To: "Limonciello, Mario" <mario.limonciello@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 5, 2023 at 6:06=E2=80=AFPM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 4/5/2023 06:29, Liu, Aaron wrote:
> > GFX is in gfxoff mode during s0ix so we shouldn't need to
> > actually execute kfd_iommu_suspend/kfd_iommu_resume operation.
> >
> > Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> > ---
> Probably should add to this patch:
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 3b6b85d9e0be..5094be94fa06 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3304,9 +3304,11 @@ static int amdgpu_device_ip_resume(struct amdgpu=
_device *adev)
> >   {
> >          int r;
> >
> > -       r =3D amdgpu_amdkfd_resume_iommu(adev);
> > -       if (r)
> > -               return r;
> > +       if (!adev->in_s0ix) {
> > +               r =3D amdgpu_amdkfd_resume_iommu(adev);
> > +               if (r)
> > +                       return r;
> > +       }
> >
> >          r =3D amdgpu_device_ip_resume_phase1(adev);
> >          if (r)
> > --
> > 2.39.0
> >
>
