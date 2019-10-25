Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C7FCA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 19:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022CE20679
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 19:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022CE20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C821E6EB67;
	Fri, 25 Oct 2019 19:24:19 +0000 (UTC)
X-Greylist: delayed 1667 seconds by postgrey-1.36 at gabe;
 Fri, 25 Oct 2019 15:55:46 UTC
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656BF6EAD4;
 Fri, 25 Oct 2019 15:55:46 +0000 (UTC)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1iO1Un-0001vM-5Z; Fri, 25 Oct 2019 23:27:21 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1iO1Ue-0007uU-5p; Fri, 25 Oct 2019 23:27:12 +0800
Date: Fri, 25 Oct 2019 23:27:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/5] crypto: nx - Improve debugfs_create_u{32,64}()
 handling for atomics
Message-ID: <20191025152712.26q6s5gbygdxd33j@gondor.apana.org.au>
References: <20191021145149.31657-1-geert+renesas@glider.be>
 <20191021145149.31657-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191021145149.31657-2-geert+renesas@glider.be>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Mailman-Approved-At: Fri, 25 Oct 2019 19:24:18 +0000
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
 Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>, David@rox.of.borg,
 Kevin Hilman <khilman@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nayna Jain <nayna@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Casey Leedom <leedom@chelsio.com>, linux-pm@vger.kernel.org,
 Pensando Drivers <drivers@pensando.io>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, netdev@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, Paul Mackerras <paulus@samba.org>,
 Shannon Nelson <snelson@pensando.io>, linuxppc-dev@lists.ozlabs.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025152712.1PkDBsqYzj_1vyjCFah7U9L0esX9j2QEwJZhORj982w@z>

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDQ6NTE6NDVQTSArMDIwMCwgR2VlcnQgVXl0dGVyaG9l
dmVuIHdyb3RlOgo+IFZhcmlhYmxlcyBvZiB0eXBlIGF0b21pY3ssNjR9X3QgY2FuIGJlIHVzZWQg
ZmluZSB3aXRoCj4gZGVidWdmc19jcmVhdGVfdXszMiw2NH0sIHdoZW4gcGFzc2luZyBhIHBvaW50
ZXIgdG8gdGhlIGVtYmVkZGVkIGNvdW50ZXIuCj4gVGhpcyBhbGxvd3MgdG8gZ2V0IHJpZCBvZiB0
aGUgY2FzdHMsIHdoaWNoIHByZXZlbnRlZCBjb21waWxlciBjaGVja3MuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4KPiAtLS0K
PiAgZHJpdmVycy9jcnlwdG8vbngvbnhfZGVidWdmcy5jIHwgMTggKysrKysrKysrLS0tLS0tLS0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpQYXRj
aCBhcHBsaWVkLiAgVGhhbmtzLgotLSAKRW1haWw6IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9y
LmFwYW5hLm9yZy5hdT4KSG9tZSBQYWdlOiBodHRwOi8vZ29uZG9yLmFwYW5hLm9yZy5hdS9+aGVy
YmVydC8KUEdQIEtleTogaHR0cDovL2dvbmRvci5hcGFuYS5vcmcuYXUvfmhlcmJlcnQvcHVia2V5
LnR4dApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
