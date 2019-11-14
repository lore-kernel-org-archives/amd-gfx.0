Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD76C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 08:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD4B2070E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 08:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD4B2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3446E46F;
	Thu, 14 Nov 2019 08:44:04 +0000 (UTC)
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch
 [185.70.40.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57566E47B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 08:44:03 +0000 (UTC)
Date: Thu, 14 Nov 2019 08:43:57 +0000
To: Daniel Vetter <daniel.vetter@ffwll.ch>
From: Simon Ser <contact@emersion.fr>
Subject: Re: drm core/helpers and MIT license
Message-ID:
 <882SQUfM7Qo1AqlUNQlQprzgc_qrO4LiunXq0RJZ1BlhlDRJ8gD3zcRs_W7yfk9pYe9oY4G_H32AgNEIXCR_m4M8eaHhNJcFed9V5bV69XQ=@emersion.fr>
In-Reply-To: <CAKMK7uH-8+tbKsAoiChsxELEc_77RVVxP2wapHWhqB+0Viifog@mail.gmail.com>
References: <CAKMK7uH-8+tbKsAoiChsxELEc_77RVVxP2wapHWhqB+0Viifog@mail.gmail.com>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emersion.fr; s=protonmail; t=1573721041;
 bh=WYQAC0bhgcB9njJqUgeyVxXjiZO85H71sfgaFnAtEss=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
 Feedback-ID:From;
 b=YdJQTQRydOeBJGb2zmNNWO543Jfb0KQmSf/OqVANB31bIJmn6QEbjfx/qC2Xbw2Kx
 Q/gj0hcKMNNUnqFeto7RLXyUNGPyUrk/CwZrh1MRflTKA6kTit14r+DejtMDm+bqbg
 W5eej0q5eJriGOK2aIW1QmqvX2Z0qsoNwXlUO+50=
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: "Nikula, Jani" <jani.nikula@linux.intel.com>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "zeising@FreeBSD.org" <zeising@FreeBSD.org>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114084357.br0pxuEUcYQSOExvlHbxpuzyuuyD2lLNkp8j7Hybd-M@z>

QWRkaW5nIHplaXNpbmdARnJlZUJTRC5vcmcgZm9yIEZyZWVCU0QuIEknbGwgdHJ5IHRvIHNlZSBp
ZiBJIGNhbiBwaW5nCnNvbWUgTmV0QlNEL09wZW5CU0QgZm9sa3MgdG9vLgoKT24gVHVlc2RheSwg
Tm92ZW1iZXIgMTIsIDIwMTkgNDowMyBQTSwgRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBm
ZndsbC5jaD4gd3JvdGU6Cgo+IEhpIGFsbCwKPgo+IERhdmUgYW5kIG1lIGNoYXR0ZWQgYWJvdXQg
dGhpcyBsYXN0IHdlZWsgb24gaXJjLiBFc3NlbnRpYWxseSB3ZSBoYXZlOgo+Cj4gJCBnaXQgZ3Jl
cCBTUERYLipHUEwgLS0gJzooZ2xvYilkcml2ZXJzL2dwdS9kcm0vYycKPiBkcml2ZXJzL2dwdS9k
cm0vZHJtX2NsaWVudC5jOi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gZHJp
dmVycy9ncHUvZHJtL2RybV9kYW1hZ2VfaGVscGVyLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAgT1IgTUlUCj4gZHJpdmVycy9ncHUvZHJtL2RybV9kcF9jZWMuYzovLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZF9s
b2FkLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiBkcml2
ZXJzL2dwdS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vci1sYXRlcgo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZm9ybWF0X2hlbHBlci5j
Oi8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi9kcml2ZXJzL2dwdS9kcm0vZHJt
X2dlbV9jbWFfaGVscGVyLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6Cj4gR1BMLTIuMC1v
ci1sYXRlcgo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX2ZyYW1lYnVmZmVyX2hlbHBlci5jOi8v
Cj4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiBkcml2ZXJzL2dw
dS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMAo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3R0bV9oZWxwZXIuYzovLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4wLW9yLWxhdGVyCj4gZHJpdmVycy9ncHUvZHJtL2Ry
bV9nZW1fdnJhbV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4w
LW9yLWxhdGVyCj4gZHJpdmVycy9ncHUvZHJtL2RybV9oZGNwLmM6Ly8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKPiBkcml2ZXJzL2dwdS9kcm0vZHJtX2xlYXNlLmM6Ly8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiBkcml2ZXJzL2dwdS9kcm0vZHJt
X21pcGlfZGJpLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIK
PiBkcml2ZXJzL2dwdS9kcm0vZHJtX29mLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb25seQo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fc2ltcGxlX2ttc19oZWxwZXIuYzovLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4wLW9yLWxhdGVyCj4gZHJpdmVycy9ncHUv
ZHJtL2RybV9zeXNmcy5jOi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkK
PiBkcml2ZXJzL2dwdS9kcm0vZHJtX3ZtYV9tYW5hZ2VyLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAgT1IgTUlUCj4gZHJpdmVycy9ncHUvZHJtL2RybV92cmFtX2hlbHBlcl9j
b21tb24uYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4wLW9yLWxhdGVyCj4g
ZHJpdmVycy9ncHUvZHJtL2RybV93cml0ZWJhY2suYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMAo+Cj4gT25lIGlzIEdQTCtNSVQsIHNvIG9rLCBhbmQgb25lIGlzIGEgZGVmYXVs
dCBHUEwtb25seSBoZWFkZXIgZnJvbQo+IEdyZWcncyBpbmZhbW91cyBwYXRjaCAoc28gY291bGQg
cHJvYmFibHkgYmUgY2hhbmdlZCB0byBNSVQgbGljZW5zZQo+IGhlYWRlcikuIEkgb25seSBsb29r
ZWQgYXQgLmMgc291cmNlcywgc2luY2UgaGVhZGVycyBhcmUgd29yc2Ugd3J0Cj4gaGF2aW5nIHF1
ZXN0aW9uYWJsZSBkZWZhdWx0IGhlYWRlcnMuIFNvIGFib3V0IDE4IGZpbGVzIHdpdGggY2xlYXIg
R1BMCj4gbGljZW5zZXMgdGh1cyBmYXIgaW4gZHJtIGNvcmUvaGVscGVycy4KPgo+IExvb2tpbmcg
YXQgd2hlcmUgdGhhdCBjb2RlIGNhbWUgZnJvbSwgaXQgaXMgbW9zdGx5IGZyb20gR1BMLW9ubHkK
PiBkcml2ZXJzICh3ZSBoYXZlIGEgbG90IG9mIHRob3NlIG5vd2FkYXlzKSwgc28gc2VlbXMgbGVn
aXQgbm9uLU1JVAo+IGxpY2Vuc2VkLiBRdWVzdGlvbiBpcyBub3cgd2hhdCBkbyB3ZSBkbzoKPgo+
IC0gICBOb3RoaW5nLCB3aGljaCBtZWFucyBHUEwgd2lsbCBzbG93bHkgZW5jcm9hY2ggb24gZHJt
IGNvcmUvaGVscGVycywKPiAgICAgd2hpY2ggaXMgcm91Z2hseSB0aGUgc2FtZSBhcyAuLi4KPgo+
IC0gICBUaHJvdyBpbiB0aGUgdG93ZWwgb24gTUlUIGRybSBjb3JlIG9mZmljaWFsbHkuIFNhbWUg
YXMgYWJvdmUsIGV4Y2VwdAo+ICAgICBsZXRzIGp1c3QgbWFrZSBpdCBvZmZpY2lhbC4KPgo+IC0g
ICBUcnkgdG8gY291bnRlciB0aGlzLCB3aGljaCBtZWFucyBhdCBsZWFzdCBhKSByZWxpY2Vuc2lu
ZyBhIGJ1bmNoIG9mCj4gICAgIHN0dWZmIGIpIHJld3JpdGluZyBhIGJ1bmNoIG9mIHN0dWZmIGMp
IG1ha2luZyBzdXJlIHRoYXQncyBvayB3aXRoCj4gICAgIGV2ZXJ5b25lLCB0aGVyZSdzIGEgbG90
IG9mIEdQTC1ieS1kZWZhdWx0IGZvciB0aGUga2VybmVsICh0aGF0J3MgaG93Cj4gICAgIHdlIGdv
dCBtb3N0IG9mIHRoZSBhYm92ZSBjb2RlIHRocm91Z2ggbWVyZ2VkIGRyaXZlcnMgSSB0aGluayku
IEkKPiAgICAgc3VzcGVjdCB0aGF0IHdob21ldmVyIGNhcmVzIHdpbGwgbmVlZCB0byBwdXQgaW4g
dGhlIHdvcmsgdG8gbWFrZSB0aGlzCj4gICAgIGhhcHBlbiAoc2luY2UgaXQgd2lsbCBuZWVkIGEg
cGlsZSBvZiBhY3RpdmUgcmVzaXN0YW5jZSBhdCBsZWFzdCkuCj4KPiAgICAgQ2MgbWFpbnRhaW5l
cnMvZHJpdmVyIHRlYW1zIHdobyBtaWdodCBjYXJlIG1vc3QgYWJvdXQgdGhpcy4KPgo+ICAgICBB
bHNvIGlmIHBlb3BsZSBjb3VsZCBjYyAqYnNkLCB0aGV5IHByb2JhYmx5IGNhcmUgYW5kIEkgZG9u
J3Qga25vdyBiZXN0Cj4gICAgIGNvbnRhY3RzIGZvciBncmFwaGljcyBzdHVmZiAob3IgYW55dGhp
bmcgZWxzZSByZWFsbHkgYXQgYWxsKS4KPgo+ICAgICBDaGVlcnMsIERhbmllbAo+ICAgICAtLQo+
ICAgICBEYW5pZWwgVmV0dGVyCj4gICAgIFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3Jh
dGlvbgo+ICAgICArNDEgKDApIDc5IDM2NSA1NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCj4K
Pgo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
