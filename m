Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE8C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCF5222A0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 14:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCF5222A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003B76E943;
	Tue, 19 Nov 2019 14:56:56 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2AB6E943;
 Tue, 19 Nov 2019 14:56:53 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 06:56:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; d="scan'208";a="204420318"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by fmsmga008.fm.intel.com with SMTP; 19 Nov 2019 06:56:50 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Tue, 19 Nov 2019 16:56:49 +0200
Date: Tue, 19 Nov 2019 16:56:49 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: mikita.lipski@amd.com
Subject: Re: [PATCH] drm/dsc: Return unsigned long on compute offset
Message-ID: <20191119145649.GZ1208@intel.com>
References: <20191119144526.31797-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191119144526.31797-1-mikita.lipski@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119145649.4sc-i5xk-CAfy4a5Is0h3LwuvQuvhiTOZoi2N4aICWg@z>

T24gVHVlLCBOb3YgMTksIDIwMTkgYXQgMDk6NDU6MjZBTSAtMDUwMCwgbWlraXRhLmxpcHNraUBh
bWQuY29tIHdyb3RlOgo+IEZyb206IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNv
bT4KPiAKPiBXZSBzaG91bGRuJ3QgY29tcGFyZSBpbnQgd2l0aCB1bnNpZ25lZCBsb25nIHRvIGZp
bmQgdGhlIG1heCB2YWx1ZQo+IGFuZCBzaW5jZSB3ZSBhcmUgbm90IGV4cGVjdGluZyBuZWdhdGl2
ZSB2YWx1ZSByZXR1cm5lZCBmcm9tCj4gY29tcHV0ZV9vZmZzZXQgd2Ugc2hvdWxkIG1ha2UgdGhp
cyBmdW5jdGlvbiByZXR1cm4gdW5zaWduZWQgbG9uZwo+IHNvIHdlIGNhbiBjb21wYXJlIHRoZSB2
YWx1ZXMgd2hlbiBjb21wdXRpbmcgcmMgcGFyYW1ldGVycy4KCldoeSBhcmUgdGhlcmUgb3RoZXIg
dW5zaWduZWQgbG9uZ3MgaW4gZHNjIHBhcmFtZXRlciBjb21wdXRhdGlvbgppbiB0aGUgZmlyc3Qg
cGxhY2U/Cgo+IAo+IENjOiBOaWtvbGEgQ29ybmlqIDxuaWtvbGEuY29ybmlqQGFtZC5jb20+Cj4g
Q2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9ncHUvZHJtL2RybV9kc2MuYyB8IDYgKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZHNjLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5jCj4gaW5kZXggNzRmMzUyN2Y1
NjdkLi5lYzQwNjA0YWI2YTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kc2Mu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMKPiBAQCAtMjQ1LDExICsyNDUsMTEg
QEAgdm9pZCBkcm1fZHNjX3Bwc19wYXlsb2FkX3BhY2soc3RydWN0IGRybV9kc2NfcGljdHVyZV9w
YXJhbWV0ZXJfc2V0ICpwcHNfcGF5bG9hZCwKPiAgfQo+ICBFWFBPUlRfU1lNQk9MKGRybV9kc2Nf
cHBzX3BheWxvYWRfcGFjayk7Cj4gIAo+IC1zdGF0aWMgaW50IGNvbXB1dGVfb2Zmc2V0KHN0cnVj
dCBkcm1fZHNjX2NvbmZpZyAqdmRzY19jZmcsIGludCBwaXhlbHNfcGVyX2dyb3VwLAo+ICtzdGF0
aWMgdW5zaWduZWQgbG9uZyBjb21wdXRlX29mZnNldChzdHJ1Y3QgZHJtX2RzY19jb25maWcgKnZk
c2NfY2ZnLCBpbnQgcGl4ZWxzX3Blcl9ncm91cCwKPiAgCQkJCWludCBncm91cHNfcGVyX2xpbmUs
IGludCBncnBjbnQpCj4gIHsKPiAtCWludCBvZmZzZXQgPSAwOwo+IC0JaW50IGdycGNudF9pZCA9
IERJVl9ST1VORF9VUCh2ZHNjX2NmZy0+aW5pdGlhbF94bWl0X2RlbGF5LCBwaXhlbHNfcGVyX2dy
b3VwKTsKPiArCXVuc2lnbmVkIGxvbmcgb2Zmc2V0ID0gMDsKPiArCXVuc2lnbmVkIGxvbmcgZ3Jw
Y250X2lkID0gRElWX1JPVU5EX1VQKHZkc2NfY2ZnLT5pbml0aWFsX3htaXRfZGVsYXksIHBpeGVs
c19wZXJfZ3JvdXApOwo+ICAKPiAgCWlmIChncnBjbnQgPD0gZ3JwY250X2lkKQo+ICAJCW9mZnNl
dCA9IERJVl9ST1VORF9VUChncnBjbnQgKiBwaXhlbHNfcGVyX2dyb3VwICogdmRzY19jZmctPmJp
dHNfcGVyX3BpeGVsLCAxNik7Cj4gLS0gCj4gMi4xNy4xCj4gCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4g
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCgotLSAKVmlsbGUgU3lyasOkbMOkCklu
dGVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
