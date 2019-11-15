Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E55C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 19:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14645206D9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 19:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14645206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23346E7DC;
	Fri, 15 Nov 2019 19:23:10 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F156E7DC;
 Fri, 15 Nov 2019 19:23:09 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Nov 2019 11:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; d="scan'208";a="217188853"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by orsmga002.jf.intel.com with SMTP; 15 Nov 2019 11:23:06 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 15 Nov 2019 21:23:05 +0200
Date: Fri, 15 Nov 2019 21:23:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] drm/edid: Add alternate clock for SMPTE 4K
Message-ID: <20191115192305.GM1208@intel.com>
References: <20191112075307.12574-1-Wayne.Lin@amd.com>
 <20191112075307.12574-2-Wayne.Lin@amd.com>
 <75d0e827-25b2-ceae-0484-a98af7b8b693@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75d0e827-25b2-ceae-0484-a98af7b8b693@baylibre.com>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115192305.y3rjzisahTnEco8ebeH14EsTg7EpB9Ie6LK9l6ISHyg@z>

T24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMTA6MzY6NTRBTSArMDEwMCwgTmVpbCBBcm1zdHJvbmcg
d3JvdGU6Cj4gT24gMTIvMTEvMjAxOSAwODo1MywgV2F5bmUgTGluIHdyb3RlOgo+ID4gW1doeV0K
PiA+IEluIGhkbWlfbW9kZV9hbHRlcm5hdGVfY2xvY2soKSwgaXQgYWRkcyBhbiBleGNlcHRpb24g
Zm9yIFZJQyA0Cj4gPiBtb2RlICg0MDk2eDIxNjBAMjQpIGR1ZSB0byB0aGVyZSBpcyBubyBhbHRl
cm5hdGUgY2xvY2sgZGVmaW5lZCBmb3IKPiA+IHRoYXQgbW9kZSBpbiBIRE1JMS40Yi4gQnV0IEhE
TUkyLjAgYWRkcyAyMy45OEh6IGZvciB0aGF0IG1vZGUuCj4gPiAKPiA+IFtIb3ddCj4gPiBSZW1v
dmUgdGhlIGV4Y2VwdGlvbgo+IAo+IFNob3VsZG4ndCBpdCBiZSBvbmx5IGJ5cGFzc2VkIHdoZW4g
dGhlIHNpbmsgaXMgSERNSTIgPwoKSU1PIGp1c3QgbnVrZSB0aGUgY2hlY2suIENhbid0IHNlZSBt
dWNoIGhhcm0gY29taW5nCmZyb20gYWRkaW5nIHRoZSAyMy45OEh6IG1vZGUgb24gSERNSSAxLjQg
YXMgd2VsbC4KCj4gCj4gTmVpbAo+IAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBXYXluZSBMaW4g
PFdheW5lLkxpbkBhbWQuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2RybV9lZGlk
LmMgfCAzIC0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2VkaWQuYwo+ID4gaW5kZXggZmNkN2FlMjkwNDlkLi5lZDI3ODJjNTNhOTMgMTAwNjQ0Cj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9lZGlkLmMKPiA+IEBAIC0zMTI2LDkgKzMxMjYsNiBAQCBzdGF0aWMgZW51bSBoZG1p
X3BpY3R1cmVfYXNwZWN0IGRybV9nZXRfaGRtaV9hc3BlY3RfcmF0aW8oY29uc3QgdTggdmlkZW9f
Y29kZSkKPiA+ICBzdGF0aWMgdW5zaWduZWQgaW50Cj4gPiAgaGRtaV9tb2RlX2FsdGVybmF0ZV9j
bG9jayhjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqaGRtaV9tb2RlKQo+ID4gIHsKPiA+
IC0JaWYgKGhkbWlfbW9kZS0+dmRpc3BsYXkgPT0gNDA5NiAmJiBoZG1pX21vZGUtPmhkaXNwbGF5
ID09IDIxNjApCj4gPiAtCQlyZXR1cm4gaGRtaV9tb2RlLT5jbG9jazsKPiA+IC0KPiA+ICAJcmV0
dXJuIGNlYV9tb2RlX2FsdGVybmF0ZV9jbG9jayhoZG1pX21vZGUpOwo+ID4gIH0KPiA+ICAKPiA+
IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
ZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAoKLS0gClZpbGxlIFN5cmrDpGzDpApJbnRlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
