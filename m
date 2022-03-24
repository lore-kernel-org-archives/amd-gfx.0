Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FABC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 01:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9DE10E522;
	Thu, 24 Mar 2022 01:02:52 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB8710E522
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 01:02:51 +0000 (UTC)
Received: by mail-ua1-x929.google.com with SMTP id a28so1432577uaf.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 18:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=IANY+ekVZQgcH0O7joJntQXHOX1ZyJ6j0/bmDm4T7UA=;
 b=MPLS2FZhiXVpXMHnBJMsVn3d3exSHUuHOmo2EV6zBLh4/hD1YqrXqWw7opwy7TuweZ
 TEObQr4NRatb5YMoQTURuHKLGD7ZR7W0b8tYdeQ1TmA9179vTK6rkVdzRdTDTOuigBdz
 qun7t4mvFfx4+V6TJIoJ4JNz6kd2FMKM26qho9kqPD8YsYe1VaaJXE7zeqtEUCXsZOj1
 vIJ7ieiAckDQmaPRRX1tqHUvOPOqHQ0XFjEtG0HQBuiX38+5hkP+7aSGq9csKcLmoRO9
 SWZKB0mQzUpspQegxwwvAyqnluLessele3XB+VE+M9qOcPkBtdlI/tj+pE+yRvxCmYzI
 wtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=IANY+ekVZQgcH0O7joJntQXHOX1ZyJ6j0/bmDm4T7UA=;
 b=g1n8CJvd9Vp40s0DFLfDBiJWS81TfyS15kWZmxuckvnBXAp92+KMC8h5bdrVuyhizp
 B+FV8sJ0RaEi5TtZBD69PrmbkjCjQcDoDBx3M2tdnQgUoHqkny4g4HNPxKrT3CIOGUYJ
 LmZF/3934DOKnrpakfCr1rO7FeJ43ZxwAuWgSCiJK13mpgINoIOkK6IPAP+i66kNGoE9
 BV3HKZgHJFpTu1xdinm13IA189Dvr4JkIVrhlqT/CbAjv33lBKA3N36psYT2Jm/opHUm
 td3YIDD78iX1NSHjjh3dU4Nq644oTD0G/0k2DstutWipsZMg9VTlt4ftUgi5IwWfsQIr
 xxNQ==
X-Gm-Message-State: AOAM5330gQeKZ+Nmtca4jGxtqXZokhNwtkJ144BhI+UOSQO3F2Q5+5lv
 x13jeAb8WNngKDhxBG2XathM3Cbs/bgM3Q6Mw0KLpZ1/pZw=
X-Google-Smtp-Source: ABdhPJxW/M0Bs4LNCbnSgfAiYlRbt7oDS7WoJ/tn+9jhLTi5QM8hGP0caq4N7PjUZQoe8OnKL408FQFHj02WTJMvh48=
X-Received: by 2002:ab0:6647:0:b0:353:7544:1d2d with SMTP id
 b7-20020ab06647000000b0035375441d2dmr1418730uaq.115.1648083770124; Wed, 23
 Mar 2022 18:02:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:2287:b0:28d:c775:b69f with HTTP; Wed, 23 Mar 2022
 18:02:49 -0700 (PDT)
From: Craig M <cmroanirgo@gmail.com>
Date: Thu, 24 Mar 2022 12:02:49 +1100
Message-ID: <CAHtRFGvj1DuYzUUL1P5bvfMpT1WkwUL2ZpZQt1iYf-XH=fJP0Q@mail.gmail.com>
Subject: ATI Radeon Mobility 3470 fails with Kernel 5
To: amd-gfx@lists.freedesktop.org
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

Hi,

I'm trying to track down a problem with an ancient graphics device ATI
Radeon Mobility 3470.

Ubuntu/Kubuntu 18 is shipped kernel 4.18 and the radeon drivers work well.
With 18.02 and later it ships with kernel 5.0 and the radeon drivers don't.

What I'm seeing is hard to describe. It looks a lot like the scan
lines are interleaved and there's a lot of noise. It's not the typical
screen tearing, nor is it just snow (black and white noise). I can
*just* make out what it being displayed onscreen, but hurts the eyes a
lot to try and do so!

If I hold the kernel back at 4.18 things are just fine.

Some detailed info (from a working 4.18 kernel). Note that the
returned information from a 5.x kernel isn't all that much different:

$ lshw -c video
*-display
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0description: VGA compatible controller
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0product: RV620/M82 [Mobility Radeon HD =
3450/3470]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vendor: Advanced Micro Devices, Inc. [A=
MD/ATI]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0physical id: 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus info: pci@0000:01:00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0version: 00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0width: 32 bits
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock: 33MHz
      capabilities: pm pciexpress msi vga_controller bus_master
cap_list rom =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0configuration: driver=3Dra=
deon latency=3D0
resources: irq:26 memory:c0000000-c7ffffff ioport:9000(size=3D256)
memory:c8020000-c802ffff memory:c0000-dffff


$ modinfo radeon

filename:
/lib/modules/4.18.0-17-generic/kernel/drivers/gpu/drm/radeon/radeon.ko
license: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPL and additional right=
s description: =C2=A0=C2=A0=C2=A0ATI Radeon
author: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Gareth Hughes, Keit=
h Whitwell, others.

...
name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0radeon
vermagic: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04.18.0-17-generic SMP mod_unl=
oad
signat: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PKCS#7
signer:
sig_key:
sig_hashalgo: =C2=A0=C2=A0md4
....



I'm just trying to track down the driver changes between 4.18 and 5.0
to see what I can do to change settings. Any help  would be greatly
appreciated. I've had a quick look through
https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati but I don't
know where to start (as there's no correlation between releases and
kernels, from what I can see).

Regards,
Craig.
