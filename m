Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB27CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 13:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B634510E58D;
	Thu, 15 Oct 2026 13:42:05 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B0510E58D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 13:41:59 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5db19e2ef99so288719e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 06:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792071718; cv=none;
 d=google.com; s=arc-20260327;
 b=LFn2Dj4lXu40vawUCgxcxJaLD+rSoaNpn+NtBCShMg5wOUcJTOYcH42sje0XfsR23V
 ogezi9NmUVdvi4xn/7x/1WLW0OTv966sqNWC8B41VD1ivyvWn0PXwzfiOH/Ibx+H1MOW
 iaKJC/4gxQyxhSoQ4AP1Q0ffaO4AxwpDgJZVol0RGPMp7aqwKBrveJ8RJEQ3t4XAFdo4
 9qM0JiHbF0O2wPFfuMmSpCpTNuf2s6o5Kfv++by61qeqyWtcMiiUTGC23fFInDD7WBRa
 YCXwZ6nOew5hpwKp3BrxiYxCjVn6YxAtOgjovZipdR4LI/sBxa6tt51NiGZBJaSJw7fb
 DHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7JRsVCKEIXgABZie+RiSpAHxPH1n0cROPAtHKZ0a+RA=;
 fh=6DY1ujrfiPWzga9b+/IrkFGz5yG61fk86u1jLNmUn+A=;
 b=cM/JqSQJfanny5leAB4kQ1m+A075iXOZxYy0pSTOUhBEizze8UnGAT6Zu1tH652Msa
 BFdywYvnsM1KzSqXxcdD8toc2iX+SgAlk06k/55tgxdoLIwm06aYmoKDuu3jkkV/oE77
 nXuWQOlQk+5CkAJi1sx3mjpDDEnO4+O2LPbSWYY3fsOLqG+IYkXxarjhW52iBsgSv13B
 uZabWa5HzFKj7Y+n4bua/q/Gd1lLD3PvjKH8GbJ8cva5cCA8LpezHXne3wMpcvD2cLXu
 EbqGh55sYPyJcs0B0f15rR8LGnXQ5VE0I8QlC5pxNguQSVYS06X41O66gb9yO9e4zKWq
 ly5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792071718; x=1792676518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7JRsVCKEIXgABZie+RiSpAHxPH1n0cROPAtHKZ0a+RA=;
 b=s/gMOyhEHDnWHWKZuKh9LQD5wq4EC6sQ9LGsuDNdr6zfjzEmwcka6o/03Bj1vVQwNE
 r+JHCHcSIquBffP8MkF8Dt2GixLwrjzqkVQxOGTwAlFgV+RN/xjRVJzmtAE2aOQm7li7
 4HXACiUuFYnBxuOm+4wGTO11Ru8BwH/jg1jqYQpWLwWEsa499n20msLUlZq7PdvIUZ5Z
 oHaIhqzyHQZdXVmM9MlkkR+DLMzvZxOh2Aw6upT6CUjNeoaYUiBWMXJbDTMe04TamPBa
 60ZBLWCsqWson2vgiubWFx1Sg2u774rUirR5JkG8zklU80nK6g/JC+NQZScXWH4hoEhC
 KyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792071718; x=1792676518;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JRsVCKEIXgABZie+RiSpAHxPH1n0cROPAtHKZ0a+RA=;
 b=BXs7ylSSDf9xQbNQJe+ofPrKpJrZEZKq9ZZT540MVYW1uQ6rhZAFd7Aqef9UFVME/k
 MHmajr1A3Gc8g+nlDaQrjyLKuiVzYyhEIEjK155rIC0bvGgTMBSWJ4hreNNJ4TRmYpUV
 SKsqJYe0eW0JzmNLE1zkwaspWDqmr3s775NFC3EDjFEDUUlPeKVWRese5pv54UH2sDzk
 RwSF6mybfubi1fn5jWLZop/tzF/tmLCFgVPi+v/Wfv0J7g86neuFisK86jBHVLWLxXd5
 1baoFjqpKk5CKdI1h32yNc0Pil9fR7E+//Uz+6huaJqG7nqCo1tJZxxzlMynHWmCrdzp
 ENWA==
X-Gm-Message-State: AFq9FYIAVZRRAMtuA2cLcuy+ICmiZzVsQay2Nkd1do8mozXtNu1bBG+N
 2xI/FbrcHqIoZKE7VAAQZ3WxgddILaBJ1gcT5i2UrAMMVbUt8jZM517PoubCVjAaGLzT+H4i+CQ
 hPlS/BYobcpCFu8fX8Am+KZTftiRMv9VpMblKuS0=
X-Gm-Gg: AYBFou1Mvo1NVzm7QzGo0AX5TniRE/T0aJ3zpQ4WBZzrYMVl6ey3LKQq+N8H+q47ljR
 WqBxMGqKUH4RYyW+20W2fEtBXHRrdgvPmiqUTR9ryZuhqxQvclhbvMAfsgQc8bCv7VYdYZDaxoq
 O5azuGuNyMqPKrWEIsdbwOiRrgfqoZB1bMSJMTLE1aU6g7z7MVIcrpXQHDCV641wOanv8NFGmFC
 6PFGPechheTAGp73q/hGs414MCb16GyCDCNYoWh1TpMs35JIIblR9kK03UWW2L59n9oWz7V4+ki
 COexR3YneYIiAmlAOqCgcDzP9j9Av8SAl7sjkwFHTWi/g6vQqjer7jBeR/1qcEnxJUKYAJs1njV
 O8DBJdhbOHkJcgD7eEDSoA4FvmTbo0mt1CgEfG0MF/g==
X-Received: by 2002:a05:6122:4a52:20b0:5cf:69d4:10ea with SMTP id
 71dfb90a1353d-5e92e15cddcmr3625398e0c.0.1792071717583; Thu, 15 Oct 2026
 06:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261014133356.3002808-1-luigi.lauro@gmail.com>
In-Reply-To: <20261014133356.3002808-1-luigi.lauro@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 09:41:45 -0400
X-Gm-Features: AclHuK8kH5rS_QUDMd_OvyWX1nlDRIPyrZAzPmgPo8iphr7akWFprVMMX8RKv1M
Message-ID: <CADnq5_Mw0k8NLVyWMZWd-Oxg0Om=6ckVET7Wjdx4zU7c1NL2QA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: require _PR3 for BOCO
To: Luigi Lauro <luigi.lauro@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Oct 15, 2026 at 4:31=E2=80=AFAM Luigi Lauro <luigi.lauro@gmail.com>=
 wrote:
>
> amdgpu_device_supports_boco() returns true for an AMD_IS_PX device on a
> system with a hybrid ATPX method even when the device has no ACPI power
> resource (_PR3). On an APU mini PC with a discrete GPU attached over
> OCuLink, the iGPU's ATPX method reports hybrid graphics, the dGPU is
> flagged AMD_IS_PX, and runtime PM in auto mode picks BOCO:
>
>   amdgpu: ATPX Hybrid Graphics
>   amdgpu 0000:c6:00.0: Using BOCO for runtime pm
>
> In BOCO mode the driver leaves powering the device off to the PCI core,
> which can only do it through _PR3 on the upstream bridge. No device on
> this dGPU's path has _PR3, so when it runtime suspends the card stays
> powered, with its fans at about 700 rpm.
>
> Require has_pr3 for BOCO, as the function's description ("dGPU with ACPI
> power resources") says. The same card then picks BACO, which powers it
> down:
>
>   amdgpu 0000:c6:00.0: Using BACO for runtime pm
>
> This only changes systems with a hybrid ATPX method and no _PR3 on the
> dGPU's upstream bridge, where BOCO cannot cut the power today. Tested on
> one such system only, an RX 9070 XT (Navi 48) over OCuLink with a Ryzen
> AI 9 HX 470, with the change backported to 7.2.9: the stock module logs
> "Using BOCO", the patched one "Using BACO"; BACO runtime suspend powers
> the card off and it resumes cleanly. Not tested on a hybrid laptop or a
> Thunderbolt eGPU.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5980
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

and applied.  Thanks!

> ---
> Alex asked for this on the issue. Here is the full picture, so you can
> judge which approach is best:
>
> Why _PR3: in amdgpu_pmops_runtime_suspend() the BOCO branch does nothing
> itself ("PCI core handles it for _PR3"), and has_pr3 checks exactly the
> bridge the PCI core would power off (link_partner, past the dGPU's own
> switch). On a hybrid ATPX, amdgpu_device_supports_px() is false, so the
> ATPX power-control method is not used either.
>
> Who changes: only hybrid-ATPX systems without _PR3 on that bridge. Hybrid
> laptops that have _PR3 there, which I understand is the usual design,
> are unaffected.
>
> Risks I cannot rule out:
> - BACO on older laptop chips that have never used it for runtime PM.
> - A platform that cuts the power in a way has_pr3 does not see (_PR3
>   somewhere else on the path).
> - The other users of the function change too on such a system: the
>   DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME flags in
>   amdgpu_pci_probe(), amdgpu_pmops_prepare() returning 1, and
>   amdgpu_device_supports_smart_shift().
>
> Narrower alternative: leave amdgpu_device_supports_boco() alone and
> require has_pr3 only where amdgpu_device_detect_runtime_pm_mode() picks
> BOCO in the auto case, falling back to BACO. That fixes this system too
> and keeps the other three users as they are, which is the same state as
> booting it today with amdgpu.runpm=3D1.
>
> Please tell me which you prefer; I can send a v2 with the narrower form.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e001461..96cb4d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -593,10 +593,8 @@ bool amdgpu_device_supports_boco(struct amdgpu_devic=
e *adev)
>         if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>                 return false;
>
> -       if (adev->has_pr3 ||
> -           ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> -               return true;
> -       return false;
> +       /* BOCO needs a platform power resource (_PR3) to cut the power *=
/
> +       return adev->has_pr3;
>  }
>
>  /**
> --
> 2.56.0
>
