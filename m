Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EBC2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0643248C4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+A5BFNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0643248C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C946E426;
	Mon,  6 Apr 2020 15:43:04 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBD66E426
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586187781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2oMrM2mDIQhAJG19GAm5tBSf0P9gXDshIKsrEuaQRh0=;
 b=d+A5BFNo8mKLiBRxF9CnphFemgYj5izQpUAuszTbPuYGHI4n/zajR78jTfJBJi3gdpTIif
 L3z/rPISJIv3fvOCx1jfAfL4y5PGsWBiluzIfiGildYa+PdbtY0MhmEBxx/oXPhhjdcl4/
 O1jdXwbsEDbZxNUIL8K5KKXnAJey/mw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-naJPkxFRODW4iyROb-5paQ-1; Mon, 06 Apr 2020 11:42:57 -0400
X-MC-Unique: naJPkxFRODW4iyROb-5paQ-1
Received: by mail-qt1-f200.google.com with SMTP id j7so29694qtd.22
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 08:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=mTQ6SwoE2yqMXLBx7O92dtojONPG9oy9eYg6hBnMWSo=;
 b=t34AyjEfs6kV5Af+rnbolM8PxND+ExPtWaSRmBADDVLfqUe74L257w8H7V60TPaPky
 0GeySCKLGmIhG+23h/Y5OIAk/it6burRxmRd104bskCt3TXvam31UIS6h1NkNUa9NrlI
 Cqec+/kAHVcHjE7daZmfdc6ugIKikOQvPbixsYP4Ijpax7ZV91eEHxYW4xBkHr01LMKW
 OWVDD2LcZW9LpvpykemFCYsM/HU/REucN7RTkIGFmXlueh6emRThKLXDZOMkJ7z+BBgE
 NHSzkjKHb9tHWXV6g/wUMe/LIBm6jY87j7qp3i3TDKrZkb6xSXmRi6e3Gqz2PaWWRprx
 Lu3Q==
X-Gm-Message-State: AGi0PuZqYydxcFWyzeGW43vNL2+7bOLqoc6QehhpZ/8oRH84cVZ9smxp
 X85Amwdq+z3T12WNKETH1FC+bHRvhdzchX0SCH8gilaxfCYITJI44u1bT9mBlxnIrZpz/xD7nQN
 4IC+NxGuLdQjdKXsocuA0L89nMQ==
X-Received: by 2002:ae9:dd83:: with SMTP id
 r125mr22560636qkf.105.1586187777118; 
 Mon, 06 Apr 2020 08:42:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEO6+HnV6CFGNQSI2NC/499K8UEKT2zxcX+nyu1TLx6uyjv4PjMIjCN8mPbiPqNeTMeT6gdw==
X-Received: by 2002:ae9:dd83:: with SMTP id
 r125mr22560614qkf.105.1586187776797; 
 Mon, 06 Apr 2020 08:42:56 -0700 (PDT)
Received: from desoxy (c-24-61-245-152.hsd1.ma.comcast.net. [24.61.245.152])
 by smtp.gmail.com with ESMTPSA id h10sm8207966qtp.93.2020.04.06.08.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 08:42:56 -0700 (PDT)
Message-ID: <f4d856925111b77012cabb255d6a880ae5637b41.camel@redhat.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and
 impact on services
From: Adam Jackson <ajax@redhat.com>
To: Rob Clark <robdclark@gmail.com>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel@daenzer.net>
Date: Mon, 06 Apr 2020 11:42:54 -0400
In-Reply-To: <CAF6AEGuNTtHfNm_nRhPFX5wPRmKkjnFEKqTdTSBDjpLkaiN8Fw@mail.gmail.com>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <59f4ea1f13a9a9d37f7801b93061b4ae7dd595e2.camel@gmail.com>
 <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
 <d9dca12759fd6a549dc4cd71b5f210a4dced01cd.camel@gmail.com>
 <CAOFGe96WqRTagf=Lhp6j9aMnB6hxwog7t93t=4r6QE_4f+HpeQ@mail.gmail.com>
 <5551426acf99f73d3ce8234c14c176c1c7a1fe44.camel@ndufresne.ca>
 <CAAxE2A5zSy7Rh6xyPW8NCqj3q0_8F7yw8tAXx=_z8+mJ-u2uWw@mail.gmail.com>
 <3cddf1aa-5072-af7c-c51e-c16039176f6c@daenzer.net>
 <CAF6AEGuNTtHfNm_nRhPFX5wPRmKkjnFEKqTdTSBDjpLkaiN8Fw@mail.gmail.com>
User-Agent: Evolution 3.34.0 (3.34.0-1.fc31)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 Discussion of the development of and with GStreamer
 <gstreamer-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAyMDIwLTA0LTA0IGF0IDA4OjExIC0wNzAwLCBSb2IgQ2xhcmsgd3JvdGU6Cj4gT24g
RnJpLCBBcHIgMywgMjAyMCBhdCA3OjEyIEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnpl
ci5uZXQ+IHdyb3RlOgo+ID4gT24gMjAyMC0wMy0wMSA2OjQ2IGEubS4sIE1hcmVrIE9sxaHDoWsg
d3JvdGU6Cj4gPiA+IEZvciBNZXNhLCB3ZSBjb3VsZCBydW4gQ0kgb25seSB3aGVuIE1hcmdlIHB1
c2hlcywgc28gdGhhdCBpdCdzIGEgc3RyaWN0bHkKPiA+ID4gcHJlLW1lcmdlIENJLgo+ID4gCj4g
PiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uISBJIGltcGxlbWVudGVkIHNvbWV0aGluZyBsaWtl
IHRoaXMgZm9yIE1lc2E6Cj4gPiAKPiA+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9t
ZXNhL21lc2EvLS9tZXJnZV9yZXF1ZXN0cy80NDMyCj4gCj4gSSB3b3VsZG4ndCBtaW5kIG1hbnVh
bGx5IHRyaWdnZXJpbmcgcGlwZWxpbmVzLCBidXQgdW5sZXNzIHRoZXJlIGlzCj4gc29tZSB0cmlj
ayBJJ20gbm90IHJlYWxpemluZywgaXQgaXMgc3VwZXIgY3VtYmVyc29tZS4gIEllLiB5b3UgaGF2
ZSB0bwo+IGNsaWNrIGZpcnN0IHRoZSBjb250YWluZXIgam9icy4uIHRoZW4gd2FpdC4uIHRoZW4g
dGhlIGJ1aWxkIGpvYnMuLgo+IHRoZW4gd2FpdCBzb21lIG1vcmUuLiBhbmQgdGhlbiBmaW5hbGx5
IHRoZSBhY3R1YWwgcnVubmVycy4gIFRoYXQgd291bGQKPiBiZSBhIHJlYWwgc3RlcCBiYWNrIGlu
IHRlcm1zIG9mIHVzZWZ1bG5lc3Mgb2YgQ0kuLiBvbmUgbWlnaHQgY2FsbCBpdCBhCj4gcmVncmVz
c2lvbiA6LSgKCkkgdGhpbmsgdGhhdCdzIG1vc3RseSBhIGNvbXBsYWludCBhYm91dCB0aGUgY29u
ZGl0aW9uYWxzIHdlJ3ZlIHdyaXR0ZW4Kc28gZmFyLCB0YmguIEFzIEkgY29tbWVudGVkIG9uIHRo
ZSBidWcsIHdoZW4gSSBjbGlja2VkIHRoZSBjb250YWluZXIKam9iICh3aGljaCB0aGUgcnVsZXMg
aGFwcGVuIHRvIGhhdmUgZXZhbHVhdGVkIHRvIGJlaW5nICJtYW51YWwiKSwgZXZlcnkKam9iIChy
ZWN1cnNpdmVseSkgZG93bnN0cmVhbSBvZiBpdCBnb3QgZW5xdWV1ZWQsIHdoaWNoIGlzbid0IHdo
YXQKeW91J3JlIGRlc2NyaWJpbmcuIFNvIEkgdGhpbmsgaWYgeW91IGNhbiBkZXNjcmliZSB0aGUg
VVggeW91J2QgbGlrZSB3ZQpjYW4gd3JpdGUgcnVsZXMgdG8gbWFrZSB0aGF0IHJlYWxpdHkuCgpC
dXQgSSBkb24ndCByZWFsbHkga25vdyB3aGljaCBqb2JzIGFyZSBtb3N0IGV4cGVuc2l2ZSBpbiB0
ZXJtcyBvZgpiYW5kd2lkdGgsIG9yIHN0b3JhZ2UsIG9yIENQVXMsIGFuZCBldmVuIGlmIEkga25l
dyB0aG9zZSBJIGRvbid0IGtub3cKaG93IHRvIG1hcCB0aG9zZSB0byBjdXJyZW5jeS4gU28gSSdt
IG5vdCBzdXJlIGlmIHRoZSBVSSB3ZSdkIGxpa2Ugd291bGQKbWluaW1pemUgdGhlIGNvc3QgdGhl
IHdheSB3ZSdkIGxpa2UuCgotIGFqYXgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
