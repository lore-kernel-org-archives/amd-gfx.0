Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC9C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201FF61166
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 17:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201FF61166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889B96E84A;
	Tue, 22 Jun 2021 17:14:00 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE546E588
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 15:23:45 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id dj3so9399680qvb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=r42ocVEmWIA//O7Vp0R5aVeKrTj4f+CjM19TgcLu7yI=;
 b=JbYlgSzYmG1Fc66FYJM2c7uKHMNG0BKhfYRhDl/t4HfZIXCTkXkNOXDsHPqa4n2peB
 ysI6mqNNkHNeAKm8LsjMNdQE2b2zkO/XX6peVaIj0AMNhYUfmW34UNv99J2ObeyW/O4M
 AlP7HDwJNBY8OgpUgjTTorTmyLUlsVUZnNJdeZZN3fBd9t94MplJeK/FtWbF5wQXcwR5
 J/44W0pKR1bz4Y8dMUyaa9V35Pyl3Yzhscasz1N63ZBqjUGbU5HIxyMOZAlZZ1TDg33w
 laau+inbi3QaWeLqDwOYYzVVpGP9v4S02gOhgQLFCKQspXRAAzDLVW1nl9ri0zrdJ0n3
 86Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=r42ocVEmWIA//O7Vp0R5aVeKrTj4f+CjM19TgcLu7yI=;
 b=UeSkcBT+XTK/Fm79b0Un661V9r4L+W9dh91Ecn7cxr5fcpH4x+/YxMIhyIxjxxHOaL
 hXCvrMV1jAlOPt8oVDn7Bv8WCx10zEhNL/wrumEbw+22F3B3rCxFWFjo5ZCNsUj9wTV/
 3Ce7ffOhH3rzlm5JIb93iH0O3Gbx6sZjVxnJA3zVxg2zDX0uV9Sh6RVXh+0dkIZuqcJJ
 8RsLPVUgqU8ICmDvcBolxdRn3sH88MRqmq7ZDXwhu/AJtTX8Jkfl2cVPtarZF7Voqt6l
 NTbjmxTqf8oBN4h3nOnPGApifQLSV2g8IouFNQkA8r5aBKBpuAkCDutE6OUZXeac6yXu
 BY3g==
X-Gm-Message-State: AOAM530foBVccgXHIJBMMCDH7ZSW1n1SMVVwp4Xiu/rbbGmp2SVxNjcW
 jA3i20pF+7QhwYjiRZKIzRFixg==
X-Google-Smtp-Source: ABdhPJwYy9rg7mWFRLoue2Gvxh5Qw5S6GBldIL56hi68CLiY+GrTF6D8VqH249atgxPW27LFsL858w==
X-Received: by 2002:ad4:56e5:: with SMTP id cr5mr25603185qvb.7.1624375424489; 
 Tue, 22 Jun 2021 08:23:44 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id z3sm13252730qkj.40.2021.06.22.08.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 08:23:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lviFb-00ADEI-G0; Tue, 22 Jun 2021 12:23:43 -0300
Date: Tue, 22 Jun 2021 12:23:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622152343.GO1096940@ziepe.ca>
References: <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
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

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMDI6MjM6MDNQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMi4wNi4yMSB1bSAxNDowMSBzY2hyaWViIEphc29uIEd1bnRob3JwZToK
PiA+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDExOjQyOjI3QU0gKzAzMDAsIE9kZWQgR2FiYmF5
IHdyb3RlOgo+ID4gPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCA5OjM3IEFNIENocmlzdGlhbiBL
w7ZuaWcKPiA+ID4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPiA+
ID4gPiBBbSAyMi4wNi4yMSB1bSAwMToyOSBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPiA+ID4g
PiA+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDEwOjI0OjE2UE0gKzAzMDAsIE9kZWQgR2FiYmF5
IHdyb3RlOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEFub3RoZXIgdGhpbmcgSSB3YW50IHRvIGVt
cGhhc2l6ZSBpcyB0aGF0IHdlIGFyZSBkb2luZyBwMnAgb25seQo+ID4gPiA+ID4gPiB0aHJvdWdo
IHRoZSBleHBvcnQvaW1wb3J0IG9mIHRoZSBGRC4gV2UgZG8gKm5vdCogYWxsb3cgdGhlIHVzZXIg
dG8KPiA+ID4gPiA+ID4gbW1hcCB0aGUgZG1hLWJ1ZiBhcyB3ZSBkbyBub3Qgc3VwcG9ydCBkaXJl
Y3QgSU8uIFNvIHRoZXJlIGlzIG5vIGFjY2Vzcwo+ID4gPiA+ID4gPiB0byB0aGVzZSBwYWdlcyB0
aHJvdWdoIHRoZSB1c2Vyc3BhY2UuCj4gPiA+ID4gPiBBcmd1YWJseSBtbWFwaW5nIHRoZSBtZW1v
cnkgaXMgYSBiZXR0ZXIgY2hvaWNlLCBhbmQgaXMgdGhlIGRpcmVjdGlvbgo+ID4gPiA+ID4gdGhh
dCBMb2dhbidzIHNlcmllcyBnb2VzIGluLiBIZXJlIHRoZSB1c2Ugb2YgRE1BQlVGIHdhcyBzcGVj
aWZpY2FsbHkKPiA+ID4gPiA+IGRlc2lnbmVkIHRvIGFsbG93IGhpdGxlc3MgcmV2b2thdGlvbiBv
ZiB0aGUgbWVtb3J5LCB3aGljaCB0aGlzIGlzbid0Cj4gPiA+ID4gPiBldmVuIHVzaW5nLgo+ID4g
PiA+IFRoZSBtYWpvciBwcm9ibGVtIHdpdGggdGhpcyBhcHByb2FjaCBpcyB0aGF0IERNQS1idWYg
aXMgYWxzbyB1c2VkIGZvcgo+ID4gPiA+IG1lbW9yeSB3aGljaCBpc24ndCBDUFUgYWNjZXNzaWJs
ZS4KPiA+IFRoYXQgaXNuJ3QgYW4gaXNzdWUgaGVyZSBiZWNhdXNlIHRoZSBtZW1vcnkgaXMgb25s
eSBpbnRlbmRlZCB0byBiZQo+ID4gdXNlZCB3aXRoIFAyUCB0cmFuc2ZlcnMgc28gaXQgbXVzdCBi
ZSBDUFUgYWNjZXNzaWJsZS4KPiAKPiBObywgZXNwZWNpYWxseSBQMlAgaXMgb2Z0ZW4gZG9uZSBv
biBtZW1vcnkgcmVzb3VyY2VzIHdoaWNoIGFyZSBub3QgZXZlbgo+IHJlbW90ZWx5IENQVSBhY2Nl
c3NpYmxlLgoKVGhhdCBpcyBhIHNwZWNpYWwgQU1EIHRoaW5nLCBQMlAgaGVyZSBpcyBQQ0kgUDJQ
IGFuZCBhbGwgUENJIG1lbW9yeSBpcwpDUFUgYWNjZXNzaWJsZS4KCj4gPiA+ID4gPiBTbyB5b3Ug
YXJlIHRha2luZyB0aGUgaGl0IG9mIHZlcnkgbGltaXRlZCBoYXJkd2FyZSBzdXBwb3J0IGFuZCBy
ZWR1Y2VkCj4gPiA+ID4gPiBwZXJmb3JtYW5jZSBqdXN0IHRvIHNxdWVlemUgaW50byBETUFCVUYu
Lgo+ID4gWW91IHN0aWxsIGhhdmUgdGhlIGlzc3VlIHRoYXQgdGhpcyBwYXRjaCBpcyBkb2luZyBh
bGwgb2YgdGhpcyBQMlAKPiA+IHN0dWZmIHdyb25nIC0gZm9sbG93aW5nIHRoZSBhbHJlYWR5IE5B
SydkIEFNRCBhcHByb2FjaC4KPiAKPiBXZWxsIHRoYXQgc3R1ZmYgd2FzIE5BS2VkIGJlY2F1c2Ug
d2Ugc3RpbGwgdXNlIHNnX3RhYmxlcywgbm90IGJlY2F1c2Ugd2UKPiBkb24ndCB3YW50IHRvIGFs
bG9jYXRlIHN0cnVjdCBwYWdlcy4KCnNnIGxpc3RzIGluIGdlbmVyYWwuCiAKPiBUaGUgcGxhbiBp
cyB0byBwdXNoIHRoaXMgZm9yd2FyZCBzaW5jZSBERVZJQ0VfUFJJVkFURSBjbGVhcmx5IGNhbid0
IGhhbmRsZQo+IGFsbCBvZiBvdXIgdXNlIGNhc2VzIGFuZCBpcyBub3QgcmVhbGx5IGEgZ29vZCBm
aXQgdG8gYmUgaG9uZXN0Lgo+IAo+IElPTU1VIGlzIG5vdyB3b3JraW5nIGFzIHdlbGwsIHNvIGFz
IGZhciBhcyBJIGNhbiBzZWUgd2UgYXJlIGFsbCBnb29kIGhlcmUuCgpIb3c/IElzIHRoYXQgbW9y
ZSBBTUQgc3BlY2lhbCBzdHVmZj8KClRoaXMgcGF0Y2ggc2VyaWVzIG5ldmVyIGNhbGxzIHRvIHRo
ZSBpb21tdSBkcml2ZXIsIEFGQUlDVC4KCj4gPiA+IEknbGwgZ28gYW5kIHJlYWQgTG9nYW4ncyBw
YXRjaC1zZXQgdG8gc2VlIGlmIHRoYXQgd2lsbCB3b3JrIGZvciB1cyBpbgo+ID4gPiB0aGUgZnV0
dXJlLiBQbGVhc2UgcmVtZW1iZXIsIGFzIERhbmllbCBzYWlkLCB3ZSBkb24ndCBoYXZlIHN0cnVj
dCBwYWdlCj4gPiA+IGJhY2tpbmcgb3VyIGRldmljZSBtZW1vcnksIHNvIGlmIHRoYXQgaXMgYSBy
ZXF1aXJlbWVudCB0byBjb25uZWN0IHRvCj4gPiA+IExvZ2FuJ3Mgd29yaywgdGhlbiBJIGRvbid0
IHRoaW5rIHdlIHdpbGwgd2FudCB0byBkbyBpdCBhdCB0aGlzIHBvaW50Lgo+ID4gSXQgaXMgdHJp
dmlhbCB0byBnZXQgdGhlIHN0cnVjdCBwYWdlIGZvciBhIFBDSSBCQVIuCj4gCj4gWWVhaCwgYnV0
IGl0IGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNlLiBXaHkgc2hvdWxkIHdlIGNyZWF0ZSBhIHN0cnVj
dCBwYWdlIGZvcgo+IHNvbWV0aGluZyB0aGF0IGlzbid0IGV2ZW4gbWVtb3J5IGluIGEgbG90IG9m
IGNhc2VzPwoKQmVjYXVzZSB0aGUgaW9tbXUgYW5kIG90aGVyIHBsYWNlcyBuZWVkIHRoaXMgaGFu
ZGxlIHRvIHNldHVwIHRoZWlyCnN0dWZmLiBOb2JvZHkgaGFzIHlldCBiZWVuIGJyYXZlIGVub3Vn
aCB0byB0cnkgdG8gY2hhbmdlIHRob3NlIGZsb3dzCnRvIGJlIGFibGUgdG8gdXNlIGEgcGh5c2lj
YWwgQ1BVIGFkZHJlc3MuCgpUaGlzIGlzIHdoeSB3ZSBoYXZlIGEgc3BlY2lhbCBzdHJ1Y3QgcGFn
ZSB0eXBlIGp1c3QgZm9yIFBDSSBCQVIKbWVtb3J5LgoKSmFzb24KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
