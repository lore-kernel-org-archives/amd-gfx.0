Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A88BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EA5613CC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EA5613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763036E897;
	Tue, 13 Apr 2021 20:08:56 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C10C6E8A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:08:55 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 c8-20020a9d78480000b0290289e9d1b7bcso3178857otm.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sB4WXh46IEzfV/ca7rj2To4vNKgecWEurNQGcfGXPP0=;
 b=KlixHj1Mxw44obre5ZsYgDoXz2NB0dZgnBiY/nVp13MGzg8pgodasl9xZs1vvRnlWg
 9EWNlol221E4pjGyU+Zmzvdal0Euyyr82mPO2XHGtmM9t36xVN2vqrXIzu+fg2PQI6VW
 ekr0lQRHVTzDgnnsRG71BMTz+kGYzOPiZJSVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sB4WXh46IEzfV/ca7rj2To4vNKgecWEurNQGcfGXPP0=;
 b=OOtC76mEBYH8j2oMsk5BK38Y2ZG/cauf/rwE6f1bj0ygJOPBbRB3uUrSzuEh4LcPvd
 hZ5T6F71KP+VU6yLrKoKOiEBzJb7ANFND+bV6NqutDZgDyjhlg8ZoxUvgmiGcTGuaGNJ
 j92ZSMacVCq0ItCjguviKHzShoeJxThrRAkixm3Yk3iaLYtgAnlygELNmOTx9m5C8H6s
 elVA/RC5H4BWZXxSrxBmqEo1tA0k0Hv1OflS1MJ/58EsoB7G7xq8QdF0+Pcn4qwt6NBm
 nFuvjHm1u2SpL3ysyRuX0YlTqWgvagsxHi8zCseGcuGa3Ukys8+bYjJCLkoTcai8xHxZ
 fSQQ==
X-Gm-Message-State: AOAM531TObbAKjPqIyYc+G8vzPp8+fStOYff2FLYP11/fevS06ftqRhs
 3go7I0CASA8/Ctzhfj4s1pbb+M4+lFIBn+e5PMtuRA==
X-Google-Smtp-Source: ABdhPJy7Cgt4hsv3CsqNn7se8OwqgOYEV6Y4rFLU6ffF2xyORRGBz1U+TVdxe9bR5ZmJvnKiUOVDy51rjq0eNGn4gkM=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr30582388oto.281.1618344534378; 
 Tue, 13 Apr 2021 13:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <DM5PR12MB25334B94CB060BD4C3EA4223ED4F9@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB25334B94CB060BD4C3EA4223ED4F9@DM5PR12MB2533.namprd12.prod.outlook.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 13 Apr 2021 22:08:43 +0200
Message-ID: <CAKMK7uEYrw3TnXgtWwTX0RZysAeaHG+PJiKh4w=wa+NdnREQvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: "Li, Dennis" <Dennis.Li@amd.com>
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMTE6MTMgQU0gTGksIERlbm5pcyA8RGVubmlzLkxpQGFt
ZC5jb20+IHdyb3RlOgo+Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQo+Cj4gSGksIENocmlzdGlhbiBhbmQgQW5kcmV5LAo+ICAgICAgIFdlIG1h
eWJlIHRyeSB0byBpbXBsZW1lbnQgIndhaXQiIGNhbGxiYWNrIGZ1bmN0aW9uIG9mIGRtYV9mZW5j
ZV9vcHMsIHdoZW4gR1BVIHJlc2V0IG9yIHVucGx1ZyBoYXBwZW4sIG1ha2UgdGhpcyBjYWxsYmFj
ayByZXR1cm4gLSBFTk9ERVYsIHRvIG5vdGlmeSB0aGUgY2FsbGVyIGRldmljZSBsb3N0Lgo+Cj4g
ICAgICAgICAgKiBNdXN0IHJldHVybiAtRVJFU1RBUlRTWVMgaWYgdGhlIHdhaXQgaXMgaW50ciA9
IHRydWUgYW5kIHRoZSB3YWl0IHdhcwo+ICAgICAgICAgICogaW50ZXJydXB0ZWQsIGFuZCByZW1h
aW5pbmcgamlmZmllcyBpZiBmZW5jZSBoYXMgc2lnbmFsZWQsIG9yIDAgaWYgd2FpdAo+ICAgICAg
ICAgICogdGltZWQgb3V0LiBDYW4gYWxzbyByZXR1cm4gb3RoZXIgZXJyb3IgdmFsdWVzIG9uIGN1
c3RvbSBpbXBsZW1lbnRhdGlvbnMsCj4gICAgICAgICAgKiB3aGljaCBzaG91bGQgYmUgdHJlYXRl
ZCBhcyBpZiB0aGUgZmVuY2UgaXMgc2lnbmFsZWQuIEZvciBleGFtcGxlIGEgaGFyZHdhcmUKPiAg
ICAgICAgICAqIGxvY2t1cCBjb3VsZCBiZSByZXBvcnRlZCBsaWtlIHRoYXQuCj4gICAgICAgICAg
Kgo+ICAgICAgICAgICogVGhpcyBjYWxsYmFjayBpcyBvcHRpb25hbC4KPiAgICAgICAgICAqLwo+
ICAgICAgICAgc2lnbmVkIGxvbmcgKCp3YWl0KShzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpbnRyLCBzaWduZWQgbG9uZyB0aW1lb3V0
KTsKClVoIHRoaXMgY2FsbGJhY2sgaXMgZm9yIG9sZCBob3Jyb3MgbGlrZSB1bnJlbGlhYmxlIGly
cSBkZWxpdmVyeSBvbgpyYWRlb24uIFBsZWFzZSBkb24ndCB1c2UgaXQgZm9yIGFueXRoaW5nLCBp
ZiB3ZSBuZWVkIHRvIG1ha2UgZmVuY2VzCmJhaWwgb3V0IG9uIGVycm9yIHRoZW4gd2UgbmVlZCBz
b21ldGhpbmcgdGhhdCB3b3JrcyBmb3IgYWxsIGZlbmNlcy4KQWxzbyBURFIgc2hvdWxkIHJlY292
ZXJ5IHlvdSBoZXJlIGFscmVhZHkgYW5kIG1ha2Ugc3VyZSB0aGUKZG1hX2ZlbmNlX3dhaXQoKSBp
cyBib3VuZCBpbiB0aW1lLgotRGFuaWVsCgo+Cj4gQmVzdCBSZWdhcmRzCj4gRGVubmlzIExpCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxMywg
MjAyMSAzOjEwIFBNCj4gVG86IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBM
aSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLdWVo
bGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMC80XSBSZWZpbmUgR1BVIHJlY292ZXJ5IHNlcXVlbmNlIHRvIGVu
aGFuY2UgaXRzIHN0YWJpbGl0eQo+Cj4gQW0gMTIuMDQuMjEgdW0gMjI6MDEgc2NocmllYiBBbmRy
ZXkgR3JvZHpvdnNreToKPiA+Cj4gPiBPbiAyMDIxLTA0LTEyIDM6MTggcC5tLiwgQ2hyaXN0aWFu
IEvDtm5pZyB3cm90ZToKPiA+PiBBbSAxMi4wNC4yMSB1bSAyMToxMiBzY2hyaWViIEFuZHJleSBH
cm9kem92c2t5Ogo+ID4+PiBbU05JUF0KPiA+Pj4+Pgo+ID4+Pj4+IFNvIHdoYXQncyB0aGUgcmln
aHQgYXBwcm9hY2ggPyBIb3cgd2UgZ3VhcmFudGVlIHRoYXQgd2hlbiBydW5uaW5nCj4gPj4+Pj4g
YW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uIHdlIHdpbGwgc2lnbmFsIGFsbCB0
aGUgSFcKPiA+Pj4+PiBmZW5jZXMgYW5kIG5vdCByYWNpbmcgYWdhaW5zdCBzb21lIG1vcmUgZmVu
Y2VzIGluc2VydGlvbiBpbnRvIHRoYXQKPiA+Pj4+PiBhcnJheSA/Cj4gPj4+Pj4KPiA+Pj4+Cj4g
Pj4+PiBXZWxsIEkgd291bGQgc3RpbGwgc2F5IHRoZSBiZXN0IGFwcHJvYWNoIHdvdWxkIGJlIHRv
IGluc2VydCB0aGlzCj4gPj4+PiBiZXR3ZWVuIHRoZSBmcm9udCBlbmQgYW5kIHRoZSBiYWNrZW5k
IGFuZCBub3QgcmVseSBvbiBzaWduYWxpbmcKPiA+Pj4+IGZlbmNlcyB3aGlsZSBob2xkaW5nIHRo
ZSBkZXZpY2Ugc3JjdS4KPiA+Pj4KPiA+Pj4KPiA+Pj4gTXkgcXVlc3Rpb24gaXMsIGV2ZW4gbm93
LCB3aGVuIHdlIHJ1bgo+ID4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdwdV9m
ZW5jZV93YWl0X2VtcHR5IG9yCj4gPj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaV9ody0+YW1k
Z3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uLAo+ID4+PiB3aGF0IHRoZXJlIHByZXZl
bnRzIGEgcmFjZSB3aXRoIGFub3RoZXIgZmVuY2UgYmVpbmcgYXQgdGhlIHNhbWUgdGltZQo+ID4+
PiBlbWl0dGVkIGFuZCBpbnNlcnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJheSA/IExvb2tzIGxpa2Ug
bm90aGluZy4KPiA+Pj4KPiA+Pgo+ID4+IEVhY2ggcmluZyBjYW4gb25seSBiZSB1c2VkIGJ5IG9u
ZSB0aHJlYWQgYXQgdGhlIHNhbWUgdGltZSwgdGhpcwo+ID4+IGluY2x1ZGVzIGVtaXR0aW5nIGZl
bmNlcyBhcyB3ZWxsIGFzIG90aGVyIHN0dWZmLgo+ID4+Cj4gPj4gRHVyaW5nIEdQVSByZXNldCB3
ZSBtYWtlIHN1cmUgbm9ib2R5IHdyaXRlcyB0byB0aGUgcmluZ3MgYnkgc3RvcHBpbmcKPiA+PiB0
aGUgc2NoZWR1bGVyIGFuZCB0YWtpbmcgdGhlIEdQVSByZXNldCBsb2NrIChzbyB0aGF0IG5vYm9k
eSBlbHNlIGNhbgo+ID4+IHN0YXJ0IHRoZSBzY2hlZHVsZXIgYWdhaW4pLgo+ID4KPiA+Cj4gPiBX
aGF0IGFib3V0IGRpcmVjdCBzdWJtaXNzaW9ucyBub3QgdGhyb3VnaCBzY2hlZHVsZXIgLQo+ID4g
YW1kZ3B1X2pvYl9zdWJtaXRfZGlyZWN0LCBJIGRvbid0IHNlZSBob3cgdGhpcyBpcyBwcm90ZWN0
ZWQuCj4KPiBUaG9zZSBvbmx5IGhhcHBlbiBkdXJpbmcgc3RhcnR1cCBhbmQgR1BVIHJlc2V0Lgo+
Cj4gPj4KPiA+Pj4+Cj4gPj4+PiBCVFc6IENvdWxkIGl0IGJlIHRoYXQgdGhlIGRldmljZSBTUkNV
IHByb3RlY3RzIG1vcmUgdGhhbiBvbmUgZGV2aWNlCj4gPj4+PiBhbmQgd2UgZGVhZGxvY2sgYmVj
YXVzZSBvZiB0aGlzPwo+ID4+Pgo+ID4+Pgo+ID4+PiBJIGhhdmVuJ3QgYWN0dWFsbHkgZXhwZXJp
ZW5jZWQgYW55IGRlYWRsb2NrIHVudGlsIG5vdyBidXQsIHllcywKPiA+Pj4gZHJtX3VucGx1Z19z
cmN1IGlzIGRlZmluZWQgYXMgc3RhdGljIGluIGRybV9kcnYuYyBhbmQgc28gaW4gdGhlCj4gPj4+
IHByZXNlbmNlICBvZiBtdWx0aXBsZSBkZXZpY2VzIGZyb20gc2FtZSBvciBkaWZmZXJlbnQgZHJp
dmVycyB3ZSBpbgo+ID4+PiBmYWN0IGFyZSBkZXBlbmRlbnQgb24gYWxsIHRoZWlyIGNyaXRpY2Fs
IHNlY3Rpb25zIGkgZ3Vlc3MuCj4gPj4+Cj4gPj4KPiA+PiBTaGl0LCB5ZWFoIHRoZSBkZXZpbCBp
cyBhIHNxdWlycmVsLiBTbyBmb3IgQStJIGxhcHRvcHMgd2UgYWN0dWFsbHkKPiA+PiBuZWVkIHRv
IHN5bmMgdGhhdCB1cCB3aXRoIERhbmllbCBhbmQgdGhlIHJlc3Qgb2YgdGhlIGk5MTUgZ3V5cy4K
PiA+Pgo+ID4+IElJUkMgd2UgY291bGQgYWN0dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNlIGlu
IGEgZG9ja2luZyBzdGF0aW9uCj4gPj4gd2hpY2ggbmVlZHMgaG90cGx1ZyBhbmQgdGhlIGRyaXZl
ciBtaWdodCBkZXBlbmQgb24gd2FpdGluZyBmb3IgdGhlCj4gPj4gaTkxNSBkcml2ZXIgYXMgd2Vs
bC4KPiA+Cj4gPgo+ID4gQ2FuJ3Qgd2UgcHJvcG9zZSBhIHBhdGNoIHRvIG1ha2UgZHJtX3VucGx1
Z19zcmN1IHBlciBkcm1fZGV2aWNlID8gSQo+ID4gZG9uJ3Qgc2VlIHdoeSBpdCBoYXMgdG8gYmUg
Z2xvYmFsIGFuZCBub3QgcGVyIGRldmljZSB0aGluZy4KPgo+IEknbSByZWFsbHkgd29uZGVyaW5n
IHRoZSBzYW1lIHRoaW5nIGZvciBxdWl0ZSBhIHdoaWxlIG5vdy4KPgo+IEFkZGluZyBEYW5pZWwg
YXMgd2VsbCwgbWF5YmUgaGUga25vd3Mgd2h5IHRoZSBkcm1fdW5wbHVnX3NyY3UgaXMgZ2xvYmFs
Lgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPiA+Cj4gPiBBbmRyZXkKPiA+Cj4gPgo+ID4+
Cj4gPj4gQ2hyaXN0aWFuLgo+ID4+Cj4gPj4+IEFuZHJleQo+ID4+Pgo+ID4+Pgo+ID4+Pj4KPiA+
Pj4+IENocmlzdGlhbi4KPiA+Pj4+Cj4gPj4+Pj4gQW5kcmV5Cj4gPj4+Pj4KPiA+Pj4+Pgo+ID4+
Pj4+Pgo+ID4+Pj4+Pj4gQW5kcmV5Cj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+IENocmlzdGlhbi4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+PiAgICAgLyogUGFzdCB0aGlz
IHBvaW50IG5vIG1vcmUgZmVuY2UgYXJlIHN1Ym1pdHRlZCB0byBIVyByaW5nCj4gPj4+Pj4+Pj4+
IGFuZCBoZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9yY2Ugc2lnbmFsIG9uIGFsbCB0aGF0IGFy
ZQo+ID4+Pj4+Pj4+PiBjdXJyZW50bHkgdGhlcmUuCj4gPj4+Pj4+Pj4+ICAgICAgKiBBbnkgc3Vi
c2VxdWVudGx5IGNyZWF0ZWQgIEhXIGZlbmNlcyB3aWxsIGJlIHJldHVybmVkCj4gPj4+Pj4+Pj4+
IHNpZ25hbGVkIHdpdGggYW4gZXJyb3IgY29kZSByaWdodCBhd2F5Cj4gPj4+Pj4+Pj4+ICAgICAg
Ki8KPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gICAgIGZvcl9lYWNoX3JpbmcoYWRldikKPiA+Pj4+
Pj4+Pj4gICAgICAgICBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+ID4+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+PiAgICAgZHJtX2Rldl91bnBsdWcoZGV2KTsKPiA+Pj4+Pj4+Pj4gICAgIFN0b3Agc2No
ZWR1bGVycwo+ID4+Pj4+Pj4+PiAgICAgY2FuY2VsX3N5bmMoYWxsIHRpbWVycyBhbmQgcXVldWVk
IHdvcmtzKTsKPiA+Pj4+Pj4+Pj4gICAgIGh3X2ZpbmkKPiA+Pj4+Pj4+Pj4gICAgIHVubWFwX21t
aW8KPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gfQo+ID4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+PiBBbmRyZXkKPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Cj4gPj4+
Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+PiBB
bHRlcm5hdGl2ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCBzdG9wcGluZwo+
ID4+Pj4+Pj4+Pj4+Pj4+IGFuZCB0aGVuIHJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCB3
b3JrIGFzIHdlbGwuCj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4u
Cj4gPj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+IEkgZGlkbid0
IGdldCB0aGUgYWJvdmUgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBJIG5lZWQgdG8gcmV1c2UKPiA+Pj4+
Pj4+Pj4+Pj4+IHRoZSBHUFUgcmVzZXQgcndfbG9jay4gSSByZWx5IG9uIHRoZSBTUkNVIHVucGx1
ZyBmbGFnIGZvcgo+ID4+Pj4+Pj4+Pj4+Pj4gdW5wbHVnLiBBbHNvLCBub3QgY2xlYXIgdG8gbWUg
d2h5IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUKPiA+Pj4+Pj4+Pj4+Pj4+IHNjaGVkdWxlciB0aHJl
YWRzLCBhbnkgY29kZSBwYXRjaCB0byBnZW5lcmF0ZSBIVyBmZW5jZXMKPiA+Pj4+Pj4+Pj4+Pj4+
IHNob3VsZCBiZSBjb3ZlcmVkLCBzbyBhbnkgY29kZSBsZWFkaW5nIHRvCj4gPj4+Pj4+Pj4+Pj4+
PiBhbWRncHVfZmVuY2VfZW1pdCBuZWVkcyB0byBiZSB0YWtlbiBpbnRvIGFjY291bnQgc3VjaCBh
cywKPiA+Pj4+Pj4+Pj4+Pj4+IGRpcmVjdCBJQiBzdWJtaXNzaW9ucywgVk0gZmx1c2hlcyBlLnQu
Ywo+ID4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0aGVy
IHdpdGggdGhlIHJlc2V0IGxvY2sgYW55d2F5LCBjYXVzZQo+ID4+Pj4+Pj4+Pj4+PiBhIGhvdHBs
dWcgY291bGQgcnVuIGF0IHRoZSBzYW1lIHRpbWUgYXMgYSByZXNldC4KPiA+Pj4+Pj4+Pj4+Pgo+
ID4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4gRm9yIGdvaW5nIG15IHdheSBpbmRlZWQgbm93IEkg
c2VlIG5vdyB0aGF0IEkgaGF2ZSB0byB0YWtlCj4gPj4+Pj4+Pj4+Pj4gcmVzZXQgd3JpdGUgc2lk
ZSBsb2NrIGR1cmluZyBIVyBmZW5jZXMgc2lnbmFsbGluZyBpbiBvcmRlcgo+ID4+Pj4+Pj4+Pj4+
IHRvIHByb3RlY3QgYWdhaW5zdCBzY2hlZHVsZXIvSFcgZmVuY2VzIGRldGFjaG1lbnQgYW5kCj4g
Pj4+Pj4+Pj4+Pj4gcmVhdHRhY2htZW50IGR1cmluZyBzY2hlZHVsZXJzIHN0b3AvcmVzdGFydC4g
QnV0IGlmIHdlIGdvCj4gPj4+Pj4+Pj4+Pj4gd2l0aCB5b3VyIGFwcHJvYWNoICB0aGVuIGNhbGxp
bmcgZHJtX2Rldl91bnBsdWcgYW5kIHNjb3BpbmcKPiA+Pj4+Pj4+Pj4+PiBhbWRncHVfam9iX3Rp
bWVvdXQgd2l0aCBkcm1fZGV2X2VudGVyL2V4aXQgc2hvdWxkIGJlIGVub3VnaAo+ID4+Pj4+Pj4+
Pj4+IHRvIHByZXZlbnQgYW55IGNvbmN1cnJlbnQgR1BVIHJlc2V0cyBkdXJpbmcgdW5wbHVnLiBJ
biBmYWN0Cj4gPj4+Pj4+Pj4+Pj4gSSBhbHJlYWR5IGRvIGl0IGFueXdheSAtCj4gPj4+Pj4+Pj4+
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzOiUyCj4gPj4+Pj4+Pj4+Pj4gRiUyRmNnaXQuZnJlZWRlc2t0b3Aub3JnJTJGfmFncm9kem92
JTJGbGludXglMkZjb21taXQlMkYlM0ZoCj4gPj4+Pj4+Pj4+Pj4gJTNEZHJtLW1pc2MtbmV4dCUy
NmlkJTNEZWYwZWE0ZGQyOWVmNDRkMjY0OWM1ZWRhMTZjOGY0ODY5YWNjCj4gPj4+Pj4+Pj4+Pj4g
MzZiMSZhbXA7ZGF0YT0wNCU3QzAxJTdDRGVubmlzLkxpJTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVj
MzRhCj4gPj4+Pj4+Pj4+Pj4gZWRmZTZkMDhkOGZlNGIzOTQ3JTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDCj4gPj4+Pj4+Pj4+Pj4gMCU3QzYzNzUzODk0NjMyMzE5NDE1
MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMCj4gPj4+Pj4+Pj4+Pj4gakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
Cj4gPj4+Pj4+Pj4+Pj4gJmFtcDtzZGF0YT0lMkZlJTJCcUpObGN1VWpMSHNMdmZIQ0txZXJLJTJG
ZjhsenVqcU9CaG5NQklSUDhFCj4gPj4+Pj4+Pj4+Pj4gJTNEJmFtcDtyZXNlcnZlZD0wCj4gPj4+
Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gWWVzLCBnb29kIHBvaW50IGFzIHdlbGwuCj4gPj4+Pj4+Pj4+
Pgo+ID4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+Pj4+IEFuZHJleQo+ID4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+
Pj4KPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+ID4+Pj4+Pj4+Pj4+
Pgo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+ID4+Pj4+Pj4+Pj4+Pj4K
PiA+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+
Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+ID4+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+
Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5
Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pgo+
ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pgo+ID4+Pj4KPiA+PgoKCgotLSAKRGFuaWVs
IFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cu
ZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
