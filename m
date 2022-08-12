Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03636C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 19:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5D9B1BBE;
	Fri, 12 Aug 2022 19:50:19 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F6FB1AD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 19:50:12 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id gk3so3676044ejb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=2HOhUr3agxm8Z8G8CQwB+MNDpKU3sFf884ff4QdMPbo=;
 b=qQb/kvQ9scNrZOBwijwuscIDbeJyrp3ma3lWs4boYduvy6UKUXR5MhhEiSdmn9txhI
 l7bZnpyJy7sozkwX1UDSNIfMhV/v9VoMnDhS7Defe8ajCGYI49wHv5Sf/yp+bD0ouXOi
 MYQg2zhEkHnY8aqjDwpzaUT46Yke3Hx7mBcIKe/EXFN/LhiIrU3cD5ke9FZLDc3fzsv0
 q8VMPwBw2rVIrjtDTnlnWUqitLecbWPxEfJXM38QNP4kZBCd67XyxlhtDNPpnxjw4VQe
 mYw1H1VEQuU+qDN1oPKx3zPEIklXz4HD0POUFFQJEpd2nV62FgQVup/A3RaI/T/eSFgV
 i4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=2HOhUr3agxm8Z8G8CQwB+MNDpKU3sFf884ff4QdMPbo=;
 b=KstdWiq72oAsvl19NY4JX5dTiV4ZqgXEpW+XJlVn+Jvz7R+45ani2K8B817WvwZrwA
 dWdEIUupadm5GTQmPiPW0P8YXRJouHahXulCoWVUOrvtWVq5bQAia2YZ7tFm8iD33hZq
 N6l8aPSAH7ANZDyiRUAmkIH7IhcvXQzfjQcy4WRPEh6pgNbuTmCf/h4LpO2ZmrA8mbnw
 02J0UFtjuqRMZB+El3a7vEOz1/jtsAHdrrmWNv+vY8MyjsVJd4qsT2ziqk3ukmaa6Wrn
 NPvw7+kjosbxgesVH+b+6Dy4nlzuqXJqoBCDK4SbSBc8b3m3I0t6ll0T9iryVWV9ppmD
 pVWA==
X-Gm-Message-State: ACgBeo1QYYryBu2EjBrUINhO3eyni6eiJ3/rkdGn7KZQTnJoVKHhBNP2
 3AIWEqzIZQC0fVC+Op1RCWpzf5YoEr+H3hmrJId04usm69E=
X-Google-Smtp-Source: AA6agR66X27Bf7uyrM2sf1gBqDSerXa5ksdqFj7vGSR9fPaVdLl7HKbRW89gJTUIE0OD6MwiL4esWqO3Uyrtoi3+D5k=
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr3504593ejc.161.1660333810822; Fri, 12
 Aug 2022 12:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220810234109.935228-1-Felix.Kuehling@amd.com>
 <20220811190433.1213179-1-Felix.Kuehling@amd.com>
 <da05c04a-c484-e2a0-8019-27f415f0a726@amd.com>
 <0d45fb6d-800b-8291-1726-be83ef1af044@amd.com>
In-Reply-To: <0d45fb6d-800b-8291-1726-be83ef1af044@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 13 Aug 2022 05:49:59 +1000
Message-ID: <CAPM=9txOupxRUY5Qko7Ex9KxktRXK0wvrqycURpX-L=7O+8hGg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: Try to schedule bottom half on same core
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: nicholas.curtis@amd.com, Philip Yang <yangp@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, 13 Aug 2022 at 04:11, Felix Kuehling <felix.kuehling@amd.com> wrote:
>
>
> On 2022-08-12 09:55, Philip Yang wrote:
> >
> > On 2022-08-11 15:04, Felix Kuehling wrote:
> >> On systems that support SMT (hyperthreading) schedule the bottom half of
> >> the KFD interrupt handler on the same core. This makes it possible to
> >> reserve a core for interrupt handling and have the bottom half run on
> >> that same core.
> >>
> >> On systems without SMT, pick another core in the same NUMA node, as
> >> before.
> >>
> >> Use for_each_cpu_wrap instead of open-coding it.
> >>
> >> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >
> > nit-pick below, looks better to use new_cpu as iterator, either way
> > this is
> >
> > Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>
> Thank you. I think I prefer cpu as the iterator and new_cpu as the
> variable that holds the CPU we choose to schedule to.

I don't think this sort of thing should be in a driver.

queue_work_node seems like it should be used or enhanced. Doing this
sort of thing in driver code should be the last place to do it.

At least please task someone to work on an upstream answer to this
sort of hacky downstream thing.

Dave.
