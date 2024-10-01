Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF759CEACD2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 14:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9686510E63A;
	Tue,  1 Oct 2024 14:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GqvniVVs";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5605910E181
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 14:40:52 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2e0f7027781so460609a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Oct 2024 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727793652; x=1728398452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4wyEIAAYvKjKQItWAsktAUdW6+078T8bJnN4pjpf/c=;
 b=GqvniVVs1tN2fs7jaFqgNOR7EejKCMJnzmXpvVrKeBJ9M35YQtmQJXBQI3yYv1XQMY
 EvADNigOs2hoFP/Jroh2zYMVWGXN8qOe/pOnDbN0vYJx0QPuQ51T7LKfIH+4qrJPbmIm
 FqLFP3TdvrxmXyKjepaRwdW1UWdHg+ky3rKergqZIomUdkyXzh9Mxk2ylVXxZWC4N9YV
 M+ic3MZhTrnPu/K3SeKGX7V/EecNzyJKV/RB9YNOgw59day9DqsZrJa40olpWB5tqZP1
 aUxb1wymzat4AiOAUbF0H+JIY0ckQlMDk+lt6meX5sAEMNQe21SBekwH2/oSUEHdVppu
 bn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727793652; x=1728398452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4wyEIAAYvKjKQItWAsktAUdW6+078T8bJnN4pjpf/c=;
 b=NubZwjOyjVCNSNSPIZAfZo2GsvPvWX77dqJdiLcbd7cpsS/Bomreug0Efrmcz19oy3
 neDvwNvAr4gwDxWGbSWVohGJBSdJswYascCmBRUP9ELh/QsPwr2wswmgempvlGB1f2cM
 iSEpXSwF7Hkv1jTuJF6NRBnfYm99sbQR31MCx/5kMLb6f2Z2CQDP06Ka0ZMBRiL4oWKT
 W5tBO2i1XKk4fUGCcfHSfuE+QjmCJ1MSLq1LNEqTBRUvCHL4RFgFc9K9y5sXwsngbyNI
 oBuEN2sjxTwJ/fK8Cgjezlidv4amEZp08FzidI2zTEuRtttNKkrJApp2SpJya90RT9kY
 BL+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl8YdHyxSqU/1zMn1zjkearm2NaYJ6W5LW6qh4iP5ojzX3w4y+gG+7SFW9O4pE2uL0qHRAXy4l@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7hK/nPtueYx9KmaIK/w0L/aKT0hoQrJRhsWLLcGsAeAGRUff7
 9hxoMPnpZooZgd7sJHCk7y8QeRNlnIN/cIGp0k/6CD7lQgfiS28pUGHU52AoPeRtGLTZJwTtffu
 wKfOk85WPvXoSdG13e8ft4Cfmo8AOKTDx
X-Google-Smtp-Source: AGHT+IFHnq4CScfzaUABCIq9uIgKxOFD7xXhG3I/7z1T2AMrVwlHdT1N6qmuryqS4R9kTYS9/YlHk9Hf50FjCd3UJB8=
X-Received: by 2002:a17:90b:397:b0:2da:5aa5:5d5b with SMTP id
 98e67ed59e1d1-2e0b89e14c3mr7798614a91.3.1727793651786; Tue, 01 Oct 2024
 07:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241001070047.2578002-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241001070047.2578002-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Oct 2024 10:40:40 -0400
Message-ID: <CADnq5_ONmfERR-_1V_+hrjJFHoEcYRxjyE9J=W1kuKTnkZ-Ykg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: Add Cleaner Shader Deinitialization in
 gfx_v9_0 Module
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Oct 1, 2024 at 3:01=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit addresses an omission in the previous patch related to the
> cleaner shader support for GFX9 hardware. Specifically, it adds the
> necessary deinitialization code for the cleaner shader in the
> gfx_v9_0_sw_fini function.
>
> The added line amdgpu_gfx_cleaner_shader_sw_fini(adev); ensures that any
> allocated resources for the cleaner shader are freed correctly, avoiding
> potential memory leaks and ensuring that the GPU state is clean for the
> next initialization sequence.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Fixes: c2e70d307f44 ("drm/amdgpu/gfx9: Implement cleaner shader
support for GFX9 hardware")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index d7ef05cdb72e..1deb5eee794f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2418,6 +2418,8 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
>         amdgpu_gfx_kiq_fini(adev, 0);
>
> +       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +
>         gfx_v9_0_mec_fini(adev);
>         amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>                                 &adev->gfx.rlc.clear_state_gpu_addr,
> --
> 2.34.1
>
