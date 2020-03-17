Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF8DC10F29
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3294720757
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IqF/Pcn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3294720757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9583F6E14E;
	Tue, 17 Mar 2020 13:50:09 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D51B89FE3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 11:56:51 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id o18so10627174qvf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ezcaLzE+xMMW5k9+Lp3Fyb2v5+m1vlesVnD+8wIqvFk=;
 b=IqF/Pcn6Nw5T4vMcmTfGaEtbebh8d19TIxqJMpr9n/7ww13viixneJRo8yAFbrOmfF
 yi6gQx0fAlaDWh21kjKj5ucaecO2HtMyqm4zQjmaYbn9qmb7o8wevSYRehKm0LiRU8VO
 BSycWwfeQzFTeY9y3GLp2ZsXmrPN+MYAqq8r0p0PoqsvdUYABt3WTre7330EXu9VsyCT
 a0PmW2f0OysK4LylLGDsqjCxNyA5EKwiri2IPBjHLO00hBO15IPMZ4WZfsLN8I5jKx5y
 c8MsgopbvRu6Iql7pFUkjXgtxJ3ufw/0hJ9VOxF/4O+PKW8XFNgE+Ob+ZFAOc7o7Zue/
 PxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ezcaLzE+xMMW5k9+Lp3Fyb2v5+m1vlesVnD+8wIqvFk=;
 b=hefU8MHEzdXBLs3wWt//V3oY9znKW37YcqlqGPWpjvauEf8b4LZvhCUL1pJ/DtCG7H
 d6iZQCAa1qQcFbFsmtnBcZ3lvd7x6gPjISqZ1QmA8seOrXQTsBll6p53ONoLXP/Db5kq
 2TXJdV4bRnh0ZjG1PXlcSmZhKy8EwcyCfwYInUnU1sM2Uk6qS16ITlf/YCNhuFeqlyNp
 N5vXAMZzEg2vWQLlLUTh6PcKjJ9JOLkMAxEDggtcR9IbjFbOMejq3hBj8Ldj60JZ+UmS
 /qM/pE8z9bN3CBXIiSEdxmRoOoZdg3MvhNEprw9QPKcnuI6CrUPsX4DCqnO+8xbAqql4
 o8Tw==
X-Gm-Message-State: ANhLgQ3lMokgJolPZOkRkJBqVVG6Ilksjc447m8hy4KZzhrgOhmXNuSl
 Mx6q3Gu6Kci7j+jDjByL/9inrQ==
X-Google-Smtp-Source: ADFU+vsg9TkFE/EUzCqf5ev0slQz4qmgYe2ZEFolT/sXe7p9PM9imp1X0/0EahO8T5ITCvrRw66fPw==
X-Received: by 2002:a05:6214:1628:: with SMTP id
 e8mr4546212qvw.81.1584446210477; 
 Tue, 17 Mar 2020 04:56:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id l2sm1916228qtq.69.2020.03.17.04.56.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Mar 2020 04:56:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jEAq1-0000my-Dc; Tue, 17 Mar 2020 08:56:49 -0300
Date: Tue, 17 Mar 2020 08:56:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 2/2] mm: remove device private page support from
 hmm_range_fault
Message-ID: <20200317115649.GP20941@ziepe.ca>
References: <20200316175259.908713-1-hch@lst.de>
 <20200316175259.908713-3-hch@lst.de>
 <c099cc3c-c19f-9d61-4297-2e83df899ca4@nvidia.com>
 <20200316184935.GA25322@lst.de> <20200316200929.GB20010@ziepe.ca>
 <6de7ee97-45c7-b814-4dab-64e311dd86ce@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6de7ee97-45c7-b814-4dab-64e311dd86ce@nvidia.com>
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

On Mon, Mar 16, 2020 at 01:24:09PM -0700, Ralph Campbell wrote:

> The reason for it being backwards is that "normally" a device doesn't want
> the device private page to be faulted back to system memory, it wants to
> get the device private struct page so it can update its page table to point
> to the memory already in the device.

The "backwards" is you set the flag on input and never get it on
output, clear the flag in input and maybe get it on output.

Compare with valid or write which don't work that way.

> Also, a device like Nvidia's GPUs may have an alternate path for copying
> one GPU's memory to another (nvlink) without going through system memory
> so getting a device private struct page/PFN from hmm_range_fault() that isn't
> "owned" by the faulting GPU is useful.
> I agree that the current code isn't well tested or thought out for multiple devices
> (rdma, NVMe drives, GPUs, etc.) but it also ties in with peer-to-peer access via PCIe.

I think the series here is a big improvement. The GPU driver can set
owners that match the hidden cluster interconnect.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
