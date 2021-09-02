Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9110AC83026
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 16:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C706108B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 16:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60C706108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4F56E7D3;
	Thu,  2 Sep 2021 16:58:06 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED4C6E3EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 16:58:03 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id r4so5150922ybp.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Sep 2021 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mPo7kSBxF2NMjbODsw6VV5fR1Wgl9LQdhHj7hVWwqFY=;
 b=guCzNX8M+/BNv5RUnag25d8CAlhMu7tEp6FSYtx9HQFKqjA3NjS9LuNEQlHwNygYog
 QBcTaL3PomAyQ3x00MmVQ2+FbHWL/JPfS8pAhGrm4+0hPo0UghEZwQxdq23rFbGdhfvZ
 E+wTmq3dwQhebfgyX6zEk7Y2tWiWFpnUUpK5L+q6LFoQcT3V8PDadOPNogH+WlGhNRsm
 Ho3ejxBw9ecNEIRqJPH5jMmEvL0TbLihz3MELarlZov9qkQnP/RAmVSmIK0xoeKgjnqT
 TESLO+aaP4c5HWv4SVna2uYpDh39fIWtC7SQkRZ1/UP1uIpO0gtl8QmfnCPi12ZwGjT1
 inKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mPo7kSBxF2NMjbODsw6VV5fR1Wgl9LQdhHj7hVWwqFY=;
 b=IBHFcsvnPGaU3/B5ff6eMZsowzJb04H4B6lOYwAU5E6vUL/6odqzQ4ETZyi8ouHZmg
 ekX5iDxLkhS9UhauqJkndssVgjaWQZ1qx3TME0k+AZqAK22/+fO01DrwC22nfoyy40iu
 82ySidV4VLgbOv/w4l78Gu8DRLxfGRuKb2iurpZN9Z2AcC5R84Ijd8OqqTWdY/9Nq9LY
 feYMfGhQY5xy9UE2rY8JMFSUgubLoN1XWBieIatBI92Hoj3cglMPsAMWv2+2wjwNhCzr
 0sMwoKP39ur7AQE8HWv5AyAv8cPL6A33tWDmAKzjIlnNCW3wxf3C/dQ7BtyO8Mfjjx+X
 3cYA==
X-Gm-Message-State: AOAM530Pf3sF8gUlP2Fz9hCNuQXfV8WQXwkfNp6Zug3yCOzASiSK2SZH
 34wkSp1VkGCCSgAJRhQeWGgViFsIF1S4mLF3aWFBuw==
X-Google-Smtp-Source: ABdhPJxp037KKgrTJN59O5wUm42z08mT8r+D1KDZSkntLAxAQJHiXMwqt+jVbufumiRBU6DkQLeUHcL1BKJR1lzZbOo=
X-Received: by 2002:a25:5b44:: with SMTP id p65mr5369975ybb.301.1630601882719; 
 Thu, 02 Sep 2021 09:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <BL1PR12MB526942160701B46D4B28EEEC84CD9@BL1PR12MB5269.namprd12.prod.outlook.com>
 <CAKMK7uHKX0rSVk_yBPo_KAEJ-UeLk5UxQ2kBdv+FD2j9zAjfZA@mail.gmail.com>
 <BL1PR12MB5269B303372A6251EDD1DC2C84CD9@BL1PR12MB5269.namprd12.prod.outlook.com>
 <CADnq5_PUvgt9Cv2L3G4GGBJv_WBhtOp8DN+3WMvoES_80UMKfQ@mail.gmail.com>
 <CAPM=9tz-66nXR8gbMucsBo5Q1VJ5AsrVZh4pF0r0WfFi7CQtzg@mail.gmail.com>
 <BL1PR12MB5269F6B279EDE278C8FDF90A84CE9@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5269F6B279EDE278C8FDF90A84CE9@BL1PR12MB5269.namprd12.prod.outlook.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 2 Sep 2021 17:57:51 +0100
Message-ID: <CAPj87rPS7ns5XaJDi2vvsnDr-gr1_9eWC6NLL0wjSaEWnr=pkg@mail.gmail.com>
Subject: Re: [diagnostic TDR mode patches] unify our solution
 opinions/suggestions in one thread
To: "Liu, Monk" <Monk.Liu@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, 
 DRI Development <dri-devel@lists.freedesktop.org>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

Hi Monk,

On Thu, 2 Sept 2021 at 06:52, Liu, Monk <Monk.Liu@amd.com> wrote:
> I didn't mean your changes on AMD driver need my personal approval or review ... and  I'm totally already get used that our driver is not 100% under control by AMDers,
> but supposedly any one from community (including you) who tend to change AMD's driver need at least to get approvement from someone in AMD, e.g.: AlexD or Christian, doesn't that reasonable?
> just like we need your approve if we try to modify DRM-sched, or need panfrost's approval if we need to change panfrost code ...
>
> by only CC AMD's engineers looks not quite properly, how do you know if your changes (on AMD code part) are conflicting with AMD's on-going internal features/refactoring or not ?

Looking at the patches in question, they were (at least mostly) CCed
both to the amd-gfx@ mailing list and also to ckoenig. Unfortunately
it is not possible for every single patch to get mandatory signoff
from every single stakeholder - e.g. if every AMD patch which touched
the scheduler required explicit approval from Etnaviv, Freedreno,
Lima, Panfrost, and V3D teams, it would become very difficult for AMD
to merge any code.

So the approach is that patches are sent for approval, they are CCed
to people who should be interested, and after some time with no
comments, they may be merged if it seems like a reasonable thing to
do.

The problem with internal work is that, well, it's internal. If the
community sends patches to amd-gfx@, there is no comment from AMD, and
then months later we are told that it should not have happened because
it conflicts with development that AMD has been doing - how should the
rest of the community have known about this? So unfortunately this is
the compromise: if you decide to do private development, not inform
anyone about your plans, and not join in any common discussion, then
it is your responsibility to deal with any changes or conflicts that
happen whilst you are developing privately.

The only way we can successfully have support in the same ecosystem
for AMD, Arm, Broadcom, Intel, NVIDIA, Qualcomm, and VeriSilicon, is
that we are all working together openly. If community development had
to stop because each of these vendors had been doing internal
development for several months without even informing the community of
their plans, any kind of shared development is clearly impossible.

Cheers,
Daniel
