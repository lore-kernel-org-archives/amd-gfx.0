Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A78C17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 15:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C000421872
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C000421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205566EB4F;
	Tue, 12 Nov 2019 15:03:47 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379F86E123
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 15:03:45 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id a14so15044262oid.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 07:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=yFGku1zoGbiEtuPUDgiBWF8Mwkas9xUD2EnXkvOl58g=;
 b=Vt5xBIJ2oJCUUAJMb8K+MwICJx2P9s3nQFoZeiYa//yIQyGTz09+9TeVt0CSkATaMI
 H77NkEWaNcbVJKEjLKXZtYC7nYUb2RbFSNpYLU+6+Qc6sHWRGKXE0FBNEIMF5293NUhg
 P7xynt/bRUiROVNtJB4vTHvH3fkz1UF7H5Lq92/hQeV0+ysrJs/p5qXZ+78hr0dIUDTV
 LIVMeEuaagLYXI/XBtoc8KpOwiXWv95zZ59JYRqXdvG5Lop8hYHGVRBnKoWlufRAjk4H
 UuJgn8nmtq0y4wv/OmSYA2ez5ia6a1GNRaNvnPsYxjeWYW/7TaLbZqoWVcDzNI1BantB
 6Itg==
X-Gm-Message-State: APjAAAVbg5zyha27NY5DpLdSjJIGXuAZB7cnY+dKzNAi5gyeSxQfRBx4
 xd8lVXzScoXmDx3F53zwH1srQ+6rwy6Zkd6AlpSq4Q==
X-Google-Smtp-Source: APXvYqwumPk8dL4PT2Z8HtPyfLtI3+nQntle5Uq7YQVWOeiSPDQOstSucXsdraK+ZabQ5MWPxsr9NgTRaVVa3vF6BKY=
X-Received: by 2002:aca:39d7:: with SMTP id g206mr4114564oia.101.1573571024433; 
 Tue, 12 Nov 2019 07:03:44 -0800 (PST)
MIME-Version: 1.0
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 12 Nov 2019 16:03:33 +0100
Message-ID:
 <CAKMK7uH-8+tbKsAoiChsxELEc_77RVVxP2wapHWhqB+0Viifog@mail.gmail.com>
Subject: drm core/helpers and MIT license
To: dri-devel <dri-devel@lists.freedesktop.org>, 
 intel-gfx <intel-gfx@lists.freedesktop.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Alex Deucher <alexdeucher@gmail.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 "Nikula, Jani" <jani.nikula@linux.intel.com>,
 Thomas Hellstrom <thellstrom@vmware.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=yFGku1zoGbiEtuPUDgiBWF8Mwkas9xUD2EnXkvOl58g=;
 b=QIXhNl9KtT/X7kzmUFeX5IKUzclP2OVxHQvCRlOHDzOn0jsvTT2oRyxoLN8r+VwHBD
 9FF8YsjefzkRAZyk7R2S8OYOCxcKg2sNJItNEt+esorLAMMnDzlxO0g/Rk5690hmwnGZ
 vt4onKe5IV/VRXwR9SY4VS0IiPhDsQ2w489b0=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112150333.-wfBl_QJkNz7G140Zukp26aGUvvzrtZdYUMu9DjS9Rw@z>

SGkgYWxsLAoKRGF2ZSBhbmQgbWUgY2hhdHRlZCBhYm91dCB0aGlzIGxhc3Qgd2VlayBvbiBpcmMu
IEVzc2VudGlhbGx5IHdlIGhhdmU6CgokIGdpdCBncmVwIFNQRFguKkdQTCAtLSAnOihnbG9iKWRy
aXZlcnMvZ3B1L2RybS8qYycKZHJpdmVycy9ncHUvZHJtL2RybV9jbGllbnQuYzovLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMApkcml2ZXJzL2dwdS9kcm0vZHJtX2RhbWFnZV9oZWxw
ZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQKZHJpdmVycy9n
cHUvZHJtL2RybV9kcF9jZWMuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMApk
cml2ZXJzL2dwdS9kcm0vZHJtX2VkaWRfbG9hZC5jOi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCmRyaXZlcnMvZ3B1L2RybS9kcm1fZmJfY21hX2hlbHBlci5jOi8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCmRyaXZlcnMvZ3B1L2Ry
bS9kcm1fZm9ybWF0X2hlbHBlci5jOi8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
ICovCmRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX2NtYV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjoKR1BMLTIuMC1vci1sYXRlcgpkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9mcmFt
ZWJ1ZmZlcl9oZWxwZXIuYzovLwpTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1s
YXRlcgpkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYzovLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMApkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV90dG1faGVscGVy
LmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6CkdQTC0yLjAtb3ItbGF0ZXIKZHJpdmVycy9n
cHUvZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjoK
R1BMLTIuMC1vci1sYXRlcgpkcml2ZXJzL2dwdS9kcm0vZHJtX2hkY3AuYzovLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMApkcml2ZXJzL2dwdS9kcm0vZHJtX2xlYXNlLmM6Ly8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKZHJpdmVycy9ncHUvZHJtL2Ry
bV9taXBpX2RiaS5jOi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
CmRyaXZlcnMvZ3B1L2RybS9kcm1fb2YuYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5CmRyaXZlcnMvZ3B1L2RybS9kcm1fc2ltcGxlX2ttc19oZWxwZXIuYzovLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjoKR1BMLTIuMC1vci1sYXRlcgpkcml2ZXJzL2dwdS9kcm0vZHJt
X3N5c2ZzLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQpkcml2ZXJz
L2dwdS9kcm0vZHJtX3ZtYV9tYW5hZ2VyLmM6Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAgT1IgTUlUCmRyaXZlcnMvZ3B1L2RybS9kcm1fdnJhbV9oZWxwZXJfY29tbW9uLmM6Ly8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6CkdQTC0yLjAtb3ItbGF0ZXIKZHJpdmVycy9ncHUvZHJt
L2RybV93cml0ZWJhY2suYzovLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAoKT25l
IGlzIEdQTCtNSVQsIHNvIG9rLCBhbmQgb25lIGlzIGEgZGVmYXVsdCBHUEwtb25seSBoZWFkZXIg
ZnJvbQpHcmVnJ3MgaW5mYW1vdXMgcGF0Y2ggKHNvIGNvdWxkIHByb2JhYmx5IGJlIGNoYW5nZWQg
dG8gTUlUIGxpY2Vuc2UKaGVhZGVyKS4gSSBvbmx5IGxvb2tlZCBhdCAuYyBzb3VyY2VzLCBzaW5j
ZSBoZWFkZXJzIGFyZSB3b3JzZSB3cnQKaGF2aW5nIHF1ZXN0aW9uYWJsZSBkZWZhdWx0IGhlYWRl
cnMuIFNvIGFib3V0IDE4IGZpbGVzIHdpdGggY2xlYXIgR1BMCmxpY2Vuc2VzIHRodXMgZmFyIGlu
IGRybSBjb3JlL2hlbHBlcnMuCgpMb29raW5nIGF0IHdoZXJlIHRoYXQgY29kZSBjYW1lIGZyb20s
IGl0IGlzIG1vc3RseSBmcm9tIEdQTC1vbmx5CmRyaXZlcnMgKHdlIGhhdmUgYSBsb3Qgb2YgdGhv
c2Ugbm93YWRheXMpLCBzbyBzZWVtcyBsZWdpdCBub24tTUlUCmxpY2Vuc2VkLiBRdWVzdGlvbiBp
cyBub3cgd2hhdCBkbyB3ZSBkbzoKCi0gTm90aGluZywgd2hpY2ggbWVhbnMgR1BMIHdpbGwgc2xv
d2x5IGVuY3JvYWNoIG9uIGRybSBjb3JlL2hlbHBlcnMsCndoaWNoIGlzIHJvdWdobHkgdGhlIHNh
bWUgYXMgLi4uCgotIFRocm93IGluIHRoZSB0b3dlbCBvbiBNSVQgZHJtIGNvcmUgb2ZmaWNpYWxs
eS4gU2FtZSBhcyBhYm92ZSwgZXhjZXB0CmxldHMganVzdCBtYWtlIGl0IG9mZmljaWFsLgoKLSBU
cnkgdG8gY291bnRlciB0aGlzLCB3aGljaCBtZWFucyBhdCBsZWFzdCBhKSByZWxpY2Vuc2luZyBh
IGJ1bmNoIG9mCnN0dWZmIGIpIHJld3JpdGluZyBhIGJ1bmNoIG9mIHN0dWZmIGMpIG1ha2luZyBz
dXJlIHRoYXQncyBvayB3aXRoCmV2ZXJ5b25lLCB0aGVyZSdzIGEgbG90IG9mIEdQTC1ieS1kZWZh
dWx0IGZvciB0aGUga2VybmVsICh0aGF0J3MgaG93CndlIGdvdCBtb3N0IG9mIHRoZSBhYm92ZSBj
b2RlIHRocm91Z2ggbWVyZ2VkIGRyaXZlcnMgSSB0aGluaykuIEkKc3VzcGVjdCB0aGF0IHdob21l
dmVyIGNhcmVzIHdpbGwgbmVlZCB0byBwdXQgaW4gdGhlIHdvcmsgdG8gbWFrZSB0aGlzCmhhcHBl
biAoc2luY2UgaXQgd2lsbCBuZWVkIGEgcGlsZSBvZiBhY3RpdmUgcmVzaXN0YW5jZSBhdCBsZWFz
dCkuCgpDYyBtYWludGFpbmVycy9kcml2ZXIgdGVhbXMgd2hvIG1pZ2h0IGNhcmUgbW9zdCBhYm91
dCB0aGlzLgoKQWxzbyBpZiBwZW9wbGUgY291bGQgY2MgKmJzZCwgdGhleSBwcm9iYWJseSBjYXJl
IGFuZCBJIGRvbid0IGtub3cgYmVzdApjb250YWN0cyBmb3IgZ3JhcGhpY3Mgc3R1ZmYgKG9yIGFu
eXRoaW5nIGVsc2UgcmVhbGx5IGF0IGFsbCkuCgpDaGVlcnMsIERhbmllbAotLSAKRGFuaWVsIFZl
dHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KKzQxICgwKSA3OSAzNjUg
NTcgNDggLSBodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
