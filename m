Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A7EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 04:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D844210E021;
	Thu, 17 Nov 2022 04:57:25 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64F810E52E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 04:28:07 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id l14so1483358wrw.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=am1pqej90LN9oUfPY/QamDYoHeiS9DBo2YTNmvO0b9g=;
 b=HC8Kanw+P8hs6VYc3PycEHdaThpTn+ehJM2GlPIEZPfi+W7h+ASgO7GM8w6kLy2bxI
 wGZDAMRHgLDJk0M9FIyjbBJ/OjcEoo6jD4hrvYiIjxKWzzDYf6of2gRdixlC1DqEcbJ/
 DgVWBqjnXmtgNd4Hfx3h0DE6GNNePXvg+vYnK29EgC2kRaIRe2irszREPFe+VZjfZmVu
 sruZjS0rh46F3bDGfJUarxtyV+G3KqHtuMcYgA/HhJaHAky6MqRZff8gWkdpohgUCWZV
 60l6VHeTBt+tgVw/3ENzFrcf+h0/P3XYPFXFvCiBj0b33h8mg5a1+cUxJTnzJWuRJb3W
 ZpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=am1pqej90LN9oUfPY/QamDYoHeiS9DBo2YTNmvO0b9g=;
 b=M1KZdSlbvL9ig5DMnnRCPhmASN5s7/kSB0WDWmoQsGyoNnohVvqUpkPIYAGlXAETOq
 l6pHN+sopFjCkRahWx9wtda2+rB8tNQXy/SZrQGCHD/XxLBjxQHjXuQ3hBMNwkNLPib/
 ZiD255E7bzt5nA7goqNyzafDfdmGcItT0x+iuCJUBEHil3oT85PaN9BMojXZQJbYjNns
 indiky4JrPzGpGjlltgrAFUE59DzBjBW6daf303/d1k8IX/LJLqlX4yM0kfRTMCFVxhv
 2F47GjMBFu+d99Q9eCN0vdU9Q431LnNlQkFXXYASMXSbyMCjPkul/3SPz8pfH8AHiAaZ
 UwFg==
X-Gm-Message-State: ANoB5pm4pL3/GeGWqRyrVv5aHBK7pkh6IZWkyZKjdqzCUdzPX2rH78cZ
 jEUtMMu4hlhIeb0svxvZTyk=
X-Google-Smtp-Source: AA0mqf66hYYs9t3KKlr2fxAbVFzMVvD9zPX7z9FyyAKQv4/nSSzvaJnHJdd87MJ57cFkGT8QK7MoxQ==
X-Received: by 2002:a05:6000:1e0f:b0:238:3d2a:cd12 with SMTP id
 bj15-20020a0560001e0f00b002383d2acd12mr310027wrb.172.1668659286279; 
 Wed, 16 Nov 2022 20:28:06 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 n7-20020adffe07000000b002366f9bd717sm19909773wrr.45.2022.11.16.20.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 20:28:05 -0800 (PST)
Date: Thu, 17 Nov 2022 07:28:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Release the topology_lock in error case
Message-ID: <Y3W4UhsDA9oL6W8o@kadam>
References: <20221116080415.593223-1-Jun.Ma2@amd.com>
 <13c82533-6cb1-2bcb-405c-f81123807fcb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c82533-6cb1-2bcb-405c-f81123807fcb@amd.com>
X-Mailman-Approved-At: Thu, 17 Nov 2022 04:57:21 +0000
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
Cc: Ma Jun <Jun.Ma2@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 guchun.chen@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 16, 2022 at 03:49:18PM -0500, Felix Kuehling wrote:
> Am 2022-11-16 um 03:04 schrieb Ma Jun:
> > Release the topology_lock in error case
> > 
> > Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> Dan, did you change your email address, is this one correct?
> 

Yep.

I'm still around doing Smatch stuff though:
https://lore.kernel.org/all/Y1qf7w%2Fjo8FH5I8G@kadam/

regards,
dan carpenter

