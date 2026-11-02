Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20794606A33F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n7/Ux5f9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8C610E4FC;
	Mon,  2 Nov 2026 14:10:04 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB11910EED0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 14:09:57 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-35159e0092aso328713eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 06:09:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793628597; cv=none;
 d=google.com; s=arc-20260327;
 b=XYLYHUFsd5FrKXa+46ffB2vmiYFnZNZz8uNpvtztDImxXYSGXjwrrT+GkAjY65McTS
 YliHBU6hVwMSjfMP2QV6Z6vZKhe+wPOxQzMedP1JRHkYJd3g2MbN3hj6giXxvVcH37MM
 HKU33YXWJ+6sLIyeZzqM3UMCnoTfwWA0+4Uvsu2pR9HYGCxjbaPwN+r7oBXvM60zJb//
 E8pq3jADNT2erX205v/+UjxHONkvHq7BY9FK3sly9PCjv/1Af7GUzE37aEGv//dHjvEB
 nYwr6t2s8rm11Ht0g3tW/EhcNAKjiKsTpUGVl3lFjH/PJ2nkFvs9rqekYAzb+S5DpqQ/
 45/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BA4eR/Y18lLoJIgYyk0kRPwZOmosI6/4taftCvPvg6U=;
 fh=9qt+zuMWvVgdHs5tU67lDs2e/pJtUSe30a+3f4TwHBc=;
 b=py5xBcEQaEJPv/nh+15SaNjCToKOKdliMR7Ep3A9EM9SwoSMxl6jfjXrlsXsMwjf2T
 RWRgb4ZxtwxlATaenFx9i5GD0RkfZOwui7odbxk+Id+gS7GNINhd5SRHJ2C/iV7o3fhW
 aTOZ6w/S5RGYkwtqeK+/s5/ozLHiSzVujwhWSIs3+q10TIbHP/XXWRcymicX1ExPG8rZ
 TCtpc64OoQJdXCnAqlgxXorLG8YQHWIM84LVGPom/nMPPxnJylAFektHWZicMAz69ufk
 6WY3eLTlLgLUQ7lF3v+E8ahZgIQm9VR+bcaLwdiHEbSXn2W/qO9zHnomOJKLRxnvAhJb
 hxfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793628597; x=1794233397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BA4eR/Y18lLoJIgYyk0kRPwZOmosI6/4taftCvPvg6U=;
 b=n7/Ux5f9tN26bytwZn7FUifkj+B5zZ8Mply/75GpWD1nWfCth6Q5oIti95SSnW88Xt
 9E8G19VD01LfwHagHuFD8gWmQ6Qm5o8AnY8PWgq86dqv+R1gzrwwAhwZvPaJOy6ctEvw
 a6t4Tdx7uSq1SLwhaAXKcclmRerFPjFLiy/Ne6L4ZLWbKH+pWjzmMIIUM2//u14ixRkj
 0ROCQ+t4SwBnmQU1zrQJ6ynHQHBXvQ90NBZMlTWmUT79iWi1x9UoYrPnkuuoFrD65Ybr
 A/1Z6W/LBdahOPZuuKLyFURkETRWqlZFCxSIRErWG+k/avzur5wNY88dAWUbvmWI6eeP
 JAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793628597; x=1794233397;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BA4eR/Y18lLoJIgYyk0kRPwZOmosI6/4taftCvPvg6U=;
 b=nQNYlHgwIBk7DJuk4ibup41p3wxBusCXyF80pzd4ASTHKhI1YTVbccwzYSYINnc6Ri
 5a9faT+FjWkkyGO1NA3KaBW/ee6sVAwKW6uHqB7841L84MvdutsQ44RCnsGKKYECSjXW
 LPURewghAhpwye42RPFcJ2lk40s7jss/0rxKR4ncUikkp/f84DWszGPX8kD32CTyjn0v
 t35NPMtEEIuGDnoGsA5w3KLjoqHuMbkOvf4mNmxyjVLOX0YkHXYE/R1EmPMMo067vssT
 5TTPc5FPqs4lxSXdhfPlPOcdfdq5dHcHbxEGcGSL+YQHUaeg1i0wJs3GMHSc8MWhlD96
 zXiQ==
X-Gm-Message-State: AFq9FYJgiGxSfPtmKPPjKbnPa5bk/v+pVQFS+7KKgM4coh8wupS6k+H4
 4Ie83OqLE0dtLDf1iQDJr+dVDMzXsM1Y2lKOwvb5z15m6cTRBBYquhtDPWHHzAvfYdJnEqKjKNp
 qOin5q6hpvqfVNp3wo6kBafEAqktnwMc=
X-Gm-Gg: AYBFou3GmEeSSnP/Qfzcswt2SK4LZpg07mgZGzjCE428abK/VGlJIm5oBrEr7AystCt
 6ku38QxhQpJMp7TFfOgbBpTz5tWobfihsCz7RwFN3wWGROmNUjoQgHI00KvsqMOuAfaanBU4QBC
 8w10Dv/G4slPh0/eyc/kFtxWxp60+QFmlzJ0xnHNq7KI8gdOoioidrkThvxXk8w74FH8JXkZdPH
 RvDBdv2ZBAfzMqrUDYH71/GEeZ96Kfs7/77fBmJkPwOepq9TOHp9nTLjqIu44pareHHph58hzOD
 RU3yj+9hqBh7eFCa0cl0S+Ju/0+ZmVjqcvyu81YPADiYN4mI+TfD1vsO88P43y0KrBM5I8z2gfI
 BXLXFy2ijEmFB0GX05C2NgxX4AnrqFdpZCpkAdUIuy3W/DhPZhbAs0nfORdAMvbAhrc0jGcNfVz
 EaGLgCIPoa4lxxZoDQv7UwlGA=
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr25688334c88.0.1793628596924; Mon, 02 Nov 2026
 06:09:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CACOV87VBmya0PKjni5xEYxUaEczk9X_UoUHXSR_HDS2kSJnM2g@mail.gmail.com>
In-Reply-To: <CACOV87VBmya0PKjni5xEYxUaEczk9X_UoUHXSR_HDS2kSJnM2g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 09:09:44 -0500
X-Gm-Features: AclHuK_vRhBeW5Eh56Hb7eNcMb7wVqdQhlqpXQtPfp3uOOkJmrZWy5xmkaRSbEw
Message-ID: <CADnq5_MzmNYq0WA5HFaOp6E3WO82YqTT5opCgkAbvv=9Q8AQnw@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: Navi 23 passthrough fails after ef5fcf2a6c32
To: Nathan Blomquist <nblomquist@gmail.com>,
 Guangshuo Li <lgs201920130244@gmail.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev, 
 alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 3:16=E2=80=AFAM Nathan Blomquist <nblomquist@gmail.c=
om> wrote:
>
> Hi,
>
> I can reproduce a Navi 23 / RX 6600 (1002:73ff) passthrough failure on
> unmodified upstream Linux 7.2.10. It happens during the amdgpu-to-VFIO
> handoff, before any guest code runs.
>
> Revert/add-back tests on Proxmox kernels isolate ef5fcf2a6c32
> ("drm/amdgpu: fix autosuspend cleanup during removal") as the trigger.
> Removing its added call from -20 works; adding it to working -19 fails.
>
> Tracing shows amdgpu_device_baco_exit() returning -ENOTSUPP (-524)
> during runtime resume: the live BACO feature reports supported but
> not enabled. The exit sequence is skipped, and a later bus reset
> leaves both graphics and audio inaccessible.

Adding a few people.  I'm not quite sure I follow what's happening.
Can you attach your kernel logs to the bug report?

Thanks,

Alex

>
> The candidate below keeps the autosuspend cleanup and allows the exit
> based on the selected runtime mode. In two clean baseline/candidate
> build pairs on upstream 7.2.10, the baseline fails and the candidate
> restores reset recovery and guest graphics/audio initialization.
> Sustained rendering and repeated-reset stability are not yet tested.
>
> Is the selected runtime mode the right condition to use here?
>
> Full report:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
>
> #regzbot introduced: ef5fcf2a6c320676bf8be2dadac93d9023b468b7
>
> Candidate patch:
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6412,8 +6412,16 @@
>  {
>         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>         int ret =3D 0;
> -
> -       if (!amdgpu_device_supports_baco(adev))
> +       bool runtime_baco =3D adev->in_runpm &&
> +               (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO ||
> +                adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO);
> +
> +       /*
> +        * Runtime PM selected BACO while the device was active. Firmware=
 can
> +        * clear the live feature bit during D3, but the matching exit se=
quence
> +        * must still run to restore the runtime D3 policy.
> +        */
> +       if (!runtime_baco && !amdgpu_device_supports_baco(adev))
>                 return -ENOTSUPP;
>
>         ret =3D amdgpu_dpm_baco_exit(adev);
>
> Thanks,
> Nathan
