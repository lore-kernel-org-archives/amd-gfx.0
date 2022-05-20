Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFB8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 06:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3953911B4A2;
	Fri, 20 May 2022 06:13:16 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA46610E446
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 00:47:16 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id p139so11755164ybc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QIoUiuZGqV7oFDLhhYUZHcVLA10ci1UfARClMRzKgYo=;
 b=FdDLvN2NTra6ypywHizY8dWfdcVjPnTiseiW035ivOw1/e8glVye6PPRdXsY8uZWxS
 LEEtdYnT77Xbjn5vD0R7h8fuAkhjk7YyXxezuI6QgH7RnkrV5QhteKzQ1z+Pf9JaNC9O
 0JUMMgyaJPHB99SmwIPETS7FNRJI+xvULMCllvqpb9JJrUxCo25uH7ZIFQhqOa1ZHYBA
 dkcVIHDx8INQqyRKWyEuBJDQKWyl5GfH/9JQLw4NS6BqHqF6ao3cwg+U3yS672ZZoGL9
 nQiVOJ77+w4ZSzNywC4k6VzOz+Un617U+Q1uPR392g0v3lVXst+dNHhZCnhbYGRZAnkm
 puhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QIoUiuZGqV7oFDLhhYUZHcVLA10ci1UfARClMRzKgYo=;
 b=dAiWmZQbH7ZD2dyGzn6pFa325aGr7O85TPnrBOiFUen8lOvZvIOdDpeqYsThwpeQO3
 ryNUR+0U0C3z8+EpBpi+EMI5Ftb8h31T7eT1PfgnGbZGkRdApifOCefyLNortteT/daE
 r4PsBsCSJo3QuzeuNPVxn3W0m3xkSB0+RUkckvLHhrM8YoIMD7S4QINazNGJYc754Q9+
 prB8OCUpYavM0sJIgB0MhIGsR2oU9lfhy4X90Dy0Kvzi4exDuMhJK4y9sb2CDqPSr5+n
 9ooeKVeQsk1PUXEvHkFD8/WP4bDVzpXYBApEPlXeKYRgzp0cqhLWzy1GlC6CjMusJS4X
 rtTw==
X-Gm-Message-State: AOAM5300NQ+jLzowhStZPYBRXenFDXzdI67CtKP/lpPQUYh7g1jRZki0
 XKTgdcYjigt8JcStJO5tLr+MBJmWXcXazdQ0Oy4=
X-Google-Smtp-Source: ABdhPJzkt5PraYGDQgB0+kBC486a4S/fxdly8I69BJVJqe0PZ3nHUepoaDwveVGapcItqMmpTgMaPZNYUH2+UjcSw/w=
X-Received: by 2002:a25:eb06:0:b0:64d:7cd1:f416 with SMTP id
 d6-20020a25eb06000000b0064d7cd1f416mr7275416ybs.237.1653007635825; Thu, 19
 May 2022 17:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
In-Reply-To: <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 20 May 2022 08:47:04 +0800
Message-ID: <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 May 2022 06:13:14 +0000
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
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, specifically patch
> 'drm/amdgpu: Switch to delayed work from work_struct.
>
> I will just reiterate here -
>
> We need to be able to do non blocking cancel pending reset works
> from within GPU reset. Currently kernel API allows this only
> for delayed_work and not for work_struct.
>

I'm OK with the change.

With an updated changelog:

Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>


Thanks
Lai
