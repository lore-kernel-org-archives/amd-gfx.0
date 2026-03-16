Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02AFF53D7E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417DF10E329;
	Mon, 16 Mar 2026 18:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UphmB3qi";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F4410E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:01:37 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1277863a912so339092c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 11:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684097; cv=none;
 d=google.com; s=arc-20240605;
 b=CEEF8d6yD8s0tnB2A7+VbTEg9zmTtqyzu1mh5kd9lAxlS9uQp14BGIClGLf4nUshD5
 e06gmZH0COfYQyE09eEm9HIH/8lcP9iH2GXC0rM0XJn9QRY1Yvn/WdF+kONPObyqRW6c
 xxQj9xDzj89Mi6Cr3ypR9fC8oCACSXbWbrAkdJDTXjZli+V97PRCPpsSYq18g7d1YzDy
 EpQkrLHUI66WWHCzAgU2rm2c7lkNGxJNX2bs5crq9Brs7XbVVVvDAhSgd1Q4A4/QyQN/
 vagNjhZ2ZzM5SHMDhw4iXyG59CL7FVvuZVfLOs5oi6gOUfl4iWiAw8vYbC4sPLQIYQCq
 nsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AIFKjLMX2khtU0E42f2KRCQbCv9FgI7Va9bFF3yLo8A=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=Dwu7dQOayD74OVNrFF37Z4sNz0lgLJeKIjc6gAtY7Vd8qo/HLmJxsrae2thYaqsPfy
 3rbAgicDf1T6aHNc/m03wnMRpOaQUj6BcCtm00RIQVVQbYe429Fw3L4F+4xUwlPl2Gtf
 TgjvRTHpSjac+Ro6T+fhbC2y+Zto2/F3F9+hixDpb6pOvcTtxkaF9hjGdAHHY/H4Jmvi
 Z9LuqNBHNL38UeU4GonJ/2psB3GjFOhjovFGMnoxtWdW2Bwkq66N1trkgI8i2qZ2Kcs6
 zcgrkYR/Dw75m4RPJVunAkVeDU0Eq+6pLZ6ehKMbJk/WGxvJV9LMyUsDcD+XrHgOJ1o6
 Z2gg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773684097; x=1774288897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIFKjLMX2khtU0E42f2KRCQbCv9FgI7Va9bFF3yLo8A=;
 b=UphmB3qirc9cZ3UQzUlHZ6su1vGYhEWD+yMM1SIsZyLpiDUpbKTNUzrZMSMqAm2Y2V
 dpIjV6T7WaWzdQcs2jmrRq9RZpX9L+j7r+M17J07WKnf0DDVKETlyFUN/x3E0exLw2V4
 i7dEBGOcGAx1qvQagcUwdvKKXwdmosoaMTqe3yXQYcGemYfBp1FQ/PiWJhMntDE1Yf9n
 FjrBW456JdvADEIffO57KD1398oOXLurMaMv+9qZ5OhSQaHhbDJvP+Jig3k344bdT1FS
 7z+bF1T03k5YwvkbM6+TGmB+hqec8HpQC5rkASKIcfc3lLukwaZ0IoP3gDivQaIXvXoC
 l4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684097; x=1774288897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AIFKjLMX2khtU0E42f2KRCQbCv9FgI7Va9bFF3yLo8A=;
 b=Ot+MuLs4TimF96ahMwFkBoOMOCeGpy60o9PBis7DmRmonbegiF2OlaDTD/fVr8xwUe
 DLIPJmP6EMNxXA8P2sIZSuulbmwbK6zEC25mO1Zns2VaV5ff4QYVWn3aQcV3YCSKTxTi
 I7WRX/ZDmD5TulUoj+heu+5YDFQZ8hlh5ZHF7kfpTeF9tA0g+jokWf8/QJWxWThcXjKV
 yONC9SLaR7+SAmxJoUG6P74fLN9JV1fwXRGFcmdIaMVTSAznRrJPwDNWYma+JgetO+zR
 CO/AqDAkipnb9mAxLUQK3E/gAX0iFU6QFvBZgw2VH+iRSEelrYW1Q+ZqkCOO9yRc46au
 o5bQ==
X-Gm-Message-State: AOJu0YwCsLsgG5y9cewHJIyDqoCY4aR3D4vdR9/d4obnT/6pKPxznBsJ
 d7opIWWPqOI8v03/p/CAh1l71DcxIQtteg8wgY5DIEQBQxPcDEdKecLVMoAc3+KchEfMjZI+D0z
 V3WwHahkTzdDgYDYKPgVs0/J5Tq0w4lc=
X-Gm-Gg: ATEYQzyq/hk8bEyR35foV6kgqQGKSX18JssdvbJrTUyjoxl/x6kHy5ivRBZ98O2JMTL
 BgjU7CbUmgkrWiCW1v6UF9ufLZREzzsWJQnApm6hm+qPy3eJcKe0DoWyZUn7PIc5LB8E8yUIKtk
 TX+o3AMs/g8Mam5oNQnJrCmwsNXrm3Ti00TVvfplwMqDIR3FPn1IaAOkj+COkSAFBuRVLf2RgVt
 n3q7n+aCjx3e5Zafi//lXb64iUHBopqRFjnVISaOUWQRnWu0fFjeJwsjg5epe55NO/5Ta3TPFZF
 0//xs8oX/K6GwvrGDpqfBQEsagCCaIVokTaTcfo3zn5qpcDYt/Jpz90CpBBf5iFfbJg2qw==
X-Received: by 2002:a05:7023:88c:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-128f3d0cc00mr2167720c88.1.1773684097036; Mon, 16 Mar 2026
 11:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260306142801.3914073-1-alexander.deucher@amd.com>
In-Reply-To: <20260306142801.3914073-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 14:01:24 -0400
X-Gm-Features: AaiRm522uEfvs0YXYFlkYJbnjEpU39rRuFH6q6bxcUVz8cHxuefrbnbFhA_qKxw
Message-ID: <CADnq5_OBK=77sXEgx_Pv8bZDqOQ3+38E6YxG4ko9a=YKJiThwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: apply state adjust rules to some
 additional HAINAN vairants
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

Ping on this series.

Alex

On Fri, Mar 6, 2026 at 9:34=E2=80=AFAM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> They need a similar workaround.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 07d2ee67dcbc3..c2b1383c7db71 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3455,9 +3455,11 @@ static void si_apply_state_adjust_rules(struct amd=
gpu_device *adev,
>         if (adev->asic_type =3D=3D CHIP_HAINAN) {
>                 if ((adev->pdev->revision =3D=3D 0x81) ||
>                     (adev->pdev->revision =3D=3D 0xC3) ||
> +                   (adev->pdev->device =3D=3D 0x6660) ||
>                     (adev->pdev->device =3D=3D 0x6664) ||
>                     (adev->pdev->device =3D=3D 0x6665) ||
> -                   (adev->pdev->device =3D=3D 0x6667)) {
> +                   (adev->pdev->device =3D=3D 0x6667) ||
> +                   (adev->pdev->device =3D=3D 0x666F)) {
>                         max_sclk =3D 75000;
>                 }
>                 if ((adev->pdev->revision =3D=3D 0xC3) ||
> --
> 2.53.0
>
