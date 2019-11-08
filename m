Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35684C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8CF2178F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8CF2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0DB46F9EA;
	Fri,  8 Nov 2019 16:06:57 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA986F942
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 11:24:46 +0000 (UTC)
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id c76056e31ef5e5d1; Fri, 8 Nov 2019 12:24:42 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/5] power: avs: smartreflex: Remove superfluous cast in
 debugfs_create_file() call
Date: Fri, 08 Nov 2019 12:24:42 +0100
Message-ID: <4367615.jSCgeRn5tF@kreacher>
In-Reply-To: <20191021145149.31657-5-geert+renesas@glider.be>
References: <20191021145149.31657-1-geert+renesas@glider.be>
 <20191021145149.31657-5-geert+renesas@glider.be>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Nov 2019 16:06:56 +0000
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
Cc: Nishanth Menon <nm@ti.com>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 dri-devel@lists.freedesktop.org, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
 Breno =?ISO-8859-1?Q?Leit=E3o?= <leitao@debian.org>, David@rox.of.borg,
 Herbert Xu <herbert@gondor.apana.org.au>, Kevin Hilman <khilman@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>,
 amd-gfx@lists.freedesktop.org, Casey Leedom <leedom@chelsio.com>,
 linux-pm@vger.kernel.org, Pensando Drivers <drivers@pensando.io>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Paul Mackerras <paulus@samba.org>, Shannon Nelson <snelson@pensando.io>,
 linuxppc-dev@lists.ozlabs.org,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108112442.qeCPfaQ-PUbXNt61nwBbe3aIktH5P8UIPD3rwt7133A@z>

T24gTW9uZGF5LCBPY3RvYmVyIDIxLCAyMDE5IDQ6NTE6NDggUE0gQ0VUIEdlZXJ0IFV5dHRlcmhv
ZXZlbiB3cm90ZToKPiBUaGVyZSBpcyBubyBuZWVkIHRvIGNhc3QgYSB0eXBlZCBwb2ludGVyIHRv
IGEgdm9pZCBwb2ludGVyIHdoZW4gY2FsbGluZwo+IGEgZnVuY3Rpb24gdGhhdCBhY2NlcHRzIHRo
ZSBsYXR0ZXIuICBSZW1vdmUgaXQsIGFzIHRoZSBjYXN0IHByZXZlbnRzCj4gZnVydGhlciBjb21w
aWxlciBjaGVja3MuCj4gCj4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZT4KCkdyZWcsIGhhdmUgeW91IHRha2VuIHRoaXMgb25lIGJ5IGFu
eSBjaGFuY2U/Cgo+IC0tLQo+ICBkcml2ZXJzL3Bvd2VyL2F2cy9zbWFydHJlZmxleC5jIHwgMiAr
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9hdnMvc21hcnRyZWZsZXguYyBiL2RyaXZlcnMvcG93
ZXIvYXZzL3NtYXJ0cmVmbGV4LmMKPiBpbmRleCA0Njg0ZTdkZjgzM2E4MWU5Li41Mzc2ZjNkMjJm
MzFlYWRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcG93ZXIvYXZzL3NtYXJ0cmVmbGV4LmMKPiAr
KysgYi9kcml2ZXJzL3Bvd2VyL2F2cy9zbWFydHJlZmxleC5jCj4gQEAgLTkwNSw3ICs5MDUsNyBA
QCBzdGF0aWMgaW50IG9tYXBfc3JfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
PiAgCXNyX2luZm8tPmRiZ19kaXIgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoc3JfaW5mby0+bmFtZSwg
c3JfZGJnX2Rpcik7Cj4gIAo+ICAJZGVidWdmc19jcmVhdGVfZmlsZSgiYXV0b2NvbXAiLCBTX0lS
VUdPIHwgU19JV1VTUiwgc3JfaW5mby0+ZGJnX2RpciwKPiAtCQkJICAgICh2b2lkICopc3JfaW5m
bywgJnBtX3NyX2ZvcHMpOwo+ICsJCQkgICAgc3JfaW5mbywgJnBtX3NyX2ZvcHMpOwo+ICAJZGVi
dWdmc19jcmVhdGVfeDMyKCJlcnJ3ZWlnaHQiLCBTX0lSVUdPLCBzcl9pbmZvLT5kYmdfZGlyLAo+
ICAJCQkgICAmc3JfaW5mby0+ZXJyX3dlaWdodCk7Cj4gIAlkZWJ1Z2ZzX2NyZWF0ZV94MzIoImVy
cm1heGxpbWl0IiwgU19JUlVHTywgc3JfaW5mby0+ZGJnX2RpciwKPiAKCgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
