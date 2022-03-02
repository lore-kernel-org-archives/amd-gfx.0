Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B968C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 23:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC3E10E4D1;
	Wed,  2 Mar 2022 23:20:19 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A59F10E4D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 23:20:18 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 s1-20020a056830148100b005acfdcb1f4bso3074863otq.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Q5O31HUYjdscklXRXvmIo2a+KRrg+KbZekYyUmOBdlQ=;
 b=NMlh+In8hqJzm11n/pBAceHkhO4cKz+IQpIEEoxyH/w/Klg2dyhHX3ssfZYWonHRzY
 gpU3xjA6mVZZalgz5Is3Oq7Jdy/fnROfgT5X3nr4NkIWINDj1KnvpSdMxgE9jmOKoZmL
 RG1wVitWI6pA6ORD9X1JvqTI2oUyRd0NldwtysPIDhdrc8dKKLQ4jZOmslsv+avMZQjN
 PP7sFsW8rAVB+phBv+vNzV+5g7MOnqfey0bj3E8ny1obNVlJ1TePtqaYZaxabwUiG77W
 gv5/E970OV8yV1Ga9K/QlEZV1+ya9ymaggsGar316Q7vhPLMRV/k+YrshugeJf0XW3cE
 g9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Q5O31HUYjdscklXRXvmIo2a+KRrg+KbZekYyUmOBdlQ=;
 b=opKdWx6h67xNokrEvHPkKf6oWX8b+/5aayd4TMzaTnEqm6SqBzu/zjMyml1QBdyejb
 YNQggjDhSBoskzak7Dla8Zaul6wOiPaJVOSVQ0CnfLJW4T2HbpjlOcPDCRY5OpQvT8Ib
 f5z9sIBQSqd1QTIMfkeIttdFxAQJpxSOx/npkUUd+DEEPE/MeN8q74ezccPb4P/uwr7K
 NgS/Cj/J3qQkaB54NzhQhDh9AS0hX88aBmfLeLTslvGOsBQlPtDDVjw4uu0TSECgkjgb
 04HKyd9SZNe7iyZp3gnJZGRHFgSKZ8Y83DyaCafIj+6vCrISUcc4O1MKQ1TlnSH1eGNB
 mSxA==
X-Gm-Message-State: AOAM533AIHMW65UkVO6TqI67OIYsIQG/sJrYVApmYLwfKWpMemmwusMS
 Rud19tZXNSokJ8U/XH9ikYcEpDQ6Qa0o73fjarY=
X-Google-Smtp-Source: ABdhPJwsJn9qaH2KXnNnxkinO/s/Gt3k6nIoSEEBwfC4GuE26Li2y7FVOO9kRLouMtJeKS/JPR+vB3d4kyg4ibTYRzA=
X-Received: by 2002:a9d:5a06:0:b0:5af:b5fd:5b72 with SMTP id
 v6-20020a9d5a06000000b005afb5fd5b72mr17283446oth.200.1646263217608; Wed, 02
 Mar 2022 15:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
 <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
 <6121a782-6927-f033-1c09-ffe4ad7700ae@yahoo.com>
 <CAJMQK-j5YYqen78Vgng_5jhja-YKSTRut7f7vJ4wWufVfbZy6w@mail.gmail.com>
 <363432688.323955.1642272250312@mail.yahoo.com>
 <CAJMQK-jx+z974AT_p+-AVAbMQQ33V-XU9NKmy-i6nbS5zagHBA@mail.gmail.com>
 <297191986.3285872.1644002564779@mail.yahoo.com> <YgaiFsgQUSeUTUwz@kunai>
In-Reply-To: <YgaiFsgQUSeUTUwz@kunai>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Mar 2022 18:20:06 -0500
Message-ID: <CADnq5_M-Wrav_WW4Wx1GC+f0UJtS_Op4W0VWED4VvPhYqDvp2Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
To: Wolfram Sang <wsa@kernel.org>,
 "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 11, 2022 at 12:51 PM Wolfram Sang <wsa@kernel.org> wrote:
>
> On Fri, Feb 04, 2022 at 07:22:44PM +0000, Tareque Md.Hanif wrote:
> >  The issue still exists. It takes very long time to suspend (10-12s). `DRI_PRIME=1 glxgears` is a black window.
> >
> > journalctl attached
> > Looking forward to any testing.
>
> Any new ideas which Tareque could test?

For some background, the GPU has multiple i2c buses attached to it
which the driver uses for querying the EDID on monitors over i2c.
Although in this case, the i2c buses are not used because there is no
display controller on this particular GPU.  I'm not even sure if the
gpu driver exposes any i2c buses in this case.  The i2c buses present
are in a vbios table that the driver parses at load time.  If there
are none on your platform, then it's probably not the AMD GPU driver.
Can you check if there are any i2c buses from the AMD GPU device in
sysfs?  I don't really see why this patch would change anything off
hand on the GPU.  Maybe the GPU is a red herring.  No one reported any
regressions on systems with AMD CPUs or even other Intel CPUs.  This
seems to be specific to a particular Intel CPU + AMD Topaz GPUs.  The
dGPU power is controlled by the platform via ACPI (it's usually a GPIO
under the covers).  I wonder if the issue is related to one of the i2c
buses or devices on the intel platform?  E.g.,

00:15.0 Signal processing controller: Intel Corporation Sunrise
Point-LP Serial IO I2C Controller #0 (rev 21)
00:15.1 Signal processing controller: Intel Corporation Sunrise
Point-LP Serial IO I2C Controller #1 (rev 21)
00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)

I'm not sure what those do, but maybe that is something to look at?

Also there are some PCI AERs in the kernel log.  Are those present
without the patch?

Alex
