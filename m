Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F53CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 08:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C30F10E423;
	Mon, 17 Jan 2022 08:48:57 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBF610E366
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jan 2022 17:27:07 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id z19so10605554ioj.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jan 2022 09:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mu52mCpV2nrQW+DvvGvGXwkA9rgLAwESwOW831oZMnE=;
 b=d3c2rEAUTq64Y+w6197B+rfX3aaLSZ92yWel7tJ5VZaQnn0VPZTAewMBNDS0Tmud85
 KH5j5drTQzOAbIhxudKiZaXo9wwa46OCq2FVaGILXJmQ2lCLgWHDsnVykCSCjIeCHTY/
 ZQXHtXE3g9CAUtVdt2NYw02fZ7pg8W1ftQR0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mu52mCpV2nrQW+DvvGvGXwkA9rgLAwESwOW831oZMnE=;
 b=uZvNvuDprrQnHfwStgzJom4tHK7HAiHJKP/gX+srza+zDyQQxm3CFkW38kEl6u9A5t
 b3g2Aw2mbap0JPxxdQbkOIyv8VWFjcPq2y4QV5AjQYtBU9zyQ+bOEc0d8PZkUCV2wZFT
 2P2v+zQrHERdhBxnXuSHGPzDKIAE//wMozXOBNY8LT5oMrrdvch+qGoIkeRIJqr4U373
 uMDPR2y27q4mWsxNaW+eKJ+ma7WRcvLvGhskWRiUku6Vz3qW32FLU8Hw5IB4+xRQD+uV
 05Gdjjw94xMCMs3WwYQ4ZAdxNCzC4v1f5LcBJMSKt0lFKoPmlzUKxHj4OIdnZIbdKpzz
 ftEA==
X-Gm-Message-State: AOAM530cvT9ddR99jaHMOpJoEyFcCSo0zP+d07a2A0N7G0s+MD+0pK96
 0SPNr1Bz3DmKfPo4J2aM6hLkKFRVRalTn9miewo2uw==
X-Google-Smtp-Source: ABdhPJyR3JZ53vXZtEgCpx9pT/ydRQnd5TmsZ9xh4WkPiq1Hsx2lP0NtdPS27LZu4ouZ2C9SZTB2oznIMinprrNekro=
X-Received: by 2002:a05:6638:3012:: with SMTP id
 r18mr6621186jak.282.1642267626434; 
 Sat, 15 Jan 2022 09:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
 <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
 <6121a782-6927-f033-1c09-ffe4ad7700ae@yahoo.com>
In-Reply-To: <6121a782-6927-f033-1c09-ffe4ad7700ae@yahoo.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Sun, 16 Jan 2022 01:26:40 +0800
Message-ID: <CAJMQK-j5YYqen78Vgng_5jhja-YKSTRut7f7vJ4wWufVfbZy6w@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
To: Tareque Md Hanif <tarequemd.hanif@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Jan 2022 08:48:56 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hi Tareque,


On Fri, Jan 14, 2022 at 6:09 PM Tareque Md Hanif
<tarequemd.hanif@yahoo.com> wrote:
>
> Hi Hsin-Yi,
>
> On 1/12/22 16:58, Hsin-Yi Wang wrote:
>
> Can you help provide logs if we apply
> 5a7b95fb993ec399c8a685552aa6a8fc995c40bd but revert
> 8d35a2596164c1c9d34d4656fd42b445cd1e247f?
>
> Issue still exists. journalctl log attached in revert_8d.txt
>
>
> > after apply 5a7b95fb993ec399c8a685552aa6a8fc995c40bd
> > 1. delete SET_LATE_SYSTEM_SLEEP_PM_OPS(i2c_suspend_late,
> > i2c_resume_early) and function i2c_suspend_late() and
> > i2c_resume_early().
>
> No issues. journalctl log attached in test1.txt
>
>
> > 2. delete SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume,
> > NULL) and function i2c_runtime_suspend() and i2c_runtime_resume().
>
> Issue exists. journalctl log attached in test2.txt

Thanks for the testing.
Can you help us test if applying the following patch on top of
5a7b95fb993ec399c8a685552aa6a8fc995c40bd works? Thanks

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9eb4009cb250..6b046012aa08 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -484,7 +484,7 @@ static int i2c_resume_early(struct device *dev)
        struct i2c_client *client = i2c_verify_client(dev);
        int err;

-       if (!client)
+       if (!client || dev_pm_skip_resume(dev))
                return 0;

        if (pm_runtime_status_suspended(&client->dev) &&
@@ -502,7 +502,7 @@ static int i2c_suspend_late(struct device *dev)
        struct i2c_client *client = i2c_verify_client(dev);
        int err;

-       if (!client)
+       if (!client || dev_pm_skip_suspend(dev))
                return 0;

        err = pm_generic_suspend_late(&client->dev);
