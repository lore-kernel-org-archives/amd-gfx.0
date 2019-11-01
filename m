Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE3CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 18:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA1021734
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 18:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E6D6E2A8;
	Fri,  1 Nov 2019 18:43:07 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9976F6F852
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 18:26:14 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id g50so14115380qtb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Nov 2019 11:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gf48vjpUJOI371bNO6wuyPSeEKQoVC5o/vcfCQf27GI=;
 b=NxKBF7p2SFdhGEaJ9YeajNelds3LhE3+CM7YivLvFPF0KRiYqhmqwxaF4jgQ2BqGN6
 2fkGUW1fllUBUNzWainJDmtHdRoE2K435Uk+VLHQVjIOkSliXMaqxtjbA0+aBQJIG6P8
 r074Oqd2A3+pHDHUoIkNP8L2n3In4/613jPweZaCfNUlGUYwuBVGXDHSiZUnhML5/fF7
 nY316BaSeH0tfJgIIykNGo7A6hf8XDj7a8hhsaS3dKxTdx2wYEs3Y6TxQWuIEE7j6sKF
 0HLz096X5f9oLtc4KNSUuuR6+ogPPfCH2csz4aGHGPsrDUEDKFf7DMHUs0bEUiLkEo/F
 sSPw==
X-Gm-Message-State: APjAAAVUmAGqDtspRMuesdK0JxBzXlgE3zD8PUu/ScOpTW9Lsst8juxe
 s597YfhG/K6cB98FTo9QuAFISA==
X-Google-Smtp-Source: APXvYqxlEpFiUQP9ickqdfrdsM0skeumHMpJp062tTi17mtiKR8bSsZEkpehUJ8EZgMrejKnz1agZQ==
X-Received: by 2002:a0c:8884:: with SMTP id 4mr11433684qvn.248.1572632773480; 
 Fri, 01 Nov 2019 11:26:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id x10sm5932634qtj.25.2019.11.01.11.26.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Nov 2019 11:26:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iQbci-0008HC-0J; Fri, 01 Nov 2019 15:26:12 -0300
Date: Fri, 1 Nov 2019 15:26:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Subject: Re: [PATCH v2 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
Message-ID: <20191101182611.GA31478@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-9-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191028201032.6352-9-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Fri, 01 Nov 2019 18:43:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Gf48vjpUJOI371bNO6wuyPSeEKQoVC5o/vcfCQf27GI=;
 b=JWQs9dhnB75sOXYZXe00Sx8Ycjn6wXVLJb4bA4loebrzhAwONRCd3M5hdaM0XcPXz1
 0pyWtlLrDj1njuvPs0zQ0ulMeEyYu9AvLupxmw9YV4Vil+0G3KASfmA7bMmkBjsVbLm0
 NwKPrT73FZLPw9yxM2LsvyNjyyW57QaAakB9IZRdrjquWCFH5qzR698e9e1ojGeAZOIU
 KBToGNUChheA/LNzlqzqO22UYmvZ00/yxcgviEIwglK7aIkeobtD5FAioyP3loLN1pgO
 xAWVbCdTVv2/yYYX7qXzDiZnl3pkn6y+wuJtS5dp5Cn2pGV9z3geaSwd6yE4+Biq0CTg
 qgMg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Petr Cvek <petrcvekcz@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101182611.Ug5OyqU64lQblQhUBLwbhY_vZgU9lu7z-Knml4yWkiY@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDU6MTA6MjVQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4KPiAKPiBE
TUFfU0hBUkVEX0JVRkZFUiBjYW4gbm90IGJlIGVuYWJsZWQgYnkgdGhlIHVzZXIgKGl0IHJlcHJl
c2VudHMgYSBsaWJyYXJ5Cj4gc2V0IGluIHRoZSBrZXJuZWwpLiBUaGUga2NvbmZpZyBjb252ZW50
aW9uIGlzIHRvIHVzZSBzZWxlY3QgZm9yIHN1Y2gKPiBzeW1ib2xzIHNvIHRoZXkgYXJlIHR1cm5l
ZCBvbiBpbXBsaWNpdGx5IHdoZW4gdGhlIHVzZXIgZW5hYmxlcyBhIGtjb25maWcKPiB0aGF0IG5l
ZWRzIHRoZW0uCj4gCj4gT3RoZXJ3aXNlIHRoZSBYRU5fR05UREVWX0RNQUJVRiBrY29uZmlnIGlz
IG92ZXJseSBkaWZmaWN1bHQgdG8gZW5hYmxlLgo+IAo+IEZpeGVzOiA5MzJkNjU2MjE3OWUgKCJ4
ZW4vZ250ZGV2OiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZvciBkbWEtYnVmIFVBUEkiKQo+IENjOiBP
bGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+
Cj4gQ2M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+Cj4gQ2M6
IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+Cj4gQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVs
Lm9yZz4KPiBSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+IFJl
dmlld2VkLWJ5OiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3NhbmRyX2FuZHJ1c2hjaGVu
a29AZXBhbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFu
b3guY29tPgo+IC0tLQo+ICBkcml2ZXJzL3hlbi9LY29uZmlnIHwgMyArKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKSnVlcmdlbi9PbGVrc2FuZHIv
WGVuIE1haW50YWluZXJzOgoKV291bGQgeW91IHRha2UgdGhpcyBwYXRjaCB0aHJvdWdoIGEgeGVu
IHJlbGF0ZWQgdHJlZT8gVGhlIG9ubHkgcmVhc29uCkkgaGFkIGluIHRoaXMgc2VyaWVzIGlzIHRv
IG1ha2UgaXQgZWFzaWVyIHRvIGNvbXBpbGUtdGVzdCB0aGUgZ250ZGV2CmNoYW5nZXMuCgpTaW5j
ZSBpdCBpcyBsb29raW5nIGxpa2UgdGhlIGdudGRldiByZXdvcmsgbWlnaHQgbm90IG1ha2UgaXQg
dGhpcwpjeWNsZSBpdCBpcyBwcm9iYWJseSBiZXN0IGZvciB5b3UgdG8gdGFrZSBpdC4KClRoYW5r
cywKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
