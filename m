Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B9CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 13:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4703A10E1E4;
	Mon, 18 Aug 2025 13:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q6gVdMhH";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5136710E1E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 13:50:00 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-24498e93b8fso509905ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755525000; x=1756129800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AE1OPl3TGCMs8hkf4vMAiAixwit+wIqpfDHMziFqg4E=;
 b=Q6gVdMhHu5FmkVgiAVLEsPhhrU30+BqGJfIKGna9rRlepU0LyF6wwREkVjRaHLAWKE
 x0l1UAk6GAdxvyJYfKdvUo35512LPH02mfKVP8yqSNLcPWToNuDt+aU9xvEUE2xcwSzK
 gBR9HMOH0ubaZszFWxTD4nSZZn9f1DJCgjU1td3dsdIZcpPiif386+SbneBhjDxMSRA2
 jRvsXs0zp2wkR8Uy4vQWLJUzP5C1KTUJGFUhgYCrfkjc+saJ4BE5KT4TpviUgByvURGO
 F0P/ujUUyC6z/wofxGBP+0YbRlK8VN05Shff8QvyPJRHKOXkpOtA1qUqwBlDRBZ8pG2S
 vPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755525000; x=1756129800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AE1OPl3TGCMs8hkf4vMAiAixwit+wIqpfDHMziFqg4E=;
 b=v5GlYE9slknglj1SgbjzHEwiUBkbnIvqgJLPAezlSaXQ4mneHw93/hGbs/dsPz97tf
 hwLHiWYAc7Shvol9lAftptTESp9w1XZvKbuNBS0G/gyofxrvz2fk+AE6dC5jmQaDWBXE
 aj3d5DpS0lxRLEo5xV3AV5R3cAoA0udIGi6ZL6NagTJjy6T5xaqwAfGvTXhsOq3P2CWp
 Vmdj1olxoYNpA7Yf0mhCutW+fhLyWiSEcC7jmyw37cHbu3Tmzji6lz3/1lnyFwiA/lsP
 3xuMUFHa0Ev+vF6QL7WwHHrOqnYYDbR2aQEdLbgXM7HzJ4eFCYYD7BK2VfrvoM0d/Uis
 fKmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcTBpGcx6DI8Z/Xvhhcz+6v7hsR0sOA+lo1Yjq6UYvS/1LZcUuBRMXvpPqQOGBfWMgpO9B+K56@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8yJ/i8UUjh7gdFFGyxT0yUOdTPBQVc59S60Z/yN5UGvWFQWbj
 /4AVXyaVotGWzdVYhCU6C4b881Mz/gsag4lAAjC5wai4Bzd0N5Cdm77P2J+Es/7C/lPC46RPdYI
 BtxmcOwBbGEBWKLpbkH8mqpYPhp1nDFOKFQ==
X-Gm-Gg: ASbGncu6KheYarNxZ42CyMz/VRGN5Othnhs0w7vDfa70i1GSYjQdVIOP0hEAO3nEj6A
 3/OkrVyjeShmkRa3rcGACOiS3mY/HtDf7CAaElcjuAxfyPp0mSXyBJAysG2A1deeBub8BWAcozQ
 4c0lIwWhAPO6N/3d+ft7J+5q2svf3dISzBjtGC3xhBD8a67qI0Bju3iZugKNfOC1f9PxjeZDQE3
 OHTCIeZiDNoNNwxBA==
X-Google-Smtp-Source: AGHT+IGAcIthdR3e5rZLPUs7dCfw6+Rni4xyHvK3hL9XThFzbkD/xOcQcvYcly76LZ03+1Wk/77VxxcrHmnseQev93E=
X-Received: by 2002:a17:902:cecf:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-2446d5d6202mr84078405ad.2.1755524999671; Mon, 18 Aug 2025
 06:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250818134822.1927480-1-sunil.khatri@amd.com>
In-Reply-To: <20250818134822.1927480-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 09:49:48 -0400
X-Gm-Features: Ac12FXyWLSQT_BdqZ9qRjAO9fnG5FQbG3LTbgrNEgkiL3sR67G6cny8IkfreG9A
Message-ID: <CADnq5_P9_W=nqO1ETcprD8VjTkw21oGDAhHaMFzXSbcEO0OJ2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: print root PD address in PDE format
 instead of GPU
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Tom.StDenis@amd.com
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

On Mon, Aug 18, 2025 at 9:48=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Print PD address of VM root instead of GPU address in the debugfs.
> On modern GPU's this is what UMR tool expects in the registers
> as well.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Please add a Fixes tag.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 127091de0f34..a70651050acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2155,7 +2155,7 @@ static int amdgpu_pt_info_read(struct seq_file *m, =
void *unused)
>                 return -EINVAL;
>         }
>
> -       seq_printf(m, "gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(fpriv=
->vm.root.bo));
> +       seq_printf(m, "pd_address: 0x%llx\n", amdgpu_gmc_pd_addr(fpriv->v=
m.root.bo));
>         seq_printf(m, "max_pfn: 0x%llx\n", adev->vm_manager.max_pfn);
>         seq_printf(m, "num_level: 0x%x\n", adev->vm_manager.num_level);
>         seq_printf(m, "block_size: 0x%x\n", adev->vm_manager.block_size);
> --
> 2.34.1
>
