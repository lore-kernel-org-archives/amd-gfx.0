Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9E8CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 18:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A8A10E31C;
	Tue,  4 Nov 2025 18:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MH+3pTLs";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC3110E31C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 18:56:32 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-78283098d7dso288492b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762282592; x=1762887392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h15GH+PZbI8FGXRVHQrxN+kup9jSFhdmvc42RT1LTQ=;
 b=MH+3pTLsVZmKiXCVTqvvZisnlCgWRRGcscvmHdIrzcK802v9cJFRhFwYAGoNhb73a1
 mFVVksGLT/G8gnY3ItwpCGa8YTGVw2WrrLYwZq+SrQQWedv9fgjMF2vdLzvAUG/9pUqe
 mplE7fjH/7pNgHiZDZEEmfVcuOxEv4VmxA7U9U8XzBr4o/QDOlBwGlLyHI3WKNRz4cm6
 FMAx4U5DUwNFJvWHI1NYnglvZFlzvG+4yJ1eWXyO/PxTjroiGIPGwAqARbQGNjJnQELR
 crfred9cEkWjxglBzBLGm6UA8Ai6UQoiw7H4GJ5WC+OY2e4ve9l9JEBAowKMy+vvK6xD
 jGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762282592; x=1762887392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h15GH+PZbI8FGXRVHQrxN+kup9jSFhdmvc42RT1LTQ=;
 b=HB7uE0K/tz1VoE4pfC8t8Y65l+fEXY0gkq6hUZnDx9nelU1WvIboUNLjLZTWd29qJm
 EyoUOK3NtM0CGqY/QiocjLucb8v352cduQ1eRbdpS1w3Q1wWUAQl1XX0gJLFCO1AyVKM
 QmmFbWAr6NzgHbKX4A7DmUBplbbZUY0dRDZ39jCbuWkHSFbuAwuqXk+ok+0nG3oSa36Z
 pCgoEGeTkJsWe6k2sj3by18QRfac/dn2Z3i8n2GsgqSyjqokY0vAPDVAffjkE/WpF5fQ
 FaZ0VKv2HtaiP2cVzuTJj0jGTeJBSLtRPMatM4mhRjW8Drma7swqhYIJ/pZdXcxZsCOQ
 vEJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9EarcvFy0oy1XIwVcX7VfCUIUO7Xn4A63ytZmgYP/GbBeH7OsNezcu7dXtxpL6KpTvDR3tbAu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZZzHRZwMBg4RmHxWUWP2jFeSsKggOaePQj0ZqxVhuNzrZwpAG
 TCdnK3XTOHa/G3Ec0drG27MN5XliGLPO+kkaaXlKV+z6z5QlzPgNis785rNQe6mb3VLX3UUJahD
 N+nF4WS0KVi7h+iKHT7M2f9GV/KwHPuQ=
X-Gm-Gg: ASbGncsm+JVZC63vmn+kfsssUgJ6EyKURDA4j2ZNaRG/QjIrw6+wMyq4UaHrbjbG4gl
 gXlqtxelYP7+HYu9TfiQaizl7kE7hx23AmoJkImrGLql1RtO++OXgujD8nQa4IHzv1V11l2yI81
 bUMQKTWJoO8eooO747eLFrdrk/KNWORXpTWlcFQC763J1xOuot5v16ISGzG38lKuLoeXS6ezC2y
 YiIr/m2OTG0i4BB1B3c3pdTmTDDH3mhAKdyvs6SKhM9y56yz4/Cyb+MULtfa4vUEcz7AzM=
X-Google-Smtp-Source: AGHT+IFk5fK8hIt6Xy8FXscZcMfT2UwelwFr9GsKlUzVtoktNU/BNI519gk6H/OnZ+vwCHGgRqrSf8KQRze6Uu+fafo=
X-Received: by 2002:a05:6a20:12c3:b0:342:8c38:ed0 with SMTP id
 adf61e73a8af0-34f87106a7cmr168137637.8.1762282591604; Tue, 04 Nov 2025
 10:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20251104163932.263193-1-David.Wu3@amd.com>
 <20251104163932.263193-2-David.Wu3@amd.com>
 <CADnq5_O2pf8w8NbK8QEhPDtFgqrhXsGPv4U_i-+Ov4UzLLUb9Q@mail.gmail.com>
 <d7569ba6-a915-45fb-b025-e9ab1047c616@amd.com>
In-Reply-To: <d7569ba6-a915-45fb-b025-e9ab1047c616@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 13:56:20 -0500
X-Gm-Features: AWmQ_bkxcJb42ROTIIAXcU0B85qhiEQMq2jhH8tqxVIstEAk_LTPBZkd1jwXQ0Q
Message-ID: <CADnq5_NLi7Xyb=dTyNRSA0pVfN+Bdkx4LopHLebieNiXfem-bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: need to unref bo
To: David Wu <davidwu2@amd.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, alexander.deucher@amd.com
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

On Tue, Nov 4, 2025 at 1:52=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-11-04 12:06, Alex Deucher wrote:
> > On Tue, Nov 4, 2025 at 11:46=E2=80=AFAM David (Ming Qiang) Wu <David.Wu=
3@amd.com> wrote:
> >> unref bo after amdgpu_bo_unreserve() failure as it has
> >> called amdgpu_bo_ref() already
> > The other error paths need to be fixed as well.
>
> hmm... do you mean "map_error"? it has the amdgpu_bo_unref() already.

whoops, yes, sorry.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> David
>
> > Alex
> >
> >> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> index 2aeeaa954882..99ae1d19b751 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> @@ -386,6 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amd=
gpu_usermode_queue *queue,
> >>          amdgpu_bo_unreserve(queue->vm->root.bo);
> >>          r =3D amdgpu_bo_reserve(bo, true);
> >>          if (r) {
> >> +               amdgpu_bo_unref(&bo);
> >>                  DRM_ERROR("Failed to reserve userqueue wptr bo");
> >>                  return r;
> >>          }
> >> --
> >> 2.43.0
> >>
