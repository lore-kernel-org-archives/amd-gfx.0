Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E72D5B143
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 20:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D452910E0DC;
	Mon, 28 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lj0dcn36";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535B910E0DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 20:05:30 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-20cb8954ec9so3777855ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730145930; x=1730750730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FE0qhmRqgZGH4hrp1c5RCm5X6K57CtSftHFWUGWozO0=;
 b=lj0dcn36+o5/VHPqO/rupQ5ci0XxNZI/R5rCHd4bfkYAyXeIvrbYXE7YKcvsHWHyd5
 EaKXbnNRk34Tn13OytqYh2laBZxM3cNXOGXxcyVUIKt+ZeSZ0y5f4PQDB+vL6pnI+dcB
 Tq5N3f6QIKZKMmR3Me6YwbA/M6ol2BOemiZaBk9Fdd8VWiknUTkq9fbVa7uf/Vk91mWF
 zTKdAT8XLhqpAQFSUmRD4s7ECvjGfIDoD0wKs88iLeixtDJyLOsSV1/9iTxKJ367+g68
 lYAEeaNb+fUeLhT6Xax0Eup6tYM6XUo1caMq+e671hlK7sDT0XsI4boMlSzEgex09g5z
 Qwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730145930; x=1730750730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FE0qhmRqgZGH4hrp1c5RCm5X6K57CtSftHFWUGWozO0=;
 b=DmZtWuWVJh0YxaOFJpiLFEzbb9uDHksWxBqn8c84dljYTGaZgi4YZfTkpAfavG8fiD
 WH4Yh5KstOKOqX7WdpHoAOzKA3OnjppnCim/vCPApkxWVDRnmAumEVXWSKqRjuCKjbfA
 b4PpsdkrYRs7wEhSYgHgR7HJlmhdzioiyQt6tSGS/k4LZqCPJHACTYwBohrce7ZgrjEz
 LXoJgTpKrghnvD2HIlg79KFfb1xO+8+/wdQOVRjQbWnfwKJ3g8770WWlRStiEzZJM1gd
 J9s6ivp1iiI+TEQJVA/jW6HwD/YX6fbwhmQK1/8FSpG0u3HoG84Up7QnrSFfSAljd3xI
 96Xw==
X-Gm-Message-State: AOJu0YygjboQ6W2Oxvsx70Mmqy0x8/lXNIS5ArO6wZdnNiIMUuzfaD8x
 z8CskH47ebw7sll3tkFCSh9tsG5N/PPKuDe1YwkXNrodlOvkGvbAOgSmHyWiw0ZJGEv8A3KZAZr
 90zftn3RbUhBU/lk2X8/ppSZP3UA=
X-Google-Smtp-Source: AGHT+IH/O48hq39PkFOZTjBfpjIDLIcbPkcoGVC4XSO7SWALLA0yEIIfTJYy/6oaeJE/A5Qzr/N2KFgRuCGEfrHa33M=
X-Received: by 2002:a05:6a21:7884:b0:1cf:35db:2c3c with SMTP id
 adf61e73a8af0-1d9a83af5bfmr6036968637.3.1730145929604; Mon, 28 Oct 2024
 13:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-10-boyuan.zhang@amd.com>
 <CADnq5_OQ=Nj_U5gYODLkHnoPpvKBpWrtVQynKJ=z=1E7_QUeBw@mail.gmail.com>
 <69ceb132-9cd4-45ef-973f-6dab0dfe1dab@amd.com>
In-Reply-To: <69ceb132-9cd4-45ef-973f-6dab0dfe1dab@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 16:05:17 -0400
Message-ID: <CADnq5_OiMxw4a6ejyY944+AQ+k9aAHYw9ucFKJbO758-ry-_aw@mail.gmail.com>
Subject: Re: [PATCH 09/29] drm/amdgpu: track instances of the same IP block
To: Boyuan Zhang <Boyuan.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Mon, Oct 28, 2024 at 3:53=E2=80=AFPM Boyuan Zhang <Boyuan.Zhang@amd.com>=
 wrote:
>
>
> On 2024-10-28 15:27, Alex Deucher wrote:
> > On Thu, Oct 24, 2024 at 10:48=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
> >> From: Boyuan Zhang <boyuan.zhang@amd.com>
> >>
> >> Add a new function to count the number of instance of the same IP bloc=
k
> >> in the current ip_block list, then use the returned count value to set
> >> the newly defined instance variable in ip_block, to track the instance
> >> number of each ip_block.
> >>
> >> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++=
+-
> >>   2 files changed, 25 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index fba10ad44be9..2e2c6a556cc8 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -390,6 +390,7 @@ struct amdgpu_ip_block {
> >>          struct amdgpu_ip_block_status status;
> >>          const struct amdgpu_ip_block_version *version;
> >>          struct amdgpu_device *adev;
> >> +       unsigned int instance;
> > Thinking towards future work, we should add a `bool harvested;` member
> > to the structure so that we can skip harvested instances in the common
> > code going forward.
> >
> > Alex
>
>
> OK, so do you suggest to add it in this patch set, or a separated patch
> set when we implement it later on?

Later on.  Just thinking out loud for when we clean up adev->vcn.
I.e., we can remove all of the checks for (harvest & (1 << inst))
because we can set ip_block->harvested =3D true in the common code and
then in amdgpu_device_ip_early_init() we can do:

if (ip_block->harvested)
   adev->ip_blocks[i].status.valid =3D false;

and we won't have to check for harvested instances in any of the runtime co=
de.

Alex

>
> Boyuan
>
>
> >
> >>   };
> >>
> >>   int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 7c06e3a9146c..065463b5d6a9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -2322,6 +2322,28 @@ int amdgpu_device_ip_block_version_cmp(struct a=
mdgpu_device *adev,
> >>          return 1;
> >>   }
> >>
> >> +/**
> >> + * amdgpu_device_ip_get_num_instances - get number of instances of an=
 IP block
> >> + *
> >> + * @adev: amdgpu_device pointer
> >> + * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
> >> + *
> >> + * Returns the count of the hardware IP blocks structure for that typ=
e.
> >> + */
> >> +static unsigned int
> >> +amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
> >> +                                   enum amd_ip_block_type type)
> >> +{
> >> +       unsigned int i, count =3D 0;
> >> +
> >> +       for (i =3D 0; i < adev->num_ip_blocks; i++) {
> >> +               if (adev->ip_blocks[i].version->type =3D=3D type)
> >> +                       count++;
> >> +       }
> >> +
> >> +       return count;
> >> +}
> >> +
> >>   /**
> >>    * amdgpu_device_ip_block_add
> >>    *
> >> @@ -2354,7 +2376,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_dev=
ice *adev,
> >>                    ip_block_version->funcs->name);
> >>
> >>          adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;
> >> -
> >> +       adev->ip_blocks[adev->num_ip_blocks].instance =3D
> >> +               amdgpu_device_ip_get_num_instances(adev, ip_block_vers=
ion->type);
> >>          adev->ip_blocks[adev->num_ip_blocks++].version =3D ip_block_v=
ersion;
> >>
> >>          return 0;
> >> --
> >> 2.34.1
> >>
