Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A9C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 12:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DD310E0F2;
	Fri, 29 Jul 2022 12:37:59 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE92410E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 12:37:55 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id z23so8293619eju.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Fu8dlxwrYBW72hvBK9lkKWvr0IanIkt+rVNekPgtNlo=;
 b=mOfeiFJ6kk8OPtSkMEeuD+KMxSypWebMqYLG69Aa5mqdnTy6Wr0px6e+RF8gNfO+Mh
 Vg1JcCbE4RswBcU6FywP4Xu0HU1eRxDbxvNmvlbgnr6JlTR6nFG7o9O3coXIZZqXbjCA
 7Eh1TQm18TbiveKFdk3QVA2VAAsg8kNADcS0lZ7KsdOWVyZLk0gTVjoya0FrdQ/hgYTT
 nasAGafDxre4xsgU6UuxdTFUQWeZeL2XheDLpZotbD81BznvW+hYcKCg58nZQN1vFHHp
 MMyvuTHkrtVtMEWETWM1ADKbCvV7K2G8nmY7njU6rHUtRL3kw4i+sSxKfPgdHD8wJaKS
 Bw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Fu8dlxwrYBW72hvBK9lkKWvr0IanIkt+rVNekPgtNlo=;
 b=XQzy3/gmukRbsSeBcmZD3MBcdaKSThMt5/GWXWriv8Vk6YclDPivAWTY29aJxwnosF
 Dhdmm2LnkKOIwaLw4YZ2r0CmXUrFtSJ2LsyIMmagBoiJU+OQGMrHv9SW8pSLhH9h54C5
 XCqfFmiQSZOT1Y7pon5I0pQNBrtDxXsfC5m/Ro5uCI5qKBG1ghwVkIACf2ZDvu9I/gSn
 H0cpU+zAjeGwW6wMtvTTAsrNY9LaiMJG5OslyBj3z/fggMd6zSp5l1Nauc2ex+SjOcyp
 BJmwCZegJpe+zN+LlBDpDccvvmNkb8RifKhw5jbP1UlgDK+QqKklMY2C4PTicuQz/+nE
 aNAw==
X-Gm-Message-State: AJIora8ag3nk9VQJOUQujEBchzVABfmDhtNMQfSryqrsreleB4qzSfA9
 tMDF14ScY8wLXdGfaTU6cT3fyivR61J9TkkCYB58Cg==
X-Google-Smtp-Source: AGRyM1uSProj6DPU7YVk7zJCGNhilPhw7rRSFkEa2hX/os/wiHxyYM+alQLS3IJDEW8iO7TdwzlLS7ZcQY/nWYOrzpQ=
X-Received: by 2002:a17:907:6087:b0:72f:36ff:7fa2 with SMTP id
 ht7-20020a170907608700b0072f36ff7fa2mr2786682ejc.162.1659098274111; Fri, 29
 Jul 2022 05:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1o+57sPVgPyFoQMkAyqzOko6Td8O-f-6eP_qLn0DkYs3A@mail.gmail.com>
In-Reply-To: <CAEzXK1o+57sPVgPyFoQMkAyqzOko6Td8O-f-6eP_qLn0DkYs3A@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Fri, 29 Jul 2022 13:37:42 +0100
Message-ID: <CAHbf0-EHB+0e5D5cs1Br1_zhozJMhcNN3+eYfxUhk18LNgb48g@mail.gmail.com>
Subject: Re: Please consider Open-source OpenCL support in amdgpu/mesa
To: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I've recently gotten ROCm 5.1.3 working on Gentoo with the open
drivers and using upstream llvm 14.0.6, it's enough to get LuxMark 3
running (well with fast math disabled)

You might want to look for a distro that packages ROCm for you as
Clover is nowhere near ready

On Fri, 29 Jul 2022 at 11:06, Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> wr=
ote:
>
> Hi,
>
> I am an Aparapi project developer that has been struggling for two
> years to get an RX 5700 properly running OpenCL applications.
>
> First of all, as an end consumer, I would like to congratulate the
> open-source amdgpu driver for its stability and performance, as well
> as the team behind it! Unfortunately I cannot say the same for the
> closed source, proprietary drivers which have been a nightmare in
> terms of quality and stability and currently the only way to have
> OpenCL... which in reality is not the case, because it does not have
> any stability.
>
> The open-source driver has been superior in terms of OpenGL and Vulkan
> stability and performance, it just misses OpenCL to be complete.
>
> I am not expecting any reply on this, nor that it will make the
> Open-source OpenCL support for AMD graphics cards a reality... I just
> want to share this reality that I am experiencing for two years, with
> many amdgpu-pro driver versions tested and also the new deb based
> amdgpu-install drivers. None of them provided a working solution,
> neither legacy based, nor rocr based ones. The machine starts running
> a few OpenCL jobs, which after a few seconds lead to a black screen,
> followed by GPU reset and machine hanging. The same OpenCL jobs run
> fine on a GT 1030. There is also a big issue when running the RX 5700
> as a secondary GPU, aside with the GT 1030 as the primary card, which
> causes the amdgpu driver to fail to load and renders the RX 5700
> unusable. I just wanted to share my experience with this card and hope
> for a better future.
>
> Please consider Open-source OpenCL support in amdgpu/mesa.
>
> Best regards,
> Lu=C3=ADs Mendes
