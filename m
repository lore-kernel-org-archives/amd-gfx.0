Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6FCD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 17:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191A710E524;
	Thu, 14 May 2026 17:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ndb9J5KK";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0416210E4E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 17:19:29 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1325d6391a1so535249c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 10:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778779168; cv=none;
 d=google.com; s=arc-20240605;
 b=N6qtlYTGMcXZ9QQbFpDQLudvcarwE0XzJKK8UX4cdEG/s5SeqXXLnj42ROd7QCne8q
 0s8GWV35Bezfqz6lgPldKSEKt8ySvqueqaJPcLJbVkVSznX7ph0Zh0yEYteQOCRaVSvu
 i22zTRcQ4sEjLZYSm9xxpHcO0UfJslY50CMpqhwyha7/PdvdCoUnwyzqT+GCe8SlVlTz
 7p3HJ36BKhnf3cgeGwPA5GxHk2HXVJWiyX3MXZDUpH0SY3gF6YoWCeASFH/lkKdptFE0
 0+0SSed3AEnX7Np/OIvffgmhWu5GvWrMMBVQfeN044DVuTLczS6YEAYr8Qr8dIgc2IEz
 HBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+kgt6VghtXyCeOewAd2bBhxKrJ5EeB0MoPNkdQdR5b0=;
 fh=iN9eGREI21RO0V3tpbLKpeiyiCdirXoitc+kEPiEkys=;
 b=jgQUBdJnJ4uWo2Acz2xKfCHSMznMiQjACfGOeahOI71Aa1ZKfC+nGREnL6wyApydxt
 3YiuWgmqlfGyouAZRvTcHgGKs6GtDhk7RWpz6I3y9zmpOfhrIIzFTXtlRBOCmGgYaphd
 l0hZzfHJ7c+Vcmpql75c8h090NTTH+DXsP8Cs/qsPzoUMfuOFNAh35qrGIAKBXJDs1XX
 sZd8xIgrS7mWaZATIXTdzau2O7UkTA/GPmPBBVUCTEV4ZAOtboO0jJr8msq4xYUQQOaR
 1EujCiVdTlSPypIDi9jvGVhzDFtzUsH8s/+EN0lB9bLVWlmqcZKcXFpd4B6o353AgHcM
 xwsQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778779168; x=1779383968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kgt6VghtXyCeOewAd2bBhxKrJ5EeB0MoPNkdQdR5b0=;
 b=Ndb9J5KKqcBaOk4YLclWTT5qCrO8Qr+UYwAHhGOeddIDFdnQGSiDKcxoF5r+C5XiwN
 ESyvZ4iT4fZKoJKQ6XjUNK/WXbTwTf5gH7yPAWkC8nlBssC3B7rXiI5e29CIdgVWmPj+
 OSu9J3+Igk9tig0IIPhM/2zMEeXkDyy/e7rJHKpDMnTnG3zS/uDNzIA0KNCtF4OdmD9g
 cIRgPOPj3EPVT0xxbooytCeweFFWOJPPjwbvO5bvFJa9jg3RUW87C0US50uk0S+hhD6w
 qlBE/yiJP+PvFJXII7kcuMyFnh1o4g6z+uKLOFc44aJp0bzjA9qbXe6bXwSBsStlePly
 PvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779168; x=1779383968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kgt6VghtXyCeOewAd2bBhxKrJ5EeB0MoPNkdQdR5b0=;
 b=qmSDJicoVL7S+lez5rxVor2Dmnfw2IqFwGOrxjeW1QxHJ4+nhuSHAdYtxqop+ccMB3
 5OWFfV9mysZQy8QpeIr4ViW3qAY34Nl5wccU7Zf4bJxq1DAKQglMNbOta/f7+wnnS6sy
 jo15VZPqc3eS1eZPF0GSFOm0sWVxt9ez+D7168kuu0wceOeimtD3SUL1CzDrfTPClS1a
 VeNO/AtLmWuN4qWfP314vWSQNysxWgOcrwNfVqbSzEycollgWZ3d1JJkd9eQyHFivUuL
 imUMOnK7CzjeA67c1p3HhzfguzBoqleYDqMbiwR/7IcFdAadxsB0eytliqqM0xN+15IB
 BAaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oGZCA0I97s+FtEWsNJ/bkQWzhbzaIeuvaT2J8+geL772+cVubTqCJSvvrUOrarqHsVxAZGZSC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLme1zWAydsDNDw7U7WZj6OZZqovJGLGioQOnBcQLuW1lIycfm
 AWKKYIniYCH3cRiUD0woL2A3Vit6qeRSkhef7SflVTw9ijPZukk/JQZOOWYsWkeeOU2PW3NMttU
 ql5t8yi/wrKxiE+hlHIvgABVphDiCUbM=
X-Gm-Gg: Acq92OHAtDhS47JvXynxwe5FjJUfen2wF8W/W9oWLvuVG/i7q63YrMYGwo1BTvHf5sK
 S03QPHS28q/+e+g9Rujr4SlBl4pOmEv71fYbEvdLbsFNgWO1GOc9t+2bly5AV3Xw3nPuznYQ0EU
 AL2vYqzQhFs0Kr4sYHYiQsAkzmIBpgaYpXhUXokA0Tk+NNRNI17Y8EBAvZqd//o2W6xQr9YZF94
 eNl9vhGmL70qD+YO0iAihaTs90rJdPDZcUKBgh7ZJBGap2k4IFyPQKT5bxTOTZx17iHbj9VkvPi
 O+xZIu9taS52WQW37dnZpp14Bu86qFL+h1+LEYOGaCcYcQuCgaIJ6IupJ9xS8BEvX0AR6Q==
X-Received: by 2002:a05:7022:60a9:b0:130:8ed9:203e with SMTP id
 a92af1059eb24-13503fe8579mr18309c88.0.1778779168197; Thu, 14 May 2026
 10:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260514170139.335618-1-alex.hung@amd.com>
In-Reply-To: <20260514170139.335618-1-alex.hung@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 May 2026 13:19:15 -0400
X-Gm-Features: AVHnY4J4r3RZAvJcrVS79xkNwSaEe7tXxUwqGyTSplDANI65OpLuqquJItPOrTg
Message-ID: <CADnq5_MZ=S-b3smHdHA_0_+hZq92Y66oKO=KCfzoG79F_fardA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix UML build guards for x86_64-only code
To: Alex Hung <alex.hung@amd.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
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

On Thu, May 14, 2026 at 1:03=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrote=
:
>
> cpu_data().topo.apicid and kfd_fill_iolink_info_for_cpu() rely on
> x86-specific structs not present on UML. The kfd_topology.c and
> kfd_crat.c were guarded by CONFIG_X86_64 alone, causing build
> failures when CONFIG_DRM_AMDGPU is selected on UML.
>
> Update guards to '#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)'
> to ensure x86_64-only paths are excluded on UML builds.
>
> Fixes: e6b71bcdc409 ("drm/amdgpu: Remove UML build exclusion from Kconfig=
")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605140506.TI8zPIBG-lkp@i=
ntel.com/
> Cc: Harry Wentland <harry.wentland@amd.com>
> Assisted-by: Copilot:Claude-Sonnet-4.6
> Signed-off-by: Alex Hung <alex.hung@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 6 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index a1087c13f241..cf7b1b038d5f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1821,7 +1821,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_=
id, int *avail_size,
>         return 0;
>  }
>
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>  static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_siz=
e,
>                                 uint32_t *num_entries,
>                                 struct crat_subtype_iolink *sub_type_hdr)
> @@ -1880,7 +1880,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_i=
mage, size_t *size)
>         struct crat_subtype_generic *sub_type_hdr;
>         int avail_size =3D *size;
>         int numa_node_id;
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>         uint32_t entries =3D 0;
>  #endif
>         int ret =3D 0;
> @@ -1945,7 +1945,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_i=
mage, size_t *size)
>                         sub_type_hdr->length);
>
>                 /* Fill in Subtype: IO Link */
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>                 ret =3D kfd_fill_iolink_info_for_cpu(numa_node_id, &avail=
_size,
>                                 &entries,
>                                 (struct crat_subtype_iolink *)sub_type_hd=
r);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 46db0d65d242..87e13f021457 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2349,7 +2349,7 @@ static int kfd_cpumask_to_apic_id(const struct cpum=
ask *cpumask)
>         first_cpu_of_numa_node =3D cpumask_first(cpumask);
>         if (first_cpu_of_numa_node >=3D nr_cpu_ids)
>                 return -1;
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>         return cpu_data(first_cpu_of_numa_node).topo.apicid;
>  #else
>         return first_cpu_of_numa_node;
> --
> 2.43.0
>
