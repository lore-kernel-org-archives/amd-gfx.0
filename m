Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C53EA7942
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483B210E1E2;
	Wed,  4 Feb 2026 19:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i9wBaoGA";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F9110E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:18:42 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1233e05c77bso20934c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:18:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232721; cv=none;
 d=google.com; s=arc-20240605;
 b=H8qy0TNS+3AofMgnJwpYu311WdThQvlE5j+4BCTozn+4EryTQ1NCLZdKovqpRWHS8K
 LFLAvm3kuPFbXXGTb7swgyEMxGZULkDPcoTQqwwYsv8n8UWMH/X/8fMcsRrjxE2WM3hO
 ruK16x67GE2TEpRpK9WIR4fgPHWJVFHb1OtWpcO7YzSsuawCoZtvZOiZdv0vYp3vfoo6
 3DoRiI2q7FXJlA7HNZRijYGw7W+C1/z/b7U7UQCzVlQPN+MXM4+qTHqdNLyUMkVTt5H5
 bnBcF/lKnlGSHrJvRYkoHZx8aetFsRmspusoBELT7VMRfUqjWYo0lPl72DBYkbVo9asc
 7zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yfxat9U5EnIi4hWGlhY7TTY4uhwWsaHCqOZ/NW6YNPE=;
 fh=PrGNJkmAq9wGwTduBIK95GSImFwkbt3Rn8eLhHlF7O8=;
 b=MOPrML11qt4Wb6twaC71ggsGzruNtmsR5G7H3CctuSEOac8WJleHUQkK4e9X32IPrb
 kdPkHSdE2bhLOoqN+sQANT3sEZcSFXw337zPbiII051+X8UEH+EQsywgc7n8t74ORYUZ
 ojJ1GTtbttmBt+N2/KzGeTL3SO5d1ciqPyQaOd5F1J+xBXEClMr+fEWuITtv/fqLJJKz
 RjL+XIWp9Qw6QjMt/fIwBa0O5Bynv8l5ecFhpv8PdnWfeUr5QK1Xe0v4fqyrLy+nJ1h5
 wnMXu4ZKiBH6OfLSnYQ/vHbsXb7LbXT5ZzzNErwSUYTC51F3PXVTjkYjwmw5oWLQXKUq
 a6MQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770232721; x=1770837521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yfxat9U5EnIi4hWGlhY7TTY4uhwWsaHCqOZ/NW6YNPE=;
 b=i9wBaoGAcj81KMYI1sgB7PsSJjiJ5b8ch1Bx6/x9KprUNh0ml+C8Bi5XxybRnI83s1
 95KIrYm7S6nT3Fbq8d/ZGGzM9jqfpicbWrmb4OMZ+Lj4Z2Erp2fflfxzqCVaPQGpMKLw
 yVm4ieiAzW/xm0/LZr08iBRiytPZLRlxFYjEy2NA/9cXnUzD7BtmSaLrCjXQEGsgBa4s
 IeLnTHfXIUKiM5UHMyushO58eJGEHFsja3+eVo9DDdmqhZbIEed0EAkFVYYflBr43kMl
 ovZgtflJrckm6ShVA4RQ8BqI65SINx3LnsAWlLI/tkrIx+AfiKc45sDnt4qSDFy0++Rt
 SXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232721; x=1770837521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yfxat9U5EnIi4hWGlhY7TTY4uhwWsaHCqOZ/NW6YNPE=;
 b=pFBovHL29hYpyAYPyPYNKnbj2Cust0acGoEw0N4IIxDCcB9Dq8XOy6GtQspqhjMWT9
 Z861rhhlRnwBOvzNklSgpfMZMrRLmqtp05g2c8gwQGPGRSzhmUHxvKsimpdZGxQW8Yvg
 mLxWQA0PO89hwKQBEc3OPnHJfNixWe+Zm1c9jX5rKfWB3DsQJhBeSFuh7h4Vj13Y2pIb
 hh2dfXop7ZXe3txuE3OSzX1RvDqc1EpnYnOvgqsYHwasqkPZuIJdiy9fO5Ni2cl/qoY+
 0cDnS7IQtVOiCpPbrrpyCZaCBBi8nBLbKbRA5FmRPZ32O4U60BAPe10DOwZpjx/I4p3w
 Zo0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn+uJuoSpEH8kWuX2Gqzr8J+SikYvVwyz6sqguBZc4d4CdnG3QV79BkbHDJK9yUl4CdTn46wRI@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9Kief/LQwfRVhNiNrquX+u1+EjjPt1np8enmFsBTxIn7ulIDM
 9Sgpa1oCglfe+q9eXvciMrzkOs2hj5/Q9qlZJGRZymOHG3G6s7ER3FEAvOoBaB6B4WbREtPccU8
 581VO7fuYLeYayheh23CzAhuVm/PXG4gH8A==
X-Gm-Gg: AZuq6aLD+NMnuqEU6LaHmzMggZW2alNmqs5cpc9Rx2RI8LMfAphqxYRk9c47jfs+zq4
 BvBl2w74DsBHO+HdpY+ndjrjHhtkjbMVTtJ81QRD18FmHgV8IIbGHx6rDhHjfEquQuvk3eIY5yP
 sMWgnQ8WY2IuSNSYdgObXMLCuZoxUnUlLMendG+Ld3uJE2vw884AAMVCIvCwDfT+LWSlAVL0238
 zYhsk5UzoCtH0kkRAdZQeGw71g7GNal8yIJuHhgQQTxAOpKrRpO8sLr9wkcwHmxMeHNyXRa
X-Received: by 2002:a05:7022:6721:b0:122:33e:6ec1 with SMTP id
 a92af1059eb24-126f4708c76mr952936c88.0.1770232721238; Wed, 04 Feb 2026
 11:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:18:28 -0500
X-Gm-Features: AZwV_QhO1eiPuf106Gfal17zJsDTrAlfJqWffYk09OkS6-xr2BzDS2sJnv5wn9g
Message-ID: <CADnq5_PT90bQeM2KbdyoDRTdvBCvvAaHkfes9x_JP28TmDqHfQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:44=E2=80=AFPM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> TOC and TA both are required
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v15_0.c
> index 3aca293e2f0c..723ddae17644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_conte=
xt *psp)
>         if (err)
>                 return err;
>
> +       err =3D psp_init_ta_microcode(psp, ucode_prefix);
> +       if (err)
> +               return err;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
