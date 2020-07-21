Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423D2C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181AC2072E
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SVvv7WmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181AC2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEF16E4AA;
	Tue, 21 Jul 2020 07:42:02 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB81B6E4AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 07:42:01 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id o8so1788111wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 00:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=8I4d3yfRPKUddAXMH4OKFOkQh1gH0jweTktqrHFJPqI=;
 b=SVvv7WmMU/Y5r7Bz1LS9CJ5KZudcoOtUtpIHe4inw8Fdgpk0vWbt2aZSxRVvT1RbGP
 +dIqAIlwAMOTZjCAL5PJnhSHjxfyl5xPlAcgOiAUQtvZYQZ1VAnxWN3lgsNyuZh9PE+7
 ShZBr3S4wXdEzKLr/G5+xzpOoA5vtHu1FCB8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8I4d3yfRPKUddAXMH4OKFOkQh1gH0jweTktqrHFJPqI=;
 b=SG+fUdXqhMPbGXr32owL0GnyochTdvpMic/dmrlXoG/yWhv3QNAw+nN315/6YBA0Kf
 HDCDkciD9RHanRwVmXpPeB0tjsJHd5S581s9NZ7YUX/VegwXsuky4+BdefoinM133BvP
 UUyLEYyqeCbi7LxyGgdgS9iIj9SOF1448OII23R/f0h0Jcjmt5KXyNkn+oGIF5vNoTAt
 ax8iS1gMCJ3YT7KrxvEiTArFEZwkmSX1r6+2qwp+9B931uANit9RTKql+g/YkVtS8gzR
 vZkPcg/Ni7Jo16pcK6WW8uEMJ+uKVMnquV7VHzaDyQBm0G4iLPPBd5oMNvm7HFl+4ESq
 VkGQ==
X-Gm-Message-State: AOAM533wELmBq6E0t+yj40NYWgrePnxS4+2gFEcBRUQKy+IdCYQMq4kx
 +gVC9jONhZna/48+14n1xg/KcQ==
X-Google-Smtp-Source: ABdhPJwELMZ3FDmnBcjPCFuUIAq0UQy6OzxYenXzQ86GtS8M6350pulmMr/zJSvRpUKbu1kZupVbTQ==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr2752286wmj.22.1595317320339; 
 Tue, 21 Jul 2020 00:42:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id w1sm5246860wra.73.2020.07.21.00.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 00:41:59 -0700 (PDT)
Date: Tue, 21 Jul 2020 09:41:57 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
Message-ID: <20200721074157.GB3278063@phenom.ffwll.local>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
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
Cc: Daniel Stone <daniels@collabora.com>, linux-rdma@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, Steve Pronovost <spronovo@microsoft.com>,
 amd-gfx@lists.freedesktop.org, Jason Ekstrand <jason@jlekstrand.net>,
 Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellstr=F6m (Intel) wrote:
> Hi,
> =

> On 7/9/20 2:33 PM, Daniel Vetter wrote:
> > Comes up every few years, gets somewhat tedious to discuss, let's
> > write this down once and for all.
> > =

> > What I'm not sure about is whether the text should be more explicit in
> > flat out mandating the amdkfd eviction fences for long running compute
> > workloads or workloads where userspace fencing is allowed.
> =

> Although (in my humble opinion) it might be possible to completely untang=
le
> kernel-introduced fences for resource management and dma-fences used for
> completion- and dependency tracking and lift a lot of restrictions for the
> dma-fences, including prohibiting infinite ones, I think this makes sense
> describing the current state.

Yeah I think a future patch needs to type up how we want to make that
happen (for some cross driver consistency) and what needs to be
considered. Some of the necessary parts are already there (with like the
preemption fences amdkfd has as an example), but I think some clear docs
on what's required from both hw, drivers and userspace would be really
good.
>
> Reviewed-by: Thomas Hellstrom <thomas.hellstrom@intel.com>

Thanks for taking a look, first 3 patches here with annotations and docs
merged to drm-misc-next. I'll ask Maarten/Dave whether another pull is ok
for 5.9 so that everyone can use this asap.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
