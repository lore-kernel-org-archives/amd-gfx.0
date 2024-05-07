Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F61C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 13:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB911126D5;
	Tue,  7 May 2024 13:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nMSsSCgW";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A226B1124CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 13:27:00 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1eab16c8d83so23105765ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 May 2024 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715088420; x=1715693220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isPxUHlpcXJCxvfVvL/l9Ply6dN9xREPv0fL5Kzzuvo=;
 b=nMSsSCgWJg4HgslG1PbdclBOf8Oh7SuFur5sO5qhGQHHhxTYe/6Hel4P2hhlmf/z9R
 BqkxZHjMmJoy/7eMF6ch/Rk/2P/olA31rqcOwHny6YSEPyUjoEE+3MNfj36v9rDoehxK
 I+eEFF6sRmW5XKfCy2x+utolkqWYS1kLyTCeUQwQRwG175xCPEsXoeTjbhhRidRh9mKG
 4gPT5iuiOjnMvzAqTLumw7GiX6VBkuZiCiJXuOh1gOSay0XlgixT/6VBbn2eo18EN7Z6
 pKOmKZYvZ3736ldCK2x4h+pMYVOMn6Vup/tcWy0eD+ljW+0+eYl00m1vU4fpcqS5V9E6
 ohqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088420; x=1715693220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isPxUHlpcXJCxvfVvL/l9Ply6dN9xREPv0fL5Kzzuvo=;
 b=LFnh+BvnRfo0PqnVR2lKDcx9ikCG1vs/NFJJ1/Hc67EGeLu/v3NuGkYoS+fKAqulG9
 SDDmmwfqclxq1pLqytIS0dk7yqoLBfaGW5fZGo9RETu6VX2aKMXuvxjYM9CfGRL2yPWV
 23xBSMrH+0YPbtBSdPutzj1Q36fw7vcPmKnAy0/zdeuxbzehDT67mYGyIsxEgqQXua+e
 WdCfrCGcAAKRDPhDvJfqi9YD7mOrjp/3onwkU4dvnrM/tLsHTGQGSJ7CmlvPBBAUDQQD
 5zbdQixuJGWDUlG4bCsqVkDvuUeCCItWIl7JFdOebPs0PH1TITxPJbAfJ50XAmOGxXZD
 vz7A==
X-Gm-Message-State: AOJu0YzywcNZOSjeMLX2Jlk2WpVc/L/pvFsNzfewn/ASFJcDq1ZvUT4W
 v84rZF9aeyFHlYRe2hQ/a330+0X29SZ21fw3srfAz0YohUiWorIQzQqn9wLBT/Ce1j1H+2EpUnG
 E1q9XUxnVbxNCBk0LuXeP7G1N0qgZ/A==
X-Google-Smtp-Source: AGHT+IEc0fWQExEj4euVe4EI+Zo1WY9pUkFoO5gwPJw2Tc4u4hlCjApTDZ0mIZIJYCFnChgEeRXB6EZaFw06Dn6XvMw=
X-Received: by 2002:a17:903:944:b0:1ea:dcd9:478 with SMTP id
 ma4-20020a170903094400b001eadcd90478mr14380190plb.34.1715088419922; Tue, 07
 May 2024 06:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240502214225.8101-1-alexander.deucher@amd.com>
In-Reply-To: <20240502214225.8101-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 May 2024 09:26:48 -0400
Message-ID: <CADnq5_PRVEfvxR8iwTc2OVaEO+PN5Kzj6-8HmVSpjTjq5C0J7g@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx11: select HDP ref/mask according to
 gfx ring pipe
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

On Thu, May 2, 2024 at 6:02=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Use correct ref/mask for differnent gfx ring pipe. Ported from
> ZhenGuo's patch for gfx10.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index ad6431013c738..81a35d0f0a58e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5293,7 +5293,7 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct am=
dgpu_ring *ring)
>                 }
>                 reg_mem_engine =3D 0;
>         } else {
> -               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> +               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->p=
ipe;
>                 reg_mem_engine =3D 1; /* pfp */
>         }
>
> --
> 2.44.0
>
