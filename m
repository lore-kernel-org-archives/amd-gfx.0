Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CACC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 07:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466B9613E0
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 07:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466B9613E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F359C6EA13;
	Thu, 24 Jun 2021 07:06:12 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27126E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 18:24:37 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id dj3so1916944qvb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Ay2MFJ8k8M7R+vcG/EIgcKO9+a17Gdo2IRp61Ubbznw=;
 b=mCvqGy8+wtoV1fX/pyjo8KTMFPXZBXguyo9f6344j9Tuu6bvNitRH+6EMM391SPgX6
 SQMYyLNce8QZVpU7zBjnXebtb+Q1dmFuIlrzFz1aYg4dzKB/BRgz4LB8VyLVDBN8SLbD
 /DnbLaMY7YnyWKxjMZMgiPK42h8fTN66ErFs85v1J8jFaHQ7sl2AsFzx96c0xf/l9U1g
 an4hgyfwGlZSu7q9rvwAQ11c2UHFj6bACLkguqt6g9SVPdmo2aTNRobeEQ+DP+d/WoQh
 ZrnVQWoPWeo+kqw9aoKL73cB5McCCDUOBzJRc7EqyhLF4fkeGZrtBUlGnWa8WWodzdtj
 vF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Ay2MFJ8k8M7R+vcG/EIgcKO9+a17Gdo2IRp61Ubbznw=;
 b=shAhniuyG+U6Pq5trjvIsZpPU/uG+126Tt6DShnX9zU5YUfc0U4tcLYeRn2/jntYjd
 B8xJk3lpBVpBDoupIOJux0HOaurHBh4fEQueIM+PvfnTC1zazgP2/uycE9Try1HQRsxX
 hFT6KW8vKC23nR6WTfwXcH36bTi6qgjTpN6Hvoql5xnyZztrPP2dLj7EvHY9E2IKU5pn
 xtcwAEay2oEaRzQzaIVPsGaJ30bcaZS9XOnLf6Qht57VuvlO97r44Mp3IOGSuSCiVW0Q
 2MICBBFjK/Mt0pYE4mgc6xXkW6zMb5S4kx0iblawparF8ImmJVvsmJLyiZdgkDV1AmRw
 BArA==
X-Gm-Message-State: AOAM5338BytbKPAqevwvpQEezqd1J0uvMbsLVXiTmDqKDqNg0JQ9oQz9
 MF82V562xaib2Oszt0cAcvj4tQ==
X-Google-Smtp-Source: ABdhPJwlrtEHn8YPQ5NuHFKzj1NcK0jWPqvPQ5lmMB0+rCMklEH74CDToqHNweA68dTG1W74jUsdaA==
X-Received: by 2002:a0c:f309:: with SMTP id j9mr1350376qvl.12.1624472676911;
 Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id 85sm456567qkl.46.2021.06.23.11.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lw7YB-00BlF7-OO; Wed, 23 Jun 2021 15:24:35 -0300
Date: Wed, 23 Jun 2021 15:24:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210623182435.GX1096940@ziepe.ca>
References: <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca>
 <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
X-Mailman-Approved-At: Thu, 24 Jun 2021 07:06:12 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sleybo@amazon.com,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>, Oded Gabbay <ogabbay@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdW4gMjMsIDIwMjEgYXQgMTA6NTc6MzVBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKCj4gPiA+IE5vIGl0IGlzbid0LiBJdCBtYWtlcyBkZXZpY2VzIGRlcGVuZCBvbiBh
bGxvY2F0aW5nIHN0cnVjdCBwYWdlcyBmb3IgdGhlaXIKPiA+ID4gQkFScyB3aGljaCBpcyBub3Qg
bmVjZXNzYXJ5IG5vciBkZXNpcmVkLgo+ID4gV2hpY2ggZHJhbWF0aWNhbGx5IHJlZHVjZXMgdGhl
IGNvc3Qgb2YgZXN0YWJsaXNoaW5nIERNQSBtYXBwaW5ncywgYQo+ID4gbG9vcCBvZiBkbWFfbWFw
X3Jlc291cmNlKCkgaXMgdmVyeSBleHBlbnNpdmUuCj4gCj4gWWVhaCwgYnV0IHRoYXQgaXMgcGVy
ZmVjdGx5IG9rLiBPdXIgQkFSIGFsbG9jYXRpb25zIGFyZSBlaXRoZXIgaW4gY2h1bmtzIG9mCj4g
YXQgbGVhc3QgMk1pQiBvciBvbmx5IGEgc2luZ2xlIDRLaUIgcGFnZS4KCkFuZCB2ZXJ5IHNtYWxs
IGFwcGFyZW50bHkKIAo+ID4gPiBBbGxvY2F0aW5nIGEgc3RydWN0IHBhZ2VzIGhhcyB0aGVpciB1
c2UgY2FzZSwgZm9yIGV4YW1wbGUgZm9yIGV4cG9zaW5nIFZSQU0KPiA+ID4gYXMgbWVtb3J5IGZv
ciBITU0uIEJ1dCB0aGF0IGlzIHNvbWV0aGluZyB2ZXJ5IHNwZWNpZmljIGFuZCBzaG91bGQgbm90
IGxpbWl0Cj4gPiA+IFBDSWUgUDJQIERNQSBpbiBnZW5lcmFsLgo+ID4gU3VyZSwgYnV0IHRoYXQg
aXMgYW4gaWRlYWwgd2UgYXJlIGZhciBmcm9tIG9idGFpbmluZywgYW5kIG5vYm9keSB3YW50cwo+
ID4gdG8gd29yayBvbiBpdCBwcmVmZXJpbmcgdG8gZG8gaGFja3kgaGFja3kgbGlrZSB0aGlzLgo+
ID4gCj4gPiBJZiB5b3UgYmVsaWV2ZSBpbiB0aGlzIHRoZW4gcmVtb3ZlIHRoZSBzY2F0dGVyIGxp
c3QgZnJvbSBkbWFidWYsIGFkZCBhCj4gPiBuZXcgc2V0IG9mIGRtYV9tYXAqIEFQSXMgdG8gd29y
ayBvbiBwaHlzaWNhbCBhZGRyZXNzZXMgYW5kIGFsbCB0aGUKPiA+IG90aGVyIHN0dWZmIG5lZWRl
ZC4KPiAKPiBZZWFoLCB0aGF0J3Mgd2hhdCBJIHRvdGFsbHkgYWdyZWUgb24uIEFuZCBJIGFjdHVh
bGx5IGhvcGVkIHRoYXQgdGhlIG5ldyBQMlAKPiB3b3JrIGZvciBQQ0llIHdvdWxkIGdvIGludG8g
dGhhdCBkaXJlY3Rpb24sIGJ1dCB0aGF0IGRpZG4ndCBtYXRlcmlhbGl6ZWQuCgpJdCBpcyBhIGxv
dCBvZiB3b3JrIGFuZCB0aGUgb25seSBnYWluIGlzIHRvIHNhdmUgYSBiaXQgb2YgbWVtb3J5IGZv
cgpzdHJ1Y3QgcGFnZXMuIE5vdCBhIHZlcnkgYmlnIHBheSBvZmYuCiAKPiBCdXQgYWxsb2NhdGlu
ZyBzdHJ1Y3QgcGFnZXMgZm9yIFBDSWUgQkFScyB3aGljaCBhcmUgZXNzZW50aWFsbHkgcmVnaXN0
ZXJzCj4gYW5kIG5vdCBtZW1vcnkgaXMgbXVjaCBtb3JlIGhhY2t5IHRoYW4gdGhlIGRtYV9yZXNv
dXJjZV9tYXAoKSBhcHByb2FjaC4KCkl0IGRvZXNuJ3QgcmVhbGx5IG1hdHRlci4gVGhlIHBhZ2Vz
IGFyZSBpbiBhIHNwZWNpYWwgem9uZSBhbmQgYXJlIG9ubHkKYmVpbmcgdXNlZCBhcyBoYW5kbGVz
IGZvciB0aGUgQkFSIG1lbW9yeS4KCj4gQnkgdXNpbmcgUENJZSBQMlAgd2Ugd2FudCB0byBhdm9p
ZCB0aGUgcm91bmQgdHJpcCB0byB0aGUgQ1BVIHdoZW4gb25lIGRldmljZQo+IGhhcyBmaWxsZWQg
dGhlIHJpbmcgYnVmZmVyIGFuZCBhbm90aGVyIGRldmljZSBtdXN0IGJlIHdva2VuIHVwIHRvIHBy
b2Nlc3MKPiBpdC4KClN1cmUsIHdlIGFsbCBoYXZlIHRoZXNlIHNjZW5hcmlvcywgd2hhdCBpcyBp
bnNpZGUgdGhlIG1lbW9yeSBkb2Vzbid0CnJlYWx5IG1hdHRlci4gVGhlIG1lY2hhbmlzbSBpcyBn
ZW5lcmljIGFuZCB0aGUgc3RydWN0IHBhZ2VzIGRvbid0IGNhcmUKbXVjaCBpZiB0aGV5IHBvaW50
IGF0IHNvbWV0aGluZyBtZW1vcnktbGlrZSBvciBhdCBzb21ldGhpbmcKcmVnaXN0ZXItbGlrZS4K
ClRoZXkgYXJlIGFscmVhZHkgaW4gYmlnIHRyb3VibGUgYmVjYXVzZSB5b3UgY2FuJ3QgcG9ydGFi
bHkgdXNlIENQVQppbnN0cnVjdGlvbnMgdG8gYWNjZXNzIHRoZW0gYW55aG93LgoKSmFzb24KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
