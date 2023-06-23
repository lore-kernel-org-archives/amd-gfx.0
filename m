Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69BFEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 16:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F20910E671;
	Fri, 23 Jun 2023 16:10:51 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DE910E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 16:10:48 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-55b85b94bb0so473483eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687536648; x=1690128648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HvylnQoB2aCpq9I48MD6PGGYLWLVclKpHqZaqQxr/k=;
 b=nxJuDqaT1Ic0SARturb5PUrlNxEqW1BnfEwKcuYoYG4whIzBLLgwr3EI5aoEtgWFJf
 11zwYXPAr4392PagWt+ZNsFG4yucShzy3cQetumiv/z2EcqYzOIJUvp1QOD2mSA+Gw0N
 IzS8+Fzz7EugNaJSdat4dVCZ/gt9+n4tpmUMOlaRKZGpuiDtIMJrVYWe+l86S+GJDt4V
 yBx5P/rUw1W2FvyJSSjTWtW5Ou1zsCnkahbF1Lvq9t2Pxxrvalg5jgey/bMF92dH7ftw
 tMLT3E33YGmCXJkOC2ZR/FNb++HSH+JvaZ+0Mk4dSdQb038sqOW1a2cwVorIiDIpNXaw
 UY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687536648; x=1690128648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HvylnQoB2aCpq9I48MD6PGGYLWLVclKpHqZaqQxr/k=;
 b=JqkCEEzhGu9UAkjHFjjGuTJ3UaBhSAMKK5yHf8gBI209kCwx+/0+vF1/dluavwcW9l
 1D2GMdnlKK48f/nudxvDgH/BWjFi4um/n8BkOJ50exK3auTs9PQqAOR+yEIbTajHJPqu
 Ku3mQAsTQ2SKtt5VJXGEtQeBFtTTMdt7lhQI5qaheM2tjCpH7VjCwZpke9Jq53lpBJ9a
 p0+dG0bjjGeYvCZ94KSPis48qq9IupePxxHZjovuRbt6XyZHzyltMYNhYxK7A1ad5lKu
 YWTdiqxXr4m+Y4Q0iKjkYKxNZ89Bb5zYQOSzXT+dx57rWPo3+Ea3xrPutHcjEmuL2z9s
 fqZA==
X-Gm-Message-State: AC+VfDx9l1D2JDOHzi8PWNaW8TlJO+ftZb0o+faADKr8vAML9VQfOfI2
 kjjXgqGPHDKbZz7vm46E3W224SOCvX4vr43X36Q=
X-Google-Smtp-Source: ACHHUZ53Fc1hX07QrgCo9rhIxnnOSLU6Q/6SwYjbCMnGh/7InePWYTEMKuVAL2j09sufi5EbHWMezSe4mX0ZBxo6E50=
X-Received: by 2002:a4a:e688:0:b0:563:16e4:b6de with SMTP id
 u8-20020a4ae688000000b0056316e4b6demr629815oot.2.1687536647717; Fri, 23 Jun
 2023 09:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230623031839.16911-1-mario.limonciello@amd.com>
In-Reply-To: <20230623031839.16911-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jun 2023 12:10:36 -0400
Message-ID: <CADnq5_N9qXaGTAACjBFu2P1P=e=QOdUBSRsSda4gf69LCt6KsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't try to enable secure display TA multiple
 times
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Filip Hejsek <filip.hejsek@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 22, 2023 at 11:19=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If the securedisplay TA failed to load the first time, it's unlikely
> to work again after a suspend/resume cycle or reset cycle and it appears
> to be causing problems in futher attempts.
>
> Fixes: e42dfa66d592 ("drm/amdgpu: Add secure display TA load for Renoir")
> Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2633
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 89a62df76a12..c4cef3f2af3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1937,6 +1937,8 @@ static int psp_securedisplay_initialize(struct psp_=
context *psp)
>                 psp_securedisplay_parse_resp_status(psp, securedisplay_cm=
d->status);
>                 dev_err(psp->adev->dev, "SECUREDISPLAY: query securedispl=
ay TA failed. ret 0x%x\n",
>                         securedisplay_cmd->securedisplay_out_message.quer=
y_ta.query_cmd_ret);
> +               /* don't try again */
> +               psp->securedisplay_context.context.bin_desc.size_bytes =
=3D 0;
>         }
>
>         return 0;
> --
> 2.34.1
>
