Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63039C1975A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 19:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A46206EC
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FU4iUBgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A46206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26FD6E255;
	Tue, 17 Mar 2020 19:54:11 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9718F6E24E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 17:32:16 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id v15so18197942qto.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q/uuGRZEOsDl+bE2n4dBjQindS2U+dSkshg9e/3rsJY=;
 b=FU4iUBgbL/YDOzKu+bjTnxXn9TflPig4spFWJmilzk34kRefbe53ABssDpnYq4RxiZ
 n+O0F9b3g0saj53WHsCNw5lj/7/hY9KDJgPbxFKg1RV/01pre5JdZmlAkXMNQHxWapmi
 GprzttsXWQT9FXf/jK4VEXwggJDPRtExDhINmyI8LiapOrpi52Hmxmp/qtYxgvT0ClFa
 00xf+UmfedAWNC5qQzvH5yQdL0FIMlujhU3Kt/3E0lniCZy7MVtlf7dJy6MDyLvq5A+d
 NsyuTABobaFq0uYwqJPFhHf545MhX77WFDFIuE4jQpUv4U9urn5L79qq79pmeF23Wts7
 R4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q/uuGRZEOsDl+bE2n4dBjQindS2U+dSkshg9e/3rsJY=;
 b=S9bGmkhc6SHGylrIYFgzBgZyS3SEhuT3rJCzZ0qUlh0hNNhmIn64I1h5+M7hPRwfjm
 HES6UFBdB5xsi1p6oXrJD0s8eSFuqastIKE8xUKBv3eqxwItANw+mmGizA2qomW2CUEP
 ZajVcLxdMpDd15IV/D7PYpn2v/0w0uum0vlhkGhIkTXDigpwoyeDedfvCzTTIpjGeck9
 Dy0X0p7ZhkxknA7Zt6Zdq+RLr3BlIiHjh1x7St1w+HWtjGdolxu7IwkAk7rWi5jcDf6C
 x80mJR3q69jyJIPlPo8je3tk5kMQfUhIp/iJgvXEMI+F5G2ZXAdCLbFToE761qb74XJm
 oOoA==
X-Gm-Message-State: ANhLgQ3tzHxAleGVTzq2Mp22GfB14lZUZBx3v5C6o2a+z1e0knZ3LlHV
 QBIbQGXV2nlq98T+JrvdjPqlHw==
X-Google-Smtp-Source: ADFU+vvQkJHNXbvVdLtnlJMGZHp70Sk2ysRUXTAeHVBKUuaYuYs7P0Nymi41g21wcvfTtdp5N+dboA==
X-Received: by 2002:ac8:184f:: with SMTP id n15mr190677qtk.371.1584466335681; 
 Tue, 17 Mar 2020 10:32:15 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id z1sm2584388qtc.51.2020.03.17.10.32.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Mar 2020 10:32:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jEG4c-0006CT-8g; Tue, 17 Mar 2020 14:32:14 -0300
Date: Tue, 17 Mar 2020 14:32:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200317173214.GT20941@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca> <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de> <20200317124755.GR20941@ziepe.ca>
 <20200317125955.GA12847@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200317125955.GA12847@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 17 Mar 2020 19:54:11 +0000
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
Cc: Ralph Campbell <rcampbell@nvidia.com>, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2020 at 01:59:55PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 17, 2020 at 09:47:55AM -0300, Jason Gunthorpe wrote:
> > I've been using v7 of Ralph's tester and it is working well - it has
> > DEVICE_PRIVATE support so I think it can test this flow too. Ralph are
> > you able?
> > 
> > This hunk seems trivial enough to me, can we include it now?
> 
> I can send a separate patch for it once the tester covers it.  I don't
> want to add it to the original patch as it is a significant behavior
> change compared to the existing code.

Okay. I'm happy enough for now that amdgpu will get ERROR on
device_private pages. That is a bug fix in of itself.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
