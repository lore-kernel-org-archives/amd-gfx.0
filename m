Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A95EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 14:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB7D10E20A;
	Mon, 26 Jun 2023 14:16:04 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1BC10E20C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 14:15:59 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1a9a2724a62so2801722fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687788958; x=1690380958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeKlLFTm9h8+21lzNWPuyVNK6pxbotbzxyeTJF9NN7Q=;
 b=MCtIlgmqW2wWN4rV9AKRvzE3mxepPvBhLWBgOVhFzBqzFHJqqX9Zxq9ZmojXMJYaKG
 38OJVEqPK7u7kwcxuPuWAmU2CU+Mw/W7XqkSEvtCM8t8CPZSkoH65hkl62rZLD3+knc3
 VQ3e2s1qQZ3nyVqC9PaFAiPQpQ/zrJ8ylcWBTAmiDfMzgFLnqzlsW9O52DPo+y7FPfPm
 pbpdBL0Swroks0uDsMk13PK/cmD8Ed5sxxuGARv3Og0Rf2Vz/kMEK8doMWvUAUebqga1
 8NY81nCVtAkmR1BPfmN5bWp8YHBjFXmfhMdMu+JHpQVb2rsaaMKMQh9d+iRfGiQ+6kzg
 LYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687788958; x=1690380958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeKlLFTm9h8+21lzNWPuyVNK6pxbotbzxyeTJF9NN7Q=;
 b=XvUUxNMTpJrV8wt+q6F5LztywZkPv3o33/DoPIiCO4hZ1bQNiveJxay438qxk8bMcN
 Xr96KZCj3GV2p+dX9DvBIZ8rtP3Lye+r1TuBmGOFD3lbDzJXwRFSbRzqomdARUEPUbij
 p9+/RKoMefoJJydaFh+mXfL+Q/kbSvqmruv8WrT1Az6CS81I94DqCW/L+Q7uPjf6XvV5
 qzl4nFdlz7ktu05b1xa+4DLWtqYM17NFACO+BFDxt/m2SHkdzCDJ/R5Wm23NjP36kIDH
 bEKWjnKxDCeAVqC++ZzAPE+9t6e3jcHv8y2jS8Z5wPp6kKphRHVk6lNhpcbvTw5VZ5Us
 Yfcg==
X-Gm-Message-State: AC+VfDxuUUkafPx0/TdIuVwWX6CImsZSAccaEoNycKZbRr8Ni0KRKYpA
 hT62rV1gtdEMCooiH/5yk302HQ4Q7zXy04Wwus+OWIQ5
X-Google-Smtp-Source: ACHHUZ75CpgOxYmE3uLzu1CHc+OiYMHaHO7yxPHwkW0vdJP2LKpVUUZvRqOHWbdJkbfzfOOTv1C480/zyvPF//pBtic=
X-Received: by 2002:a05:6870:5383:b0:19e:f50f:f253 with SMTP id
 h3-20020a056870538300b0019ef50ff253mr19477633oan.5.1687788958328; Mon, 26 Jun
 2023 07:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230602184312.752618-1-alexander.deucher@amd.com>
 <85ae153f-357b-53b9-e987-c6aafa425299@daenzer.net>
 <6fd2e4d2-bcb6-052c-031e-6ff9aa04d9a5@gmail.com>
In-Reply-To: <6fd2e4d2-bcb6-052c-031e-6ff9aa04d9a5@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jun 2023 10:15:46 -0400
Message-ID: <CADnq5_Pq4HtF-ERV-gPrC4YjU7=LZzZv96yM-HvSU9oJZ2qRLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: change the reference clock for
 raven/raven2"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx@lists.freedesktop.org, "Chen, Jasber" <yipeng.chen@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 26, 2023 at 9:58=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi guys,
>
> Vitaly and Jasber have been recently working on disabling the IGT tests
> for the TSC query on RV/RV2 (which I'm not very keen on).
>
> And additional to that we have this RADV merge request here:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23481
>
> What exactly is going on here? That sounds like we are working around a
> FW or more specific GFXOFF bug in userspace.

The clock source used by the gfx firmware on Raven is part of the gfx
domain so it gets powered off when gfxoff turns off the graphics
block.  There is a clock source in an always on domain, but the gfx
block doesn't use it.  I don't know off hand if the clock source used
by gfx can be changed or not on raven (IIRC, I don't think it can,
which is why this was never fixed on RV).  Since they are different
clock sources, the GPU timestamp doesn't match the GPU timestamp.  On
renoir and newer APUs, gfx uses the always on clock source so it's
always consistent between CPU and GPU.

Alex

>
> Regards,
> Christian.
>
> Am 05.06.23 um 10:57 schrieb Michel D=C3=A4nzer:
> > On 6/2/23 20:43, Alex Deucher wrote:
> >> This reverts commit fbc24293ca16b3b9ef891fe32ccd04735a6f8dc1.
> >>
> >> This results in inconsistent timing reported via asynchronous
> >> GPU queries.
> >>
> >> Link: https://lists.freedesktop.org/archives/amd-gfx/2023-May/093731.h=
tml
> >> Cc: Jesse.Zhang@amd.com
> >> Cc: michel@daenzer.net
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > The series is
> >
> > Reviewed-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > Thanks!
> >
> >
>
