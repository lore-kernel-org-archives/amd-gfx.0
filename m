Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12900C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 20:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F9B207ED
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 20:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FseEPp8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F9B207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792156E944;
	Thu, 11 Jun 2020 20:49:25 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B3A6E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 14:29:55 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id dp10so2688095qvb.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=iS2yXa8gKHNwS2UChvutG5V1O7eVsWQuqeZ34MVLXc0=;
 b=FseEPp8Fso/6As15zVP3Ym7NPs9kvuOvCIptWPzePslhXjFzBDqQXKhNnYWATD+15R
 Al/WYp+hbHsKFK4X2ojiK+EHs7yhQmmL+EDMNyPnOR89aEMfOJc5yjRH0aJYrgc62Vs4
 Doe6mzmOoH4EXTAuqTBF2FSP/hDXXwvjF9/30kmpRxNG9NB7+P9LM/fisKeD5/yoOQW2
 PEChRlkS/fkvSbixN4O37472Uu4NlrAggCY6VhNzkkPK4SDvGr55LxYD+4T/EdoOhWVl
 4gdKknLaMPLAltUrhRVsboI89uK5/pkjAghK31JbmOaIh7KRRHIu3+t+3Jd7dolDArof
 vWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=iS2yXa8gKHNwS2UChvutG5V1O7eVsWQuqeZ34MVLXc0=;
 b=FlQ1zNZ7BLLdRJcNqUK79OZGruqpX7fQIG8nJJhMYey8UpR4hoGeHNrKtOK4YFlC2O
 KzV3tQ8V5Y0EIEDh+LpvUwYMjY8MHqeOmwaE7kFmcqhikszR251ayGrk1hHfwqgl+x7A
 0PtHHgM++eAnyQJBLFSFuh00AkRuhcX+ha4uA+p30vh6Z6uAHd+2eZqVzlZZQOSTseJi
 F30/TeGXoT+bJHOXziZoiB3AgZk+OrFXB8XejJ1ugDkbjrjleJmdS3Qwxpu3IAE5rKvk
 wBxRxHMt9V66LjwgbvmqA94kSQAX8Ckxk/QpKmK7Q2s5LWO5SINcACDOMpPNn/LpfvMl
 yrZA==
X-Gm-Message-State: AOAM531RaBl+Vg+5sA/3jThE59mrnVT/zm6J2oscSHXU6ugxOzPmECDW
 9xYYVJTZTsjX6NSBZakqMeTp8HitW1g=
X-Google-Smtp-Source: ABdhPJyglizbugl/WH3rPRKasgzr+R/H6TfhyQSpLDpaYV29o2R1YgDECnGExOwsuREk0P31Na2jyw==
X-Received: by 2002:a05:6214:13e6:: with SMTP id
 ch6mr8093893qvb.29.1591885794923; 
 Thu, 11 Jun 2020 07:29:54 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id 195sm2287728qkg.74.2020.06.11.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:29:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jjODJ-005xNV-Ml; Thu, 11 Jun 2020 11:29:53 -0300
Date: Thu, 11 Jun 2020 11:29:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
Message-ID: <20200611142953.GA1419658@ziepe.ca>
References: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
 <20200610194101.1668038-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200610194101.1668038-1-daniel.vetter@ffwll.ch>
X-Mailman-Approved-At: Thu, 11 Jun 2020 20:49:24 +0000
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
Cc: linux-rdma@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, linux-mm@kvack.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdW4gMTAsIDIwMjAgYXQgMDk6NDE6MDFQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBmc19yZWNsYWltX2FjcXVpcmUvcmVsZWFzZSBuaWNlbHkgY2F0Y2ggcmVjdXJzaW9u
IGlzc3VlcyB3aGVuCj4gYWxsb2NhdGluZyBHRlBfS0VSTkVMIG1lbW9yeSBhZ2FpbnN0IHNocmlu
a2VycyAod2hpY2ggZ3B1IGRyaXZlcnMgdGVuZAo+IHRvIHVzZSB0byBrZWVwIHRoZSBleGNlc3Np
dmUgY2FjaGVzIGluIGNoZWNrKS4gRm9yIG1tdSBub3RpZmllcgo+IHJlY3Vyc2lvbnMgd2UgZG8g
aGF2ZSBsb2NrZGVwIGFubm90YXRpb25zIHNpbmNlIDIzYjY4Mzk1YzdjNwo+ICgibW0vbW11X25v
dGlmaWVyczogYWRkIGEgbG9ja2RlcCBtYXAgZm9yIGludmFsaWRhdGVfcmFuZ2Vfc3RhcnQvZW5k
IikuCj4gCj4gQnV0IHRoZXNlIG9ubHkgZmlyZSBpZiBhIHBhdGggYWN0dWFsbHkgcmVzdWx0cyBp
biBzb21lIHB0ZQo+IGludmFsaWRhdGlvbiAtIGZvciBtb3N0IHNtYWxsIGFsbG9jYXRpb25zIHRo
YXQncyB2ZXJ5IHJhcmVseSB0aGUgY2FzZS4KPiBUaGUgb3RoZXIgdHJvdWJsZSBpcyB0aGF0IHB0
ZSBpbnZhbGlkYXRpb24gY2FuIGhhcHBlbiBhbnkgdGltZSB3aGVuCj4gX19HRlBfUkVDTEFJTSBp
cyBzZXQuIFdoaWNoIG1lYW5zIG9ubHkgcmVhbGx5IEdGUF9BVE9NSUMgaXMgYSBzYWZlCj4gY2hv
aWNlLCBHRlBfTk9JTyBpc24ndCBnb29kIGVub3VnaCB0byBhdm9pZCBwb3RlbnRpYWwgbW11IG5v
dGlmaWVyCj4gcmVjdXJzaW9uLgo+IAo+IEkgd2FzIHBvbmRlcmluZyB3aGV0aGVyIHdlIHNob3Vs
ZCBqdXN0IGRvIHRoZSBnZW5lcmFsIGFubm90YXRpb24sIGJ1dAo+IHRoZXJlJ3MgYWx3YXlzIHRo
ZSByaXNrIGZvciBmYWxzZSBwb3NpdGl2ZXMuIFBsdXMgSSdtIGFzc3VtaW5nIHRoYXQKPiB0aGUg
Y29yZSBmcyBhbmQgaW8gY29kZSBpcyBhIGxvdCBiZXR0ZXIgcmV2aWV3ZWQgYW5kIHRlc3RlZCB0
aGFuCj4gcmFuZG9tIG1tdSBub3RpZmllciBjb2RlIGluIGRyaXZlcnMuIEhlbmNlIHdoeSBJIGRl
Y2lkZSB0byBvbmx5Cj4gYW5ub3RhdGUgZm9yIHRoYXQgc3BlY2lmaWMgY2FzZS4KPiAKPiBGdXJ0
aGVybW9yZSBldmVuIGlmIHdlJ2QgY3JlYXRlIGEgbG9ja2RlcCBtYXAgZm9yIGRpcmVjdCByZWNs
YWltLCB3ZSdkCj4gc3RpbGwgbmVlZCB0byBleHBsaWNpdCBwdWxsIGluIHRoZSBtbXUgbm90aWZp
ZXIgbWFwIC0gdGhlcmUncyBhIGxvdAo+IG1vcmUgcGxhY2VzIHRoYXQgZG8gcHRlIGludmFsaWRh
dGlvbiB0aGFuIGp1c3QgZGlyZWN0IHJlY2xhaW0sIHRoZXNlCj4gdHdvIGNvbnRleHRzIGFyZW50
IHRoZSBzYW1lLgo+IAo+IE5vdGUgdGhhdCB0aGUgbW11IG5vdGlmaWVycyBuZWVkaW5nIHRoZWly
IG93biBpbmRlcGVuZGVudCBsb2NrZGVwIG1hcAo+IGlzIGFsc28gdGhlIHJlYXNvbiB3ZSBjYW4n
dCBob2xkIHRoZW0gZnJvbSBmc19yZWNsYWltX2FjcXVpcmUgdG8KPiBmc19yZWNsYWltX3JlbGVh
c2UgLSBpdCB3b3VsZCBuZXN0IHdpdGggdGhlIGFjcXVpc3Rpb24gaW4gdGhlIHB0ZQo+IGludmFs
aWRhdGlvbiBjb2RlLCBjYXVzaW5nIGEgbG9ja2RlcCBzcGxhdC4gQW5kIHdlIGNhbid0IHJlbW92
ZSB0aGUKPiBhbm5vdGF0aW9ucyBmcm9tIHB0ZSBpbnZhbGlkYXRpb24gYW5kIGFsbCB0aGUgb3Ro
ZXIgcGxhY2VzIHNpbmNlCj4gdGhleSdyZSBjYWxsZWQgZnJvbSBtYW55IG90aGVyIHBsYWNlcyB0
aGFuIHBhZ2UgcmVjbGFpbS4gSGVuY2Ugd2UgY2FuCj4gb25seSBkbyB0aGUgZXF1aXZhbGVudCBv
ZiBtaWdodF9sb2NrLCBidXQgb24gdGhlIHJhdyBsb2NrZGVwIG1hcC4KPiAKPiBXaXRoIHRoaXMg
d2UgY2FuIGFsc28gcmVtb3ZlIHRoZSBsb2NrZGVwIHByaW1pbmcgYWRkZWQgaW4gNjYyMDRmMWQy
ZDFiCj4gKCJtbS9tbXVfbm90aWZpZXJzOiBwcmltZSBsb2NrZGVwIikgc2luY2UgdGhlIG5ldyBh
bm5vdGF0aW9ucyBhcmUKPiBzdHJpY3RseSBtb3JlIHBvd2VyZnVsLgo+IAo+IHYyOiBSZXZpZXcg
ZnJvbSBUaG9tYXMgSGVsbHN0cm9tOgo+IC0gdW5ib3RjaCB0aGUgZnNfcmVjbGFpbSBjb250ZXh0
IGNoZWNrLCBJIGFjY2lkZW50YWxseSBpbnZlcnRlZCBpdCwKPiAgIGJ1dCBpdCBkaWRuJ3QgYmxv
dyB1cCBiZWNhdXNlIEkgaW52ZXJ0ZWQgaXQgaW1tZWRpYXRlbHkKPiAtIGZpeCBjb21waWxpbmcg
Zm9yICFDT05GSUdfTU1VX05PVElGSUVSCj4gCj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIChJbnRl
bCkgPHRob21hc19vc0BzaGlwbWFpbC5vcmc+Cj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc+Cj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNv
bT4KPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnCj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRl
bC5jb20+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4K
PiAtLS0KPiBUaGlzIGlzIHBhcnQgb2YgYSBncHUgbG9ja2RlcCBhbm5vdGF0aW9uIHNlcmllcyBz
aW1wbHkgYmVjYXVzZSBpdAo+IHJlYWxseSBoZWxwcyB0byBjYXRjaCBpc3N1ZXMgd2hlcmUgZ3B1
IHN1YnN5c3RlbSBsb2NrcyBhbmQgcHJpbWl0aXZlcwo+IGNhbiBkZWFkbG9jayB3aXRoIHRoZW1z
ZWx2ZXMgdGhyb3VnaCBhbGxvY2F0aW9ucyBhbmQgbW11IG5vdGlmaWVycy4KPiBCdXQgYXNpZGUg
ZnJvbSB0aGF0IG1vdGl2YXRpb24gaXQgc2hvdWxkIGJlIGNvbXBsZXRlbHkgZnJlZS1zdGFuZGlu
ZywKPiBhbmQgY2FuIGxhbmQgdGhyb3VnaCAtbW0vLXJkbWEvLWhtbSBvciBhbnkgb3RoZXIgdHJl
ZSByZWFsbHkgd2hlbmV2ZXIuCj4gLURhbmllbAoKSSdtIHN0aWxsIG5vdCB0b3RhbGx5IGNsZWFy
IG9uIGhvdyBhbGwgdGhlIEdGUCBmbGFncyBtYXAgdG8KZGlmZmVyZW50IGJlaGF2aW9ycywgYnV0
IHRoaXMgc2VlbXMgcGxhdXNpYmxlIHRvIG1lCgpBdCB0aGlzIHBvaW50IGl0IHNob3VsZCBnbyB0
aHJvdWdoIEFuZHJldydzIHRyZWUsIHRoYW5rcwoKQWNrZWQtYnk6IEphc29uIEd1bnRob3JwZSA8
amdnQG1lbGxhbm94LmNvbT4gIyBGb3IgbW11X25vdGlmaWVycwoKSmFzb24KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
