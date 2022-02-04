Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09B1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C376810E9E0;
	Fri,  4 Feb 2022 19:27:45 +0000 (UTC)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7141B10E130
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:18:45 +0000 (UTC)
Received: by mail-io1-xd34.google.com with SMTP id r144so8375138iod.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B0ahm0hdwmzp8LcfxQ8+kQ7YphowIvmbdFdhXbcRawU=;
 b=YuuKVwxWhqjqDGM91SbOGfO5jk1lvcH2xOKu9SdTS/0AtcSSu6Z74v9BI75XsPuQNQ
 6voOghPWwZ0DFtuWnIayytbcUYvQLdpxYUw/+iekyW/DRrXWz5L3T9qUdSP4JAL0wOB2
 AAuLy72nClt9QPT6wEIYZ/WM76WScoUHkqOnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B0ahm0hdwmzp8LcfxQ8+kQ7YphowIvmbdFdhXbcRawU=;
 b=kfcTdE+LSWUXrLq5mvyILY65u0FVcf4jKuGwFtWr9ZDezYA7/vipmUIbcga439ZgDA
 F0CKIqHzTYgOvN/opqxYZMYFoDHyykWGDcMnJwlyhtBQF/CsOLtZHO9bcIMpTFdcex0y
 6v3uitett5JJtvJpMjAnExMmnd4m0JaY8nd05lcqbvbp6oncG1SgbEN5I0jVx7jyxz/b
 BsZ5v9XUnn4TqGxTqcfGF44H7AF4Odg3ZPO9oD6dhdaqBE/yReboVeoRtoHfNDEJTOld
 yvRMl2bgYHl6srrhOpUGxINtg3fTJG6ku3v7i14yfVC03NzzsnpQAT6+TS4fz1g/WKhY
 YyNA==
X-Gm-Message-State: AOAM531VkjuqtX7znQxiwLE44dqENM43OnpmBqL/CwUX64rNznCpuCdS
 WK2Sq5NhCinIHaoKQL0KHPk51PVdQn0BGkCMIKPYhA==
X-Google-Smtp-Source: ABdhPJytny1SyvPfpAVIt5yuyPMy85jb9OFiLTaA6qhpI02J9cXH4cGVPLFMJsAR4d38qn7L7cix9j7++UZ9EJEbmaw=
X-Received: by 2002:a6b:f218:: with SMTP id q24mr174468ioh.55.1643998724641;
 Fri, 04 Feb 2022 10:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
 <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
 <6121a782-6927-f033-1c09-ffe4ad7700ae@yahoo.com>
 <CAJMQK-j5YYqen78Vgng_5jhja-YKSTRut7f7vJ4wWufVfbZy6w@mail.gmail.com>
 <363432688.323955.1642272250312@mail.yahoo.com>
In-Reply-To: <363432688.323955.1642272250312@mail.yahoo.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Sat, 5 Feb 2022 02:18:18 +0800
Message-ID: <CAJMQK-jx+z974AT_p+-AVAbMQQ33V-XU9NKmy-i6nbS5zagHBA@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
To: "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 04 Feb 2022 19:27:42 +0000
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Wolfram Sang <wsa@kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jan 16, 2022 at 2:44 AM Tareque Md.Hanif
<tarequemd.hanif@yahoo.com> wrote:
>
> Hi Hsin-Yi,
>
> The issue still exists. I reverted a19f75de73c220b4496d2aefb7a605dd032f7c01 (the commit that reverted 5a7b95fb993ec399c8a685552aa6a8fc995c40bd) and manually applied the patch (tags/v5.16). journalctl attached.

hi Tareque,

Can you apply the same setting[1] again and with this patch to see if
the issue is still there?
https://github.com/torvalds/linux/commit/6dc8265f9803ccb7e5da804e01601f0c14f270e0

[1] reverted a19f75de73c220b4496d2aefb7a605dd032f7c01 (the commit that
reverted 5a7b95fb993ec399c8a685552aa6a8fc995c40bd) and manually
applied the patch (tags/v5.16)

Thanks
>
> Regards,
>
> Tareque
>
> On Saturday, January 15, 2022, 11:27:07 PM GMT+6, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
>
> hi Tareque,
>
>
> On Fri, Jan 14, 2022 at 6:09 PM Tareque Md Hanif
> <tarequemd.hanif@yahoo.com> wrote:
> >
> > Hi Hsin-Yi,
> >
> > On 1/12/22 16:58, Hsin-Yi Wang wrote:
> >
> > Can you help provide logs if we apply
> > 5a7b95fb993ec399c8a685552aa6a8fc995c40bd but revert
> > 8d35a2596164c1c9d34d4656fd42b445cd1e247f?
> >
> > Issue still exists. journalctl log attached in revert_8d.txt
> >
> >
> > > after apply 5a7b95fb993ec399c8a685552aa6a8fc995c40bd
> > > 1. delete SET_LATE_SYSTEM_SLEEP_PM_OPS(i2c_suspend_late,
> > > i2c_resume_early) and function i2c_suspend_late() and
> > > i2c_resume_early().
> >
> > No issues. journalctl log attached in test1.txt
> >
> >
> > > 2. delete SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume,
> > > NULL) and function i2c_runtime_suspend() and i2c_runtime_resume().
> >
> > Issue exists. journalctl log attached in test2.txt
>
>
> Thanks for the testing.
> Can you help us test if applying the following patch on top of
> 5a7b95fb993ec399c8a685552aa6a8fc995c40bd works? Thanks
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 9eb4009cb250..6b046012aa08 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -484,7 +484,7 @@ static int i2c_resume_early(struct device *dev)
>         struct i2c_client *client = i2c_verify_client(dev);
>         int err;
>
> -      if (!client)
> +      if (!client || dev_pm_skip_resume(dev))
>                 return 0;
>
>         if (pm_runtime_status_suspended(&client->dev) &&
> @@ -502,7 +502,7 @@ static int i2c_suspend_late(struct device *dev)
>         struct i2c_client *client = i2c_verify_client(dev);
>         int err;
>
> -      if (!client)
> +      if (!client || dev_pm_skip_suspend(dev))
>                 return 0;
>
>         err = pm_generic_suspend_late(&client->dev);
>
