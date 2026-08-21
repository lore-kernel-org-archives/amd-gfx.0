Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4232DC5DF87
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 13:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCCF10E296;
	Fri, 21 Aug 2026 13:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOI4vWVU";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A9F10E296
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 13:06:17 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cad68425a7so1147515ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 06:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787317577; cv=none;
 d=google.com; s=arc-20260327;
 b=jqfIjXXDlvhcT7E6v6/eHUJABO27vgktCmPvqf3b4XGfdA9AqK0U1w8UkELaU+UMXJ
 JrR/F7pnLGpQX6aalRr2U0qlAXzawTzXLTPqlTbbzj/JMauOjhqX9NjJX087AN8PSwzF
 jRyWP22SK/x4h1SC7LduE39eyPwalWOxNGtfBGmba9TOYuNPYpGVxHGRDm98iAWRqnH1
 Of2Xm3eC9oOGkJ7KMq+eUesBCBaF65PcXRpbaJTxIxZ3A7jIt4rjF1nZ6LVZT7/YrrB4
 LMkrbiteUwafpWX6Umw3utjIPHy2TIB/ZYW1c2CcZUxNcM8YawQQgl8lG2z6bFweS+ZA
 AiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e8+kapFIItIBccHIUABZT6ooH4/t0R4ERogEa828JkQ=;
 fh=ZJbcsAdpuhkrrEf4MwTFv+CnmlAzlIjOhzSx7/Tzg70=;
 b=FiopFkgjQ2KXlWshe4q6u0XjGYtgtbV+53NftWzbiss7ZOGI7J9oVPAkTRLFEUNb1h
 Lz5CKtg2irvWtyTrotmHUqYr3T+KUsdjH20GECMjGRvWuR47s49x1CF3S7ssSDZEPG69
 bbRbsT1LDHQdR3+qE0yxLeoSifAenGJcbgCoYebWhPi66HWfshFiEkSOzfjh46iYsLUX
 AN4cn/1KCtRMmoJQ51yJ7d655YskxIGUvPsgNciTnWEHx9zhgR836Svh7l4XrCug9Q5P
 R6eXLjAKeiq1Iuh2DAyRvBz/w1KLPoO2ef5kR0DFJ1gPmhKAH8CRRcv0XeGwexBtyiLg
 HJ4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787317577; x=1787922377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e8+kapFIItIBccHIUABZT6ooH4/t0R4ERogEa828JkQ=;
 b=IOI4vWVU8xYjCFzqV2yvROWErzlHgWDDBUiUlUD/K1Z4nLgpsrw91F0Rfee9Wu2BDH
 j28H9FKPJdcaAF7KLXlllkUQcQNhS5YA+UpAMq5XI4+DtpT35waX9cDfxzwdCo/hWQNG
 ktQuQoh1EFH5Dq15o8VvqVuwWkQLJWolP9pxoHi/EaeXl1ljzbrHlzeIzsv1oJvkAlHq
 /NcNgTn8oSmbv213rY6xfAV7YP7aDc3+aRfC9iOzOvVtm4tDXBuiz5PB+ouEvGZaf8HW
 tbH5O8jo/1jziqMxJoqCuiec8tQ3WQrPerXvKWbIgYphWZ4Iae8BzITUMls5YEuxMT7M
 5FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787317577; x=1787922377;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e8+kapFIItIBccHIUABZT6ooH4/t0R4ERogEa828JkQ=;
 b=WtM4mh0mArgofnAnc7disvVYW0JQBOEjEdwrUKHiZdw6N6cgAtam8DS22JacTsKuMo
 4SpFrEvQycF/+FGX8QDIfmPS4oFOtDZkxj5WQbOkj1RjlI7iGgMTJeqCwNzX+lvTNQ8t
 e7Z032+UxHpVmbmcOP6fJpYZmOLg5LpYNIacWsdLgYNi4GPDQqRIimEcJ4xQSpqwjwWN
 AiLE348YUEOgCrLtC+7dx2kb4rYe3bQKHYe2chnoBDchMJS+0b6BQUVZp4fVJn2U00We
 bsBjjiuHYJkUR9C+qtNiS7jVKK8GsMZQ+Ew/PwWYwNq7I4CXC9NtJtRdXVkakWLaQg1G
 22SA==
X-Gm-Message-State: AFuF++nuZT4EdZzVhcqSCj4g7lIf+QLD4GjdtiyKbx8QBIjSyNHZ39sk
 z5wt716eD3oQI5mmIy1y9CsU0IZEutx/HEeAkMYW4NiU8V8KfJeQ7j0L9g8u2XW6OIhMjWV6ian
 gyW3l3TwV7UTCupiZBmNN4W01d8A7mAk=
X-Gm-Gg: AR+sD12//ep2wyQ2rlGupa77fVSxO2HMctIOUrnWbPVAolbtqyfyM6nNWDBWreLBjF+
 Xi1AZMie1gVyTmspHJeo5Z3Bqvhos8TIY75Rf2gXE/3eD+r6k+DBALJXw6CxyZxxpFdhvUzggOz
 9/fZmxdSKpUUZcIrFgOiKrYOvCVSHamM5/DLdgxKqRhAchAELMFN9+q5wd8Y0dHfVJtk0kienLN
 S5CjW8DdqyZ0bLNI0s1xSpa5yD6+EZNvAMMFzRAXJpgfWw/21Ybbq15PbqHe+9+8wD4VAv8bZMp
 UgCFClCs3cbRV1o6gODLimx7rqeey7ExvFC9nY/yRln3IMh/lMJg/6XggWyLaj8h6vJCnuMUlMI
 NZbxhRgd7E0PEW6HluDACf3/2v0xx/lA=
X-Received: by 2002:a17:902:f709:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d64b047823mr61827985ad.2.1787317576394; Fri, 21 Aug 2026
 06:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260821100906.1652542-1-xiang.liu@amd.com>
In-Reply-To: <20260821100906.1652542-1-xiang.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Aug 2026 09:06:05 -0400
X-Gm-Features: AcwNN1V5idRFAcFjl3zaiP3wFtMHjFoya3Qmdjz5zbMmMGVLvHusKnHwQyr2Vuo
Message-ID: <CADnq5_M_8azMxrWBNukehd4ytrXmM_JVN5crHq7_sTSsUSrmzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clamp the isolation index for rings outside a
 partition
To: Xiang Liu <xiang.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Christian.Koenig@amd.com
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

On Fri, Aug 21, 2026 at 6:20=E2=80=AFAM Xiang Liu <xiang.liu@amd.com> wrote=
:
>
> adev->isolation[] has one slot per partition, but a ring that is not
> assigned to one keeps AMDGPU_XCP_NO_PARTITION, which is ~0, so indexing
> the array with it is out of bounds. SDMA submissions hit this on both
> the isolation enforcement and the VM flush path and trip UBSAN.
>
> Fall back to the first slot the way the cleaner shader path already
> does, and stop taking the address before the ring type check that makes
> it relevant.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index baadb676f76b..d8d182599fc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6756,8 +6756,8 @@ struct dma_fence *amdgpu_device_enforce_isolation(s=
truct amdgpu_device *adev,
>                                                   struct amdgpu_ring *rin=
g,
>                                                   struct amdgpu_job *job)
>  {
> -       struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp=
_id];
>         struct drm_sched_fence *f =3D job->base.s_fence;
> +       struct amdgpu_isolation *isolation;
>         struct dma_fence *dep;
>         void *owner;
>         int r;
> @@ -6770,6 +6770,9 @@ struct dma_fence *amdgpu_device_enforce_isolation(s=
truct amdgpu_device *adev,
>             ring->funcs->type !=3D AMDGPU_RING_TYPE_COMPUTE)
>                 return NULL;
>
> +       isolation =3D &adev->isolation[ring->xcp_id =3D=3D AMDGPU_XCP_NO_=
PARTITION ?
> +                                    0 : ring->xcp_id];
> +
>         /*
>          * All submissions where enforce isolation is false are handled a=
s if
>          * they come from a single client. Use ~0l as the owner to distin=
ct it
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 5a6f5151c3ca..743d307c71fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -774,7 +774,9 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>                      bool *emit_gds_needed)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp=
_id];
> +       struct amdgpu_isolation *isolation =3D
> +               &adev->isolation[ring->xcp_id =3D=3D AMDGPU_XCP_NO_PARTIT=
ION ?
> +                                0 : ring->xcp_id];
>         unsigned vmhub =3D ring->vm_hub;
>         struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>         struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
> --
> 2.34.1
>
