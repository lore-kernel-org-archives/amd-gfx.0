Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F16AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 19:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC91610E29A;
	Mon,  5 Aug 2024 19:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QeyMnaeI";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEE810E29A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 19:59:08 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2cb5243766dso8724a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Aug 2024 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722887948; x=1723492748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrHzJ5RpXek44xNP35USN3iE+igbkoFbqoC+MsMenhw=;
 b=QeyMnaeIBVSWYHjDT8YJqMGVsjlezQl4DTJPAd4NUH/y0xAhqu7UKxsKBJqgYL3IMl
 qu+cWY4ZZlD5fg99Mn9ozUlLDpOioD+Oic3pg5VWqT1mL4hC96dV+cjbbhZjbLO04a1g
 qB4BuiNj6f7NO32wFs5GKygDRSPm2ZKKHbloCwKQ2r+LT0V7/zMRwBNSodF6wceksJSi
 ikfXdX6L7O88c52LaXHiNCsSfPer4RRmfgvWF9wocGzz5uNMHuktoSK3H1e5AQmnDb4H
 adKp7N5uEk3pWBjlSZXUbfWB1r5RoFQhMqqwKn39KrAmFLzbmjK1dlrOb6GR1wqSrp4Q
 wPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722887948; x=1723492748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrHzJ5RpXek44xNP35USN3iE+igbkoFbqoC+MsMenhw=;
 b=clLHB36cgPNZPL/lboKOs2Gcgs02DwuKQ0nxSGXTVpYmDNa03nnIz2XeEV8SQMmNms
 WhSKnlzyHpKaHywF1X7Or0OyKPBI246cMDTqvxzRw5UlMi6Z8Xrp3GePKsBtNqWxxvgJ
 MjDgVo70KIfHg9awlFMQsF7RO2sVlVlbJkb9H5YGpYnjpNgIhg0tyCOamk+9/S63ElHl
 pP04iu+SElpYiA0OkfGccOeM350C+PevSVPpWzJYUNpkFOxxk1zM0NLMAKuSAzW1FCBZ
 yoPbkFWZJ3kMVzGtsnBT2twnEcHg2pHzfzqoea5CDMExZIsX5iQS3OrIomqC8lOIYD7O
 cstw==
X-Gm-Message-State: AOJu0YyhjgPB76rw0RZjJ6vO8OMzvmOKoSeQmGoh8bm5bv7AxiA0+8XH
 wuUlhjjrM3uYhjJEcV9k+wF2NYORq+3vZGGD7gt3t7Z7rCOEy+NFerlUdCDIvWBmg2gHXHkC0ea
 TmkNOIieb3ITFEdGepeu6P2y1vaTLig==
X-Google-Smtp-Source: AGHT+IFoyB6QLFxAix7lv9d6GJC8D6yZM9Ihb4Y+kdSqn6Yj5GnBwYxMnaFz6gp6/J2dqcgVqOp3lUCXLeBmyrJaOFc=
X-Received: by 2002:a17:90b:4c0e:b0:2c9:6ccc:2fbb with SMTP id
 98e67ed59e1d1-2cff946945bmr15990064a91.24.1722887948166; Mon, 05 Aug 2024
 12:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240802182720.318993-1-victor.skvortsov@amd.com>
In-Reply-To: <20240802182720.318993-1-victor.skvortsov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 15:58:56 -0400
Message-ID: <CADnq5_OdCBnP=E7oe0cOh3=HGJwXYavRGCH958=S8Px8smH99g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: Extend KIQ reg polling wait for
 VF"
To: Victor Skvortsov <victor.skvortsov@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Vignesh.Chander@amd.com, Lijo.Lazar@amd.com,
 Yunxiang.Li@amd.com, christian.koenig@amd.com
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

On Fri, Aug 2, 2024 at 2:27=E2=80=AFPM Victor Skvortsov
<victor.skvortsov@amd.com> wrote:
>
> KIQ timeouts no longer seen.
>
> This reverts commit b4d12cc00ad69e8a0dea2ece7202bacfd8b894fb.

MIssing your Signed-off-by.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 137a88b8de45..206360503136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -347,9 +347,9 @@ enum amdgpu_kiq_irq {
>         AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
>         AMDGPU_CP_KIQ_IRQ_LAST
>  };
> -#define SRIOV_USEC_TIMEOUT 1200000 /* wait 12 * 100ms for SRIOV */
> -#define MAX_KIQ_REG_WAIT (amdgpu_sriov_vf(adev) ? 50000 : 5000) /* in us=
ecs, extend for VF */
> -#define MAX_KIQ_REG_BAILOUT_INTERVAL 5 /* in msecs, 5ms */
> +#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
> +#define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
> +#define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>  #define MAX_KIQ_REG_TRY 1000
>
>  int amdgpu_device_ip_set_clockgating_state(void *dev,
> --
> 2.34.1
>
