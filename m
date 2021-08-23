Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A8C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A84C613A6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A84C613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFF889B70;
	Mon, 23 Aug 2021 20:49:17 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8E389BC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 20:49:15 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 k12-20020a056830150c00b0051abe7f680bso34843832otp.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kRioPTSwPNPQIawlVjBYUzUe1ixS3CDqz1E0OToKW/0=;
 b=icpSRXFrtIwMTLAq6k0FjigYljXDSrKlLfXeaeSKo/wAwMoFAeBhdLvRma2cWEv9NR
 UbsbezU+0isWZA8E2r2S87/URdtr1zQi2UdendocMFoE/H2Ho//YphDzly87MlR/eprh
 IDy9cTW1Az3ondfyIOyZB5JLj7A0BNDuu2sewBCHJhVMpvDh2vvdx2XBhzu6Tykou4dz
 XuDR2Z9U7ahgH701PeiYMoZUGXvjTSz0q6gVd5cNrf9VIbx7R51v+teDzl+8/tRmvPnY
 GzFUXCfK1mX+22cFGPlhZ/FMqPPxHR6wnQ0+E9az6KdQnWwXAseoFKNmGieYhEFtTKkS
 hgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kRioPTSwPNPQIawlVjBYUzUe1ixS3CDqz1E0OToKW/0=;
 b=lwQzPDQKGdya2pbpWgaXUaoCjw1aq1TESV1BltRn+sH65k9pGixchfkJoYKa29sh+Z
 Htt6GCKLDNHvx87z0fIU3UFSgKLjdVmKuR0Dx5W6/Zovxm3Lm+/UsBAuXztdx+y+HI+x
 bWYcbirzyjKSirG4sEnYGK0C1vasRLBnWAJC0IViqy/lLXn6kmqB7XcqhzNI0X/bVzsJ
 +4DA0WictO5m2F/C4AxlWC/BL4Nr7WYAveiO63glGZMH4xcUPgYGDQYZzf51R9bY8cJ/
 Wnbsrhqkv/wbcdWsxKZT1Pp8JQQngjw6pi1s7MbHqAVpEPeb98UNzSSoNoR9K5/MAxJe
 GPwQ==
X-Gm-Message-State: AOAM5319G9hxVEhzSQ7I/7aaJigVl8Bxryu+GngBjawUDuxYfIxUGAkz
 1z9Tu0ZYRD4rvDSXT+PeffvqnrWNIKIpPAc5VPo=
X-Google-Smtp-Source: ABdhPJyTqOIR/h/yNMKFNF14JH+tbIbDvdaqQ6ajhKxsEA97mpcrsd9PxJlq5thk1Mhopi+qdXRRBiBCkWCotwFi7JM=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr16178721otf.311.1629751755213; 
 Mon, 23 Aug 2021 13:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
In-Reply-To: <YSQJL0GBzO2ulEpm@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Aug 2021 16:49:04 -0400
Message-ID: <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
Subject: Re: ERROR: modpost: "pm_suspend_target_state"
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
To: Borislav Petkov <bp@alien8.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 lkml <linux-kernel@vger.kernel.org>
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

On Mon, Aug 23, 2021 at 4:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 23, 2021 at 04:31:42PM -0400, Alex Deucher wrote:
> > Thanks. I think that should do the trick. Care to send that as a
> > formal patch?
>
> Sure, but let me run it through the randconfigs tests first to make sure
> nothing else breaks. It is late here so if I don't manage now I'll send
> you a formal version tomorrow morning, CET, the latest.
>

Sounds good.  Thanks!

Alex
