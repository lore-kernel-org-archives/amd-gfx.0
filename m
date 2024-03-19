Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6A6C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 10:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD4E10F78E;
	Wed, 20 Mar 2024 10:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ma+iyhG3";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2E910EE0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 15:04:51 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-513d4559fb4so6874324e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710860689; x=1711465489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jv/uWSD+G+ay7c7HRJxuglU4B1i2HwQDLwaxV+71/EY=;
 b=Ma+iyhG3Jjks0oQBHLFCOPd4ltg5Kr5mxtnJm8FQVrVjpVH0/Peh/W394DmXvxIIPM
 6TIXEu2e23jv2q9b4qXQ1kOgIJfPQZSoEqyR92mu4IVYssCwJOofUmi2wYhSm8t3AMob
 rY722/J4aHXg7+iIy8xA6Jmz1YUSw2qXp92R/ZM/SAhDrowWuI/SPKeushH93SAhOv5H
 N6xF3H+y6xAHf8NFVm7dK1d+GEQ/9o9mT7vG5t6lt2wxIvdvQmGeHibArKjBt2m57CBV
 XJmfUSDx8jRiHF0ZrEiNbfYhSd+zhpVPsPxU2loDwa0KYAYp2rR2xO05Ug/cIt1EYQgE
 dPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710860689; x=1711465489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jv/uWSD+G+ay7c7HRJxuglU4B1i2HwQDLwaxV+71/EY=;
 b=cArz0Eo0kWScc7HvNcuTQeJ7GagE8AUQMeglek/vpo2QQjDKZg0culjiLi/IkSuFxW
 dx+c1TZe2qf9fhmVeDN3cBBFkNkk79iPyQbNb++7luBie9WKMFucWl6p31X92bRDLIx7
 asfXpBKDsMcvrrFBqkmA2H5DpVH/6/K+VkE8+x+L6oSkA3PrBZE+10xgDB9uHg5+0qap
 weFgnTtgijtrYI5iRhcxyj19wquPq8sRbr41yhRVUEXI1fY6af1W7+dPMWxJECW21iiw
 xYqeUpRnndHxc8/IV/kje045XVezJ6U5rrTVhTJHniL2zcA3MUUUbHKYr13kVYhC36rM
 nrcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULzDPZ+KXrX+BqcyG6u11PZMBUw1c3YAls1vuhwUb0jARmxAKw8zIolO/q/juKEUYccU/T15jR5E7YAyv86iRYbvnLkG9m/qbcc9WXBQ==
X-Gm-Message-State: AOJu0YxE8lxeY16NlYq1NRf6JURoC+tk81YULCe0LVakT//FE8PS2CfV
 j5E6UVaYRKEFRHzVtgNfJX+zg8xjIyTyrqFOhsRv5hSc4lUxry48xOZubbu4S6UZ/L3OT5YnsBO
 OrhRD5FUWbx8va8Hg3Azzm9/wETI=
X-Google-Smtp-Source: AGHT+IGFedwBgFTj9cmo1LljwlLa0GjKtZGurP6+578WiU6ZKPudC4Oz6viQhvY/B+xTn+SE2zR3n9OKcHQUjyZCMpw=
X-Received: by 2002:a05:6512:1cd:b0:513:cc23:3b6b with SMTP id
 f13-20020a05651201cd00b00513cc233b6bmr2295102lfp.48.1710860689237; Tue, 19
 Mar 2024 08:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
 <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
 <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
 <CADnq5_OtProx-8d_0epm9TrYtE_rHLYDhEb6XrK9bgOPi7MicQ@mail.gmail.com>
 <CACawnnx8Z5jbBdzct9Omeq3Y6iJhMDTDy_C3DRPe9irjoHRn+Q@mail.gmail.com>
 <cbc7739a-21c3-4872-bcb0-4fceaf607d32@amd.com>
In-Reply-To: <cbc7739a-21c3-4872-bcb0-4fceaf607d32@amd.com>
From: Kurt Kartaltepe <kkartaltepe@gmail.com>
Date: Tue, 19 Mar 2024 08:04:37 -0700
Message-ID: <CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Mar 2024 10:49:42 +0000
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

On Tue, Mar 19, 2024 at 2:54=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
> Well what problems do you run into? The ACPI and BIOS assignments
> usually work much better than whatever the Linux PCI subsystem comes up
> with.

Perhaps its easier to show the lspci output for the BIOS assignment
and we can agree it's far from helpful

           +-04.1-[64-c3]----00.0-[65-68]--+-01.0-[66]----00.0-[67]----00.0
 Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge
DD 2018]
           |                               +-02.0-[67]--
           |                               \-04.0-[68]--

In this case the bios has assigned the upstream port 65-68, for its 3
downstreams 66,67,68, and then assigned the upstream port of the
device's own bridge to 67.

In this case not only did BIOS produce an invalid topology but it also
does not provide any space at the first upstream or downstream ports
which the current PCI implementation would require to assign bus
numbers if I understand it correctly.

>
> The PCI subsystem in the Linux kernel for example can't handle back to
> back resources behind multiple downstream bridges.
>
> So when the BIOS fails to assign something it's extremely unlikely that
> the Linux kernel will do the right thing either.

I'm not sure this is still the case, the PCI subsystem with realloc
(and assign-busses for x86) deals with enumerating this topology which
reports multiple bridges just fine. The same configuration as above
produces this bus numbering (with hpbussize=3D20)

           +-04.1-[24-66]----00.0-[25-66]--+-01.0-[26-45]----00.0-[27-29]--=
+-01.0-[28]----00.0
 Intel Corporation DG2 [Arc A750]
           |                               |
    \-04.0-[29]----00.0  Intel Corporation DG2 Audio Controller
           |                               +-02.0-[46]----00.0  Intel
Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge DD 2018]
           |                               \-04.0-[47-66]--

The Linux kernel doesnt do the right thing without these features, and
these are not the default. So you may be right that by default it does
not recover from the situation of well.


Given the bus allocation at the root port I can imagine a more
aggressive than default but less aggressive than `assign-busses`
reallocation scheme could deal with both preserving root allocations
like the APU and renumbering things behind upstream ports. That might
be a better approach than renumbering even the root bus devices.

>
> Regards,
> Christian.
