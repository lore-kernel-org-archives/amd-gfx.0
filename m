Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8026FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 15:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CD010E08E;
	Fri, 17 Mar 2023 15:21:44 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E022F10E08E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 15:21:42 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id bi17so4018621oib.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679066502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HT4iYM40NJcPq1uRsnJJVTP6isccxNeH3ZrNQ8Prs5Q=;
 b=WAbnTQnAaKf65meKP89dZ3ItSIDlZ8p2kEwlznrakZT+wBli7J4JsuPmpvKPvRIt1v
 hs0cRYH3OcgiL6QfjRSN34wHfc/iuNTjW6Te1LQw3rkYyMYXBwZL8s8wmSwV0u2+wYpx
 4YywMwgmix9ez3lK8lZMkmTycyHBlEHmvA2p/aJo6HwGh/EpDJ8GSDNdDqWp6GwHA/Ut
 DQXD6RX+wqQ8liCDnTQNkq3/QHxT4+3h44vO5Xyh+4MTn1ZuZzS7S9v6+d3qrn801Vl/
 Woht2Vbf6rc3o7PVJiLyRW+Kgc9Xvu10aJS1mQoInCLhDhwFWVqtY5vnz/LfR6q6+G0v
 vedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679066502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HT4iYM40NJcPq1uRsnJJVTP6isccxNeH3ZrNQ8Prs5Q=;
 b=cQ4/DrDPq6wEiPTRri+Wi3DDoW68TIR8TyfXbJjSFqcPPLFFHkMv4jT3jR/RG06CMk
 AKddFEs+5NTI0OIlkhVGuB+OhCguifiDzuQr4f+JBd5m5eQpldRnjvoTDZLrcgpMjrdB
 Namk/yX3V5SHP3EdClJx5HUwKi3l9oZn//5VPgt346gjFcxc/HXMRDS7bhew2/8B2Jpj
 yONUkC5qj/qcq0jPzLkhkUmQ4TuZqmuGr38JUZF/hwH/VpAfm8+AZ2tptJ79TitPz0Id
 9OV5uStVDUqWBx6Y/WwQk/eWM5UUlwBVcnN8mj50q/Q0Kn195y3/jgI87OqYgRzH2KW7
 /qMg==
X-Gm-Message-State: AO0yUKUblN0V1I8KlHIFHMhlepfrETzN17mvjYCjXlx9zXGjjnmw4FLy
 TTBj3BoV5QPAlo4uIIIBaQbrhitpuyggBWzCKLs=
X-Google-Smtp-Source: AK7set9Rm+T9CngH9ERXPlmqeW9xJUHcFyS6Xhw1U1vQiZDt1E/Lz/TB/bVx31XCw9X7d4UE75sJLske9NHA47L8ZAw=
X-Received: by 2002:a05:6808:9aa:b0:386:8b4f:fe99 with SMTP id
 e10-20020a05680809aa00b003868b4ffe99mr2852892oig.3.1679066502057; Fri, 17 Mar
 2023 08:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230316083626.248647-1-Bill.Liu@amd.com>
In-Reply-To: <20230316083626.248647-1-Bill.Liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Mar 2023 11:21:30 -0400
Message-ID: <CADnq5_PFEOJdAXh7QSQ88LJvfe+PQ_Mn2NrbEN=LDkCLAq4Bzg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adding CAP firmware initialization
To: Bill Liu <Bill.Liu@amd.com>
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
Cc: Alexander.Deucher@amd.com, Horace.Chen@amd.com, haijun.chang@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 16, 2023 at 4:36=E2=80=AFAM Bill Liu <Bill.Liu@amd.com> wrote:
>
> Added CAP firmware initialization for PSP v13.0.10 under psp_init_sriov_m=
icrocode
>
> Signed-off-by: Bill Liu <Bill.Liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 02f948adae72..0b9e99c35a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -148,6 +148,7 @@ static int psp_init_sriov_microcode(struct psp_contex=
t *psp)
>                 break;
>         case IP_VERSION(13, 0, 10):
>                 adev->virt.autoload_ucode_id =3D AMDGPU_UCODE_ID_CP_MES1_=
DATA;
> +               ret =3D psp_init_cap_microcode(psp, ucode_prefix);
>                 break;
>         default:
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index 380b89114341..b59c92037375 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -669,6 +669,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID uc=
ode_id)
>                 return "VCN1_RAM";
>         case AMDGPU_UCODE_ID_DMCUB:
>                 return "DMCUB";
> +       case AMDGPU_UCODE_ID_CAP:
> +               return "CAP";
>         default:
>                 return "UNKNOWN UCODE";
>         }
> --
> 2.34.1
>
