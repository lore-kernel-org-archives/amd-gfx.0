Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F70CD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 13:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672C310FF34;
	Fri, 29 May 2026 13:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwAFG1kN";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1D010FF34
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:31:53 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1364ff8099cso212252c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780061513; cv=none;
 d=google.com; s=arc-20240605;
 b=R17ZfBbYAwIVrTjAEvwL3wlQ15/VkVm36xwSLdmg9mkeUnLYOSckavWj9eUhZh6uLj
 EGIliljynAk+3qs8JUY5x/0u+5AnKzybfP7Ym25aBDd3ZcH/MbFG5/W+tJgt7UbDneYJ
 prwB7fTfmucSuEM4wRfuXJQpVPmSBoi4CSEJ+D00C0seLewgJXhzGMpcs9FyhZhpiAfI
 4GI8AnIZqe4VDcDEzVa+B4bfqDVbqIgHiKfbBwNc/rpWA4K3tmDVF1N5O6dOLSxtwTRJ
 c7NDg5AxObBaOKH6FJHRNrrEh/+8Hr46kKAaixlfsWXhgUk6ChgPtBTnsV6bwp/tLFNJ
 VDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N76d3FioC56PlAfwbkYxb7XiDYGFApNJACOLa/DfZvw=;
 fh=HMeKoZvWaIsiYsB3u5W569+HDQBe2pDN3xmC6Pl+0s8=;
 b=YgkXgcMT1zApTY2CdQQTJxG/z7DvPzsune5FtQRWx/iZJ78YjM8G8LCUclcG1OeOvd
 TYj4gsGRmbd/ukOpFxvfllIhunQo9K25V9DOGkyBV8k9ImMO9QgRRRui/Rq3UaByMaUU
 4sNsj/D8S0BwKQntwJdQcgaXyyubae4NG+5Vc+7mvZUDBoIawuYvzf7YYOfJqyV9ojBD
 gphiiv9/6Mj5nXGYAhPACPhzRUO34K9FSxTzroc/B9NAvPGSSAt/iIECOEL/JVhGjRJF
 Y49SuQzBLhYVYUJXYeYAPV59gEjpHhJQtts1/FFcrbVSwpltYrU8McXC8sHHkwaQH7Ei
 xbCg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780061513; x=1780666313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N76d3FioC56PlAfwbkYxb7XiDYGFApNJACOLa/DfZvw=;
 b=EwAFG1kNH/J30okxVoDmqBi32I8U6w+O0/oQza93jl+/PulG97Z/1rzcgK0rsgVIrx
 o5Txc9z95y8TB0tWYP+mdvn8n2IjQRMHktmB2m7n1yPpYJ8v4IGvGeAAwObH2d3HnYwx
 SUrzynOmxdzFEX7g6nSlBSUblkXm1LUzH3FhPNpOeo7tkLWG31FrTwmuFiAb3cKroCU8
 Ktz8sWUXHtS/XBTqMeTT+Gp+1ya5FgKyB5LHUTgG7d9O5lDFXJR+S95Z0oSj4cm1Yk2i
 bI0E7kb4kgss6ByJG53pf53muoIOAdqUKuo1b4UK9rOwNcnSCgFGJF+oqhEWXYsSbxXm
 Pcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780061513; x=1780666313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N76d3FioC56PlAfwbkYxb7XiDYGFApNJACOLa/DfZvw=;
 b=CPQztUuqkN60vL2VhzhRlLzjCkyrvZTzpNOz1Avag12EOVKURJReDFhTzBtY1xLO3N
 jPixRajtVVj3OZa3lIW57R/UHpnYABKoep394XOEdE7GagO6BvF2IOTksuiAuhKPBqDB
 WWwE9yvmtfnd+frut0GUgk/M3KHftcrssabJ1JkuRvWNeGM2n/ZNhOwx7uuxY1My034G
 UxygAO+v8npwkz4YQnYfdfLCuJGwVx6SO1fyMzkppsIzDgD+aTeB/sZpXDhaWTfKKWvl
 uqK4Sqba5ttyvO8I0923CHmvsnSJw+pX0VHNVoS4cbYFu9LCgM4Z1TlRI20jnoI9GWJT
 ciKQ==
X-Gm-Message-State: AOJu0YwZqssBmwDykEDUNffVBVac3UooNB/cA0hoMPMYZkEfl+A/+OO+
 7W5us2wv9UNCiMEVOGpAdy66n33DuBxWwOIa50SLPafwL1J9bVtVMIfNqDLIExKl342Z12IIN0n
 NZKAF2B6pDxUQHV4kSPA+40vxMcLKIJ7kOw==
X-Gm-Gg: Acq92OEHVNiFAkyNpCZM4IeCn+1QSNEx7DEqiTUQSd+kcHSGTIHR0U72MXD1tMXEt9X
 ZkAizrr0fdYi+2hEenpnt3YIIRcQRr0P4dL3OcxQX9exUWCMO4Ezt2iSKHPQrKv+Ec4L0fyld/u
 7yieS//Eq/3Aq2i7JsSk2OHhmap1RAaYXtI2wSMlfU+dBcm3jQRc6sB2MSCbJ09/wybp8Wt+gHV
 cr3JF933vUbmdDOCI5rtYYD1pNzZCwJBGB8H/pOe66+hNCJAdvc2mNJ7NvV5IOWgjoc+mHUU0vs
 RSWx96Ay8UVToWRjjeYrO76Kr4xejjETpuRekv9U522kjeu6VmNRfqeUmhpFgaNZBZqj1NY1MsS
 F6HvI
X-Received: by 2002:a05:7022:f92:b0:134:feba:1eb8 with SMTP id
 a92af1059eb24-137aecc65f7mr606068c88.3.1780061512811; Fri, 29 May 2026
 06:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260529015528.524595-1-qiang.yu@amd.com>
In-Reply-To: <20260529015528.524595-1-qiang.yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 May 2026 09:31:41 -0400
X-Gm-Features: AVHnY4LfxCcs8SfjPvegm6DdvSkvUF3q1Pxa007DM3dbYUonCaO3gbKFdWgOz1g
Message-ID: <CADnq5_OccD8uqrsnpW9zrQKCbaqriF7AF0mM+Td8ZJdJKgsp+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: initialize iter.start in
 amdgpu_devcoredump_format
To: Qiang Yu <qiang.yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
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

On Thu, May 28, 2026 at 9:56=E2=80=AFPM Qiang Yu <qiang.yu@amd.com> wrote:
>
> From: Qiang Yu <Qiang.Yu@amd.com>
>
> This fixes read /sys/class/drm/cardN/device/devcoredump/data
> return empty content sometimes.
>
> amdgpu_devcoredump_format() leaves struct drm_print_iterator's
> .start field uninitialized on the stack before passing it to
> drm_coredump_printer(). __drm_puts_coredump() compares the running
> .offset against .start to decide whether to skip or copy each
> chunk:
>
>         if (iterator->offset < iterator->start) {
>                 if (iterator->offset + len <=3D iterator->start) {
>                         iterator->offset +=3D len;
>                         return;
>                 }
>                 ...
>         }
>
> Fixes: 4f28b4930f8e ("drm/amdgpu: move devcoredump generation to a worker=
")
> Signed-off-by: Qiang Yu <Qiang.Yu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 46043a1479e4..63d7ef78c025 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -219,6 +219,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count,=
 struct amdgpu_coredump_inf
>         u32 ring_idx, off;
>
>         iter.data =3D buffer;
> +       iter.start =3D 0;
>         iter.offset =3D 0;
>         iter.remain =3D count;
>
> --
> 2.43.0
>
