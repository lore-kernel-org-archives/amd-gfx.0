Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238CAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132FB1128B0;
	Wed, 12 Jan 2022 13:26:27 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EC310E3D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 12:25:14 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id 19so3365376ioz.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 04:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r0Ed94N6PJ1HQvpwsTDcBAz1gPfqabvU1XtB9N89ivo=;
 b=i9YELGkPrF9QildKnEB0Dl461a8mPFeJ9M7JKTP5U2yLPD5Qyis0LkkhVGUzbd0RpI
 /P9zvBLoXiB15zji+qwH/xUWw+pRZlU1+I1m4SRLHwC6H8/GEBbhK+sL4dz43TxBPrHP
 fdSDxAOsL7O3hf1tG/sWVsfWRSmoMvMLYA4Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r0Ed94N6PJ1HQvpwsTDcBAz1gPfqabvU1XtB9N89ivo=;
 b=vQtZXoEd3lIqfNyt1lydrMf/Ab3UeabRY8SUoFtbpJPCufWXgASwxIF6vs20PDP4zL
 lLx44Aw/nV1kXOi7IlZFYa1sq7ASU0ddwTgMjGgycd4U2y7rAsiRG5jylEh2wfiBMO2H
 4cUPtBvH9D1y7saStop8somu0gER29QRDLDh03Yjj6WU9LsES3a6jzEY4zq+AfeQDum8
 /AZ3LtNizxqosQUMn5+D2wg6FvfZQoS1OuvBRjsHvl7fiXRa8Hijj3sdm4RrqBieu9pz
 xAvPWDpia8TqjUeRE8oq0YyCDaXb3BobmIpDU0TmtFd3Nj1zVzAN2IkqKbfOdGfQikWI
 Bc5w==
X-Gm-Message-State: AOAM530XUkik3Pfg6ZQxGsKrU2jXk1MblhsTpBgWhALxBWRo0mQX78PX
 DxeS3wlrR0oY0bvwrZedmdSSxGO0vUcVc4x4nHNqkg==
X-Google-Smtp-Source: ABdhPJz3aWTJ6YHXl+DNpQfRBduYGsa3dA2FrH3qublefl99BTefVU7PwBsvrZTCfAWITEprI8dsA0VWgDMC1jSTU/M=
X-Received: by 2002:a05:6602:17d0:: with SMTP id
 z16mr4259571iox.204.1641990313893; 
 Wed, 12 Jan 2022 04:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
 <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
In-Reply-To: <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 12 Jan 2022 20:24:48 +0800
Message-ID: <CAJMQK-g1pqg05K+ZL0R3i67gitEVoZQ2jbOuL=Q2djBr45soAg@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
To: Tareque Md Hanif <tarequemd.hanif@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 12 Jan 2022 13:26:25 +0000
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

On Wed, Jan 12, 2022 at 6:58 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> hi Konstantin and Tareque,
>
> Can you help provide logs if we apply
> 5a7b95fb993ec399c8a685552aa6a8fc995c40bd but revert
> 8d35a2596164c1c9d34d4656fd42b445cd1e247f?
>
Another thing might be helpful to test with:

after apply 5a7b95fb993ec399c8a685552aa6a8fc995c40bd
1. delete SET_LATE_SYSTEM_SLEEP_PM_OPS(i2c_suspend_late,
i2c_resume_early) and function i2c_suspend_late() and
i2c_resume_early().
2. delete SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume,
NULL) and function i2c_runtime_suspend() and i2c_runtime_resume().

Does it still fail if we do 1 or 2?

Sorry that we don't have a platform with intel CPU and amd GPU
combination to test with.


> Thanks
>
> On Wed, Jan 12, 2022 at 6:02 PM Tareque Md Hanif
> <tarequemd.hanif@yahoo.com> wrote:
> >
> >
> > On 1/12/22 15:51, Wolfram Sang wrote:
> > > would the reporters of the
> > > regression be available for further testing?
> > Sure. I am available.
