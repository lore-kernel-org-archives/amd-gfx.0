Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F73C49EA4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C4261166
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C4261166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF816E86A;
	Tue, 22 Jun 2021 17:14:01 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CEB6E5BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 16:05:40 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id r7so16371400qta.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=DZ3pXIZRpSkwolJsuMb/jDRoPgB3Tr5Ed0gJwqNhEn0=;
 b=bPcDo+rlbwvx6J+BbENOrwkAhwr/ApYX6dANLjI5IldJpUZEty9WP/A+WSRSkVnfVp
 fd2e4y/tXjqXDkPAhIKeQEV9eOqRiGPykVl6hBy9OPbjguGQbCXYh8BSABRpZ+0/loeK
 k5B7tYHxXO+OYAqc2XDEiodfylo30HXpiBw3o5xdgwyyFytUxxOswWBt61pJyEvA82JG
 jeswvAaYdQ80zAeU2QU/ihXizpJ995HOOdf81AhQWyQIhwQZLacM2brku76mBW2AwSnt
 rLC2zGxEtGcdZECkACvvAcUZ2O3xmGuKK/Qrbfiv04IEijyo0iWQN51AxkzmtGCV9rNa
 dlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DZ3pXIZRpSkwolJsuMb/jDRoPgB3Tr5Ed0gJwqNhEn0=;
 b=orXp3j/e8ZN3ov/Wu/nM/yxgRy4VYDkNA+5RNJkijZskvRRxg72C5y7ysLODDuA0F6
 wjPmS1xk5cycw4fl8BuhPRyzTCBvRTLxSyfpPp1dlCuwgbN/BJjLGfrK6RRbcBYEIKEN
 OR6xD39dMWpjUKteJ2FYs6qK8qitOOl4ZFALwebDGzqQBBeURwNSKMTrTy7GPAFn2aaa
 9sq2EtUsN4hb6gQEwGp1YmFnJFFZjlQZDUaXAzEPW9apROY5DLSUsbz+NQwcrUe5Cowu
 crNNnmpr/m1t0zQiFv+o5oR3lwpR8wEleayhq9uIZ6Kl/Bfe4BRRtcLH8t3MIrtTHcnj
 7t4Q==
X-Gm-Message-State: AOAM531REAb8RB1r2fAxnqII3eLw4ARtmXN0N7KB68UZXmW0SYWizKHh
 vVLanPcbSergBJaoPVv1CjK6EA==
X-Google-Smtp-Source: ABdhPJwsZvQD0cl9e1oHhoP7iCcZiW+TSb8cEQVE7Z3CfQWJtDN54cMi/qDxEpHPFsGzcH9l1+8wSg==
X-Received: by 2002:a05:622a:13cd:: with SMTP id
 p13mr4098685qtk.235.1624377939521; 
 Tue, 22 Jun 2021 09:05:39 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id j7sm13254363qkd.21.2021.06.22.09.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 09:05:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lviuA-00ADrH-BE; Tue, 22 Jun 2021 13:05:38 -0300
Date: Tue, 22 Jun 2021 13:05:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622160538.GT1096940@ziepe.ca>
References: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
X-Mailman-Approved-At: Tue, 22 Jun 2021 17:13:59 +0000
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
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMDU6NDg6MTBQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMi4wNi4yMSB1bSAxNzo0MCBzY2hyaWViIEphc29uIEd1bnRob3JwZToK
PiA+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDA1OjI5OjAxUE0gKzAyMDAsIENocmlzdGlhbiBL
w7ZuaWcgd3JvdGU6Cj4gPiA+IFtTTklQXQo+ID4gPiBObyBhYnNvbHV0ZWx5IG5vdC4gTlZpZGlh
IEdQVXMgd29yayBleGFjdGx5IHRoZSBzYW1lIHdheS4KPiA+ID4gCj4gPiA+IEFuZCB5b3UgaGF2
ZSB0b25zIG9mIHNpbWlsYXIgY2FzZXMgaW4gZW1iZWRkZWQgYW5kIFNvQyBzeXN0ZW1zIHdoZXJl
Cj4gPiA+IGludGVybWVkaWF0ZSBtZW1vcnkgYmV0d2VlbiBkZXZpY2VzIGlzbid0IGRpcmVjdGx5
IGFkZHJlc3NhYmxlIHdpdGggdGhlIENQVS4KPiA+IE5vbmUgb2YgdGhhdCBpcyBQQ0kgUDJQLgo+
ID4gCj4gPiBJdCBpcyBhbGwgc29tZSBzcGVjaWFsdHkgZGlyZWN0IHRyYW5zZmVyLgo+ID4gCj4g
PiBZb3UgY2FuJ3QgcmVhc29uYWJseSBjYWxsIGRtYV9tYXBfcmVzb3VyY2UoKSBvbiBub24gQ1BV
IG1hcHBlZCBtZW1vcnkKPiA+IGZvciBpbnN0YW5jZSwgd2hhdCBhZGRyZXNzIHdvdWxkIHlvdSBw
YXNzPwo+ID4gCj4gPiBEbyBub3QgY29uZnVzZSAiSSBhbSBkb2luZyB0cmFuc2ZlcnMgYmV0d2Vl
biB0d28gSFcgYmxvY2tzIiB3aXRoIFBDSQo+ID4gUGVlciB0byBQZWVyIERNQSB0cmFuc2ZlcnMg
LSB0aGUgbGF0dGVyIGlzIGEgdmVyeSBuYXJyb3cgc3ViY2FzZS4KPiA+IAo+ID4gPiBObywganVz
dCB1c2luZyB0aGUgZG1hX21hcF9yZXNvdXJjZSgpIGludGVyZmFjZS4KPiA+IElrLCBidXQgeWVz
IHRoYXQgZG9lcyAid29yayIuIExvZ2FuJ3Mgc2VyaWVzIGlzIGJldHRlci4KPgo+IE5vIGl0IGlz
bid0LiBJdCBtYWtlcyBkZXZpY2VzIGRlcGVuZCBvbiBhbGxvY2F0aW5nIHN0cnVjdCBwYWdlcyBm
b3IgdGhlaXIKPiBCQVJzIHdoaWNoIGlzIG5vdCBuZWNlc3Nhcnkgbm9yIGRlc2lyZWQuCgpXaGlj
aCBkcmFtYXRpY2FsbHkgcmVkdWNlcyB0aGUgY29zdCBvZiBlc3RhYmxpc2hpbmcgRE1BIG1hcHBp
bmdzLCBhCmxvb3Agb2YgZG1hX21hcF9yZXNvdXJjZSgpIGlzIHZlcnkgZXhwZW5zaXZlLgogCj4g
SG93IGRvIHlvdSBwcmV2ZW50IGRpcmVjdCBJL08gb24gdGhvc2UgcGFnZXMgZm9yIGV4YW1wbGU/
CgpHVVAgZmFpbHMuCgo+IEFsbG9jYXRpbmcgYSBzdHJ1Y3QgcGFnZXMgaGFzIHRoZWlyIHVzZSBj
YXNlLCBmb3IgZXhhbXBsZSBmb3IgZXhwb3NpbmcgVlJBTQo+IGFzIG1lbW9yeSBmb3IgSE1NLiBC
dXQgdGhhdCBpcyBzb21ldGhpbmcgdmVyeSBzcGVjaWZpYyBhbmQgc2hvdWxkIG5vdCBsaW1pdAo+
IFBDSWUgUDJQIERNQSBpbiBnZW5lcmFsLgoKU3VyZSwgYnV0IHRoYXQgaXMgYW4gaWRlYWwgd2Ug
YXJlIGZhciBmcm9tIG9idGFpbmluZywgYW5kIG5vYm9keSB3YW50cwp0byB3b3JrIG9uIGl0IHBy
ZWZlcmluZyB0byBkbyBoYWNreSBoYWNreSBsaWtlIHRoaXMuCgpJZiB5b3UgYmVsaWV2ZSBpbiB0
aGlzIHRoZW4gcmVtb3ZlIHRoZSBzY2F0dGVyIGxpc3QgZnJvbSBkbWFidWYsIGFkZCBhCm5ldyBz
ZXQgb2YgZG1hX21hcCogQVBJcyB0byB3b3JrIG9uIHBoeXNpY2FsIGFkZHJlc3NlcyBhbmQgYWxs
IHRoZQpvdGhlciBzdHVmZiBuZWVkZWQuCgpPdGhlcndpc2UsIHdlIGhhdmUgd2hhdCB3ZSBoYXZl
IGFuZCBkcml2ZXJzIGRvbid0IGdldCB0byBvcHQgb3V0LiBUaGlzCmlzIHdoeSB0aGUgc3R1ZmYg
aW4gQU1ER1BVIHdhcyBOQUsnZC4KCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
