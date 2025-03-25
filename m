Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC97C36005
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 13:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9903610E39E;
	Tue, 25 Mar 2025 13:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sii1dGDb";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960CE10E39E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 13:55:43 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-30363975406so402970a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742910943; x=1743515743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVgvfzW0KAryx1CoFeWjjy4BSo4um6r3DRMlHz45qeU=;
 b=Sii1dGDbLOzCjIEF1BaspTHkufNfXW3Krvm4ZFVOOOYqPQmlcY7QabfUo5T/OiGdGk
 mNGnTdQGKunmaJ/6S3u1MIeeGtCMuSoFfUW+LQWy38ModD89wWalek0nsaFY8x16OkSZ
 zFGx+a3MZRgIeVNg7oTR6ojvrtFvp1NriyCYjcw+ERBZJe2WStXcFP3dVm2sW6dhi8cU
 xejP4G4Vbb9aq29nIJRZwkD5bSEqup57SKtz01PlJmYyLY6VI7UaNloe8T36JeNNq8vO
 JPs7TBB1vuLgMt+hLO17sGJlH8nsNBITliF7dZrfv3MLsQAXqBkSgJ4Cxg8KAKS88s8L
 4qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742910943; x=1743515743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVgvfzW0KAryx1CoFeWjjy4BSo4um6r3DRMlHz45qeU=;
 b=qxrBg0jbda8XANNCVYSQGPV9IOYAdLDfC8RlhDefi7vaNsln9PijWV0aV4bsbI8KqC
 BDDp7v8bWXEUdPxhTsUDdOwah4oahrobVUDDwOLKR1RRme7A0eraLoJlsNj5NuNjrvFf
 brpZ2vafxEN4x984C9zL3xXR+hSkpjoDPMfNXJTAbaYkZdL3VPDshS1B1h27mRPTLsDZ
 dZIywXRjWXfuDYgtf8DFYyT6ocvZi+Rgw/07O9RSazqzlhBBSgR12T0GWsyPERc3WIbA
 I5y0o/bvhczS+85B4D3ySPqpG3bg1FuPjlQBhI92eTnuf8r7P0HzCDzhA93yxasGt6y0
 JmmA==
X-Gm-Message-State: AOJu0YwzfncualVKucWzCtCPvQIAN9Sf1I2HCGCnK7RPObi+tZtYqYCc
 DF3QzimOoPPkOevSJaNKpGT7S/pR1xJ64DqQir5cgDZKmUWbHv/CbN1b0FeD+/xmFQc2dvGk49b
 zv8Wq55B42oqVTbV5L+y5sE5GGeQ=
X-Gm-Gg: ASbGncuD8iz3X9GAw8N3YVnJspYntXvD8PhIuhRs50mAbQ/ERv8yjkqhBDS2hUcOLh1
 WwnegdzheOQNPPA+FilNJBvc/4q7ibyq/YW0I+eQ2/CFjG3pGk9IZxMyUg5prkvSu4Aj37zH/Zl
 ZF48kyC1BdymXSFb/CvLws9C9e5g==
X-Google-Smtp-Source: AGHT+IEO85OFf0Y5F1ZzlpQcyq5aXYI/BZ7PBhkP3gqf7b0kJvrSFatTaaZ7I4WBGZWAy6zhw10DzbYFLvUZ5QxGZfo=
X-Received: by 2002:a17:90b:3a8d:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3036b4abf73mr1910304a91.5.1742910942884; Tue, 25 Mar 2025
 06:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <314e8563-82c6-4702-bd3a-bdc2200adfcd@gmx.at>
In-Reply-To: <314e8563-82c6-4702-bd3a-bdc2200adfcd@gmx.at>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 09:55:30 -0400
X-Gm-Features: AQ5f1Jplgb1eRHd4svx4csA9xxnQnAFpNHKkiOALXqkHQt0En1gmHT0ttK-nCvg
Message-ID: <CADnq5_Ox=zp+yJOnLTr7paQp_wQ3rd0=tTBn11Gmzx242OdbKw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: Do not trigger reset_method S3 workaround for S4
To: Harald Judt <h.judt@gmx.at>
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

On Tue, Mar 25, 2025 at 4:33=E2=80=AFAM Harald Judt <h.judt@gmx.at> wrote:
>
>  From 9a2f16a4a43f424f5008d5c4a87e1329f682e919 Mon Sep 17 00:00:00 2001
> From: Harald Judt <h.judt@gmx.at>
> Date: Sat, 22 Mar 2025 23:01:57 +0100
> Subject: [PATCH] amdgpu: Do not trigger reset_method S3 workaround for S4
>
> Commit 3a9626c816db ("drm/amd: Stop evicting resources on APUs in suspend=
")
> causes hibernation to fail on R390 because it triggers a workaround for S=
3 in
> amdgpu_dpm_is_baco_supported that disables BACO. With reset_method PCI CO=
NFIG,
> S3 works but S4 fails on resume. This commit fixes this by modifying the
> workaround to only apply for S3 and not S4.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3634

Please use git-send-email to send out patches.  Your email client has
messed up the formatting.  Also, I think this issue may already be
fixed by this patch:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4afacc9948e1f8fdbca401d259ae65ad93d298c0

Alex


> Signed-off-by: Harald Judt <h.judt@gmx.at>
> ---
>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++----
>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c     |  2 +-
>    2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 91a874bb0e24..05ac13f1aa6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2556,13 +2556,15 @@ static int amdgpu_pmops_freeze(struct device *dev=
)
>
>         adev->in_s4 =3D true;
>         r =3D amdgpu_device_suspend(drm_dev, true);
> -       adev->in_s4 =3D false;
>         if (r)
> -               return r;
> +               goto out;
>
>         if (amdgpu_acpi_should_gpu_reset(adev))
> -               return amdgpu_asic_reset(adev);
> -       return 0;
> +               r =3D amdgpu_asic_reset(adev);
> +
> +out:
> +       adev->in_s4 =3D false;
> +       return r;
>    }
>
>    static int amdgpu_pmops_thaw(struct device *dev)
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 9dc82f4d7c93..1a8624b2f388 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -220,7 +220,7 @@ int amdgpu_dpm_is_baco_supported(struct amdgpu_device=
 *adev)
>          * Powering down/up everything may adversely affect these other
>          * devices.  Needs more investigation.
>          */
> -       if (adev->in_s3)
> +       if (adev->in_s3 && !adev->in_s4)
>                 return 0;
>
>         mutex_lock(&adev->pm.mutex);
> --
> 2.49.0
>
>
> --
> `Experience is the best teacher.'
>
> PGP Key ID: 4FFFAB21B8580ABD
> Fingerprint: E073 6DD8 FF40 9CF2 0665 11D4 4FFF AB21 B858 0ABD
>
