Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5CC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 11:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086AB206F9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 11:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FNX2D5zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086AB206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AACBB6E432;
	Mon, 11 May 2020 11:03:35 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618956E432
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 11:03:34 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id h17so1491656wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f2UAiave+4C0yzTk4hyjUeeMrVJ2ok20QkX6BTAWcnk=;
 b=FNX2D5zWVGnnBlmc4Oo0SzmBoJG611Ho8o7b87QXAyfZdfSuYWU/wq7wd9PknSvltY
 Vq2E+4yJMSO/cloGGg1r1jR5dxTK77Vh1Cp5AREOzxPAUQjTMTzbqk9q8VyAYkoZg/2D
 SY0WWHLHI7pUiZM7b7UQSIfUnkj8hLT5HtVGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f2UAiave+4C0yzTk4hyjUeeMrVJ2ok20QkX6BTAWcnk=;
 b=njiZqbKpt7MdgbzMNOCdgxKQ31t5at2kp9K1G0IFM9xdUGMDsST56jY/Z2EWqsAkkZ
 s+aYfZzD0DwX1/AMGa8jcIqNCuef0l5nptRbompVaQwQ4MOx8Zf9zKTl70SweL4hm+Aw
 qK8hWCAYH2x0kzG9OJIRH3Ar4XOZlOyu6/9STn4bn4AlIHXivcmbVBP0F5MG+v3VEf7p
 l+NjSNkM7WRqP+69s1s/FBT+sTNcQxh4tuW6jxjBJsmIejqdLsvq0TOWUw8FoLUy7lBq
 SeIh7o3S+RHcafso33OX/DcZCxftjmVrBcDgCw4to1KQBRQ5uC9KqKs0wOVWR1B4niNS
 70og==
X-Gm-Message-State: AGi0PubIYVn92rBpdIV2t6uUy7855nDhypnnH6O4dOs3bm2ZoGDqMAZa
 aj/W29tHZRlIAVv7HEtIBPkZhw==
X-Google-Smtp-Source: APiQypIU/wmV9sEfNkXiGps5GelhOeqDK0bu+lOqF9lumObpKw9FBzEdzOfKsYbcqcNn+7ummTLhPg==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr19154145wrq.280.1589195013059; 
 Mon, 11 May 2020 04:03:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g184sm11633864wmg.1.2020.05.11.04.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 04:03:31 -0700 (PDT)
Date: Mon, 11 May 2020 13:03:29 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 0/6] RFC Support hot device unplug in amdgpu
Message-ID: <20200511110329.GC206103@phenom.ffwll.local>
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <20200511095433.GA206103@phenom.ffwll.local>
 <158919237000.1729.13151635793333034320@build.alporthouse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <158919237000.1729.13151635793333034320@build.alporthouse.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, daniel.vetter@ffwll.ch,
 michel@daenzer.net, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 11, 2020 at 11:19:30AM +0100, Chris Wilson wrote:
> Quoting Daniel Vetter (2020-05-11 10:54:33)
> >   - worse, neither vk nor gl (to my knowledge) have a concept of events
> >     for when the gpu died. The only stuff you have is things like
> >     arb_robustness which says a) everything continues as if nothing
> >     happened b) there's a function where you can ask whether your gl
> >     context and all the textures/buffers are toast.
> 
> Vulkan/DX12 arrived after eGPU, and there is at least the concept of
> VK_ERROR_DEVICE_LOST. Mainly used at the moment after a GPU hang and
> loss of context.
> 
> https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#devsandqueues-lost-device

Ah cool, so -EIO on some ioctls, with silencing it in the gl driver and
passing it on for the vk driver should be ok. Assuming vk frameworks
bother to implement the *may* thing. I'm assuming if the validation
midlayer doesn't inject this, it's untested and firework will ensue.

But then more direct path to fireworks is what vk is all about :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
