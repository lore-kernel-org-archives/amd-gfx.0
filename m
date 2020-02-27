Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE8C3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC8824690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCaNGPt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC8824690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5F66E97B;
	Thu, 27 Feb 2020 21:02:34 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4156E97B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:02:34 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c13so460379wrq.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5uZ1WmzT9kBZiF2GCN0KsvLC6imulwY7IY8qSr48vFI=;
 b=aCaNGPt2WeKLIPVHlpYfq/9RVZqGbiwjKd1GoyNf+MYpU+fm6pW6JRQa+8wiXlj2Hd
 cJvezqwmNGjr3AIwEuApSTaVQJDWqynb0WhuOqW6W830fbEHiNb0TQO79FsI7y8JlOju
 TpVlhkFpdsed7ebqgavbcNmFIr/g494UjCDzupepWKo7eC4sCX0xS6sde61yrt1J8XVv
 Yo2SRQaBmrAL717mxKrK6UgTjfPMlIchhJBDNrkJljyO7spfXC6hPqp8I4VoMXcIPf1Z
 cfWWOmD1mrrDXYsWhLG6ZqO6IxV5HDo78g1aEqVbIVHJC2d0f8W/CUrQJS24+2Rmf1cQ
 uDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5uZ1WmzT9kBZiF2GCN0KsvLC6imulwY7IY8qSr48vFI=;
 b=cv/utUepbUkMtSdzarK+QWDrT36nqSRCfkTPfTvzWHx+NwWNmqg6i/5VLkCWsu8uuF
 rh+t+WHybXuHqjXg+4q/4L41iVZcDrgMMBo31huqmrwEaPBAqwvF5fOjR6tS/fo4IMhn
 c7QoCTDMOYwzQ58gXYlWgknW8tqFAgD2f0vpaRtRaQUidQISiTB2fbA6UzGOfWJkgJQm
 mToWZGY6sRu4NF7TKusUnISEt8xASW63esPCkuREmV49RHlWFhzbRyd3r9wQJeTRh+20
 J6WCfabMXsZgR3RS8dTTOEKqvb4YqR+paN2GX+s5IP5J6aRS+aK279BNHdUh7IS5OeRi
 GtYA==
X-Gm-Message-State: APjAAAUIdpmMDkWFe7kwIsWQht7x+M50JPeyO4qyC77Ej6IPH7ytl+8W
 hIdxaSsdHeKEeIhAvLuaTSiKEPBi0AzBLYLuTSI=
X-Google-Smtp-Source: APXvYqyKYjsca4k1ejhXPINwelvmkTWZWZXvYEz9yYdClPM6vlB+H1dWtZ/Do2U4HdiBe8saLBP+ZawDAercZaOtnI0=
X-Received: by 2002:adf:9282:: with SMTP id 2mr827447wrn.124.1582837353171;
 Thu, 27 Feb 2020 13:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
 <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
 <CADnq5_PPqDGn2rP6ep6aEHgjow5mkKUp1=FLLo_mDn-QEsN1KA@mail.gmail.com>
 <31b82a5a-4767-1a4b-b74c-61179a52b9e8@amd.com>
In-Reply-To: <31b82a5a-4767-1a4b-b74c-61179a52b9e8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 16:02:21 -0500
Message-ID: <CADnq5_Ofp64uFjWQzzVdyc0tKPU+KsOm8um5AYWgJsLAuf25YQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy <nirmodas@amd.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <Ray.Huang@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 3:28 PM Nirmoy <nirmodas@amd.com> wrote:
>
>
> On 2/27/20 3:35 PM, Alex Deucher wrote:
> > We shouldn't be changing this at runtime.  We need to set up the queue
> > priority at init time and then schedule to the appropriate quueue at
> > runtime.  We set the pipe/queue priority in the mqd (memory queue
> > descriptor).  When we init the rings we configure the mqds in memory
> > and then tell the CP to configure the rings.  The CP then fetches the
> > config from memory (the mqd) and pushes the configuration to the hqd
> > (hardware queue descriptor).  Currrently we just statically set up the
> > queues at driver init time, but the hw has the capability to schedule
> > queues dynamically at runtime.  E.g., we could have a per process mqd
> > for each queue and then tell the CP to schedule the mqd on the
> > hardware at runtime.  For now, I think we should just set up some
> > static pools of rings (e.g., normal and high priority or low, normal,
> > and high priorities).  Note that you probably want to keep the high
> > priority queues on a different pipe from the low/normal priority
> > queues.  Depending on the asic there are 1 or 2 MECs (compute micro
> > engines) and each MEC supports 4 pipes.  Each pipe can handle up to 8
> > queues.
>
> After some debugging I realized we have amdgpu_gfx_compute_queue_acquire()
>
> which forces amdgpu to only use queue 0,1 of every pipe form MEC 0 even
> if we
>
> have more than 1 MEC.
>

IIRC, that is to spread the queues across as many pipes as possible.

>
> Does it make sense to have two high priority queue on the same pipe ?

Good question.  Not sure what the best option is for splitting up the
queues.  Maybe one set of queues (low and high) per pipe?

Alex

>
> Regards,
>
> Nirmoy
>
>
> > Alex
> >
> >>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
