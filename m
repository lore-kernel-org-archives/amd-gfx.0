Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEBBD44D78
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 15:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4725010E145;
	Wed,  6 Nov 2024 15:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mk9PJ5v7";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1E710E145
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 15:12:33 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7ea535890e0so955196a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2024 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730905953; x=1731510753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THzqLEWvEb/85bhWd5Dm4VO5OcBrcIT26HQoIGNyrik=;
 b=mk9PJ5v7HQtXwduuj63B+fig+Kdv0c/VPTgUeT9TX/g5lka2WzZMQAA8MsCR5oY1os
 LHWvI8IzmUkKxccvb+50ZM/LqQ/RlXwqwxVOYsk7Rhpoc8ZhB0OgGrIM6EgqqJUJpeFq
 mfGcCuXoiPf56nr4MU2Gq1ZE6AAj0jk7O6qBgP/yZZDUIQZDaJ5mO1U5kOkNx9avRCBc
 Kd1pWSLfCz1i1SGQuOhhdz0MUf96/AlBgmCTm7tp1W8zihNNZNEHxuOl1ogfpHr4FJCx
 eEj6sCx8qSKeSEjDk9/vt5oCT14S8ppB1DuUHuvHId/w9PZmDO9mLgL2Pmng9oUdgIMn
 FXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730905953; x=1731510753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THzqLEWvEb/85bhWd5Dm4VO5OcBrcIT26HQoIGNyrik=;
 b=Z/Avs7/C+usE2Dn7JBIpqelmRbQKPABgSvF3vuE6rij+H/nzFvn97xEFBlWiLfkpQV
 TcVjiL1IXpXwK/XE/luFvF4l6AA+TDD5yGUGjH5GzqRI0LUk3raqXhfVfqXyI/3VXN/q
 Y8ryRRQmz4/XPVMPPUOjHsw0L82wfBHe+UsjrSRhhuSUwnxffQu1BxYrv0hYBIki2Vma
 QGPZFhdcQm8/fdiVuLBwjJaRnZ1nT5kAClFSu70K1USR3nQi26tdzEqwU+rMIPKmHGGL
 aGCWrVbzGcGg5mlbVrgPtmldBjPVKPs9wwegSIOZv8udWLegn2S6nf713V3R/8bB32Ug
 eHPw==
X-Gm-Message-State: AOJu0Ywi4weW75pLHdB0txqZeUFbpV5/bhv8smNeQr5lVfK6765S6rl7
 qFhYBPIypGcYmmVVvHIlozZ0tZeAYJVBHKDQfKA4fpLMV1jcHDHsF/dosl9OCPnzbvFdi9t4ftJ
 QpKW1+QaF7YQNblCF/BzUM4cH88bC9A==
X-Google-Smtp-Source: AGHT+IFBNwi7PBNK1QB1dAtrK/Dovc2hioc3wYlyOz/fWQ+aH+cHDUkWjDqKWE2dhsMdqDq6KWD7bHwaOCb+ES1/rmA=
X-Received: by 2002:a17:90b:1d89:b0:2e2:e545:82c6 with SMTP id
 98e67ed59e1d1-2e8f0f4fad4mr19163189a91.2.1730905953267; Wed, 06 Nov 2024
 07:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
In-Reply-To: <20241106063322.2443403-2-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2024 10:12:20 -0500
Message-ID: <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, monk.liu@amd.com, christian.koenig@amd.com, 
 philip.yang@amd.com, felix.kuehling@amd.com
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

On Wed, Nov 6, 2024 at 1:49=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> wr=
ote:
>
> From: Monk Liu <Monk.Liu@amd.com>
>
> As cache GTT buffer is snooped, this way the coherence between CPU write
> and GPU fetch is guaranteed, but original code uses WC + unsnooped for
> HIQ PQ(ring buffer) which introduces coherency issues:
> MEC fetches a stall data from PQ and leads to MEC hang.

Can you elaborate on this?  I can see CPU reads being slower because
the memory is uncached, but the ring buffer is mostly writes anyway.
IIRC, the driver uses USWC for most if not all of the other ring
buffers managed by the kernel.  Why aren't those a problem?

Alex

>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 1f1d79ac5e6c..fb087a0ff5bc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>         if (amdgpu_amdkfd_alloc_gtt_mem(
>                         kfd->adev, size, &kfd->gtt_mem,
>                         &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr=
,
> -                       false, true)) {
> +                       false, false)) {
>                 dev_err(kfd_device, "Could not allocate %d bytes\n", size=
);
>                 goto alloc_gtt_mem_failure;
>         }
> --
> 2.34.1
>
