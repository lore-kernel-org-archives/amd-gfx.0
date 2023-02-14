Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E917FC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC3F10E0DA;
	Tue, 14 Feb 2023 12:48:49 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF6F10E0DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:48:47 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id by3so14202387wrb.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 04:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ynWFsuN10LTcQ5w1SbtSKS8QX5tSJTLF/ql04cbEBCg=;
 b=ATxWZefcbCaUQbI4t6VU/6ikBR3ZzS6XQklUgBG4sypT1iB65oon1S0usqUEnQvJLD
 5MhWnz9biMDou4u8L0vpW6g5w37abyDSfwGprEnw+Gr/pPMpibuwSe95mPfq0e35AKVL
 hdpvZibRv2y3DMALBzxex7McJubGPsXD5T49KZz27afYn8/uPQQdD1PdlEuritzCFREp
 covFua6g70uYcTrzMkPbSX3B9zfY9T4FTzX9EAf5IdZAfGVgYwYthlfD3cwZbf9MoavX
 ljzAtWDl7nvAPuST57XyCSbWyujpxxaMtOT+XL91HZzHDzJdNL2R8rcakw5fhjTPmR+o
 nPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ynWFsuN10LTcQ5w1SbtSKS8QX5tSJTLF/ql04cbEBCg=;
 b=z2l4mljDcEO8HhunNckp6n1LfeFUtbj4agdpayqUPMYxrQNicTPhXGI+QGAnCh+M44
 F/HTeUc2GFbdRdnKmCdunlKyavLZ+sfoDTiVTod9g3j5qESW4ktkT3plCc12QJqEYv2g
 VoCuQRUT0u8qVE4HLZQ93OmpxJWvR8ke7eZnj5PZrc/fwkTom9n3vd3bP4oCb8HVgPig
 z1MXt6MtJgCUwK69+l9RCe/Q7+/VmT1ukASdC/iRiNLyTCa9aK70OBx8HjLUH1cJfCzc
 KlVUVve0j8uTGsWaqfVOQ17t9lma4SqCrucsLcSaPVrUvKZraz+DcQYfUlEy6cMml7hX
 wlkA==
X-Gm-Message-State: AO0yUKUmEdtY5D28MNNPZ0iAtqemZGodCFs5GCewU784S44kCojWgqzt
 TMryc0Zo0KYWnWHgu6MMEAg=
X-Google-Smtp-Source: AK7set+6D/xGNyAdgThsHNzjql3Xmot8prZwdj6dTaC1V26CCJSmMpS998Ftwp9AuE7r8ZCbEFHxbA==
X-Received: by 2002:adf:fe43:0:b0:2c5:4d35:5260 with SMTP id
 m3-20020adffe43000000b002c54d355260mr1604867wrs.16.1676378926059; 
 Tue, 14 Feb 2023 04:48:46 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 r3-20020a5d6943000000b002c551ae8cc1sm7883909wrw.67.2023.02.14.04.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Feb 2023 04:48:45 -0800 (PST)
Message-ID: <75defc22-3b18-262e-5917-c42ab8ee3c28@gmail.com>
Date: Tue, 14 Feb 2023 13:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/6] Trivial code cleanup around color resources
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org
References: <20230214121406.97750-1-mwen@igalia.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230214121406.97750-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 13:14 schrieb Melissa Wen:
> Hi,
>
> Sorry for the noise, but while I've been working on wiring 3D LUT
> support to AMD display driver [1] I found some annoying code style
> issues in the shared-code part. So I'm just sending what I've been
> cleaning to better examine the code.
>
> Most seem trivial, except the last one "remove unused
> _calculate_degamma_curve" since this could just be a matter of missing
> parts. If so, happy to remove the patch and include a comment describing
> the situation (or the potential usage of it).

The display stack is not my field of expertise, but those cleanups are 
so obvious that I think I can safely give my Reviewed-by: Christian 
König <christian.koenig@amd.com> for the entire series.

Thanks,
Christian.

>
> Thanks,
>
> Melissa
>
> [1] https://lore.kernel.org/dri-devel/20230109143846.1966301-1-mwen@igalia.com/
>
> Melissa Wen (6):
>    drm/amd/display: ident braces in dcn30_acquire_post_bldn_3dlut
>      correctly
>    drm/amd/display: clean code-style issues in dcn30_set_mpc_shaper_3dlut
>    drm/amd/display: camel case cleanup in color_gamma file
>    drm/amd/display: unset initial value for tf since it's never used
>    drm/amd/display: remove unused func declaration from resource headers
>    drm/amd/display: remove unused _calculate_degamma_curve function
>
>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  37 ++---
>   .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
>   drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
>   .../amd/display/modules/color/color_gamma.c   | 140 ++++--------------
>   .../amd/display/modules/color/color_gamma.h   |   3 -
>   5 files changed, 48 insertions(+), 138 deletions(-)
>

