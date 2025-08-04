Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A07C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D6910E00F;
	Mon,  4 Aug 2025 14:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XfcxO7cz";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5303610E00F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:55:35 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b350c85cf4eso509369a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754319335; x=1754924135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9ag/xvJNK9FJlxGchf91rK9nnb+w66rFV4LrQzA80Y=;
 b=XfcxO7czRWrRT71Vw8oPeYjnGVIW+iqx/bCdAVxpPNesiZ56b8oHmk/GQvi9o/qP08
 xo6+La/+mck/7dDXnHdWG3+CYQZWcYxuF1LJNbuB71o+PPIyiJC/BuYTAfYUZ+HY5E5U
 5mG1kJfh8b2IP4x5jAPdU1UezbV5gMyM+TIrX8ZIE7pT7AzD//0Aj8WZy/tNPQa0xzyE
 knjpZ+guKA7sASn51cRXGlHONYAtiwwhl+/O0lN9UBBBLQmK1kcv818MqmUGJdWmk5VG
 /uDCk3S5lc8Q8UFyXBARZAtwYLiuZB9Pv0cOsF+JvD8oDHNRJgDQXKJQzIgahorPhE3Y
 cZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754319335; x=1754924135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9ag/xvJNK9FJlxGchf91rK9nnb+w66rFV4LrQzA80Y=;
 b=bXnL1PcLiVQ2/+2btSfD7i3weonjqgPx7KvyBVuynJAfCnACv8Ksxqb8npI4L2Q5Kw
 K7MB68SEkd8pk1Qjt6mYxpAWDiSS/Ige0LXfaSR8qdG1VcbtIcJ/u3O1QxgGj/gOiAJ/
 ZHsoRq22LMv+Wkh5EvcDfFsxWBYaPcj/rluLJmv5GMKUOZibdiu4AnCoW5kIhSFm6vqu
 0mk7M0UcLoFaVS3Si8w6l0hGlwQ8/eoGz9ebVpVhZSQpE46om5WdwOitLJ9R85cAAH1+
 doRHHTN1KxVoNc+jIepKpFn7B0u2JVluvQoVOGIrNsZxqvXIpPlAZM1qqwrhThipJTF+
 LTZg==
X-Gm-Message-State: AOJu0YzsKEOn49JjgEm/RaCKLNAGUMASsNjKZmqsS+sEqwkJp1a6W/hN
 w9MFCmfhyQxCUb2kZaKJ2hkf+vYLaeBk1AUpHKS22tXS8YYYiP3qkxBOyGx569eoNd+mUwhIjjZ
 3ZIXoBY5R96bwrHAD3hIhZLdLZRk8KxQ=
X-Gm-Gg: ASbGncs+qtj09hYOTCHVQUtmYpA4dYXMkJ6DGFQeZgpp8J1dhty56eoJVtmpPofojoo
 w6Ng+LZsY3jX8PvXgstZCAHg1/jySNdmj7dc+MHCIV24uwdV7dO2+aOIH+LV7d+RzOOWe8gyLnU
 WXIlvbCslftwFocza9kvUvfwyhoCdQFhOA+R0WPfqHy0UZM0GkfJivt2ULzg6HyrRtwz/vPSxCD
 f2sPPus
X-Google-Smtp-Source: AGHT+IHpcu4bIE/OBBqla+4XOCscN1zE2fLtU2gSprnY9n+DGQWTJ3mSU0569U91KAI+L2U7C7KV6SvlG+fHHKh4unc=
X-Received: by 2002:a17:90b:1d03:b0:31f:ea:ca84 with SMTP id
 98e67ed59e1d1-321161e12c3mr6200233a91.2.1754319334648; Mon, 04 Aug 2025
 07:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250803022731.2033153-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250803022731.2033153-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:55:22 -0400
X-Gm-Features: Ac12FXwfPk0kxOzhfwYXf0lMRC_y8tJvCn3jQUFjgdxz5aw9MU1NSLJSdW-nIs0
Message-ID: <CADnq5_MZ3pZxv2GwmzCiW3k8o8XweB8kYDR5o+EtgfC2=81fMw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu doc: Remove VCE support as OLAND's features
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

Applied.  Thanks!

Alex

On Sat, Aug 2, 2025 at 10:38=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> OLAND doesn't support VCE at all, but it does support UVD (3 or 4,
> depending of the sources).
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Document=
ation/gpu/amdgpu/dgpu-asic-info-table.csv
> index d2f10ee69dfc..f4dde71b5654 100644
> --- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> @@ -1,7 +1,7 @@
>  Product Name, Code Reference, DCN/DCE version, GC version, VCN version, =
SDMA version
>  AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, =
--,  6, --, --
>  AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3=
, --
> -AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6=
, 6, VCE 1 / UVD 3, --
> +AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6=
, 6, -- / UVD 3, --
>  AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, D=
CE 6, 6, VCE 1 / UVD 3, --
>  AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 S=
eries, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
>  AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 /=
 UVD 4.2, 1
> --
> 2.50.1
>
