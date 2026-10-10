Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE8CA9EC5
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 12:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0811A10EBE8;
	Sat, 10 Oct 2026 12:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EdY08S5P";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B367910EB69
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:55:52 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a77df9781eso2448511fa.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2026 19:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791600951; cv=none;
 d=google.com; s=arc-20260327;
 b=bMtAeOFERWU9LUIO/dFLbd7zxj9pKa+p7EjmYuoUgd9NOdssA4/c/rzknfOmxtqcV4
 v+3K5Mo4ODGXjUZugkTGRPP76SGWejWjTIxRG/mUVOYkYlLFBjv0wl9t3XrnhtuiWATK
 HEo6+ptl3PUbR0sC22th8r/gblqf9MZpeoirvSnrIRY9AGjM2f06yzROdY9WTGInzSDS
 5GIDE77oa5NLX5KGEJOauaCZKF+rkq+C2CRm0H3DMQhcvQ/tb8UxqJPJOrB5UF5mEzdP
 YTF98Ei3LCGO9W8f00WmwIml92i5BalqaP7cBI82vGSDkerfERypOaY/6jMqist/T6A4
 VMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Ed07fuWkE9fwos4AUZ3ykff2cVsq6dA1pVFJ9uVlwM=;
 fh=kjDQIiPplX7Sl0Uo8f1+mVpa/1wbk7MYghGuYGiBIJ8=;
 b=jCtlGNYUtYO61KI9uaJDRi+I++if+NrQ2ExJWGuhaeobr53UDR8l9pFFHW9mEdU3wW
 69Ev159Uy6v+13ctsAOIIXFrMDTiQUcfaA8rAF5KIBVgJBq7ra9D54nSCk2DIoMUKhXE
 d6nZqqMGGFi8FP8DeMDNnyqSTLYiqgphwuGPv8/D1B2L0+4EfyhZoMo9YKIUHqsXqk5Q
 IECh0DqZM7i5zboXUGbm4fYqbU/XqmsnPWFnJM+joByttQU+n6ablbBY8Hx/CyasEg8v
 vRD7NRQX5D+TKnWa7aBIl438RnRjXiK9kE42u1jS0Dqb/OfiI2E+qLegcd4PbYcLqymL
 MUow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791600951; x=1792205751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Ed07fuWkE9fwos4AUZ3ykff2cVsq6dA1pVFJ9uVlwM=;
 b=EdY08S5PHI7IVT+JkyVrc8GdnpDTpsjaMLGfOCFn/mQZUr8I3wx4IStPE2jQ5I6Wwg
 G4Qa9fT7YokY+KdxWLdrzYkJOeOfI0REau0YgVELa9zA+NhEDjqq1Cyk37a7dha3Ryoq
 hUSfWpVOM9KHm7MMwQs6UnSuPFVCycLyG3R9bUVReuX5lsf+WdweLkwky+NuAnYC/XQW
 Eaai++CKd5y9hvM/pnAxSTkssEXd5JvjdfcJo9tVArCka7/8c3DLZ5C2hlJPvljg/rxS
 TDx7EZWdpoe1VE1GgUiHYh2T71xswQXJkC2JNVPgVRi47H9g9tUG71V0zvd7j1d2IdQj
 8oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600951; x=1792205751;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Ed07fuWkE9fwos4AUZ3ykff2cVsq6dA1pVFJ9uVlwM=;
 b=oVEKSam20YVLxdFrAPfcJZsM/pQS1dagOrZAglxePZfH+JkVIRSmuk6SXrT4lneUWl
 NC8YtE2ynjD0WCmVaMHSpxLreZ2tFfFohbGlcZ268/8OtgJMTc9yu3MScSGjqHF474D4
 Ft1Wc0yhK/pkkldp91s9OWdsZbQla7L5Ch7SefpRRs9f8fvECIqUH7YKkcWlo2gnljxh
 FmqEdOC/7BrQcejZygMgem0td6SvtYkxMGYrSpKsXI1wwRbQLTtj6FLj4/oX6DA3v1Fj
 D7v3s3+mT9ABrs036k0YVRF4ht6jeYEPku9vdJho9/eix971fmO/+h5IepHJpgboyHel
 246Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBySaFV2wOiZ+HnsQ20ZNb9FnBD//lUTr3+zD2Zm97OZvXO0WC0/YUn7VnAMlp2i9LDlw6uKyBlh@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZFOZJokRjO+2Wv51WJPjJOpX0qp8qEC0+h19m7YPU9jJG8YHA
 TL+VRhubLaFQscHhBjR+q0dwFvY783UswMyekiMzrh6Y+j9JuxxGSxVhPiscau/NrYHzrcxc/Es
 YhZXusOhDeYvUzP5JU0TXJc7T94PahqdZezpOqmeM4Q==
X-Gm-Gg: AYBFou0+3A4QVN2SACB55DpDbs74hp+69aFcQqZ0estcV1+PkH64j0+yf2pDBCczA9q
 8FnEupuAp/RBD/87eiOVm7e/BioQBm+yw9wbB9R1RsBJQ93+blMACeuCUujk9yI/UN7TSk+Zdkp
 jLy4fxSoLCrSBZ6Od7YP8df4tNUbfqjQkTAIfRkL1Tn9QbApzJTV3r0ODX9Hsl0xdPl1p5+yzjH
 vhx+oZ4u2Lai03XnKiBpvWxQKyvt1RBNX4rjoTr1tg6XgLOZLGx+HApAOf8v1G7T5ksxeu64Hgy
 kJ62yv3ykNvud3WsEEAu0/CDRusu+OWR7kLG5FtpOXykJAfX3Gm3HDdT
X-Received: by 2002:a05:651c:198f:b0:3a9:7993:14d9 with SMTP id
 38308e7fff4ca-3a9c55db6demr8033451fa.8.1791600950465; Fri, 09 Oct 2026
 19:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
 <2bbea75d-2e3f-4a57-a291-5f5d9ca698c5@amd.com>
 <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
In-Reply-To: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sat, 10 Oct 2026 10:55:38 +0800
X-Gm-Features: AclHuK8jQu2OuoKyhFajMg-wI8QX3TxzpO-LWoyEF9m9UL71Uox_eNc24B_fdJ4
Message-ID: <CAEnQdOrvD+uju5FBcew7TPWvfcfuSOHHyxuwF3T91yHOG5GYDQ@mail.gmail.com>
Subject: Re: [PATCH] amdkfd: fix doorbell allocation race creating duplicate
 allocations
To: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 10 Oct 2026 12:37:50 +0000
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

Hi Felix,

You're right on both counts, thanks for the careful look.

v2 drops kfd->doorbell_mutex entirely and adds a per-process-device
mutex in struct kfd_process_device (initialized in
kfd_create_process_device_data()).  The device-global mutex is no
longer held across the sleeping allocations, so the existing
dqm->lock -> doorbell_mutex order on the start_cpsch() -> pm_init()
-> kq_initialize() path cannot invert, and unrelated processes no
longer serialize against each other for per-process doorbell setup.

The Fixes tag is corrected to 2105a15a2046 ("drm/amdgpu: use
doorbell mgr for kfd process doorbells").

Regards,
Henry

Kuehling, Felix <felix.kuehling@amd.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 23:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-10-09 11:00, Kuehling, Felix wrote:
> > On 2026-10-09 06:18, Henry Martin wrote:
> >> The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> >> lockless at every call site of kfd_alloc_process_doorbells():
> >> kfd_get_process_doorbells() (mmap of /dev/kfd), kfd_ioctl_create_queue=
()
> >> and the CRIU restore path each test the pointer under different
> >> locking (or none), so two racing threads can both observe NULL and
> >> each allocate a doorbell BO and bitmap, orphaning one allocation and
> >> handing the two mappings different backing pages.
> >>
> >> Move the serialization into kfd_alloc_process_doorbells() itself:
> >> take kfd->doorbell_mutex and re-check under it, so all three call
> >> sites are covered regardless of their own locking.  The existing
> >> doorbell_mutex users (kfd_get_kernel_doorbell() /
> >> kfd_release_kernel_doorbell()) only guard the device-global
> >> kfd->doorbell_bitmap in short non-sleeping sections and never call
> >> into this path, so there is no nesting.
> >>
> >> This vulnerability was discovered by Tencent CodeBuddy Security.
> >>
> >> Fixes: 428542d91772 ("drm/amd/display: Setup for
> >> mmhubbub3_warmup_mcif with big buffer")
> >> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> >
> > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> >
> > I'm applying the patch to amd-staging-drm-next.
>
> An automatic Claude review pointed out two problems with the patch. I
> agree with both:
>
> The Fixes: tag points at an unrelated drm/amd/display commit
> (428542d91772). It must be corrected =E2=80=94 2105a15a2046 ("drm/amdgpu:=
 use
> doorbell mgr for kfd process doorbells") is the commit that introduced
> the allocation being fixed.
>
> The patch holds the device-global kfd->doorbell_mutex across
> bitmap_zalloc(GFP_KERNEL) and amdgpu_bo_create_kernel(), while that same
> mutex is already acquired under dqm_lock via start_cpsch -> pm_init ->
> kq_initialize -> kfd_get_kernel_doorbell(). That is a plausible ABBA
> inversion once reclaim/TTM eviction runs the KFD eviction fence back
> into dqm_lock. Please either post lockdep (CONFIG_PROVE_LOCKING) results
> for a boot + queue-create cycle, or switch to a per-process-device lock,
> which also avoids serialising unrelated processes behind a device-wide
> mutex for per-process state.
>
> Regards,
>    Felix
>
>
> >
> > Thanks,
> >   Felix
> >
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> index fdcf7f2d1b5b4..07f881573837e 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> >> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev
> >> *kfd, struct kfd_process_device *
> >>       int r;
> >>       struct qcm_process_device *qpd =3D &pdd->qpd;
> >>
> >> +    mutex_lock(&kfd->doorbell_mutex);
> >> +
> >> +    /* Another thread may have won the check-and-allocate race */
> >> +    if (qpd->proc_doorbells) {
> >> +        mutex_unlock(&kfd->doorbell_mutex);
> >> +        return 0;
> >> +    }
> >> +
> >>       /* Allocate bitmap for dynamic doorbell allocation */
> >>       qpd->doorbell_bitmap =3D
> >> bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> >>                            GFP_KERNEL);
> >>       if (!qpd->doorbell_bitmap) {
> >>           DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> >> -        return -ENOMEM;
> >> +        r =3D -ENOMEM;
> >> +        goto unlock;
> >>       }
> >>
> >>       r =3D init_doorbell_bitmap(&pdd->qpd, kfd);
> >> @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev
> >> *kfd, struct kfd_process_device *
> >>           DRM_ERROR("Failed to allocate process doorbells\n");
> >>           goto err;
> >>       }
> >> +
> >> +    mutex_unlock(&kfd->doorbell_mutex);
> >>       return 0;
> >>
> >>   err:
> >>       bitmap_free(qpd->doorbell_bitmap);
> >>       qpd->doorbell_bitmap =3D NULL;
> >> +unlock:
> >> +    mutex_unlock(&kfd->doorbell_mutex);
> >>       return r;
> >>   }
> >>
> >> --
> >> 2.43.7
