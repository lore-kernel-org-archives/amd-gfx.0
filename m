Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D5C3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 15:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BAA10E2BD;
	Fri,  6 Jan 2023 15:22:37 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B3A10E2B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 15:18:40 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id a16so2198628qtw.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 07:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLTT10Q08SvcCsbZuYubvWn2TjFc+1wP3y0ZN/T09Wc=;
 b=vl3W3LIDKDhMNwkpL1Fs01qMc/0529PG4JbN34KROF6eO0y2tF4LH7tPAI6W2Q0Mm3
 NqCAd6QN8AQHp0p8QGUKCrimUqipZlkLtXyZTudzC9vzYsFS0jj6kRJZTjriN1MazWTB
 cDEi1Fkwi+asuS1WU5+ooSuMpaoMebo3C4B1suf8ya4He7QqKnlMp62xtOfjckcPspFp
 PXCiw34n53L88smJAG5RaIMx3/q7wqDITI8sMNYusZCJ8HDi6mK3qpG+OLSvE+qZbtwK
 os4ilTUeKBGIpPOVVSpge4TQXVmTtnVyfD4xSVmRFXSOIUEOKZJuaVKCPAz6aWZnnmJY
 UGAw==
X-Gm-Message-State: AFqh2kpecjMqHMZFZ5KXYZkOLwUQbF9NgjPPdlc1Bb8EZ1HpNc6piXvr
 EdWDzq+fCrgcMO3BaohJzcqcBvmqgSGrQg==
X-Google-Smtp-Source: AMrXdXtz05pkkYhTD8HQ8dTgJZY5caKswDVuWnQYTzIYEf71V3Gpu7Ot7E0fSnEU9dvY5CH8u6qEvw==
X-Received: by 2002:a05:622a:4d47:b0:3a7:f183:7f66 with SMTP id
 fe7-20020a05622a4d4700b003a7f1837f66mr84149038qtb.22.1673018319249; 
 Fri, 06 Jan 2023 07:18:39 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com.
 [209.85.128.178]) by smtp.gmail.com with ESMTPSA id
 fz18-20020a05622a5a9200b003a591194221sm634574qtb.7.2023.01.06.07.18.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jan 2023 07:18:38 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-4b6255ce5baso26158887b3.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 07:18:38 -0800 (PST)
X-Received: by 2002:a81:17ca:0:b0:46f:bd6:957d with SMTP id
 193-20020a8117ca000000b0046f0bd6957dmr4281773ywx.383.1673018318622; Fri, 06
 Jan 2023 07:18:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
In-Reply-To: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Jan 2023 16:18:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU8AKSdujbr=nwaBUy4q4z_R=MERnb5CBPPv=A63BVFXA@mail.gmail.com>
Message-ID: <CAMuHMdU8AKSdujbr=nwaBUy4q4z_R=MERnb5CBPPv=A63BVFXA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.2-rc1
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 06 Jan 2023 15:22:35 +0000
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-f2fs-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 6, 2023 at 4:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi John,

Bummer, "Hi Adrian", ofc ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
