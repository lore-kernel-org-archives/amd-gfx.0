Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780F1C55175
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2D610E2D3;
	Sat,  1 Aug 2026 07:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jscxWm7F";
	dkim-atps=neutral
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACED910E042
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 22:42:47 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-39c8dbf4ef0so14167981fa.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 15:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785537766; cv=none;
 d=google.com; s=arc-20260327;
 b=D72OzO66V/+LAd8q/uwKCyncMeTuyIArwtbcLJz4Jb/XV9FVAF/ZongJ+PQXr8A3ED
 KItCHYHsRtviYuBsu7fowLIoRha+HUnQhrucwWHO+Div+ytJppkK63iSiTRclm/CWxR4
 ZC0HEUVsQAyhIS23rabebPyb8IgjxK5/wUi3V3Z5CZ7RHLKJ3nPandkKLRW/TsaT23gB
 mte46eHbok19tqhn3Fh2kFf8BSglAPqCyS/q5F4SBEvC9nn64453Y2O0cROm4Duhv3uv
 WriOU2XdThDC0UZbXazBGJfuTpbDOgRT7J0OmOOKb8o4Y1071jowXwkq69YVehFZhB1Y
 2T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
 fh=m6Pfav3EUoTX2vNhwzfGP/9VXdLnV5jrBG9IvjuRJ8E=;
 b=nvmQh1Y9Gl7cw/rDG0bpfMKdul1pmznkQ+gdb98nyqme38IarPbAFADx9GSd35ZxaY
 8JWeAYj++usAkMx0I1xJdpg3roNtJ516PQd+UnZgrME/gxe3bWjOijA8lUAWSiRReBgh
 kbr0THPN+9ds3h0UNM/w0P3vL/i5qtHVDKUvBqrLkRVg885rZi1XOt4dmM0aGPxzRvoO
 CYuEMn4ohHeHYEdx0g/f0TkbpF1ayGQ1/1JyJ+DxWTacNx/QnwXlq5q+8BxO4eduA2Lq
 W4Gh5GjM/1RkyFbxPfK/YyKlRcPHFEy6VY7lMAlVUbaHPUrrzEDewBM0KEVms3kydEKl
 tVGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785537766; x=1786142566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
 b=jscxWm7FLzRdOf6Mmf2ZCdRNMEljWr3bPHo+JngqkzDfs9kgg23nv+3MLa22jeGqGM
 MIjMTqlmpWTol89CI1qegevBHy5Iq4+anUeAJ7/EjET2UAUavW1eouoAi5NnIq+MZzcn
 JLbUVZ/ckHJTiH/FprqblFWYKmOvV7WrYBPnlt0rDuCmvcXLLdKPs54K2QGaUuOyyH9i
 3whMJy9NiLGnEbFMyhhG8LkFDwIHOdS1KLFicAQRPh70U6szi5caY3r8Q9+/aYte6ThV
 rn7gcroUllfOuSmf1HO5/6x2lZ/v4sQ8IRN10SYgNHBRU1wPqQM041cEs+ztIbfKy/IN
 yjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785537766; x=1786142566;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
 b=lLXd7R+LqMzpQJ6mEtZlDj/w1YC3Zgn9Wq4UW9ljHR63mSDTbZfq41pNvWahJNGae2
 5SRDDOvW27CdkGrZleb7KZh4D21UTI2GxeekpzfGHFTjTZPMqntfalJTl5Z0Zabdj9Q7
 d7/BF8Gz3LsYsscmKDq+h0nrAjPRponV3nYR+8DzcQ/0OusSC9oMqxVpSo9UetrYCP7n
 9HmLy2oSSqRmV8PxJ/3995Vq6sY7C43x+I45EFlU36W2zGoobSr3qG1iEsz1uugc0/dS
 YLrM/2OJu4q5jYJSjCsMa7uKmeYJqw8E7tOaOC9BJzPm3gq+fZXMVb0jbygclHdVODAj
 /QyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqM//+4l0Vx2SACwm4paK6FqUAz5tnbOoJ+3RkPKHlln46aVO8uSD9NmvGi/TU7iS8JfY+0am86@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBOxvow3A5ZKhC+p5v3feDqywZfTavRkMJ/WkDuIXWTNzjuf+U
 ZcIsmNiq4G8ignvQSl7hImrMxdLdoT5KS4egzJgW0k3Qv0YHhgcY9BVRwf+Wtl2Sk1wbVSvErEc
 mEZSJxP/lLZvLlsPJlrxEtj0Z5+Zip4U=
X-Gm-Gg: AR+sD11t4eKdzAtp0AH/cVJ//cSkaNTFLxCqmIYtgl6dYp0y3DGt1MCUKY+DKzzkCrK
 lSBMirWV+lqkYo7s+jhbIqqUFd26zPiSYX3f3dPqVlDIGu3UhfHncgscUI+AhCHvHKusPVh9soT
 duVUXUF8wtMB1yNK6PBg3XgRt+N+gIfJ5KqWAr0ZqkBuuLVFfdx1Dw1nI/kPPZEUhvTh1RhIEN0
 q5pF61P4IKe1OapWFtxL7mFU9Qba6Gum2jJMjd4zRTiD4Lf8CjbN5RSfV8WoF86IRXYUMxWMrRC
 I6esswjzsONmwR3VwyxwPftoAwq/4+U9Z6y3e5j/YiLn3qrCmks/tQqbRSEkkgCHJf8L5OYNj1f
 gCa5JX3jtgEJWYen4pVXdlQ/PulW1fjcLTkYeby4E2ClZIC5re07l
X-Received: by 2002:a05:651c:c8d:b0:39c:74ef:1a86 with SMTP id
 38308e7fff4ca-39f8640cf26mr2452871fa.33.1785537765380; Fri, 31 Jul 2026
 15:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
 <20260731162424.GA1571989@bhelgaas>
 <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
In-Reply-To: <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Fri, 31 Jul 2026 17:42:32 -0500
X-Gm-Features: AUfX_mzkvLUGzJCYHgtRvb9G-SIli9XZ_yCQ5x2jz8b5Ly_BQwxe_F38zuwne_c
Message-ID: <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
To: Liz Fong-Jones <lizf@honeycomb.io>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
 Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:58:44 +0000
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
Reply-To: bjorn@helgaas.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Liz Fong-Jones <lizf@honeycomb.io> wrote:
>>> This breaks amdgpu completely on the SolidRun HoneyComb LX2 (NXP
>>> LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
>>> on the root bus of its segment (there is no root port device, so
>>> pdev->bus->self is NULL):

On Fri, Jul 31, 2026 at 12:15=E2=80=AFPM Liz Fong-Jones <lizf@honeycomb.io>=
 wrote:
>> Maybe this is a tangent, but I'm curious about this topology.  Is this
>> running as a virtualized guest?  At the hardware level, a PCIe
>> endpoint must have a Root Port somewhere, even if it isn't visible to
>> the OS (as is often the case in virtualized guests).
>
> Defer to Jon on what the actual hardware configuration is, but this is
> physical hardware, no virtualisation, running as the UEFI rather than U-B=
oot
> (devicetree) variant. See:
> https://dev.solid-run.com/nxp/lx2160a/com-som/lx2160a-com-hardware-user-m=
anual#block-diagram

I guess this must be the drivers/pci/controller/mobiveil/pcie-layerscape-ge=
n4.c
driver.  The commit log mentioned this:

>>>   amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]=
: releasing

so the GPU is on bus 01, which isn't a nice round bus number like root buse=
s
usually are.  The typical thing would be a root port on bus 00 with a secon=
dary
bus 01, and amdgpu being on that bus 01.  Can you share a dmesg log?  It
should include the lx2160a host bridge details and the PCIe topology below =
it.
