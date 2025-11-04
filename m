Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6CECCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 17:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D73D10E64E;
	Tue,  4 Nov 2025 17:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bjZsc4B8";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E29810E64E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 17:06:54 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7aa6db9f87dso93864b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 09:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762276014; x=1762880814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPne4Gy9dadKtqgiwXNCnSXv1sPdKKm8UdPf4u98i0Q=;
 b=bjZsc4B8j8k4QLzSusRk/oBG/GG0WqGlV0x3Q2n4oMvKGMAybgKNCI+Ysp8meW1iYI
 T0s4V7Va/D7YnAakBikajjjkLOfpDpWItKvlHHOF60prIO36o6YB7D5/hJgLdUopicxA
 Qevqkh38H5xLmmGapyugB8xLLs6xFR8c5CsaOKwva+SiHVjqC6ZSnSWnx5bHUAsI2OdN
 4vwr4HbRAevMzhbSFQe4i52efmxYaCxXzyKPcZA86mKPrw6wM6C+Il9O3z198hJeqK6x
 2vgsXfSgpAmD03aJUGGCylk+skO0xEpLPh95PN98NwzzKA/1flqKSuDq/NEv8up2+q3G
 VumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762276014; x=1762880814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPne4Gy9dadKtqgiwXNCnSXv1sPdKKm8UdPf4u98i0Q=;
 b=kvn5Hn8eTRK2htB2jGUq5jEcV8/cpJ5QIScQAUW0IDfF7nUljrXrxrgI4pHwZyPy4C
 LyURPz6hLO+ro7fxnds+tr9gjKPlY5LoW2/r/79Uo2a+kgy1X/O4BnQuBY4L8gH7VAr2
 16IZFhWters8y6EXeS3jsWFNGlQrHzU8XN8zsaVtAIk9W5mTlaSGV+v3+NoGKYE2ZeLf
 bnENVaYf5i8UhOWPYqmx09i49dFIZsXbQbbXBgYWgJ+I269ApoXtjTkkEbYSS41fJXe5
 jiq6wSsxM9xgFyhS3syCYpXth4aaU3CFzK3KYWOIDl/h2A2jjZrGaX8SNi7jz00jQt66
 I1iw==
X-Gm-Message-State: AOJu0Yzvbfh/+Lixh976SNknlPi7Mbp/GevFQFlLyGpHFi9QefeHuDyy
 ryQsl0HVWGnKhVmU9Qt4Cbi2cD1aBvNTTKxsxFUPc3EGAfKyKCzj5S0s20nQukToM904aAlC3A2
 gJ7RJ6DRpOmPypemzHTQpiHPbnLMH05Y=
X-Gm-Gg: ASbGncvJ6QzCW9f1aljNo37g5pykBj9xbuZlvpHK/+nsCHcuNek3wQWGfLfBJi18meU
 XB/YD/zOwrfqeK1jRKmIivFvVdl6IUh301G9SrBl8BRw4+krqP/dJCBd4F0vvZYrqDQRpdnSO1+
 uyDX9uKJ7AhTZ4GKN4tRFlZWM6c8NQMmwQMMDM+RD1WccaUQUdu6RfY610diAV6+7ohrN5ieAgF
 QNAI/Vyd5O0K5E8XE415Lg7DyXpao/J5AHrztfotDmpW47beVoIqK0aDAA1
X-Google-Smtp-Source: AGHT+IGubWST+QLqejGUAaEx/GG467LFR1KzIJY00SPfwr2cv1ZkO+f9EbtQda46AmeNrBTH2h9nFbdrYsP6ZdzWab8=
X-Received: by 2002:a05:6a21:3947:b0:2e3:a914:aabe with SMTP id
 adf61e73a8af0-34f8431d03fmr14466637.2.1762276013578; Tue, 04 Nov 2025
 09:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20251104163932.263193-1-David.Wu3@amd.com>
 <20251104163932.263193-2-David.Wu3@amd.com>
In-Reply-To: <20251104163932.263193-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 12:06:42 -0500
X-Gm-Features: AWmQ_bmyk_mlNmJjZ6j5KMI1AeUpdRlKhxJLvfSMBH9wGr-jbVee8PQDHqGz9vQ
Message-ID: <CADnq5_O2pf8w8NbK8QEhPDtFgqrhXsGPv4U_i-+Ov4UzLLUb9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: need to unref bo
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com
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

On Tue, Nov 4, 2025 at 11:46=E2=80=AFAM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> unref bo after amdgpu_bo_unreserve() failure as it has
> called amdgpu_bo_ref() already

The other error paths need to be fixed as well.

Alex

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 2aeeaa954882..99ae1d19b751 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -386,6 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu=
_usermode_queue *queue,
>         amdgpu_bo_unreserve(queue->vm->root.bo);
>         r =3D amdgpu_bo_reserve(bo, true);
>         if (r) {
> +               amdgpu_bo_unref(&bo);
>                 DRM_ERROR("Failed to reserve userqueue wptr bo");
>                 return r;
>         }
> --
> 2.43.0
>
