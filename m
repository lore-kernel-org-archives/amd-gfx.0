Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D5C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 12:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE46205CB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 12:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OTm90I5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE46205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F856E1D3;
	Wed, 22 Jul 2020 12:51:44 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEE66E1D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 12:51:43 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id 95so1627955otw.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+/pF3SCY8xJs7DmzgS+n3eKJ4TjeFNT447j5SaOKcWo=;
 b=OTm90I5OSe/cJMhk3v86ivkKxFA5udVMzmIA59k++vwjdC2qHDKb440cfJnG0/CEcT
 WEUVP91nhnqgZmtN/ZCXgPPivWUAmO/VO523pcjiHwWeZ4wUan3X8y8DECkhatadVZCv
 xq5mYaNP5T+UweyLDXr5C5CM6KPUW4Bi+o5wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+/pF3SCY8xJs7DmzgS+n3eKJ4TjeFNT447j5SaOKcWo=;
 b=A3Xr8WRkUYNJ0Aqmk9+o+9ACmu1qTVr8GjSHo+kEVfMcapl/zid9A54nQ66YTiEA23
 9fO9+HKqfGqHA5L3+2dOAKzeP1+PWVpBtCgV7gU8eHdKKEMWRl815z1VtYzYGMvBOhu1
 I3za+W6Um3rkTW+W/RVqs4sbcz619umda2/xnSf2XDAfY0PYsiv9aawdf2TEGBi8Pfwv
 nBXk0bZd2bfPVAW7su0iAx8b53k3qA8XYedx9MPkZrczpmVRrG9JCG5upQwzBP5Ub/dc
 MFQecdsrVXrXjvMedVN3vngSZxleJFrH1cOwhbF88x4j27youjn6ArlnTvYxeyDQz+9Y
 1CRA==
X-Gm-Message-State: AOAM530J+VHcw+1TNxl3c/s1C/mhl4JMYENQfH0m3qUdd8zxdnIkBkde
 P1/OANis+wfveLGCzEwW7T2SemncZvdlTaaqQvQMxg==
X-Google-Smtp-Source: ABdhPJxR4pIVgabqvMb4RRA8e6sxQFDzuTMs8bk5zOofaPvfh1eG0ImuhElWy2TQBAnNPnOFV2cl0esAJFhYA6UDLwI=
X-Received: by 2002:a9d:d55:: with SMTP id 79mr29749847oti.281.1595422302230; 
 Wed, 22 Jul 2020 05:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200722123813.721041-1-michel@daenzer.net>
In-Reply-To: <20200722123813.721041-1-michel@daenzer.net>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 22 Jul 2020 14:51:31 +0200
Message-ID: <CAKMK7uGO3K0P1yJsdT0urEXOVyBCU_Gsm8JaAW3R0TrBkueYNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Simplify drm_crtc_state::active checks
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Leo Li <sunpeng.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgMjozOCBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IEZyb206IE1pY2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRo
YXQuY29tPgo+Cj4gZHJtX2F0b21pY19jcnRjX2NoZWNrIGVuZm9yY2VzIHRoYXQgOjphY3RpdmUg
Y2FuIG9ubHkgYmUgdHJ1ZSBpZgo+IDo6ZW5hYmxlIGlzIGFzIHdlbGwuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KCm1vZGVzZXQgdnMgbW9k
ZXJlc2V0IGlzIGEgYml0IGFuIGluZ2xvcmlvdXMgbmFtZSBjaG9pY2UgLi4uIHNpbmNlIHRoaXMK
c2VlbXMgdG8gYmUgZ2x1ZSBjb2RlIGFuZCBub3QgcGFydCBvZiBjb3JlIGRjLCBtYXliZSByZW5h
bWUgdG8KZW5hYmxlX3JlcXVpcmVkL2Rpc2FibGVfcmVxdWlyZWQgdG8ga2VlcCBpdCBjb25zaXN0
ZW50IHdpdGggdGhlCndvcmRpbmcgYXRvbWljIGhlbHBlcnMgdXNlPyBEQyBhbHNvIHNlZW1zIHRv
IHVzZSByZXNldCBmb3IgYSBsb3Qgb2YKb3RoZXIgdGhpbmdzIGFscmVhZHkgKHN0YXRlIHJlc2V0
LCBsaWtlIGF0b21pYywgb3IgZ3B1IHJlc2V0IGxpa2UKZHJtL3NjaGVkdWxlcidzIHRkX3JfKSwg
c28gSSB0aGluayB0aGlzIHdvdWxkIGFsc28gaGVscCBjbGFyaXR5IGZyb20gYQpEQyBwZXJzcGVj
dGl2ZS4KClBhdGNoIGl0c2VsZiBpcyBnb29kLCBhYm92ZSBqdXN0IGFuIGlkZWEgZm9yIGFub3Ro
ZXIgcGF0Y2ggb24gdG9wLgoKUmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0
ZXJAZmZ3bGwuY2g+Cj4gLS0tCj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyAgICB8IDE2ICsrKy0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBpbmRleCAzMTJjNTQzYjI1OGYu
LmRhYmVmMzA3YTc0ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IEBAIC0zNDE1LDIxICszNDE1LDEyIEBAIHN0YXRpYyBi
b29sIG1vZGVzZXRfcmVxdWlyZWQoc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqbmV3
X3N0cmVhbSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkY19zdHJlYW1f
c3RhdGUgKm9sZF9zdHJlYW0pCj4gIHsKPiAtICAgICAgIGlmICghZHJtX2F0b21pY19jcnRjX25l
ZWRzX21vZGVzZXQoY3J0Y19zdGF0ZSkpCj4gLSAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
PiAtCj4gLSAgICAgICBpZiAoIWNydGNfc3RhdGUtPmVuYWJsZSkKPiAtICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOwo+IC0KPiAtICAgICAgIHJldHVybiBjcnRjX3N0YXRlLT5hY3RpdmU7Cj4g
KyAgICAgICByZXR1cm4gY3J0Y19zdGF0ZS0+YWN0aXZlICYmIGRybV9hdG9taWNfY3J0Y19uZWVk
c19tb2Rlc2V0KGNydGNfc3RhdGUpOwo+ICB9Cj4KPiAgc3RhdGljIGJvb2wgbW9kZXJlc2V0X3Jl
cXVpcmVkKHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSkKPiAgewo+IC0gICAgICAg
aWYgKCFkcm1fYXRvbWljX2NydGNfbmVlZHNfbW9kZXNldChjcnRjX3N0YXRlKSkKPiAtICAgICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOwo+IC0KPiAtICAgICAgIHJldHVybiAhY3J0Y19zdGF0ZS0+
ZW5hYmxlIHx8ICFjcnRjX3N0YXRlLT5hY3RpdmU7Cj4gKyAgICAgICByZXR1cm4gIWNydGNfc3Rh
dGUtPmFjdGl2ZSAmJiBkcm1fYXRvbWljX2NydGNfbmVlZHNfbW9kZXNldChjcnRjX3N0YXRlKTsK
PiAgfQo+Cj4gIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9lbmNvZGVyX2Rlc3Ryb3koc3RydWN0IGRy
bV9lbmNvZGVyICplbmNvZGVyKQo+IEBAIC04MTA4LDggKzgwOTksNyBAQCBzdGF0aWMgaW50IGRt
X3VwZGF0ZV9jcnRjX3N0YXRlKHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2VyICpkbSwKPiAg
ICAgICAgICAqIFdlIHdhbnQgdG8gZG8gZGMgc3RyZWFtIHVwZGF0ZXMgdGhhdCBkbyBub3QgcmVx
dWlyZSBhCj4gICAgICAgICAgKiBmdWxsIG1vZGVzZXQgYmVsb3cuCj4gICAgICAgICAgKi8KPiAt
ICAgICAgIGlmICghKGVuYWJsZSAmJiBhY29ubmVjdG9yICYmIG5ld19jcnRjX3N0YXRlLT5lbmFi
bGUgJiYKPiAtICAgICAgICAgICAgIG5ld19jcnRjX3N0YXRlLT5hY3RpdmUpKQo+ICsgICAgICAg
aWYgKCEoZW5hYmxlICYmIGFjb25uZWN0b3IgJiYgbmV3X2NydGNfc3RhdGUtPmFjdGl2ZSkpCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgICAgLyoKPiAgICAgICAgICAqIEdpdmVu
IGFib3ZlIGNvbmRpdGlvbnMsIHRoZSBkYyBzdGF0ZSBjYW5ub3QgYmUgTlVMTCBiZWNhdXNlOgo+
IC0tCj4gMi4yOC4wLnJjMAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCgoKCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJ
bnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
