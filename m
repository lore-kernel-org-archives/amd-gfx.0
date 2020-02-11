Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B77C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB13820714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UAQMn31B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB13820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CF46EE23;
	Tue, 11 Feb 2020 11:13:26 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FE76EE23
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:13:25 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id t2so11843873wrr.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VJKGXshv9im8n13J7VytMlLDWj4BKc4K3gpa1jG75HI=;
 b=UAQMn31BcN1FYJQphT3Z1jWaUYxyNoQ/7W9yMdfDUE7ZQMDi3DL2IgDzoNBhEF2k4F
 R4RyRP3q8epWYD3TYWwR4c0lxVX1TZMoheFYmMHITJ4lBDFiFSufmE5D7Tc0BNp/GIKP
 BWAEqaIA+PH6xrGpT6ItmsBl8V6fkq86oDg7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VJKGXshv9im8n13J7VytMlLDWj4BKc4K3gpa1jG75HI=;
 b=b2gzXjLjWXKAbDuWB2wyPFz50hectUd6vTGhFxUMMt8ckXiCFSt7bur96D4PKnijDq
 Jb9TWiATJ9p4YaIqTLbJhUr1rQs4ajw/S/d115WWUhekoSPmRR3t0kz67ZWaFrVgUADb
 jZHSvFTZ6hJQkzsuu7Wn0AK/C1jZ4oz8KChNuKRb4ZvuBE8jX9bFyG26cMti5Gm3buWZ
 1cOvUvIVXiitCrEmqHvFuM4mQotbl1B+zAP4gwVt9Tvu/al3QJ3nIsObYoj3NRadZCOO
 RuWM0DM06zQo0KMqnYBv4/UYnlkto6FDUThkFAI/kWljtm2zFp9lsamFvNApkB1mkPYk
 dYhw==
X-Gm-Message-State: APjAAAVKT1JKVUL/LNqUG3tUoPvrjDqPs081cZg7DBTV0rEc6srage74
 TJ5l/73zsmO5RWSjcWVKNhcrEg==
X-Google-Smtp-Source: APXvYqzBeoe5MDEk4TQ0c7WoQXjrim/UKU53DgPdywGq1OhC4Zg1bB98YZMoMTrAIIEPd5hkOrprmw==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr7907527wrw.319.1581419603822; 
 Tue, 11 Feb 2020 03:13:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b10sm4721660wrw.61.2020.02.11.03.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:13:23 -0800 (PST)
Date: Tue, 11 Feb 2020 12:13:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: Cleanup TTMs delayed delete handling
Message-ID: <20200211111321.GY43062@phenom.ffwll.local>
References: <20200210150907.20616-1-christian.koenig@amd.com>
 <SN6PR12MB2800BAF6444C0BC373C13E9087180@SN6PR12MB2800.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2800BAF6444C0BC373C13E9087180@SN6PR12MB2800.namprd12.prod.outlook.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 11, 2020 at 11:06:53AM +0000, Pan, Xinhui wrote:
> [AMD Official Use Only - Internal Distribution Only]

Uh might want to fix your email setup.
-Daniel

> =

> For patch 1/2/3/5/6
> Reviewed-by: xinhui pan <xinhui.pan@amd.com>
> ________________________________
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, February 10, 2020 11:09:01 PM
> To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org <dri-devel@list=
s.freedesktop.org>
> Subject: Cleanup TTMs delayed delete handling
> =

> This series of patches cleans up TTMs delayed delete handling.
> =

> The core of the new handling is that we new only have a single reference =
counter instead of two and use kref_get_unless_zero() to grab BOs from the =
LRU during eviction.
> =

> This reduces the overhead of LRU moves and allows us to properly individu=
alize the BOs reservation object during deletion to allow adding BOs for cl=
earing memory, unmapping page tables etc..
> =

> Please review and comment,
> Christian.
> =

> =


> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
