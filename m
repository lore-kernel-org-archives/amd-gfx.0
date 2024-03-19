Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3F7C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 09:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B1710F890;
	Tue, 19 Mar 2024 09:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jwda0t+P";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A5B10E20D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 01:56:06 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-513c8b72b24so5556321e87.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710813364; x=1711418164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/npr9ZBgPo4lt1K3xYl0Hg1IsU/NO66AdS2S7y8TJ2o=;
 b=Jwda0t+PsMVLfEcrX2Dv8OHlh1j4sRKmS9KX+3WL/4M5lp73AwhYFRHaH7at3IM8Aa
 O1+MZbD2m7G0QfQgQiCq33srAIseU+WHZVkNNt6KkfMSnZKFmIJsQRrukJECiaHf+Zt1
 +ZVW+tKReeTDNIh0//qzm5tU3Pmv/oUilZrWLMpqkVGrH04/CJmoQRb57CzVdgf/jHII
 IJfKjAHKj1BXYuIxJzz7YtU+KH43UnTxJlbefOa4e0eGoVztWpgJwhOQ1roDt1cXfudN
 FhGqGVWcpto60bMV/yJjzyZSbbPqOfK05tBjGd8VUGpwsa8xXf/1R1RjKyAawzrc6JZS
 r5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710813364; x=1711418164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/npr9ZBgPo4lt1K3xYl0Hg1IsU/NO66AdS2S7y8TJ2o=;
 b=i2axFZ4ZuZzVeJn/H1frIAK0aDxL8m+iezM4SnjcC2LeD7VBP+nmkDRlrszFOXtDBd
 eW/CL4EFIRDa9HPeq+O8egeeo0o7eYraSIMtIQnBihJYXrTr3ic3gscOhSUYpps9S2/m
 bGxWGRtnBTcFC60xA2EtE4X+2YVmwtyNldj5agRJIvXhfT75JU5yupY5L85W8ZU/11g0
 5SNU6LBafiWvsLYgTCjhlLf0K2bGGYRtzFYkN83hschy68tNwtv8+yMAl9K1u30sRfS9
 BNw/n0YrjDuhecguQH8pDrAioPvEb2Ncp7o/sGZdBHbprfIa4EWENvV0X/MKSla+u0FL
 9bLQ==
X-Gm-Message-State: AOJu0YwA1s8Og3xT/8BqQ9kMDfsgpJOwRoILEngUD6MCgMvTVnvFeOGh
 oopmtdjlB4GV0YgaGih6q7vKCdyLjAcJ3Q8H+ms6p2f52cyAfS0vwKWI+IGUed8pBX3w4AU/4YL
 IuSdL5by36J6+aww3NVzhPRGFXoA=
X-Google-Smtp-Source: AGHT+IExRMRPzOVhj9qi1Lc+VzoewkEnDD/KGB5hFwfMkT7V9AYpLZWs89VHTaZLzhpV62Ey+M1jykAAHkcwQHgMvhU=
X-Received: by 2002:a19:5f5b:0:b0:513:e7ff:15b7 with SMTP id
 a27-20020a195f5b000000b00513e7ff15b7mr598458lfj.59.1710813364016; Mon, 18 Mar
 2024 18:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
 <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
 <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
 <CADnq5_OtProx-8d_0epm9TrYtE_rHLYDhEb6XrK9bgOPi7MicQ@mail.gmail.com>
In-Reply-To: <CADnq5_OtProx-8d_0epm9TrYtE_rHLYDhEb6XrK9bgOPi7MicQ@mail.gmail.com>
From: Kurt Kartaltepe <kkartaltepe@gmail.com>
Date: Mon, 18 Mar 2024 18:55:52 -0700
Message-ID: <CACawnnx8Z5jbBdzct9Omeq3Y6iJhMDTDy_C3DRPe9irjoHRn+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Mar 2024 09:00:19 +0000
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

On Mon, Mar 18, 2024 at 12:57=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, Mar 18, 2024 at 3:52=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
...
> > Depends on the platform, but recent ones use VFCT.  That said, there
> > should only ever be one IGPU in the system so I think we could just
> > rely on the VID and DID for APUs in this case and check everything for
> > dGPUs.
>
> Is there a reason why you need this option?  Even beyond this, I could
> envision other problems related to APUs and ACPI if these changed.
>
> Alex

So there are multiple factors in play. I am trying to make use of the
lovely usb4/tb3 controllers on the 7940HS with the reportedly Intel
Tamales Module 2 pci/pci bridge over the usb4 interface. This provides
a handy way to expand the pcie bus but configuring ACPI and pcie
topology isn't generally an option on consumer BIOS (unless you want
to enlighten me). This leaves us in the situation where the bios can
enumerate devices poorly resulting in inaccessible devices due to
address conflicts. To resolve address conflicts the only option I'm
aware of is pci=3Dassign-busses, maybe this could also be configured at
runtime but assign-busses seemed nice in some ways.

I havnt experienced any issues with the APU (graphics, hardware
encoders/decoders) but I do think assign-busses might be renumbering
again after suspend/resume/pci rescans but I need to debug further,
maybe suspend/resume are just broken when ACPI addresses are wrong.
Obviously the graphics user space (compositors, mesa might be working
as expected) dont handle the device switching addresses while in use,
for amdgpu kernel side I haven't inspected deeply yet.

I'm not sure if this is the right approach to solving the problem, and
given your input i'm considering it may be better, though not
upstreamable, to implement renumbering only for specified devices like
this pci bridge or investigate runtime management of the pci bus
addresses. The current assign-busses implementation is quite the big
hammer admittedly.

--Kurt Kartaltepe
