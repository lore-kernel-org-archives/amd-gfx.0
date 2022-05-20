Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC0CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 07:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D923111B76C;
	Fri, 20 May 2022 07:52:13 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF6C11B76C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 07:52:13 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id i17so6726777pla.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=5vIeqJ2l7ohbADo6n14qY+TAL6tqjFMC+/vvZ+WHJvA=;
 b=QbMBFcQM9qRP+Zt3g3VsB3vTZOpvKm6co4eXrI0mMajeM60kX9QU+FH98IFoV4NfxD
 oRl0QjfFPBhMbU2V8gl/4x95UfmTyCaYSwq6U9PgyvQxVsCf4tzMbl9WOdYQJHo1qPcw
 6lH+gvtR04sra0+Q4UwHEm6eSKsJKD0RHgLwSU1VIh8K98sH+Sm7Mg/PNk0OO11VygyX
 I/a5DQemxJjUDN9jnRlMyQ8E7Aow7y1AnyqI8UyDT5KbsOWrir/uPpHFcx9LoIWiF5Db
 SOd6VQmpcmW7+w065G+ZrR4LNhyHz0SY/j1URG/gcgJOLrnFH8do/XBfJ2zzmXfgnAW9
 6vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=5vIeqJ2l7ohbADo6n14qY+TAL6tqjFMC+/vvZ+WHJvA=;
 b=KcIeH/q/jzbkNRXlhvsz0U51+uUFxG6exfV6EoX6Gvcw8VvII78wQRV9sY9sRUj9HA
 nGt4mDNeX+lTHFjLYdLzxxkw5771w5Pmec3gd2hDCIN+8nlyqtVrdvclxJOz6IbymrdO
 zAEgPX+svdcNb77ZIgkh7lzkaB3eE3my24Sxvgs2NBC+mF8OtHUbOI0x/Egl2rINsT+2
 ZG/K21fUPuWuXIItLV2k23kcQ3YnoCPpXgbvbS51HUtncglkxdQjefI2wfZKJ9ZBYKgn
 sh2AMHQYzSwgNL9ZFE9nNCAyGpCObgEr3nTLRVylUAYOkK/ZNKODGztapeLYJ9A8+Qzj
 DuLQ==
X-Gm-Message-State: AOAM533HHiG2EeA34x8fruNLxKOridsfKvWLe7oPRywwAfAwL0w6YA0i
 6lp3sgB7Uai3NboKcwwMrvc=
X-Google-Smtp-Source: ABdhPJz2uw+P0c+QcAEevcQomiSCOXCL0p/z1jWLOWE65LWBQt5+YLv0FiSxkyiQpvuR3U6l2l8jRw==
X-Received: by 2002:a17:90b:1e4f:b0:1dc:847d:38b5 with SMTP id
 pi15-20020a17090b1e4f00b001dc847d38b5mr10177098pjb.3.1653033132554; 
 Fri, 20 May 2022 00:52:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902c1d100b0015e8d4eb243sm4943881plc.141.2022.05.20.00.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 00:52:12 -0700 (PDT)
Date: Thu, 19 May 2022 21:52:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Message-ID: <YodIquufXzK581gw@slm.duckdns.org>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 20, 2022 at 08:22:39AM +0200, Christian König wrote:
> Am 20.05.22 um 02:47 schrieb Lai Jiangshan:
> > On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> > > See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, specifically patch
> > > 'drm/amdgpu: Switch to delayed work from work_struct.
> > > 
> > > I will just reiterate here -
> > > 
> > > We need to be able to do non blocking cancel pending reset works
> > > from within GPU reset. Currently kernel API allows this only
> > > for delayed_work and not for work_struct.
> > > 
> > I'm OK with the change.
> > 
> > With an updated changelog:
> > 
> > Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>
> 
> Good morning guys,
> 
> for the patch itself Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> And just for the record: We plan to push this upstream through the drm
> branches, if anybody has any objections to that please speak up.

Andrey, care to resend with updated description?

Thanks.

-- 
tejun
