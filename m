Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50069C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 19:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07DB10E1BB;
	Tue, 10 Jan 2023 19:29:43 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4C910E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 19:29:41 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 e17-20020a9d7311000000b00678202573f1so7564909otk.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MDG+/k60dGStevvsw9ofM23PsmqXXZTjFr7hbTgtWWc=;
 b=hIOuGFqqrGO9QYF5+nQtv0a1rffxEUkQkwjGE4xgbuUnbcPbBNW7FY33/1odd2yLLq
 Tk6IkUg9PexU+qKGyksM3w2GKyxr6+qtImeJtCm5i2uCub3q6AZMHgzx0wE7Ik1M6Ib7
 2uEkbfPjHO3SMK8bOaEbwTI5o/CbrkwIkfu41jQmVPOY6tWg/pYHUG/hHe8H67KC5sng
 llB6zaycikilZ94Jv8m445ZIc70sh083+rYcW83Vu5/TTZHvx+61PjBu9vuZjF06moQ2
 I1rcKSb6Jj6wJEkNa/rJwPrPOCJbPu35LKNtHvf2drpr5cjmYJuVwh9+wa+si9OzFq2e
 8fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDG+/k60dGStevvsw9ofM23PsmqXXZTjFr7hbTgtWWc=;
 b=7G39W6K33yzNPMBuoSfpUbX6+5dgTDprKDbEpKgfh8o/wQAvPztNwlG742MH5EtcAx
 LWczyegK9gMMOQfJmSMWU0GaSZHy6/3Vllg/mCnWxbPDFGCZ/NeADVpNcjk6Ym0ZOJv0
 M5CQXFesOxVqr9Ml8Xl2EaZAtYfxJL2bR8mrkSaXj2/KGxmtBSWR5E3GeuoWznQA/BqM
 sB6VeVdb27O7SYw5er3Wyt6TeKuqGf0kkt7A2dQPt3p4qteoJRmIEBr6Qf2Xokkg/1Hi
 yYpryr0XcGKNHrXxTm9AzsKMlVN98XVL8VmCBn/rGb6YIpZEcnFngQ5+asRo8ILToUUK
 yADQ==
X-Gm-Message-State: AFqh2kpxCTGRlELg1oF9Y4jEmBVLMjgUqPZhuuhASUdcJDSduYvT2GLd
 IMf73ddnTHj0NiYeoDYMcoOPKcRDp4uecWGIyDA=
X-Google-Smtp-Source: AMrXdXt3TVP6mH+znpnNRbufgMJhyN8A8KxUSdpsirEkCCnBmHChDbtbC/VUuGxzGc1Z4l1K8WhcsxlVv65/esxfk6w=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr4741871otk.123.1673378981035; Tue, 10
 Jan 2023 11:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20230110191547.5042-1-mario.limonciello@amd.com>
In-Reply-To: <20230110191547.5042-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Jan 2023 14:29:29 -0500
Message-ID: <CADnq5_M1z0j1559YkadccZ-d3MAw1K7ZZb-gJeyrykdQgn=utg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Only load TA microcode for psp v12_0 once
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 10, 2023 at 2:16 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> During rebase from patch series accidentally ended up with two calls
> to load TA microcode for psp v12_0. Only one is needed, so remove the
> second.
>
> Fixes: f1efed401badb ("drm/amd: Parse both v1 and v2 TA microcode headers using same function")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I'll squash this into f1efed401badb.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index e82a0c2bf1faa..fcd708eae75cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -55,9 +55,6 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
>         amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
>
>         err = psp_init_asd_microcode(psp, ucode_prefix);
> -       if (err)
> -               return err;
> -       err = psp_init_ta_microcode(psp, ucode_prefix);
>         if (err)
>                 return err;
>
> --
> 2.25.1
>
