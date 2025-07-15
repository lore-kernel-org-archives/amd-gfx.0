Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC775C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 18:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8299610E050;
	Tue, 15 Jul 2025 18:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EctAXNqn";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F228810E050
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 18:46:46 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-23de2b47a48so6507345ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752605206; x=1753210006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lsraJ8K+80LoJvcSy8DqFlwGVdi0yJ8fryyjNly6T0=;
 b=EctAXNqnegq33iMixjWT0/hDeW6ODZ9iJYcC1Lcj8cTDiljmHkMixTZA0rSDNFfLP2
 VvhHW9NyAd21kkNP6uW/SlWHRAwTydJe36ZORtBO7n0OSe/9J/JS3ZbeTGfEI1INjaRG
 AsaCOnagBU85Z9UopA9OOzwSe8gvpSs3TBERWX7iHa0mjBQaUFq8BCdpWivCQ2CEJghU
 gvIIUoos97DO0TC11j2gaDEHhmL6RuhVxAj2TgFPmbr2sn4BvNW+nZzEWOb/Zbjah7Bp
 smdYgGYcycTUptZrqfHFpgskqAeknIhHfORD+FULD82XvPq9M16+G9MOwL64biJwnIwy
 mHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752605206; x=1753210006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lsraJ8K+80LoJvcSy8DqFlwGVdi0yJ8fryyjNly6T0=;
 b=Um3HfebBHD6rH7OOqZtBGvvF7LqNF8X0s4s0N/dj0X877jemOvdhlBrtdVqXyV/T74
 oq2LgiQXvIIRRAgm3lFQZvOkypDNDRl1GNIQ+N/Z8VFBXbMwXQ+6745+tNonVLC1KGFq
 QYLGY5xp01r8KsBRGS6y3im7JXyhjH5lBwmDdAGJ6cPn2JUH9oy1dSiziqA2g4Gplui/
 81NoMbQGGM6HUuYRRx78hzYqeEeBkL0hT1pvzywYaT5tjnYhJesPFjvEh5dBEgUP02vC
 hrTyftnbFIEj6xliFw/5d97WKeJ4CSw8UksD3xa26LdAsA64/6tO1PbTZ9bnmo/XYtNw
 kpRA==
X-Gm-Message-State: AOJu0YyE4ZEq4KGBFo8mCS1FcFbqMtfSxNMm8eTE8kRzT1HPHYtcpYKj
 X6BV4bwfyjkW2mvDR91hWK4YyupPb2jjDg5NGZ/eVdnzoupVr6O15thr/4jKOBS28xc1IpxDRdy
 M1lfOHTRnnt7eOD895mSYfNudmK6gH4X5yg==
X-Gm-Gg: ASbGncvUNMErbFlK8QXL64S3BHuznGLeH6ehNnK3KImElV0gPhXOWzJbPvVhsLpTsIW
 Gx2n7gDVHD2bOH5AdtmiAqqHy4FnGV/D1i+tAtnvQQrVNeIdfKshPm9ewxVRb9V+eIDQXeIoO51
 rtDF5KSMZzQuyxjEwNIlt5yTOCClXH90Z8E8pqRmqk5DFqrAolL9TejukvLGuUNYkAXnrhVbJ6x
 A3VdrH8
X-Google-Smtp-Source: AGHT+IGZByvMxGBNaSZ2Jgc0zQo03ty5tej+FsUNZfiC5CSusyTQ2/5ZQt5j6elRm0hW2usPpoK2L/pbHzSdAi/9bSc=
X-Received: by 2002:a17:903:22ce:b0:234:8f5d:e3a0 with SMTP id
 d9443c01a7336-23e24ec7de1mr441345ad.2.1752605206343; Tue, 15 Jul 2025
 11:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250711215122.23288-1-alexander.deucher@amd.com>
 <20250711215122.23288-3-alexander.deucher@amd.com>
In-Reply-To: <20250711215122.23288-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jul 2025 14:46:33 -0400
X-Gm-Features: Ac12FXwLXiw8lUzQF1B4zLFJ6nrJIHIplASE_CBl5DFWwXTY6siNJE0SP_radIQ
Message-ID: <CADnq5_Ntdm40p8Uvpz84g0ch6sDo=y_woPLAvc6MCQy8=vtH2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue
 priv
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

ping on this series.


On Fri, Jul 11, 2025 at 6:28=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Set the MQD as appropriate for the queue priv state.
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index e4fc42470cf3e..c4dc6bfb0f6f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3016,6 +3016,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>  #endif
>         if (prop->tmz_queue)
>                 tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1)=
;
> +       if (!prop->priv_queue)
> +               tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, =
1);
>         mqd->cp_gfx_hqd_cntl =3D tmp;
>
>         /* set up cp_doorbell_control */
> @@ -3165,8 +3167,10 @@ static int gfx_v12_0_compute_mqd_init(struct amdgp=
u_device *adev, void *m,
>                             (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1))=
;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +       if (prop->priv_queue) {
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE,=
 1);
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, =
1);
> +       }
>         if (prop->tmz_queue)
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>         mqd->cp_hqd_pq_control =3D tmp;
> --
> 2.50.0
>
