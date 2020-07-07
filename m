Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C43C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 05:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893DE20702
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 05:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JjYvUZBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893DE20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC616E506;
	Tue,  7 Jul 2020 05:50:18 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5846E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 05:50:17 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id s10so43736970wrw.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2020 22:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=tWwPNUXAhZkGALSmCM6I62dir2ac7KtA6PfPQYUz4tM=;
 b=JjYvUZBaLJxTV/BcuvHN0yhsBodhFnLNMtn6S42f4eG11n/5e/oCblJoIIBUpfysyf
 Vgw3xlD1GHvhj9g1ql1pmPUfwN4tqKoAj4Pvpq1pZ2urqQ5fkXpiqvs54MSWagyQKwiA
 n6No1KSVjXYrja6mPtGqEkYkUS2sD4sKfSn3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=tWwPNUXAhZkGALSmCM6I62dir2ac7KtA6PfPQYUz4tM=;
 b=qU8xqCytQeZZkwlMGoFDnrb8QKUFGg9RHdMOZWq2LZhY8ma4V8286riTJgbAjHXLqx
 15fn9dGzAOOADrrf+aRxbsMAH2y42Dp1a+J4XntUcVqjHMdhcK499P30ofsouflIWKh1
 LFFXh8uhwcEwVpGVlUxy04JZ9qFjd2GRwk6ByqoDDVk5IgUvIprprfE2aCse+p4XbLA/
 We9uDtwohHq/xykQgcrbNOvl+94KRQkBxCdjT4RbcFj8p5n69T9k0xslQINhigBlt/N4
 vjXHOwWwlEZY1uQGSG1g9d8I+kawESpvakz7G7if5KhYMd8xofiZd4ReQPl0bowrGBnB
 KLgw==
X-Gm-Message-State: AOAM531RdTe3UQM7d//53Fv3xPwbKMIOCdRaxZ/WzLn2EctxJYxndSfn
 eohX+cl6/Uvnx3X1vTSrJ6WMqQ==
X-Google-Smtp-Source: ABdhPJxzb1aGKqJ4jxtL9PIFyXbRUO2dBkb0GWe1iZ9+xLYdWRBle+zVIIjxFlCnANQHnCq+1iMaNw==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr51255032wrq.319.1594101016305; 
 Mon, 06 Jul 2020 22:50:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k185sm1883352wmk.47.2020.07.06.22.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 22:50:15 -0700 (PDT)
Date: Tue, 7 Jul 2020 07:50:13 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [Proposal] drm: amd: Convert logging to drm_* functions with
 drm_device parameter
Message-ID: <20200707055013.GG3278063@phenom.ffwll.local>
Mail-Followup-To: Suraj Upadhyay <usuraj35@gmail.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20200706105138.GA10722@blackclown>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706105138.GA10722@blackclown>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 06, 2020 at 04:21:38PM +0530, Suraj Upadhyay wrote:
> Hii Maintainers,
> 	I recently came across this list of janatorial tasks
> for starters on DRM subsystem [1]. One of the tasks is replacing
> conventional dmesg macros (like dev_info(), dev_warn() and dev_err())
> with DRM dmesg macros [2]. And I need your input whether the
> conversions to DRM dmesg macros are worth it or not.
> I would like to start working on this task if this needs the change.

For any core code I'm happy to merge such patches. If you're changing a
specific driver (all the subdirectories under drivers/gpu/drm/*) then
please ping the specific driver maintainer first. They should be all
listed in the MAINTAINERS file.

Cheers, Daniel

> 
> Thank you,
> Suraj Upadhyay.
> 
> [1] https://dri.freedesktop.org/docs/drm/gpu/todo.html.
> [2] https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-paramater
> 



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
