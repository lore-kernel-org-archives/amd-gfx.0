Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28385C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 20:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2D210E8E0;
	Wed, 10 Jul 2024 20:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIcIoBVW";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56BE10E8E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:13:22 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-a77c1658c68so19967066b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720642401; x=1721247201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaZd9UrwV/RSsN0gQOqBofD958Pgr8F/2ZsWuKB22EQ=;
 b=PIcIoBVWcXIuZ26BjJ9d1TrmQIdcruoiMUs4v+n8xRchaaXuCp2v6SPVF6GxEp512n
 iaAYPzsqnW/JieNK2LS73ArWtlhuo0YcrIo+LPzZVE1vkRxSeRsoV9PjCWgNoyPhB8pW
 9G0FLn3b2L5CAxeJcFRvIIsgp7ef9kH+2sLChYt5swXZVRdVC/yr6xMa1QTPHKfDNdIF
 iHFoid0lSVfKZzn7IYW8VnhoSrWrIstbNHshaVJyOt+dzviHGzwl5K6mxAVH9k+a65Nc
 s0L6nP0O0v5tbgS5tZhXNHWWsynMGwrXMUzStg9siIKqLq0hZ7LG0zGUFmzdppoG+quI
 XOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720642401; x=1721247201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaZd9UrwV/RSsN0gQOqBofD958Pgr8F/2ZsWuKB22EQ=;
 b=EIaVZPM4yq5f/CDgBsL/TIFaGRiYjGTkSGo+3UpkFu3r2a7bMDvjLBZ/5Hr4Ugmouc
 fMjE4/ekzRa3Qogqj9NoxvnvY9kOhxs0ta2xS+gXrGdR2QpBn6QHxPFx1H/RsTKqQpZ1
 k1ZIXEwKlHQ1l3M5tgF4DFxQQjse4LDBn7HOZS+vPhz1Sn/uC1G0DZh08xz4doo1AziP
 m34BjZhMt7SEZIoMeTPTn7ebQacLxn1B4Ig8C25NYJU7+x0wiLL+Q01NrLccxa6kBcJ+
 /UjfSC5GhvVU1qjncHKuCCWOfnrxIBGHHgbzNsVeHSJjLErYo3T9jzf13laIksO6jCyQ
 K8yg==
X-Gm-Message-State: AOJu0YziEc/p0OtjCGtp1SArhTbufYyydG+NCo2e/0Xw5qj8n86mRPWZ
 oc/2Wky7JdBTd/3DLRf0XCShUQiaotdcHetx+y+9UAj63nZ6eSxZIfdVViPrTipR1SG0M29/YbV
 8m/Q/zVT+wi2KYWzlL/fc4A8xYGo=
X-Google-Smtp-Source: AGHT+IEedMyaibe+C5JYQSeZpY27ecfAT7FYDpnvCMemnbLpAnrl5xvk2toa8WE6qhuKBtHumYYvkjl4zv0ovoup4gg=
X-Received: by 2002:a17:906:1cd6:b0:a77:c364:c4f0 with SMTP id
 a640c23a62f3a-a780b70548amr375860366b.36.1720642400822; Wed, 10 Jul 2024
 13:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
 <CAAxE2A4gOcABsskv2e3Dwc_XVaXs-CmfK_D34nZgFjY3H_qY2w@mail.gmail.com>
 <90570011-55f1-4607-a4ea-dfd167f66315@amd.com>
In-Reply-To: <90570011-55f1-4607-a4ea-dfd167f66315@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 10 Jul 2024 16:12:44 -0400
Message-ID: <CAAxE2A6LTSzfyP1uKrPYOotC9+_uNU+tZPfu4EZpB+K9_XL1UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow display DCC for DCN401
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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

Can you also increase KMS_DRIVER_MINOR with a proper comment in
amdgpu_drv.c, which will be used by Mesa to tell whether display DCC
is supported on gfx12?

Thanks,
Marek

On Wed, Jul 10, 2024 at 4:05=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 7/10/24 10:49 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > This will enable display DCC for Wayland because Mesa already exposes
> > modifiers with DCC. Has it been tested?
>
> Yes, its working for most resolutions. Investigating issue with certain
> modes.
> >
> > Marek
>
> --
>
> Thanks & Regards,
> Aurabindo Pillai
