Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FFCC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C1222D58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C1222D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F7A89243;
	Mon, 25 Jan 2021 13:10:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEA289243;
 Mon, 25 Jan 2021 13:10:48 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C9EF22EBD;
 Mon, 25 Jan 2021 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611580248;
 bh=6JJ4Nm0kaHBVbitV9armeYd/HjXqVZ6g0euhuEoNPuA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=t6Ke8RvDAhHlgjg3pXQAieLR77l39DEV2VbpK/aByE5AkziwhGkizw64Z61n0+vX5
 VR679Q5z/MMLm2eq1tqx2M3Wk8IW+jZ6qv2w8VLrTfJTGv8eOq9B7KKpuYyeNGtALa
 lJr0MrH1LVc7L6H4WWR4i5VW6b7F+hGz5vGc51fd3sKEZQLqbln0iyxHNo9sb/rNnQ
 h3mYnpUgULwrwERDWT9iQkOk0psv7L4xjuzCuQxzOy0uN/zeyXDo1qKdkUaLRLw83B
 zHBrnkdsvym2oAFPD2Qj+kW/3MqSZxl4ZeYP4v9/U9r8peP34y6PHNsmayxeAqQOf+
 Ia2WjrXJ/dFjg==
Received: by mail-ot1-f44.google.com with SMTP id s2so10455816otp.5;
 Mon, 25 Jan 2021 05:10:48 -0800 (PST)
X-Gm-Message-State: AOAM5315DpK7FpqdtuyDMFDjYJejiP+9T1UyG6AWvgp2T2tgKV3vUFET
 QJCKC20BHu7Rrh59oNSiEsLqOtT2R/E9BGrcdzU=
X-Google-Smtp-Source: ABdhPJwnN84NqKdW3l2u+qaTx2r0WtE4eDaZO+Bzs3/LR9lqmjVYXpjT3MmQyzJh8+M38iiBKhDDF6FVaomIwqf97UA=
X-Received: by 2002:a05:6830:139a:: with SMTP id
 d26mr376081otq.305.1611580247723; 
 Mon, 25 Jan 2021 05:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20210125114012.2480845-1-arnd@kernel.org>
 <CY4PR12MB1287B8B020D280A5F12ED62DF1BD9@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287B8B020D280A5F12ED62DF1BD9@CY4PR12MB1287.namprd12.prod.outlook.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 25 Jan 2021 14:10:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a06+7sC8yWEFb1D_Op=76RR2OqY7j4s11h3sos-SJ=v6Q@mail.gmail.com>
Message-ID: <CAK8P3a06+7sC8yWEFb1D_Op=76RR2OqY7j4s11h3sos-SJ=v6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use div_s64() for 64-bit division
To: "Chen, Guchun" <Guchun.Chen@amd.com>
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
Cc: "Aberback, Joshua" <Joshua.Aberback@amd.com>, "Chalmers,
 Wesley" <Wesley.Chalmers@amd.com>, Arnd Bergmann <arnd@arndb.de>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, David Airlie <airlied@linux.ie>,
 Jacky Liao <ziyu.liao@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Leung, Martin" <Martin.Leung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 25, 2021 at 1:51 PM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> [AMD Public Use]
>
> Hi Arnd Bergmann,
>
> Thanks for your patch. This link error during compile has been fixed by below commit and been submitted to drm-next branch already.
>
> 5da047444e82 drm/amd/display: fix 64-bit division issue on 32-bit OS

Ok, thanks. I assume this will make it into linux-next in the coming days then.

     Arnd
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
