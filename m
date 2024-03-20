Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144B1C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 09:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88BB10E42C;
	Thu, 21 Mar 2024 09:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kdN+41f+";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE2010FC8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 14:24:46 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-513c8b72b24so7645034e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710944685; x=1711549485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIpZ81OiK8i/n4RlGngn6tAkU4dlWaxx4D+c6j7SUF8=;
 b=kdN+41f+Rx3qtJlhdM4Vv4tn9cr2iruEHq9QWKXozTRFIZE3CsXuOq4U0rbhAhn+Q9
 JU7KESoG5hGYbj3KyEIVZa/+b9cljbEeU0VFF1hhDvSBRlIeZk8xxVZzNDXnvaMw0PLx
 MCTf2jM8AyNr+g67lo2ATJY5sT3gK9mdMR9+sdLPqgJG6so+2V6e4sz1+AUyLZi6JpPY
 xy9yTes3J0uiJTsyINO/4BbJQOcaE306p0I8uPK6irkHadKvC7JqtD6R3jQx3JLErTXM
 9hU7qHfUbkueK6MBVOEl5pACIv+RQAJ03qUVl4/UgTKWaD0W9BH/FeYshoAQipoqNV4G
 IB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710944685; x=1711549485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIpZ81OiK8i/n4RlGngn6tAkU4dlWaxx4D+c6j7SUF8=;
 b=DeQP9lo0TMKpmMx+RlSBUVGnCFGJk/GplGgJq+etQBZ3DOuD0PC4QF8G00+sK2acyS
 DJL3oj9xJP/hgczC/3vLPs8BpHlNKE5S7vS7P0F4mutqtVymHOef09gTR+D+LaA6Qocs
 5XL7F5+EX3XffF2TjYN8oceET9KBqfd5rVDuy+qs07bvdZ8gZ2zNTUtUgVGHMc0wuYo2
 NJn+5dgqCf+40anpj/7ts56RaHz1LOELkjIfHHC4TYFzATc6lMRi2Wlwg62EFKhpwCLC
 dux3EgczAJBaXjhFbKVcndel/5knoTD7fr9FJXwT8zYgfsd/SdWsasvUo+aexor67PZ6
 GJqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd/eD1Z7HCK350jmGOnDJ1h5H1X8OH4T0N+eJaLWF+yq/nT4S9i6j5IA9Pq2oO4VAsQ3LOF7d4AfJPVFo3JTYDBpcfqCWhSxm5dt+SKg==
X-Gm-Message-State: AOJu0YyxjeQwlKYhBhs7xkF2vPICcFDx2ywcHZJ77uO2vVa+kj7VIO/9
 jkJ6YYe/ExA2nMLmVXT1lFtM0NsEUYDSutcU8ubE4d0Li2FuVtFF0PaXjr+TiFpgtxNFoYTdivG
 mPsMEQKQ8DlEPTIdoOm5ql9o8VrQ=
X-Google-Smtp-Source: AGHT+IHVl3WESMdvzEi8HZi1/YNXm+62QPOhi4JClE5pVRHLw/eQ8y4tjZXPEONUlsuLdoS64AkKKBiywtQhdAnn7N4=
X-Received: by 2002:a05:6512:472:b0:513:e2bd:6d15 with SMTP id
 x18-20020a056512047200b00513e2bd6d15mr4206157lfd.49.1710944684436; Wed, 20
 Mar 2024 07:24:44 -0700 (PDT)
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
 <CACawnnwei18rsUPXcPW8iUBXyKBghoOHSzMMy6ndwi64ovF88g@mail.gmail.com>
 <8fcf6836-8c86-4072-b201-e8a62c438e2c@gmail.com>
In-Reply-To: <8fcf6836-8c86-4072-b201-e8a62c438e2c@gmail.com>
From: Kurt Kartaltepe <kkartaltepe@gmail.com>
Date: Wed, 20 Mar 2024 07:24:33 -0700
Message-ID: <CACawnnxFhzJuy_RLJ7urgwzLW9+2A4En69Sj9SvNPg2YqW92iw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 21 Mar 2024 09:21:12 +0000
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

On Wed, Mar 20, 2024 at 6:31=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:

> Can you provide the full output of lspci -vvvv. As far as I can see that =
doesn't looks so invalid to me.

I've added the relevant pci probing debug output without assign-busses
and the lspci -vvvv for a boot with all devices visible.
https://gist.github.com/kkartaltepe/2f01f33c7e7af33cf0d28678e91f50fb

> Well that is just a very very old workaround for a buggy BIOS on 20 year =
old laptops. The last reference I could find for hardware which actually ne=
eded it is this:
>
> commit 8c4b2cf9af9b4ecc29d4f0ec4ecc8e94dc4432d7
> Author: Bernhard Kaindl <bk@suse.de>
> Date:   Sat Feb 18 01:36:55 2006 -0800
>
>     [PATCH] PCI: PCI/Cardbus cards hidden, needs pci=3Dassign-busses to f=
ix
>
>
> So as far as I know nobody had to use that in ages and I wouldn't expect =
that this option actually works correctly on any modern hardware.
>
> Especially not anything PCIe based since it messes up the ACPI to PCIe de=
vice mappings. That amdgpu doesn't work is just the tip of the iceberg here=
.
>
> The bus assignment code in the PCI subsystem is made to support hotplug, =
not completely re-number the root hubs from scratch. That is just a hack so=
mebody came up with two decades ago to get some Cardbus slots in laptops wo=
rking.
>
> I'm not sure yet what's going wrong with the Thunderbold controller, but =
completely re-assigning bus numbers is certainly the wrong approach.

I was referring to the work outlined in
https://ostconf.com/system/attachments/files/000/001/698/original/Sergei_Mi=
roshnichenko_linux_piter_2019_presentation.pdf?1570136708
for nvme enclosures. Which maybe referncing more the movable BARs than
the renumbering that occurs with assign-busses, but also on power with
device trees which may behave differently as it mentions assign-busses
to get this same renumbering of buses. This makes me think at least
modern non-x86 devices expect to behave this way, which may not be
relevant to ACPI/x86 systems but at least this shared pci code should
be solid.

> I'm not sure yet what's going wrong with the Thunderbold controller, but =
completely re-assigning bus numbers is certainly the wrong approach.

I agree, it is just what is currently available in the kernel. A less
disruptive approach seems needed.

--Kurt Kartaltepe
