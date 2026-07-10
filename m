Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BB2C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F5F10F8E2;
	Fri, 10 Jul 2026 13:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZfLiAyc";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FEC10F8E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:34:04 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2ca158f02ccso2380675ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783690444; cv=none;
 d=google.com; s=arc-20260327;
 b=GZgTOlzo8Wq+bSTgxTBNoXHXDzB6CQ0ZD3WbnzBoELZmgf1ZJ53BT5ySdB5EDT/d/7
 4OjLpNIjJTXaPdSct/nAV/PC9z7PJfV+vcuU4lVkMHKu4LyVu+5SYXQfq0eySiTw24da
 yvrKSinJr9ocne9GewtyUP/QTcRhi8sF0BX9KdjqUR/MWNjpNGqkQzOv9SP0sxrdRUpw
 qwnyPiPZlMKMAuNsTrwZzFkNrr72LcQiHjoBx9j/6fmsADJ0hCsTCHdrkqIfcuFr9EA4
 WiRS9GZKfWHL50XWrBFqYJx7BHmkOQzzavVmNrmfy8vrAi1/qRiemAMUJgDXRtwO4Ywt
 T2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jf9WDkMAlW1uiTPRoDFydqvr3xxuohSQSPO/b8Vz4dY=;
 fh=CAQvLrMO+G215KzMdEOSEliozUfcQ8VWfLOp36ir1Pk=;
 b=GYIvhsjcnQq4z2SQcZ1vIQ0ONuZJGbpC5Tp23Ksr55l15aPMECzKrxhkdXZbHJE1cB
 WRPCjCwtofIOk/h0OT/2ZgYo2Rc+9jSC5uulauWcjyf0HVZRHvZd+kVs09W4No43HiqJ
 7tGVr6cmMn6sEV9WPXO6Es+PJwvpMb09+yngAvuVCvi+FF4A4lilXCJmOuTRIqN0giRM
 10Mfdm0CrJ9GZUB8ESXe+0rfbvfJtB/S5sNK288dZ+oEMjpF/tkq7oR8hJgjmUp+pZiX
 KseXM13VSDfq/oYTYKZEJVQuZ8d5tAIdXZesaUYOV29X1op11I5EQpduHIkNDFet6AjK
 Qq0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690444; x=1784295244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jf9WDkMAlW1uiTPRoDFydqvr3xxuohSQSPO/b8Vz4dY=;
 b=KZfLiAyclqn5P/C09/tVFCm/CS9rywJDSlmHgo6aM0ZgVREJBhM2LQjay7SZG9hztO
 +I7QhhxIfdRWM0Ick4wO//xG6d5CdguEW437KKBo2CGV+Lu7nbtt1QTYFcDveZgBPBJg
 GnkJER54f+OU58uRQe+Ryc/U8GTr5uFAUIHyF7wwwAYGkpqOEf37jORJU901ZXgEUUK9
 qe5DdPFAaMTWgDefQ/ykHs1e6FYPYbNIf3iSrUPos7ADxS6FqzZytSKu+BBUwjt4+ViN
 aidY0j0FBePiuUfV2swZGzBgNjnntssn7Q/6ySpE5LixoJN+RQVIPYWOOe5CZOIij47R
 BSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690444; x=1784295244;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jf9WDkMAlW1uiTPRoDFydqvr3xxuohSQSPO/b8Vz4dY=;
 b=As6TB4E1E082my5TfSokzz9B8IiYjbL2OFhOK94N6XsjlPgwUbMThEBAJxpG1kCTj2
 PPdnVqXGPwRURawmApRlT+NzSmUWpvFvbKkPWG0tgkv0rF7o8hdwX16m/OmOkGfjrrJ2
 NdPzo8kKhd/A1M+LUmJjAauVfOxHYY5S7WVKqMGXMP7mn2O3rTXDJ4OOZNKmdxMdJJ1I
 ERgW9hj95Ou/HPxdXa8VBYlmv1ab1Q+aU6vsLvTMU6rPpKygOsKY/kjBSgaHuPxah+B8
 HFhf8Tn/Hsl3SyP6tBEPeOIWkRYlhvsm6uakoPcvY0TuRmAemvEMIBxMJaYmKD8O3ViF
 E56g==
X-Gm-Message-State: AOJu0Ywv/Qcv6+Bo+W2V6H5Vw6kGz1m5Kc7QQtKOjUuKW+SIMUagqsLc
 N3NEGSMG1ZU0qXL9xeNAs/MVz9CrRDy7kEdHGbFaBc9rIQwZpbHiSJKOBtYR/1LEQ5aNvRj9nAZ
 af0ztb3p9Yv0DYr3YCNWkgqqUFHQiQiM=
X-Gm-Gg: AfdE7ckeZ9abNREvYlFxAtNFJgNG2nm6yLg6STi+5fOFAy92wrlxQlxza/5BXoKrlhM
 XJQwt7OP/5D2ntdK4Nxv24WVk3eMCUdorp1zomueKfDZ/nS0Rw6ZqovF9odV6gjJUjY85u9ITwv
 r7iZxKkJJ8BGlmnYe7MuV6nD6uAML2aimfzBluiM21Qbh40EJvfUQeU+oBbrMuTh0U0UJr/VGMM
 AW+Ft+Tm9BlAALmmZnL+VpSeNY7OohnRQEDyTCRVUtgbCmuUP9qBlSClkX0De8ejSFe66wZbrPr
 UXiCjK60xf0tqfnTcVd9TXr4yBp+e0NiBRPd5ZFgYbBc2K74KAjRLRHBYDM=
X-Received: by 2002:a17:902:eccf:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2ccfe05e629mr71465735ad.0.1783690443695; Fri, 10 Jul 2026
 06:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260710073648.41408-1-timur.kristof@gmail.com>
In-Reply-To: <20260710073648.41408-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:33:51 -0400
X-Gm-Features: AVVi8CfdgHGfASG6k1Yd_9OOtNvARYW0TmzmmEF0MbZ3XJLutudpc0_NN8hqemw
Message-ID: <CADnq5_MBR2QLU_w8PNU2ktSKpDPwgomGKC0JH0C6ASLs9ooTsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix IP block NULL check during soft reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Dan Carpenter <error27@gmail.com>, kernel test robot <lkp@intel.com>
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

Applied.  Thanks!

Alex

On Fri, Jul 10, 2026 at 3:44=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> We can't print the IP block name when the IP block is NULL.
>
> Note that it should never be NULL, the only way that
> can happen is when amdgpu_ip_from_ring() is missing the
> given ring type. The check is just there to be sure.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202607031711.yLwFhGfp-lkp@intel.com/
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.c
> index 33a04113ed74..922f4b15619d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -489,7 +489,13 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *=
guilty_ring,
>         ip_type =3D amdgpu_ip_from_ring(guilty_ring->funcs->type);
>         ip_block =3D amdgpu_device_ip_get_ip_block(adev, ip_type);
>
> -       if (!ip_block || !ip_block->version->funcs->soft_reset) {
> +       if (unlikely(!ip_block)) {
> +               dev_warn(adev->dev, "IP block not found for ring %s\n",
> +                        guilty_ring->name);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (!ip_block->version->funcs->soft_reset) {
>                 dev_warn(adev->dev, "IP block soft reset not supported on=
 %s\n",
>                          ip_block->version->funcs->name);
>                 return -EOPNOTSUPP;
> --
> 2.54.0
>
