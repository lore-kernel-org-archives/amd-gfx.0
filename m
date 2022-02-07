Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89943C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E965C10EF97;
	Mon,  7 Feb 2022 19:35:52 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356AA10F817
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:22:44 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id t17so12684152qto.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 11:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yHQiDHxA3qZlcWTxLN1MgZypNnbjTwUZO2QoeiWP/cI=;
 b=WalR+vjdCg+8zPlO5aZ1ywuN+woRsi3gerM9e8um5R75M05o/0A4tTPV0sDoS0iLf7
 MI5Ayh/aUjA3lzGk4knlGcpvrjJkTAzgzCaIVUlu2cLGGSbDhpJ/GrhJhUdc2HnXtmRK
 stuNg7sUYxLt5HQjP/PwyCP9ZRninXNxW8lX4+8vi6VkUSLgg5BY3Jxg39rH3WH2BDNx
 g9rpWqR/RtcR0wf2poNmSVgkhRnSCPEG3oCgynxbJlts+OBBSOpC9atYeDDQCpJbBHmV
 OdyYF8TiYTFFifPNOFO5hE7XJgkPbqKroSw//vj0hDKtL6BLQKT8a9/Jd8uxBZMUHGVb
 3Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yHQiDHxA3qZlcWTxLN1MgZypNnbjTwUZO2QoeiWP/cI=;
 b=AzVA/OrBO/mVQM4N5JbIqfbqjrO6X+YL4s0ttaS1+DS1So38+jqy3CPzfgVqnHCJIf
 t9PNlpv1c0Exr4pi0H7lnhqi/7AWu/Yey51a+dKSI6pWBeIsK3MvGZppKSnYBpCJf7QW
 tmT2rleW+9akmu4bB95+Hj4ZCkQqrXRA2l8vkrWozwD0Z5FMKT2ptGAFjqAheqiNsJed
 OycXlsepecENKsTuW+/72ytBVy2any9g8WPk0hYmrytRko856ogrBCazyosE+sIMmYYe
 FKtKS9zGBUKgV1/57jk34yQIuIoEkasK8Z6OzjzWCztoZZP25k/GmSLijQ5PiWjwFz29
 EZRg==
X-Gm-Message-State: AOAM530jqOUKDGaRs5000fLhH/H3BKNeKfCVyqfhoDUyQS+P/c+SaNlM
 ObROTpUFOizc3Jpbpd9APj6SgA==
X-Google-Smtp-Source: ABdhPJyusc4Y6UBxGsOMvrtpT2MH3zTc6ABg/OaP0sDSZntIjW01XzJV/gLuVV8p/6/141fWu3yUUA==
X-Received: by 2002:a05:622a:1303:: with SMTP id
 v3mr740294qtk.294.1644261763197; 
 Mon, 07 Feb 2022 11:22:43 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id y5sm5930001qkp.37.2022.02.07.11.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 11:22:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nH9b0-000HrC-2F; Mon, 07 Feb 2022 15:22:42 -0400
Date: Mon, 7 Feb 2022 15:22:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/8] mm: remove a pointless CONFIG_ZONE_DEVICE check in
 memremap_pages
Message-ID: <20220207192242.GC49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-2-hch@lst.de>
X-Mailman-Approved-At: Mon, 07 Feb 2022 19:35:52 +0000
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
Cc: nvdimm@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, linux-mm@kvack.org,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Dan Williams <dan.j.williams@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 07, 2022 at 07:32:42AM +0100, Christoph Hellwig wrote:
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/memremap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
