Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDCBC05027
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 14:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801D410E49D;
	Mon, 23 Jan 2023 14:09:39 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5427B10E49D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 14:09:37 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 x21-20020a056830245500b006865ccca77aso7368268otr.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VeuBZyNeTGyU/wqW/UfJ6LFekK3d5sFwETjIwj7Rbdw=;
 b=bjeT9OMfgYD7Gw5IAjFjxeYBt730OlUBTLW19g4d2jNARM3z/uXanQCKkbmuSJbObd
 3vZGW+XkHQASMaA5696iKebUEMNsxgl83WelE4NIgw5oqpWj9yUCqoK0BjXWOLXtUAdD
 XxRMMnzBl2ky0+tQzHZHiC8QkbN1rcHSpCwHIRVUfKOJAF0T7iDQgRd5ZNQcRB7hGI9t
 jP6HQZ8rf5eVPjA/rsb34Yrv9baudH5oSSy6M3X0rs00jWTIVuB2coE3STazLz0KXJJR
 B85+ppLqkgGP3F6gamCKxTHoQH6MSho7CFc4UVoRf0Ijrv3fLnpzZrrlPfJyNnLWdHwY
 oNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VeuBZyNeTGyU/wqW/UfJ6LFekK3d5sFwETjIwj7Rbdw=;
 b=CnuawYNlNEas78/8dg6qVY9n58s19NL3hiqWf5Ri/zv2aX9Z2WSXqGOLjVTWTJ24fD
 impIM3txDhTBD+aUdGsy636bG7eCq6qt82BrIjdX1534n3YZ19i9eYyQmiY+cF04G/Qs
 3Ax+Abk/UPLhdgxUajVMfJsLsqaekrM2sYH/IxKTj2WLleXpGA5aIMkUYpt2nfmIDf9Y
 gD6sqPVW+4585gGzVoVMSFtVqI2h0RpOeG3h4tHeKqskgrqUfYzUx+gNNgTAuLeLHGjn
 x8I6nRX+EmCl/7adHAA/7hjkMjj58GUQXIj8GAnZWxRdzZq44Y9W/C46JRceJlOGFvDj
 /Ylw==
X-Gm-Message-State: AFqh2kp7ZiNkGRUATC14s+N0fP2c3rAfFGYMS6mlxTUKs69mfb5fSk68
 8GM+2ORWTxuWszkodhvvZmNktSGylzIT05IuQa0=
X-Google-Smtp-Source: AMrXdXsQ+6X9JnD8dif1GGpn1WDTAIy9sfmwswYlWZYrYqTwO4GU9oVPjGUK7qBvDhoe4rN8OukCg2VJJmUKozIU3u4=
X-Received: by 2002:a05:6830:26d9:b0:686:9219:3704 with SMTP id
 m25-20020a05683026d900b0068692193704mr848990otu.123.1674482976437; Mon, 23
 Jan 2023 06:09:36 -0800 (PST)
MIME-Version: 1.0
References: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
In-Reply-To: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Jan 2023 09:09:24 -0500
Message-ID: <CADnq5_N8AH+Ay8V1oqX4FptDKM6Uz=6a22JOr47Jw98VeJqRBA@mail.gmail.com>
Subject: Re: Minimal kernel version for 7900XT
To: =?UTF-8?B?R29yYW4gTWVracSH?= <meka@tilda.center>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 23, 2023 at 5:11 AM Goran Meki=C4=87 <meka@tilda.center> wrote:
>
> Hello,
>
> I'm trying to figure out what's the minimal kernel version that supports
> the 7900XT. I found that the driver supports SLES 15:
> https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-series/amd-rad=
eon-rx-7900-series/amd-radeon-rx-7900xt
>
> I also found that SLES 15 SP 4 runs on 5.14:
> https://www.suse.com/support/kb/doc/?id=3D000019587#SLE15SP4

Kernel 6.0 or newer.

>
> The problem I have is that I can't find PCI ID (for my card it's 744c)
> in the list:
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/=
amdgpu_drv.c#L1654
>
> Can you help me understand how this card works with Linux without PCI ID
> anywhere mentioned in the code, please? Thank you!


The driver binds to all 0x1002 vendor ID display class devices.  Once
loaded, the driver parses a data table on the device to enumerate all
of the engines on the GPU.  If they are all supported, the driver
loads.

Alex
