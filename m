Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7570EE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2736310E726;
	Tue,  7 Jan 2025 15:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKEX5K1w";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB86B10E726
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:51:45 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-216325f516fso23545195ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2025 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736265045; x=1736869845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AInTbU+Vlp3N8mfzPrdYC59na1FEoFojJntCH6//oUM=;
 b=WKEX5K1w9culVLJLJJzAQn0T52w6M/CSS8LmXkfFksSlUSbpizaj7R0gypbj2Gyd4Y
 J266vHwPFkUfZ3mS8roeWdMyCX9ItcHmMpUM38cK+kH15bS/sab42r2BFgU2hAW5yIyU
 DGzfdTUgmOA/5gPofgKyGChWEXscNxm6qrzCFwBbQ3hb2qPF6ErWhS+6CLCVGToy0cp4
 FBoZwcHHh0eE+CIj9tWvhb1FDMzHKQrH6QCL7bx9zfQGRoqigExzyNWyo6VwJJ7jKQVf
 BW+RbtPLR/1i0m6vVXAIbZChi5M53xsUXg/1EDQK2FgATJrZefefnNjhuH1GkqCunp2n
 J57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736265045; x=1736869845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AInTbU+Vlp3N8mfzPrdYC59na1FEoFojJntCH6//oUM=;
 b=v5x3iCpPHlgJRuHHMLUouzOpQ5ZTq9bUv6AuEaKldaN0nxMllhLeODl6qcNRpNBQsT
 jtnLomnBti3XRzuAsfmQsemZa1rFD/afX9RQ388p8VqktFSOxhMHsvMT0HgXjOedOV3z
 Y07p7pZzJenjhIzPUAlImhyIFBQbZkFlBZX5Fxy6tHPxm3u0F4DaYo6TMbCNoU3aM/hT
 0BXEHf8LiL98P0IQF7Nranhsjr6deWswjbsiXmplgZGS6MeTxYlZG572HNvKzmG7OXl4
 m6CkDjRvMkuBj6BQ7uocv+3XKCB0TxaDdBnwqGPHJje66m8qP2YVP/i37wma5mQ1NBJy
 D4hg==
X-Gm-Message-State: AOJu0Yz1bC7y785sHVnRtVnxDDp/uVUm3J8qUiJWK6a4O1A7/EVS8aUj
 g8ObCxYX3i6VHzqmpNr3lgpqmflAzIzBHtSRzYb2srio+wNRsQGWvYE3SMNXroGqZBnJacbzqwd
 5BKYZCUDjtoflNjjjsqCAUTJz2+Sos0Ry
X-Gm-Gg: ASbGncueY3AK9cg+fNU4dH8JLz8nKhaJoWOK8buGNfdENr5kYldqgdhDx44dVR8EsO5
 OfDJnT9nnNDP5srIb3Kb/UBIm3BrlYe5UOeihLQ==
X-Google-Smtp-Source: AGHT+IGkCGzIJTTg1H5VBHEB8RNIZON4pzR+jdNYK4AuBHam0CH/eS39NkvHrsj/OaqjF4qOiGmHJ6GqzK7ZjPHokd8=
X-Received: by 2002:a17:90a:d60d:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2f452dec107mr34852988a91.1.1736264547935; Tue, 07 Jan 2025
 07:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20250106105228.2121987-1-Victor.Zhao@amd.com>
In-Reply-To: <20250106105228.2121987-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jan 2025 10:42:16 -0500
Message-ID: <CADnq5_MWWkp29C3Nii6P95BQHfJG7ZWatxL=s4TWT2V96KvVsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fill the ucode bo during psp resume for SRIOV
To: Victor Zhao <Victor.Zhao@amd.com>
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

On Mon, Jan 6, 2025 at 6:12=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> wr=
ote:
>
> refill the ucode bo during psp resume for SRIOV, otherwise ucode load
> will fail after VM hibernation and fb clean.

Please drop the comment above amdgpu_ucode_init_bo() in psp_hw_init()
since it is no longer true.  WIth that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 010c038b33ab..97fdd93c3ae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3148,6 +3148,10 @@ static int psp_resume(struct amdgpu_ip_block *ip_b=
lock)
>
>         mutex_lock(&adev->firmware.mutex);
>
> +       ret =3D amdgpu_ucode_init_bo(adev);
> +       if (ret)
> +               goto failed;
> +
>         ret =3D psp_hw_start(psp);
>         if (ret)
>                 goto failed;
> --
> 2.34.1
>
