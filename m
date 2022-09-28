Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5151FC6FA86
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46C010E95C;
	Wed, 28 Sep 2022 19:32:19 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAA610E95C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:32:17 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 r34-20020a05683044a200b0065a12392fd7so8810330otv.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=jAEyYayZvFyVB0pae1Ib/d7zzuh3o0gH/z0RdN1Z4rs=;
 b=YfVXx8NoAGe3iseEbBxJEsdRh/QQDeApSNA3UkTmDX+Ps9ic6b10xu5nSbo/Nd/0Y4
 l2NSFSNsp4oj8R2AnYnwqhquTjD/7jP88CtmQyDGJtnrRdq2oqy6RuM4BJllG1Cxce6E
 OmwuNf3fPx+us3+1BTG3xd2yt/ua5VSnMelZoV62C/EDKd5Q60a0oY/vneWR0pYvsKab
 bwclPTbG8ixeRov9DOHDtEe6NdqN/+HZ6Q9HIJ62PRnGxvfvnZIPQBrg6Ake505QTAc9
 uAI7oBM7e+APCAHvU4faeKsU7Rr0wIkbZcUXoA6ai7R+zfKc6jSxB4bK2bQ5RCkCaaIi
 ATpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=jAEyYayZvFyVB0pae1Ib/d7zzuh3o0gH/z0RdN1Z4rs=;
 b=VkY7KRAwhs6hf0D8Y6pfBP2EWS5m2URblxfpzY75Kw+xK+m+8gZk6ZCk0AnTd2/vOa
 0cXdlYvTudHuF23KcAi/yEAJdNX39r+GwRvHMO8mn6SSBP2wdmDJ/J5uJQdvsGoxjoZ6
 YwQ4sL5i4Vp1TnKPof9V6whyPNoMVJauw97qMpK5E4p/TNvg5FqGcPVWN4itvCT0bo8x
 W9xhqKQWI3EfwUN+4/d7bMoZee2S6IZQSEzQKTVycnWTajam4Sx0BKny/6mWvSSPLZz+
 ILGi8j2xpvmf5xsnpt6HH4Tpz/B3duEDBfiMoFyy/P5BNiXV6n6ZaguC/JIdfffgCD0R
 ubRg==
X-Gm-Message-State: ACrzQf3AxIADAwzQ87BvoPQgGCIhsJjjFVpBRo6dxKe4Iic6HHU+O3Wj
 ZIJOTBrz1acSrGxlpO/hnUvU75tPiyCgoArOahkUlDKZ738=
X-Google-Smtp-Source: AMsMyM4VpHBe/3BuRDfp8GC0mtHbWxfOGKTpIhv1N5ixas58vWr0IIySrwPPB+rubtk03sIMK2KpqsCsBBN+DMAURjA=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr15450763otv.233.1664393537118; Wed, 28
 Sep 2022 12:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
 <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
 <8a383215-4a8a-243c-6cef-6e7fc12af001@collabora.com>
 <BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2da3a6aa-8f3e-a640-d351-c923c8c924e5@collabora.com>
 <b5fcab24-5c6c-d585-261b-2b202283eba0@collabora.com>
In-Reply-To: <b5fcab24-5c6c-d585-261b-2b202283eba0@collabora.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Sep 2022 15:32:05 -0400
Message-ID: <CADnq5_MMD-7rF0K9abMrj-y-DWbMZOuvYT6U5bSV3=w3yd43Qw@mail.gmail.com>
Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 28, 2022 at 3:24 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 9/28/22 20:47, Dmitry Osipenko wrote:
> > On 9/28/22 20:44, Deucher, Alexander wrote:
> >> [AMD Official Use Only - General]
> >>
> >> This should be fixed in a backwards compatible way with this patch:
> >> https://patchwork.freedesktop.org/patch/504869/
> >
> > Good to know that it's already addressed, thank you very much for the
> > quick reply.
>
> Unfortunately, that patch doesn't help beige goby. Please fix.

https://patchwork.freedesktop.org/patch/505248/

Alex

>
> --
> Best regards,
> Dmitry
>
