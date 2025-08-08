Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8571CC87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D11310E0A7;
	Fri,  8 Aug 2025 19:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LwJnBssC";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5925110E0A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:47:42 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-24286ed452fso3446405ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754682462; x=1755287262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NihLoVKJ2S/NoHbV4oWrGEj0wDWtDFmn2JpdZeRJCyw=;
 b=LwJnBssCEDCdqTuaoEp2RRTU5/ONWxm2KDK3hkNlsdYOL8LxZQlsu/f5go5E70qvMa
 iEOrHV2PbEsTQsOczmcoHu3wXjdeIRsqLZ4ehexBhHTg6zVssusCHgGMVbnbLzaWUPxp
 +1M/HcEYevndyxurFqleP3zvZcVdwLPxpmR1m0+7TO0C87L6xM0uoG5HOJxhcu/1cm/2
 pjGEn/qK39HpepR9e2SQjbdBD22W4E1JBfE+AWLTlNuZydVvk+fJ049AEwxjxZ+2dzkc
 bqxpOfDcm2BSJAyG5hB4NQLq75qd+ssMhViKF94U7FBa52i6RFsNSIrfBlnKyESp8/6T
 dUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754682462; x=1755287262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NihLoVKJ2S/NoHbV4oWrGEj0wDWtDFmn2JpdZeRJCyw=;
 b=i1cmZmIq1cQ0l/vslLwjPKWRBOhdXoM64yMvwWu+Xz11ZJ+QybcHOn/lmhCiZlwBS3
 DLwXybv040ry5V7aM8aQ/ZTLCDzqeR5bV5khvHYK3sOJBgJZ8h7/c0VUS0TyM1vumb7A
 jLhTshjoEboXzc03LSNAlW21g3tE7HX3pq5H4Zm+JYBLDjjtyX4bLy7HxNVGAX69OZbi
 GhbEQLEbfNpjidP49n+VrX8zsWPWz6EjQwrOavCHKzwatVE4Myuyvo4tWqe9smO/DJe9
 AGWwRsvrZfJ13tb+zaqoQ8c3lNRhyKpNtycAmLMU4mu/LgNR0XNKBMkDDsIFE+83vjGm
 xOww==
X-Gm-Message-State: AOJu0YwGqNPta9foQjReKq72w4/Af3Sx2KWglgb6eWfylv5KYPQkanJr
 FVapcepEoJ8Xy5IKss8vWF83Cr58axrs3ptiN5r22N4pEuLGKHQbGs/Il1X1KISQPYSDPog7i11
 Ee6Aq/0cEEifYZ/OQ0fBDIiHos+R+4tw=
X-Gm-Gg: ASbGncvZT1iv9CJHL2gP/8cyJ+6c4/5AqyaHtj0O3sxEfYxk5rYK6iGAh9xA6QCcFIk
 zJ+mTdMNCgE+tALzfjBNlOf7uAQa3FRIZX/5ON+k0QcJ/QhegAoxCbjt4fGm+mJoOPiBAnJk2zj
 wsYi0FiN65OrJt+oLzhkBj8zvkXQN1v/Vtr7yOyaUkM0uaVRhohH7ksqutFe784H8coGZuqiO9C
 /8Affxfmp0CBX/k9A==
X-Google-Smtp-Source: AGHT+IGVqCIimLoh+jRjdTX6uRMa4MmSjIG2m9h5cE1R7uBxo3qYrpoEVka5R6Z1bQpEbBoJEH+pYx7VwoYJDr8y2Ec=
X-Received: by 2002:a17:902:ecd2:b0:240:bd35:c4ec with SMTP id
 d9443c01a7336-242d38fc0c1mr1021535ad.6.1754682461692; Fri, 08 Aug 2025
 12:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
 <20250806022816.1050823-3-Jesse.Zhang@amd.com>
In-Reply-To: <20250806022816.1050823-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 15:47:30 -0400
X-Gm-Features: Ac12FXwuE1NV3hVeLR-zlQrNjZibQ9ijR3mKMOnNoZsBMyf-ZuM0UO1kl776EKM
Message-ID: <CADnq5_Pi-UD1VgRTKD9f5ZggO-bMLfzaRBbM++F9ZRvJF9vF_g@mail.gmail.com>
Subject: Re: [v7 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
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

On Tue, Aug 5, 2025 at 10:54=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This commit implements the actual MES (Micro Engine Scheduler) suspend
> and resume gang operations for version 12 hardware. Previously these
> functions were just stubs returning success.
>
> v2: Always use AMDGPU_MES_SCHED_PIPE
>

What about the MES implementation for v11?

Alex

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 32 ++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 6b222630f3fa..24c61239b25d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -567,13 +567,41 @@ static int mes_v12_0_unmap_legacy_queue(struct amdg=
pu_mes *mes,
>  static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
>                                   struct mes_suspend_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__SUSPEND mes_suspend_gang_pkt;
> +
> +       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
> +
> +       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
> +       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gan=
gs;
> +       mes_suspend_gang_pkt.gang_context_addr =3D input->gang_context_ad=
dr;
> +       mes_suspend_gang_pkt.suspend_fence_addr =3D input->suspend_fence_=
addr;
> +       mes_suspend_gang_pkt.suspend_fence_value =3D input->suspend_fence=
_value;
> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_S=
CHED_PIPE,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
>                                  struct mes_resume_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__RESUME mes_resume_gang_pkt;
> +
> +       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
> +
> +       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
> +       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
> +       mes_resume_gang_pkt.gang_context_addr =3D input->gang_context_add=
r;
> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_S=
CHED_PIPE,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe=
)
> --
> 2.49.0
>
