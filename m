Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACADC624DA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 19:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFDC10E450;
	Thu,  3 Sep 2026 19:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lw9LzD1f";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3745F10E450
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 19:29:25 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666bed441so12842a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 12:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463765; cv=none;
 d=google.com; s=arc-20260327;
 b=GCxN0cdnVUaVF+oketR+HV72J10L2Eh2VGgBdii+GIsPMCb7Wnn42h35LzVui5+X7s
 Mzy47/3fNblyrKlEvfPlzShqa6vnE29APvrkbdBI0umVekqy8wA3t3oSQ9TyRPIgZ0MK
 QhmUvAEW06AB4eAQd3lzHNuTp6X0OEeaXbpk2hF90WEXIe6USE8W6YXDO0AQcjRlRu9a
 xvXgRXXGShhUGdCWL12Ta/MUYs3G78L/z/vEKa4pFhIhc98fyDGY7bTY+Acl/YXcICxj
 SxCqOc8WxonuOoTSoS8vU19uG3uTG4s3G5texE8J9djnqk3doWWGtqjksoJShfC8DLry
 T6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=raSNyqmGH42xK70p/Cp23NDpcRD9xOYkbEyvNol3rdU=;
 fh=nV7O7ZvrEXClH0+OVsSKlRbbPPwH9zMzJ13ak4xFzAw=;
 b=EVfeBpAi+/G4zhrUA1o6cpiuMd79KA5AhzzDjDrHzuEUIyrD5+na8UbFaYNEK5AJwm
 H+DlVrOezD6CxDYmkmtGz8Tgli64zlMnI3aR0h2DARzXYCV9TidsHAMJBAXfFkhH5d8/
 BSDMN32udyITdNjaPIhdDfmaagG5HahEGLGFxnH9j/ppggSva8mZJIHjAzF7IxG198NC
 /QUq3fKnXR1RGnJDa4eTY1yVpqGe4bDYivmuiRjpwF3NRF/dsrRmpjv39uFAcz55yzrb
 /VLLZY5AAhWbZnRj4D0JpFWOZlowA0iVdNq9OZqGOsiV91nAvHeyzqaV+D8ARaGjiBdh
 bIyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788463765; x=1789068565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=raSNyqmGH42xK70p/Cp23NDpcRD9xOYkbEyvNol3rdU=;
 b=Lw9LzD1fOIwTFkNl+g+r0z/6CzIBYFCm3QFDREHkb0wShTqK3dt+UundpQfHtU5RJk
 /i9FvWJPfJKxyJv/ZlvgQ5d5MhCdTlssH8mrUfAlrGYbY6XingKhk4AlxubBpe9mwzin
 I6Wy0DTnY1odwDccEKnrIp5vlI0t0jKbHvnbBcZ7DWnCdTwH8/sASX2XWK1iWzkSoiqW
 2JlWwab+u3Mlic9aBd7YRGFJ6Zs0+xGMSUpk1vu9O0dac29+r5zep6D0VxFg8Glz5P1P
 xmXIAcS2B6kO9pV3Sh1Y0bE9qjFF7x8r+mj1xkqVfufyCSxZzb1g4JGwNGiT1DlKtcEK
 u36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463765; x=1789068565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raSNyqmGH42xK70p/Cp23NDpcRD9xOYkbEyvNol3rdU=;
 b=oD+eJK0ZfFf8QEqNvYteT933ecyd50pp1daywl1+cLFaxyLE87kJzp6bIe5K0sxqyU
 Mj8rrtDG7kciT/xYumcjZqCtHGSJ2xzZ5qcmOaXBYJdjhcgREPFG/B4IcyjtrHdfCpek
 sHWBQU+bus4+xzycKLrFbI0PiuQ4M8BTY54lxYuUomQvCLwJE7jpOktbBTvVjFrynV04
 wC1VdqzOh0zZZQq3faPSa7GM9a+DBFdX0UkEB0hCDsDznoYaCBG8/Umjglx/pvpqUPkv
 hNP8cO11/iPuCVs7D25BqETn2ZCIDX6HJjnyZpZtGiABLhB5V991+JRMZOF426IshJvx
 orLg==
X-Gm-Message-State: AFuF++kFAGr+uOdeILnf+dveDvuaCqEh6qDi4NbvaCCgaptf2Kt+yLjR
 z4/i1lhMDA0bB65jNO1PbvKxjGKTcku+y5xw9N0v+JS1uUuWYrF1gbLB+/ZLYYwQ1tFRN+ChO1b
 0/K3QRVvaRaJhU2JlVKmwR/7MzqORJRM=
X-Gm-Gg: AYBFou0xSdrVGnQBjw3RNGCxw0Flv99Wj7n0q+US3i1hJXyuIrnPjkVmvRg9rS1duw+
 1XagfAtEMmSFHq0anqHaPEQbY8vCiVdlGixnVZJBni3sCP8nTtT+q2ncPbMCXkwnQ8TeMkp3qTJ
 kkH873gZdxe4fn5JXSG4vCczzLANoHlf8cpuIUb45LvY4LQ3GGA9hqLcEF5O547hLeo3XuD85Vn
 zYJSnA4QrDW32Oyvi8N3XSQngiP9E8PZiCa4BFEOZXECbPTv9t+EM3RHMi+P2/WFvULCMRwB9Yo
 UL+UZWmc4xAsQENuHBPfQMwkFhfJrQljhxYPwJZkO1Hjk6yvr0x5OZEUIq7DuJYJqY5k0rbthJz
 zXeNE7+lY4gl4o3ccrUPuwlHdqxfDM3uVrqN24py38w==
X-Received: by 2002:a17:90b:3bcf:b0:396:d27c:8696 with SMTP id
 98e67ed59e1d1-39b2693597emr461785a91.4.1788463764604; Thu, 03 Sep 2026
 12:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-2-Prike.Liang@amd.com>
In-Reply-To: <20260902125001.621629-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 15:29:11 -0400
X-Gm-Features: AcwNN1VTIPfnT_qSs3F66whkTUXZPe_qNF6YCGinV09maOhe_sawJRTjy6W4ECs
Message-ID: <CADnq5_NKo1Asayw4e6rbUiFhksR9D1qVL=JpdftNd-QWzBEpmQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] drm/amdgpu: clean up the userq support redundant
 check
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Sep 2, 2026 at 11:25=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> If the userq doesn't support in a system. then there's no
> valid userq_doorbell_xa entry to walk over and then has a
> no-op.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 0a816b3c5ff9..ed329041a648 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1373,15 +1373,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mg=
r *userq_mgr)
>
>  int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  {
> -       u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>         struct amdgpu_usermode_queue *queue;
>         struct amdgpu_userq_mgr *uqm;
>         unsigned long queue_id;
>         int r;
>
> -       if (!ip_mask)
> -               return 0;
> -
>         xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>                 uqm =3D queue->userq_mgr;
>                 cancel_delayed_work_sync(&uqm->resume_work);
> @@ -1398,15 +1394,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *ad=
ev)
>
>  int amdgpu_userq_resume(struct amdgpu_device *adev)
>  {
> -       u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>         struct amdgpu_usermode_queue *queue;
>         struct amdgpu_userq_mgr *uqm;
>         unsigned long queue_id;
>         int r;
>
> -       if (!ip_mask)
> -               return 0;
> -
>         xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>                 uqm =3D queue->userq_mgr;
>                 guard(mutex)(&uqm->userq_mutex);
> --
> 2.34.1
>
