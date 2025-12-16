Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6FBD609AD
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 15:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3227210E0F6;
	Tue, 16 Dec 2025 15:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KH95Whet";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DD210E0F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 15:27:47 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7f6282195a9so404373b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765898867; x=1766503667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hMipUfGS7jBGmTv6YDgrbzjA4iGEIpEiKn9cuVa04M=;
 b=KH95WhetbxTZ+BluRy+dvkWpDLzrFru/XFy2hE6YQH+jO86ZGDEqjzZECzy0TOjGAL
 53PXnq0I69y0SWF/c6iL3rsovwdEdcb/U99Pc7jTuFzoX9ePObjzxALxr4AUhGbq3Lye
 eCnlXlpvVaNPdh9SwpbtA0HI/iLn+80Z/V6E+7Z7pc2dEHMhT1X00h44ebKczXJpD66P
 j7L3Uas+aJjcs63Nsorr2B1z9Cs5+Tt09kDMeKuoiJlOWIVhZUjmk5WJ2DnF1QbuwAYr
 cflGP+AF9hpwca7ulP8og9iGar6uh82hAk2/0OtbOe1vHoLp9bvYO24CVRvObP70pX6Y
 4PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765898867; x=1766503667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8hMipUfGS7jBGmTv6YDgrbzjA4iGEIpEiKn9cuVa04M=;
 b=Y0GR1C1gwl0NBa30BRD85b0Hk1m2bRRdcRccDKnATVu6q0RAHsT2W1XGJjQN9ltUwJ
 ob4rMOvlsgQI7cd9JeuMiEXOF2jgMnygNLC9hrCA2yKONHaM+90qCep0OeA9RClINrHR
 fsEIl2jq95IK9N6E5MPgHptPXhumWvKauWfYz1iNHR0+0VcFMqrDliqIOUxKj90cLIHU
 dgKef0YrXPFB8szXoFJLLNgx8pLPhV4+a3BC4RWHlm4P6n0QLjBdIM10rW5wfnH4BvGi
 bGN2f/B8eItdYgd9MtiwX+iLm4dFkIMMMvZHFiNpujMqA23D0CleBC74ymWmQWZt5Jya
 kSyg==
X-Gm-Message-State: AOJu0YwohyQ/zMQkBxFIXiokUvQ5ZXBuMtULi2ryoQorO6F3iZJ0Gi6k
 iyNEvDYI87OYZ5bgK5b8NIW6GxfF1TImT+ko/RuOm7dfcHQ8qk7/CceeGaRsNU3noEdjfZxdWDI
 bh+d8jCZz8mkxIeefK8lbYWumn1culNOuOWXy
X-Gm-Gg: AY/fxX5qXZgosnDOAZ5pt5bZ1WJ5GKer1SA1Y3x+gvNV3Cm7uGOm9D+skyHhe4UhkQr
 6W+bjecsTs2pP1+Z9btTgXqoBwJelDsubaCbf1OTWPOm/gwHqWpWVplmbJYhMtP0+/oAg3nixoH
 3+GIYc5mt6mzRXqgi2iW9hMnXs4XvADxb14zIge6jNwoeogJHIT4b1fcorj6965ZoKfIQSBEFKO
 2KifVfLuUeqr+7Mcz7whPV3O0LK8TH7ur8kKGe43vXBsOECjrt0CvUH6rWInvacd9ef6Kr7
X-Google-Smtp-Source: AGHT+IFwwFJxngznHz4h3VTYN/hf1HpnQHXXtcNNWwpu9sMxOie2IKXTZ6yoIcvqRz4TvuO9SVHxY20RBTlcFFW85fc=
X-Received: by 2002:a05:7022:f106:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-11f34c39ad8mr4006843c88.7.1765898866709; Tue, 16 Dec 2025
 07:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20251206023106.8875-1-timur.kristof@gmail.com>
In-Reply-To: <20251206023106.8875-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:27:34 -0500
X-Gm-Features: AQt7F2oeOUEw9f5NNkwm_2JKcelRiqmLTawng1F9YNchRQMIcmQqIN4YZ-Bf3Lw
Message-ID: <CADnq5_PhBodb6o9LHi6e5Y8yQUaJyTa_EvMyWFpmmfrpZrUkuA@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/display: DC analog connector fixes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
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

On Fri, Dec 5, 2025 at 9:49=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Fix a few issues with the initial DC analog connector
> implementation that I've noticed since. I highly recommend
> to backport this series to kernel versions that include
> the DC analog series.

Did you have an update for this series, or are they ready to be applied?

Alex

>
> Timur Krist=C3=B3f (5):
>   drm/amd/display: Pass proper DAC encoder ID to VBIOS
>   drm/amd/display: Correct color depth for SelectCRTC_Source
>   drm/amd/display: Add missing encoder setup to DACnEncoderControl
>   drm/amd/display: Setup DAC encoder before using it
>   drm/amd/display: Don't repeat DAC load detection
>
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 +-
>  .../drm/amd/display/dc/bios/command_table.c   | 44 +++++++++++++++----
>  .../drm/amd/display/dc/bios/command_table.h   |  4 +-
>  .../drm/amd/display/dc/dce/dce_link_encoder.c |  2 +
>  .../amd/display/dc/dce/dce_stream_encoder.c   | 25 ++++++++++-
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 28 +-----------
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>  .../amd/display/dc/inc/hw/stream_encoder.h    |  4 ++
>  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 ++
>  .../drm/amd/display/dc/link/link_detection.c  |  7 ++-
>  .../drm/amd/display/dc/link/link_factory.c    | 10 ++---
>  .../dc/resource/dce110/dce110_resource.c      |  2 +
>  .../amd/display/include/bios_parser_types.h   |  2 +-
>  13 files changed, 87 insertions(+), 51 deletions(-)
>
> --
> 2.52.0
>
