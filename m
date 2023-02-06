Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9249AC636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30DD110E421;
	Mon,  6 Feb 2023 16:12:05 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170B110E421
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:12:04 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-16a27344a17so6307889fac.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 08:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxWs8SEFiXaVrXHlZ00pk8naTEHijmtK9QxFkoxeIWw=;
 b=dwuf31Ed10r+u5tNFAlu5lATLBAw1HkyOxsN5UsQaXc34TNhZ1CEx0CSBGbMx1AvX0
 kAbtmNVMUkVQeqyVDMGv69dESd/GNUVsJ4NE7UXjOMaqOANuuuqEcojNNZfrI2s4AzQg
 vh9PnjC8zkSboNQITRhCIgTWpJBVfSZ1yJMIoes3eS9PdWZRllu5OEMfqgYDrozQvz//
 pbFM0V0bFCwURjKw/YWe1tRm2MfHDhF+Lfj3UkFm+d1ybzoAeHHcQw6Z77/6NTyrKFfz
 KKLEB+MaRsLounIArC5Imgfqgmd9ptGTv6F3vrTJx8/bheiA+tpQymYDP40uxMeQyC4w
 yORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxWs8SEFiXaVrXHlZ00pk8naTEHijmtK9QxFkoxeIWw=;
 b=A8Jk9VvZAHQg8KeAAjvgJFYgigyDK6TRqwSpnOTjyFQ5xLeTKmmZeDRnB8ilqYKfdW
 q9+//cC7P3alQINCYRZ5pskNa2hO2ICMJhRjD9ocmO9shcnFRTc/ezX83J0rPc2zfvNc
 x640oCTdvd2mbZq7wErTXXk4i6amxDsMkCwXoGWzXmwdiNYR8xVnyV7aWWOdIuT8DCR1
 W5gK4jgwF9jm2NgTz9f5wy7M4WVLvdxgo0XCn0vndFff5e2hCJICitEKKpgx4wwwVDUc
 9xtPkSlK2C8AjccPSBZ+TH8lv3HCl37jtn01q2GT2FGy7KghauYC4ZStUmusZQY2oFG5
 3BRA==
X-Gm-Message-State: AO0yUKWKY/G6xA5LJ1zZQg5CA+sUWvys4fCUQUxM9CeTnab1ujy6audI
 T5nrASK1etqjTrvUGWEL/0tUPPv4iNHhpFKOKG4=
X-Google-Smtp-Source: AK7set8URa8Hu/7Q0UUgJsHMOQgA6IztZC4IVgl4b0rt+t4ob+BfmUZqOt9blE6MDGb3xoidr01jrcine+TPO435H/s=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr30252oab.96.1675699923166; Mon, 06 Feb
 2023 08:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <1de90d3d-e1de-1540-6e28-1caa245bc474@mailbox.org>
In-Reply-To: <1de90d3d-e1de-1540-6e28-1caa245bc474@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 11:11:51 -0500
Message-ID: <CADnq5_OLbBDQqOJE=Sh6MAAu59G17FHyy6vbjmyVbaujNQYaEA@mail.gmail.com>
Subject: Re: [PATCH 0/8] AMDGPU usermode queues
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 10:39 AM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 2/3/23 22:54, Shashank Sharma wrote:
> > From: Shashank Sharma <contactshashanksharma@gmail.com>
> >
> > This patch series introduces AMDGPU usermode graphics queues.
> > User queues is a method of GPU workload submission into the graphics
> > hardware without any interaction with kernel/DRM schedulers. In this
> > method, a userspace graphics application can create its own workqueue
> > and submit it directly in the GPU HW.
> >
> > The general idea of how this is supposed to work:
> > - The application creates the following GPU objetcs:
> >   - A queue object to hold the workload packets.
> >   - A read pointer object.
> >   - A write pointer object.
> >   - A doorbell page.
> > - Kernel picks any 32-bit offset in the doorbell page for this queue.
> > - The application uses the usermode_queue_create IOCTL introduced in
> >   this patch, by passing the the GPU addresses of these objects (read
> >   ptr, write ptr, queue base address and doorbell address)
> > - The kernel creates the queue and maps it in the HW.
> > - The application can start submitting the data in the queue as soon as
> >   the kernel IOCTL returns.
> > - Once the data is filled in the queue, the app must write the number o=
f
> >   dwords in the doorbell offset, and the GPU will start fetching the da=
ta.
> >
> > libDRM changes for this series and a sample DRM test program can be fou=
nd
> > in the MESA merge request here:
> > https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>
> I hope everyone's clear these libdrm_amdgpu changes won't be sufficient u=
API validation to allow the kernel bits to be merged upstream.

Right, this is just what we have been using to bring up the feature so far.

Alex

>
> This will require an implementation in the Mesa radeonsi / RADV driver, i=
deally with working implicit synchronization for BOs shared via dma-buf.
>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
>
