Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A099EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 10:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459BD224B8
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 10:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459BD224B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3ED96E092;
	Mon, 11 Jan 2021 10:16:17 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957DC6E087;
 Mon, 11 Jan 2021 10:16:16 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id ga15so23924302ejb.4;
 Mon, 11 Jan 2021 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xhmTKRqLarXlSW1GRT4yOeWPCmzkJd+9PMrZ1OwcOIc=;
 b=rpxAnY1kI94A7pc84z4Ib2ZPZEIi2wQsupk+fq72stXlHiIbIipwwOiRasowRLpCbk
 WBSe+ZltKqUWZXt3XCXrwXbk136j+4ozbQUnk9rQaPfpvbPFVhql56errV2BKoigUe8F
 mOsKV7q0lmt9pQBoFg3Fk4hUwIAls69EXsc0wtrd55p/32shK1rvV8rQ6xdEEyhZa6Ta
 SiCepIgeRCf06MkuFnzoee9uMA4c/BksiRXho2W0Qf2+vSHfjTEdvIw8vbY/F0G3lkAH
 Nd771pW53X4sMzNjfilpqbMT5G1D8w9Jabx1ujbHJypx5Uk4mZkIhl6v+xJvHahC7XIg
 T4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=xhmTKRqLarXlSW1GRT4yOeWPCmzkJd+9PMrZ1OwcOIc=;
 b=MpMpysDeD6p4LgPaECX1NDsHzvcTZ5FkCg3LyhRVLrEDS2kDpOJgJpy9UusqOTdtO3
 qpzVMfUQnEQ1JPl4/XgSMHMImTSHnT2/VdGsdZhFzFteYyHeB7057UhPCDVY4yxI8ZQE
 zvQ94MUkl+oy6TrMSFO+JW/rkm5ZmmmcprW18NEGtBsBX/SXfMN3DgP2iUROOAKvTflf
 21IKeUQNF0o1t8wXhq1Q9Yf72txT+4d9TCNfJFnTRzL0hleCYFSHIQEJ9dvbIIdDJcf7
 QPgEbNDbDS9calN1lq/XwrgGPrY/+paixRzx4LPH68qt+FQm5674Wt3eW5RGclWsGRZ8
 oKwg==
X-Gm-Message-State: AOAM531rH2P0qkfDB8za4k67GntTH2rfx5FoVjXVg4V70WWkUsghU2qO
 IXTeW4SDiarIuCFrNAUB0MPJkjvCiQ4=
X-Google-Smtp-Source: ABdhPJyQncunVqg3cAwjnB9XZIqEbYRlbDaHalZ3ivXuTdormD5bHyWH2ETEaz6WmTXkiUGQBsyAZg==
X-Received: by 2002:a17:907:111c:: with SMTP id
 qu28mr10109014ejb.540.1610360175045; 
 Mon, 11 Jan 2021 02:16:15 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id bo20sm7495032edb.1.2021.01.11.02.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 02:16:14 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/radeon: stop re-init the TTM page pool
To: Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20210105182309.1362-1-christian.koenig@amd.com>
 <X/dN/YFtnVAIllds@phenom.ffwll.local>
 <ffa9d7f2-fe68-fb6a-8422-82b8949dbe1e@gmail.com>
 <X/hs1Rvm57zGPU8y@phenom.ffwll.local>
 <d066b08c-756c-bbef-0f30-d8c68ef92dbf@amd.com>
 <CAKMK7uGcRM8E0hYZeJCUuON7+uZnyEVtwU0HrNwhoWcw9V2uNA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <42d82248-0bec-ea1c-8d6e-d032a2e53c43@gmail.com>
Date: Mon, 11 Jan 2021 11:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGcRM8E0hYZeJCUuON7+uZnyEVtwU0HrNwhoWcw9V2uNA@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@alien8.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDEuMjEgdW0gMTY6NTMgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIEZyaSwgSmFu
IDgsIDIwMjEgYXQgMzozNiBQTSBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+IHdyb3RlOgo+PiBBbSAwOC4wMS4yMSB1bSAxNTozMSBzY2hyaWViIERhbmllbCBWZXR0
ZXI6Cj4+PiBPbiBUaHUsIEphbiAwNywgMjAyMSBhdCAwOTowODoyOVBNICswMTAwLCBDaHJpc3Rp
YW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDA3LjAxLjIxIHVtIDE5OjA3IHNjaHJpZWIgRGFuaWVs
IFZldHRlcjoKPj4+Pj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMDc6MjM6MDhQTSArMDEwMCwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4+IERyaXZlcnMgYXJlIG5vdCBzdXBwb3NlZCB0
byBpbml0IHRoZSBwYWdlIHBvb2wgZGlyZWN0bHkgYW55IG1vcmUuCj4+Pj4+Pgo+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
Pj4+PiBQbGVhc2UgaW5jbHVkZSByZXBvcnRlZC1ieSBjcmVkaXRzIGFuZCBsaW5rIHRvIHRoZSBi
dWcgcmVwb3J0cyBvbgo+Pj4+PiBsb3JlLmtlcm5lbC5vcmcgd2hlbiBtZXJnaW5nIHRoaXMuIEFs
c28gSSBndWVzcyB0aGlzIHNob3VsZCBoYXZlIGEgRml4ZXM6Cj4+Pj4+IGxpbmU/Cj4+Pj4gSSdt
IG5vdCBhd2FyZSBvZiBhIGJ1ZyByZXBvcnQsIGJ1dCB0aGUgcmVwb3J0ZWQtYnkvRml4ZXMgbGlu
ZXMgYXJlIGluZGVlZAo+Pj4+IG1pc3NpbmcuCj4+PiBUaGlzIG9uZSBoZXJlOgo+Pj4KPj4+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmRyaS1kZXZlbCUyRjIwMjAxMjMxMTA0MDIwLkdBNDUw
NCU0MHpuLnRuaWMlMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQu
Y29tJTdDM2FlZGUyMDMzNDhiNGYzMmVhMzEwOGQ4YjNlMjI0ZWMlN0MzZGQ4OTYxZmU0ODg0ZTYw
OGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDU3MTMxMTc5MjU4NDg4JTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPWJIVnc0bGoxZjhnNG9oVlRl
dUtOa2IwTEFiTHdZNk40S1dvcnRyM1Z0QW8lM0QmYW1wO3Jlc2VydmVkPTAKPj4+Cj4+PiBPciBk
aWQgSSBnZXQgY29uZnVzZWQsIGFuZCB0aGUgYWJvdmUgaXMgeWV0IGFub3RoZXIgYnVnPwo+PiBZ
ZWFoLCBidXQgdGhhdCB3YXMganVzdCByZXBvcnRlZCBieSBtYWlsLiBUaGUgYnVnIHRyYWNrZXIg
SSd2ZSBzYXcgd2FzCj4+IG9wZW5lZCBhZnRlciB0aGUgcGF0Y2ggd2FzIGFscmVhZHkgcHVzaGVk
Lgo+IFN0aWxsIGdvb2QgdG8gZ2l2ZSByZXBvcnRlZC1ieSBjcmVkaXRzIGZvciBtYWlsaW5nIGxp
c3QgcmVwb3J0cyBhbmQKPiBsaW5rIHRvIGxvcmUua2VybmVsLm9yZyBmb3IgdGhlIHJlcG9ydCwg
dGhhdCdzIG5vdCBqdXN0IHVzZWZ1bCBmb3IKPiBidWd6aWxsYSByZXBvcnRzLgoKVGhhdCdzIGlu
ZGVlZCB0cnVlLCBidXQgSSB3YXMgZGlzdHJhY3RlZCBieSB0aGUgZmFjdCB0aGF0IGRybS1taXNj
LWZpeGVzIAp3YXNuJ3QgdXAgdG8gZGF0ZSA6KQoKR29pbmcgdG8gYWRkIHRoYXQgZWFybGllciBu
ZXh0IHRpbWUuCgo+Pj4+IEJUVzogQW55IGlkZWEgd2h5IGRpbSBhZGQtbGluayBkb2Vzbid0IHdv
cms/Cj4+PiBIbSB3ZSBvY2Nhc2lvbmFsbHkgaGF2ZSBmdW4gd2l0aCBlbWFpbCBwYXJzaW5nIChp
dCdzIGhhcmQpIGFuZCBlc3BlY2lhbGx5Cj4+PiBweXRob24gY2hhbmdlcyBpbiBob3cgZW5jb2Rp
bmdzIGFyZSBoYW5kbGVkIGRpZmZlcmVudGx5IGJldHdlZW4gcHl0aG9uMgo+Pj4gYW5kIHB5dGhv
bjMuIElmIHlvdSBoYXZlIGEgc3BlY2lmaWMgZXhhbXBsZSBJIGNhbiB0cnkgYW5kIHRha2UgYSBs
b29rIHdoeQo+Pj4gaXQgZG9lc24ndCB3b3JrLgo+PiBJdCBqdXN0IGxvb2tzIHVwIGFuZCBkb2Vz
bid0IHNlZW0gdG8gZG8gYW55dGhpbmcuIEknbSBub3QgZmFtaWxpYXIgd2l0aAo+PiBweXRob24g
c28gSSBjYW4ganVzdCBkZXNjcmliZSB0aGUgc3ltcHRvbXMuCj4gSSBtZWFudCB0ZWxsIG1lIHdo
aWNoIG1haWwgKHBhdGNod29yayBvciBsb3JlKSBhbmQgSSdsbCB0cnkgdG8KPiByZXByb2R1Y2Ug
YW5kIHNlZSB3aGF0J3MgbWF5YmUgdXAuCgpJdCBkb2Vzbid0IHNlZW0gdG8gd29yayBpbiBnZW5l
cmFsLiBFLmcuIGFueSBwYXRjaCBJIHRyeSBJIGp1c3QgZG9uJ3QgCmdldCBhbnkgcHJvZ3Jlc3Mg
aW4gb3ZlciAxMCBNaW51dGVzLgoKTWF5YmUgc29tZSBzZXJ2ZXIgaXMgbm90IHJlc3BvbmRpbmc/
CgpDaHJpc3RpYW4uCgo+IC1EYW5pZWwKPgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiAtRGFuaWVsCj4+
Pgo+Pj4+PiBBbmQgbWF5YmUgc29tZSB3b3JkcyBvbiBob3cvd2h5IHN0dWZmIGJsb3dzIHVwLgo+
Pj4+IEp1c3QgYSB0eXBvLiBJJ3ZlIGZvcmdvdCB0byByZW1vdmUgdHdvIGxpbmVzIGluIHJhZGVv
biB3aGlsZSByZWJhc2luZyBhbmQKPj4+PiBzdGlsbCBoYWQgdGhlIHN5bWJvbHMgZXhwb3J0ZWQg
c28gbmV2ZXIgbm90aWNlZCB0aGlzLgo+Pj4+Cj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+IC1E
YW5pZWwKPj4+Pj4KPj4+Pj4+IC0tLQo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3R0bS5jIHwgMyAtLS0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlv
bnMoLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwo+Pj4+Pj4g
aW5kZXggZDQzMjhmZjU3NzU3Li4zNWI3MTVmODJlZDggMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPj4+Pj4+IEBAIC03MjksOSArNzI5LDYgQEAgaW50IHJh
ZGVvbl90dG1faW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKPj4+Pj4+ICAgICAgICAg
ICAgIH0KPj4+Pj4+ICAgICAgICAgICAgIHJkZXYtPm1tYW4uaW5pdGlhbGl6ZWQgPSB0cnVlOwo+
Pj4+Pj4gLSAgdHRtX3Bvb2xfaW5pdCgmcmRldi0+bW1hbi5iZGV2LnBvb2wsIHJkZXYtPmRldiwg
cmRldi0+bmVlZF9zd2lvdGxiLAo+Pj4+Pj4gLSAgICAgICAgICAgICAgICBkbWFfYWRkcmVzc2lu
Z19saW1pdGVkKCZyZGV2LT5wZGV2LT5kZXYpKTsKPj4+Pj4+IC0KPj4+Pj4+ICAgICAgICAgICAg
IHIgPSByYWRlb25fdHRtX2luaXRfdnJhbShyZGV2KTsKPj4+Pj4+ICAgICAgICAgICAgIGlmIChy
KSB7Cj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgIERSTV9FUlJPUigiRmFpbGVkIGluaXRpYWxp
emluZyBWUkFNIGhlYXAuXG4iKTsKPj4+Pj4+IC0tCj4+Pj4+PiAyLjI1LjEKPj4+Pj4+Cj4+Pj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+Pj4g
ZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+Pj4+Pj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+Pj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGZHJpLWRldmVsJmFtcDtkYXRhPTA0JTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQw
YW1kLmNvbSU3QzNhZWRlMjAzMzQ4YjRmMzJlYTMxMDhkOGIzZTIyNGVjJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQ1NzEzMTE3OTI1ODQ4OCU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1wSHp1QXNKY1hmNUhs
QWZKN3dZWWMlMkJzaXpaaFNMQkdXWEJoQ3lWTlJDZm8lM0QmYW1wO3Jlc2VydmVkPTAKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
