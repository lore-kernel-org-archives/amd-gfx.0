Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E0C27C79
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 18:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2075A10ED89;
	Wed, 19 Jun 2024 18:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVLNMaSK";
	dkim-atps=neutral
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DA410ED89
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 18:44:55 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so1632431fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718822693; x=1719427493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vv9LZhEu+cilk2qksmNRLgLtANUGEe5h3QkXqavjIAs=;
 b=DVLNMaSKiNhF+klvB9EIqBNDwpbiktMxelJzRVZtHeY1KypUy8y0LgyZL7TQBOGA7S
 +u2E3ddsPtm9BJaX1jKc2W7Oq2QEyOm8H8omyRZBj55VV2BBXMJYTOkXcBPe3HR50vNb
 nV1ZQSGSdUs0sD9DbP6LTumrGHBpWKi1cOU/HkDjo/5FO9Rj4JPCS0DrB/i1UPe3zlGx
 /6pMb8Yxis5UcD/jRbXb5u9uGx7uAOnBHUgLBklEcgnUANEwxM3VI8IYYLw2aBdhCj0E
 F271KSNCRLJIhCeXtH8avas8QTOPiRt70AiyFyPM+EQbKJ9iXxjkhuf9fK1dx43EDEdk
 g4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718822693; x=1719427493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vv9LZhEu+cilk2qksmNRLgLtANUGEe5h3QkXqavjIAs=;
 b=wuOWJ+8rMFjuvb9kCgWUJdJHeqWrzt0ztJ0pPNPNU1oV5VOHdB0AhU+0E+yV0xV5XV
 sTes13Y89JVSQJLnb0ceuzBRzg+kcm0whvG8XvYN6GCdFzoM36fcPFoPujhLXJMRKQJR
 WHpL+wGm1s2BJCSSvWKa1H+dglfX8vQjfGjCybFmYXn3oH/hI98UF65uu9JAUarXk601
 +5da+aGqAxEDghBlUZTU+c9A19SpDo2ivt1lwvy3nto8mb2G9TD4qSAi8abiqGgLgWEp
 j29/nrS7knPbz8CSD2u2RCha2Q2BI8nE37d3RGyMLv8vw9lzRZtFsVQBARsjh6Qw7VJn
 OGmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNYzuC6YJE6D9eiF+QfvieK1Rc5BgtFNr1EE6cnW6vf2cQkMhcOfC8a6MRoakMHJHgFGj5CogcnR0SRqLGAOQe4VNUTMzPt4+yqtFVzA==
X-Gm-Message-State: AOJu0YydU9po+4fgN8uxtNMw9hgTNiXBwRbww5lG5REPOBy9VDf6gN+N
 tufg54YqyAp7dY7NWfKsiJnMJ2m0jEZPcib4BsJE1vpE+kx2RMDSlsXlI7eJWw+rAArSyd9G7ii
 2pSGek3HwHw8DqL4jRDFvfTtYKSA=
X-Google-Smtp-Source: AGHT+IF7SNLHAz7wZHXrx/lIg17ePeCNBQOXw/gqvhWYoaQziyp45t7y+BZICtdN2R4G6TLyJStDlV7zpL0uWafY200=
X-Received: by 2002:a2e:6a14:0:b0:2ec:22a7:2b3c with SMTP id
 38308e7fff4ca-2ec3cea485dmr28345401fa.11.1718822693156; Wed, 19 Jun 2024
 11:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-5-pierre-eric.pelloux-prayer@amd.com>
 <CAAxE2A6sQrU94uisM00kZs=P2pguTcQJjEtUX_Gum_vPjZ2J+g@mail.gmail.com>
 <bbe4d387-ca6a-44a5-a143-dae794d23312@amd.com>
In-Reply-To: <bbe4d387-ca6a-44a5-a143-dae794d23312@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 19 Jun 2024 14:44:17 -0400
Message-ID: <CAAxE2A5CNoErNMU_qOS+OK7yGSoMUGwpLL2kRVF_bAqnyhj4Lg@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: add AMDGPU_INFO_GB_ADDR_CONFIG query
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

The INFO ioctl was designed to allow increasing the sizes of all info
structures. GB_ADDR_CONFIG isn't that special to justify a separate
query.

Marek

On Wed, Jun 19, 2024 at 5:31=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> I would try to avoid that.
>
> Putting everything into amdgpu_info_device was a mistake only done
> because people assumed that IOCTLs on Linux are to expensive to query
> all information separately.
>
> We should rather have distinct IOCTLs for each value because that is way
> more flexible and we won't find later that we have to deprecate fields
> and work around issues because of legacy hw.
>
> Regards,
> Christian.
>
> Am 19.06.24 um 02:34 schrieb Marek Ol=C5=A1=C3=A1k:
> > I would put this into drm_amdgpu_info_device. That structure can grow i=
n size.
> >
> > Marek
> >
> > On Tue, Jun 18, 2024 at 11:30=E2=80=AFAM Pierre-Eric Pelloux-Prayer
> > <pierre-eric.pelloux-prayer@amd.com> wrote:
> >> libdrm_amdgpu uses AMDGPU_INFO_READ_MMR_REG to fill the dev->info.gb_a=
ddr_cfg
> >> value.
> >> Since this value is already known by the kernel, this commit implement=
s a new
> >> query to return it.
> >>
> >> The libdrm MR to use this query is:
> >>     https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/368
> >>
> >> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@=
amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
> >>   include/uapi/drm/amdgpu_drm.h           | 2 ++
> >>   3 files changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index f51f121d804e..403add7f05af 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -117,9 +117,10 @@
> >>    * - 3.56.0 - Update IB start address and size alignment for decode =
and encode
> >>    * - 3.57.0 - Compute tunneling on GFX10+
> >>    * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF=
 & AMDGPU_IDS_FLAGS_MODE_PT
> >> + * - 3.59.0 - Add AMDGPU_INFO_GB_ADDR_CONFIG support
> >>    */
> >>   #define KMS_DRIVER_MAJOR       3
> >> -#define KMS_DRIVER_MINOR       58
> >> +#define KMS_DRIVER_MINOR       59
> >>   #define KMS_DRIVER_PATCHLEVEL  0
> >>
> >>   /*
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c
> >> index b32ff6e1baaf..dbb05d51682b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -1256,6 +1256,10 @@ static int amdgpu_info(struct drm_device *dev, =
void *data, struct drm_file *filp
> >>                  return copy_to_user(out, &gpuvm_fault,
> >>                                      min((size_t)size, sizeof(gpuvm_fa=
ult))) ? -EFAULT : 0;
> >>          }
> >> +       case AMDGPU_INFO_GB_ADDR_CONFIG: {
> >> +               ui32 =3D adev->gfx.config.gb_addr_config;
> >> +               return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAU=
LT : 0;
> >> +       }
> >>          default:
> >>                  DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> >>                  return -EINVAL;
> >> @@ -1310,6 +1314,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >>          case AMDGPU_INFO_VIDEO_CAPS:
> >>          case AMDGPU_INFO_MAX_IBS:
> >>          case AMDGPU_INFO_GPUVM_FAULT:
> >> +       case AMDGPU_INFO_GB_ADDR_CONFIG:
> >>                  need_runtime_pm =3D false;
> >>                  break;
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h
> >> index 3e488b0119eb..680492cd73d8 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -933,6 +933,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >>   #define AMDGPU_INFO_MAX_IBS                    0x22
> >>   /* query last page fault info */
> >>   #define AMDGPU_INFO_GPUVM_FAULT                        0x23
> >> +/* Query GB_ADDR_CONFIG */
> >> +#define AMDGPU_INFO_GB_ADDR_CONFIG             0x24
> >>
> >>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
> >>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> >> --
> >> 2.40.1
> >>
>
