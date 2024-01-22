Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F6C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 14:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A52E10F079;
	Mon, 22 Jan 2024 14:32:01 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6FD10F06C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 14:31:59 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-6ddeb09bc68so1758254a34.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 06:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705933859; x=1706538659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVU212tIiio3Ot4U5FS3kHcWVKmApZYn8vJ+DRJf5LY=;
 b=HZIud0oIbtKwi50HJKdZltwhAtyFJLxfdc45mzJm1lVBckYdUiOXLfXgqgnZrIvSA2
 rOSBTqTgoh/eznVYa0f1dGWqSEN7NfhWGsPw2ELz86BeyX1LpldIdOgn0vN5usWY6FfU
 0thzpcg1al2u6rDXaOx50wSPcVcRs7HP/H/P8Uq/d/IigAdcfl6yUnqZsZ2UBHqP9QVE
 RRM1qePbcrQANS04+k+HRRzgiwGNkz0OTiZUpIIaSfw05/aBUEtLi/OmRd2F+AdYQ2M0
 GTnFl4Bn3bQpChK2I/dJce3YnudhJ5HQUE+IxCJHc2gTDXm200MJNSXiJ+37DSJ9UlCd
 ymeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705933859; x=1706538659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVU212tIiio3Ot4U5FS3kHcWVKmApZYn8vJ+DRJf5LY=;
 b=IEMAd8m2Mo4muaZNL0kFZcmwUsQUIEaEQmq/G+DK1ne5DBi3lwNPoCBPVJrRLvK+IW
 nQMiASPCNRVGll6zybuAXy4cqhyQ/+EtZAc2yEisE/eLi8BUJrvZAgg/iUNKeM5PVTAI
 pNtowfloXvxCjqBI/u9FRhrkdB8RyfRuXpjQ/odWQQlzT06vTQdYC87JznJS6QqeDFxA
 5PaQv+2OckYvQYU5wsk+gD4vMZL7BFMJH7NgRr0BG1660GaL2f0a3uGgeW3WfomsnunM
 tVL3pCw5w6qVANJ8BumgKWTyv5P1mYPzpLmBML4y/wfIjxTHgIxOzXK9PDTBYpDyGypM
 9t9g==
X-Gm-Message-State: AOJu0YyRDvhHrN11JVN7bnNZ/SIDz1E1RqU41crQzz9XdEjRbtjAW09W
 A8bpCYxs635gMnasI7u1G21WKG0UqCuRl4LQ+pml9zwJODzKHafxXIfvdsnpxZTIewNQLBr0wQp
 pjsJBuaIOFXjAdMO8C32WqcCoWFQ=
X-Google-Smtp-Source: AGHT+IFJvYat96HNKwe+EE9+EnX65hOuJzMIrYcefd/8hBLL3jNr7UO7U++d4awo7ld2CCarh6P1mUY7UvGeSbC70J8=
X-Received: by 2002:a05:6870:b61d:b0:206:7fbe:b142 with SMTP id
 cm29-20020a056870b61d00b002067fbeb142mr2334566oab.17.1705933858950; Mon, 22
 Jan 2024 06:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20240122084240.1053190-1-Jun.Ma2@amd.com>
In-Reply-To: <20240122084240.1053190-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jan 2024 09:30:47 -0500
Message-ID: <CADnq5_OZQNYB-6ZEzAF_Yj4d8m-n5SpDQfyYU-CUNr_zYVXtAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/pm: Add default case for smu IH process
 func
To: Ma Jun <Jun.Ma2@amd.com>
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 22, 2024 at 3:52=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Add default case for smu IH process func.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c       | 4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 8047150fddd4..d74343adaa5f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1462,6 +1462,10 @@ static int smu_v11_0_irq_process(struct amdgpu_dev=
ice *adev,
>                                         schedule_work(&smu->throttling_lo=
gging_work);
>
>                                 break;
> +                       default:
> +                               dev_dbg(adev->dev, "Unhandled contxt id %=
d from client:%d!\n",
> +                                                                       c=
txid, client_id);

Typo: contxt -> context.  Same issue in the other files as well.  With
those fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                               break;
>                         }
>                 }
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index ff1f35e823a2..fc7c04e19b18 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1428,6 +1428,10 @@ static int smu_v13_0_irq_process(struct amdgpu_dev=
ice *adev,
>                                 data =3D data & (~THM_THERMAL_INT_CTRL__T=
HERM_TRIGGER_MASK_MASK);
>                                 WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_C=
TRL, data);
>                                 break;
> +                       default:
> +                               dev_dbg(adev->dev, "Unhandled contxt id %=
d from client:%d!\n",
> +                                                                       c=
txid, client_id);
> +                               break;
>                         }
>                 }
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 952a983da49a..bc1242477002 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1439,7 +1439,10 @@ static int smu_v13_0_6_irq_process(struct amdgpu_d=
evice *adev,
>                                                         entry->src_data[1=
]);
>                                         schedule_work(&smu->throttling_lo=
gging_work);
>                                 }
> -
> +                               break;
> +                       default:
> +                               dev_dbg(adev->dev, "Unhandled contxt id %=
d from client:%d!\n",
> +                                                                       c=
txid, client_id);
>                                 break;
>                         }
>                 }
> --
> 2.34.1
>
