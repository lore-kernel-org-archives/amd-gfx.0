Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63731C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 22:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA4D10F725;
	Thu,  9 May 2024 22:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiKDJoAn";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847A410F725
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 22:07:19 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso8874265ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715292439; x=1715897239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nl9ZpDmk3p+vQrLiW0e4ognMEACdf/AGBA0g1TqePJg=;
 b=HiKDJoAn9O7Hnlc67HoleH5+frZm5z4w4hBOWGhL/VEOeSkU8Lo02Vj4K4+x+6I0S1
 gBh5V4edEYQ47oLVHZznTkIMDs8sRwB+0cP+86+jgS7ATqOmJzWGq5UZCYo87M1ILyL6
 ljP/mdrLhUZaCsWfUvsZyHtuys9CZnjMTr33OufkcD/LVBwN+983QpSZsw5jscjCCYH4
 07yXxgO5cfmg+8T2p7esE55nFvJgdiX7Yja2XfeEAIRidXfeBaCkfLXytKpnf+j3iIu8
 ezDJ9w6tAHO3iSyVW/AL1Ca5KbJRo70H0wt+xZDZcHe+SG8ZauYEyKvhgUanbSoE90B4
 81dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715292439; x=1715897239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nl9ZpDmk3p+vQrLiW0e4ognMEACdf/AGBA0g1TqePJg=;
 b=Z8tJAvL9XvdDtNqy9fc4xa5vFKFJ30UKdjoM4TDvNHSHVjdFohGMo5Z2Ar4RVyRil1
 w0dUGRP3WrZ0gQ8NyP1/bKfU0gLsoP7jTCM4OMeUJl1TnGOFk5D6nLVPg1H9K7NrjE04
 nK+9Z4WB5NWdmb7nhpBakOMaLCYwuYNclGL5Xft4ZCn4hGENt/Bnp3rVrgSlQgwWkXHR
 SdVL0eE4s3QfCC6C+lHAR+DKCf21u487amtEdd29tjnoHflqOVwPtQs1dcjvd3DtHxT9
 5Incibo3GXohPYMms6m9/N35pX1DF83lsRMnBBAkuiFN1YKdCgRLN93jDDhV+0rpwqFb
 aQDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Hl004tg9D5VH9hB1zF5I+yt0gOub3snjnt5BLb7IS0hMS8TLhZG89Irc4Zode9rCuy6QgwJtDvFAv+jWVfAv0WBxGXdxjFD2P6iySA==
X-Gm-Message-State: AOJu0YzinDNXnMSRL+1ikOC36zCM4HHvVA/04UgLheO7VLUirPJ6cXiz
 EVO/pOJVgJcjUduzTMuqI2IGCjKSjPdf/Wm46CKziacS1nTBwoXHyqoVTIeQQGKIxLX4DgqAoGL
 935mV+1oG4b3L/GymatTDXDcryKE=
X-Google-Smtp-Source: AGHT+IEFNfSlpf4YloyJ5uQb7jnWaYjToK6t/EQx4mAFnLh09sjK3zmNo6NexrEPXAZnf/h8eLx3IR8M4aF2qvLuFx0=
X-Received: by 2002:a17:902:d3d5:b0:1eb:86c:ed70 with SMTP id
 d9443c01a7336-1ef44060dfemr9446315ad.59.1715292438661; Thu, 09 May 2024
 15:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240509204631.1489565-1-David.Wu3@amd.com>
 <CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com>
 <cdd46ba4-4ceb-45d6-a204-4097216df9e2@amd.com>
 <CADnq5_M6+yMtMDz5kr6FYZyMT0ZB7pNc5Ln-vSb6e45Cn71V=g@mail.gmail.com>
 <678ac44c-4105-461e-ad32-83b0ecf04576@amd.com>
In-Reply-To: <678ac44c-4105-461e-ad32-83b0ecf04576@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 18:07:06 -0400
Message-ID: <CADnq5_O-XmfOBgoCmHa+tg=OVQUS6W+EHeymUy5j0Do1Cy7pwg@mail.gmail.com>
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

On Thu, May 9, 2024 at 6:03=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> Hi Alex,
>
> Well - the dev_info has 2 "amdgpu"s.
>
> [   67.227121] amdgpu 0000:43:00.0: amdgpu: JPEG decode is enabled in VM =
mode
>
> In practice we use "drm" to grep the GPU info for VCN and JPEG support.
> So I believe the DRM_INFO is the best and it is used by most of the amdgp=
u code with exception only a few jpeg code and one vcn code.
> in case of a need to convert all of them to something like:
>
> [   67.227121] amdgpu 0000:43:00.0: JPEG decode is enabled in VM mode
>
> We can just change the macro of DRM_INFO.
> Do we agree on using DRM_INFO?

Doesn't matter to me as long as we have a way to differentiate between
multiple devices on a system.

Alex

>
> Regards,
>
> David
>
> On 2024-05-09 17:36, Alex Deucher wrote:
>
> On Thu, May 9, 2024 at 5:31=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
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
>
> You can use just plain dev_info().
>
> Alex
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
