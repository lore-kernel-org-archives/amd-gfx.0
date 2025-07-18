Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59016C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D6910E0E9;
	Fri, 18 Jul 2025 13:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxMpOVzI";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4E210E0E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:41:14 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-313067339e9so377379a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752846074; x=1753450874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzxKFRpd0DFNnzKuKWUe58AlBSnbCxk7UIckn6IJCoc=;
 b=ZxMpOVzIQUN4qD/FTcEc9XoKy3Ckvjz0HE2SKomicbIheirXfr99GF+b8RlUDatIey
 DKEPkaK/6YiOlLXw5XAYfvSokPCm+Ky5fxU5jrW5WIO1WnIrqj7yabss0XxkhgJ8soOK
 8JEvzS/sV5UUCtp4PASfIx0lBYpNrhWnwcd1Ezd4MhKwGmRwHZ32mhJ4G+bZr73zWo3W
 cBj9sUbzJh3fS/EVsizjGGUgUHmNFaeKsvZDf508UkL8oAqWPsUzJR1GsS7JTpA7rHHA
 AQx3aEw+ABOd8bHxrUbuohD7kAAfxUxMEqrQUkpne7ujSb8wmBzeTw9FqSKo4pB+vdZp
 tXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752846074; x=1753450874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzxKFRpd0DFNnzKuKWUe58AlBSnbCxk7UIckn6IJCoc=;
 b=PbLImCmlvFqtsKpal7icI8yHR9GoDdVAuoaSV+yUvCCdhea0vaqUyCC133P/eth9wk
 rNcOygKR6IxGvsy2wbToGMTU/bHfllaMalcm7gEbkl4LLaFR8KoS3Uqf8r+t4Ud/yWiN
 x2I34ARIJvM/yvrH6DNn18iMBf8+N+GHyOWX7XmOixD89K+2t+3K+doYz1yUJdFiUgvg
 oh3gN6c7s407r3IhkNbAVkYXbUcH6ZzfhCBfT1vgSkvaKTkL4y/QjDMclcmd0ZXtunoR
 e9NlxA+1li/A4iC77pxNISrrHA0JpNqaMh1DtnIbTidXGjQZaf5/+mwAa/iXcU8z9PVK
 7Nmg==
X-Gm-Message-State: AOJu0YwUrr+0iP4rsVD8TyJNbcrqD5U03Vsj4+YM2W8pWsp+ezU8QRpL
 4aA5WGKQ47ZU0s2oRRlGbnZM3xVPAido93pJpl65fVxG8MNO9gRuzB6i117mo12csi0pU7rthHx
 8XKUHbSp5Pt5CaqtOKjCVSk84ABhm13mbPQ==
X-Gm-Gg: ASbGncvwn9Jn7oyfzibOoXRsMcM8VrLLKonTbQhfsWjGZtxdJdPrbNvulu3YW2W/bCx
 ig1MqijCZHb1dvqaFiY66VEYDIZu1cxvNkM/YI6vKasaRJwt+aGIkAROMEDIsHLZesNtZvcw/7J
 2wgEngGiMOGhPfCtapT6UUy9DEzjzYAHWgm2qP/sxzTJIBok8lTBUeBNltY4Lyx/prSuHyL3UqW
 HPW5HXu
X-Google-Smtp-Source: AGHT+IE5Ua4xxco0J10r+nJgEsdqOj3qCCTqCpoilKGdtsswxCzCCkj/aCXx3g4uFr2TkoBn1cuvbGho6Vm83flowW8=
X-Received: by 2002:a17:90b:2689:b0:313:151a:8653 with SMTP id
 98e67ed59e1d1-31c9e7a412bmr5772949a91.8.1752846074246; Fri, 18 Jul 2025
 06:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250718035945.1560178-1-lijo.lazar@amd.com>
In-Reply-To: <20250718035945.1560178-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 09:41:02 -0400
X-Gm-Features: Ac12FXw4LhZsF1G6aMfIEOSRztzxx_1_C27bfrlTMo9HbAgYRIpUFcqd0Uammho
Message-ID: <CADnq5_P2Q-y2z2ZrtD6R9CT=7QJR2MpXdb3EL+8CAU1t+MYEdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add NULL check for asic_funcs
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Jul 18, 2025 at 12:08=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> If driver load fails too early, asic_funcs pointer remains unassigned.
> Add NULL check to sanitize unwind path.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_nbio.c
> index e56ba93a8df6..a974265837f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -55,7 +55,8 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_dev=
ice *adev)
>
>  bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_sriov_vf(adev) || !adev->asic_funcs->get_pcie_replay_c=
ount ||
> +       if (amdgpu_sriov_vf(adev) || !adev->asic_funcs ||
> +           !adev->asic_funcs->get_pcie_replay_count ||
>             (!adev->nbio.funcs || !adev->nbio.funcs->get_pcie_replay_coun=
t))
>                 return false;
>
> --
> 2.49.0
>
