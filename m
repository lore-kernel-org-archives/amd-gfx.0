Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BAC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 15:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A0960FD8
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 15:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A0960FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24ACA6E03D;
	Mon, 21 Jun 2021 15:53:30 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1501B6E1F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 15:53:28 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so18211636otl.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9ZbRwuIdQDNCcz/pnU9BDxlzoJgaD/x3T5Lkco7n4mA=;
 b=W3Z0uj9rKqdn6ZJWrTqOx/GtU569/5Kcpkjwszw5lCOk8Gp6wuyWlqD3Byp4rw7G8X
 H3GmU5dUycsvTjdwpOEFg0p5gVdvqtlcSZhrwPFr95/yWe267UjjvfxbxHiPNzA0zDC0
 1YhasX4QWal1E+Z/ANTRSPBCkY1v4jwrVzhb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9ZbRwuIdQDNCcz/pnU9BDxlzoJgaD/x3T5Lkco7n4mA=;
 b=F4y6P9EN71eympBu+F42xrEKlYqEh7hwtlxUt6h51InjYySdOa1FumL4qyiZdPjKy7
 LuPqe/nGi3JIBNlYiBYxcAM+dy8ATQn68DQBdrK+WBobhuSA7w4plJdOmPwdMq5aRIaq
 JVLVeqSa14HBZVBu1aeR2MQUTIaiu5Jjm5ymn/MFFccqmLF7dsziaiEoxep2WBq2y+Pw
 1ag4AG4D/+mRiAb/354cxrEH9VAJ/wX1mJeSZkh2ayVNhqnF7iJtyvJIF19cAefQ70z0
 XLqSlxuRPu8kXTuMSwsENBCZLd/cDuH1TXj/mNL8CkuCPdwJKzc2Ek5S0cJGzqT6xeoy
 GqRg==
X-Gm-Message-State: AOAM5309OWrsefweiY3DCIpH+awhyWjFF752jKZhDUpWEZ+vNHmcrOqH
 wcscdn3rKqHxbveC2o2azP/EXaXZNOFrGSJ3ORE5fw==
X-Google-Smtp-Source: ABdhPJytSq1TwW8sX7+Gd2OBgr6JZnE1MbVUqfwzWKowqyJPkP+thwgGRIJhAysYcpdKL8914lI9tz4uvczAUxKpTh8=
X-Received: by 2002:a05:6830:2370:: with SMTP id
 r16mr21533959oth.188.1624290808187; 
 Mon, 21 Jun 2021 08:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210621130328.11070-1-christian.koenig@amd.com>
 <YNCoK1qv6CCIy0Rl@phenom.ffwll.local>
 <2033755d-c49f-8b90-f726-d640146a3df7@gmail.com>
In-Reply-To: <2033755d-c49f-8b90-f726-d640146a3df7@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 21 Jun 2021 17:53:15 +0200
Message-ID: <CAKMK7uEET_E7eJa1No3KLMBudgE16ymXzXZp0CRYt_ZjS-_YsA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/nouveau: wait for moving fence after pinning
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
Cc: Nouveau Dev <nouveau@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gMjEsIDIwMjEgYXQgNTo0OSBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMS4wNi4yMSB1bSAxNjo1
NCBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gPiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAwMzow
MzoyNlBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4+IFdlIGFjdHVhbGx5IG5l
ZWQgdG8gd2FpdCBmb3IgdGhlIG1vdmluZyBmZW5jZSBhZnRlciBwaW5uaW5nCj4gPj4gdGhlIEJP
IHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBwaW4gaXMgY29tcGxldGVkLgo+ID4+Cj4gPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4+
IENDOiBzdGFibGVAa2VybmVsLm9yZwo+ID4+IC0tLQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL25v
dXZlYXUvbm91dmVhdV9wcmltZS5jIHwgOCArKysrKysrLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfcHJpbWUuYyBiL2RyaXZlcnMvZ3B1L2RybS9u
b3V2ZWF1L25vdXZlYXVfcHJpbWUuYwo+ID4+IGluZGV4IDM0NzQ4ODY4NWY3NC4uNTkxNzM4NTQ1
ZWJhIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfcHJp
bWUuYwo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfcHJpbWUuYwo+
ID4+IEBAIC05Myw3ICs5MywxMyBAQCBpbnQgbm91dmVhdV9nZW1fcHJpbWVfcGluKHN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqb2JqKQo+ID4+ICAgICAgaWYgKHJldCkKPiA+PiAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7Cj4gPj4KPiA+PiAtICAgIHJldHVybiAwOwo+ID4+ICsgICAgaWYgKG52
Ym8tPmJvLm1vdmluZykgewo+ID4gRG9uJ3Qgd2UgbmVlZCB0byBob2xkIHRoZSBkbWFfcmVzdiB0
byByZWFkIHRoaXM/IFdlIGNhbiBncmFiIGEgcmVmZXJlbmNlCj4gPiBhbmQgdGhlbiB1bmxvY2ss
IGJ1dCBJIHRoaW5rIGp1c3QgdW5sb2NrZWQgd2FpdCBjYW4gZ28gYm9vbSBwcmV0dHkgZWFzaWx5
Cj4gPiAoc2luY2Ugd2UgZG9uJ3QgaG9sZCBhIHJlZmVyZW5jZSBvciBsb2NrIHNvIHNvbWVvbmUg
ZWxzZSBjYW4ganVtcCBpbiBhbmQKPiA+IGZyZWUgdGhlIG1vdmluZyBmZW5jZSkuCj4KPiBUaGUg
bW92aW5nIGZlbmNlIGlzIG9ubHkgbW9kaWZpZWQgd2hpbGUgdGhlIEJPIGlzIG1vdmVkIGFuZCBz
aW5jZSB3ZQo+IGhhdmUganVzdCBzdWNjZXNzZnVsbHkgcGlubmVkIGl0Li4uLgoKWWVhaCAgLi4u
IHNvIHByb2JhYmx5IGNvcnJlY3QsIGJ1dCByZWFsbHkgdHJpY2t5LiBKdXN0IHdyYXBwaW5nIGEK
dHRtX2JvX3Jlc2VydmUvdW5yZXNlcnZlIGFyb3VuZCB0aGUgY29kZSB5b3UgYWRkIHNob3VsZCBi
ZSBlbm91Z2ggYW5kCmdldCB0aGUgam9iIGRvbmU/Cgo+IEJ1dCBpbiBnZW5lcmFsIEkgYWdyZWUg
dGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYXZvaWQgdGhpcy4gSSBqdXN0Cj4gZGlkbid0IHdh
bnRlZCB0byBvcGVuIGEgYmlnZ2VyIGNhbiBvZiB3b3JtcyBieSBjaGFuZ2luZyBub3V2ZWF1IHNv
IG11Y2guCgpZZWFoLCBidXQgSSdtIGtpbmRhIHRoaW5raW5nIG9mIHNvbWUgaGVscGVycyB0byB3
YWl0IGZvciB0aGUgbW92ZQpmZW5jZSAoc28gdGhhdCBsYXRlciBvbiB3ZSBjYW4gc3dpdGNoIGZy
b20gaGF2aW5nIHRoZSBleGNsdXNpdmUgZmVuY2UKdG8gdGhlIG1vdmUgZmVuY2UgZG8gdGhhdCwg
bWF5YmUpLiBBbmQgdGhlbiBsb2NraW5nIGNoZWNrcyBpbiB0aGVyZQp3b3VsZCBiZSBuaWNlLgoK
QWxzbyBhdm9pZHMgdGhlIGNhc2Ugb2YgZXhwbGFpbmluZyB3aHkgbG9ja2xlc3MgaGVyZSBpcyBm
aW5lLCBidXQKbG9ja2xlc3Mgd2FpdCBmb3IgdGhlIGV4Y2x1c2l2ZSBmZW5jZSBpbiBlLmcuIGEg
ZHluYW1pIGRtYS1idWYKaW1wb3J0ZXIgaXMgdmVyeSBtdWNoIG5vdCBmaW5lIGF0IGFsbC4gSnVz
dCBhbGwgYXJvdW5kIGxlc3MgdHJvdWJsZS4KLURhbmllbAoKPgo+IENocmlzdGlhbi4KPgo+ID4g
LURhbmllbAo+ID4KPiA+PiArICAgICAgICAgICAgcmV0ID0gZG1hX2ZlbmNlX3dhaXQobnZiby0+
Ym8ubW92aW5nLCB0cnVlKTsKPiA+PiArICAgICAgICAgICAgaWYgKHJldCkKPiA+PiArICAgICAg
ICAgICAgICAgICAgICBub3V2ZWF1X2JvX3VucGluKG52Ym8pOwo+ID4+ICsgICAgfQo+ID4+ICsK
PiA+PiArICAgIHJldHVybiByZXQ7Cj4gPj4gICB9Cj4gPj4KPiA+PiAgIHZvaWQgbm91dmVhdV9n
ZW1fcHJpbWVfdW5waW4oc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmopCj4gPj4gLS0KPiA+PiAy
LjI1LjEKPiA+Pgo+CgoKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVs
IENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
