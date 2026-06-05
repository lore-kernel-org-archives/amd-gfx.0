Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE943CD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 17:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59078113B36;
	Fri,  5 Jun 2026 17:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gdC7PklJ";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0553113B36
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 17:57:53 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-137c0db2638so177227c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 10:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682273; cv=none;
 d=google.com; s=arc-20240605;
 b=ZvCtelHigoYaZr/NNeMg5Jy6Khkwea3bafIgAFTQNFqzxmtM00Zma9tPnnX4rJiGgL
 7Xepp20T5FEJ9NDb4z5MYS4X91pAzaV4EtyqNipG4LnPU2erGr9ALoAQ3b3/kliwgnWX
 E8PyC4QPIjKUyBSHHuBuhnftHiwH3NL3hdWeSJT/kugSiXmaINqCSYk5APjfI9dhot0p
 RXHxIXm7fVe8VlJfaQ5IL7307o6VnpTlAXmYhBoxvFfFK4MITm6jiwmB5tpfzelh5JZc
 Hj7KyOrjbJTQf8v3Iops5AEDoA78GvbkcmAidlftt4MTRAwPbbQJUhTa2jtP6eimHZPZ
 DETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=26dkzTAc/keHgixwbhYKgsFRTgpVEWlLu/P6CbMSpe0=;
 fh=H/VfgC4cZPyU8hANrSoOA2UIZImS8Otn1ShIpKh6jhI=;
 b=DfWlXTssZ8ICdJIY45plQCyzugL8WkbgqWYoSOrye+9aaQpWjsErYdIvk4i7P9+y7B
 6fpDoyTWclZyxrIGPxPzzOS+wJvQYXML/pNBBeArvAYIeoMD3a7HpQiSn8pfoObSTVRo
 gkHawIQfwlLeqX7yC37XE06npfj8EcuFF/CQVUfoh+R1z90RpyrqntZuU12Cpcyh+pSo
 TUMwdnRJW26smMpfnGz+Rg59Oetbplxs0VZZ5d69Ptuw1OxX4xdD76fQn0o42KYdRrI8
 nQjT4cmV4sBfdLVAZWzP8SUZxAykLjscyoZE1FZOf42BNM27U/WUtgdEf1UQj84cl8eT
 /UKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780682273; x=1781287073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26dkzTAc/keHgixwbhYKgsFRTgpVEWlLu/P6CbMSpe0=;
 b=gdC7PklJQ3pjku7x542lMZUeLN4FcZUVVR7yD9uySwzke4oP+AH2SbClJNMx8iAchB
 tnxvVAcv22s2AJwiApMCUIuByCbfaQ1TGLMmxPCiIQtyX3/l8Ecl8baVAXS3ygqcV8jO
 aSS7KLY1uwRhq1PvmXR6gQCvjMlQddE2Uj3gH16PGxiH89ADzQznKnukZ7PgCpzPu+Ej
 lAB51MSq71UlWVgZVbKcoNXj5w1dksLklC+YPkxoYQIlvEgJoxhBhJQ52vJrELtrvhH+
 KL932zH9R/3qqDr6FEYbtRUod2gDI6A99ynSxv1OYN8gNXc745HJMJguHoj+EF6rCGkH
 EtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780682273; x=1781287073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26dkzTAc/keHgixwbhYKgsFRTgpVEWlLu/P6CbMSpe0=;
 b=nxwmx68u5J5QAS3Ri8fZbPt/iEknP0Bhn2SupPM7RK8rro2pr6oO1IrUJZ1ChFQX+4
 IuuqHOrYPqvoaYu0UFBTHY+j8DAJ4LVVmER7Sttaxkt8vnhKf/NgZGGLFL76/B+/Y6pE
 f4GpBHFnkEsXLdCp9dcV5m48REWXqtA4hj0Dt+sf9ePRuJFzGK7cEyUETKX5I7L4HjNX
 w2l0uc0EfJEq0kBQirCZepsnKXy3os4Uf162lePQdO7zyIaiLvyssoCMv/iTQMh+LNz0
 elcxfNV7EXNhjFjcjm13F2xk/rOnM+zAigGrVrdTueo/aDE0Z0sMx9oxQdDkm+vI3ugf
 oHEg==
X-Gm-Message-State: AOJu0YwLyydRONoyR/y8aXQS4o6de06dIkBIs4mIKUM0atpw5idn1nvm
 gk3E/E3PH96g88UXcYB3c4uBhpQBgUgDJze6llyoeTdogDbznl7Vc6fX+BInor1p+bz6veE75j6
 B4AFmMqc7/CUqHU8cqN36knIGDgA0QIM8WQ==
X-Gm-Gg: Acq92OH8MROAJdEAfzvufvcUDNrrjUtLIZQcUFSXoQKHNbeH0l3yApffEuRxovbH0jG
 wAjVeI4Z2seSy8wiTumtfm2ctwO60+zzXW9bVfAnWMnJ53vHKfZNC9HS4//m32D8D/A7d/3KDf5
 K3X/NPR3ybYFK7C9Vtlry6o8Es1oQz3NeClplESIxC+QUAibEtd81ZBw8fFWc3DLIs8+3Hu8pu4
 KV3zQ/jgqnY5VuFKoYmOVR7+O7TRcXkg9TzyvpUQyiRuOuCllmMZtG4hNsyOb1ag8TpOSghW1cp
 oQttUqlXDgt853eSvNXyHeEuIGUfqy6Jc/xQIYZUm93aP5kdzxmbDFh6wM2/I4BMU3U03ZTz/OP
 IkKibtSrxBSsfBDM=
X-Received: by 2002:a05:7022:407:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1380676bfb6mr870140c88.3.1780682272970; Fri, 05 Jun 2026
 10:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 13:57:41 -0400
X-Gm-Features: AVHnY4LfqTSsxrmQj4VYfuIU7nYtDfudkLPR2U3Vm5x1s5GyZSkZfqk41KTnySc
Message-ID: <CADnq5_PsV+3d4gcoMtc15zm_6+Q_qDQTPz71Tg6r8OwGjkHnKg@mail.gmail.com>
Subject: Re: [PATCH 00/11] drm/amdgpu: clean up amdgpu.h by splitting out
 structs
To: Shahyan Soltani <shahyan.soltani@amd.com>
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

On Fri, Jun 5, 2026 at 9:54=E2=80=AFAM Shahyan Soltani <shahyan.soltani@amd=
.com> wrote:
>
> This patch series refactors amdgpu.h by moving several structures and the=
ir
> associated helpers into dedicated or existing header files. This improves
> code organization and makes the structure easier to parse.
>
> Notes:
>
> Patches 0002 and 0003:
> Functions amdgpu_device_wb_get()/free(), amdgpu_device_set_uid()/get_uid(=
) are still defined
> in amdgpu_device.c rather than being moved into new amdgpu_wb.c/amdgpu_ui=
d.c files. I wasn't
> sure if I was supposed to move them or not.
>

Yeah, you can move them.  to align with the headers.

> Patch 07:
> I created a new amdgpu_acpi.h file rather than moving the definitions int=
o the existing
> amd_acpi.h, since there are amdgpu specific functions that group naturall=
y into this file.
>
> Patch 08:
> I moved struct amdgpu_clock into the existing amdgpu_mode.h. I'm not sure=
 if this is the right call.
>
> Patch 09:
> I moved struct amdgpu_allowed_register_entry into the existing amdgpu_reg=
_access.h.
> I'm not entirely sure this is the right place either.
>
> Patch 11:
> I wasn't sure whether to create separate headers for every small struct t=
hat amdgpu_device.h
> depends on. Since these structs are only used in amdgpu_device.c, I left =
them in amdgpu_device.h.
>

I left a few comments on some of the patches.  As a follow up to these
patches, it would be good to move the includes of the new headers to
the places where they are used rather than just including them all in
amdgpu.h.  That way when you make a change to one of the headers it
will trigger fewer files from being re-compiled.

Alex

> Shahyan Soltani (11):
>   drm/amdgpu: move struct amdgpu_sa from amdgpu.h into its own header
>     file
>   drm/amdgpu: move struct amdgpu_wb and helpers into separate header
>     file
>   drm/amdgpu: move struct amdgpu_uid and helpers into header file
>   drm/amdgpu: move struct amdgpu_video_codecs and helpers into header
>     file
>   drm/amdgpu: move struct amdgpu_mqd and helpers into header file
>   drm/amdgpu: move struct amdgpu_init_level and helpers into header file
>   drm/amdgpu: move amdgpu_acpi helpers into new header
>   drm/amdgpu: move struct amdgpu_clock into amdgpu_mode.h
>   drm/amdgpu: move amdgpu_allowed_register_entry into
>     amdgpu_reg_access.h
>   drm/amdgpu: move amdgpu_asic helpers into new header
>   drm/amdgpu: move struct amdgpu_device and helpers into new header
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 973 +-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h      | 151 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h      | 160 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.h    | 586 +++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_init_level.h    |  51 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  14 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h       |  75 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h        |  61 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h       |  50 +
>  .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  |  47 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h        | 100 ++
>  12 files changed, 1315 insertions(+), 961 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_device.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
>
> --
> 2.54.0
>
