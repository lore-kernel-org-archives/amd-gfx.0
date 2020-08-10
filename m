Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EAFC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 13:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5762073A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 13:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qu5Z8lGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5762073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73706E41D;
	Mon, 10 Aug 2020 13:09:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895FC6E421
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 13:09:39 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r4so8103559wrx.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=WCd8JfYnpGOr7a2xpvj2kbmZwGcXBNT1BUusT+gdxIU=;
 b=Qu5Z8lGA7FeP8PipQ1E+cOwghahRzt5jmC00kHl/Z1PU/ibPQqv0bevmvrI3yFrUqF
 6cKDrQjtQDLWNNc99k/xaqL1Toh0Mz1pTuG+V4mPcaAaMiMohvypZcXKp2ebwlNg8z/n
 mvGQH3eCD8S1QMhHnroEuH5YseIYmX/oDXP1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WCd8JfYnpGOr7a2xpvj2kbmZwGcXBNT1BUusT+gdxIU=;
 b=dLib8iyoRG8YvmFWOmFGdV+bUcYHrI5OsI/d2iMsqIYhNTrTqJ5Hjz6IxKv4o70NkG
 qANIb//7A1ujpAxxsZil8fEAhWSXfMADFuQcJhGbh+ZGN5ypHplTmIGwMnFXrDP4tf54
 lxreYQjyH25L/sbMoVBTsyJsujDq7q/l5lTQQDl0GkvCwStrYkSmJZWxjJZnpAhpy9Zr
 vAKdZSXKSOvYntABf+Tp/ZayED7XJL5PrHJMwS82k6aFaI8RLlH5cN0PvdntgbP1QlSc
 VXAfyzZml3sTrLL8SDUlFkhhUU5UjCooHlEHfikaGzQyjHwWJRDom7NXezaCxVTYHpvL
 rB4Q==
X-Gm-Message-State: AOAM530Ttpf0eeXxobAxjjxsR0ITlkTVNV58vuahq+2ahAQp2vxVTTiR
 goWIb5IyxQX6hdCuSpGNSFtSKA==
X-Google-Smtp-Source: ABdhPJziqf7H7RmGy3QDYZryYvT8kabmd0yeXzuL6LaNkjIUfLJEoIc1XTJvaM4epVx+0ca0xkZBjg==
X-Received: by 2002:adf:e90f:: with SMTP id f15mr1482568wrm.18.1597064978127; 
 Mon, 10 Aug 2020 06:09:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 68sm21310539wra.39.2020.08.10.06.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 06:09:36 -0700 (PDT)
Date: Mon, 10 Aug 2020 15:09:35 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 6/8] drm/amd/display: Set DC options from modifiers.
Message-ID: <20200810130935.GT2352366@phenom.ffwll.local>
References: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
 <20200804213119.25091-7-bas@basnieuwenhuizen.nl>
 <20200805073210.GU6419@phenom.ffwll.local>
 <20200810122820.GJ2352366@phenom.ffwll.local>
 <49e200cd-3df6-8a11-34f4-d1342a79f75e@daenzer.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49e200cd-3df6-8a11-34f4-d1342a79f75e@daenzer.net>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: maraeo@gmail.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 daniel@fooishbar.org, harry.wentland@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 10, 2020 at 02:49:00PM +0200, Michel D=E4nzer wrote:
> On 2020-08-10 2:28 p.m., Daniel Vetter wrote:
> >
> > Ok just learned that amdgpu hat set/get_tiling, so I'm upgrading my idea
> > here to a very strong recommendation, i.e. please do this except if
> > there's and amd ddx which somehow wants to change tiling mode while a fb
> > exists, and expects this to propagate.
> > =

> > In i915 we even disallow the set_tiling ioctl with an error if an fb
> > exists, just to make sure userspace behaves. Even if userspace uses
> > set_tiling, this way we can at least enforce the same semantics of "cli=
ent
> > can't pull compositor over the table with a set_tiling at the wrong tim=
e"
> > of modifiers.
> =

> FWIW, xf86-video-amdgpu doesn't have any code to set the tiling
> metadata, only Mesa and presumably AMD's Vulkan/OpenGL UMDs do.

Ah right you do everything with glamour, so this should never show up as a
problem.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
