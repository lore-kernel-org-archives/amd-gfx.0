Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A070DCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 16:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AE110E162;
	Wed, 20 May 2026 16:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUBFRzVM";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A844010E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 16:19:05 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c7288cfb9so151216c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 09:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293945; cv=none;
 d=google.com; s=arc-20240605;
 b=Q6/9OaCxWekO0x1wWO3CuCpk71itwR3UmXqethWo61sbBD+Ul7BQd1HEGlqkVuWUQ9
 7DRL8n9ozxccJUK2w70baQjV/XphlGLD9GzgNoID6dX738JNTlzP4ahfCkv7e9lJvk23
 gz0kOHuUIWMZFkwQgcyJw74OjbGxfXaa+xSMJxC/A4eu99Q5uON+84DGxoQnWv2i94T6
 8R315kTsjXu0mF98TiD/7ulJg7Ai4SWRu2RlqhazOQXXR+fBP10kUzuIu5f+/363+465
 qh5fRrdHQVcaMN1AejFCjokh4im5QliLDfC/DMTrnbWSPw+79w5tk5VHsxxIm0EEONEp
 H0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2IvgCxkjFVeMzpa2KxlzSSnk1gEQMLVw0Pdy3qm8/ks=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=Lxobfo3Ygnxez9r2B1+pedO8r/NFtLVP2IxcyxjnJXWe3uFI5YH5SiY9Op3pAkKUcg
 30HEruC6t24sRkBl9LIt8q1zgs+XUKiSknMkGqBr/j+w96QXblUB/ttlwJD/dapQNT7t
 gs1rQS2Yf2JKN0IA3nzmWghP8Srcm9GSCVeCJbCegiyl83Llp7M02/mU65nMNDN/PKQH
 cV4nzMs/+8rs5dfodjirrw5vTVCbM+2huIcG9eoLm8MPbL7FwAegimgvFgw1r+ILFteg
 wuodOrRwm/aCTUfLgc082IBwSEIFUtBAPJ53fghqqvQfqLsGluOey1j3Y8RigXbMRJ1N
 ujuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779293945; x=1779898745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IvgCxkjFVeMzpa2KxlzSSnk1gEQMLVw0Pdy3qm8/ks=;
 b=jUBFRzVMY/GWAoojrzpDsjz2Mll2MamxPS9Ibpu5z6COm/FfVuwBux8qb14IOURlV4
 zn4/uFMCiPBMylP5ndfUbstVUez05+7QnqJpMmvZoOEG7KkyENPQ8zgavzwMQWKzxlPR
 Fv9CefqtbTFb5fqpWPYbnUz1gS2sTAE+9h0n9qfmkYIFUbr4yk2S1DZCCwCYVf+ukdSv
 +q1p7DsZwJxaNaIJWYXQSjY0ihDaJLQokepSdDSvDsYT7gekvjfhKkw7+uiMffl/lO8Z
 Oetj5Tu9h4VXgBi77DkGEpfyhFRoJzJX1xgILKXmPj2o2vs3U94dgvL3r4Szb6T5Qs+F
 zN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293945; x=1779898745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IvgCxkjFVeMzpa2KxlzSSnk1gEQMLVw0Pdy3qm8/ks=;
 b=c0Dzjs/Uw627EEfhXtxEuGNmLq6UrH27/Fgzga4Gh5IquhONPMwKgD2fnpH7Rt3pZ9
 TMHvc5hq9n6/dH+xTFqWdyif0A5yn2F15vx1x09HIyOT8aDGHHJv3qP2vCmrp7hLxOHX
 M1UbraYhHfT/3/yNHpkuyya/umdgBi9PEwvLxD1m2fOpT7h29j7EnjItV3jVZSZPtsU9
 9eTFIVGhbqyeBSsSpnl8XnkI03u8BZT8iBWElCqLRjmtvg7b5Ir7TzE8kKvM8eob0hpX
 mb7qpsombmQafIEE5jWEzHSZwsY3KUQhfr/mFZ0yMbJutN7WM/9GqGtIVfGkN3TuLZ3t
 a8cA==
X-Gm-Message-State: AOJu0YyWZXkaavDQEjNSDwRSluHZvkii72cim0Si9UAFLIRGNV82TOGj
 SIq583RlJdgMwaqduWydJ7ZBr22MJHXJLgJr+ZSJRtPmzc8jmm5q9yfIsLWQUKMBpzQj+hzR1W4
 9Tm1VdORxxawRpOTjxGKDLqDaGsY3m4s=
X-Gm-Gg: Acq92OEBsGjDRscDDP9NOMhZ+74lc6WLti+StRTHJjmwzpZw8+kfGhsYzNm/jUhuo34
 vgdGGXSgO8hPaWLpZGJofbmA6oYl7bBHXYBJueqr9HTKVGEZBapxpIQPHMWvLOHmHMw+4vzM7wu
 BL0iWS5Hvjxxm/LSSLzoNUgjFxt493k6mIj8iC4AXiGtaOffpBAJXNBtqAH8NnDIa+L/lmVV1FU
 nE5nwDdspZGuSyDXxlgGXYolvrIlZlCmggPfeA/ZHViF+rjB/j4sIT7lBvbfWcLytIdFdXWGq4J
 kpM2jj669eaq4PDQxcYqsm1eDAqRIKUD0vdYtjfoNTyDSOiaIJk+DcZhe0tkG5fUqKV2mBVg22u
 CYZeA
X-Received: by 2002:a05:7022:6620:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-13503fe876fmr4619684c88.0.1779293944742; Wed, 20 May 2026
 09:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260520154618.809699-1-mario.limonciello@amd.com>
 <20260520154618.809699-3-mario.limonciello@amd.com>
In-Reply-To: <20260520154618.809699-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2026 12:18:53 -0400
X-Gm-Features: AVHnY4KbkolOZukM80gb9rZhVNB5pz3nrNk2cEz-Fl0sEs39qJRSLeRJuLCYK60
Message-ID: <CADnq5_OS4+tbuTtqU+ekK7Qc_LQQHCfw5-hrYwEYDhbHFaWR_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd: Adjust _PR3 detection
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, May 20, 2026 at 12:04=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> _PR3 detection was changed in commit 134b8c5d8674e ("drm/amd: Fix
> detection of _PR3 on the PCIe root port") to look at the root port
> of the topology containing the GPU.  This however was too far because
> it ignored whether or not all the intermediary bridges could power
> off the device.  The original design in commit b10c1c5b3a4e3 ("drm/amdgpu=
:
> add check for ACPI power resources") was too narrow because it matched
> the switches internal to the GPU.
>
> Use the goldilocks approach and look for the first bridge outside of the
> GPU and check for _PR3 on that device.
>
> Fixes: 134b8c5d8674e ("drm/amd: Fix detection of _PR3 on the PCIe root po=
rt")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index b6a24faaf78dd..7319467b11a94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1939,7 +1939,6 @@ static struct pci_dev *amdgpu_device_find_parent(st=
ruct amdgpu_device *adev)
>  static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ip_block *ip_block;
> -       struct pci_dev *parent;
>         bool total, skip_bios;
>         uint32_t bios_flags;
>         int i, r;
> @@ -2026,10 +2025,8 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>             !dev_is_removable(&adev->pdev->dev))
>                 adev->flags |=3D AMD_IS_PX;
>
> -       if (!(adev->flags & AMD_IS_APU)) {
> -               parent =3D pcie_find_root_port(adev->pdev);
> -               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fals=
e;
> -       }
> +       if (!(adev->flags & AMD_IS_APU))
> +               adev->has_pr3 =3D pci_pr3_present(amdgpu_device_find_pare=
nt(adev));
>
>         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
>         if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D KFD_SCHED_POLICY=
_NO_HWS)
> --
> 2.43.0
>
