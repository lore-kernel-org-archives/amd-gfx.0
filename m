Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E2AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Dec 2022 16:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBFB10E3FA;
	Thu, 29 Dec 2022 16:42:49 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D8A10E3FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 16:42:47 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 m7-20020a9d73c7000000b00683e2f36c18so6719693otk.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XIvm70LkQ0CoIBJttPmIJN6T0aTQeFPqoab/sv2/Y/Q=;
 b=RpbCVwWkg6y2HFXbLkdAMBEjzk1nGRpiL3JNiid7F86P98QOUxAExYfy5Nt3XXW8Qj
 QhxSYdgLBA6u3ddxnLXHT3Npm+mw6TDGiL8FVK5WU07CTtpGLIsYzY8UuX3E/thZBoxT
 XmbhBwROvAj3ti7Y56c+9CnVye/Zc0iWb91udaRj0dtV18cXzKNsW9c0ULtyPTF3QCgN
 6kX84x+AzKfM51A5t9UPjOmmJCBDLQdwfFzuMZCuLickpcd5RB1hCdgXN3bWUZIWQi3K
 hRN7dlTa4bNW3ZSGKL6LyEia7+coFika2MDDUj5KaNrjrPfIMioZ+57XIkwEgg/z7FY6
 g80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XIvm70LkQ0CoIBJttPmIJN6T0aTQeFPqoab/sv2/Y/Q=;
 b=PcRSSc1zUrjyKldusbrAsBbvWWK7kXXgOZbXNZ4fPWFfN/ZTeLt8RaTtlQzpU64dLp
 nU02x4sBUaDBV1j8HmypVMR5WZe3rllCV37KF6nBxr6HY/UmKGvHB30+ItBe2KULpRhq
 q9bpdqqCBGgdAA6MPIVO+NOaiWHjbjUflqQthk04FoLkWoa0ePf5JBk56+QXbFt1osd5
 Qj0RpMXxDi8L54/AQ/ZJIuGgh8sIpIKMX4LMZvU4+hnCcrFPYjldiPx40VipI/H+cWnk
 /PB1tHhXrmwpfHAoXaDsXRElnW5tUOMtgBPgYIiHRYgpU01b1lzPLYGT1Lg9ur7KgkpT
 UDsA==
X-Gm-Message-State: AFqh2kqb9YoTzBfU+lEHr1TTH2xUTwBeM0MKBpO1JlYijzdcD/PRBPIS
 Dv+wGqSk2rssTYFQBqu9rjmBqRUFC9+D8IAYZFU=
X-Google-Smtp-Source: AMrXdXtBCmcxjk+Vd0518fLYPGkHLDRkfku4pPSrg7+B3ww44bFQhxGhRTH25O0a6nz9t5OpFouimGJA/o8GyL1o848=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr1850314otq.233.1672332167193; Thu, 29
 Dec 2022 08:42:47 -0800 (PST)
MIME-Version: 1.0
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
 <20221228192740.1ec44a3d@localhost>
In-Reply-To: <20221228192740.1ec44a3d@localhost>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Dec 2022 11:42:35 -0500
Message-ID: <CADnq5_OXLuhSJwN-bKg47YjurUze6wj0kZhzsqszfV93uzok_w@mail.gmail.com>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
To: Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Aditya Garg <gargaditya08@live.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 28, 2022 at 5:47 PM Orlando Chamberlain
<redecorating@protonmail.com> wrote:
>
> On Mon, 26 Dec 2022 21:44:06 +1100
> "Aditya Garg" <gargaditya08@live.com> wrote:
>
> > The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in
> > MacBook Pro 16 inch, 2019 (MacBookPro16,4).
> >
> > The GPU fails to work on Linux, thus a blank black screen gets
> > displayed on boot.
> >
> > If nomodeset is added as a kernel parameter, we are able to access
> > Linux easily.
> >
> > The link below contains the journalctl of the failed boot :-
> > https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7
> >
> > Thanks
> > Aditya
>
> I'm not sure if it was an unrelated issue, but on older versions
> including 5.17.1, psp_v11_0_bootloader_load_sysdrv would timeout and
> return -ETIME. I'm not sure when it started having Mode Validation
> Warnings instead, but these errors are what it previously had:
>
> [    5.136077] [drm:psp_hw_start [amdgpu]] *ERROR* PSP load sys drv failed!
> [    5.136233] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading failed
> [    5.136351] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of IP block <psp> failed -22
> [    5.136458] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
> [    5.136477] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
> [    5.136540] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
> [    5.137815] amdgpu: probe of 0000:03:00.0 failed with error -22


It's not likely that the two are related.

>
> The patch used to test this and the kernel log I received from someone
> using that patch are on this page:
> https://gist.github.com/Redecorating/645a62eec4fb06e03f384396f483fa37

What was this patch for?

Alex
