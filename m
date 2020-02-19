Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1618AC34056
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 18:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB85A24670
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rYeKImtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB85A24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E176EC71;
	Wed, 19 Feb 2020 18:40:13 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA526EC72
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 18:38:44 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id i23so962991qtr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8Doxcme7+jrZwJS6ST/rzTNwpMBSbirxVwxv1qEdw5s=;
 b=rYeKImttZI7x6bzjER2czevU8xhzoiO0fHOwBWL2BT4hsGECSGmyqPgoGTV4CucsBZ
 uTnJoXNwR7UAglw3UPw1NxLU5ddpTksdSVtT5QjXF1AnurYfoBBc8IdvY2YodtGt8z0M
 QacjY8wuodiTGBs0IVVATW2YMRzBMkLiyZHVjGvvF9BNoW9pjzl8ft6Qnc6yAvcSuxDs
 UzhfJPLoXJgkQP5KuxvV/2RNezt7UtdUOKjQ2fR59CK2Jo345MJFsX4yD2NmH1oVRyhb
 ArUtmfikqkqsHkSnUBKIK5mbtPTvuTR16p7k9MSKdETJT+ebL/CRLYK+ZgbmmphjUcH0
 eXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8Doxcme7+jrZwJS6ST/rzTNwpMBSbirxVwxv1qEdw5s=;
 b=bbhLcbW9nDePdgxzZGvHsX41YjaM3Pcg+tFJVHIRs1v4NUr3S8jLrNQu98tY4wc/1X
 tm7eOJ8gXyNQwbiwXmY+VjWm3vWQd8G5/9p4O4DDFY0PHUS4Juq2oplx9wGKQPiXM7wP
 Eq555CJMPjClcBI1xZuzRcABw719ELTgAbFig8ZmIUFC4Buvn7ZBM5mzO/jPWEnG4hSb
 y1aiuAGM8JIgsuvyYcEFu63X+jVyGEDlvIvG0exp5T4RisAh9NKb4FGMrOtmMt3k8vbz
 1GMmPYXs1/lW4GIVyXgvyUV/MbjT8t0ObGbqYslaGh/97R5zKPy1WBz6BVCRuxBpNrT/
 pkRQ==
X-Gm-Message-State: APjAAAUEJFt4ZEjSs+KcSNaN/2urOGwTVANE9Ep0k4+H3VkmFSBmXvTp
 qrEMNodd207W6rONAsjpIfPO+A==
X-Google-Smtp-Source: APXvYqzKQY+wCwO5dOV01Ah7jfljGDG/Ul5zVw7kKLgCnfZrY8hsRus06+mtT0cEH4YRMtnIpYneFg==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr22890647qtg.314.1582137523279; 
 Wed, 19 Feb 2020 10:38:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
 by smtp.gmail.com with ESMTPSA id z1sm402480qtq.69.2020.02.19.10.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 10:38:41 -0800 (PST)
Date: Wed, 19 Feb 2020 13:38:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
Message-ID: <20200219183841.GA54486@cmpxchg.org>
References: <20200214155650.21203-1-Kenny.Ho@amd.com>
 <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local>
 <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com>
 <20200219161850.GB13406@cmpxchg.org>
 <CAOWid-e=7V4TUqK_h5Gs9dUXqH-Vgr-Go8c1dCkMux98Vdd1sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-e=7V4TUqK_h5Gs9dUXqH-Vgr-Go8c1dCkMux98Vdd1sQ@mail.gmail.com>
X-Mailman-Approved-At: Wed, 19 Feb 2020 18:40:12 +0000
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
Cc: juan.zuniga-anaya@amd.com, Daniel Vetter <daniel@ffwll.ch>,
 Kenny Ho <Kenny.Ho@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 jsparks@cray.com, nirmoy.das@amd.com,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 lkaplan@cray.com, Alex Deucher <alexander.deucher@amd.com>, "Greathouse,
 Joseph" <joseph.greathouse@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 damon.mcdougall@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 19, 2020 at 11:28:48AM -0500, Kenny Ho wrote:
> On Wed, Feb 19, 2020 at 11:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Yes, I'd go with absolute units when it comes to memory, because it's
> > not a renewable resource like CPU and IO, and so we do have cliff
> > behavior around the edge where you transition from ok to not-enough.
> >
> > memory.low is a bit in flux right now, so if anything is unclear
> > around its semantics, please feel free to reach out.
> 
> I am not familiar with the discussion, would you point me to a
> relevant thread please?

Here is a cleanup patch, not yet merged, that documents the exact
semantics and behavioral considerations:

https://lore.kernel.org/linux-mm/20191213192158.188939-3-hannes@cmpxchg.org/

But the high-level idea is this: you assign each cgroup or cgroup
subtree a chunk of the resource that it's guaranteed to be able to
consume. It *can* consume beyond that threshold if available, but that
overage may get reclaimed again if somebody else needs it instead.

This allows you to do a ballpark distribution of the resource between
different workloads, while the kernel retains the ability to optimize
allocation of spare resources - because in practice, workload demand
varies over time, workloads disappear and new ones start up etc.

> In addition, is there some kind of order of preference for
> implementing low vs high vs max?

If you implement only one allocation model, the preference would be on
memory.low. Limits are rigid and per definition waste resources, so in
practice we're moving away from them.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
