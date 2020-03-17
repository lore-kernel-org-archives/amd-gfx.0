Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF49C18E5B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8527D20757
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SQzUEb66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8527D20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CCC6E151;
	Tue, 17 Mar 2020 13:50:09 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDEA89E23
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 12:15:39 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id m33so17137630qtb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=embLdYCC+n7Oc9s6Q8ZHyjDJLIa4kBbr1h9BCOMYbH4=;
 b=SQzUEb66s7EkVHhGjTvINACKhElAAylB3fP+JIE5uJtINxUSWP+viORRExV6sx6htD
 HpVjFFlfhYosV5Dtv6arQkz6yiV2Baf2i4b1LfAOirqSi7orDhzKcNalylzPx3FE1iin
 oP+wLU4hopi4dKyJTpvXWz51qQrzPAGcS4kKz84+9KAoAC2yW49o3KG6agUJaN37k6yK
 HuepGzVyNECsPyMpp1CtLxq1h9Taueop5kQtr0Zv8iKdXRs41vSS5Kb4H/Sh9sxSVbBi
 Mn9h5qwb5Z+4eSnt+xfXYW9HjJYHq+hghoj++xGbpVpzLV1xGx/h/5X4aTndQ1jk78Xd
 Y1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=embLdYCC+n7Oc9s6Q8ZHyjDJLIa4kBbr1h9BCOMYbH4=;
 b=PuTCHCsfXngTmtSPloaHy0/5etDp20xxO+rgcxjtfBMTfucpBE7YXj9wGhcFDNQzy6
 Q1RXPwJ6/mVe2IDLzdvoF24d7CwvHamgV4sErfnRdYNhL8ZyCiaHrdT/8dzkga1ycXtZ
 hVTaMW14SsXPaF+yurRDvT5I7HNvcUIjxMSRQCyxmeCJiLstNmmTdkDZXOSwACCi+Zna
 xivik4Ur1ynuH0Op6s0Jq8YMiNDTk+AJ33G6xPRZLMEgeQHQ7M/KZCi+FIWbCxhKees1
 OeSuPMyXWeq3DMWjUAOiFDy2xKCoRqG0dSZIiODjR2DjgDKGXLKXyBuLetYF4/vetF0u
 bqYw==
X-Gm-Message-State: ANhLgQ1wpoOPWfTOItEPz354ysyyzsaFLzfqM+C/q7wcp8LWhMTBhVXx
 kXC4h50Xrkj24umFqgovOiIGkA==
X-Google-Smtp-Source: ADFU+vsrbs1FMDMvrBo9cu5QRVB0IZzDlkTw1XDG3EBbGMsL3EdtYUQXQDIyFHCwplMScIrZT+xPIg==
X-Received: by 2002:aed:2ba2:: with SMTP id e31mr4988796qtd.286.1584447338651; 
 Tue, 17 Mar 2020 05:15:38 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id k13sm2042705qtm.11.2020.03.17.05.15.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Mar 2020 05:15:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jEB8C-00012L-NV; Tue, 17 Mar 2020 09:15:36 -0300
Date: Tue, 17 Mar 2020 09:15:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200317121536.GQ20941@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 17 Mar 2020 13:50:08 +0000
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
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Bharata B Rao <bharata@linux.ibm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 03:49:51PM -0700, Ralph Campbell wrote:
> 
> On 3/16/20 12:32 PM, Christoph Hellwig wrote:
> > Remove the code to fault device private pages back into system memory
> > that has never been used by any driver.  Also replace the usage of the
> > HMM_PFN_DEVICE_PRIVATE flag in the pfns array with a simple
> > is_device_private_page check in nouveau.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Getting rid of HMM_PFN_DEVICE_PRIVATE seems reasonable to me since a driver can
> look at the struct page but what if a driver needs to fault in a page from
> another device's private memory? Should it call handle_mm_fault()?

Isn't that what this series basically does?

The dev_private_owner is set to the type of pgmap the device knows how
to handle, and everything else is automatically faulted for the
device.

If the device does not know how to handle device_private then it sets
dev_private_owner to NULL and it never gets device_private pfns.

Since the device_private pfn cannot be dma mapped, drivers must have
explicit support for them.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
