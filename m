Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C073E9B269
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 14:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04D910E58E;
	Tue, 24 Feb 2026 14:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7/ZQEph";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E8710E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 14:17:10 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1275750cfadso354304c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 06:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771942630; cv=none;
 d=google.com; s=arc-20240605;
 b=LBtze9vFdr7DpCeJUKfCCI7nkMDCowpMPS+cbTe61U521D/J4eP6/DuSi1ZNbakB4D
 tokWKAacrCbtmL2cuIqMHo73T6Z1qTo7CrpH5T1aXTqZ6RgrXEANgMJ3UfhyX6hYCjrr
 Kwl714/JwGofDi/PTwiPT9Z6a6jkxav+ABgr/4oaP+/nn/KprWTeCvnlEoJZZCE0KiMq
 E3XxhAmNM7GGs/GmTvmShMgnqh9r94emq4WvO+BJ9UYDVPO5PqZv3JNePrPWN8QfxlvF
 fLRsY/zaD65kEj0S+PBcRdB4101LelaXo5Am6kT6rgoJUdeXf4m9/Cd1Z2cfZN5uasx8
 SJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/FkHItMggKyR642C3LmNyO8TwuOKHlw446oe40DvbVY=;
 fh=+TIUOhQe0qggj9A/Xr24nJtkhMNi2/748vFAEZMc/HQ=;
 b=NhF7jgLadTEnzFmQayWHJ1tLzBC/1mALlYL68nDxPUGpAEzxmsMdl56tuuLLmt4KRR
 3zF9aztHL+dIl0EXCYp00MqxtCEd7+tODLqztGIdY9NzKcuXGEtq97kis+agb1pdIO11
 gzBvFtLxEoAK71uMfdnvW03Tfoq4LuDFkydz2UfqwNmXssOT/mAlFL1bqR56sRMbs6dS
 K/lTuqATccFnv8kLzhX3iPfesi8QY6v1kqq91jMLMFWTQx3xg/B1IBXIseHgRpdzQmMe
 x4nYWzK3+c/cnGfkJGemBThJb1kuUlrLPq1XTubhkIxmQ7rDoalgwbDtdzu98eo92ENJ
 pQ1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771942630; x=1772547430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FkHItMggKyR642C3LmNyO8TwuOKHlw446oe40DvbVY=;
 b=C7/ZQEph4/maaS+PEcmivafTST34vhJr76NSxBrVJkAehs0X4GTNj/I0sCQnDH2Elh
 id1hGVGCWDTV7GzevAA3Gw6iSgcO0iipcVnoXEE1ZcASvWxhcDrTcWTp2xxqVdn//N+c
 Gd63jtmCIQmxUxD1zw4G1pnIxEczfAAbe87DL9wzUwrsEjIM5Jvhu/Ah6Ba477GhV4D6
 iOYUlrsa6+7VUyYZoBf6L+79K+qfqmWq85Ssw/rOA57184Sek87eRDA3jKrOPp04eeWO
 9YuHi/gRBiO3crsc+udw4Mv4pf7tiPwFHikSoz6/howKe8AAwQHFmCmqBXRxQ4rvq4D6
 8JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771942630; x=1772547430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/FkHItMggKyR642C3LmNyO8TwuOKHlw446oe40DvbVY=;
 b=puf+jbB7TEHBWtFdkbJob8Da/0MAhmRmE43gsfKrOfxpWSLcpmST5SqZJ8cBTtxRzL
 fgizx2Okes7gra6IH/786Di8meEGau5TjluzsfVvDXiSnRsKj28ApR0X0vC6gkoL5Lay
 vLzHIvhiLE9BC2CR6Le7kNNiblJrBTyUQuzoaJ3uiliD1IRm1BZXEdh6RSQCUgcGs6SU
 P6DqU7hXaTBFYQDVC0aI1jaWvdF03rwDZe1VpZt3hPOVHo8SgDDSp5jpiRSfYhJL+m5I
 VHYACQKFPOoelD6ycCfTHOEp21LgF/EE//0BKjj6mGSkTCG4Mhv3vHKWwfNFt6ZLmzYa
 4qpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRp3oEkc3u5baoN1p9IckEUzcc0vq+NMXumR/hDcfuZ8l6d1Rz4wHZqVppPE1QSO5gzqZHcpy2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzddunSguiSfl2/dqakbFWPIiYSvYAyzzwxo+JN22ZNKmwYiCWR
 j7ZGOuelBfpTr6k8FKBIZy78J0hEd7scAv9qYQBa5PpzGlllU0Y0ay+LPeezqi+UqQzc8iGKOEk
 Ehp02vslc6057s1MO3IFlkSCIfxpSV6ZV5A==
X-Gm-Gg: AZuq6aKiREIdmFoeTImb2vhUnYpnSd7Q7LZoVpzAJ7PBRgqdKxFY57rhOISSNCKtJ90
 wiPjIDdShzEGXYKP552qp75m8GEqhSGYC1Aat9eoIKlisQTmg6/3UhrT6NahKgKyLL4Bj1jmKtz
 Q8dzoqAhhFId1VDYFAbNJpCChjjCvacXJce57dM/Fd26hGZXrpjsK6Sr8bC3jcrfJi1y+cVXNWB
 6VQWQCQ1tuQXiNTxzKqyuoCLK3Q2dCAbe0yjiU9VBqF6zo0yAmhk3IrRLEHJybHC5nXERQ8Wokz
 JGjlP9PfBfX9MLjWzV4h5NXFKDZzRqLq2LtUkk06/9i184uDmig77rLWQTPBXxHZfBvJXQ==
X-Received: by 2002:a05:7022:f005:b0:11a:43fb:58dd with SMTP id
 a92af1059eb24-1276ad3bcd8mr2466034c88.5.1771942629746; Tue, 24 Feb 2026
 06:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20260224091118.4017760-1-sunil.khatri@amd.com>
 <20260224091118.4017760-2-sunil.khatri@amd.com>
 <062ce56e-5d80-47c6-88e7-c45f5f72dec9@amd.com>
 <3dbe7fa7-e498-4cab-8b96-2cee679e0eb5@amd.com>
 <ba10fefc-e5c9-4b09-80f9-e73211031c11@amd.com>
In-Reply-To: <ba10fefc-e5c9-4b09-80f9-e73211031c11@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Feb 2026 09:16:58 -0500
X-Gm-Features: AaiRm505Cr79o9PFePTJpJlyrHXvgQtXMjf01Mi_up3XqW3kDE2vONVapW8STcM
Message-ID: <CADnq5_OLqfyMbY0x1d1fWbpLyvF9818MnZLEjE0tLZFo9FBcmg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 24, 2026 at 8:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 2/24/26 13:50, Khatri, Sunil wrote:
> >
> > On 24-02-2026 02:58 pm, Christian K=C3=B6nig wrote:
> >> On 2/24/26 10:11, Sunil Khatri wrote:
> >>> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
> >>> remain uninitialized and during free cause a fault. So to handle such
> >>> cases we better set the gobj_read and gobj_write to NULL.
> >> Yeah that still doesn't looks like a good idea to me.
> >>
> >> We intentionally avoid nationalizations like that if they aren't neces=
sary because that allows the compiler to complain about it.
> >>
> >> Christian.
> > Sure Christian.
> > @Alex, can you pull in the drm-misc-next to have the fixes in ASDN, or =
if it is supposed to take some time then in that case i think we need to pu=
sh the change no 1 and 2 to ASDN as signal/wait IOCTL are broken right now.
>
> We just need the ack from Alex to cherry pick the patch from Srini over t=
o ASDN. Should be able to do this by tomorrow.

Sure go ahead and cherry-pick what you need.  That said, I think this
patch is fine on its own as well:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Regards,
> Christian.
>
> >
> > Regards
> > Sunil Khatri
> >>
> >>> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in=
 amdgpu_userq_signal_ioctl")
> >>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>> index 18e77b61b201..e53e14e3bf2d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *=
dev, void *data,
> >>>       const unsigned int num_read_bo_handles =3D args->num_bo_read_ha=
ndles;
> >>>       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> >>>       struct amdgpu_userq_mgr *userq_mgr =3D &fpriv->userq_mgr;
> >>> -    struct drm_gem_object **gobj_write, **gobj_read;
> >>> +    struct drm_gem_object **gobj_write =3D NULL, **gobj_read =3D NUL=
L;
> >>>       u32 *syncobj_handles, num_syncobj_handles;
> >>>       struct amdgpu_userq_fence *userq_fence;
> >>>       struct amdgpu_usermode_queue *queue;
>
