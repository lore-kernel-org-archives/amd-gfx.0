Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54358C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 14:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73D610E488;
	Mon,  7 Apr 2025 14:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gL/8i1Zf";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8290110E482
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 14:18:22 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-30363975406so839122a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744035502; x=1744640302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWX29h/XCFZL7IoGKQlLjxYjLTFGDstQ0MQTDFiDHpQ=;
 b=gL/8i1ZfZwL0rF4sdIT3RQ6gog4kvNPt7/bfAVDIzk5SnRBPSU5ltDbaqC1z6Pqutv
 Z3LdbbJXMSkyJgi+92aRDLVTwJU1cdCoYgNHkusEUvbAhO1zTscNKvOJ7qoBmDEucsSB
 zyRn40HCpqqGvbpKy5YEMLkJpiVBs6ft5ur/RfPWG/3YAkpfiI54bMpc7ad5d6as9Z/K
 MnUR25AtAw97j41+HMxNYjTy4RZvLmH1iIcfnWDTFLp1ZMsbkHvIoZhL0nqLcEWXg4/o
 kMGJuzonFdp7/GEzTz+Q49uBU2+JWboYOyMKcGmENFOnMXACXlefHTOr0w1zZ1yRp1hN
 UUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035502; x=1744640302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWX29h/XCFZL7IoGKQlLjxYjLTFGDstQ0MQTDFiDHpQ=;
 b=DT4bOkXVLg1PCEuPqAKimoYo5U2QY8MOCUZunNEpI5+vPzKkbT3TchSVUAOEYSymUP
 WG0TbJOE+M+xIYQgO55UnPSM6Hut6LaX2fppTKI8pPwcGqx/tOdVnkHmpimE+T09k9KE
 apf8Ha6dhay7+asrOC6mc8M/NO40qcgMq9tOpKluAstKHk3WkFl5p4j59bFH2/3FIt/g
 gQUs64JsZD1Xox0dp98vZHuK79FZAqKGQL7zw5jH+VPxbxth0SPShdysUki4mUSqB3dA
 cF5TxAlk3L1Zm57rGobAuruMf04uHso7R2dxVdRDuHVie4XyPIQ/xMn9o3yoelNqzOcl
 h4IQ==
X-Gm-Message-State: AOJu0YwO981RHlnl8KaK66tqu/9jNlsOH8RhFLd9Ya3nBwCGyXlrMqKL
 qhjys0R9ZAEMZ9sTPs+0VFFvih5yq6zbRVd45IQvdPTPIVAbjiQCfSPiCwCRJrcijXAuX3K5loh
 OJIyjZ+aHNp+2U1eqdtVfUeMhuuQhAw==
X-Gm-Gg: ASbGncuRvDXcKgG/vInhGi3R2rJ9ZZGohfe7YYsQpFMA8PtZyqziTi9XIevkQsZ03Is
 PL76Kgt2Nh8CESa5mXFDIvIfy3YzDQLOcinGdj3frA8SU6jAB2KY3LgPzxgL9Xfno+jK7r+4wf3
 GBDEgXcpYjWQIpGLyIB3vrZdLY2A==
X-Google-Smtp-Source: AGHT+IG9ZHust3a0b4a8GpriKEXc9BeaTAoewXRWFlSBkqmXuaE3xujYv3oILRw7q7Wguv6NZ6zU6ow0by0kcxGa9+E=
X-Received: by 2002:a17:90a:d006:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-306b6ae4e3bmr3468240a91.3.1744035501975; Mon, 07 Apr 2025
 07:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250326175122.1209403-1-alexander.deucher@amd.com>
In-Reply-To: <20250326175122.1209403-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 10:18:09 -0400
X-Gm-Features: ATxdqUEouQrUAVDlWlhX3exxreydhXEYGFdgLoaZo30V5-P9IHXcDiqOekeOlIE
Message-ID: <CADnq5_MsT6FD0g00H=DxuNj6B83nW8D47Y0k73b9Wavf0JXJkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: update KIQ documentation
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

Ping on this series?


Alex

On Wed, Mar 26, 2025 at 1:52=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> KIQ is replaced with MES on GFX 11 and newer.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/driver-core.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu=
/amdgpu/driver-core.rst
> index 7e3f5d1e9aaf4..81256318e93cf 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -140,7 +140,8 @@ Some useful constructs:
>  KIQ (Kernel Interface Queue)
>      This is a control queue used by the kernel driver to manage other gf=
x
>      and compute queues on the GFX/compute engine.  You can use it to
> -    map/unmap additional queues, etc.
> +    map/unmap additional queues, etc.  This is replaced by MES on
> +    GFX 11 and newer hardware.
>
>  IB (Indirect Buffer)
>      A command buffer for a particular engine.  Rather than writing
> --
> 2.49.0
>
