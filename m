Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F31C43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CE22073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CE22073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687B46E8D0;
	Fri, 15 Nov 2019 15:39:02 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02256E8D0;
 Fri, 15 Nov 2019 15:39:01 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id b11so10086270wmb.5;
 Fri, 15 Nov 2019 07:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zoKeuD92Y55TpLZMNbygg5BaUfLiCKFfjzKbBjaVR2c=;
 b=nkwHpSWu//hP3Qrk6odgMC649oZK7pDgzJi4b9O4O2vTsGUGcZj1Hc/CvXhtlct5Ud
 QSYEQR481CvT67HYuCuCG6D0aoOT6dM/rhAUxSU7R8KbWA/+rGI9wmYSI4eM2MaguR1A
 jBxTX8ldkGDdETcvuY4CzuofZmZlhpTdCgWotXkxxagf81Q01kapoG52Cj/jNaeBsd2E
 WUWZ/4gTk3RCyYlZVAdmuYoJ5FpwO2/7pGxe7DDor1YLXBW5otw/HvG50x78A8kogq5c
 0JJM9UT5wR+pXD6/Lkw46Ky+J8koXxGdGAFXtUsWzH3u+P/QxqF/HprgPRURN1PCO3J0
 esqA==
X-Gm-Message-State: APjAAAUDD4ZjT5v9OYtoQHTspJn3Zaw10sc/Coybyhg84Tarmz9inNtg
 ABE3Ul8yLymJt6eqPa8msI+wGY1SqsEk7uLW31Y=
X-Google-Smtp-Source: APXvYqwgCrMcWVpeFqTGY0demPryPJAnxf68BUAQVE8ETSPhysPI3f1Qm7JXbKotYuJTThs6VU79ev9A09T1csiFQyo=
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr14314973wma.34.1573832340216; 
 Fri, 15 Nov 2019 07:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uH-8+tbKsAoiChsxELEc_77RVVxP2wapHWhqB+0Viifog@mail.gmail.com>
In-Reply-To: <CAKMK7uH-8+tbKsAoiChsxELEc_77RVVxP2wapHWhqB+0Viifog@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2019 10:38:48 -0500
Message-ID:
 <CADnq5_MTwnCC9Gq1QytDvJVVTgF8nEr7v+OdEZA7wDwXZw6TXw@mail.gmail.com>
Subject: Re: drm core/helpers and MIT license
To: Daniel Vetter <daniel.vetter@ffwll.ch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=zoKeuD92Y55TpLZMNbygg5BaUfLiCKFfjzKbBjaVR2c=;
 b=YXc7+Ncbyzx8ouelyFPM49XfVeX9HPtE8ZKDjaHmTCOQIpaY/KpAmTd02aelX6sFfQ
 6JGL2IkOD2rUpeQmidph/t2ysOeSKZlJ7MOgVU+dJ/X9FSMQyWRSQF1ARWgRLTwh1epV
 VyGIw2nED2+LC1u1xOJHC6OS9SD6DheyOQneCLi4dyFLOlXvK12m7D1HVgp0sSsqqKvL
 Te4eMP2ABymJ7i8R2rzP2bL6ELasU8uF8CNwK94bNYPeMzhhKzpZPhcTsHgMtkH5AeZ6
 pfi7QBPqZ3fQCrdeoWpzvGjxsiZy3yo3MozbqFMFmmRLsDCbVBgOAwpk/C6vF4H2oNCm
 YhbA==
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
Cc: "Nikula, Jani" <jani.nikula@linux.intel.com>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115153848.2t_rylOKNpUuCoQg-A4X3_YwoUn7jXXMdeDD-gqzWBM@z>

T24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMTA6MDMgQU0gRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZl
dHRlckBmZndsbC5jaD4gd3JvdGU6Cj4KPiBIaSBhbGwsCj4KPiBEYXZlIGFuZCBtZSBjaGF0dGVk
IGFib3V0IHRoaXMgbGFzdCB3ZWVrIG9uIGlyYy4gRXNzZW50aWFsbHkgd2UgaGF2ZToKPgo+ICQg
Z2l0IGdyZXAgU1BEWC4qR1BMIC0tICc6KGdsb2IpZHJpdmVycy9ncHUvZHJtLypjJwo+IGRyaXZl
cnMvZ3B1L2RybS9kcm1fY2xpZW50LmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAKPiBkcml2ZXJzL2dwdS9kcm0vZHJtX2RhbWFnZV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQKPiBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX2NlYy5j
Oi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gZHJpdmVycy9ncHUvZHJtL2Ry
bV9lZGlkX2xvYWQuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZmJfY21hX2hlbHBlci5jOi8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gZHJpdmVycy9ncHUvZHJtL2RybV9mb3JtYXRf
aGVscGVyLmM6LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KPiBkcml2ZXJz
L2dwdS9kcm0vZHJtX2dlbV9jbWFfaGVscGVyLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
Cj4gR1BMLTIuMC1vci1sYXRlcgo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX2ZyYW1lYnVmZmVy
X2hlbHBlci5jOi8vCj4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIK
PiBkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMAo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3R0bV9oZWxwZXIu
YzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4wLW9yLWxhdGVyCj4gZHJpdmVy
cy9ncHUvZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjoKPiBHUEwtMi4wLW9yLWxhdGVyCj4gZHJpdmVycy9ncHUvZHJtL2RybV9oZGNwLmM6Ly8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiBkcml2ZXJzL2dwdS9kcm0vZHJtX2xlYXNl
LmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiBkcml2ZXJz
L2dwdS9kcm0vZHJtX21pcGlfZGJpLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb3ItbGF0ZXIKPiBkcml2ZXJzL2dwdS9kcm0vZHJtX29mLmM6Ly8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seQo+IGRyaXZlcnMvZ3B1L2RybS9kcm1fc2ltcGxlX2ttc19o
ZWxwZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4wLW9yLWxhdGVyCj4g
ZHJpdmVycy9ncHUvZHJtL2RybV9zeXNmcy5jOi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkKPiBkcml2ZXJzL2dwdS9kcm0vZHJtX3ZtYV9tYW5hZ2VyLmM6Ly8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgTUlUCj4gZHJpdmVycy9ncHUvZHJtL2RybV92
cmFtX2hlbHBlcl9jb21tb24uYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjoKPiBHUEwtMi4w
LW9yLWxhdGVyCj4gZHJpdmVycy9ncHUvZHJtL2RybV93cml0ZWJhY2suYzovLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMAo+Cj4gT25lIGlzIEdQTCtNSVQsIHNvIG9rLCBhbmQgb25l
IGlzIGEgZGVmYXVsdCBHUEwtb25seSBoZWFkZXIgZnJvbQo+IEdyZWcncyBpbmZhbW91cyBwYXRj
aCAoc28gY291bGQgcHJvYmFibHkgYmUgY2hhbmdlZCB0byBNSVQgbGljZW5zZQo+IGhlYWRlciku
IEkgb25seSBsb29rZWQgYXQgLmMgc291cmNlcywgc2luY2UgaGVhZGVycyBhcmUgd29yc2Ugd3J0
Cj4gaGF2aW5nIHF1ZXN0aW9uYWJsZSBkZWZhdWx0IGhlYWRlcnMuIFNvIGFib3V0IDE4IGZpbGVz
IHdpdGggY2xlYXIgR1BMCj4gbGljZW5zZXMgdGh1cyBmYXIgaW4gZHJtIGNvcmUvaGVscGVycy4K
Pgo+IExvb2tpbmcgYXQgd2hlcmUgdGhhdCBjb2RlIGNhbWUgZnJvbSwgaXQgaXMgbW9zdGx5IGZy
b20gR1BMLW9ubHkKPiBkcml2ZXJzICh3ZSBoYXZlIGEgbG90IG9mIHRob3NlIG5vd2FkYXlzKSwg
c28gc2VlbXMgbGVnaXQgbm9uLU1JVAo+IGxpY2Vuc2VkLiBRdWVzdGlvbiBpcyBub3cgd2hhdCBk
byB3ZSBkbzoKPgo+IC0gTm90aGluZywgd2hpY2ggbWVhbnMgR1BMIHdpbGwgc2xvd2x5IGVuY3Jv
YWNoIG9uIGRybSBjb3JlL2hlbHBlcnMsCj4gd2hpY2ggaXMgcm91Z2hseSB0aGUgc2FtZSBhcyAu
Li4KPgo+IC0gVGhyb3cgaW4gdGhlIHRvd2VsIG9uIE1JVCBkcm0gY29yZSBvZmZpY2lhbGx5LiBT
YW1lIGFzIGFib3ZlLCBleGNlcHQKPiBsZXRzIGp1c3QgbWFrZSBpdCBvZmZpY2lhbC4KPgo+IC0g
VHJ5IHRvIGNvdW50ZXIgdGhpcywgd2hpY2ggbWVhbnMgYXQgbGVhc3QgYSkgcmVsaWNlbnNpbmcg
YSBidW5jaCBvZgo+IHN0dWZmIGIpIHJld3JpdGluZyBhIGJ1bmNoIG9mIHN0dWZmIGMpIG1ha2lu
ZyBzdXJlIHRoYXQncyBvayB3aXRoCj4gZXZlcnlvbmUsIHRoZXJlJ3MgYSBsb3Qgb2YgR1BMLWJ5
LWRlZmF1bHQgZm9yIHRoZSBrZXJuZWwgKHRoYXQncyBob3cKPiB3ZSBnb3QgbW9zdCBvZiB0aGUg
YWJvdmUgY29kZSB0aHJvdWdoIG1lcmdlZCBkcml2ZXJzIEkgdGhpbmspLiBJCj4gc3VzcGVjdCB0
aGF0IHdob21ldmVyIGNhcmVzIHdpbGwgbmVlZCB0byBwdXQgaW4gdGhlIHdvcmsgdG8gbWFrZSB0
aGlzCj4gaGFwcGVuIChzaW5jZSBpdCB3aWxsIG5lZWQgYSBwaWxlIG9mIGFjdGl2ZSByZXNpc3Rh
bmNlIGF0IGxlYXN0KS4KPgoKSSdkIGxpa2UgdG8gdHJ5IGFuZCBrZWVwIGFzIG11Y2ggTUlUIGFz
IHBvc3NpYmxlLiAgSSdkIGJlIHdpbGxpbmcgdG8KaGVscCB3aXRoIHRoZSByZS1saWNlbnNpbmcg
ZWZmb3J0LgoKQWxleAoKPiBDYyBtYWludGFpbmVycy9kcml2ZXIgdGVhbXMgd2hvIG1pZ2h0IGNh
cmUgbW9zdCBhYm91dCB0aGlzLgo+Cj4gQWxzbyBpZiBwZW9wbGUgY291bGQgY2MgKmJzZCwgdGhl
eSBwcm9iYWJseSBjYXJlIGFuZCBJIGRvbid0IGtub3cgYmVzdAo+IGNvbnRhY3RzIGZvciBncmFw
aGljcyBzdHVmZiAob3IgYW55dGhpbmcgZWxzZSByZWFsbHkgYXQgYWxsKS4KPgo+IENoZWVycywg
RGFuaWVsCj4gLS0KPiBEYW5pZWwgVmV0dGVyCj4gU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENv
cnBvcmF0aW9uCj4gKzQxICgwKSA3OSAzNjUgNTcgNDggLSBodHRwOi8vYmxvZy5mZndsbC5jaApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
