Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143CAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A632071A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NdjzPFUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A632071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EEB6E831;
	Wed, 22 Jul 2020 15:19:40 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81656E831
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 15:19:39 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id k6so2153762oij.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R5vgS+toQIIyGFV2PCS1CtPWLZUEfMXWVk8xO4EDx9g=;
 b=NdjzPFUaKxwEudErWY72s1og/SKN6zicuX+YIJ9/JDsf0uYypDWCtcylgC/0hc7FOC
 DE8rMYPjV4Ogma0SYDGscCKVPGubBMrVByu8qxd3A+FJeZjXsu98QVq5iaY4uxahke01
 AsIQDdufq91FX/sRVNb94zlkeeuXvbyFHqYvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R5vgS+toQIIyGFV2PCS1CtPWLZUEfMXWVk8xO4EDx9g=;
 b=qXLRpCj4zM9ecQh3050w/zk0BFicXBF+0Vmf9sMEZdEsCgSitk3ZQ3RukKSGxQJiTD
 Dgq/6lDa4AIRbvlQJOEFaWK5pyZCIqhrsniUe9axELWFs8GPGEng/EkY2MgSGLy0Dk7F
 p8sSKP4d1460vyx+XK4Q0A296HyjvoNVkGKZaqLKhT4T74UxYAxwhuJ1f5z6/mPjQKMU
 UjHewKKTUUZoIDjxXjSdA3DpuQpQtUbey55RU69MwwtwZbf77o6d9Ix+tKdojVSRHIuK
 E80x/ucTH8C+BHsvVJzuonXillFsyPeWY9EaehZkVM3XSvh79ytIk8BioO/e/r5jjCJr
 73NA==
X-Gm-Message-State: AOAM533V5+pufy8rX/Vgo19E1SHpuOJgIO9KmCc8/kBzqgzsIZhGCbxS
 1TU+UqNa7fvtD5mXytTBw5Gt8xi42ImAXlx/3Wy3qw==
X-Google-Smtp-Source: ABdhPJxe3fmXRsMB9vXWsd0rvwFuqmhzJOVrbvvjH2fy/2Fb954xG9KdDym8G0kmOI6wL178KcUYWcEhyXUoDs0AmrM=
X-Received: by 2002:aca:da03:: with SMTP id r3mr164606oig.14.1595431178986;
 Wed, 22 Jul 2020 08:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200722123813.721041-1-michel@daenzer.net>
 <CAKMK7uGO3K0P1yJsdT0urEXOVyBCU_Gsm8JaAW3R0TrBkueYNg@mail.gmail.com>
 <c1bed91c-aa9d-140e-701b-6946995cf24f@amd.com>
 <46b17209-09f6-d5a8-1335-0ff5371659f6@daenzer.net>
In-Reply-To: <46b17209-09f6-d5a8-1335-0ff5371659f6@daenzer.net>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 22 Jul 2020 17:19:28 +0200
Message-ID: <CAKMK7uEzG0mNJQBzKPNnKBo3tKkny4x35-sx_LM-JWXZqRqbAA@mail.gmail.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgNDoyNSBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMjAtMDctMjIgMzoxMCBwLm0uLCBLYXpsYXVza2Fz
LCBOaWNob2xhcyB3cm90ZToKPiA+IE9uIDIwMjAtMDctMjIgODo1MSBhLm0uLCBEYW5pZWwgVmV0
dGVyIHdyb3RlOgo+ID4+IE9uIFdlZCwgSnVsIDIyLCAyMDIwIGF0IDI6MzggUE0gTWljaGVsIETD
pG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPj4+Cj4gPj4+IEZyb206IE1pY2hl
bCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+ID4+Pgo+ID4+PiBkcm1fYXRvbWljX2Ny
dGNfY2hlY2sgZW5mb3JjZXMgdGhhdCA6OmFjdGl2ZSBjYW4gb25seSBiZSB0cnVlIGlmCj4gPj4+
IDo6ZW5hYmxlIGlzIGFzIHdlbGwuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBE
w6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+ID4KPiA+IExvb2tzIGZpbmUgdG8gbWUuIFRo
ZSBjaGVjayBpcyBzdWZmaWNpZW50bHkgb2xkIGVub3VnaCB0aGF0IEkgZG9uJ3QgbWluZAo+ID4g
cmVseWluZyBvbiB0aGUgY29yZSBmb3IgdGhpcyBlaXRoZXIuCgoiYWN0aXZlIGltcGxpZXMgZW5h
YmxlZCIgaGFzIGJlZW4gYSBoYXJkIGFzc3VtcHRpb24gb2YgYXRvbWljIGZyb20gZGF5CjEuIFNv
IHNob3VsZCB3b3JrIGFueXdoZXJlIHlvdSBoYXZlIGF0b21pYy4KLURhbmllbAoKPiA+IFJldmll
d2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+
Cj4gPgo+ID4+Cj4gPj4gbW9kZXNldCB2cyBtb2RlcmVzZXQgaXMgYSBiaXQgYW4gaW5nbG9yaW91
cyBuYW1lIGNob2ljZSAuLi4gc2luY2UgdGhpcwo+ID4+IHNlZW1zIHRvIGJlIGdsdWUgY29kZSBh
bmQgbm90IHBhcnQgb2YgY29yZSBkYywgbWF5YmUgcmVuYW1lIHRvCj4gPj4gZW5hYmxlX3JlcXVp
cmVkL2Rpc2FibGVfcmVxdWlyZWQgdG8ga2VlcCBpdCBjb25zaXN0ZW50IHdpdGggdGhlCj4gPj4g
d29yZGluZyBhdG9taWMgaGVscGVycyB1c2U/IERDIGFsc28gc2VlbXMgdG8gdXNlIHJlc2V0IGZv
ciBhIGxvdCBvZgo+ID4+IG90aGVyIHRoaW5ncyBhbHJlYWR5IChzdGF0ZSByZXNldCwgbGlrZSBh
dG9taWMsIG9yIGdwdSByZXNldCBsaWtlCj4gPj4gZHJtL3NjaGVkdWxlcidzIHRkX3JfKSwgc28g
SSB0aGluayB0aGlzIHdvdWxkIGFsc28gaGVscCBjbGFyaXR5IGZyb20gYQo+ID4+IERDIHBlcnNw
ZWN0aXZlLgo+ID4+Cj4gPj4gUGF0Y2ggaXRzZWxmIGlzIGdvb2QsIGFib3ZlIGp1c3QgYW4gaWRl
YSBmb3IgYW5vdGhlciBwYXRjaCBvbiB0b3AuCj4gPj4KPiA+PiBSZXZpZXdlZC1ieTogRGFuaWVs
IFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KPgo+IFRoYW5rcyBmb3IgdGhlIHJldmll
d3MhIEkgYXNzdW1lIHRoaXMgd2lsbCBnZXQgcGlja2VkIHVwIGJ5IGEgREMKPiBkZXZlbG9wZXIg
b3IgQWxleC9DaHJpc3RpYW4uCj4KPgo+ID4gVGhhdCBzb3VuZHMgbGlrZSBhIHJlYXNvbmFibGUg
aWRlYSB0byBtZS4gVGhlc2UgYXJlIHVzZWQgbW9yZSBhcyBhCj4gPiBzdHJlYW1fY2hhbmdlZCAv
IHN0cmVhbV9yZW1vdmVkIGZsYWcsIGJ1dCBJIGRvbid0IHRoaW5rIHRoZXNlIGhlbHBlcnMKPiA+
IHJlYWxseSBuZWVkIHRvIGV4aXN0IGF0IGFsbC4KPiA+Cj4gPiBUaGF0IGNvdWxkIGNvbWUgYXMg
YSBmb2xsb3cgdXAgcGF0Y2guCj4KPiBZZWFoLCBJJ20gbGVhdmluZyB0aGF0IHRvIHlvdSBndXlz
LiA6KQo+Cj4KPiAtLQo+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KPiBMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKCgoKLS0g
CkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6
Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
