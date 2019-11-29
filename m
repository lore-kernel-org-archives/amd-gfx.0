Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCEC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 07:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FECB21781
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 07:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FECB21781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7836E893;
	Fri, 29 Nov 2019 07:18:29 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91A46E0D5;
 Fri, 29 Nov 2019 07:18:28 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id n5so13808288wmc.0;
 Thu, 28 Nov 2019 23:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tkeRI2yNVRyfmG+HaLVXwFnLxkVjrmIZNI8y9X6UAY0=;
 b=Ihyix941Xh0vqFyXo1yyiKpPieZIMr94+1ZsLdwtrhFTg1FzFBovdt8N5ggP5KyH1o
 wZBiD0BxMtMKY2tT1nD9uu6h2UiOKAH3yMSUVvrxyz92Ii+6T3EV8WunPgaY69p9u2ju
 a6imK1vHPb7Rs+1Z6ZbypaL0u4LjFNvg5trOM+s9USRlLthYZa2L3vZFDmItL28PAn+l
 42Rgk81FrnWzooc51sYVtbHJPfQ5z6jMPzFzasZC3nr9TGnH+KRyMDoex2qWG6GPv/GB
 CldoO/bsg1b5g6/LtleqSY3hcSQafBRW77Gryrb7SC4XXY42sbDxMzNwudXndRUraN6D
 zs5A==
X-Gm-Message-State: APjAAAV+ZWar/Ym3qtKAYttJ5NdPEvInQpi5B7ksGc7hBubx3L9+2vrU
 lZhBZ43V8/2Y7Xi79ehQsiaF4HGYRewb/C+BhJM=
X-Google-Smtp-Source: APXvYqzT32qHBZuzjCjX33Dg4+GU6F5DyFwzn3B8bpFRr4BM0kkJOpw1uOFVI1WyG4NlW0pdHQwEJTYh54sxKRLk2as=
X-Received: by 2002:a1c:5603:: with SMTP id k3mr13924771wmb.150.1575011907203; 
 Thu, 28 Nov 2019 23:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-8-Kenny.Ho@amd.com>
 <20191001142957.GK6694@blackbody.suse.cz>
In-Reply-To: <20191001142957.GK6694@blackbody.suse.cz>
From: Kenny Ho <y2kenny@gmail.com>
Date: Fri, 29 Nov 2019 02:18:15 -0500
Message-ID:
 <CAOWid-diGR6bkygGO7gMQauNSCApxFwgYPunHGWGTXFKV8KkJg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 07/16] drm,
 cgroup: Add total GEM buffer allocation limit
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tkeRI2yNVRyfmG+HaLVXwFnLxkVjrmIZNI8y9X6UAY0=;
 b=a3EfmTdZwnX8sB+JVaRBSQ/mLoNcsXV7erm4NRvfI36MMemPkiPg8g+UQJKe8tfrkR
 lk8HbZY655P4W+5GQgWS5EcElRLTOqRB3h6okLDUw5j3iLYQgVenVOFuuE8dzBjkPlaG
 Nasc8+UnfNjgPmTt04pDG37HpwgQGyARGlUKpg/G4njgOxyxFIOgbegUbAJKkwpg6iIS
 lQQyTyZcymoFGLYX9HNQeiQhQO2yatTTK1hV/T8ouwwaGGfjBCniqjW8OMDn+g3knRkp
 yhhZo7AYsShmOnABthUFBvWrIdJYxcRofbztlDO7MXL8JhJxxuy1uVSxf3Rbv28KJKFK
 oAHQ==
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, jsparks@cray.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, lkaplan@cray.com,
 Tejun Heo <tj@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 "Greathouse, Joseph" <joseph.greathouse@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, cgroups@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191129071815.aeMvcWDIdVTy1uD-3DtMR02LeQ2S5ZL8h1w4c61uCU8@z>

T24gVHVlLCBPY3QgMSwgMjAxOSBhdCAxMDozMCBBTSBNaWNoYWwgS291dG7DvSA8bWtvdXRueUBz
dXNlLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBdWcgMjksIDIwMTkgYXQgMDI6MDU6MjRBTSAtMDQw
MCwgS2VubnkgSG8gPEtlbm55LkhvQGFtZC5jb20+IHdyb3RlOgo+ID4gZHJtLmJ1ZmZlci5kZWZh
dWx0Cj4gPiAgICAgICAgIEEgcmVhZC1vbmx5IGZsYXQta2V5ZWQgZmlsZSB3aGljaCBleGlzdHMg
b24gdGhlIHJvb3QgY2dyb3VwLgo+ID4gICAgICAgICBFYWNoIGVudHJ5IGlzIGtleWVkIGJ5IHRo
ZSBkcm0gZGV2aWNlJ3MgbWFqb3I6bWlub3IuCj4gPgo+ID4gICAgICAgICBEZWZhdWx0IGxpbWl0
cyBvbiB0aGUgdG90YWwgR0VNIGJ1ZmZlciBhbGxvY2F0aW9uIGluIGJ5dGVzLgo+IFdoYXQgaXMg
dGhlIHB1cnBvc2Ugb2YgdGhpcyBhdHRyaWJ1dGUgKGFuZCBhbGlrZXMgZm9yIG90aGVyIHJlc291
cmNlcyk/Cj4gSSBjYW4ndCBzZWUgaXQgYmVpbmcgc2V0IGRpZmZlcmVudGx5IGJ1dCBTNjRfTUFY
IGluCj4gZHJtY2dfZGV2aWNlX2Vhcmx5X2luaXQuCgpjZ3JvdXAgaGFzIGEgbnVtYmVyIG9mIGNv
bnZlbnRpb25zIGFuZCBvbmUgb2Ygd2hpY2ggaXMgdGhlIGlkZWEgb2YgYQpkZWZhdWx0LiAgVGhl
IGlkZWEgaGVyZSBpcyB0byBhbGxvdyBmb3IgZGV2aWNlIHNwZWNpZmljIGRlZmF1bHRzLiAgRm9y
CnRoaXMgc3BlY2lmaWMgcmVzb3VyY2UsIEkgY2FuIHByb2JhYmx5IG5vdCBleHBvc2UgaXQgc2lu
Y2UgaXQncyBub3QKcGFydGljdWxhcmx5IHVzZWZ1bCwgYnV0IGZvciBvdGhlciByZXNvdXJjZXMg
KHN1Y2ggYXMgdGhlIGxncHUKcmVzb3VyY2UpIHRoZSBjb25jZXB0IG9mIGEgZGVmYXVsdCBpcyB1
c2VmdWwgKGZvciBleGFtcGxlLCBkaWZmZXJlbnQKZGV2aWNlcyBjYW4gaGF2ZSBkaWZmZXJlbnQg
bnVtYmVyIG9mIGxncHUuKQoKCj4gPiArc3RhdGljIHNzaXplX3QgZHJtY2dfbGltaXRfd3JpdGUo
c3RydWN0IGtlcm5mc19vcGVuX2ZpbGUgKm9mLCBjaGFyICpidWYsCj4gPiBbLi4uXQo+ID4gKyAg
ICAgICAgICAgICBzd2l0Y2ggKHR5cGUpIHsKPiA+ICsgICAgICAgICAgICAgY2FzZSBEUk1DR19U
WVBFX0JPX1RPVEFMOgo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBfbWF4ID0gcGFyZW50ID09
IE5VTEwgPyBTNjRfTUFYIDoKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVu
dC0+ZGV2X3Jlc291cmNlc1ttaW5vcl0tPgo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYm9fbGltaXRzX3RvdGFsX2FsbG9jYXRlZDsKPiA+ICsKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICByYyA9IGRybWNnX3Byb2Nlc3NfbGltaXRfczY0X3ZhbChzYXR0ciwgdHJ1ZSwKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb3BzLT5ib19saW1pdHNfdG90YWxfYWxsb2Nh
dGVkX2RlZmF1bHQsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwX21heCwKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2YWwpOwo+IElJVUMsIHRoaXMgYWxsb3dz
IGluaXRpYXRpbmcgdGhlIHBhcnRpY3VsYXIgbGltaXQgdmFsdWUgYmFzZWQgZWl0aGVyIG9uCj4g
cGFyZW50IG9yIHRoZSBkZWZhdWx0IHBlci1kZXZpY2UgdmFsdWUuIFRoaXMgaXMgYWxhcyByYXRo
ZXIgYW4KPiBhbnRpcGF0dGVybi4gVGhlIG1vc3Qgc3RyaW5nZW50IGxpbWl0IG9uIHRoZSBwYXRo
IGZyb20gYSBjZ3JvdXAgdG8gdGhlCj4gcm9vdCBzaG91bGQgYmUgYXBwbGllZCBhdCB0aGUgY2hh
cmdpbmcgdGltZS4gSG93ZXZlciwgdGhlIGNoaWxkIHNob3VsZAo+IG5vdCBpbmhlcml0IHRoZSB2
ZXJiYXRpbSB2YWx1ZSBmcm9tIHRoZSBwYXJlbnQgKG1heSByYWNlIHdpdGggcGFyZW50IGFuZAo+
IGl0IHdvbid0IGJlIHVwZGF0ZWQgdXBvbiBwYXJlbnQgY2hhbmdlKS4KSSB0aGluayB0aGlzIHdh
cyBhIG1pc3Rha2UgZHVyaW5nIG9uZSBvZiBteSByZWZhY3RvciBhbmQgSSBzaHJ1bmsgdGhlCmNy
aXRpY2FsIHNlY3Rpb24gcHJvdGVjdGVkIGJ5IGEgbXV0ZXggYSBiaXQgdG9vIG11Y2guICBCdXQg
eW91IGFyZQpyaWdodCBpbiB0aGUgc2Vuc2UgdGhhdCBJIGRvbid0IHByb3BhZ2F0ZSB0aGUgbGlt
aXRzIGRvd253YXJkIHRvIHRoZQpjaGlsZHJlbiB3aGVuIHRoZSBwYXJlbnQncyBsaW1pdCBpcyB1
cGRhdGVkLiAgQnV0IGZyb20gdGhlIHVzZXIKaW50ZXJmYWNlIHBlcnNwZWN0aXZlLCB3b3VsZG4n
dCB0aGlzIGJlIGNvbmZ1c2luZz8gIFdoZW4gYSBzeXNhZG1pbgpzZXRzIGEgbGltaXQgdXNpbmcg
dGhlICdtYXgnIGtleXdvcmQsIHRoZSB2YWx1ZSB3b3VsZCBiZSBhIGdsb2JhbCBvbmUKZXZlbiB0
aG91Z2ggdGhlIGFjdHVhbCBhbGxvd2FibGUgbWF4aW11bSBmb3IgdGhlIHBhcnRpY3VsYXIgY2dy
b3VwIGlzCmxlc3MgaW4gcmVhbGl0eSBiZWNhdXNlIG9mIHRoZSBhbmNlc3RvciBjZ3JvdXBzPyAg
KElmIHRoaXMgaXMgdGhlCmVzdGFibGlzaGVkIG5vcm0sIEkgYW0gb2sgdG8gZ28gYWxvbmcgYnV0
IHNlZW1zIGNvbmZ1c2luZyB0byBtZS4pICBJCmFtIHByb2JhYmx5IG1pc3Npbmcgc29tZXRoaW5n
IGJlY2F1c2UgYXMgSSBpbXBsZW1lbnRlZCB0aGlzLCB0aGUgJ21heCcKYW5kICdkZWZhdWx0JyBz
ZW1hbnRpYyBoYXMgYmVlbiBjb25mdXNpbmcgdG8gbWUgZXNwZWNpYWxseSBmb3IgdGhlCmNoaWxk
cmVuIGNncm91cHMgZHVlIHRvIHRoZSBjb250ZXh0IG9mIHRoZSBhbmNlc3RvcnMuCgo+IFlvdSBh
bHJlYWR5IGRvIHRoZSBhcHByb3ByaWF0ZSBoaWVyYXJjaGljYWwgY2hlY2sgaW4KPiBkcm1jZ190
cnlfY2hiX2JvX2FsbG9jLCBzbyB0aGUgcGFyZW50IHByb3BhZ2F0aW9uIGNvdWxkIGJlIHNpbXBs
eQo+IGRyb3BwZWQgaWYgSSdtIG5vdCBtaXN0YWtlbi4KSSB3aWxsIG5lZWQgdG8gZG91YmxlIGNo
ZWNrLiAgQnV0IEkgdGhpbmsgaW50ZXJhY3Rpb24gYmV0d2VlbiBwYXJlbnQKYW5kIGNoaWxkcmVu
IChvciBwZXJoYXBzIGJldHdlZW4gc2libGluZ3MpIHdpbGwgYmUgbmVlZGVkIGV2ZW50dWFsbHkK
YmVjYXVzZSB0aGVyZSBzZWVtcyB0byBiZSBhIGRlc2lyZSB0byBpbXBsZW1lbnQgIndlaWdodCIg
dHlwZSBvZgpyZXNvdXJjZS4gIEFsc28sIGZyb20gcGVyZm9ybWFuY2UgcGVyc3BlY3RpdmUsIHdv
dWxkbid0IGl0IG1ha2UgbW9yZQpzZW5zZSB0byBtYWtlIHN1cmUgdGhlIGxpbWl0cyBhcmUgc2V0
IGNvcnJlY3RseSBkdXJpbmcgY29uZmlndXJhdGlvbgp0aGFuIHRvIGhhdmUgdG8gY2hlY2sgYWxs
IHRoZSBjZ3JvdXBzIHVwIHRocm91Z2ggdGhlIHBhcmVudHM/ICBJIGRvbid0CmhhdmUgY29tcHJl
aGVuc2l2ZSBrbm93bGVkZ2Ugb2YgdGhlIGltcGxlbWVudGF0aW9uIG9mIG90aGVyIGNncm91cApj
b250cm9sbGVycyBzbyBpZiBtb3JlIGV4cGVyaWVuY2UgZm9sa3MgY2FuIGNvbW1lbnQgdGhhdCB3
b3VsZCBiZQpncmVhdC4gIChBbHRob3VnaCwgSSBwcm9iYWJseSBzaG91bGQganVzdCBkbyBvbmUg
YXBwcm9hY2ggaW5zdGVhZCBvZgpkb2luZyBib3RoLi4uIG9yIDEuNS4pCgo+Cj4gQWxzbywgSSBj
YW4ndCBmaW5kIGhvdyB0aGUgcmVhZCBvZgo+IHBhcmVudC0+ZGV2X3Jlc291cmNlc1ttaW5vcl0t
PmJvX2xpbWl0c190b3RhbF9hbGxvY2F0ZWQgYW5kIGl0cwo+IGNvbmN1cnJlbnQgdXBkYXRlIGFy
ZSBzeW5jaHJvbml6ZWQgKGkuZS4gc29tZW9uZSB3cml0aW5nCj4gYnVmZmVyLnRvdGFsLm1heCBm
b3IgcGFyZW50IGFuZCBjaGlsZCBpbiBwYXJhbGxlbCkuIChJdCBtYXkganVzdCBteQo+IG92ZXJz
aWdodC4pClRoaXMgaXMgcHJvYmFibHkgdGhlIHJlZmFjdG9yIG1pc3Rha2UgSSBtZW50aW9uZWQg
ZWFybGllci4KClJlZ2FyZHMsCktlbm55Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
