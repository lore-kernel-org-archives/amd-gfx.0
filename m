Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380F6C32774
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33036D8FAF;
	Thu, 25 Aug 2022 07:19:30 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75B610E71F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 14:45:53 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-11d08d7ece2so14281623fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=xJW2jI96Zwcrvy+eTtY4zwb6R7KH49EInbBsysTbn04=;
 b=VhZ1r9dZw+q80O6nYjGPVr3Ni0ZZ1y1ZdEbIemDT/Di6L0qxY/Ro2D2l+08GZvkmkm
 ukKNV0tJ6aDz+zMJ1XKSVlUh6dnx//7R+ufQT0kH5YQ7laUchITugBQMDWGJ1NAIZ3Vd
 ghRuDpnMAINyfbwg/aLX+/9jH2RlbDkUk7UuiG9MqBHkx6/VkB5uaIylZs4Jp7n55sau
 wo3eS/AbWetL4ts1TRUXKjAeGnK6i3iV0OHPFplupPkUxwYXpbB+sUYVSyIQH9g2rlrC
 7grIxYeK4TwjZ7x6R7ABxXZheJ+50ruDEKqTf3iHjm2ho15RdQBmamCGbZAv8RzJJM5V
 slqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=xJW2jI96Zwcrvy+eTtY4zwb6R7KH49EInbBsysTbn04=;
 b=z2lA7rGjNOWj38IQ+VNAT26NlkNLFheoJ/igq7vdEe+BjtfGd80NZlXt+tZOYSLrkN
 Dwk5g7o8FJhQqHc/7oplnVEGFNwys5TqP9nM8jwIOPw+k1dW+ZJXmAgHHvLbeMHY3Lrq
 tDT2nYA72Jd1MHXYTOTEEre0oVucp13YA0pp6tqVol/1yqH3k5Rqf5y03eHtLaL9r3Bg
 m8veYeDTsP/m51o0ccSZc2HyjGx8llZwpC2m/UFfWLzTI3Ml2Xh8OJ5ZdmvHE7XGe8Ez
 rel0kLXqwZBNLDcooNH98o0mkSjUjBGCFiVGFvOXVmy4mK91XK+Gk2C3J8xs8wxV+yTM
 p4SA==
X-Gm-Message-State: ACgBeo339rtyfMYLW529JM8w9eI62GTx2FKWJKnuc89hCBkUOBpcpxgd
 179ywC48Q9QyxuRghYaGIC1rq6Oo2nZfFnOB/T4=
X-Google-Smtp-Source: AA6agR66fkmkvlbzDo7a46+yk6fXL1KDXUmUWrF+QVrtdW+IrekthVSmJuG9nEr3Bc6wthKrZ+24RcujERHX4470XWs=
X-Received: by 2002:a05:6870:5a4:b0:11d:37b3:ff54 with SMTP id
 m36-20020a05687005a400b0011d37b3ff54mr3703850oap.172.1661352352883; Wed, 24
 Aug 2022 07:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190725.GA2499154@bhelgaas>
 <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
 <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
 <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
In-Reply-To: <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
From: Tom Seewald <tseewald@gmail.com>
Date: Wed, 24 Aug 2022 09:45:41 -0500
Message-ID: <CAARYdbhdR0v=V82WnQOGBNrcth8z6F_61SxG9OTzgNpgg3xx7A@mail.gmail.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Aug 2022 07:18:47 +0000
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
Cc: regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 24, 2022 at 12:11 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
> Unfortunately, I don't have any NV platforms to test. Attached is an
> 'untested-patch' based on your trace logs.
>
> Thanks,
> Lijo

Thank you for the patch. It applied cleanly to v6.0-rc2 and after
booting that kernel I no longer see any messages about PCI errors. I
have uploaded a dmesg log to the bug report:
https://bugzilla.kernel.org/attachment.cgi?id=301642
