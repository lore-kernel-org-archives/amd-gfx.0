Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B1FC3ABC6
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 20:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9047F10E219;
	Thu,  8 May 2025 20:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="drftWKIS";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8097E10E219
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 20:49:49 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-30a892f82b3so180859a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746737389; x=1747342189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3tZ1w/v02KZztYeclZyjATwnRs+Gq32VbLpx+6H5Qs=;
 b=drftWKIStwbAXqH6/jmjgaZdAYZ7Or/TUq1F5y2KCPzROrjVlcRfB8XtMWie0mx2K9
 Tp5zUVNDsuKB11ULl3G4GldQoxo0ZAgmUtP1E8WaEbWsbmyS+tjCcaEvqyvW2LbrPAXs
 2h+OaxL7cjF/TAstmH6KN+9h8b990FxXB7WjXX8c8IVVj/8nuu+addG16HpWA2J99yx0
 igjy2x2R18L5ftDECZtwq+WJYLZilqlBlcz7vqQX/iY4gOZYSGJq9rsi8ikMR8jooaTN
 EPoeqUXRHu9sofO7sdMdp9DDCSwyaVVF4RLlr5OYLgGqE1tx2tspol5lLXbUsvjUQ/a0
 5biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746737389; x=1747342189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3tZ1w/v02KZztYeclZyjATwnRs+Gq32VbLpx+6H5Qs=;
 b=VfcNrNID1OEr51akckZsnoGHppPNaqrN0nOkGdUjPFK8HUvkN7hmtB9Yo7blTtm+Wn
 ASyW4nQDnYhgQ8P1KOJQPzqjXmyN7OkiebkmMCG3lgjWhVE7+gOHdtBV96FQb3zjYZL+
 WI4kiXSuZFjKhQCL1mdivUl159iANf+8doEs1lkE8nc1uNPLxDjZ6mFutpEbB21pFqHq
 izerAbk33d0fZD0GY9azFq9VTVLG8XjYnwEeGWBofmMFD5x7TW15hKTE7XrQUaXIaOdc
 iit7yazng09TOtlsG3LnE3WZ4LZ7q0g4EJnOxY96KLlDIsjjtK6VR+GW2wH3SLL7eZE/
 qqng==
X-Gm-Message-State: AOJu0YwM+KB3a7e5TWdrUXMolbNDVl4cd/Sr1DSU9G56IsLwbpE0Rn1l
 rOjqE68AJhFXTX2jSd6lVmrj1qmYLGwAorQhNEwne3LL/XVLAvPdAk5IhLrRA315/yov4NmgCAY
 yb/QrMP+pO1SHjZ/YOIyCoQbuRieABQ==
X-Gm-Gg: ASbGncsjVbA+QCe7BjLq8w+EcGV3+krJRCNMuAT43IT7JosJg8gYeRffndt85kMXOBv
 g3qTHy5N6qsftNyt0hiVmU+LTosUxV09yzhS5t1De9qUXS0otcoouXLvodoy4G2gf8II5Mm47xD
 tVZW0uzXzEPf7GE5/JivYEe7t7J7tv5CIU
X-Google-Smtp-Source: AGHT+IFDU5FTi3Mwc4UCZYdUYe6AVOO3WwjXPa2YynbJi/MKXlV9IlBVovKWb3e7YDf5F5t9valhClK70Ty5Z7py33E=
X-Received: by 2002:a17:902:e88d:b0:22e:5bdc:fe24 with SMTP id
 d9443c01a7336-22fc894997cmr4829455ad.0.1746737388937; Thu, 08 May 2025
 13:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250507140631.200770-1-alexander.deucher@amd.com>
In-Reply-To: <20250507140631.200770-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 16:49:37 -0400
X-Gm-Features: ATxdqUGy6bu8vM4u_HGBw27_17BEEHg7bCZ3OIJ9x5UgS0KTBI0jiP71b6Y_Z7U
Message-ID: <CADnq5_NmR7TZnMXWCsz_wznTOmW=mLhF2h1itou=SkhX83GMww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: drop warning in event_interrupt_isr_v1*()
To: Alex Deucher <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

Alex

On Wed, May 7, 2025 at 10:07=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Commit ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vmid=
_mgr_init()")
> enables all 16 vmids for MMHUB on GC 10 and newer for KGD since
> there are no KFD resources using MMHUB.  With this change, KFD
> starts seeing MMHUB vmids in it's range with no pasid set.  As
> such there is no need to warn, we can just ignore those interrupts.
>
> Fixes: ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vmid=
_mgr_init()")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_int_process_v10.c
> index 54870b4c50000..3e1ad89747979 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -175,8 +175,7 @@ static bool event_interrupt_isr_v10(struct kfd_node *=
dev,
>                 data[0], data[1], data[2], data[3], data[4], data[5], dat=
a[6],
>                 data[7]);
>
> -       /* If there is no valid PASID, it's likely a bug */
> -       if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt"))
> +       if (pasid =3D=3D 0)
>                 return 0;
>
>         /* Interrupt types we care about: various signals and faults.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_int_process_v11.c
> index eb88ba8d8b012..2788a52714d10 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -287,8 +287,7 @@ static bool event_interrupt_isr_v11(struct kfd_node *=
dev,
>                 data[0], data[1], data[2], data[3], data[4], data[5], dat=
a[6],
>                 data[7]);
>
> -       /* If there is no valid PASID, it's likely a bug */
> -       if (WARN_ONCE(pasid =3D=3D 0, "Bug: No PASID in KFD interrupt"))
> +       if (pasid =3D=3D 0)
>                 return false;
>
>         /* Interrupt types we care about: various signals and faults.
> --
> 2.49.0
>
