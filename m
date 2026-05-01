Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09BBCCFA13
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 13:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F7610F523;
	Fri,  1 May 2026 13:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NFPTSdye";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C286210F523
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 13:31:01 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c750eaf4cso177939c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2026 06:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642261; cv=none;
 d=google.com; s=arc-20240605;
 b=OKGx1CDDhseILQjeigbPvzJRcsb8VdH/1pu7hJIrSljwn90p03UUkN7yMSGGq4eHzP
 L/dQkjF2PbVqwIKhqQIOtXNMkNug02Aby35iVjoixgcz4YGVSGxKUJSDnktLV9K1Xi/E
 1Pqyq/mLNZa/GeB/mixxzogHtDRhFh31XnDaK/TvxZCO1PiEFf6QytZboxn4L0yrqKFr
 GpIQ6Cq3Oq8i3WFSHCFcey62MzIkScDdBTnTMUhjO3OfUV1PDmA+2j9q0OOWKWCWG+0S
 xvivEtpBFZWJY2UtQ11MRdaO/PG46V3Acq/WlfpcaMLSDAMKHJ4QqUrfBpZ6JNrM+ZqE
 lHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YOTzbWB9arxgbaCh+41rNSLKEkG4JzChkSbzgWU/u7Y=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=RYAhfR2zbssbjpbQv+U5fJsvHupHxohB8qhaAjG/GF/jJoW002iEefzIxToTGl6IX9
 n3fI93ahehwvtfFlkrwF9+iQKmMCK/DLdORGsngwkUSwrY/ZuTw1cYyHawHK8bARos6L
 VUKAkPvmyR3qFtkySajx+xFkK1CgeAcVvUmvPEASUoL8mN/fSil6ElP6kiqH3H/58fyD
 Ou0mpe4vTmL0+e9jbqhDWTzN2NGoE+janjvcIxZw6wif0rd+pUUq4Mdsw6kVCV1vvIZX
 xhjSeFYtzU8EONSC1YYnDYHLvHnI+SW9iC3HBYtyeLZ68h8nXosdW3dfeWQ9TVskHAQe
 m+YA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777642261; x=1778247061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOTzbWB9arxgbaCh+41rNSLKEkG4JzChkSbzgWU/u7Y=;
 b=NFPTSdye06zXkGAeNvNVdx5QSNq5ghTm195FSGgnYxJDp9VuFFrnorliqNigu6yGVe
 bZcpLe19pIMwudYc52QvuFh6726q3fEOf/RuM1Bbv+ntKUg8u6LhCuMiTX9qqVQHgC6H
 YeN9o4vOHmG5S6BehiqH6TBIB7s5mBrn8QOyJG/Xxls6kGHxcNa1amcLoqpjQEDv8bJw
 RZ/0vkC2xVF3Kvk1S0O2XHSS2CUAeDFM+feou5SBb225U5AIQj6IUZYaDGm/EfesX4V7
 COZHnQ6r2MRRuGO2hdKJNNTdFusQzEAfq6CpI5ShjMx5onh0RHFtVlG8uIqoiyc3sxSa
 3mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777642261; x=1778247061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YOTzbWB9arxgbaCh+41rNSLKEkG4JzChkSbzgWU/u7Y=;
 b=ZWNCzwd9xGqgnjDN2kMVGPIX58ZHoUYGNhrwZ0jki7mRkhow2JeXVxpg8m1Sw+RatC
 lXkg44SsrJEeAZYqri5V9DnFTmAQ/LKeggGNRMUvjX6XwqIGr7KCJfxXUwETivH2nHts
 5b+7zNHCWN95sexGOpCP2eQuwbCMk71O2UUhj2ddEdAY+FgvlbgDk1k1lZQ+c/WQPR5I
 0r0GQDpE6Mfxt+rog6h0s3QHOHsrRav6vw3OHN1OMIp7ZYQxP8Q3OSp6BITk5RJ6L4mv
 mybr3yv6h4x3lYEwnJkz+DMnSigr8rhlmhVFV7FB8kknHJBcdfaJlUEze3s/hciN6oZo
 O/MQ==
X-Gm-Message-State: AOJu0YwXzhZDkxid2VbJ6XG/Rj9ffbo0vYRc/6K5LrQiWCXoSxXLYPWc
 RMbqK2RT2OBSamOvgGpkfMKR8eDHn4R+jqEM39nYBCg+q0MhkumhGNZI1bWPklkqxLYO//HUmwl
 9RlkH271mLNQDG7xw0mfD+CygRs9STus=
X-Gm-Gg: AeBDietxpX52RaoCC2dMpGVjCvHlyDRuu+szn4cY3CfaEDoo6JTY7wkAzW9YYm3STiN
 nc5+ks8lQH/xwflhslxmZ8quyrTdM1As/P08rtKre7Gr/upLAHG6d+tLj+0omyJE39CibQYhIIR
 3SMSSOAmWVXi6n/hoOrLx2O4fXLc2VE/BrD1TtanD99SNTdFVaCMoyaUwQPEZgoBhzepB048Q0e
 BjMedrHqtoPx+JXjDSxMO4xIEvgVJFisdji+MUjQNmelbNAf0caU3Y0oqv+dmw1xZKM60YTF2us
 oW1fgjzTrS/sgpOCx3GqGbczWqnQcSkzAjyhWFe0lgTXM5GXBdNY/RQU7PZOZFwBqlW+6uyOIpv
 bvoar
X-Received: by 2002:a05:7022:f94:b0:12c:20b9:80fc with SMTP id
 a92af1059eb24-12dead567ccmr1428155c88.7.1777642260854; Fri, 01 May 2026
 06:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
 <20260430161146.2851078-10-Jesse.Zhang@amd.com>
In-Reply-To: <20260430161146.2851078-10-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 May 2026 09:30:48 -0400
X-Gm-Features: AVHnY4Ih3najnKcB83DxqgNZYo0IVED3jf1sehtZMh0S4bJawg_f_2xxb-Bo2hA
Message-ID: <CADnq5_N_PwKyX4-gmDc7xWWB3AL0CVYJXzomgOXER0c72-c_oA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA UMQ
 submit
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Apr 30, 2026 at 12:29=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: "Jesse.zhang" <Jesse.zhang@amd.com>
>
> Pair the userspace aggregated-doorbell ring (added by the
> AMDGPU_INFO_DOORBELL / AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL ABI in
> the previous patches) with a kernel-side
> MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE in amdgpu_userq_signal_ioctl
> for SDMA UMQs.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

How will this work if the user doesn't use this IOCTL?  protected
fences are optional.  An application can create a user queue and never
use a protected fence.  Why don't KFD SDMA queues need this special
treatment?

Alex

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a58342c2ac44..50e275b51c9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -598,6 +598,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev=
, void *data,
>         /* drop the reference acquired in fence creation function */
>         dma_fence_put(fence);
>
> +       /*
> +        * SDMA UMQ wake: SDMA has no CP_UNMAPPED_DOORBELL HW intercept, =
so
> +        * once MES gangs the queue out (after the first IB's PROTECTED_F=
ENCE
> +        * idles the queue), per-queue doorbell rings hit a mapped-out HW
> +        * slot and are silently dropped =E2=80=94 FENCE IRQ never fires.
> +        *
> +        * Userspace rings the priority's MES aggregated doorbell directl=
y
> +        * via the agdb_bo mmap (see AMDGPU_INFO_DOORBELL +
> +        * AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL).  That alone, however, =
is
> +        * not enough on current MES12 firmware =E2=80=94 MES will not sc=
an the
> +        * priority's queue list unless its hasReadyQueues flag is set.
> +        * NOTIFY_WORK_ON_UNMAPPED_QUEUE flips that flag, so MES then
> +        * processes the doorbell ring and re-MAP_QUEUEs the SDMA UMQ.
> +        *
> +        * This is a kernel-side companion to the userspace agg doorbell
> +        * ring; remove once firmware learns to wake on bare aggregated
> +        * doorbell.
> +        */
> +       if (queue && queue->queue_type =3D=3D AMDGPU_HW_IP_DMA &&
> +           adev->enable_mes && adev->mes.funcs->misc_op) {
> +               struct mes_misc_op_input op =3D { 0 };
> +
> +               op.op =3D MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
> +               op.notify_work.priority_level =3D AMDGPU_MES_PRIORITY_LEV=
EL_NORMAL;
> +               amdgpu_mes_lock(&adev->mes);
> +               (void)adev->mes.funcs->misc_op(&adev->mes, &op);
> +               amdgpu_mes_unlock(&adev->mes);
> +       }
> +
>  exec_fini:
>         drm_exec_fini(&exec);
>  put_gobj_write:
> --
> 2.49.0
>
