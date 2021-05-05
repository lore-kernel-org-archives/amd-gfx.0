Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83950C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B34761106
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B34761106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89006E8D1;
	Wed,  5 May 2021 18:57:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989566E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620240999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZxmsf7X2drm+zu0JbMMDkHTJ3+oYC2HvD6+6uPXGfY=;
 b=ZkX3CRDWpWFlYR04nIVsu3aexXiqZYKmqzdafxETViyXc07j9uYto67GLxr1/bY92uWAyQ
 6da4z108XQ+EPrjxM9IBDltHoR4b8kQhu0tuiu4AJXJ6lc3jG0oBT3yJ8Z3wi7nvFGFhpd
 /AHdvUs4x23FYgSra3/ZKbbNpOngHVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-gOcp-uvMMb-su514lmtS7Q-1; Wed, 05 May 2021 14:56:35 -0400
X-MC-Unique: gOcp-uvMMb-su514lmtS7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8726D6D581;
 Wed,  5 May 2021 18:56:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 621A460875;
 Wed,  5 May 2021 18:56:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 145IuXGC032143; Wed, 5 May 2021 14:56:33 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 145IuX0A032139; Wed, 5 May 2021 14:56:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Wed, 5 May 2021 14:56:33 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: A hotplug bug in AMDGPU
In-Reply-To: <CADnq5_O7Mbodcoj3-NtVesQ00tH8jaAEG0vOoZx5NoDE37Cw6A@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2105051449350.31064@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2105031023580.29348@file01.intranet.prod.int.rdu2.redhat.com>
 <CADnq5_O7Mbodcoj3-NtVesQ00tH8jaAEG0vOoZx5NoDE37Cw6A@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mpatocka@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Wed, 05 May 2021 18:57:55 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On Mon, 3 May 2021, Alex Deucher wrote:

> On Mon, May 3, 2021 at 11:40 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Hi
> >
> > There's a bug with monitor hotplug starting with the kernel 5.7.
> >
> > I have Radeon RX 570. If I boot the system with the monitor unplugged and
> > then plug the monitor via DVI, the kernel 5.6 and below will properly
> > initialized graphics; the kernels 5.7+ will not initialize it - and the
> > monitor reports no signal.
> >
> > I bisected the issue and it is caused by the patch
> > 4fdda2e66de0b7d37aa27af3c1bbe25ecb2d5408 ("drm/amdgpu/runpm: enable runpm
> > on baco capable VI+ asics")
> >
> > When I remove the code that sets adev->runpm on the kernel 5.12, monitor
> > hotplug works correctly.
> 
> This isn't really a hotplug bug per se.  That patch enabled runtime
> power management which powered down the GPU completely to save power.
> Unfortunately when it's powered down, hotplug interrupts won't work
> because the entire GPU is powered off.  Disabling runtime pm will
> allow hotplug interrupts to work, but will cause the GPU to burn a lot
> more power.

I measured it and it saves 15W. Hard to say if it's worth to pay this for 
the hotplug capability or not.

I can re-activate the card by logging in and typing "rmmod amdgpu;modprobe 
amdgpu". But what should less technically savvy users do?

> I'm not sure what the best solution is.  You can manually
> wake the card via sysfs (either via the runtime pm controls in
> /sys/class/drm/card0/device/power or by reading a sensor on the board
> like temperature) then hotplut the monitor or via a direct request to
> probe the displays via the display server.
> 
> Alex

Mikulas

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
