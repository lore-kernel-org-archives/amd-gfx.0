Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D982C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4CA20C09
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MMmRJ8t4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4CA20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C174D6E9CC;
	Fri, 19 Jun 2020 20:02:32 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872B86E9FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 19:51:45 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id l17so10094432qki.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zP3mPfj8fYVGpA7X3i9lQw/wDhwl6Nv+h6HgzhW86WQ=;
 b=MMmRJ8t4j4VSr9X/gdvrRhfckKKnEPttgsjRqD7r42N3dR4TTyyqhwnzRR2Zmqw9vU
 /eO8RZr/A4nHSOyE8HOfUMCXLr5V4yKzT96SAI89H9oM6ivtb11eu4o1b5IwFl/nQYDG
 BnpCLEibfwPpM+qQe2fTwD8TqkotDnif2MXx2+W5OqJhUu02J9GSkKwpu8Dh9btmlQsW
 HfPeSb4neRXQnhdWbAQBoeJfQU5yXw4BH7QCQBZFfTz7zBx/ENEemRvnCmMQHQcSOvEj
 0arcTcBmJyDOK1t36aFed0to462HbPkMSNhWvaHJO5I28iu9xV3xW3atg8lfxqqFsEQb
 IKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zP3mPfj8fYVGpA7X3i9lQw/wDhwl6Nv+h6HgzhW86WQ=;
 b=Me2uWfrbHqKFgaTNYvZgSdHJaCJ4SB8wlkH+abUe8OVSSFvMOThxBrSE0EN6W4QSWO
 0Rg0tmF0BcYzdz5oKZ4+kLlwM7SLF+MMVlxdNkmegjOcp/GXmvyQzR7yx9ga59rFRuej
 EHxR/ykhBAw5EBgirVqmpV78kf/y9oi5hceiOyspu88X0QohlDVgFEwE70JCl8Kh7EAb
 hQFiKZCqdKrXMBpTYdECk/Fab0fxqd/OhZfqP94o58lha5Igh91CfO+0IPvsyTbWcrGn
 sdJsogJSZaKyiyM5gxbFx4U8pc342BtmRnVawj8/BYqOS4/jfyoNpyiAnKoS4HY5NrZW
 WRvA==
X-Gm-Message-State: AOAM53004sJNFoDKJvpCfNItHPJgQbyVpWsVdXlRLH2q+MyDf8BwZTnO
 KDoKZqixff8dz6fVh+7ddQmhzQ==
X-Google-Smtp-Source: ABdhPJyeNbiGf5pDE6/nVlB6izIza9irK+wIFfmkUW9Wq6/rfhl4M8xllFEi5LwJ5619wnq0QRE14Q==
X-Received: by 2002:a37:b401:: with SMTP id d1mr5401845qkf.206.1592596304691; 
 Fri, 19 Jun 2020 12:51:44 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id a81sm7609057qkb.24.2020.06.19.12.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 12:51:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jmN39-00B0gQ-Jd; Fri, 19 Jun 2020 16:51:43 -0300
Date: Fri, 19 Jun 2020 16:51:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200619195143.GS6578@ziepe.ca>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <CADnq5_Pw_85Kzh1of=MbDi4g9POeF3jO4AJ7p2FjY5XZW0=vsQ@mail.gmail.com>
 <86f7f5e5-81a0-5429-5a6e-0d3b0860cfae@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86f7f5e5-81a0-5429-5a6e-0d3b0860cfae@amd.com>
X-Mailman-Approved-At: Fri, 19 Jun 2020 20:02:31 +0000
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jerome Glisse <jglisse@redhat.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 19, 2020 at 03:30:32PM -0400, Felix Kuehling wrote:
> We have a potential problem with CPU updating page tables while the GPU
> is retrying on page table entries because 64 bit CPU transactions don't
> arrive in device memory atomically.

Except for 32 bit platforms atomicity is guarenteed if you use uncached
writeq() to aligned addresses..

The linux driver model breaks of the writeX() stuff is not atomic.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
