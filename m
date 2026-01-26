Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1EDD13C22
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 14:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8E910E22D;
	Mon, 26 Jan 2026 14:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IDoHDaoz";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F39E10E22D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 14:58:44 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b703e04984so290786eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 06:58:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769439523; cv=none;
 d=google.com; s=arc-20240605;
 b=j0UuoSh1/JpgeTAWt+XFZRaF7lzQu9bl3qdUkpLgVJN6+DO4a/No6EHqDJV9VWuwiS
 qJupethxUn+0jFr6T1H/vV/4BDZzOLj1Eb10Bu+VmUFHd58oGuH+Q49Pe/QMG5huzPah
 SKhF0SOCqS5Yn4a+w0IHwpE/7romGagz7qNtujMmUFyTvqXzgxQqDlmhIHtFbL4QlDe7
 7vEcKs3V8fwtRVswJGRaCck55C7YQSvDJ8P43y0HTV6SnX5Gxm2eQo3Ft1HILue3+7sq
 R0ugvb9hM1hVJrInsgSJaRAc6tqzGaNWqfT9vu1IcQO4foumihTGnK14Sqqb8v7Ctksn
 s4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K+mFiZGgxXiIpiwYBtoDhBsa5ghAgLylhxCOKrYjnLQ=;
 fh=apalxpwyR7RiWXbdBftMhuQdUwwwLsjURd1H39azLJE=;
 b=eGG38lFiX0e+rCvKdbyVrlGYI9x6UWpe+H3k9vIhr2CfiuaueMnvmM6pbVPqhPwqQd
 5++sMCWdv329w1DpzkejcxNC1xEI5ui2PrX1yQ/DumgO2JVdwXyUiRO6hL2PjHTUjPVy
 uoljvoSY96MmLunUZbkqu/eVoJTmKQ/ckdgASL2av6q3dZljfGVJpKPQrc17e/krAHO5
 GoMGo3Rj687z7d0fUCNBqv5MLIkSoLtEjkpsgdt/0WR8uNtlaIj2X9mEDbEuskgY89fJ
 3ud48Q86OJz73eK5Km8N3hfZld3yI4yEv8MO0iP/A8mY77D3l4IfgfkE0BSFyQRyOe18
 5gzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769439523; x=1770044323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+mFiZGgxXiIpiwYBtoDhBsa5ghAgLylhxCOKrYjnLQ=;
 b=IDoHDaozMuYAEo5gw/CUO1ZUDzj6z8xcciVlgaju2qHN2tZju2/h916SRdrnKymOO2
 ubnnhAQkHCNHQzhFOL3Owj6Z9nUJMjA/62jx5JiCRW4iQ6MMt826SLGw7Lu2+r96/25J
 H9Hs28oYuOe3XnryXbd3CNBxM6hhWGyTtSUrX9FD1hcNmq4tqBW5i/iR9LVW58xLYV94
 7VB+ARfFcC12QouXww7yBpcOHAXJsLDo61N23vkFIyZwLeH2Ho2rBPHhsCJjuXAR5ULN
 GuujLT1At1NOJwN9PeriMfzd1B6K7qkHLu84uHRb22kATJh0BsI1vVEKW8yKxjP/iDtX
 r63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769439523; x=1770044323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K+mFiZGgxXiIpiwYBtoDhBsa5ghAgLylhxCOKrYjnLQ=;
 b=GMoPjAJSe9DL1CxKxk+d1IA2Z8Tkp7/+yXrVPNpRnrqtBxao99TUNeKPY8jnuEXkr8
 rbJPUyfm+JdyvtpWqKtaY+JWu59pV3FI56SqhEYF2WAmSa5EXwRWqBIuWJXyPv4RJNsx
 ovUgMhN7yrmjM88R895QCV/+pZ044iqgvnzffGIVZ0cZIiM2yUCvX87O4LJiE0MDQAYD
 dSEMnk9ifoE/vcB6KI4bBt7fD4gEaI09EHiwFDx/8T1X8KOXld4acaHaQ4D/rbiVa08M
 /8B02jgVhNysvgXyxieLdSToseJXl6SlnmlfmYRcb9mJJLL3bMy7AW28Py87YjX5Yiak
 zvNw==
X-Gm-Message-State: AOJu0Yzzo3Yym7XxBxtO51DwsN+zYY9A9knFFJfHii37xD03xeYYSSjP
 cpgsJ1142gmwQrlFUXCqz/F0JutaPGfdRi47cT6CDu6XWQNHL/ra9mHHhj5OaOXDTPDtLdyVhOg
 WW3sqiAGaoyYOhqpxIAmLQut2gy0LhLFHpg==
X-Gm-Gg: AZuq6aLjCUHhli/5LzyuBrS1T6IaFbLdvcTqlCd13phc3d4zpXe7yvqSZ3U3T7Ofv02
 KCFyq+1NnNvhhZW6faYfr0EwesSEDbnfMcgrzoqtX0CiK4XPyQNko+mrgvA74CIgMsCbCegO9ME
 f9SP7dSZe+ebP6d23Ho+byaqI2UDGu7qN/z4lxtlxXTZus//YgrVpbEtMJeOUJ+PgDr7yEgtiHS
 p9lyi5an7D/GoA6GK/0doACwtJRnyKL8oRivB2sEwh+FkSqCC5C0C1m1Nq2eiw+vpjx1aTXlsK2
 laTiU2o=
X-Received: by 2002:a05:7022:fa8:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-1248ec7b46cmr1160286c88.7.1769439523205; Mon, 26 Jan 2026
 06:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20260126061921.1886410-1-yifan1.zhang@amd.com>
In-Reply-To: <20260126061921.1886410-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jan 2026 09:58:31 -0500
X-Gm-Features: AZwV_QihYWWrtERiam2RludaYhkYwJoiMI_nsBwzgXyKTKtEe1mQAQL3-3SNK3A
Message-ID: <CADnq5_NpSwsRA4yFAfjdAESGnqB53X7wjdBXaNnhHZuUOCcP6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable gfxoff in amdgpu_irq_disable_all
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 perry.yuan@amd.com
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

On Mon, Jan 26, 2026 at 1:37=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> amdgpu_irq_disable_all touchs GC registers, keep GC awake inside
> the amdgpu_irq_disable_all function. Otherwise IMU may be stuck due
> to invalid GC regsters access.

This could happen any time the interrupts registers are touched.
Would be better to do this in the interrupt .set() callbacks for all
IPs (gfx, sdma) in the gfxoff power domain.

Alex

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 82bc6d657e5a..85e5399fccad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -162,6 +162,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *ade=
v)
>         unsigned int i, j, k;
>         int r;
>
> +       amdgpu_gfx_off_ctrl(adev, false);
>         spin_lock_irqsave(&adev->irq.lock, irqflags);
>         for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>                 if (!adev->irq.client[i].sources)
> @@ -184,6 +185,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *ade=
v)
>                 }
>         }
>         spin_unlock_irqrestore(&adev->irq.lock, irqflags);
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  /**
> --
> 2.43.0
>
