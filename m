Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C0C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DE010E00E;
	Mon, 24 Jun 2024 19:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7fXJeQA";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD0310E00E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 19:46:09 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-80f59d820adso1132879241.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719258368; x=1719863168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usCbaFNuM2cyrKltGZMloCAMXk1n6yiwB9qLWIho340=;
 b=E7fXJeQAnfmBVJVZizHTTaem+IssUB+i1JJqaE26tzKuMUzinl8WH1E1EBqInjVc9x
 FyGxVPcbfrmWfiLtUtqYkZBDdbhj3RuoOI/rCFDvIIPeuIwBLZVpMQO1axu6bSkF3hUN
 yAdcGIa1BtgbD1iTZS2RRIkC3vBvBqwf4IpVDR6XU9s5AebAQcMyLqP5DTOede2rrvED
 vkeq7mS3p48KfOJy5ruHwSb0STZPnbbR2a5yUheg3kXNPv78ziFI0MhWUDmVQx01BPeQ
 Sy/2E2MBT4kTR7idIGgqsR/8qitNn4Ry7/hUGlvNOvBydUN3HNkbtjidOEolVxQYfjsf
 2IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719258368; x=1719863168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usCbaFNuM2cyrKltGZMloCAMXk1n6yiwB9qLWIho340=;
 b=lGR+rScOi9xnBEC3uYUYPbsZKtskwxLg7HeGZl9CK6K1B5Kw3GYKecKNzjES32MtOW
 dYszxvyfJ+lanmcpgFbv1Z5p1W2wI22/txA/oLHeRWhdJoDsGuSl98e5RT27i17ja9t9
 WW99cV9xOJMzcJiQwwdwwfdHF9uwYXNDxefluL60lV9AFtqpzlzOaQmCzp0S3uCdzCSG
 /JSuJNEyi9I+9UIrjcCUYEbTzbBVqf39T78YmmfkZ0n23576bOfzsNuQTN2O2fJCDQwF
 zOBohaP+QFm54xEqot9P9gStALz8AePTO2ByDac6e/MP35DQlt9LpQKyq1q/EKMSKvCv
 iBOw==
X-Gm-Message-State: AOJu0YxHfTpnbtGRe2Fr562c3KvWednc6Na3NriOobLHMledPcQgyMhQ
 dNV2l6b4iuYpBEaX77n58g+PBrIcuWEVlzAlpCRiD+JFTb8ta9RfDYq+IfrWnQI9O8M+Vk9Cx7M
 nMTL5ayNE2R+qcEwb+EW4q+8tS/4=
X-Google-Smtp-Source: AGHT+IGKZyr3IoUx9dLlKvYYoAbPDCMypZrlxy084sjgHC1LZvrPF0GlgcRczzC+G4snrZp1QIS7U2F2JfFnu25r7lU=
X-Received: by 2002:a05:6102:3114:b0:48f:1da6:cbd3 with SMTP id
 ada2fe7eead31-48f52b9dbd7mr4478699137.22.1719258368373; Mon, 24 Jun 2024
 12:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240624191525.63787-1-mario.limonciello@amd.com>
In-Reply-To: <20240624191525.63787-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jun 2024 15:45:55 -0400
Message-ID: <CADnq5_OLRZaO=sgtRAT=Dh1oB-3bJnQqsXsjwSt16HjbXr_x+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation/amdgpu: Add Ryzen AI 300 series
 processors
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Jun 24, 2024 at 3:22=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> These have been announced so add them to the table.
>
> Link: https://www.amd.com/en/products/processors/laptop/ryzen/300-series/=
amd-ryzen-ai-9-hx-370.html
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documenta=
tion/gpu/amdgpu/apu-asic-info-table.csv
> index 18868abe2a91..61140ba32793 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -11,3 +11,4 @@ Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3=
.1.2, 5.2.6, 13.0.5
>  Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
>  Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4=
 / 13.0.11
>  Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.=
0.4 / 13.0.11
> +Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
> --
> 2.34.1
>
