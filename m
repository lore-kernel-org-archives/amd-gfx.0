Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFEFC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3EE611EE
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3EE611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC1D6E894;
	Tue, 13 Apr 2021 20:07:51 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564686E894
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:07:50 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id k18so13326178oik.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xo3nh6RwWU5MU9j38DRwpu+o/6kvWRrZAVIy/0dqClM=;
 b=VpGj7tQhCb6T2wO0FCgN0+rMJ0f/H2VnYB8jol02rCfTlOAPBoaIqDCg9qhVGJRXq8
 Z/QrHYA8gJ7pWbnF7X1YCxfZHyQCPXPx+myqNQYFJsIgqdy5QCD+Mr63oHJKNKYZYLpI
 mpYXg61IimOzbugyv4ulQAk3LTUQLDnpFnidM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xo3nh6RwWU5MU9j38DRwpu+o/6kvWRrZAVIy/0dqClM=;
 b=JRZ4psUyE76p2hljv3u/i3ErfdXkpWVpe9oweIUDwA//fGqpc8IszaNjlp1jTWVguH
 AQYnb+4/+oO1BvwkPhXASqAhy926sU2/0qR2UND9apTkLxbuA4//ynJ5X99+ht7DDyEf
 tN4ECNPXzV+RYVzRK/d/aPxj6ZM2a/c67CeB2i9qdgYEqL2E/WribfVzlPvaGD74BtQi
 9x9gVJNyuQPiYeo0+gSfAx7j8FwoDLW9UKm2ChpcYTfYpil95CE/Au3eAC4za9O0rYXg
 frrx0Ep4n07W3bVEjC8Kdp5SYBfvltYBUX8/GrcvsWNuPn0h/T4AWdHTGGltA0uF1LGe
 8hHw==
X-Gm-Message-State: AOAM530qLbjPJPLsDpTIFqlzfhQZv6OmQncu/uhYnKMBO8Ptfns1M5Ap
 Ct3FOYwx/7NS9uIUTmLBbsoYtC8pDDZhxM1Lms2Mfw==
X-Google-Smtp-Source: ABdhPJz3/68lr6Z0UzbRfeLWjC4ikSc0DZFCiR/Rl8kvmvxJMvyEclmK2cd+bvN/YBDZLY5HVgnvOozhH11d1L6U/V8=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr1235137oic.14.1618344469589; 
 Tue, 13 Apr 2021 13:07:49 -0700 (PDT)
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
In-Reply-To: <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 13 Apr 2021 22:07:38 +0200
Message-ID: <CAKMK7uG9BubHGqQKJKia=hTEK8sixGSnPTmXTexBiuu5bbN6Jg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgOToxMCBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxMi4wNC4yMSB1bSAyMjow
MSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+ID4KPiA+IE9uIDIwMjEtMDQtMTIgMzoxOCBw
Lm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4+IEFtIDEyLjA0LjIxIHVtIDIxOjEyIHNj
aHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4gPj4+IFtTTklQXQo+ID4+Pj4+Cj4gPj4+Pj4gU28g
d2hhdCdzIHRoZSByaWdodCBhcHByb2FjaCA/IEhvdyB3ZSBndWFyYW50ZWUgdGhhdCB3aGVuIHJ1
bm5pbmcKPiA+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24gd2Ugd2ls
bCBzaWduYWwgYWxsIHRoZSBIVwo+ID4+Pj4+IGZlbmNlcyBhbmQgbm90IHJhY2luZyBhZ2FpbnN0
IHNvbWUgbW9yZSBmZW5jZXMgaW5zZXJ0aW9uIGludG8gdGhhdAo+ID4+Pj4+IGFycmF5ID8KPiA+
Pj4+Pgo+ID4+Pj4KPiA+Pj4+IFdlbGwgSSB3b3VsZCBzdGlsbCBzYXkgdGhlIGJlc3QgYXBwcm9h
Y2ggd291bGQgYmUgdG8gaW5zZXJ0IHRoaXMKPiA+Pj4+IGJldHdlZW4gdGhlIGZyb250IGVuZCBh
bmQgdGhlIGJhY2tlbmQgYW5kIG5vdCByZWx5IG9uIHNpZ25hbGluZwo+ID4+Pj4gZmVuY2VzIHdo
aWxlIGhvbGRpbmcgdGhlIGRldmljZSBzcmN1Lgo+ID4+Pgo+ID4+Pgo+ID4+PiBNeSBxdWVzdGlv
biBpcywgZXZlbiBub3csIHdoZW4gd2UgcnVuCj4gPj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZmlu
aV9ody0+YW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkgb3IKPiA+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZl
cl9maW5pX2h3LT5hbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24sCj4gPj4+IHdo
YXQgdGhlcmUgcHJldmVudHMgYSByYWNlIHdpdGggYW5vdGhlciBmZW5jZSBiZWluZyBhdCB0aGUg
c2FtZSB0aW1lCj4gPj4+IGVtaXR0ZWQgYW5kIGluc2VydGVkIGludG8gdGhlIGZlbmNlIGFycmF5
ID8gTG9va3MgbGlrZSBub3RoaW5nLgo+ID4+Pgo+ID4+Cj4gPj4gRWFjaCByaW5nIGNhbiBvbmx5
IGJlIHVzZWQgYnkgb25lIHRocmVhZCBhdCB0aGUgc2FtZSB0aW1lLCB0aGlzCj4gPj4gaW5jbHVk
ZXMgZW1pdHRpbmcgZmVuY2VzIGFzIHdlbGwgYXMgb3RoZXIgc3R1ZmYuCj4gPj4KPiA+PiBEdXJp
bmcgR1BVIHJlc2V0IHdlIG1ha2Ugc3VyZSBub2JvZHkgd3JpdGVzIHRvIHRoZSByaW5ncyBieSBz
dG9wcGluZwo+ID4+IHRoZSBzY2hlZHVsZXIgYW5kIHRha2luZyB0aGUgR1BVIHJlc2V0IGxvY2sg
KHNvIHRoYXQgbm9ib2R5IGVsc2UgY2FuCj4gPj4gc3RhcnQgdGhlIHNjaGVkdWxlciBhZ2Fpbiku
Cj4gPgo+ID4KPiA+IFdoYXQgYWJvdXQgZGlyZWN0IHN1Ym1pc3Npb25zIG5vdCB0aHJvdWdoIHNj
aGVkdWxlciAtCj4gPiBhbWRncHVfam9iX3N1Ym1pdF9kaXJlY3QsIEkgZG9uJ3Qgc2VlIGhvdyB0
aGlzIGlzIHByb3RlY3RlZC4KPgo+IFRob3NlIG9ubHkgaGFwcGVuIGR1cmluZyBzdGFydHVwIGFu
ZCBHUFUgcmVzZXQuCj4KPiA+Pgo+ID4+Pj4KPiA+Pj4+IEJUVzogQ291bGQgaXQgYmUgdGhhdCB0
aGUgZGV2aWNlIFNSQ1UgcHJvdGVjdHMgbW9yZSB0aGFuIG9uZSBkZXZpY2UKPiA+Pj4+IGFuZCB3
ZSBkZWFkbG9jayBiZWNhdXNlIG9mIHRoaXM/Cj4gPj4+Cj4gPj4+Cj4gPj4+IEkgaGF2ZW4ndCBh
Y3R1YWxseSBleHBlcmllbmNlZCBhbnkgZGVhZGxvY2sgdW50aWwgbm93IGJ1dCwgeWVzLAo+ID4+
PiBkcm1fdW5wbHVnX3NyY3UgaXMgZGVmaW5lZCBhcyBzdGF0aWMgaW4gZHJtX2Rydi5jIGFuZCBz
byBpbiB0aGUKPiA+Pj4gcHJlc2VuY2UgIG9mIG11bHRpcGxlIGRldmljZXMgZnJvbSBzYW1lIG9y
IGRpZmZlcmVudCBkcml2ZXJzIHdlIGluCj4gPj4+IGZhY3QgYXJlIGRlcGVuZGVudCBvbiBhbGwg
dGhlaXIgY3JpdGljYWwgc2VjdGlvbnMgaSBndWVzcy4KPiA+Pj4KPiA+Pgo+ID4+IFNoaXQsIHll
YWggdGhlIGRldmlsIGlzIGEgc3F1aXJyZWwuIFNvIGZvciBBK0kgbGFwdG9wcyB3ZSBhY3R1YWxs
eQo+ID4+IG5lZWQgdG8gc3luYyB0aGF0IHVwIHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBvZiB0
aGUgaTkxNSBndXlzLgo+ID4+Cj4gPj4gSUlSQyB3ZSBjb3VsZCBhY3R1YWxseSBoYXZlIGFuIGFt
ZGdwdSBkZXZpY2UgaW4gYSBkb2NraW5nIHN0YXRpb24KPiA+PiB3aGljaCBuZWVkcyBob3RwbHVn
IGFuZCB0aGUgZHJpdmVyIG1pZ2h0IGRlcGVuZCBvbiB3YWl0aW5nIGZvciB0aGUKPiA+PiBpOTE1
IGRyaXZlciBhcyB3ZWxsLgo+ID4KPiA+Cj4gPiBDYW4ndCB3ZSBwcm9wb3NlIGEgcGF0Y2ggdG8g
bWFrZSBkcm1fdW5wbHVnX3NyY3UgcGVyIGRybV9kZXZpY2UgPyBJCj4gPiBkb24ndCBzZWUgd2h5
IGl0IGhhcyB0byBiZSBnbG9iYWwgYW5kIG5vdCBwZXIgZGV2aWNlIHRoaW5nLgo+Cj4gSSdtIHJl
YWxseSB3b25kZXJpbmcgdGhlIHNhbWUgdGhpbmcgZm9yIHF1aXRlIGEgd2hpbGUgbm93Lgo+Cj4g
QWRkaW5nIERhbmllbCBhcyB3ZWxsLCBtYXliZSBoZSBrbm93cyB3aHkgdGhlIGRybV91bnBsdWdf
c3JjdSBpcyBnbG9iYWwuCgpTUkNVIGlzbid0IGV4YWN0bHkgdGhlIGNoZWFwZXN0IHRoaW5nLCBi
dXQgYXNpZGUgZnJvbSB0aGF0IHdlIGNvdWxkCm1ha2UgaXQgcGVyLWRldmljZS4gSSdtIG5vdCBz
ZWVpbmcgdGhlIHBvaW50IG11Y2ggc2luY2UgaWYgeW91IGRvIGVuZAp1cCBiZWluZyBzdHVjayBv
biBhbiBpb2N0bCB0aGlzIG1pZ2h0IGhhcHBlbiB3aXRoIGFueXRoaW5nIHJlYWxseS4KCkFsc28g
bm90ZSB0aGF0IGRtYV9mZW5jZV93YWl0cyBhcmUgc3VwcG9zZWQgdG8gYmUgdGltZSBib3VuZCwg
c28geW91CnNob3VsZG4ndCBlbmQgdXAgd2FpdGluZyBvbiB0aGVtIGZvcmV2ZXIuIEl0IHNob3Vs
ZCBhbGwgZ2V0IHNvcnRlZCBvdXQKaW4gZHVlIHRpbWUgd2l0aCBURFIgSSBob3BlIChlLmcuIGlm
IGk5MTUgaXMgc3R1Y2sgb24gYSBmZW5jZSBiZWNhdXNlCnlvdSdyZSB1bmx1Y2t5KS4KLURhbmll
bAoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gQW5kcmV5Cj4gPgo+ID4KPiA+
Pgo+ID4+IENocmlzdGlhbi4KPiA+Pgo+ID4+PiBBbmRyZXkKPiA+Pj4KPiA+Pj4KPiA+Pj4+Cj4g
Pj4+PiBDaHJpc3RpYW4uCj4gPj4+Pgo+ID4+Pj4+IEFuZHJleQo+ID4+Pj4+Cj4gPj4+Pj4KPiA+
Pj4+Pj4KPiA+Pj4+Pj4+IEFuZHJleQo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+Pj4KPiA+
Pj4+Pj4+PiBDaHJpc3RpYW4uCj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gICAgIC8qIFBhc3QgdGhp
cyBwb2ludCBubyBtb3JlIGZlbmNlIGFyZSBzdWJtaXR0ZWQgdG8gSFcgcmluZwo+ID4+Pj4+Pj4+
PiBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNlIHNpZ25hbCBvbiBhbGwgdGhhdCBh
cmUKPiA+Pj4+Pj4+Pj4gY3VycmVudGx5IHRoZXJlLgo+ID4+Pj4+Pj4+PiAgICAgICogQW55IHN1
YnNlcXVlbnRseSBjcmVhdGVkICBIVyBmZW5jZXMgd2lsbCBiZSByZXR1cm5lZAo+ID4+Pj4+Pj4+
PiBzaWduYWxlZCB3aXRoIGFuIGVycm9yIGNvZGUgcmlnaHQgYXdheQo+ID4+Pj4+Pj4+PiAgICAg
ICovCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+ICAgICBmb3JfZWFjaF9yaW5nKGFkZXYpCj4gPj4+
Pj4+Pj4+ICAgICAgICAgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MocmluZykKPiA+Pj4+Pj4+Pj4KPiA+
Pj4+Pj4+Pj4gICAgIGRybV9kZXZfdW5wbHVnKGRldik7Cj4gPj4+Pj4+Pj4+ICAgICBTdG9wIHNj
aGVkdWxlcnMKPiA+Pj4+Pj4+Pj4gICAgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1ZXVl
ZCB3b3Jrcyk7Cj4gPj4+Pj4+Pj4+ICAgICBod19maW5pCj4gPj4+Pj4+Pj4+ICAgICB1bm1hcF9t
bWlvCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IH0KPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4KPiA+
Pj4+Pj4+Pj4gQW5kcmV5Cj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4g
QWx0ZXJuYXRpdmVseSBncmFiYmluZyB0aGUgcmVzZXQgd3JpdGUgc2lkZSBhbmQgc3RvcHBpbmcK
PiA+Pj4+Pj4+Pj4+Pj4+PiBhbmQgdGhlbiByZXN0YXJ0aW5nIHRoZSBzY2hlZHVsZXIgY291bGQg
d29yayBhcyB3ZWxsLgo+ID4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFu
Lgo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+PiBJIGRpZG4n
dCBnZXQgdGhlIGFib3ZlIGFuZCBJIGRvbid0IHNlZSB3aHkgSSBuZWVkIHRvIHJldXNlCj4gPj4+
Pj4+Pj4+Pj4+PiB0aGUgR1BVIHJlc2V0IHJ3X2xvY2suIEkgcmVseSBvbiB0aGUgU1JDVSB1bnBs
dWcgZmxhZyBmb3IKPiA+Pj4+Pj4+Pj4+Pj4+IHVucGx1Zy4gQWxzbywgbm90IGNsZWFyIHRvIG1l
IHdoeSBhcmUgd2UgZm9jdXNpbmcgb24gdGhlCj4gPj4+Pj4+Pj4+Pj4+PiBzY2hlZHVsZXIgdGhy
ZWFkcywgYW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJhdGUgSFcgZmVuY2VzCj4gPj4+Pj4+Pj4+Pj4+
PiBzaG91bGQgYmUgY292ZXJlZCwgc28gYW55IGNvZGUgbGVhZGluZyB0bwo+ID4+Pj4+Pj4+Pj4+
Pj4gYW1kZ3B1X2ZlbmNlX2VtaXQgbmVlZHMgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50IHN1Y2gg
YXMsCj4gPj4+Pj4+Pj4+Pj4+PiBkaXJlY3QgSUIgc3VibWlzc2lvbnMsIFZNIGZsdXNoZXMgZS50
LmMKPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4gWW91IG5lZWQgdG8gd29yayB0b2dldGhl
ciB3aXRoIHRoZSByZXNldCBsb2NrIGFueXdheSwgY2F1c2UKPiA+Pj4+Pj4+Pj4+Pj4gYSBob3Rw
bHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGEgcmVzZXQuCj4gPj4+Pj4+Pj4+Pj4K
PiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+IEZvciBnb2luZyBteSB3YXkgaW5kZWVkIG5vdyBJ
IHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gdGFrZQo+ID4+Pj4+Pj4+Pj4+IHJlc2V0IHdyaXRlIHNp
ZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIHNpZ25hbGxpbmcgaW4gb3JkZXIKPiA+Pj4+Pj4+Pj4+
PiB0byBwcm90ZWN0IGFnYWluc3Qgc2NoZWR1bGVyL0hXIGZlbmNlcyBkZXRhY2htZW50IGFuZAo+
ID4+Pj4+Pj4+Pj4+IHJlYXR0YWNobWVudCBkdXJpbmcgc2NoZWR1bGVycyBzdG9wL3Jlc3RhcnQu
IEJ1dCBpZiB3ZSBnbwo+ID4+Pj4+Pj4+Pj4+IHdpdGggeW91ciBhcHByb2FjaCAgdGhlbiBjYWxs
aW5nIGRybV9kZXZfdW5wbHVnIGFuZCBzY29waW5nCj4gPj4+Pj4+Pj4+Pj4gYW1kZ3B1X2pvYl90
aW1lb3V0IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2gKPiA+Pj4+Pj4+
Pj4+PiB0byBwcmV2ZW50IGFueSBjb25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4g
SW4gZmFjdAo+ID4+Pj4+Pj4+Pj4+IEkgYWxyZWFkeSBkbyBpdCBhbnl3YXkgLQo+ID4+Pj4+Pj4+
Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJGY29t
bWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVk
YTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5ncm9kem92c2t5JTQw
YW1kLmNvbSU3Q2VlZmE5YzkwZWQ4YzQwNWVjM2I3MDhkOGZjNDZkYWFhJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUzNjcyODU1MDg4NDc0MCU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1VaU5hSkUlMkJINDVp
WW1id1NEbk1TS1pTNXowaWFrMGZObGJiZllxS1MySm8lM0QmYW1wO3Jlc2VydmVkPTAKPiA+Pj4+
Pj4+Pj4+Cj4gPj4+Pj4+Pj4+PiBZZXMsIGdvb2QgcG9pbnQgYXMgd2VsbC4KPiA+Pj4+Pj4+Pj4+
Cj4gPj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Cj4gPj4+
Pj4+Pj4+Pj4gQW5kcmV5Cj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+
Pgo+ID4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4gPj4+Pj4+Pj4+Pj4+
Cj4gPj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4gPj4+Pj4+Pj4+Pj4+Pgo+
ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4gPj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+
Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+
Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkK
PiA+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+
Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Cj4g
Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Cj4gPj4+Pgo+ID4+Cj4KCgotLSAKRGFuaWVs
IFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cu
ZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
