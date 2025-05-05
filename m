Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CF0C3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 14:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A441C10E2B1;
	Mon,  5 May 2025 14:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVoGwsW8";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1110E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 14:46:53 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so496279a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 May 2025 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746456413; x=1747061213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GAXZpsUcmngHt0/CSRdI+uKfipejSiPDN+4JBvghwQ=;
 b=UVoGwsW8goXxIDqhVQzTA0LBOon2xkODIPwvB6YIA6Y18/nc/GvM0E3nfHjXoCWpjz
 Kg2ttIHPunu/8F7VGQLhfxrrQlJsjESn3H7UIhGx+bp3jNbfrj2ODEIqbNlZF9apZ1MA
 YfT5FqeJcOjtvGVincdt9bnOvo91MvdE3zZTqp5QJKBnKFZs1VgkXDZeCb4r+bjGduEQ
 A+EpBWGpPNM5MvqBUN5FWHkPHeSznM+3vb/02oA+4LbwNjssmaQGWUU3/H1/eMRbIzKD
 VEFP/MBOn6/Yp3kQQCQvrvCpJurlUXe3dptDYXSs0mJie4ApdFxt84eJUGGx1cu9NGy6
 Y+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746456413; x=1747061213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GAXZpsUcmngHt0/CSRdI+uKfipejSiPDN+4JBvghwQ=;
 b=wGppCdb8vNupXXefx1tPUuOS5xBNBmi0KpzCz/gdCHBqumPH6riyE2Kt0QGtQjPxzA
 a3PtUgHhqz0v5TAxdMrHQjA01ik3yfAa3pYrKiR8KwXmJg9ww9UjuP74XWItMmBtVpn6
 HoCl7n0qW8MaAtCFk25aw5/fHRSlA9LjcsD1a3k3fhKuAqHL0PX2r4I19wwiGIWQFVHd
 AuIdJho8sasj2xvqK3mBIrT+T+PpFqcUW+LS4kaoO7+Txf72Ee6TeYVUyjquFzVWIyKW
 ppqPEMdZkALdTfVJeTdc3VmbrV97m8dymasMWCUpiI8V6fnB6wtdEPyjE2bhfcTWzQBy
 VkxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4JSuIynnLAmuptfhokZKmCmOE8EneiR9Cyq82OtvIQy3WLR4x0o2IV8A9E4hLlAZV/kZ2F6HD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqPpZrQyZjLB5AqbeB3/m65YV1T6SzNp2FwRKldeXLaR2DqGPA
 kveXsvVbHrmUulcjeQAj9Hd17Xo9T/83F/y3IfcP2qcCU5oehFl96U7bX1ZF+9zDcyhRyqevQiI
 SptiRuiEscrKvfRKB1Ne2aMJIyqk=
X-Gm-Gg: ASbGncvuzCph46bNoXe/4wXfKnan8R6PXFssq8NP2nftgKUuzOagErhsaVUERn9NOwq
 Smm3W6zYpnAFb4N149VEpphUBJFcxNryDo9c0CELAdOgPTQOWyiqhConTW5/ZrXjyAIEVNZmhEx
 2a99xRex0NBjsIEaeFxm66AQ==
X-Google-Smtp-Source: AGHT+IFnNTggMv2dr65UUWRJg3W3WcTZjt3IqZp8zFwPDM+0dgzmzDPaakj3HLV4SUgFX/in2AgxP8ca02CsRQ+FgDY=
X-Received: by 2002:a17:90b:3a89:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-30a4e57aeabmr7483083a91.2.1746456412671; Mon, 05 May 2025
 07:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250503203905.346049-1-siqueira@igalia.com>
 <20250503203905.346049-3-siqueira@igalia.com>
In-Reply-To: <20250503203905.346049-3-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 May 2025 10:46:41 -0400
X-Gm-Features: ATxdqUEtP76MSfco7Mit7MoYbwszoWZV2_10INtfvv9Twtd0B9gKbtd1ef0SaWY
Message-ID: <CADnq5_MtqdyO=+eWKMBM2nNwb8S7=nU6gdRmcF_uc8Qrce-+mA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Documentation/gpu: Add new entries to amdgpu
 glossary
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

Applied the series with some minor tweaks.

Alex

On Sat, May 3, 2025 at 4:39=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.co=
m> wrote:
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 8e6af7cc76c2..70aceff4bdc6 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -24,6 +24,9 @@ we have a dedicated glossary for Display Core at
>      CIK
>        Sea Islands
>
> +    CB
> +      Color Buffer
> +
>      CP
>        Command Processor
>
> @@ -39,6 +42,9 @@ we have a dedicated glossary for Display Core at
>      CU
>        Compute Unit
>
> +    DB
> +      Depth Buffer
> +
>      DFS
>        Digital Frequency Synthesizer
>
> @@ -63,6 +69,12 @@ we have a dedicated glossary for Display Core at
>      GC
>        Graphics and Compute
>
> +    GDS
> +      Global Data Share
> +
> +    GE
> +      Geometry Engine
> +
>      GMC
>        Graphic Memory Controller
>
> @@ -128,6 +140,9 @@ we have a dedicated glossary for Display Core at
>      MQD
>        Memory Queue Descriptor
>
> +    PA
> +      Primitive Assembler / Physical Address
> +
>      PFP
>        Pre-Fetch Parser (Graphics)
>
> @@ -146,6 +161,9 @@ we have a dedicated glossary for Display Core at
>        the GFX block. It's involved in GFX power management and SR-IOV, a=
mong
>        other things.
>
> +    SC
> +      Scan Converter
> +
>      SDMA
>        System DMA
>
> @@ -164,6 +182,9 @@ we have a dedicated glossary for Display Core at
>      SMU/SMC
>        System Management Unit / System Management Controller
>
> +    SPI
> +      Shader Processor Input
> +
>      SRLC
>        Save/Restore List Control
>
> @@ -176,6 +197,9 @@ we have a dedicated glossary for Display Core at
>      SS
>        Spread Spectrum
>
> +    SX
> +      Shader Execution / Shader Export
> +
>      TA
>        Trusted Application
>
> @@ -185,6 +209,9 @@ we have a dedicated glossary for Display Core at
>      TOC
>        Table of Contents
>
> +    UMSCH
> +      User Mode Scheduler
> +
>      UVD
>        Unified Video Decoder
>
> @@ -202,3 +229,9 @@ we have a dedicated glossary for Display Core at
>
>      VPE
>        Video Processing Engine
> +
> +    XCC
> +      Accelerator Core Complex
> +
> +    XCP
> +      Accelerator Core Partition
> --
> 2.47.2
>
