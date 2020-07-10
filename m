Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D4C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FFB2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WU2W6d+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FFB2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1536EC55;
	Fri, 10 Jul 2020 14:02:49 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3D506EC52
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 14:02:47 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id e4so4884269oib.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xTQ5MsJnerH24IzbOibKIVgALQbQ6fBLEFDFGaudNHc=;
 b=WU2W6d+TZkpC2bQ5QGHyZU588I4aYRy0pgR/0jf5dsrsdUKzG7CHHQbdXmPQGYQqUL
 nasfBbJ4/UbxjUPNH17KzLPCu8/hid/VouoHAy2Rs5LX3JMX0PseWupYbCGix+YrbFIN
 0G929NaZD66foWbG+h37GXj5alNoKzzHEG+Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xTQ5MsJnerH24IzbOibKIVgALQbQ6fBLEFDFGaudNHc=;
 b=VLpc2iyTrpDrHlxRabb08BevkZPTn8OQO3oyvlwpnt/ou/Rs+tEC0RE/LyYK8jKxJ7
 xP9zwVMJu4XdeEcjeA8AYbAwhJHcUZVzGT212SDigAN/tkupPoWFSlf2MI4y305vWdnk
 mNMjWPpU4wrbz5GtloG7JVND8ZA67J4abPkooI3fLgXo+oQotW8SRm9Z7t4BNaioAqb+
 bMxFI1T1NENHSy4APjgvuzAdlFkF+50L9XGVuqFjMbSQJUDExYGSIf3/RWQ9wORv2vDg
 4BKJ3O16eQ5z+lmvwlVFYUL74JTFBvwDTUbQ0W3teplcSCMyFBvjmzVyKrywnL//NDBX
 bE2w==
X-Gm-Message-State: AOAM531FqrYM8MYPn36fkz+pgpOhH49UEJA9/IoXzFKS8BeL5sANl0Km
 /npwIIfUN4cyfy3MgO3+O2OBR66u3Xll6zQCuADfNQ==
X-Google-Smtp-Source: ABdhPJz9ueO/NwCXWq4u05bld/A1Jzmv30JDZLkssowFodTQImkU08xp+BW6yONjBlhlRH0STky3grfq96MK+YXxz58=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr4296478oig.128.1594389767031; 
 Fri, 10 Jul 2020 07:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch>
 <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com>
 <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
 <20200710125453.GC23821@mellanox.com>
 <4f4a2cf7-f505-8494-1461-bd467870481e@amd.com>
 <20200710134826.GD23821@mellanox.com>
In-Reply-To: <20200710134826.GD23821@mellanox.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 10 Jul 2020 16:02:35 +0200
Message-ID: <CAKMK7uGSUULTmL=bDXty6U4e37dzLHzu7wgUyOxo2CvR9KvXGg@mail.gmail.com>
Subject: Re: [PATCH 02/25] dma-fence: prime lockdep annotations
To: Jason Gunthorpe <jgg@mellanox.com>
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
Cc: Chris Wilson <chris@chris-wilson.co.uk>, kernel test robot <lkp@intel.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdWwgMTAsIDIwMjAgYXQgMzo0OCBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxs
YW5veC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBKdWwgMTAsIDIwMjAgYXQgMDM6MDE6MTBQTSAr
MDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+IEFtIDEwLjA3LjIwIHVtIDE0OjU0IHNj
aHJpZWIgSmFzb24gR3VudGhvcnBlOgo+ID4gPiBPbiBGcmksIEp1bCAxMCwgMjAyMCBhdCAwMjo0
ODoxNlBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4gPiA+IEFtIDEwLjA3LjIw
IHVtIDE0OjQzIHNjaHJpZWIgSmFzb24gR3VudGhvcnBlOgo+ID4gPiA+ID4gT24gVGh1LCBKdWwg
MDksIDIwMjAgYXQgMTA6MDk6MTFBTSArMDIwMCwgRGFuaWVsIFZldHRlciB3cm90ZToKPiA+ID4g
PiA+ID4gSGkgSmFzb24sCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEJlbG93IHRoZSBwYXJhZ3Jh
cGggSSd2ZSBhZGRlZCBhZnRlciBvdXIgZGlzY3Vzc2lvbnMgYXJvdW5kIGRtYS1mZW5jZXMKPiA+
ID4gPiA+ID4gb3V0c2lkZSBvZiBkcml2ZXJzL2dwdS4gR29vZCBlbm91Z2ggZm9yIGFuIGFjayBv
biB0aGlzLCBvciB3YW50IHNvbWV0aGluZwo+ID4gPiA+ID4gPiBjaGFuZ2VkPwo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBUaGFua3MsIERhbmllbAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICsg
KiBOb3RlIHRoYXQgb25seSBHUFUgZHJpdmVycyBoYXZlIGEgcmVhc29uYWJsZSBleGN1c2UgZm9y
IGJvdGggcmVxdWlyaW5nCj4gPiA+ID4gPiA+ID4gKyAqICZtbXVfaW50ZXJ2YWxfbm90aWZpZXIg
YW5kICZzaHJpbmtlciBjYWxsYmFja3MgYXQgdGhlIHNhbWUgdGltZSBhcyBoYXZpbmcgdG8KPiA+
ID4gPiA+ID4gPiArICogdHJhY2sgYXN5bmNocm9ub3VzIGNvbXB1dGUgd29yayB1c2luZyAmZG1h
X2ZlbmNlLiBObyBkcml2ZXIgb3V0c2lkZSBvZgo+ID4gPiA+ID4gPiA+ICsgKiBkcml2ZXJzL2dw
dSBzaG91bGQgZXZlciBjYWxsIGRtYV9mZW5jZV93YWl0KCkgaW4gc3VjaCBjb250ZXh0cy4KPiA+
ID4gPiA+IEkgd2FzIGhvcGluZyB3ZSdkIGdldCB0byAnbm8gZHJpdmVyIG91dHNpZGUgR1BVIHNo
b3VsZCBldmVuIHVzZQo+ID4gPiA+ID4gZG1hX2ZlbmNlKCknCj4gPiA+ID4gTXkgbGFzdCBzdGF0
dXMgd2FzIHRoYXQgVjRMIGNvdWxkIGNvbWUgdXNlIGRtYV9mZW5jZXMgYXMgd2VsbC4KPiA+ID4g
SSdtIHN1cmUgbG90cyBvZiBwbGFjZXMgKmNvdWxkKiB1c2UgaXQsIGJ1dCBJIHRoaW5rIEkgdW5k
ZXJzdG9vZCB0aGF0Cj4gPiA+IGl0IGlzIGEgYmFkIGlkZWEgdW5sZXNzIHlvdSBoYXZlIHRvIGZp
dCBpbnRvIHRoZSBEUk0gdUFQST8KPiA+Cj4gPiBJdCB3b3VsZCBiZSBhIGJpdCBxdWVzdGlvbmFi
bGUgaWYgeW91IHVzZSB0aGUgY29udGFpbmVyIG9iamVjdHMgd2UgY2FtZSB1cAo+ID4gd2l0aCBp
biB0aGUgRFJNIHN1YnN5c3RlbSBvdXRzaWRlIG9mIGl0Lgo+ID4KPiA+IEJ1dCB1c2luZyB0aGUg
ZG1hX2ZlbmNlIGl0c2VsZiBtYWtlcyBzZW5zZSBmb3IgZXZlcnl0aGluZyB3aGljaCBjb3VsZCBk
bwo+ID4gYXN5bmMgRE1BIGluIGdlbmVyYWwuCj4KPiBkbWFfZmVuY2Ugb25seSBwb3NzaWJseSBt
YWtlcyBzb21lIHNlbnNlIGlmIHlvdSBpbnRlbmQgdG8gZXhwb3NlIHRoZQo+IGNvbXBsZXRpb24g
b3V0c2lkZSBhIHNpbmdsZSBkcml2ZXIuCj4KPiBUaGUgcHJlZmVyZWQga2VybmVsIGRlc2lnbiBw
YXR0ZXJuIGZvciB0aGlzIGlzIHRvIGNvbm5lY3QgdGhpbmdzIHdpdGgKPiBhIGZ1bmN0aW9uIGNh
bGxiYWNrLgo+Cj4gU28gdGhlIGFjdHVhbCB1c2UgY2FzZSBvZiBkbWFfZmVuY2UgaXMgcXVpdGUg
bmFycm93IGFuZCB0aWdodGx5IGxpbmtlZAo+IHRvIERSTS4KPgo+IEkgZG9uJ3QgdGhpbmsgd2Ug
c2hvdWxkIHNwcmVhZCB0aGlzIGJleW9uZCBEUk0sIEkgY2FuJ3Qgc2VlIGEgcmVhc29uLgoKWWVh
aCB2NGwgaGFzIGEgbGVnaXQgcmVhc29uIHRvIHVzZSBkbWFfZmVuY2UsIGFuZHJvaWQgd2FudHMg
dGhhdAp0aGVyZS4gVGhlcmUncyBldmVuIGJlZW4gcGF0Y2hlcyBwcm9wb3NlZCB5ZWFycyBhZ28s
IGJ1dCBuZXZlciBsYW5kZWQKYmVjYXVzZSBhbmRyb2lkIGlzIHVzaW5nIHNvbWUgdmVuZG9yIGhh
Y2sgaG9ycm9yIHNob3cgZm9yIGNhbWVyYQpkcml2ZXJzIHJpZ2h0IG5vdy4KCkJ1dCB0aGVyZSBp
cyBhbiBlZmZvcnQgZ29pbmcgb24gdG8gZml4IHRoYXQgKHVuZGVyIHRoZSBsaWJjYW1lcmEKaGVh
ZGluZyksIGFuZCBJIGV4cGVjdCB0aGF0IG9uY2Ugd2UgaGF2ZSB0aGF0LCBpdCdsbCB3YW50IGRt
YV9mZW5jZQpzdXBwb3J0LiBTbyBvdXRyaWdodCBleGNsdWRpbmcgZXZlcnlvbmUgZnJvbSBkbWFf
ZmVuY2UgaXMgYSBiaXQgdG9vCm11Y2guIFRoZXkgZGVmaW5pdGVseSBzaG91bGRuJ3QgYmUgdXNl
ZCB0aG91Z2ggZm9yIGVudGlyZWx5CmluZGVwZW5kZW50IHN0dWZmLgoKPiA+ID4gWW91IGFyZSBi
ZXR0ZXIgdG8gZG8gc29tZXRoaW5nIGNvbnRhaW5lZCBpbiB0aGUgc2luZ2xlIGRyaXZlciB3aGVy
ZQo+ID4gPiBsb2NraW5nIGNhbiBiZSBhbmFseXplZC4KPiA+ID4KPiA+ID4gPiBJJ20gbm90IDEw
MCUgc3VyZSwgYnV0IHdvdWxkbid0IE1NVSBub3RpZmllciArIGRtYV9mZW5jZSBiZSBhIHZhbGlk
IHVzZSBjYXNlCj4gPiA+ID4gZm9yIHRoaW5ncyBsaWtlIGN1c3RvbSBGUEdBIGludGVyZmFjZXMg
YXMgd2VsbD8KPiA+ID4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgZXhwYW5kIHRoZSBsaXN0IG9m
IGRyaXZlcnMgdGhhdCB1c2UgdGhpcwo+ID4gPiB0ZWNobmlxdWUuCj4gPiA+IERyaXZlcnMgdGhh
dCBjYW4ndCBzdXNwZW5kIHNob3VsZCBwaW4gbWVtb3J5LCBub3QgdXNlIGJsb2NrZWQKPiA+ID4g
bm90aWZpZXJzIHRvIGNyZWF0ZWQgcGlubmVkIG1lbW9yeS4KPiA+Cj4gPiBBZ3JlZWQgdG90YWxs
eSwgaXQncyBhIGNvbXBsZXRlIHBhaW4gdG8gbWFpbnRhaW4gZXZlbiBmb3IgdGhlIEdQVSBkcml2
ZXJzLgo+ID4KPiA+IFVuZm9ydHVuYXRlbHkgdGhhdCBkb2Vzbid0IGNoYW5nZSB1c2VycyBmcm9t
IHJlcXVlc3RpbmcgaXQuIFNvIEknbSBwcmV0dHkKPiA+IHN1cmUgd2UgYXJlIGdvaW5nIHRvIHNl
ZSBtb3JlIG9mIHRoaXMuCj4KPiBLZXJuZWwgbWFpbnRhaW5lcnMgbmVlZCB0byBzYXkgbm8uCj4K
PiBUaGUgcHJvcGVyIHdheSB0byBkbyBETUEgb24gbm8tZmF1bHRpbmcgaGFyZHdhcmUgaXMgcGFn
ZSBwaW5uaW5nLgo+Cj4gVHJ5aW5nIHRvIGltcHJvdmUgcGVyZm9ybWFuY2Ugb2YgbGltaXRlZCBI
VyBieSB1c2luZyBza2V0Y2h5Cj4gdGVjaG5pcXVlcyBhdCB0aGUgY29zdCBvZiBnZW5lcmFsIHN5
c3RlbSBzdGFiaWxpdHkgc2hvdWxkIGJlIGEgTkFLLgoKV2VsbCB0aGF0J3MgcHJldHR5IG11Y2gg
Z3B1IGRyaXZlcnMsIGFsbCB0aGUgaG9ycm9ycyBmb3IgYSBiaXQgbW9yZSBzcGVlZCA6LSkKCk9u
IHRoZSB0ZXh0IGl0c2VsZiwgc2hvdWxkIEkgdXBncmFkZSB0byAibXVzdCBub3QiIGluc3RlYWQg
b2YgInNob3VsZApub3QiPyBPciBtb3JlIG5lZWRlZD8KLURhbmllbAotLSAKRGFuaWVsIFZldHRl
cgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwu
Y2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
