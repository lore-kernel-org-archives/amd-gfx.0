Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23338C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 07:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB66112906;
	Wed, 24 Aug 2022 07:32:50 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2459110E0ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 17:04:16 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 a1-20020a4ab101000000b0044acf001f83so2525359ooo.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=TUg/MW+5uwqkPY+MLc70krjM60VBeEeGCfnySwldiwg=;
 b=Yy1D2HftO+eOzV0Ic0suR8nmcNMTHLyik3FZY7MaTj4OFyv37SMhw+ej0wDA23ngLK
 CwPEql8zfjyGvUi1VFcpICjJgqQarDgcFZR9hRz3/yVobuA7vkCOixudjUYpUjO9hnyc
 VKoQIrnb47IwnDpZQRCOJ1H9GsWAFI62J/s+A9N+K7W4VLtyIV/px6P4JE1a83SnvVcY
 /MmLgVj3fmUHPZnUiV3DQgvCSIAWGOWJ7gSZJ4CidRmYHVPEjauK54QtR5J0fE18VFKt
 MBigCSfySQ4qcEKE9R4EMOLNaN2pbepP4uwpqVN+hsX+v6ihxoD3KNc5HX3dgdLm+Ko9
 XKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=TUg/MW+5uwqkPY+MLc70krjM60VBeEeGCfnySwldiwg=;
 b=uzTEACfVrLJQQ4dvvcL3+1DEFzY3EGoQHrSD15jiRkvKgiA2QICBCK/F85/Us1RR9l
 IdpuacTubGshvZ96HcInXsVDNdiOBf1l3VYeKqfXkI9tSaovSfC4AA4R5Wi9OTDnuG/u
 R9DwOv1JIMXRtt38xHAWmSKgm4UyHQ5JidoGk+PR3KmwUvP9brmC5jt57gLIwvrfnBBZ
 dUX6vhxOSPKj71Qa8L4YqFdxocdorXgpFMXwU6AIrhg+dsY9oWEhvIEdzUqX4P+L3bLV
 71tjR1jmuLEM/SUcab9IYn97wXVOuI62HAlszkY0ag+64dbXvm4wNpFHqHYmQAaIgKxK
 juCg==
X-Gm-Message-State: ACgBeo2QPuMbxO3u2Ye6rYcER9J2rC3eMpnIbYOnGttk4dPSeFIoYe2/
 wj7bw9bTNHyIBRBa3w/Kg/5ScvpEhT83HG9VbPM=
X-Google-Smtp-Source: AA6agR6XgQsau2DY6uzmKYWsDA7bVUlGQKf7jxT6ApzcWlbpOaCrokpE4iUclQ4NqT06TmpMl49uQQYc0O0JgDYZNgg=
X-Received: by 2002:a4a:b607:0:b0:44a:f4e7:4808 with SMTP id
 z7-20020a4ab607000000b0044af4e74808mr8239529oon.37.1661274255415; Tue, 23 Aug
 2022 10:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190725.GA2499154@bhelgaas>
 <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
In-Reply-To: <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
From: Tom Seewald <tseewald@gmail.com>
Date: Tue, 23 Aug 2022 12:04:04 -0500
Message-ID: <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 24 Aug 2022 07:32:23 +0000
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
Cc: regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Aug 20, 2022 at 2:53 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
> Missed the remap part, the offset is here -
>
> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nv.c#L680
>
>
> The trace is coming from *_flush_hdp.
>
> You may also check if *_remap_hdp_registers() is getting called. It is
> done in nbio_vx_y files, most likely this one for your device -
> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c#L68
>
> Thanks,
> Lijo

Hi Lijo,

I would be happy to test any patches that you think would shed some
light on this.
