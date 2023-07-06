Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667BCEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 17:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0644610E480;
	Thu,  6 Jul 2023 17:42:02 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DB710E480
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 17:41:59 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b049163c93so731025fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688665318; x=1691257318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUep7VJKQnKxe5hVUaDLltzPFVX9/iFrcsS5Hafd1nY=;
 b=KKehbuscR9s2NtuDxsONQTgiSgjA3Pxnot6nxTWIX8xPNaFXxNVtccdd+xKuj2nWjH
 rb61OMoHyHjnqr+TGfTGqaDHifXSBGNjIw5qjYX7TvMuvWJOIX9EJzHFkusjX2EudAat
 WrYSJwPO9UbTL4cHnGFzajwRwWZ/Tcdhe+r2LAdilozZLjwb9dVPq2GSNnF+FKj2wgGq
 Dt0JTDG0i/JnohtbGBTddccVrdyQvDp7CnpfxkPRbOzZ3hdSfJ7BFiGrjrKC2rf34GOX
 er70JTQOuUzNdBQQ0xYd0tZlnPdVfj8gvUwUARzl9ST1Bxd0dNk+bTDT5IZ81a5rRzj2
 IetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688665318; x=1691257318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUep7VJKQnKxe5hVUaDLltzPFVX9/iFrcsS5Hafd1nY=;
 b=BUe64wshaC4IZC+G8tjiYJuRygz4G5vIQRQCfNmv3Sk3CkssEV+Xvvj5eWyzTdLNG3
 GZVl86szQPflQgtbHdawriikKi9fLuj3604KQKj8oUlP/3IMnJhRdwNYK/ZvQplYA3+g
 bG3diShdjofsZldr7OUsfKKUUqTAc90LIWWZkHaPlcmZFCUh96NhyI+QVly0s5l59zi+
 fewb4F3UlZa2D1aJf+Qx2ncYtCF0km2M7nf4y0SKth88jdt+tsVLdSxX45rT7S5QpFMb
 PKJMnLBFwBfWgZW/DdPTpQigRt6NDGwyudj0/46LaNlxUg284Iak6pddsIMoiwnfgPs0
 SYDA==
X-Gm-Message-State: ABy/qLbO+KDud34zFKtGu8Uxass610/QoUFjDGCQo3WSXqVdVN/fmC7G
 hazQsukHGjJGUSYpaZoM3xz+MAl3JWIsOGzgilfje5Ci
X-Google-Smtp-Source: APBJJlG5X3iSZGcVm8YMRsTwgbSMQ6zJfzC+mzQShfA/xXklzSkhBY0pzhToV7KNHktyepdCLez2O/Z3DIPP9YwLWdQ=
X-Received: by 2002:a05:6870:9720:b0:18e:2e28:d3aa with SMTP id
 n32-20020a056870972000b0018e2e28d3aamr2666271oaq.31.1688665318481; Thu, 06
 Jul 2023 10:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-11-shashank.sharma@amd.com>
In-Reply-To: <20230706123602.2331-11-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 13:41:47 -0400
Message-ID: <CADnq5_O2iSioSREAp=8iPnQ+qcm98b6+NUK6AJo9y5XGkT6BbA@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] drm/amdgpu: add delay after userqueue mapping
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 6, 2023 at 8:36=E2=80=AFAM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
> It has been observed that the MES FW needs 250-300us to map the gfx
> userqueue, and if the user rings the doorbell before this duration,
> the FW never recognizes the work. This patch adds the delay of 300
> us after the queue mapping.
>
> V1: Moved the delay from userspace IOCTL to kernel (Alex).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: =EF=BF=BCArvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 8edb020683a1..78b58c5d0fd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -25,6 +25,7 @@
>  #include <linux/firmware.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
>  #include "amdgpu_psp.h"
> @@ -6749,6 +6750,12 @@ static int gfx_v11_0_userq_mqd_create(struct amdgp=
u_userq_mgr *uq_mgr,
>                 goto free_ctx;
>         }
>
> +       /*
> +        * It has been observed that HWS needs appx 250-300us to map the =
queue, and the
> +        * user needs to wait this duration before ringing the doorbell, =
or else the FW
> +        * will never recognize the work.
> +        */
> +       udelay(300);

Is there a way we can query the MES to verify that the queue is mapped
and ready?  We should talk to the MES team.  This is hacky and may
fail if the MES is busy, etc.

Alex


>         return 0;
>
>  free_ctx:
> --
> 2.40.1
>
