Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F68C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 15:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B29510E263;
	Wed, 24 May 2023 15:28:59 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F29B10E263
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 15:28:57 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-54f5fdaa693so3901934eaf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684942136; x=1687534136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5MQz4tRtkG+kSAOx+7cDjXH3GlxLpEVvkOR0cGeMbw=;
 b=CKW2NTF6Voh4yCMud+Z9KU6wa2a3nyRCotPLtem283S8sHvDjQcHT8DaACbLBM34AB
 u3Do1boA3IpAoWMFpuzvdgS406jmI7Gej8+CnrWPYcBCurgHrRJzkx7sqncgq9bHmKB9
 o6vbxenD89yepUE3ZFj4jVSPRzcQ183xWtQoK5l2JX/0MmGB1JprLbMteiV8n5yVmooc
 rZsLu83MzpBxB77Y541sBwI/27VJtN3TROQZU4bnllY/D4n61J8+2IgSI3VbL2hwizf/
 +ddvxDb9hMA9t8K8n+rs5514YlPd+9kHqjfrraBu8Gjs+R824mt/1Zy5b9btLL5Q/3jN
 k9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684942136; x=1687534136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5MQz4tRtkG+kSAOx+7cDjXH3GlxLpEVvkOR0cGeMbw=;
 b=ZErZ0c7oUdd8XaFlBsKVAfalCl0wAwQ0TbjA2P1M3DhX3rS8NbMkal+UMdpMZ8TX7N
 GJAuS6Ljum5bHkM4qHV9YSd6rQiDPDxxHapDFO9KIzd21q3mFMxjAMlTCVRcZP8NuVkm
 +6Pm4DZqf6HxFhJ0gNgrtquXBOG7cNhbevZpAPqypzFkLzFbLKNMBelO6eMbV5idxXoR
 yWZ5GseIGDyfLVXjMhF2+8tFXpXLGelyED6x4Z72+tdtjm3BSEAYpTuazPtpp0kQ+ARe
 l23u4oxczZOuw+m3O4BBAjInUQoHLtmcVJVMkmgsPFEGMnfK5/U9k7SrxYSNzVlbtcFv
 X1Dw==
X-Gm-Message-State: AC+VfDx17ucdzNMzc2GZ564Djo6Pc0mko/2TI8saNFwQe1Nk9sHAYc1c
 EbJPfhFuvdubN8qqUI1vggLUFsyDlHC4x0Pp7fk=
X-Google-Smtp-Source: ACHHUZ7uw0PRxGdf3aDPz7JxHgbvzaWS6kWcooJnGWj444daIvvFiBZAFV48kI0dDl2rfNgYCiGCMryqK5Uhs2taraU=
X-Received: by 2002:aca:3cd6:0:b0:392:31fe:cd19 with SMTP id
 j205-20020aca3cd6000000b0039231fecd19mr10464992oia.0.1684942136452; Wed, 24
 May 2023 08:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <646e2c58.170a0220.4f979.2ba7@mx.google.com>
In-Reply-To: <646e2c58.170a0220.4f979.2ba7@mx.google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 May 2023 11:28:45 -0400
Message-ID: <CADnq5_N7W8_c6tcFDkEEM_shXr0GJV+YJfJ8y4YC=2ufRHRX5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable GCVM_CONTEXT1_CNTL after page table
 addr is set.
To: ghostfly233 <ghostfly23333@gmail.com>
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
Cc: Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 24, 2023 at 11:25=E2=80=AFAM ghostfly233 <ghostfly23333@gmail.c=
om> wrote:
>
> In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
> enabled before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
> GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
> cause undefined behavior.
>
> This patch enable GCVM_CONNTEXT1_CNTL after page table addresses are set,
> so that it can ensure no undefined behavior will happen.

Please update all of the gfxhub and mmhub files with this change.

Alex

>
> Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_1.c
> index 4aacbbec31e2..791afc8e9e85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdg=
pu_device *adev)
>
>         for (i =3D 0; i <=3D 14; i++) {
>                 tmp =3D RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, =
i);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CON=
TEXT, 1);
> +               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CON=
TEXT, 0);
>                 tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE=
_DEPTH,
>                                     adev->vm_manager.num_level);
>                 tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> @@ -333,6 +333,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdg=
pu_device *adev)
>                 WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END=
_ADDR_HI32,
>                                     i * hub->ctx_addr_distance,
>                                     upper_32_bits(adev->vm_manager.max_pf=
n - 1));
> +               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CON=
TEXT, 1);
> +               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
> +                                   i * hub->ctx_distance, tmp);
>         }
>
>         hub->vm_cntx_cntl =3D tmp;
> --
> 2.34.1
>
