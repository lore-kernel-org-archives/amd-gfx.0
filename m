Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D71CCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 22:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3804310E535;
	Mon, 20 Oct 2025 22:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gLsg4lgH";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0702210E535
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 22:37:04 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-290a33bfea6so6482735ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760999823; x=1761604623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3F8kEjxl3GZo7Fb6IKYom5rD8JkawAG6v5GIH7aUxYM=;
 b=gLsg4lgH1H0IMK8TmWry3PYThMsB3Xrz3LFgkqQ03f7OKR0JN+fsLtMdEQGLX5yGr1
 M5pYgDjx1ZMBz/COanbytX/urvMFub5XLgFrek0QpidA7ldycdobK2Nc5j+jr7SnHju+
 d3DVx8Vz4t7ANOAeeFjQR6c9bht0kE3HL3TE/iW2sgIRICa6wBjHzC1hzUvG1R8RkAMM
 lR0bPvYF33rGOIMQdb6dCog1j6l9ABDLp1UkrAA42Q2KT3apxME9VA8LWD2Gb8uhpWqH
 gbuoU6XxELCTdcIAQTwASkqiQtbAzF/dGSYE1D5LTlbFRheHaOu0wOpw+/oFdPJjBN06
 fmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760999823; x=1761604623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3F8kEjxl3GZo7Fb6IKYom5rD8JkawAG6v5GIH7aUxYM=;
 b=YIbLFNsF4y1cpMZ1T/5kR5/0IoxyJOVGuScXRFpraSkV2lwfK+An3qsTVriQg79yuj
 VXkYKB7Dhn+ohhP+ighbFiGZ8JnDaFgnMOE47WDGG/qZisynyzf1yXYWjbDQcav01KlS
 Qki9c19P+cmtMhorb+Byeyk6PRBIiiJct73C6dIXk1y1BWH10y24WlbYwm0LYz3yfbNO
 x87JqNRNaZhDFCiFl/iZ0p5Qw1+E9cYELHfYyqtF1zAOhJVNUdBol7pWv+2FMNo2cAXf
 au/f0CuhjJvA1kgwJK32iohuGXolKdCdi415rZ/Oh8uQxcSgYBo/zNMEm1BeFpCjIIKz
 F/jg==
X-Gm-Message-State: AOJu0YzO6532orWwTPVR0UkHPfLV3Nvdw4j37IZp2QGz4h5hPdGzhu+x
 eefbWo6vxm8TWXVaO0ShuwRNThyHdKxMbS6vfWjeT9daGoH062RDL6G29wINLJXDm7DMaTbdejd
 hkeG90CHyH5T6LoFD2ftg+n111te69us=
X-Gm-Gg: ASbGncv69ii6SV4Ftxq1M77romW1uWEzzA/3DSc6JNs7Yzzpa0BUt66VsKuMDVfrhuf
 f+V9eK969Eb3d4q+1bmiRbXmEf8Lk4ED7uK4h/YfsXCZlQZ5KXJ6fpljqy2wrbN9LYy5RXUVy+Y
 Td/NCriuElRNZDXhdNYl8ac6slHsXV4ezf3saeqtdi5M1vVRvCCzu2ZoyMK4dJyUIOdVNaNOBZF
 ANfWDxNZMpJgtFFilYpaRtP2JKYza5dfc4VjCev80VUOiOVLS0lXpfCcCK3
X-Google-Smtp-Source: AGHT+IEjJsD4lwTMZU8SCWnFGMQhvt8csQFxanvmaSEnUPrXzmiNzYPorcXAm+yRXLH3p/Nc3Yygx4ZStLTCZHbDUXc=
X-Received: by 2002:a17:903:244f:b0:28e:c6ff:a1d1 with SMTP id
 d9443c01a7336-290ca218a7fmr98217345ad.5.1760999823391; Mon, 20 Oct 2025
 15:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251020223434.5977-1-mario.limonciello@amd.com>
In-Reply-To: <20251020223434.5977-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 18:36:51 -0400
X-Gm-Features: AS18NWBuPr9x-8SexF-JSjyEyHqvA4n3vgla5o3k8taWT3hE0nBOftWwV9eBga8
Message-ID: <CADnq5_P1wajQ_NSwqOrh2XprRJ5eQC=QjQGEAz_t=DCa5efLmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
 Sultan Alsawaf <sultan@kerneltoast.com>
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

On Mon, Oct 20, 2025 at 6:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Adjusting the idle handler for DPM0 handling forgot a return statement
> which causes the system to not be able to enter s0i3.
>
> Add the missing return statement.
>
> Cc: stable@vger.kernel.org
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index f4932339d79d..aa78c2ee9e21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -356,6 +356,7 @@ static void vpe_idle_work_handler(struct work_struct =
*work)
>                 goto reschedule;
>
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VP=
E, AMD_PG_STATE_GATE);
> +       return;
>
>  reschedule:
>         schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> --
> 2.49.0
>
