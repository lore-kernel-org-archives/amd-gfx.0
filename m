Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E03CC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDA910E54C;
	Mon, 28 Jul 2025 17:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4L+yhDt";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B3110E553
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:11:46 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-24049e42f37so667455ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753722706; x=1754327506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ot/Au628lFTBX1cJS3kWmBQarReXodTBunjosmvZyxc=;
 b=J4L+yhDtBFtCcpKhCHlzagJK0R43I1H/ysmQjueTfYxbctYcSKjJg/LPNPQEWj4gEp
 cGeZ/WB4o44SHI8LGCzxpa7zstvuPqapsZZuFW6fZDKuiCchmUbVMaSsUv0zZePAPtyV
 RDB6b7CSNAWS48DYYZxkyZtnEi4TV1j0PveH8MaleNyqWkE+kevbKtDk9/4oPqIp9yB9
 JzL3OH2kSF/dNsqigkMWKi/YjhtmIDRycL/g9t2tTk1S7F8E0wyxwR0Xsm8TUYOh8Sta
 ogzxIJ2tBxwpVW5652WVGB9OIkO/czYrEd8L4gtYqQRe4FgILNwH56gxn96A6Uee1ejl
 BaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753722706; x=1754327506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ot/Au628lFTBX1cJS3kWmBQarReXodTBunjosmvZyxc=;
 b=EuVxg/c0LdEBhtiLpMT6IGBpw0UcsgmOYE0S/BPfi55eVqVkcstJlSQeNpzmUF3k2g
 SqGxvo9rJZVEqznL1NVHRMYwOxZZW4GGyrfvcpSkTSrymkj4Y3xp9s73GR72qUlGSsZY
 6o7xaQxolyc9oT6IpnHAHLtmKH021C1JRYuZTvjdwnRYySQyLA9T5ezCVzw0D6bgMkuc
 DGMYVsXOcDKX84+wHE3plBacBN+u5XabRVWNoAvUMc3MZrJ/ixkhd++BHinBSSUSAM00
 2AgHclxVm2Kifqk+gUue42cFKIsJGvbhoHc58XiBoze4Sdz/RkRdaGxSkAI9ItKNUJYM
 S6nA==
X-Gm-Message-State: AOJu0Yx45Msu8h1YfrH6XaMOhiUWGy5cm6CEGxisyEmZFt8jIc4t0nkT
 iJFE5qlGKX7WQmmVhdG+KymnQ8c9GUCi+p2EEyWQc7YvxHWRZxD8a6ju0wpBtjaTbEHM9VgjetJ
 166cDioyOBi23W7lW6P0EwY376XaTRbHUyQ==
X-Gm-Gg: ASbGnctfnlTkG3MPvDFGpVqdKzS+C2vzTyhYV7+i9oAIZ0QET/Yj/soLNowHh0Ad13s
 Tf7eIlOopqVpN7GwHTRcYBgbiqgd2diYAGp7yl1wTlVydkzwcoP2FMr8azqn5/76JYq8N/HKK6t
 hiu3+y0fki+EMWg0DouFeooZ4PPAvHq4KWfq7NF7FTPGrBq3ib9d8RBYGHDVAgyTSQE0WLxm9dz
 D2/kjaJ
X-Google-Smtp-Source: AGHT+IEutFeh2u+a5DPbOwJwpwbR1mqnrp0CfTL08STsdTNXJbyWGUzqxr+C+LDv1nrdsO7GHqClV1PbZDP8LYEA/Q0=
X-Received: by 2002:a17:902:f818:b0:240:5c13:97a0 with SMTP id
 d9443c01a7336-2405c13a562mr5497935ad.6.1753722706090; Mon, 28 Jul 2025
 10:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <1501262214.149072942.1752943848461.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:11:34 -0400
X-Gm-Features: Ac12FXy8DWmtpegsP7-vP-DvAYCu02_QxLlu9YaCwxMwEjWMcE3IJooogZsMXfQ
Message-ID: <CADnq5_NiJowWbU6y8cGJ5vDbxgpTSh7Ak1Us73qy192yRUF0NA@mail.gmail.com>
Subject: Re: A few more items for the glossary, and understanding GPU switching
To: Yann Dirson <ydirson@free.fr>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Sat, Jul 19, 2025 at 7:58=E2=80=AFPM Yann Dirson <ydirson@free.fr> wrote=
:
>
> Hello,
>
> Back to reading some amdgpu code, I stumbled on a few things that probabl=
y ought
> to be added to the glossary.  Well, to be fair, I actually just had to re=
ad the kernel
> logs to see most of them, so those likely make sense to explain.
>
> * ATPX (could not find anything about that on the net). "PX" alone seems =
to be used
>   as a synonym.  Referred to as "ATPX power control", and closely linked =
to vga_switcheroo.

ATPX is the name of an ACPI method.  It stands for ATI PowerXpress.
PowerXpress was the marketing name associated with dGPU d3cold when it
was a vendor specific feature.  Eventually this was standardized by
ACPI and there are standard methods for controlling device power in
the ACPI layer.

>   This seems to be a preferred alternative to
>   BOCO and BACO, but those are only tersely mentioned in the glossary, an=
d could maybe
>   use more details.  There also seem to be the notion of "ATPX hybrid" (w=
hich apparently
>   applies to the RENOIR in my laptop)

The ATPX method still exists on some laptops with a dGPU, but it no
longer controls the dGPU power.  That is handled via standard ACPI
methods now and has been for a while.  The driver checks the ATPX
method to determine whether it should use ATPX or the standard ACPI
interfaces for power control.

> * MACO and BAMACO looks similarly related (I may have missed some ;)

BOCO/BACO/BAMACO are all names for various low power states GPU can be put =
into.

B =3D Bus
M =3D Memory
C =3D Chip
A =3D Active
O =3D Off

So BOCO would be Bus Off Chip Off.  Basically the entire PCIe device
is powered down.  Since the PCIe device is powered down, it no longer
appears on the PCIe bus.  This is handled by either ATPX or the
standard ACPI d3cold methods.  BACO is Bus Active Chip Off.  In BACO,
the bus interface is still up, but the chip is powered down, so the
device still shows up on the PCIe bus, but most of the chip is powered
down.  BAMACO and BOMACO are similar to BACO and BOCO, but they keep
VRAM powered up so VRAM contents are not lost when the device is
powered down.

> * CRAT seems to be known as "Component Resource Attribute Table" ACPI tab=
le according
>   to various Internet sources (it is listed as "Component Resource Associ=
ation Table"
>   in kfd_crat.h, do we want to adjust this?), but I could not locate any =
details on this
>   table (ACPI 6.5 seems to list it as deprecated, but even 6.4 just gives=
 erroneous
>   information, "Links to ACPI-related Documents" in=E3=80=80https://uefi.=
org/acpi has no info)
>   Is it useful to add to the glossary, with some info about its role in t=
he amdgpu context?
>

CRAT was an ACPI table which was used for topology information for
APUs for ROCm.  Unfortunately, not all board vendors properly
supported the table, so the driver has a fallback to handle missing
CRAT tables.  It hasn't been used for a long time.

>
> Now about the init on my MSI Bravo17 (Renoir APU, Navi10 dGPU)...
>
> What I understand about ATPX is that this is a "PX system", as shown by a=
mdgpu_atpx_detect()
> logging:
>  amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0.GP17.VGA_.A=
TPX handle
>
> So amdgpu seems to imply vga_switcheroo is supposed to get initialized at=
 some point, right?

IIRC, the switcheroo code looks for certain ACPI methods on its own as well=
.

> Similarly with another similar-looking log:
>
>  snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio client
>
> But no other log see vga_switcheroo actually getting enabled (and the deb=
ugfs dir does not
> appear either, confirming this).
>
> That is, no call to vga_switcheroo_enable() gets done (both would trigger=
 a
> "vga_switcheroo: enabled" log).  The 2 call chains from amdgpu would be:
>
> amdgpu_init()
> -> amdgpu_register_atpx_handler()
>    -> vga_switcheroo_register_handler()
>
> amdgpu_device_init()
> -> vga_switcheroo_register_client()
>    -> register_client()
>
> Booting with "tp_printk ftrace=3Dfunction ftrace_filter=3Dvga_switcheroo_=
register_handler,vga_switcheroo_register_client,vga_switcheroo_ready" it ge=
ts obvious vga_switcheroo_register_client() never not gets called.
>
> The answer seems to lie in amdgpu_device_supports_px(), but I'm not sure =
to get everything straight here:
> amdgpu_device_supports_px() is documented as "Returns true if the device =
is a dGPU with ATPX power control",
> but amdgpu_is_atpx_hybrid() it calls seems to take info from a single sta=
tic struct, so does the quoted
> docstring really make sense?  And if an "APTX hybrid" system does not sup=
port vga_switcheroo in the end,
> couldn't we just avoid any mention of vga_switcheroo in the logs (since i=
t is indeed amdgpu itself sending
> the user on that track), or at least just print once that it is not suppo=
rted and a short reason?

ATPX was also used for mux switching on laptops which had a display
mux between the APU and the dGPU.  The switcheroo stuff was for
handling that.
The message comes from the audio driver.  I think it just checks for
the presence of ATPX and sets up switcheroo on the audio side. Someone
could improve the logic in the audio driver (and the switcheroo code
as well) to follow what the GPU driver does if you wanted to avoid
those messages.

>
> Best regards,
> --
> Yann
