Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14678C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 07:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B996987D6;
	Mon, 22 Aug 2022 07:18:42 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F1610E09D
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Aug 2022 04:27:28 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id l1so7937066lfk.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
 bh=wC9lL9Kc6Kp7xZsJEHL/dIwZgeCbFL0R65oEXkMpUCA=;
 b=fXJr+IvqO5eCLb4L0UNuczZ9ytlfp93vBptFNfXYrkEM4z+aLvwjCDezTPjppA0MbE
 0MeM/jpKhgBUvnnC9yaWkqmdX3s76mvgMTc1lDf5Mzmhjxp4KHnPbmUxKpBLKzah5FER
 3jT0ZV/4hcOdQzDAGHvt8T4loNkP74uKIm59r44Ebltvd5D0RztGXXjo944NXqhu9bWZ
 YS5cQ0q2YyuZ4KDbaJCuObYLp4jvsis8zduYJ7THpi75EPKa1pmxFJn0Ykt2YNSBEHvf
 lkw5wVZSngpCxNVehDv4Iijum6BMafTE0qEQjh7/RcLcfb39UqAMGO3Y3tv/YhbiOzYe
 g5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc;
 bh=wC9lL9Kc6Kp7xZsJEHL/dIwZgeCbFL0R65oEXkMpUCA=;
 b=Ce/K7cZTLn5T1SIsLPKMfF6JLNDXt0UZ59FHwHX7MzvS2BuUoDfdLp0Xk+WtBINiey
 UK09Cr4nWGOCmUp7uFgzr5exB1m6Blb3nTtG6BTsr8BKJ8yhNzv0/OaGzus392v1sDPO
 HLlHu5Gv9ffUHSvN0WmO1DKfDyTdjz7rHFuVbPws6un2nV2hR49HDNtmQp9M/V2xLBYL
 LDZaE7umsLc/DhZ0irTX2Ayl28aX2yEMoAAtP7n0oj7cV2OVVi7Bo+ldM+9A3IKELNQ/
 rUrldQKtvOhxMpCCazB8NJseUkX0FPSKtP8AYmyl4GNydQjtoN5WTmKdjqAJRXU0mi0q
 WkrQ==
X-Gm-Message-State: ACgBeo269Ic4ZUMBBAywjfKMudjQ2IhiZAiwyoIfnG2Q/ijy8KBGStH1
 jCChPZCOR9jY/jZk7PZ38BaIR+4DoPZj8/iqONkdyDMVoyY1Lw==
X-Google-Smtp-Source: AA6agR7p+ven6ErQfFbkAvUx1F1VvXjx8u5VcCIIsX5st+SftUxZQa+jCMMAoIJmnvfUWU+Q1dRvLxf5/wJ06Ey0BoM=
X-Received: by 2002:a05:6512:131f:b0:492:992f:1f3c with SMTP id
 x31-20020a056512131f00b00492992f1f3cmr3188670lfu.565.1660969646675; Fri, 19
 Aug 2022 21:27:26 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6I+c5Y+2?= <ye.jingchen@gmail.com>
Date: Sat, 20 Aug 2022 12:27:14 +0800
Message-ID: <CAA6RncSwQL5A1Ox3a088Kpp4=-bHPzAGcJa_fEFkiE801tAJjw@mail.gmail.com>
Subject: No Audio from AMDGPU HDMI on 5.19.2
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 22 Aug 2022 07:18:35 +0000
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
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

I experienced this issue on Arch Linux 5.19.2-arch1-1 kernel on an HP
laptop with AMD Ryzen 6850HS CPU (detailed spec below), that the audio
is completely silent on the HDMI connected monitor. KDE audio settings
says everything works normally, HDMI audio shows up and can be
selected as the default output, just no sound from it.

It worked fine on Arch kernel v5.19.1-arch2. Laptop speakers always
work, and the monitor works when connected to another Windows laptop
over HDMI, so the monitor isn't the culprit I assume.

Kernel log from the journal didn't seem to contain something relevant,
but it may be me not knowing what to look for.

This is discovered on Arch Linux kernel 5.19.2-arch1-1, but also
reproducible on vanilla v5.19.2 tag.

Bisecting between tag v5.19.1 and v5.19.2 in the stable tree gives:
308d0d5d98c294b1185d6d7da60b268e0fe30193 is the first bad commit
commit 308d0d5d98c294b1185d6d7da60b268e0fe30193
Author: Leung, Martin <Martin.Leung@amd.com>
Date:   Fri May 13 17:40:42 2022 -0400

   drm/amdgpu/display: Prepare for new interfaces

   [ Upstream commit a820190204aef0739aa3a067d00273d117f9367c ]

Anything else I can do to investigate?

My hardware spec:
Laptop: HP EliteBook 845 14 inch G9 Notebook PC
CPU: AMD Ryzen 7 PRO 6850HS with Radeon Graphics
GPU: VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Rembrandt [Radeon 680M]

% lspci | grep -i audio
63:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Rembrandt
Radeon High Definition Audio Controller
63:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 60)
63:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family
17h/19h HD Audio Controller

Software:
plasma-desktop 5.25.4-1
plasma-pa 5.25.4-1
pipewire 1:0.3.56-1
pipewire-pulse 1:0.3.56-1
wireplumber 0.4.11-4
alsa-card-profiles 1:0.3.56-1
linux-firmware 20220708.be7798e-1
sof-firmware 2.2-1
