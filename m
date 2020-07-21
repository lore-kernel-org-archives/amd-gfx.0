Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC504C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B4520792
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YcswjV5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B4520792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0617F6E51C;
	Tue, 21 Jul 2020 09:17:04 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFCB96E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:17:01 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id a21so14531765otq.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zVQSUY5HZU/pPtYoYXUGW3LmwsCziy0wve5UBkyHrrQ=;
 b=YcswjV5+sW7k4OtUfwNn9hx67gBvVQOvW9Tk9wGMNqaG/doxsM5y4CyCrpKg1usyTt
 bH/LZD0gc2etqlISZDR7lPuxTqeYU52Zx3go4OimP5DjwpVo8TuBZGGS4wLt+NCMwM1Z
 AiEtABu/1Xgz7dcByADkkFcrh14udYEoEEaDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zVQSUY5HZU/pPtYoYXUGW3LmwsCziy0wve5UBkyHrrQ=;
 b=hPpkQfL1GTtE7cR8ZL7Vy1Z6huYG+h+DfsU5sV5ZwDXi4FBOPD+VVGhRkXgoyw5gTX
 /WSqB2VdicyX0JsurHPNDHM7cAT1zju4LQG7cRVPHL51xSvCiDRCtE8UqEvv2UapOqVy
 jIrWGKOWrnaDaIcsyZCMMNDd/2RzBjlTNN64CiNrq6kF6bJw7QlNHzTxhg9H2XVHV8qe
 NVcBqOGiL9TsWvFdOwyEbsPrNJWlMJE6CUjVtMv0b+mi1ngVwm1EJArFPPzPYcvxecsz
 0FTHF8EdmOV9FNoOJRKitMl4cXyPqcA+sFlz9cx/l2Af+YN/ARR6SkkmA82wF6Wax/ex
 76rA==
X-Gm-Message-State: AOAM5308u5Z42isiAERekSVVRzZzY57ujbgHHICYD7LrlWi60u9EBXz9
 BP2sdQHXVogRMao3yGiRcdwPTPGed3OMVWigGz6O6g==
X-Google-Smtp-Source: ABdhPJxZquZ0N4eWOhwpu33exVxqqStZYn7FsvW9Ie8Zgyle1yIBJkUOzhMdXgOzZ23hXhbKc5hk6nuu/ySFzfqVga0=
X-Received: by 2002:a05:6830:1613:: with SMTP id
 g19mr22748873otr.303.1595323020252; 
 Tue, 21 Jul 2020 02:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
In-Reply-To: <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 21 Jul 2020 11:16:49 +0200
Message-ID: <CAKMK7uHcWMGnLqmNqoyYmk_UcErEZwRon-ybc9t-Joa+bHacaQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Daniel Stone <daniels@collabora.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= <thomas_os@shipmail.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Steve Pronovost <spronovo@microsoft.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdWwgMjEsIDIwMjAgYXQgMTA6NTUgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDIxLjA3LjIwIHVtIDEwOjQ3IHNjaHJp
ZWIgVGhvbWFzIEhlbGxzdHLDtm0gKEludGVsKToKPiA+Cj4gPiBPbiA3LzIxLzIwIDk6NDUgQU0s
IENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gPj4gQW0gMjEuMDcuMjAgdW0gMDk6NDEgc2Nocmll
YiBEYW5pZWwgVmV0dGVyOgo+ID4+PiBPbiBNb24sIEp1bCAyMCwgMjAyMCBhdCAwMToxNToxN1BN
ICswMjAwLCBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpCj4gPj4+IHdyb3RlOgo+ID4+Pj4gSGks
Cj4gPj4+Pgo+ID4+Pj4gT24gNy85LzIwIDI6MzMgUE0sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4g
Pj4+Pj4gQ29tZXMgdXAgZXZlcnkgZmV3IHllYXJzLCBnZXRzIHNvbWV3aGF0IHRlZGlvdXMgdG8g
ZGlzY3VzcywgbGV0J3MKPiA+Pj4+PiB3cml0ZSB0aGlzIGRvd24gb25jZSBhbmQgZm9yIGFsbC4K
PiA+Pj4+Pgo+ID4+Pj4+IFdoYXQgSSdtIG5vdCBzdXJlIGFib3V0IGlzIHdoZXRoZXIgdGhlIHRl
eHQgc2hvdWxkIGJlIG1vcmUKPiA+Pj4+PiBleHBsaWNpdCBpbgo+ID4+Pj4+IGZsYXQgb3V0IG1h
bmRhdGluZyB0aGUgYW1ka2ZkIGV2aWN0aW9uIGZlbmNlcyBmb3IgbG9uZyBydW5uaW5nCj4gPj4+
Pj4gY29tcHV0ZQo+ID4+Pj4+IHdvcmtsb2FkcyBvciB3b3JrbG9hZHMgd2hlcmUgdXNlcnNwYWNl
IGZlbmNpbmcgaXMgYWxsb3dlZC4KPiA+Pj4+IEFsdGhvdWdoIChpbiBteSBodW1ibGUgb3Bpbmlv
bikgaXQgbWlnaHQgYmUgcG9zc2libGUgdG8gY29tcGxldGVseQo+ID4+Pj4gdW50YW5nbGUKPiA+
Pj4+IGtlcm5lbC1pbnRyb2R1Y2VkIGZlbmNlcyBmb3IgcmVzb3VyY2UgbWFuYWdlbWVudCBhbmQg
ZG1hLWZlbmNlcwo+ID4+Pj4gdXNlZCBmb3IKPiA+Pj4+IGNvbXBsZXRpb24tIGFuZCBkZXBlbmRl
bmN5IHRyYWNraW5nIGFuZCBsaWZ0IGEgbG90IG9mIHJlc3RyaWN0aW9ucwo+ID4+Pj4gZm9yIHRo
ZQo+ID4+Pj4gZG1hLWZlbmNlcywgaW5jbHVkaW5nIHByb2hpYml0aW5nIGluZmluaXRlIG9uZXMs
IEkgdGhpbmsgdGhpcyBtYWtlcwo+ID4+Pj4gc2Vuc2UKPiA+Pj4+IGRlc2NyaWJpbmcgdGhlIGN1
cnJlbnQgc3RhdGUuCj4gPj4+IFllYWggSSB0aGluayBhIGZ1dHVyZSBwYXRjaCBuZWVkcyB0byB0
eXBlIHVwIGhvdyB3ZSB3YW50IHRvIG1ha2UgdGhhdAo+ID4+PiBoYXBwZW4gKGZvciBzb21lIGNy
b3NzIGRyaXZlciBjb25zaXN0ZW5jeSkgYW5kIHdoYXQgbmVlZHMgdG8gYmUKPiA+Pj4gY29uc2lk
ZXJlZC4gU29tZSBvZiB0aGUgbmVjZXNzYXJ5IHBhcnRzIGFyZSBhbHJlYWR5IHRoZXJlICh3aXRo
IGxpa2UKPiA+Pj4gdGhlCj4gPj4+IHByZWVtcHRpb24gZmVuY2VzIGFtZGtmZCBoYXMgYXMgYW4g
ZXhhbXBsZSksIGJ1dCBJIHRoaW5rIHNvbWUgY2xlYXIKPiA+Pj4gZG9jcwo+ID4+PiBvbiB3aGF0
J3MgcmVxdWlyZWQgZnJvbSBib3RoIGh3LCBkcml2ZXJzIGFuZCB1c2Vyc3BhY2Ugd291bGQgYmUg
cmVhbGx5Cj4gPj4+IGdvb2QuCj4gPj4KPiA+PiBJJ20gY3VycmVudGx5IHdyaXRpbmcgdGhhdCB1
cCwgYnV0IHByb2JhYmx5IHN0aWxsIG5lZWQgYSBmZXcgZGF5cyBmb3IKPiA+PiB0aGlzLgo+ID4K
PiA+IEdyZWF0ISBJIHB1dCBkb3duIHNvbWUgKHZlcnkpIGluaXRpYWwgdGhvdWdodHMgYSBjb3Vw
bGUgb2Ygd2Vla3MgYWdvCj4gPiBidWlsZGluZyBvbiBldmljdGlvbiBmZW5jZXMgZm9yIHZhcmlv
dXMgaGFyZHdhcmUgY29tcGxleGl0eSBsZXZlbHMgaGVyZToKPiA+Cj4gPiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRs
YWIuZnJlZWRlc2t0b3Aub3JnJTJGdGhvbWFzaCUyRmRvY3MlMkYtJTJGYmxvYiUyRm1hc3RlciUy
RlVudGFuZ2xpbmclMjUyMGRtYS1mZW5jZSUyNTIwYW5kJTI1MjBtZW1vcnklMjUyMGFsbG9jYXRp
b24ub2R0JmFtcDtkYXRhPTAyJTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3Qzg5
NzhiYmQ3ODIzZTRiNDE2NjM3MDhkODJkNTJhZGQzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzMwOTE4MDQyNDMxMjM5MCZhbXA7c2RhdGE9dFR4eDJ2Znpm
d0xNMUlCSlNxcUFaUncxNjA0UiUyRjBiSTNNd04xJTJGQmYyVlElM0QmYW1wO3Jlc2VydmVkPTAK
PiA+Cj4KPiBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyB3aWxsIGV2ZXIgYmUgcG9zc2libGUuCj4K
PiBTZWUgdGhhdCBEYW5pZWwgZGVzY3JpYmVzIGluIGhpcyB0ZXh0IGlzIHRoYXQgaW5kZWZpbml0
ZSBmZW5jZXMgYXJlIGEKPiBiYWQgaWRlYSBmb3IgbWVtb3J5IG1hbmFnZW1lbnQsIGFuZCBJIHRo
aW5rIHRoYXQgdGhpcyBpcyBhIGZpeGVkIGZhY3QuCj4KPiBJbiBvdGhlciB3b3JkcyB0aGUgd2hv
bGUgY29uY2VwdCBvZiBzdWJtaXR0aW5nIHdvcmsgdG8gdGhlIGtlcm5lbCB3aGljaAo+IGRlcGVu
ZHMgb24gc29tZSB1c2VyIHNwYWNlIGludGVyYWN0aW9uIGRvZXNuJ3Qgd29yayBhbmQgbmV2ZXIg
d2lsbC4KPgo+IFdoYXQgY2FuIGJlIGRvbmUgaXMgdGhhdCBkbWFfZmVuY2VzIHdvcmsgd2l0aCBo
YXJkd2FyZSBzY2hlZHVsZXJzLiBFLmcuCj4gd2hhdCB0aGUgS0ZEIHRyaWVzIHRvIGRvIHdpdGgg
aXRzIHByZWVtcHRpb24gZmVuY2VzLgo+Cj4gQnV0IGZvciB0aGlzIHlvdSBuZWVkIGEgYmV0dGVy
IGNvbmNlcHQgYW5kIGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhlCj4gaGFyZHdhcmUgc2NoZWR1bGVy
IGlzIHN1cHBvc2VkIHRvIGRvIGFuZCBob3cgdGhhdCBpbnRlcmFjdHMgd2l0aAo+IGRtYV9mZW5j
ZSBvYmplY3RzLgoKWWVhaCBJIHRoaW5rIHRyeWluZyB0byBzcGxpdCBkbWFfZmVuY2Ugd29udCB3
b3JrLCBzaW1wbHkgYmVjYXVzZSBvZgppbmVydGlhLiBDcmVhdGluZyBhbiBlbnRpcmVseSBuZXcg
dGhpbmcgZm9yIGF1Z21lbnRlZCB1c2Vyc3BhY2UKY29udHJvbGxlZCBmZW5jaW5nLCBhbmQgdGhl
biBqb3R0aW5nIGRvd24gYWxsIHRoZSBydWxlcyB0aGUKa2VybmVsL2h3L3VzZXJzcGFjZSBuZWVk
IHRvIG9iZXkgdG8gbm90IGJyZWFrIGRtYV9mZW5jZSBpcyB3aGF0IEkgaGFkCmluIG1pbmQuIEFu
ZCBJIGd1ZXNzIHRoYXQncyBhbHNvIHdoYXQgQ2hyaXN0aWFuIGlzIHdvcmtpbmcgb24uIEUuZy4K
anVzdCBnb2luZyB0aHJvdWdoIGFsbCB0aGUgY2FzZXMgb2YgaG93IG11Y2ggeW91ciBodyBjYW4g
cHJlZW1wdCBvcgpoYW5kbGUgcGFnZSBmYXVsdHMgb24gdGhlIGdwdSwgYW5kIHdoYXQgdGhhdCBt
ZWFucyBpbiB0ZXJtcyBvZgpkbWFfZmVuY2VfYmVnaW4vZW5kX3NpZ25hbGxpbmcgYW5kIG90aGVy
IGNvbnN0cmFpbnRzIHdvdWxkIGJlIHJlYWxseQpnb29kLgotRGFuaWVsCgo+Cj4gQ2hyaXN0aWFu
Lgo+Cj4gPgo+ID4gL1Rob21hcwo+ID4KPiA+Cj4KCgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2Fy
ZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
