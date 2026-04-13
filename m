Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BFBF34C65
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 16:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FCC10E462;
	Mon, 13 Apr 2026 16:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IeLaDxT+";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659A610E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 16:52:20 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-128bae6a35aso799010c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 09:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776099140; cv=none;
 d=google.com; s=arc-20240605;
 b=GaBr9xPE+xjNT8YNMmWKVI6M5NSM/i8MX1nPHp6Okj3ugd105I3vV7FYiEZc6LBFyA
 hgaW/xdHS79HcwPRxRs8CR3fS7PspCQkW+vGoTzdQCQKPQaviiC9rZ2f6sCgDfWYn+k7
 /c8+aj8YV8how/Y0NCUR98wqWslrzlskX/YAgwLCcBLJyNMExckZ3pLWErN54sciBQaW
 r1vAbSGLhQybnXpcE+FSIxXaBT3TfDbIzx+snGI1MbgduQ0ZiA927XdXOQCuFYxy2UhZ
 6E6fmeIAPT/aL3pQG6c0rgtvCMpxF4uR4teHG/9ZwUe+mfi+FwpXO73hQTzwhRDeiF6H
 +DxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tcetian0kfhwFr6gojPZ+se+ZoBn3rYONFahogSLrLs=;
 fh=fjcRQ5XoVF+mGotxSGcVEz8MPPEknCNadRCPOfV1WEI=;
 b=V+fEcYNUeWDTwT02LrNRIIfg4h4ed3086GJQQeCOgxqrrtU6MbyUyO4q/j3aB8Lk1d
 1K433VEtsD+mzERzxdC7syWTb7VKsfH617xkP1pc/tXdnkqhIA0z7e8ncNM7f2Z38e4+
 dhG8jz0R2Z0Sr0UTO9AnuSnG7OTrxVHn85bPy9kImPURkkxwEdfbLmG7KASypZaLAWtn
 Gr7oDUUb5VhrZ9XOH4m1XWvV2pXjqNSEiA/4e/VQf0qmgDP3wvUNGprghefCshYmxTFg
 bNs8LVoisa/w5abYtFJSOvpQ99hxXmkm+397k/I9PuA9ckEkZigbeJ+4Ol/NmsJdPp2r
 lJ/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776099140; x=1776703940; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcetian0kfhwFr6gojPZ+se+ZoBn3rYONFahogSLrLs=;
 b=IeLaDxT+vK5wJMBkbQGP8UfO3lUjnoB2HH5iouyTtvEA0RT5xb0mEt5LdoHcfAycSw
 DmM0mFBfNM2kMgiPxvC1bEbJfrOEZAidJcEI6cOtrZY9dsWTOTDyoOFiaxiFqeTqRC2b
 tnWpLKlXeQ0uZH2YemkYGphiDlm/aXyCrzL/DBAjKYhC2izm59t9Okn4z35pbBID6pTQ
 uMfG06pWZYFnqrXHeT/tXTix18g2WG9EfA3E2tB+rDzLaN48W0XPb8gG1QYL7lhTg3SW
 g7BCR6Cdw4hE3qlR12uPfX1Yol9GRWpaFQoQoBn1D8DbVe2VjZaAar5yLKTdOy6b+rgz
 6jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776099140; x=1776703940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tcetian0kfhwFr6gojPZ+se+ZoBn3rYONFahogSLrLs=;
 b=ifpZnAeiYjJPSQlEosAERibnQeDv9V3+z2bPHLqe6X5XhCmnD6XEXYiNy1QYJx/jhW
 VsliWSAO77yjo70j4RshCLaEmCc4KAmMMMkbpZdGoSit8ZURAnfCvSSjcwHL0kbzjZZR
 QGPf233vO+hmxM2WTcMMn312w70KOYzdS/xweUubr2UJlhri2fyguL8Vxm6HbIO/9Y4S
 Zhk5NWGJni6qPYlr/TqgvUHbMV97UESua/wAwR5n60R19P7NcyZMpmSQ20jegcgFin30
 x8xhTs0o38m7o8bgrMKv0vj+8tdCL9XGBZw6S+DaNU4AOMs0/T28/NdQUfl5E2xYtXeJ
 gNEg==
X-Gm-Message-State: AOJu0Yzh0CqT+1rqyIQdInsisLq6FnGV8nC+kUtc3bbOc3ftiNGCMwcQ
 x5SSojJN0dHymiJMt5s9KxNdpDUZsJWD/qqRIWpTlZYWQSjEMhF3QOMxCgSH2t04P5QeAhba0Yh
 scAZcsCpBavUHCLiNONGEsRzVv4TXthw=
X-Gm-Gg: AeBDieuGVF61MrTY84S9gXC9dqE4KdrPc2orAaeIr3vJzADmaFf4j1I8Pnh7kdE09Ps
 k8m/uEJFXSGRaMON5sSr+HRqgitYXz1mPr0AFCrSqhf7szPka01soG/QhzC0IrOdEzXClTh+ua+
 pD2iHGEI7oQBTYxggdqBCjQ+foNrSJbfgJNWRa1EM7GQPrBSYg+xmiOM++2tP+yFsG+8jUXvTT3
 4Lxn1cP+N8aJBJBUU2QZsHKnB4ZHpnhrB3Fx/cBThyLokC2vHLvUMOcs0uhW31uykeg16wwrfhI
 kspr9DzVW3Z0RbUmGrhC9YX00Nqsi7jHv9seYXCz7RhltDzdnt6u8o5g+MNChFx/ISpefw==
X-Received: by 2002:a05:7022:4589:b0:128:d0cb:7a97 with SMTP id
 a92af1059eb24-12c35a75fcamr2961082c88.3.1776099139502; Mon, 13 Apr 2026
 09:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpo2meuqBDvbkX1_rmCacoLnixbQXdVw6+j5n-kYe25fj5cVw@mail.gmail.com>
In-Reply-To: <CAGpo2meuqBDvbkX1_rmCacoLnixbQXdVw6+j5n-kYe25fj5cVw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 12:52:08 -0400
X-Gm-Features: AQROBzDPyZQsjNlbYPxPw013x7dF-Ra7kMTBxMFZWY0Hh8-_2hOjvbKtK1j20mE
Message-ID: <CADnq5_PKq8HHnHD3ivqy0fXXHPnO35zzNMMMi2+x1wcyLaWPNA@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: teardown after failed init causes NULL deref in
 fw_reg_write_reg_wait
To: Geramy Loveless <gloveless@jqluv.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

On Thu, Apr 9, 2026 at 4:54=E2=80=AFAM Geramy Loveless <gloveless@jqluv.com=
> wrote:
>
> When GPU initialization fails (e.g. IP discovery failure), the teardown
> path frees TTM buffers which triggers GART unbind, following the call
> chain down to amdgpu_gmc_fw_reg_write_reg_wait. This function tries to
> emit commands to the KIQ ring, but the ring buffer was never mapped
> because of the initial failure to bring the device online.
>
> Check that ring->ring is non-NULL before continuing.
>
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 5179fa008..09db87139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,6 +876,12 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct
> amdgpu_device *adev,
> return;
> }
> + /* Ring buffer may not be mapped if GPU init failed early
> + * such as a discovery failure. Check for NULL and return to stop a
> kernel crash.
> + */
> + if (unlikely(!ring->ring))
> + return;
> +

The formatting here looks messed up.  Can you send this using
git-send-email?  Also, I think checking ring->sched.ready is better.

Thanks,

Alex

> spin_lock_irqsave(&kiq->ring_lock, flags);
> amdgpu_ring_alloc(ring, 32);
> amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
> --
> 2.51.0
