Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF4C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 19:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B66920753
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 19:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CFIdmYKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B66920753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777E7895EE;
	Mon, 16 Mar 2020 19:26:25 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A4189FCA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 19:23:10 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id t13so15240726qtn.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=japvuDOw9SGBqSZApCc07hbPuberx25oVTkg1eTKZyE=;
 b=CFIdmYKPQbgW8rXZ3LC8dolLHGk7btoV/9hlvb5sqVhK0DUjJDXu0iZhOjxeCn2MXG
 /GdpkxMBbg8aF1rAo+EIq7OH9mCMBe/2T+Mh4ULqx3GrLCMKdXErAZkN3EWgrvUYiE/9
 YOsEl53+z1kUZvnp9AIkcpOSLh2XFfGBeR7YGg5KYZoOCJ6Llm4hGbCu+XkywWZBzH6h
 lD7jhCnLSACgr36Z/dqlVpfUUV//Vd/IFcrfepwwWKxrbVILimo/2vBi7XDedG9mtfvN
 spfwCyQk9XfHm7OxqBw8vX0OWPo5Guzt+vsjlAGKsVxpRbMFXYbmNK2g1DeKIpHUtd2q
 IWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=japvuDOw9SGBqSZApCc07hbPuberx25oVTkg1eTKZyE=;
 b=Vicu9+tJvXs3jIt34P4n35wYyjjE90AsH6ySMrugYIt4Emngz9ohlkfigx2Xyol1Y4
 pRbRL433PPLFlpg8yv2XLScyieiq1t26nk0PCiCTeQaoUbbrwUxh1/ffFv6AC7mDUM+T
 7DWeigI5RPdtHmJOt6xZDnNxkXL44paT4ZDzNV/X4WGTJlwcboYdFfwwwTRK7v0Nl5FV
 iJoQY1n9MffKC/wjtLMuJiNXY9TrvOUBJxYLlojj6qeER0knVIaEBXzHeUXIWJr6zVmq
 8NR0PQyk8VvQSj73bxtO38Ws7Ad5V3XdBDOwD2E6/3mfZ3h15qYn1s7YK9XjHxs4TVM/
 ehhQ==
X-Gm-Message-State: ANhLgQ3cY1J3GQmQraYdhbyGGxFqyevsFn68NQLBbNLlyT50ea8zBd2q
 iBXZSSLb5H7qn797RLB87lj6CQ==
X-Google-Smtp-Source: ADFU+vvVMnfIMif/CgGrxSyHwE3QBkrQjxwCDJ989v5erqtbWFOprWqGIpfeC4BCoYoIRoAt/XoJLQ==
X-Received: by 2002:aed:32e7:: with SMTP id z94mr1723801qtd.382.1584386589754; 
 Mon, 16 Mar 2020 12:23:09 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id w30sm528758qtw.21.2020.03.16.12.23.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 12:23:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDvKO-0006vf-S6; Mon, 16 Mar 2020 16:23:08 -0300
Date: Mon, 16 Mar 2020 16:23:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH  hmm 2/8] mm/hmm: don't free the cached pgmap while
 scanning
Message-ID: <20200316192308.GO20941@ziepe.ca>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-3-jgg@ziepe.ca>
 <20200316090250.GB12439@lst.de> <20200316180713.GI20941@ziepe.ca>
 <20200316181324.GA24533@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316181324.GA24533@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 19:26:24 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBNYXIgMTYsIDIwMjAgYXQgMDc6MTM6MjRQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4gT24gTW9uLCBNYXIgMTYsIDIwMjAgYXQgMDM6MDc6MTNQTSAtMDMwMCwgSmFz
b24gR3VudGhvcnBlIHdyb3RlOgo+ID4gSSBjaG9zZSB0aGlzIHRvIGJlIHNpbXBsZSB3aXRob3V0
IGhhdmluZyB0byBnb3RvIHVud2luZCBpdC4KPiA+IAo+ID4gU28sIGluc3RlYWQgbGlrZSB0aGlz
Ogo+IAo+IEFzINGVYWlkLCBhbmQgcGVyIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uOiAgSSB0aGlu
ayBqdXN0IHJlbW92aW5nIHRoZQo+IHBnbWFwIGxvb2t1cCBpcyB0aGUgcmlnaHQgdGhpbmcgdG8g
ZG8gaGVyZS4gIFNvbWV0aGluZyBsaWtlIHRoaXMgcGF0Y2g6CgpPSy4gSSB0aGluayBJIGdldCBp
dCBub3cuCgpXZSBkb24ndCBldmVuIHNpZ25hbCB0aGF0IHRoZSBwZm4gaXMgYSBwZ21hcCB0byB0
aGUgY2FsbGVyLCBzbyB0aGUKY2FsbGVyIG11c3QgYXNzdW1lIHRoZSBwZm4gaXMgQ1BVIG1lbW9y
eSBhbmQgY2FuIGJlIGRtYSBtYXBwZWQuIEF0CnRoYXQgcG9pbnQgaXQgZG9lc24ndCBtYXR0ZXIg
d2hhdCBraW5kIG9mIHBnbWFwIGl0IGlzLgoKUmFjZXMgaGVyZSBhcmUgcmVzb2x2ZWQgYnkgbm90
aWZpZXJzIGFzIHdlIGNhbid0IGRlc3Ryb3kgdGhlIHBnbWFwCndpdGhvdXQgdHJpZ2dlcmluZyBp
bnZhbGlkYXRpb24gb2YgdGhlIHB0ZQoKU28gcmVtb3ZpbmcgaXMgdGhlIHJpZ2h0IHRoaW5nIHRv
IGRvLCBhbmQgdGhlIGZpeGluZyBmb3IgdGhlCmRldmljZV9wcml2YXRlIGNhc2UgaXMgY2xvc2Vy
IHRvIHRoZSBodW5rIEkganVzdCBzZW50LgoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
