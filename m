Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7543DC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4958220872
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h84l+iyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4958220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128616E51B;
	Fri, 28 Aug 2020 19:32:08 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73836E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:32:06 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a5so184036wrm.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g5EMO82EaySZFlpzwo6lyGj/b+q5s7sGQdndg4a+Xlw=;
 b=h84l+iylVZtaSwU31mamWQVDItWVZsQQ3cEb4X/TKs9K5Zst3fp2BQ8Tv/T83bnYr7
 o7377OuD1us/KFikz9bJj/vdNT8UKA7OV6qV5ujNO7RH4yKP8SW7OB6l1rntaoWJ8bDQ
 +KZfXs58n0S/6aP5KMpqyonRs6y7rm2BIOLQczxUSJYfkTE1/WEIiW3QBInUfeIX9dY9
 swsYQycKS2Up96ItHjkbKt2MTYF3CyN6SRWMTt7fZOaYJaFNSR5Rsux0puX0R0VQv+ct
 9ru3ZS4t+iNuHb8CF++wdiHMaiYGpLaOfy+fa8v2S+HcprziF4qg77WGGf+cZUrL3B+n
 jhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g5EMO82EaySZFlpzwo6lyGj/b+q5s7sGQdndg4a+Xlw=;
 b=Ip7R5Y8RG+F2P/+QtobkmnnGnLtL9C+q9T5aLiavv0FzaAoCieMPWlddMbMbP6OyTY
 iw87pbq68XnwK78v+DJhncF009ePUzPl/91jziSu01LDUzzWdLxTprYRaWsGvWuoSlvz
 jMqv9FMCo6nDGVwL58FR5mz/YKB2QsLkRDHAqzqj83T3V9epreP7AS2ySzyMI3ZCK5J9
 XH4yiid9IEiSVnIeXHiWtd+n5W0Rn2teTNjgdbfvcCR0oRhdxMhXgKrv3WOZdRgiwT+5
 Il9XhRZTXhNFVrhQawpZ722w4f7s3KCXxshzj90Pr6bKAVmtz9abU75RdY0beaQsUZsP
 IjNQ==
X-Gm-Message-State: AOAM533h3MpP9bOy5PETljkpMW8Wl1KZJpF8WpO11uiZynZwUNVIBHEY
 AjtGH1gN/iB4rlQQZowlImTZ89rhqCpoHPcqCHaCufJSGEY=
X-Google-Smtp-Source: ABdhPJyXOkyx1kCwLrXIygmYTt/PZBXE18DYKfBudzta3jEBR5d6pOqGvZ0MGfo9rNeo+mNrfBgyBLZjwwGtLOdRiT0=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr431757wrs.419.1598643125679; 
 Fri, 28 Aug 2020 12:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-8-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MCXDfGNz0FpHZfJ6G8a4eqDQDeSghBFNfCoL8aAP934Q@mail.gmail.com>
In-Reply-To: <CADnq5_MCXDfGNz0FpHZfJ6G8a4eqDQDeSghBFNfCoL8aAP934Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:31:54 -0400
Message-ID: <CADnq5_O9L8y2-RVy8f53NtEM7uxvQ4cMqOXo1X9BwKKzh25xuQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm/amdgpu: Disable DPC for XGMI for now.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 3:30 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
> >
> > XGMI support is more complicated then single device support as
> > questions synchronization between the device recovering from
> > PCI error and other memebers of the hive is required.

Typo: "members"
With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> > Leaving this for next round.
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 429167b..47e16baf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4782,6 +4782,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
> >
> >         DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
> >
> > +       if (adev->gmc.xgmi.num_physical_nodes > 1) {
> > +               DRM_WARN("No support for XGMI hive yet...");
> > +               return PCI_ERS_RESULT_DISCONNECT;
> > +       }
> > +
> >         switch (state) {
> >         case pci_channel_io_normal:
> >                 return PCI_ERS_RESULT_CAN_RECOVER;
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
