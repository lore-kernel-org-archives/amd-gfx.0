Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7135CD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FE310F2DD;
	Tue,  2 Jun 2026 18:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iY1CjjrY";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1EF910F2DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:15:53 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3042a99f0ceso1211638eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2026 11:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424153; cv=none;
 d=google.com; s=arc-20240605;
 b=iI0XimvMXNPUwvJSam1eA1CPWjpsD00UDst1U/n8fGXpAO5BFmSpKHYOJLSMwg8gVk
 Rodc7vqb1GoDLAatxeGNuw9icFkMo15wuA/EwGYI8hFN5gpBEmQ6UZucis76jEnBfVvq
 q2o8BL4Zjx+gtdcZaYB/o4wgbTF6IdKjZ+0QBxX2ymfXoaiqzfspLYMfCYY9FGAUbPaB
 YiK7w5S8AhsoQZpcAEwutUEhQ5fMV7YE4BqCJFeP2m5Qpq38WvYRbsYclW1bfspkm0fP
 euSZl9aaEZLhSXHbWSKLAmlWh5W1GiFwZcRDpRwx48rKapOjRVBkkj07AuKahE6kVloj
 UhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G7yus9HKouUQHHR9xTi7qu+xES0zyoH/nrpEmMbB5Yw=;
 fh=gZ/QuQ1El2NU1RRI5pc/CAX4Mv4g4Ez7PWwEsOz7Ag0=;
 b=WP9aDy7DHMWxXoG1y3mWplrzG2UlI0nFb/3L2zqTYryTectVQA+gLxts0q+2qQNMuW
 OhujNPj5e++LndSxNfRYAojc51lGpeAqFwaUsYLmKwYgiT1m26jzyxUfatW8VSLzAQkf
 SHADs63cqT0iv5DVUy/kDvklwkHNIGxzJAfMlsPqjKZUpNdZbGpsatUsjb5gKLXdTmrf
 icO8oiO2iQziOE8EUWuB1eZJOVa0AB/s+zr3IiOhbNo9jCdSGBe6EGkzTwGHdc4FZJlb
 JQ+ZMO+3mCXIL0l4GlSG+BNEidwiHgy5gtzCbDvcTzKx0AH+LyEPunpWaIIkYBNGnJfs
 4KdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780424153; x=1781028953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7yus9HKouUQHHR9xTi7qu+xES0zyoH/nrpEmMbB5Yw=;
 b=iY1CjjrYi9mKsbtQFhbmquPpx1Bxc6HdEdjGqgBI6cHD/w4CQR/v0bSjaHNYPLNbA4
 mbbl7V6DGsFae8jTpmdO0qdKaVXfkcvVPVgqo9H4eJrx2Oume+dUsgRWirvKnAIhJsR0
 ayVIvfDQErna0xnXcnqHQqNPNZs1mIXdrpyFg4fKrMbn72FzbLr64QvVUymHmIaSN/xr
 sMiVQstuMtGzijAY3b4dzP/fgE1NHZ2Iq39fdaK27Vh39Pd9dR7dc4P/uCmfbZKnuqjo
 8V2cz/VGAai38FOThrN125Qw/lMH9Y4cHAaLWHHme3bR+dFZ6sffvW9n6YQD3Obiu+LP
 SVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424153; x=1781028953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G7yus9HKouUQHHR9xTi7qu+xES0zyoH/nrpEmMbB5Yw=;
 b=Rz2u8C+OkJzCycEOZq9HrYyTOLWM7Dt+NSCVBBd3XyLJM+PVEyB5rO7fYDiIUBVy8p
 hG+M4O88A8EL4tsf2vJu+70RgaFQism+qRAxccjrX3D+YZKAp9CETB0mWGBKJUpmo+N3
 f7wxllHmgFu35xKHjR9xqenDBPcpF4dmLM7a9p1piT7dipzdjERAYcZuolG9GsfIPbB8
 OdCld02qI/JZ+yjlfUSEzYiILTqN/l7FPrP0mhoKYPk7QTTdrPThJRr4O3Wh+cUOHU/J
 rmVA3iZWd13UBNjBaPPGfBUydOuyI6b7sisiVrjKoDKiO3w1vDIt1fBesVosi7fwbpqX
 K0Gw==
X-Gm-Message-State: AOJu0Yw0eQLc/rTC226bxvfZXVZrIDrtwEhFFt5+yWFfhCNZoeSQPR2B
 4moB3lAFWpKCx3BjUbcxhiCYDUXZS3RJx49ZKi2b81HEJz/kZZa7sbyz1y25Tbyn8Af9fYQwGCO
 BU+wdo2oR103aRp8CzfqfwuP2T4RnJwA=
X-Gm-Gg: Acq92OHQJiwD/Df4s4Dz6TGbHsJUW+LL+nyoDAUOgALmVDUVsfjknm85cuZSHSI+KOy
 0mBxuRmQW0aP6AFwljHzbEjaMMOZAOa2S2BP4y55GGYWCb2GIQX7cWWyUShK6vQEjsd7d015m3D
 8WPL/1hcPuXQYfB+EUByq7NO+9k3tnif8gKmiQwpn0IcOM0FCowPZUd4x3HSMHSehpJhNGPh/2b
 e+TWvuzr/j6bdDsm6T7RaDr4RvSmYqNo9NYNIKbKRpt63JNYXRCAbvIwi2jykxp0TMFedspxjE9
 sY3lLwkbJjEiJqNHblp2CESkzkAJ8TsokDXP7hSwXOQZ/xTwYzKHuEQig0y6vgrUJDswYpQPW0M
 326bC
X-Received: by 2002:a05:7022:eaca:b0:12d:b4e2:f566 with SMTP id
 a92af1059eb24-137d42535ebmr3120507c88.4.1780424152722; Tue, 02 Jun 2026
 11:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260601164601.71336-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260601164601.71336-1-Yongqiang.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2026 14:15:40 -0400
X-Gm-Features: AVHnY4Js9K4aT20Xr5ymLwNaG9CDr22uzYhqcJg_0M5R6b9TmlDw50sktqM2XFo
Message-ID: <CADnq5_OWaejVHxJ25tu552r4uAsF8=umOFt4ZprFhjrqebZuew@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix SMI event cross-process information leak
To: Yongqiang Sun <Yongqiang.Sun@amd.com>
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

On Mon, Jun 1, 2026 at 12:46=E2=80=AFPM Yongqiang Sun <Yongqiang.Sun@amd.co=
m> wrote:
>
> kfd_smi_ev_enabled() skips the suser privilege check when pid=3D0.
> PROCESS_START, PROCESS_END, and VMFAULT events are emitted with
> pid=3D0 while carrying another process's PID and command name, so any
> /dev/kfd user in the render group can monitor all GPU workloads.
>
> Pass the target process PID into kfd_smi_event_add() for these events
> so the existing per-client filter restricts delivery to the owning
> process or CAP_SYS_ADMIN subscribers.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_smi_events.c
> index d2bc169e84b0..fe4b93692385 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -254,8 +254,10 @@ void kfd_smi_event_update_vmfault(struct kfd_node *d=
ev, uint16_t pasid)
>         if (task_info) {
>                 /* Report VM faults from user applications, not retry fro=
m kernel */
>                 if (task_info->task.pid)
> -                       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, =
KFD_EVENT_FMT_VMFAULT(
> -                                         task_info->task.pid, task_info-=
>task.comm));
> +                       kfd_smi_event_add(task_info->tgid, dev,
> +                                         KFD_SMI_EVENT_VMFAULT,
> +                                         KFD_EVENT_FMT_VMFAULT(task_info=
->task.pid,
> +                                                               task_info=
->task.comm));
>                 amdgpu_vm_put_task_info(task_info);
>         }
>  }
> @@ -356,7 +358,7 @@ void kfd_smi_event_process(struct kfd_process_device =
*pdd, bool start)
>         task_info =3D amdgpu_vm_get_task_info_vm(avm);
>
>         if (task_info) {
> -               kfd_smi_event_add(0, pdd->dev,
> +               kfd_smi_event_add(task_info->tgid, pdd->dev,
>                                   start ? KFD_SMI_EVENT_PROCESS_START :
>                                   KFD_SMI_EVENT_PROCESS_END,
>                                   KFD_EVENT_FMT_PROCESS(task_info->task.p=
id,
> --
> 2.43.0
>
