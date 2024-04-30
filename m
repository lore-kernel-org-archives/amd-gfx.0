Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FB2C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9E8112E1F;
	Tue, 30 Apr 2024 18:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aEZ/8EhO";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9973112E24
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:33:03 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso3417193a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714501983; x=1715106783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rm34jonJpppbqIuXEVcbrSiOHcwiNGFDbpu5Etbil7w=;
 b=aEZ/8EhO/RNAXykcP9mP+KB7iPzDz05qE7dp+oru0QofZE2JrUn1X2NtqYXEyzuIRQ
 +vIAmQMl9i+pob9/MUinvRoNnLGszBTxc46coaWXuIh1RjfWNwav0k3Q1P1xi+XJXhT1
 n4qYFVEESGaDVNCr6Dt1pduh0nAwB+fiCc0U8Cbp/sYBiE0h/J2jUqpH95klCmMBvs+k
 lhu4mWfItfWMUgm3zDNn/MPs3Hv91gIJnQfGxXBRBblowyh2rMzrL6hewT4BeLgjqW6x
 CjWUyCAL6+6iXHB02Wr7uY1Ag4L3AGiSsVEEziY2bD5HLEN8eip6jHL8xcHT5/o7/GSY
 XQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714501983; x=1715106783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rm34jonJpppbqIuXEVcbrSiOHcwiNGFDbpu5Etbil7w=;
 b=fTj5VF2HD+ZCejogUHz5yt8f+WcNwsEUDswTQEgnGSDob496eL+e3NaUWFExmnX/6J
 esUypnHeyeZ7Ir3Dtr55QY9otps6OA8ajm7Y2rRBBP0HqJ4i6PW52yToFjj+8CELpSZn
 kbBa3+VkA/t9E/8D6CVnIJdPNOHhZ4kBzuEDV7zULUj/oeR8/2pgD6x9XomF/d4rJUur
 mrFE99v5h9Iem0zE3lEn+4Ia/9joeNPSo/hPSCEb25yBJgbKvUZrvC40w5KxPE9dvcpT
 TmOBtSxmlL+U2LuSSheTaz+TOPs+KsLHoaPoU+5/GPV1AV0XV+YzvuUzN5WIt9C5DTmD
 IRNA==
X-Gm-Message-State: AOJu0YxQkAUCrd6VenOG7wsHgBFmlo2hD//MjA1+rtWWhZIM9lpZunR4
 WSubwvRYEkA+0m9KAOiSJTD0mA8rgZR5btvemtj2GB5xpQ2NidDR5C8m7FzPzNBJgtGCtSuyyb8
 xGYOyB+2mRkuEHWh5W/A1jjOwB7lYsw==
X-Google-Smtp-Source: AGHT+IFZEMWkLr+TfaVwJscnI3Jucc1WMuBKv8Yzvc3nZF879q0fR1fstuKnecZXVNzi8IWeY5SWQUunCXAdXP/gzsc=
X-Received: by 2002:a05:6a20:43ac:b0:1ac:3eb4:b91a with SMTP id
 i44-20020a056a2043ac00b001ac3eb4b91amr232064pzl.11.1714501983003; Tue, 30 Apr
 2024 11:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240430172748.61576-1-tursulin@igalia.com>
In-Reply-To: <20240430172748.61576-1-tursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Apr 2024 14:32:51 -0400
Message-ID: <CADnq5_Mzn8gesfqfNncJMWGgawFR3upgcy9MG=UwHw4i5GoZTg@mail.gmail.com>
Subject: Re: [RFC 0/5] Add capacity key to fdinfo
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
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

On Tue, Apr 30, 2024 at 1:27=E2=80=AFPM Tvrtko Ursulin <tursulin@igalia.com=
> wrote:
>
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> I have noticed AMD GPUs can have more than one "engine" (ring?) of the sa=
me type
> but amdgpu is not reporting that in fdinfo using the capacity engine tag.
>
> This series is therefore an attempt to improve that, but only an RFC sinc=
e it is
> quite likely I got stuff wrong on the first attempt. Or if not wrong it m=
ay not
> be very beneficial in AMDs case.
>
> So I tried to figure out how to count and store the number of instances o=
f an
> "engine" type and spotted that could perhaps be used in more than one pla=
ce in
> the driver. I was more than a little bit confused by the ip_instance and =
uapi
> rings, then how rings are selected to context entities internally. Anyway=
..
> hopefully it is a simple enough series to easily spot any such large miss=
es.
>
> End result should be that, assuming two "engine" instances, one fully loa=
ded and
> one idle will only report client using 50% of that engine type.

That would only be true if there are multiple instantiations of the IP
on the chip which in most cases is not true.  In most cases there is
one instance of the IP that can be fed from multiple rings.  E.g. for
graphics and compute, all of the rings ultimately feed into the same
compute units on the chip.  So if you have a gfx ring and a compute
rings, you can schedule work to them asynchronously, but ultimately
whether they execute serially or in parallel depends on the actual
shader code in the command buffers and the extent to which it can
utilize the available compute units in the shader cores.

As for the UAPI portion of this, we generally expose a limited number
of rings to user space and then we use the GPU scheduler to load
balance between all of the available rings of a type to try and
extract as much parallelism as we can.

Alex


>
> Tvrtko Ursulin (5):
>   drm/amdgpu: Cache number of rings per hw ip type
>   drm/amdgpu: Use cached number of rings from the AMDGPU_INFO_HW_IP_INFO
>     ioctl
>   drm/amdgpu: Skip not present rings in amdgpu_ctx_mgr_usage
>   drm/amdgpu: Show engine capacity in fdinfo
>   drm/amdgpu: Only show VRAM in fdinfo if it exists
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 39 +++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 62 +++-------------------
>  5 files changed, 49 insertions(+), 70 deletions(-)
>
> --
> 2.44.0
