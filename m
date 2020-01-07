Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE6C33C8C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 15:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFC72081E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VcnYI9Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFC72081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FD36E0EB;
	Tue,  7 Jan 2020 15:48:00 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE626E0EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 15:47:59 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b6so54551804wrq.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 07:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=AKH9iM1/iG8zWx2xNV+zLPV8iovcpOyyXJoSIxqdbRk=;
 b=VcnYI9AkDcSpvZxqfakPF0VUIvVs6cdZjxpLiY4QgG7rkRNj1VtVjcVLvPw+ALUCoo
 gzKrXcOFdzaWRY7NS4FOUS6Sk3iQfoxdSNFA/KyV+fKOHLMQUaEIUttgA/eyGEqPGN4E
 ONMSnAN3TjRTrvBXa+e9K9twu69SAs/P43wss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=AKH9iM1/iG8zWx2xNV+zLPV8iovcpOyyXJoSIxqdbRk=;
 b=qlCFc2Mm8LWHGRzB0FCb8CNNdFJIkuFO4/OjamfP0y6CfIXamuOD7rhl5Nt+SgTozQ
 t0j23grwHO+2LjN94UWfrdStLVYRUZsyL/6tfaiMEx8ODdzLXl/O7baEQQCf3NRDvvNj
 n0dsiUpEmtJZfzebvbb2BgOB/61w6Oynql9kWeCE5llpyk/eR6I0xHe2ZrpuCp0QqCpk
 Hk5zE722OQ3ZGt9vk0zygVZmbyh97AQMOlytIxDOWa8mRnKymA9yKyTjp0kwa+3Ke53g
 6qecKrZvA620cHjz/1Q5Dl2SiJo6giSC3kg8QJoU6nyqFL9tGyQxeQe+K/i7JrY8RR8x
 +E3g==
X-Gm-Message-State: APjAAAWjVkkj2ZVQrL+ox+1GNwCxEW07CYPF/HcIxeweqIZw8uoJvdAT
 TVKxCBOWBU6u/dirUDPrW2pTmQ==
X-Google-Smtp-Source: APXvYqzD68uooO7ZcoDZN1tshuC4uGYDnvSgRZJxqX3p24va63g3pm/AWE8wq12cU/IU5J8Nos3Kbw==
X-Received: by 2002:adf:f10a:: with SMTP id
 r10mr109349448wro.202.1578412078158; 
 Tue, 07 Jan 2020 07:47:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
 by smtp.gmail.com with ESMTPSA id z187sm39236wme.16.2020.01.07.07.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 07:47:57 -0800 (PST)
Date: Tue, 7 Jan 2020 16:47:55 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>
Subject: Re: INFO: task hung in fb_release
Message-ID: <20200107154755.GB43062@phenom.ffwll.local>
Mail-Followup-To: syzbot
 <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>, 
 Rex.Zhu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, b.zolnierkie@samsung.com,
 christian.koenig@amd.com, david1.zhou@amd.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 sam@ravnborg.org, syzkaller-bugs@googlegroups.com
References: <00000000000082b80f059a56da1f@google.com>
 <0000000000002074ef059a5c86e2@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0000000000002074ef059a5c86e2@google.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: david1.zhou@amd.com, linux-fbdev@vger.kernel.org, sam@ravnborg.org,
 b.zolnierkie@samsung.com, airlied@linux.ie, daniel.vetter@ffwll.ch,
 maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, syzkaller-bugs@googlegroups.com,
 dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, Rex.Zhu@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 23, 2019 at 02:31:01AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit e3933f26b657c341055443103bad331f4537b113
> Author: Rex Zhu <Rex.Zhu@amd.com>
> Date:   Tue Jan 16 10:35:15 2018 +0000
> 
>     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs

Pretty sure you don't even have that driver loaded ... from the config:

# CONFIG_DRM_AMDGPU is not set

:-)

Cheers, Daniel
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e00000
> start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.o..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7f6119e2e3675a73
> dashboard link: https://syzkaller.appspot.com/bug?extid=d130c4a0890561cfac5b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000
> 
> Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
> Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage
> support in sysfs")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
