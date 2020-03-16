Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B7C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 18:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4525B20409
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I9kqfk62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4525B20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035476E49D;
	Mon, 16 Mar 2020 18:18:03 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870C06E49D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 18:17:09 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id v15so15096667qto.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AU4sqxSt8W/YsMvcQ8X78B/FW1vBaCpl1FUzRCmrWTk=;
 b=I9kqfk62E7dF323PFh8XunJgdu4qpFvAS1l8ZUCl9A3tutXPqvJqbKiNe+tj0C59gy
 UvZhzm6L+Jz5auSW0YMh4Vg0v7FYOXZVRAu/O8ObdMAqlJuBwg3DLVpLfshmoOUlVf7h
 cpQdspxu4AQfJGqhUDxSStM+eXObVvC/uIh29hn6KdWAl4c/T4zmpRf1yXWZ2dOFtWpH
 hP7CJ2DDVAigxfpsHWrpdwyo/lwkqS4ojrnmbxom8dGEOjRhtpaC8taoW6+yOvvHDlZq
 4Jbtk6mowDdh1CCy3Nz3yEpp7X0Ml+vcVwbFmHaDPFmmHRa9qVw2l0UQ2c8gxyhWQGTb
 8NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AU4sqxSt8W/YsMvcQ8X78B/FW1vBaCpl1FUzRCmrWTk=;
 b=qWGWVLyxk3kHvtBM29Eebqcl1HKl2WkdUdBpb4bvZz7zPztkQRCvX5ARMCgsQEg7OK
 3u/+q7QeIdgD60nIb7G8TqNeTOVLray8edSJrbM+L1GXOMc2mcZtP+twBgI+5qpHyIjl
 4wfnK49QqcFrf2smhw8Pn1M4XtsAfLfdUB+g2yGracW2s65DH2QdKFRucUeAvwr6mhrT
 d8LOJISubzs/DZB9Yl7nStvbE1Kobjaqg+36UJ72KIJTcd0Y2ebxCKJLZ9yIQt4d1x3p
 d5+JOtCPJgwxTMbCDos0I8ZweBGSyLZoo2YudhePhwj2vtsr6YIeqqR/gKR1wHFAUoB1
 AWww==
X-Gm-Message-State: ANhLgQ0DEv2fAjzYaajSp77Dz7rUKfTcskCqwK4IMNwu03zdpyMpWwr2
 T42Q3CVyutpI9d9HKXP7i/hLdA==
X-Google-Smtp-Source: ADFU+vufKXH4Rg2LSzA+eIE14Uk1GaxDUelHZyHwAwMBTplSLIhENSdd8YqSQW0Vquak3WGfZNoxUw==
X-Received: by 2002:ac8:6d19:: with SMTP id o25mr1435634qtt.303.1584382628623; 
 Mon, 16 Mar 2020 11:17:08 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id l4sm297388qkc.26.2020.03.16.11.17.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 11:17:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDuIV-0005TT-IP; Mon, 16 Mar 2020 15:17:07 -0300
Date: Mon, 16 Mar 2020 15:17:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mm: handle multiple owners of device private pages
 in migrate_vma
Message-ID: <20200316181707.GJ20941@ziepe.ca>
References: <20200316175259.908713-1-hch@lst.de>
 <20200316175259.908713-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316175259.908713-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 18:18:02 +0000
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 06:52:58PM +0100, Christoph Hellwig wrote:
> Add a new opaque owner field to struct dev_pagemap, which will allow
> the hmm and migrate_vma code to identify who owns ZONE_DEVICE memory,
> and refuse to work on mappings not owned by the calling entity.

Using a pointer seems like a good solution to me.

Is this a bug fix? What is the downside for migrate on pages it
doesn't work? I'm not up to speed on migrate..

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
