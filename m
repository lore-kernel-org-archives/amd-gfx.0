Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09822E9410E
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 05:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777B010E7FC;
	Tue, 30 Dec 2025 05:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jqtDueki";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9FA10E7FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Dec 2025 05:08:05 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2a0abca9769so18860325ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 21:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767071285; x=1767676085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVXZvP7wR0+jAtzDVN9MnVfdNwk9ABAHUupRX5jV9zk=;
 b=jqtDuekiVVBT4m9tynLMqrVK33x69BF3vyQ8IO6EHJ1aeSVKN6scecbMyTPSl6NL1t
 JgwZScMrSHt6O6m6nklzHcH5L76MC34VQ2Z/B1NbfEpUkwQmZ14RGspRvk/ExCcoCfyp
 bk1ePM8mAQ1YuhDuQrI0GHuT4ojGPZ9QT5RMrPZvZxIwiKS9GJ1h44riM2Difz34aAhq
 57deussu3JhcQF3NwyB3dZmmQ50o6TGIuL8FoYVSCzZPpMFXTeuACAcvrzNHanJ/L85t
 Yonqjckm0rnQB2XPT7crxIGL1lSilmptLDfYqEFAIxNPHlEPvgpfFz9p9L63WsZMuMQz
 plrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767071285; x=1767676085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZVXZvP7wR0+jAtzDVN9MnVfdNwk9ABAHUupRX5jV9zk=;
 b=XUYSxy5M9XxRt5ftmi7bdENqPG+qq57gu/PQEo7NE6vybya2XTPw5midD6IpalHAZe
 Y/Cxf6hFqiz4SvfypmZBtZnv9TztCu/A854sEECpcR6KV5hT14nEGaYoflbcXyJ1dTp3
 7X2pVfEHUZ1F3LpPgGQAGc0z9gKN+BVW+uQNJHpoXQwQS6eSbCNcz0yJ4zHayNu98hHK
 kCfSbaUEtWkUKBznr8wpVKRTkK/pIpDp/YnH7cA0ETFusQhQZ3YRH/vMfuttHebuBroP
 xIsGBKnHtSvwx8O5EZeqAGWCm+14aIDFK5uStxf2L+av9m3z/7P25CKNzq4o49+zeG8W
 iV5A==
X-Gm-Message-State: AOJu0YzfNeeo7TjcESx4PeA9qjBhj2rhWCKw0yhSVwh3ho4CebSk4mxN
 oTQHiu5VvPyJ/Bk4DJgAuA2M95QcZ5LIvRgvonj6oNlh4fuvovfONB2TJYdYJbBiOpsV89++/fn
 qBK4Xgsk30Yy/CbauAP7v39HXL5Iff58=
X-Gm-Gg: AY/fxX5peHruH9cIGD+xpTgVv+2sxkV4yYFxbGPpPOF5fAuAaQ/Fxr6uMEPfln+eNwL
 htrsOlRLm5+oH8aR+H3lKD2BBJEdVdRRn2D5aaKoJ6HZmEvMzN9ZBF6WmB7Gua6rB7poZy3n/om
 qpSSAQuzI8xhAlBmFCGiB7YEAOGYfvZrsb8FMFK2H9uNs3j5vL6TBdN+kW/RmVTf/q/XyEkyZyN
 PTrChH+HrUo4m9gBJ2gvAWImj/sLKkLqOFmVgUXE56jV5lg4PC7ATmaGli3w9m2jcjiORiI
X-Google-Smtp-Source: AGHT+IEZpexZKWqA5zelMiQV4kwozk59JrDxjy+jNoaZWCQ95aXyKGm0O/hL4VfrNNIn27sVhCNN+jwa5fiPjmnzDMI=
X-Received: by 2002:a05:7022:4298:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121723088c9mr17079247c88.6.1767071284860; Mon, 29 Dec 2025
 21:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
In-Reply-To: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Dec 2025 00:07:53 -0500
X-Gm-Features: AQt7F2q9FvDUah_4oLzaYBSN98DvaS0fIy_5tjyb7JRoVj4npL1f9okkTpvjAuU
Message-ID: <CADnq5_OC2OW9rgrVTgfZKGkY3FokT_-v34sbPj_DNEsaH=D-Lg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: change the timeout for user queue
 fence waiting
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

On Mon, Dec 29, 2025 at 4:56=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> In certain error scenarios (e.g., malformed commands), a fence may never =
become signaled, causing the kernel to hang indefinitely when waiting with =
MAX_SCHEDULE_TIMEOUT.
> To prevent such hangs and ensure system responsiveness, replace the indef=
inite timeout with a reasonable 2-second limit.
>
> This ensures that even if a fence never signals, the wait will time out a=
nd appropriate error handling can take place,
> rather than stalling the driver indefinitely.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 98110f543307..c28332f98aad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -371,7 +371,7 @@ static int amdgpu_userq_wait_for_last_fence(struct am=
dgpu_usermode_queue *queue)
>         int ret =3D 0;
>
>         if (f && !dma_fence_is_signaled(f)) {
> -               ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIME=
OUT);
> +               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
2000));

use adev->gfx_timeout to be consistent with kernel queues.  You could
even make it per queue type (adev->gfx_timeout vs
adev->compute_timeout vs adev->sdma_timeout).

Alex

>                 if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> --
> 2.49.0
>
