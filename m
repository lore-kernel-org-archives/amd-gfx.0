Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB33F54AAC
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4233A10E6A7;
	Tue, 24 Mar 2026 13:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KULGNxdv";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C2C10E6A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:03:34 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1273c690e5bso498046c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357414; cv=none;
 d=google.com; s=arc-20240605;
 b=HF8WDKZb63ASyvS1EqeV303YEeOoqO0d9y/2V5V6Y+ONNyohE8Mlb2L5UVEHj5HHqq
 cZuR9JlPS2lAizPfPRVdDVYbB1tNfLmsMzs8bBraNoWJqwUhNz7iWMZ1c3nEry2IWwog
 Plhg6nm9ma4Q2MgzfCzVkg4ERcQ60nGiorhafBBTeChRuXo6T3gb0qtleOkA+DiOrEYi
 xsfoOt8Cj7Des9JZZWvkskDSXxZ/z/RstgP2rX5/LQ2wQ5jESSAjTLN621BvS4RuBQdF
 hLRmL/TOaV7aRPf5IteS4YSyejMIocEWUOufevg4rznXsy27q+M0PKSnaKjvBGqjUvEI
 +8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3XpLQPB3ENND1esnFU6ZpBx1/Nv1CnrVFUKLQpcwhWE=;
 fh=M0cOBvsBLmBdPzqHpztj1DYdPdrr7zKkcKB9CjyZusA=;
 b=VtU7Hopyhne0jfTRYp9jaj7Q15rV2Esltq2UZPJa4UWkzeRUbUuuZYDj+pMl0hQ7Sr
 Tkjx4FJs/0eurxlQ3VBHbLAq58pH1fhO3wZQLIekt3Z1nPsqaVvaXicvd4PX9PvDovI2
 /AsKWmuAxwEu+7LrkgcGBn661BDfEqPB93xxEUGpnrm2STFDabkYN3RahAFF625TlSbB
 LstB76AawR3pl7AEckSaQnPnW9jobBm6HgO/cgYFHB3yF2mBd79sCTJVO4jWuTimaxif
 1DypS1lBHGUB8ubfr3UBiPf9e4km1a2zCHy4r8jzAC7JP/ky8YIYZqIHO/hPaoCMGLRE
 jmLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774357414; x=1774962214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XpLQPB3ENND1esnFU6ZpBx1/Nv1CnrVFUKLQpcwhWE=;
 b=KULGNxdvc/jirVxPoc/hUOZ5DKbxUg6+hiz2XKk6JDkt845kzzhlU5F2+5+eE450uB
 er0iTRTPJyUKzaGLM3Cr2bGUPGI6Vb3RMzUUkuHi+jDmS6i3TPfqwwk+Lv9g+/aIXsGw
 f+5/jw3LxErCG+QkC4LginQoUc3eTxKvoSYEg1UWP8uKbkyEhPpv7j6Mfly2XGRtWTqF
 IFfc7+E20BqCthAZEa5EsTrcT2z+CJ7nerl2p2jFz99Br0kMJRdBVbdtfemqONeMDUli
 ejoN1NvwD4kzCC+tgvpx0IrSMQOMSYxHACiE3n/VjeqvmLbazrdYXv8dyJJ0M7gR5n1w
 jLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357414; x=1774962214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3XpLQPB3ENND1esnFU6ZpBx1/Nv1CnrVFUKLQpcwhWE=;
 b=kV3thNhG40iDJ2PiQ4km5qOzFkVDuv0vCHIRnO+D1SpNn+C70VgfyZ90tK2Pm1uuRU
 0CNvivNxI0PeZcScKjzOgggPQxfKOoaV8Gqnw2MsEzCWObGwSyvkLV/48B6PJ1jwcocC
 C+dnXpMPRNCWYRuFy3og4sqLfAjbKNHm2OjGj1sM7GqF2xBKZyd3XO7fBuTBlWHW0hMz
 UeBkE8zFxi0HTEqrOwvHfpSEZWDYiRX2T9DTKGfjy8XmJM9+4Eucp+84UfwyRHn/G0N6
 71k0VlvBZQF5GB3v5W7NXQ7/DlgDwD99CJn1Uau+obhp830K8KHcKLn0+W5kUHvh7Aep
 wM0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNKQsreE68mqhxO0VtUgoSTLlO1fsuwDBHmRyE6lMZL+SxO7pVMeu01LdGDKlJEQtMIIJeDJve@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxF9lvgOsOGrmDgCrfVYvPEwE9M2kWQL6GZf4MIOg3ZgQwQID/M
 HRUkZwWFVAumi11wN6ny+OAfxfegAfmv2aV0Vi6A/oxIiOngLpc+Kge3CaXK9Zg8x/hhh/3C2t0
 jmd30oY8W3uDWPGOgcx+O1bpQ/waCY7U=
X-Gm-Gg: ATEYQzyI2zf24lteUfQn7/khCE3NlfxP0EqnSQnERhyzq4TCCK0NeUwb251E5EPBcF1
 Hd1+ZshwSh0JG8om8Ly7yK8xIefaQJPund+7tRSzXSsX5UvArealC64FT1k0ZF5C/6u/HJVc4qL
 ++9DKY9ZE1TbXCXhd0q07wxOuZ5x3r6tvip4t3GuxYqACXgCOX2nCnL8G7q6bjk1KO0e4RlIwx9
 E1bvIdU87yIgyrjFDJUq7ipaLtdNRWdycEnZ1dXcAUuDLlubtsaEjLHakc+D2pP51Tir5zkmCee
 m5B8RXf42/GtjZOfuN0raWH1kH7o5RPtbeAe8G0gyIrPoLW47ZMl32lRaeNYQUhKxioazw==
X-Received: by 2002:a05:7022:439a:b0:128:d279:b8ea with SMTP id
 a92af1059eb24-12a726d6b3cmr3190842c88.5.1774357413533; Tue, 24 Mar 2026
 06:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260324075149.622626-1-sunil.khatri@amd.com>
In-Reply-To: <20260324075149.622626-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:03:21 -0400
X-Gm-Features: AaiRm528OMbKbdc0UWtMxspJONjeGXUeNpF1KpQdo3IRJx4L1TjOMAUimWrO5uI
Message-ID: <CADnq5_OzqJwPnWSk6ThbrcFMauPY4DKTpVxdrVFzf3Uskm=nAw@mail.gmail.com>
Subject: Re: [Patch v1] drm/amdgpu/userq: dont use goto to jump when at end of
 function
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Mar 24, 2026 at 3:51=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> In function amdgpu_userq_restore_worker we dont need to use
> goto as we already in the end of function and it will exit
> naturally.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index eb07ed078bfa..a351383b432b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1227,10 +1227,8 @@ static void amdgpu_userq_restore_worker(struct wor=
k_struct *work)
>         }
>
>         ret =3D amdgpu_userq_restore_all(uq_mgr);
> -       if (ret) {
> +       if (ret)
>                 drm_file_err(uq_mgr->file, "Failed to restore all queues\=
n");
> -               goto unlock;
> -       }
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> --
> 2.34.1
>
