Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52856EC112B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 20:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D1010E452;
	Mon, 23 Feb 2026 20:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cqCJ698k";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A02710E452
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 20:42:46 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-124a5810e41so264295c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771879366; cv=none;
 d=google.com; s=arc-20240605;
 b=UDWE8RvLDEJ8wi5+0zBhtyugaF60jxlzqFwKD7R8vqav7luKGslJt9eiyYU6+OPCyH
 Yo63+JFL0YTQ+TFnQ2s9XIkVn4ar4SJ5pPQ270PBIKPfpf224xjeomkWEip32g3sHlOP
 7UCbzZMYc3ge3mVBQZQJY9tj8IAaBykdThuAeRmRWLlxKxsErCIM5sXX9/1ca2oI53MX
 T8qVLUtCp1pfTywlYsw7IEmGXlsvFbNTVF9ux08MtC4i/48LVh+psfOkMBADoYFhROMb
 bHIpV28f2WAb/IsBE96aARCm7hje8kbYMUg9jsjU5wQGqqFK8TR9IUmA+RLnMSHg36oA
 I5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JuxvsCsqAJ9PZBuKvZOdeSJJhG/MLz1gUHP+VaSCF0I=;
 fh=Exan7H5iQkhRLGXT502uGSAY1ZEvISL2jrKKV4vtSUs=;
 b=DenJNXr2uV9dU8EiDcku6aikRv6Pw2K50NJrDlEAVaz+5NzSJkWOe0NKy0f3EO1Yqa
 YcyP2BQM80EeFIu5KXQms9DsUYt6fib1GkzdL6cyTauegfH8OD7p7n7lMVeumcc0rYaz
 2dvw1VcZMjLyGTzsHVHM1ANFeC31q1mA8i0IpDMQJGUP2aoGE2V0oKoVkeKLz9Pve9hy
 tuMkJqhE/U8NNvnpVAoAxinQc7yYEhXrPOBOEKbamtfhLtyXywvfYz2IGJN0CNGywg9C
 Gs7aaQ/Pla0WjnOXWGi56Z/1JAFvuz4+h8zfMzHgbibFuPPxSoapnED8gb+nDyYiu0N0
 J5kg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771879366; x=1772484166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuxvsCsqAJ9PZBuKvZOdeSJJhG/MLz1gUHP+VaSCF0I=;
 b=cqCJ698kOJydDSqf2HQSZaIv19Gld2uhkUU4eAriDjOtzZk2zBtGREbuCN9c+Fv10V
 b/BlTCEOdQ+AErGpcPiNvLJXdO5SZzYIZBcU6Msu0ck4zLT4XzDCpDDsTBEivMhVeISn
 1Ejm+w77QkSYeG8FWscxMlMFTt/ociIwQectm8Y5hh6BxexwhoERHynh8VGj74B0zJV7
 oABc49tr/Ppvh87ArrQkYKRI4etGu2IAtrzZePT3DpPa6N4aUepp3jkE9EhTg7jDf7+T
 H/Dg11j0fQrr+3dPH3XJdVFaHHlLVILsaYc0bAL8abvd9tDHkRUgrL1UTJU0fJy3QEhd
 NFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771879366; x=1772484166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JuxvsCsqAJ9PZBuKvZOdeSJJhG/MLz1gUHP+VaSCF0I=;
 b=BrULf7HGtKTH5kMOo+ilYA/Fj08k5lQvhOphJbeZnN6SkHkiTOfl5Ma2bGt+b/j23w
 Gd1UneRvT+6d1KCM8LIo/cSAUDWITQjH7lmr9FxsBrOnQahu+qou0jRZFoclZXjXJLGN
 OAQAvlnA1EdpxGwbcH99WHBm9ZskjW9NhGEyhSXtDrgfM2sFOLxvMvy4jhmlfKF1NpnI
 k1gVqYGsJcGsZWRF0laBg7znfUixDkL0db52UXGxvJhA5sBRCxabu7vDwMOE6Sa8M+Vs
 PihqxfX32giJUEZPM3zbXShJve/JBSQ0zFWYr2IVgYGi5Tlfey4XkX6NhIKI8X+06SVf
 J8kg==
X-Gm-Message-State: AOJu0YymhGdwvidYbw0tM6y0zhwZxiyqy9OWB7DV/hD777upCUjS87yi
 RDihItJbc8wqbyuC9SbW6paqkAf1YjCP0AMiOM5d9KwhBLP9/4n66POMwa/ym+FJEzNE2cD1CVY
 BnfCLXysfaQBEN+IQd2q4NHWrydVOXJo=
X-Gm-Gg: AZuq6aIH7PqVVglig/joMtcnQhN7U1FzrZh4ucYG/zTVwK3S46izGjes9I1PCV+c+mg
 Twub0Ef7yY7Az5aKEGvFIaLHBX5XiTdhRTxo6BqCD/HLHJ56wCr9qIAv/F80h1jHZL8lC0RcINu
 Z4KtDeDQiCs/fvNTtaSr6FRukA/de+bkEPgS+BAh8+M4ZkEqPDv0jF/Lx2I43jHbbO65/21gKFk
 6PCLmEqNTHNtNfIs3Ry3to7bjECi5DsLq98eCX9ocVNYr4FYTP7EDXH6AcdpaDlaJU+8d0dlwpS
 /Lj7vy3ZWRKqYAOA6UUikbhXx08UHyitngKOMGVvlT6R2bdlnJNF0ACjR0TsShcN5qN41Q==
X-Received: by 2002:a05:7022:2589:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-1276ad03aa3mr1912301c88.3.1771879365496; Mon, 23 Feb 2026
 12:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20260223201945.58052-1-andrew.martin@amd.com>
In-Reply-To: <20260223201945.58052-1-andrew.martin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Feb 2026 15:42:34 -0500
X-Gm-Features: AaiRm53LolYGqxUQUEdiJ2u8BA54viVpU_7zVI7p0W0aSXC2pRR9pWWfbCwjm5w
Message-ID: <CADnq5_M6g=sK4VBanvRp772fyhyGrZa88agUxrLgYD3KPvWpAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Removed commented line for MQD queue priority
To: Andrew Martin <andrew.martin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Mon, Feb 23, 2026 at 3:39=E2=80=AFPM Andrew Martin <andrew.martin@amd.co=
m> wrote:
>
> Missed deleting the commented line in the original patch.
>
> Fixes:3e95063383f5 ("drm/amdkfd: Disable MQD queue priority")

This should be rebased on top of a tree which contains the original
patch. I.e., the patch should look like:
-       /* m->cp_hqd_queue_priority =3D q->priority; */

With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   | 1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 1 -
>  7 files changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 90ac3a30e81d..14123c5d4925 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -70,7 +70,6 @@ static void update_cu_mask(struct mqd_manager *mm, void=
 *mqd,
>  static void set_priority(struct cik_mqd *m, struct queue_properties *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 97055f808d4a..0f7688a1f8b1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -70,7 +70,6 @@ static void update_cu_mask(struct mqd_manager *mm, void=
 *mqd,
>  static void set_priority(struct v10_compute_mqd *m, struct queue_propert=
ies *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 7e5a7ab6d0c0..d8f565cb2180 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -96,7 +96,6 @@ static void update_cu_mask(struct mqd_manager *mm, void=
 *mqd,
>  static void set_priority(struct v11_compute_mqd *m, struct queue_propert=
ies *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index a51f217329db..db615b42b25c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -77,7 +77,6 @@ static void update_cu_mask(struct mqd_manager *mm, void=
 *mqd,
>  static void set_priority(struct v12_compute_mqd *m, struct queue_propert=
ies *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index d0776ba2cc99..6e591103c3b6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -131,7 +131,6 @@ static void update_cu_mask(struct mqd_manager *mm, vo=
id *mqd,
>  static void set_priority(struct v12_1_compute_mqd *m, struct queue_prope=
rties *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..ad0dcaed3d35 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -106,7 +106,6 @@ static void update_cu_mask(struct mqd_manager *mm, vo=
id *mqd,
>  static void set_priority(struct v9_mqd *m, struct queue_properties *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static bool mqd_on_vram(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 09483f0862d4..c192c66a5c7b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -73,7 +73,6 @@ static void update_cu_mask(struct mqd_manager *mm, void=
 *mqd,
>  static void set_priority(struct vi_mqd *m, struct queue_properties *q)
>  {
>         m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -       m->cp_hqd_queue_priority =3D q->priority;
>  }
>
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
> --
> 2.43.0
>
