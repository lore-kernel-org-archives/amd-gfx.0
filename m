Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5838C32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 19:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C12B10E20C;
	Wed, 18 Jan 2023 19:07:29 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D229D10E20C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 19:07:26 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-15f944494ccso1585250fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 11:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AW7/l9XSdRKz2rVzW5sM5/qqdkxtjBPIiomswb8BClw=;
 b=IJsphxNd6G4n2Qn/37Fg2sQWh8CZmE2z18jLCHHikY//9MyUAdnIHrz1ExZ5JcT2pj
 a+lLvkc2GFerQHLh8PXxzT8g4NaQVH0jSMnLFk32YBiKn1HarAsS3OmnxfA6SqkYKcpT
 Er8NB/c+UAcibmY3FN19Tquh8QExunqp7/4XBAVMTp9Zx0Bi8SvzMg78QpNvORHwjHWs
 Q06vvphAHdiuzf7xNNc7u4tzpEHy6GNPCyFim/F8FH4ru0pWop2cskjsEjXfO6Kpuwro
 sFbQK+piPLoC05IIV2vM6ftMwJyukVk1hZ6MYBLunzos0YZ5qT3SP5YMTjWO3+tH2FbN
 TrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AW7/l9XSdRKz2rVzW5sM5/qqdkxtjBPIiomswb8BClw=;
 b=ieUsGJ6+d0sKe0SEAX9X4hEsPiBS6gG/CJS3irvQRU4SxOaBMZp0qs6PrT18lguClm
 ZngnSaQZnNgOvj30z+o4FiwoQtVmDD0YsZq1U0UhRkrTZ6kttdluXEjMtP/H7LC/5rQT
 eNmzyYhcq3CDibnlp3y0JP21s07UcgyTCEDo3y2Leu8KL/O7t01nko7eoLX4MbvGKcKg
 LVpXNpGbkRnboFNggxR9iRi6a8XEB/RVplrlwlv2yB/SfTogECijF5DIqbN0rF31k2iT
 YFsr+91s2y8MUIeFAm+5kSK/hFe+tqQgKu1lOB9sk32te3d9kCW4Sww3qeQyYvGpwaGx
 mUcQ==
X-Gm-Message-State: AFqh2krmI+GobiKCLOqZ4jJ9BFhqzt0gK1ghBGnGiwz8yy8YNaHAbjx4
 iNO6G2z7nqDm3+b43fCxcdBPv+hTsgu6IpHIwLA6g7YN
X-Google-Smtp-Source: AMrXdXsiExfaUy4JIpGsNGHd4NtgYMLe72zp8irX7K7G9X/we70Qaw6vbthW+3AWs0hFsehBRlfO4ZUvgQi1TB6SIbU=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr778343oab.46.1674068845957; Wed, 18
 Jan 2023 11:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20230118172841.5690-1-mario.limonciello@amd.com>
 <20230118172841.5690-5-mario.limonciello@amd.com>
In-Reply-To: <20230118172841.5690-5-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Jan 2023 14:07:13 -0500
Message-ID: <CADnq5_Nm+LHLAjotCKUfgFjjK=_RFzV__gcz0Ey-ktpWC_RRYg@mail.gmail.com>
Subject: Re: [PATCH 4/4] Documentation/gpu: Add Raphael to apu-asic-info-table
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
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 18, 2023 at 12:28 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Raphael launched in 2022 but was missed to add to this table.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> index 88f4e3071e696..395a7b7bfaefb 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -6,4 +6,5 @@ Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN
>  SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
>  Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
>  Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
> +Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
>  Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
> --
> 2.25.1
>
