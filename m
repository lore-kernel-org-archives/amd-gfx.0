Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F4D3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D249210E462;
	Mon,  8 Dec 2025 15:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XtLJLm+i";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D1C10E462
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:30:47 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-295351ad2f5so9173085ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765207847; x=1765812647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXSfokaMdRzeD3CmctFW59fBi2/hwICOIdomtQqlViA=;
 b=XtLJLm+itmKGTu8ZGYdv966NbALGogMgLfsACBJBr/CZrebMFZSs+xZog3wxwfMBjV
 FEJtzSGa11qmlNBuPQ0biGAmCJ7VtolApCK91gMwzUqFWsrb/csXsRDFykDdiLRs1jjM
 2rrST4hewdJwXwLGhJ1UWQGkWe3HH9jH+iKNn+DjnfhFFA7qpoagQEUmd26Y07KzepOO
 9uhbAakLgqfjAsWh1M6h9sT/+O1JNuZCxYFqELRnx3mNdsLMJaUxgl5ovKQdtWGPKXQW
 s82IERQn2GPo4QeS0Nr53PcvlhobL3D/F6T0kMpL2lJvuzysGSNEMu3i7ERqXT5v6kuB
 WibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765207847; x=1765812647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nXSfokaMdRzeD3CmctFW59fBi2/hwICOIdomtQqlViA=;
 b=mveU5Jxn105mgsIJGtHDPitkZbKkt5C9/prhmCgpPskpOS31mREZyqjUAlER6qrLOG
 Yuf4oSEg3V8OD7nBvFVGLWs2mJka0SbepD65dZiGSqSeudfnHmOkqaq+qugX86R9eR8q
 GJBTHrkA86XwlmbQuKqJAkX0B5PCS5B2CWBIFiljG+Ma4U3xgZ1SdfN6GC1leLXYEzRg
 V9MPxEm/yUPVa9bc/BSV5Emtw8k9CtSjYF7bh1nY1pRD6EJXbo4zsnb/kcR6bArlsKB5
 WJixX6zpYwAyt35GLyPIB2XOf4j86SYl5P105zoBhDklRzsyT0UwbsDVXFv2GwrGwpRx
 Er1w==
X-Gm-Message-State: AOJu0YyWg1kjsAWkG+HAF+h4WFno12O6PualqSj+ZI7EUWc3sk5TUx/y
 otYXUXGW9FRfIkS7e+EvjCGkplZkUqkTMYWT8k4aKfLhWJach3ak62fZkzI7WpUnYRrEDaXWZDJ
 wB5gMaT7E+k9nwBiYJIuiKh8moSW23u9NHJCB
X-Gm-Gg: ASbGncvdKx8LKmNFcThZwYEm1tAG2GOfz0OaKDRq3p1N5yFR3pqPNnU12EvtPMlJm0M
 BzRZyML/z56qc/E5DzlGMEhLyKEm05ATtEnXGwFhPIrzXMbOTn4zEBgITwalGgWy+IVh+jqLnVF
 xtXMMSvbxSr5IsCaCNqO/lotNceraW689PzyOcNLkVc8zLwSflLElyMiYRQ+oROsCeZbcJRtf50
 hV1WwkjxhaSuInIrdzzYkfQVvj0X/h/wloQC5Ww2gZ+xApd6CUfQdi7QYtOcIOTOpWFTw0=
X-Google-Smtp-Source: AGHT+IFLlVtEXHAoLG6W/wc2zPIXqTLbUB6MnJjfXQOs6qfiQrbYYPw8kTjw+tr5e7qow/7Py1ndOvMs2H/wuyXorOw=
X-Received: by 2002:a05:701b:2405:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-11e03e944dfmr2060000c88.6.1765207846764; Mon, 08 Dec 2025
 07:30:46 -0800 (PST)
MIME-Version: 1.0
References: <aa6e3fd2f20baf83d5bf56f880bf01e975829cd2.camel@northeastern.edu>
In-Reply-To: <aa6e3fd2f20baf83d5bf56f880bf01e975829cd2.camel@northeastern.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 10:30:35 -0500
X-Gm-Features: AQt7F2odrttwaWajJiR3uOYtuOsXiUouHYre73940KYxJpDMgcC_juVOwbd2vb0
Message-ID: <CADnq5_Mw6qYxYp_Vdo8R9hCtagxuDetgQFjNT_Y798g1vN7A1Q@mail.gmail.com>
Subject: Re: [bug 6.18] Failures and Resets on GFX1037
To: Mack Wang <wang.yunche@northeastern.edu>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Dec 8, 2025 at 8:59=E2=80=AFAM Mack Wang <wang.yunche@northeastern.=
edu> wrote:
>
> Hi,
>
> Starting from kernel version 6.18 I'm experiencing frequent failures and
> resets of the GPU, rendering the computer nearly unusable. The screen wou=
ld
> flicker, and eventually blackout (most of the cases) or recover (fewer ca=
ses).
> Even if I switch to another GPU and have Radeon GPU only for rendering, i=
t can
> fail and eventually kill the app that is running on it. The problem isn't
> present in 6.17.
>
> My dmesg logs show something like this (a successful reset):
>
> [  585.109939] amdgpu 0000:06:00.0: amdgpu: Dumping IP State
> [  585.111758] amdgpu 0000:06:00.0: amdgpu: Dumping IP State Completed
> [  585.111839] amdgpu 0000:06:00.0: amdgpu: [drm] AMDGPU device coredump =
file
> has been created
> [  585.111841] amdgpu 0000:06:00.0: amdgpu: [drm] Check your
> /sys/class/drm/card2/device/devcoredump/data
> [  585.111844] amdgpu 0000:06:00.0: amdgpu: ring gfx_0.1.0 timeout, signa=
led
> seq=3D31692, emitted seq=3D31694
> [  585.111847] amdgpu 0000:06:00.0: amdgpu:  Process kwin_wayland pid 114
> thread kwin_wayla:cs0 pid 514
> [  585.111849] amdgpu 0000:06:00.0: amdgpu: Starting gfx_0.1.0 ring reset
> [  585.269485] amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.1.0 reset failed
> [  585.269490] amdgpu 0000:06:00.0: amdgpu: GPU reset begin!. Source:  1
> [  585.331433] amdgpu 0000:06:00.0: amdgpu: MODE2 reset
> [  585.338731] amdgpu 0000:06:00.0: amdgpu: GPU reset succeeded, trying t=
o
> resume
> [  585.339090] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00=
000).
> [  585.339113] amdgpu 0000:06:00.0: amdgpu: PSP is resuming...
> [  585.361053] amdgpu 0000:06:00.0: amdgpu: reserve 0xa00000 from 0xf41e0=
00000
> for PSP TMR
> [  585.593433] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode is=
 not
> available
> [  585.602279] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode is=
 not
> available
> [  585.602281] amdgpu 0000:06:00.0: amdgpu: SECUREDISPLAY: optional
> securedisplay ta ucode is not available
> [  585.602282] amdgpu 0000:06:00.0: amdgpu: SMU is resuming...
> [  585.602569] amdgpu 0000:06:00.0: amdgpu: SMU is resumed successfully!
> [  585.602750] amdgpu 0000:06:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0
> [  585.607508] amdgpu 0000:06:00.0: amdgpu: [drm] DMUB hardware initializ=
ed:
> version=3D0x05002C00
> [  585.880737] amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 uses VM inv en=
g 0
> on hub 0
> [  585.880742] amdgpu 0000:06:00.0: amdgpu: ring gfx_0.1.0 uses VM inv en=
g 1
> on hub 0
> [  585.880743] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv e=
ng 4
> on hub 0
> [  585.880744] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv e=
ng 5
> on hub 0
> [  585.880745] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv e=
ng 6
> on hub 0
> [  585.880746] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv e=
ng 7
> on hub 0
> [  585.880747] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv e=
ng 8
> on hub 0
> [  585.880748] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv e=
ng 9
> on hub 0
> [  585.880749] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv e=
ng 10
> on hub 0
> [  585.880751] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv e=
ng 11
> on hub 0
> [  585.880752] amdgpu 0000:06:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv =
eng
> 12 on hub 0
> [  585.880753] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 13=
 on
> hub 0
> [  585.880754] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec_0 uses VM inv en=
g 0
> on hub 8
> [  585.880755] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv =
eng 1
> on hub 8
> [  585.880756] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv =
eng 4
> on hub 8
> [  585.880757] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv eng=
 5 on
> hub 8
> [  585.884345] amdgpu 0000:06:00.0: amdgpu: GPU reset(1) succeeded!
> [  585.884371] amdgpu 0000:06:00.0: [drm] device wedged, but recovered th=
rough
> reset
> [  585.897300] amdgpu 0000:06:00.0: amdgpu: [drm] *ERROR* Failed to initi=
alize
> parser -125!
>
> I'm on an ASUS laptop with Ryzen 7940HX/Radeon 610M. I'm using a distribu=
tion
> kernel, but the maintainers are slow to respond, so forgive me for sendin=
g
> messages here. I use a custom kernel command line amdgpu.dcdebugmask=3D0x=
10 to
> work around kernel lockup problems, which is a separate problem that's be=
en
> around since ~6.12.
>
> I've collected more dmesg logs other than what's shown above, as well as
> device coredumps from /sys/class/drm/card/device/devcoredump/data. I'm al=
so
> happy to help with bisecting the problem if it's not too large. Let me kn=
ow
> how I could help.

Please file a ticket here:
https://gitlab.freedesktop.org/drm/amd/-/issues
and if you could bisect, that would be really helpful.

Thanks!

Alex
