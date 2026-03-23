Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FC7F483E5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF4910E498;
	Mon, 23 Mar 2026 19:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tBEKsSr+";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B6310E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:11:37 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-128bae6a35aso292087c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293097; cv=none;
 d=google.com; s=arc-20240605;
 b=ZDYu5IQhgdKjSJ8T18WkwYRkvj2J+Ra88scwGwvSmr82W/eBzMX3JzDvPCrrXtrd82
 HiCl7vSctF9uFuniBn3Byyob70I2bs8els7uFT57ejFNbe+P0Swm5o/DuwSi29jKbecG
 snE1qw9LQlsdhkI17nnrOPITCm1rRlO26PeeuuGZTTIbH0oNOM4QAMGbXPBnYrOmkA/D
 AA7Bwqcl+60L0/qpG6bAIJYIRPM3D7M8vKbSqzu9qCZ7h3Leg6dM6X1lbOn27rm3oeh8
 Q5qvywYKAi8PBjs8NG7ttmmcQBPa94MThQiVTPJHTNqzcSkHb4q59qHNNVm5EZU5y790
 AMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t1YZQ8usqlKO96YJKshFlmer+T40bhC6JQAn383HrzM=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=Pb385VewCpofmkz1oL/2r9YQCtvVQVHxasrZkSzQlYbMygXIvZmW46ZtgfSTNCyUZO
 ZjyTzlZul891tmN8WUKGXfUvWI5qukwayFi85rjTi8ngyd8E5qlttYCJa026uB9t5I18
 ZBPyC00gaUNw9xKwH07kyWGqLWXv3u4krY57JJsy1tBdoaB6CCkp+Io8Kl2p0EjwUgC3
 9UYs6LwSznTwO6cwqsjLCblmmHrpZ0h4UEygijLE1q3gLWHgW3QgIof1a7/nV8ddD7Iu
 oDybOET9mSLu8cEZ8DbJn/GhHKXt895b5yWpmFWjlErRJt5xaYCkwWPFiBlpkQw5+tp9
 RYog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293097; x=1774897897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1YZQ8usqlKO96YJKshFlmer+T40bhC6JQAn383HrzM=;
 b=tBEKsSr+wgpLpseP6uzlLDdAWjZngOh+N/weLSOzWj7IKiw7C5rAjblYAxgoovBrED
 27D/j3/Bz3f7+0EdgB6Jfu7bku/7K51CstHeT6fHGZFT+DjW8krP/ZAbSDfgy0ndSdtQ
 SHntYLZqf4q+SxO694WUuHEsKPO4W8dPqt7JKPYJD2mIhYojw5iEvzFC9HAiPZ7zMGSv
 19LL05k0yjWO+2kV9FmptdsKoqR3BWM/hLolfBKgvNPtrXD8+WKLsmLYtqr/sAfh/rut
 TymodNEG5wq0FrMuevBl+qg1vGv9o7D7K1/hBe97f6L1gdBzqtoe9RreGy+L2yCaN7Kb
 SqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293097; x=1774897897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1YZQ8usqlKO96YJKshFlmer+T40bhC6JQAn383HrzM=;
 b=muGBkaMl17KxztkMPS86eQmoMt8iJ/5D0LEN9fnpBLjdcEXwJPWfsNTlzIOHNUN831
 yhpjkl6DBFbeRfd6gUdO2oDU5J6uGfUgiai2plb5HRm8PHUG9cOsrm5GbWD3iADhPL0C
 AiejhlULEd1vgulWi/IAkAo/kK6yfXcSRQUTkrMGdHftRnNLQsLgtdSa1A48ECN2atTs
 RnOKCIzTlV7Tfw70fBJk6Dr9OTsTCyUUHevbWIYsLdbhLmvY09pxfgtYsYgHndn4/qC7
 6hoP1y00aqxGWWgqqWo0CAtSbibioE8/Oe7fbN7JvZSb8DTZN3jHSe8xDV/1f0j6ZkuW
 B9VQ==
X-Gm-Message-State: AOJu0YxR92gwPTcP9sv8Q40j4ymXqL+PhY8O5OAEJlFVV0Yjqi6VJ+eA
 YQc4FeRGX2/CmK6RIftrGxexBERl+9J/1kBb8IG/No+GD7JjZJoQ5ulvvh1zWYad9f3Vt2vIScP
 8yuO9aDe1xDVSDc/Wjw3QvnD/5OaFvjo=
X-Gm-Gg: ATEYQzyEVfL0rPnmC1UymRppSFcPkFPJBcWnAKDjksQYsl7+VJQU43Pk5bjoqVxM63R
 BAKQSH3d/NjHX9bPHcz+1Zm1msIzsmldro8Ey7g2Ru9FX8E/l86yClFNu51TNVVsqE/Jv5Dl4tr
 1w6LS9j2SVMFeYFpYnVutmS0rUXiCC84yRxBg4Pvx/t9EEmTtPBtU9Jgs3i87+XgVZzqDrlSsAM
 5XIz0LpN6a3ME7JJ4qj+2fDOLk1B0hWRfgAca4UCMOcpBVMaWEQ7O6J8VcppEORTR+uqBAFIQaD
 ktE/MhBj37Oftejmk+nEmxYdE8CLMyL8o0+SCikWB4Vh+SsmXI723RZWz06pW3BY8WvZ0w==
X-Received: by 2002:a05:7022:699b:b0:12a:716c:d27c with SMTP id
 a92af1059eb24-12a726569ecmr2892746c88.2.1774293097106; Mon, 23 Mar 2026
 12:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-7-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-7-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:11:25 -0400
X-Gm-Features: AaiRm53RUKMPlsHvqFCtErg8rO9y3s9bDnYh5CLko_uaz5cnvyXOhwVe6KWNnQo
Message-ID: <CADnq5_O+cxvEtPvq7ig5UuCKSPryQxiRTA-JjFXpTe4d22obRQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/amdgpu: Enable suspend/resume gang in mes 12.1
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Fri, Mar 20, 2026 at 4:02=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> This patch adds code to mes_v12_1_suspend_gang and mes_v12_1_resume_gang.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 34 ++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 4b279259b9d3..7aea3a50e712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -468,13 +468,43 @@ static int mes_v12_1_unmap_legacy_queue(struct amdg=
pu_mes *mes,
>  static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
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
> +       /* Suspend gang is handled by master MES */
> +       return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_i=
d, AMDGPU_MES_SCHED_PIPE,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v12_1_resume_gang(struct amdgpu_mes *mes,
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
> +       /* Resume gang is handled by master MES */
> +       return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_i=
d, AMDGPU_MES_SCHED_PIPE,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
> --
> 2.43.0
>
