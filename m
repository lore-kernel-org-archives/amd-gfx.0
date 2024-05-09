Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07DBC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051DC10F5F8;
	Thu,  9 May 2024 21:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HrjXmP2i";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D671810F5F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:36:54 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2b4348fa971so1060563a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715290614; x=1715895414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTquz4WqDCQVR4nNPS5hnL4+sXIeQyTLSwygDy6W8so=;
 b=HrjXmP2iW8HCKm1bc7A0SAo3LS8/59g2VHVGT5PnzNI7OPU8btTi6Jpu4n99Z7iAIF
 saLDffPBw7MoxUpj04RHRAA6Kdwa4+DXT6xrkPyRahdGNG25AdjrW7uqd6oodkMwSA4r
 Kul4ifnjca37yMqXmFdTM2q5ETiZhaObWKM2kfRvGr+/+UBzDhs2jNsIII2VLqUSuOHp
 qf6WXzet7usfgBdrjulvmxU6pKOmcIrOlEjYusv8+Pau0DtWTW4Hu3sJRQqtNNobBmX8
 L6TARbnMLdUsz+LGIZicmjG4VLjoqEpYzgE/DgLE54xo5yaoDgk23Wk5wmSjrmqbsNyH
 iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715290614; x=1715895414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTquz4WqDCQVR4nNPS5hnL4+sXIeQyTLSwygDy6W8so=;
 b=dAHra+xsz01HHXSX5PVOVz+plZ3qtsOrjMQmfhFqvw15Apo7kilrBZZeJaIFWKVFRk
 kAKWWEWqmRuXxBy6TqyM4mJQETSIeJ8dV2m+SHho1rbkztkx8Aqrs8KTCdJCvJwi34WJ
 fmRmStcyGAchINBoIxp5W/O5IUoRlBUDsVvFh8O1ow4nCT0ppOP5TYXXxR3ooEiQzUCt
 vIjSSBcsU9jIiSBfF4g7WozYSXlGTyQwt2Ehma7IvDwcS5m9WnwTwasWvUagfTGQUA0g
 HAlN847MoCiodX0VqEXqKczRnFLxurLLnJodmW77/kEGC3+mAYKg6Lm9X5wba+m+qmJU
 IJtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVryS5LYnugTwZzZuyLWIGQBKGY7v/Z6jA4oHSbvx/KGirD+kl0hwHaTfMWxNSUV5nNEU8QWOL/5F0UsCcSMikFWwbnVc4v0qpiwpMFw==
X-Gm-Message-State: AOJu0Yz2Kam8GVRSDCgRcTNztFi0djghQ4FXoqan4BzWjCAcbctLntoI
 I5hky3IWn+PufXU7No6bM8Onmtk2TcjvDWVrUXmJ0GKlJVybFGugfIfhlWFTv2csjS/FVE8u//a
 4xMNZKfgIunod6llX7gpaDymFg2EEvg==
X-Google-Smtp-Source: AGHT+IETtQbW3RnBcE87quNEewMrQhimja62yOIAFlKntzh6pnj7C9nDFCoCXO6YaWM7/tI0J3IGTlghqMaQPCGckVQ=
X-Received: by 2002:a17:90a:4589:b0:2a5:2ef2:4ce4 with SMTP id
 98e67ed59e1d1-2b6ccd85d1amr676485a91.41.1715290614166; Thu, 09 May 2024
 14:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240509204631.1489565-1-David.Wu3@amd.com>
 <CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com>
 <cdd46ba4-4ceb-45d6-a204-4097216df9e2@amd.com>
In-Reply-To: <cdd46ba4-4ceb-45d6-a204-4097216df9e2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 17:36:42 -0400
Message-ID: <CADnq5_M6+yMtMDz5kr6FYZyMT0ZB7pNc5Ln-vSb6e45Cn71V=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/jpeg: keep drm kernel message consistent
To: David Wu <davidwu2@amd.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Christian.Koenig@amd.com, leo.liu@amd.com, 
 sonny.jiang@amd.com
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

On Thu, May 9, 2024 at 5:31=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> Hi Alex,
>
> Thanks for the suggestion!
> What I am thinking is "DRM_DEV_INFO" should not be the one we want - as i=
t is more like a debug message.
>
> [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.
>
> instead I prefer to use this format:
> "amdgpu 0000:43:00.0: amdgpu: JPEG decode initialized successfully."
>
> but again I dislike it as well as there are 2 "amdgpu"s in the same messa=
ge.

You can use just plain dev_info().

Alex

>
> To make it consistent the "DRM_INFO" is used everywhere in the amdgpu cod=
e.
> only the following jpeg code uses DRM_DEV_INFO and one file for vcn. All =
other jpeg versions have already changed to DRM_INFO.
>
> grep -r DRM_DEV_INFO *
> amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized su=
ccessfully.\n");
> amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in =
VM mode\n");
> amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev->dev, "VCN decode initialized succ=
essfully(under %s).\n",
> amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev->dev, "VCN decode is enabled in VM=
 mode\n");
> amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized su=
ccessfully under DPG Mode");
> amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled i=
n VM mode\n", i);
> amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized su=
ccessfully under DPG Mode");
> amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled i=
n VM mode\n", i);
> amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized succ=
essfully.\n");
> amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM=
 mode\n");
>
> If the rest of code in amdgpu uses DRM_INFO why should we make VCN and JP=
EG special?
> To address the identification of which GPUs - we need to check the kernel=
 message after each IP DISCOVERY.
> I do not see a reason to mess them up.
> Regards,
> David
> On 2024-05-09 16:59, Alex Deucher wrote:
>
> On Thu, May 9, 2024 at 4:57=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@a=
md.com> wrote:
>
> amdgpu jpeg kernel message is different than others such as vcn:
>   [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully=
.
>
> This patch is to make them consistent.
>
> The message after the change is:
>   [drm] JPEG decode initialized successfully.
>
> Please convert the others to DRM_DEV_INFO instead.  Otherwise we can't
> tell which GPUs these messages refer to on multi-GPU systems.
>
> Alex
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index 64c856bfe0cb..4be0668ab97d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n"=
);
> +       DRM_INFO("JPEG decode initialized successfully.\n");
>
>         return 0;
>  }
> @@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec=
_ring_vm_funcs =3D {
>  static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>  {
>         adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v5_0_0_dec_ring_vm_fun=
cs;
> -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
> +       DRM_INFO("JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs =3D {
> --
> 2.34.1
>
