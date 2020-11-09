Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D116C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 15:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCA9206E3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 15:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCA9206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB5B8984D;
	Mon,  9 Nov 2020 15:25:38 +0000 (UTC)
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6438984D;
 Mon,  9 Nov 2020 15:25:37 +0000 (UTC)
Received: from ravnborg.org (unknown [188.228.123.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id C30C58053A;
 Mon,  9 Nov 2020 16:25:32 +0100 (CET)
Date: Mon, 9 Nov 2020 16:25:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 10/19] drm/radeon/radeon: Move prototype into shared header
Message-ID: <20201109152530.GA1888045@ravnborg.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-11-lee.jones@linaro.org>
 <20201107142651.GA1014611@ravnborg.org>
 <20201109110603.GV2063125@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201109110603.GV2063125@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
 a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
 a=IkcTkHD0fZMA:10 a=0bRNquZ1QDSsZ4hO3z4A:9 a=QEXdDO2ut3YA:10
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTGVlLAo+ID4gCj4gPiBPdGhlciBwdWJsaWMgZnVuY3Rpb25zIGluIHJhZGVvbl9kZXZpY2Uu
YyBoYXZlIHRoZWlyIHByb3RvdHlwZSBpbgo+ID4gcmFkZW9uLmggLSBmb3IgZXhhbXBsZSByYWRl
b25faXNfcHgoKQo+ID4gCj4gPiBBZGQgcmFkZW9uX2RldmljZV9pc192aXJ0dWFsKCkgdGhlcmUg
c28gd2UgYXZvaWlkIHRoaXMgbmV3IGhlYWRlci4KPiAKPiBPaCB5ZXMsIEkgcmVtZW1iZXIgd2h5
IHRoaXMgd2Fzbid0IGEgc3VpdGFibGUgc29sdXRpb24gbm93Ogo+IAo+IFRoZSBtYWNybyAicmFk
ZW9uX2luaXQiIGluIHJhZGVvbi5oIGNsYXNoZXMgd2l0aCB0aGUgaW5pdCBmdW5jdGlvbiBvZgo+
IHRoZSBzYW1lIG5hbWUgaW4gcmFkZW9uX2Rydi5jOgo+IAo+ICAgSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jOjUzOgo+ICAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmM6NjIwOjMxOiBlcnJvcjogZXhwZWN0ZWQgaWRlbnRp
ZmllciBvciDigJgo4oCZIGJlZm9yZSDigJh2b2lk4oCZCj4gICA2MjAgfCBzdGF0aWMgaW50IF9f
aW5pdCByYWRlb25faW5pdCh2b2lkKQouLi4KPiAKPiBIb3cgd291bGQgeW91IGxpa2UgbWUgdG8g
bW92ZSBmb3J3YXJkPwoKRml4IHRoZSB0aG91c2FuZCBvZiB3YXJuaW5ncyBpbiBvdGhlciBwbGFj
ZXMgOi0pCkkgd2lsbCB0YWtlIGEgbG9vayBhdCByYWRlb24gYW5kIHBvc3QgYSBuZXcgc2VyaWVz
IGJhc2VkIG9uIHlvdXIgd29yawp3aXRoIGFsbCBXPTEgd2FybmluZ3MgZml4ZWQuCgoJU2FtCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
