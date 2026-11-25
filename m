Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05842606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRuSW4Hv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7201710E907;
	Wed, 25 Nov 2026 14:55:38 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B918810E232
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:55:31 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-86320a60314so878788a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795618531; cv=none;
 d=google.com; s=arc-20260327;
 b=ld5adC+bysyvipIuXwv42IVXwx9EIJi7j7yhuA1L8xG0rTMOvt4BirLR+UzXCdulSG
 jtEPQzYn/gNVsJQ758N5AGZcHXr92F85ekXxkkIgG8Z6L4i7hn0SknH24VbDXcsUl1Xm
 JuXlirKprfUV1YYbOTmH3OZgsld2RTZD1ct1b7Ig/LqP7OfxP19UFNYybxQBebDEJ2Ux
 Eps5zKXM0pIxwzpKxRYtPH/OCsq1/pxxJemkp+MpB9aNawYfhWvKwv1mXcwFtfM5DpUz
 mUn+8Z6ygV0XGefRNWFsaQ32FDt9McQ+5VYZ952b4UEleAlwwNWqdb6D3H8LppCoismq
 8oNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+NUosclT417FAnOVBoRVSBiDqyFvuO/Iw3sn3ygAwv8=;
 fh=UL6y2wPUyLQAM1rrUScIR7ov5kMb+DJ/dH8vmi3esx4=;
 b=TzNeKj8AwIv2AjszkhiX6sh/KLaf7GQ67G17hRuWbqZIClESYsjGU0mNxvA6TLkcxB
 vHem5lFtlhYJ4v30z2FhyaVwBYiUilJlEmc6pZU7po5IhuW9zBNoSEpQ1GRSMZ8E5M4O
 RxUtIdF+yZAzUbvUD7aUFZUWdhQRl7e+h+unbb5atym6Rq0bZGE/x4YiaGwd0PW/kqlF
 H0MuRHyp1Q5Vv+C79OQ3JUPpOOiiXjuedrl0n1cbehDMTXAwwr37sI7vaV+nmg4Cvrie
 EWS73TyxPwt+uumTOgwSDvocV5cIc1IHK7PTXYJZEYiFUJ0aO9OiBKidvyZrbC1e5NYg
 wJrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795618531; x=1796223331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+NUosclT417FAnOVBoRVSBiDqyFvuO/Iw3sn3ygAwv8=;
 b=gRuSW4HvJGDVbCG29sluCGPBUsdA3OX8CS0liCbAhHE/Lir2qbkUrUsd+CRdDcxS5Y
 ELCgKIDHx+xllBsEeYsHQ6DA735npT2o2pEgFHh9LK276wA4otYHQYtuyvAeNXwdDGpA
 fold89B9bbCG0L9daRWOoA2pFj+K+e7uW9evvDyrx9syKRhfePYZERjdsCIrag4knNxJ
 QdUQJ7dprWDe4X3DA2WCZI4dijidLfGjJv+ZScLRKCz67Gsle2OOmLE34DtYQBC2MZzG
 2hMs6wY6uac/tR6edQlhY5IkTCOCPRkOJk7Jk8O0gPPeKOAsTNV4a+GxdEt0DA4EEn3k
 kYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795618531; x=1796223331;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+NUosclT417FAnOVBoRVSBiDqyFvuO/Iw3sn3ygAwv8=;
 b=Ey/t+bhWqWAtF4dSe65Ayvy74VmXpEa3ucCNV4zlVnXl3MsK8zKaxfvakVOSWkQUcA
 wdEFgjsTx7tWynqimD4EXwEEq+VdfvsJI1BjCcg7a3SSm063YkLvr6DGiIA6Y5uYtHu0
 ggV/PHJXzYuQreKuCkNQYN03tFBeVwN1Mh/ML43xKJ1jr0bWUzFM5unlrtst4HByQy0S
 VPP+rb7E6PjX7h+8VLAUqKjwGuoaivkAb8gyPp9IvKs6iEvsB75NK1AAOrjneHx+FZzH
 6Elt0S3YmzoQ8LVFVoOg20E8JskuoaK+PnA5Xq4MWuprKVDRxY1mLkvhktkT1OhCUdh9
 QC7A==
X-Gm-Message-State: APuU4Z89wkBebTq+MnsgQ5HCbOFpRlA6eHvBGQYffzQA9AC7RY4AFssJ
 GU5mPJLx2LAqeAfzbclKL73m14Zl9TZu7/ZSiKUQod1AzBvsippNqSSBow2RbT74sLFFfjbsrkk
 hy6t5aGeUlLl/cvAjBltrU4DOTA5iXrA=
X-Gm-Gg: AZFdTZfZety8LMpmr1yi/XkZarYLHzqrTtAcVjjLFrKc9MexGnDxZ7/edS967alqHmT
 YOxSDpb/n/uWJSS/lVno5rnIGf0AJNj3Vm5lf1XDKAqnKvf5/wwA4KWtV3AxeC8SSiKDs0Asndi
 vkYomHzDJ+CY1e8mPeT+IvyU3EPQ/YlbhNVeiEijDL8c2tiW7RFYWRQ1cEfGuoRcz9kP5NP4bhy
 gf2WTf4jEFx4rbej1eZkAiul7v4C9SVdCF9ajxOiIDHaUIdN1LIj1PLvKXkpCXBRsb7un/K3Hld
 fRsGwTzw/qGwQeER5hb7I/h7XyptOBFxIpvlXp6nncCLYMzxUYWuavgYzROMakfRdgxq2rkToci
 KB9adW5Mb1m3y3fSsjvfGBUSEBKd+qktb1VluxUR7L5cZc+diKhzcUXR89NdPGrrifgmdY18rC0
 Io6R/7aP4lTZ9ZRqbCyRrKD7AxBkIxf2N/N31dIRJsYh/BEWAyGZsRDNY/L5I=
X-Received: by 2002:a05:6820:3504:20b0:71a:fbe0:a6d4 with SMTP id
 006d021491bc7-71b39325f06mr16908872eaf.1.1795618530701; Wed, 25 Nov 2026
 06:55:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
 <20260911154212.591213-8-shahyan.soltani@amd.com>
 <CADnq5_MwSF626Ji96+3Gkerr8A_OsXAW1BmFh5tciEmo7xLGdg@mail.gmail.com>
 <a66396f3-1f40-468f-8760-2813734342bd@amd.com>
In-Reply-To: <a66396f3-1f40-468f-8760-2813734342bd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Nov 2026 09:55:19 -0500
X-Gm-Features: Aa3M54rYwbBbXqT8veXzPU2WihQmONK8Zc8hGHgHVNGIs8hWetd8oAzuPZ6Nkew
Message-ID: <CADnq5_OAr6_qqDfqS5nbX_pt46qSQJT29puraQFkD-DhPfGKCg@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amdgpu: get rid of amdgpu_drm_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 9:50=E2=80=AFAM Shahyan Soltani <shahyan.soltani@am=
d.com> wrote:
>
> On 11/20/26 5:21 PM, Alex Deucher wrote:
> > On Fri, Sep 11, 2026 at 12:01=E2=80=AFPM Shahyan Soltani
> > <shahyan.soltani@amd.com> wrote:
> >>
> >> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >>
> >> Remove the entire amdgpu_drm_ioctl handler system in favor of drm_ioct=
l.
> >>
> >> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@=
amd.com>
> >> [shahyan.soltani@amd.com: Added commit description]
> >> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/Makefile       |  1 -
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 23 +-----------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h   |  6 ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 45 ---------------------=
--
> >>   4 files changed, 2 insertions(+), 73 deletions(-)
> >>   delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd=
/amdgpu/Makefile
> >> index 7b08814a24da..d5ddf236a6f9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >> @@ -321,7 +321,6 @@ include $(FULL_AMD_PATH)/acp/Makefile
> >>   amdgpu-y +=3D $(AMD_ACP_FILES)
> >>   endif
> >>
> >> -amdgpu-$(CONFIG_COMPAT) +=3D amdgpu_ioc32.o
> >>   amdgpu-$(CONFIG_VGA_SWITCHEROO) +=3D amdgpu_atpx_handler.o
> >>   amdgpu-$(CONFIG_ACPI) +=3D amdgpu_acpi.o
> >>   amdgpu-$(CONFIG_HMM_MIRROR) +=3D amdgpu_hmm.o
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index 9c5e93cd3ee6..f51f03ae5241 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -3019,25 +3019,6 @@ static int amdgpu_drm_release(struct inode *ino=
de, struct file *filp)
> >>          return drm_release(inode, filp);
> >>   }
> >>
> >> -long amdgpu_drm_ioctl(struct file *filp,
> >> -                     unsigned int cmd, unsigned long arg)
> >> -{
> >> -       struct drm_file *file_priv =3D filp->private_data;
> >> -       struct drm_device *dev;
> >> -       long ret;
> >> -
> >> -       dev =3D file_priv->minor->dev;
> >> -       ret =3D pm_runtime_get_sync(dev->dev);
> >> -       if (ret < 0)
> >> -               goto out;
> >> -
> >> -       ret =3D drm_ioctl(filp, cmd, arg);
> >> -
> >> -out:
> >> -       pm_runtime_put_autosuspend(dev->dev);
> >> -       return ret;
> >> -}
> >
> > Thinking about this a bit more, what happens when KMS IOCTLs get
> > called (e.g., modeset, display detect, etc.)?  Will they properly
> > power up the GPU?  I suspect you will either need to properly add ref
> > counting to the KMS entry points in the display code, or you need to
> > resurrect this specifically for the KMS IOCTLs.
> >
> > Alex
> >
>
> Hi Alex, thanks for your input. I've looked into it and from what I've
> seen you brought up a really good point, but I'm not entirely sure how
> to proceed.
>
> The problem is if I try runtime resuming the GPU on the KMS entry points
> for the IOCTLs, it interferes with other processes that call that same
> entry point without an ioctl path, typically with their own pre-existing
> rpm handling. For instance, A lot of the MODE SET ioctls such as
> DRM_IOCTL_MODE_SETGAMMA, rely solely on the .atomic_commit hook to
> communicate with the amdgpu_dm driver. A wrapper here within the
> atomic_commit hook (.atomic_commit =3D amdgpu_wrapper_resume_example) to
> resume the GPU would be a possible implementation method from what I can
> tell. However, within a different non-ioctl pathway, more specifically
> the suspend/resume IP block one, dm_suspend/dm_resume also calls the
> .atomic_commit hook which triggers a deadlock as the new wrapper tries
> resuming the GPU while it is already suspending within the same process.
>
> On the other hand I could resuscitate the amdgpu_drm_ioctl driver like
> you mentioned but from what I can tell a list of "kms_ioctls" would have
> to be maintained and updated whenever a change is brought up. Which
> probably isn't the best idea in the long run.

I think the best approach is to resuscitate the amdgpu_drm_ioctl
wrapper and just skip runtime pm handling on all of the IOCTLs which
we know are handled correctly.  So that would be the AMD specific ones
and any drm IOCTLs which we know don't require hw access.  That way
any new IOCTLs will automatically wake the GPU and then we can add
them to the safe list later if they don't actually need hw access.

Alex


>
> In anycase if you have any input on the matter it would be very much
> appreciated.
>
> Thanks,
> Shahyan
>
> >> -
> >>   static const struct dev_pm_ops amdgpu_pm_ops =3D {
> >>          .prepare =3D pm_sleep_ptr(amdgpu_pmops_prepare),
> >>          .complete =3D pm_sleep_ptr(amdgpu_pmops_complete),
> >> @@ -3070,12 +3051,12 @@ static const struct file_operations amdgpu_dri=
ver_kms_fops =3D {
> >>          .open =3D drm_open,
> >>          .flush =3D amdgpu_flush,
> >>          .release =3D amdgpu_drm_release,
> >> -       .unlocked_ioctl =3D amdgpu_drm_ioctl,
> >> +       .unlocked_ioctl =3D drm_ioctl,
> >>          .mmap =3D drm_gem_mmap,
> >>          .poll =3D drm_poll,
> >>          .read =3D drm_read,
> >>   #ifdef CONFIG_COMPAT
> >> -       .compat_ioctl =3D amdgpu_kms_compat_ioctl,
> >> +       .compat_ioctl =3D drm_compat_ioctl,
> >>   #endif
> >>   #ifdef CONFIG_PROC_FS
> >>          .show_fdinfo =3D drm_show_fdinfo,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.h
> >> index 2d86cc6f7f4d..6b06c0956e48 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> >> @@ -43,10 +43,4 @@
> >>
> >>   extern const struct drm_driver amdgpu_partition_driver;
> >>
> >> -long amdgpu_drm_ioctl(struct file *filp,
> >> -                     unsigned int cmd, unsigned long arg);
> >> -
> >> -long amdgpu_kms_compat_ioctl(struct file *filp,
> >> -                            unsigned int cmd, unsigned long arg);
> >> -
> >>   #endif
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ioc32.c
> >> deleted file mode 100644
> >> index a1cbd7c3deb2..000000000000
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> >> +++ /dev/null
> >> @@ -1,45 +0,0 @@
> >> -/*
> >> - * \file amdgpu_ioc32.c
> >> - *
> >> - * 32-bit ioctl compatibility routines for the AMDGPU DRM.
> >> - *
> >> - * \author Paul Mackerras <paulus@samba.org>
> >> - *
> >> - * Copyright (C) Paul Mackerras 2005
> >> - * All Rights Reserved.
> >> - *
> >> - * Permission is hereby granted, free of charge, to any person obtain=
ing a
> >> - * copy of this software and associated documentation files (the "Sof=
tware"),
> >> - * to deal in the Software without restriction, including without lim=
itation
> >> - * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,
> >> - * and/or sell copies of the Software, and to permit persons to whom =
the
> >> - * Software is furnished to do so, subject to the following condition=
s:
> >> - *
> >> - * The above copyright notice and this permission notice (including t=
he next
> >> - * paragraph) shall be included in all copies or substantial portions=
 of the
> >> - * Software.
> >> - *
> >> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
> >> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> >> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=
 SHALL
> >> - * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >> - * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> >> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS
> >> - * IN THE SOFTWARE.
> >> - */
> >> -#include <linux/compat.h>
> >> -
> >> -#include <drm/amdgpu_drm.h>
> >> -#include <drm/drm_ioctl.h>
> >> -
> >> -#include "amdgpu_drv.h"
> >> -
> >> -long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, uns=
igned long arg)
> >> -{
> >> -       unsigned int nr =3D DRM_IOCTL_NR(cmd);
> >> -
> >> -       if (nr < DRM_COMMAND_BASE)
> >> -               return drm_compat_ioctl(filp, cmd, arg);
> >> -
> >> -       return amdgpu_drm_ioctl(filp, cmd, arg);
> >> -}
> >> --
> >> 2.55.0
> >>
>
