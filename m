Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438DCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 09:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD74D10E5DD;
	Thu, 17 Mar 2022 09:30:00 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F9910E5DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 09:29:59 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id
 l1-20020a05600c4f0100b00389645443d2so2812771wmq.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=PPV/3yekNxP1EceqjJGpxw/gKPSHQInEWHupNJLTBAk=;
 b=ZaBsMr07JDXPa67dzAwVceU/0XWQ7VpYQsLwMcBf/Vz6W01miH3I1FJHBB7wtNBezI
 sodGoGW9TYwAEZF+SB1xNiWpQWoX6WctRmYX9zWNomJqoyrmn6Zc425p3qc3G/JYKsqg
 oQ/2jcQhcKJ6I/gwo7+3NlRxWXiEWCfRv8dvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PPV/3yekNxP1EceqjJGpxw/gKPSHQInEWHupNJLTBAk=;
 b=xfHlRfDlkQwE8NStViQIq7iR0E0lbgbf6ZZ+nnNhCg9oDd527osxzF2dxnJKIO2Crg
 1GK3Wb5UKfXKt0kpp9R2EqFLwKD3ejtdHA3pjT4yVq599HTz4Rsqbb+sej+2NcV6N2X8
 F2H6g0tI7bem1sxEwyqd4jIoxUpFCqY/zwNTD9TkPU0IumyN4Cs7/6jzgWqTyphXJwze
 0SJKY7MMEr/EprGCqiYrWhA98B323ANyoxhQzDhTSji6ZYestZDj5PxPtJ9ul2Ifo1wR
 hIGYNiprcf7sUjSFcUfsYQvWUvIyg7cmTCvmpUSnB0Q/Ev4cTArX060qlUb7IPlaGX/+
 Ad1g==
X-Gm-Message-State: AOAM532ht4f28OB+C2Epo9uvE++NhbUjzIjpmcQE0prLzXdgehstdiWL
 uaAfXwSj04pOtqd7Q3yExvSnQA==
X-Google-Smtp-Source: ABdhPJxoRvRG+o/gOKpQUASU/0daU/fVdPz1QW8lZ31zZ9KKfEPD/2l8jKzGdNB0WKSsMhjcMezgeA==
X-Received: by 2002:a05:600c:4e07:b0:38c:8187:13c3 with SMTP id
 b7-20020a05600c4e0700b0038c818713c3mr508203wmq.11.1647509398135; 
 Thu, 17 Mar 2022 02:29:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c410700b0038c72ef3f15sm2702750wmi.38.2022.03.17.02.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 02:29:57 -0700 (PDT)
Date: Thu, 17 Mar 2022 10:29:55 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v2 1/2] drm: Add GPU reset sysfs event
Message-ID: <YjL/k6kh+5RihGIV@phenom.ffwll.local>
References: <cda15a47-f469-2a7e-87b6-adf00e631ef0@amd.com>
 <CAF6AEGv3Wv+p1j2B-t22eeK+8rx-qrQHCGoXeV1-XPYp2Om7zg@mail.gmail.com>
 <20220311102709.225616cf@eldfell>
 <CADnq5_O1Qktec3kC_rcPZUQPbraBYmdhDwmj=jgp_QsaBFGUZw@mail.gmail.com>
 <20220314172647.223658d2@eldfell>
 <CADnq5_NsxipfFFXfRSXvVQin3e1gj0Q_p9p-shi3VZ2pSCwwfw@mail.gmail.com>
 <20220316104815.11ec2e6c@eldfell>
 <CADnq5_MbOLaZGaQ8fYW_ZL3+gssu3cq7QbzByOWdLuvbdfSAAg@mail.gmail.com>
 <CAF6AEGvoqJmXs0KxXGN4qKD4U6Yeo4gDq6sVxm=noY-TwFoj4w@mail.gmail.com>
 <5e246eb8-0256-c40e-40ea-d865bf99c003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e246eb8-0256-c40e-40ea-d865bf99c003@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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
Cc: Rob Clark <robdclark@chromium.org>, "Sharma,
 Shashank" <shashank.sharma@amd.com>,
 Amaranath Somalapuram <amaranath.somalapuram@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alexandar Deucher <alexander.deucher@amd.com>, Rob Clark <robdclark@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 08:03:27AM +0100, Christian König wrote:
> Am 16.03.22 um 16:36 schrieb Rob Clark:
> > [SNIP]
> > just one point of clarification.. in the msm and i915 case it is
> > purely for debugging and telemetry (ie. sending crash logs back to
> > distro for analysis if user has crash reporting enabled).. it isn't
> > used for triggering any action like killing app or compositor.
> 
> By the way, how does msm it's memory management for the devcoredumps?

GFP_NORECLAIM all the way. It's purely best effort.

Note that the fancy new plan for i915 discrete gpu is to only support gpu
crash dumps on non-recoverable gpu contexts, i.e. those that do not
continue to the next batch when something bad happens. This is what vk
wants and also what iris now uses (we do context recovery in userspace in
all cases), and non-recoverable contexts greatly simplify the crash dump
gather: Only thing you need to gather is the register state from hw
(before you reset it), all the batchbuffer bo and indirect state bo (in
i915 you can mark which bo to capture in the CS ioctl) can be captured in
a worker later on. Which for non-recoverable context is no issue, since
subsequent batchbuffers won't trample over any of these things.

And that way you can record the crashdump (or at least the big pieces like
all the indirect state stuff) with GFP_KERNEL.

msm probably gets it wrong since embedded drivers have much less shrinker
and generally no mmu notifiers going on :-)

> I mean it is strictly forbidden to allocate any memory in the GPU reset
> path.
> 
> > I would however *strongly* recommend devcoredump support in other GPU
> > drivers (i915's thing pre-dates devcoredump by a lot).. I've used it
> > to debug and fix a couple obscure issues that I was not able to
> > reproduce by myself.
> 
> Yes, completely agree as well.

+1

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
