Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD6C34055
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 16:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5282465D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 16:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Y0xUdyvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5282465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878C96EC4F;
	Wed, 19 Feb 2020 16:23:03 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44AE06E82C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 16:21:28 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id h4so668248qkm.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1IjE5f3DRWrL7DyNrD/EPrz9NqvpJo1LzwPmSu0Loyo=;
 b=Y0xUdyvI/KOwgnUyUAXVRQts2j2UDpi0MSoQ8O0ZIpFCbCbLaplKvU5pIrb49CIcHK
 Oko/yr/AtoCn2I7wP1Yz/l85vKpPmPYS2VLT7dy7v+KArYcmNL6mvY79eopcTfkaMHlR
 6ad0zsqSYvukfQwQMDKXW3o2M1y+7ZLCHho3eH9+XHp9GDKhBElQTtLcwPW1OzZqDG+o
 ey+6JO61zvRaKvwJ1VNS2Jvb4aETsOQDmV7IiKJxQwWThbSwQ3VPR/0SGwTsSc5081+r
 p4IwL9I721gfQnwgUof/i3OQS3UBN6v3KV2bdrPVFgNPBL/Fy8ditUJoByLUoc/wDrIn
 VXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1IjE5f3DRWrL7DyNrD/EPrz9NqvpJo1LzwPmSu0Loyo=;
 b=UgT9GLvvnri8c6UfwRLMYpbuntE5weTeGD/9LPdUJOBsDPtdaEBh8QniTpRhFX+Neq
 soGxp7k4B536/BMMz7gdODa3PRaJNxSndrGMQqj4Po7RlOSXXVY9FBiboyhQ0vo7bU1z
 e6mI8rAGofGwN662SbcFlixXNpFbTqaPsBUsP7liN0wS5ndAGOBKrBCAPAycZ3Whu+zP
 fB+GwWjEFRsTro0w7QUfh+QA4xB3ovQg/FEIIPiCU6XVxuphq5j0+ZrQ9Ua+NuWQOQAw
 sanNhSSibFhgM7l0tpo75/rAK5GhfXhU2VFO2ZFweBvbxQ8iW8+kPXpG9qbvT+B0ZSq4
 CpGw==
X-Gm-Message-State: APjAAAVk5meZqx1I8jJwZM8VDhjA4h+ZexxOwli7YoRKKrTJUxN4l3y2
 xdBPFvh1LV/pjUZKt9c3L7rZaA==
X-Google-Smtp-Source: APXvYqx3pDhfMLHjqJZav0TSJad25iHzflnIoh0HNoBZKgS2hYkzGuQm5PMiuKy/xxFf6JF9qCXKSw==
X-Received: by 2002:ae9:ed41:: with SMTP id c62mr23816689qkg.403.1582129287358; 
 Wed, 19 Feb 2020 08:21:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
 by smtp.gmail.com with ESMTPSA id n4sm210781qti.55.2020.02.19.08.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:21:26 -0800 (PST)
Date: Wed, 19 Feb 2020 11:21:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
Message-ID: <20200219162125.GC13406@cmpxchg.org>
References: <20200214155650.21203-1-Kenny.Ho@amd.com>
 <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local>
 <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com>
 <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
X-Mailman-Approved-At: Wed, 19 Feb 2020 16:23:01 +0000
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

On Fri, Feb 14, 2020 at 03:28:40PM -0500, Kenny Ho wrote:
> On Fri, Feb 14, 2020 at 2:17 PM Tejun Heo <tj@kernel.org> wrote:
> > Also, a rather trivial high level question. Is drm a good controller
> > name given that other controller names are like cpu, memory, io?
> 
> There was a discussion about naming early in the RFC (I believe
> RFCv2), the consensuses then was to use drmcg to align with the drm
> subsystem.  I have no problem renaming it to gpucg  or something
> similar if that is the last thing that's blocking acceptance.  For
> now, I would like to get some clarity on the implementation before
> having more code churn.

As far as precedence goes, we named the other controllers after the
resources they control rather than the subsystem: cpu instead of
scheduler, memory instead of mm, io instead of block layer etc.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
