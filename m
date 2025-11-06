Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF501CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 22:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421F310E9E1;
	Thu,  6 Nov 2025 22:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="js5ymLPi";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E59310E9E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 22:15:29 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-26808b24a00so188235ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762467328; x=1763072128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFbVBy23JFi73x7v/I6mQS7rFCPcNQjkSd0+MQ23IeE=;
 b=js5ymLPiOb/ieFZtBXBNDtZhtr5qIl9RqV1G8F1a7iJOTj/eMGmHDVPnU76pBsZ9TB
 zP7UyeWwr3IrJQlByLt87fxc2KZEVK2KlHArjRU1wrkfloEJoofNWmA4zPbPn7wmd6Df
 fB0EWh39/VvQ///gbb/2QaPILDjbn2O+91/N6qr0yIkF5/vbeSmqx56RwkQFzGdQ7Apv
 0XiO4MJDsGNKfHxCIBd/OVWBeBCg7BG0PiuK0oNLacu+myvBlmw9f1X7iE0i/WRSr31G
 YOqhvPgIA6DCr4ZISTewde4CR7Y9o3WRHuIFjMJDd1Lb20IIo6ClkXdzKce3QCMaH+Vg
 WXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762467328; x=1763072128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hFbVBy23JFi73x7v/I6mQS7rFCPcNQjkSd0+MQ23IeE=;
 b=RetfjSnYc/+I9Bya7A2r9YKReTi78ogiS6peHSUn/rv2WEogshJREyV07b6MF4GNYv
 VaIeIBODcQAmfjyW18UK5Z7tiF3NfGp5xp9eipLloAPNYWm0aq6KbjjWE+WAM4qPc9fQ
 2eyjWfkfkcE4Tuo8VAfqO2FGOc5MvkZVcJF1jnelJ2RF0yoQbhD8dzp/aNEcTTwLv6iw
 OYSaNjhEiuzE6pAMNGbdL0Kr/moo2OIdmtxgcextu0bTtifMBON5L1TCREKvDl+or4gB
 VsyaCktTTuCbJ84uWi+ETroc8Nk+hKVd1e0coP6w7H8/58GI88bUbkVFS4RK/BbT0e3U
 RDrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyfVkHmqA8x2oE12+h2kF5Zp0WogyALiCvNWav0BTYWcrnW+cM53cRSu0TmRbb6PO55BqUdrjF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywgy1a0hr3DfiALhy23lIM7oinURrD52OTl9fRfDVpcDXbl3OgJ
 Xqz+tn1E8rii+Nbj2mI48PvzLYCv1LXsR1nAuZ3TE0S2Tx8nSncQEXIShIaminRAvAR7yqOoMJd
 tHuCPQw1MTdY+0EqY2MSBjU7NLMI01Zg=
X-Gm-Gg: ASbGncvNsIxs8giObu6gdZNO1Rh+XTnVkXQRgrXmRtApwH1591M7AONFEmC/+gXQtc3
 PDFYhsdFLUQs44S6PFYxzHiUfqOPG7cO/yw/XJJ471tFW25boxrVvxqp0JqgBzmWXVMIwXSKpMn
 ZvmS/O3NxJSSV/BWPP254Z3gIDzDJ+7FpuvyQ3v+PgySpIRWz07pz935RWtxRToeJu+SofvFY+d
 FWNvK0WFFy1abB6KrEJDUEaFKKKF9gB34RItbjfNSwl7EYXmo+CC4lnNT1CeIO/Qhzmnbw=
X-Google-Smtp-Source: AGHT+IGqwGoOUWDFY6dh2ifm8TVRrNhSW4FormSfF4uK/ekGzwDtMamFINaUhULvi9Rt79bvvWmVztN/zzDf1g193Kg=
X-Received: by 2002:a17:903:1a8b:b0:295:247c:fb7e with SMTP id
 d9443c01a7336-297c04dc124mr7179035ad.11.1762467328307; Thu, 06 Nov 2025
 14:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20251020161606.67812-1-siqueira@igalia.com>
In-Reply-To: <20251020161606.67812-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 17:15:16 -0500
X-Gm-Features: AWmQ_bnSKeGEX1z2vJQLBZGQ-6bevVxK57OxGvXJvuRjclMYgsnY8c2q_HOhPdI
Message-ID: <CADnq5_O9p7HakQK6BvweqqsNzj0WAxkx91r1co=0Eq9AgHpPXA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org, 
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

On Mon, Oct 20, 2025 at 12:16=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> set of errors happens and the system gets unstable:
>
> [..]
>  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test=
 failed on gfx_0.0.0 (-110).
>  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> [..]
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comman=
d: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comman=
d: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> [..]
>
> When the driver initializes the GPU, the PSP validates all the firmware
> loaded, and after that, it is not possible to load any other firmware
> unless the device is reset. What is happening in the load/unload
> situation is that PSP halts the GC engine because it suspects that
> something is amiss. To address this issue, this commit ensures that the
> GPU is reset (mode 2 reset) in the unload sequence.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0d5585bc3b04..0a7bcb2d5a50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3649,6 +3649,13 @@ static int amdgpu_device_ip_fini_early(struct amdg=
pu_device *adev)
>                                 "failed to release exclusive mode on fini=
\n");
>         }
>
> +       /* Reset the device before entirely removing it to avoid load iss=
ues
> +        * caused by firmware validation.
> +        */
> +
> +       if (r)
> +               dev_err(adev->dev, "asic reset on %s failed\n", __func__)=
;
> +

I think this will break certain navi32 boards due to another quirk
they have. See

commit 7c1d9e10e6643121f1ffe9c0903467cc8682eba8
Author: Kenneth Feng <kenneth.feng@amd.com>
Date:   Thu Mar 28 11:00:50 2024 +0800

    drm/amd/pm: fix the high voltage issue after unload

    fix the high voltage issue after unload on smu 13.0.10

    Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
    Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


It would probably be best to limit this to small APUs.  Something like:

if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu)
        r =3D amdgpu_asic_reset(adev);

dGPUs should already be covered by the need_reset_on_init() logic so
there is no need to reset them.

Alex

>         return 0;
>  }
>
> --
> 2.51.0
>
