Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A27C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BA0206F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SkJhztXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BA0206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C247A6E5CF;
	Wed, 22 Jul 2020 07:12:07 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C22A06E5CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 07:12:06 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id h17so1023568oie.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JwkeYyBomvbYnFOaLpEKlvJ8DzuwKSpH8FekeAKJGLk=;
 b=SkJhztXGGkVSi+CMtPZ9mnNyIZWb3W+Hi8+3aiJVas3tDxC/kBOhWX+3nnbfTpWlDa
 9UwfYCUVg3UUFxW3a9F7GY0tSXLJgK74FxaZAlm/QwZzPlIEgPRh/x41/ptVhbOLyUY4
 gUYP4TSQcKLUYmmU2jU3ByYY0yTbp47s9NoiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JwkeYyBomvbYnFOaLpEKlvJ8DzuwKSpH8FekeAKJGLk=;
 b=D1AUindHoTFglUvO43IY6rImzkzjvxWF66EaquNBytqLP3ngsGaBz2vICP+rW7FBHY
 5wxoGitlCZ0rB5n6u87zkIl6RyEIFsBKeT6gzpnZdCfB1ZP7frobsiVh6naySK3htwFH
 bm+jA/Jc5E6j8ea/EyXIA18EqZBd9opXkmFCPqCxNJRDzeQGIOgPDkcii9YMzlmx6/A5
 A/pmcxu9MkP0JKJVn2hz0QpDxG76cWuMV2lW+t7FMCSObWP4VoS1g73sDjKN383dAcCn
 PqSndFXXPUieEa6DpVJog1n4oT9pzaA834CbWjgN3iYIFyGTjBs2f/nqYZC7Msj4ArTv
 iKDw==
X-Gm-Message-State: AOAM533XwnlswHjc506V/8OGtSSybuhNfL0G0DcdOBpELXYQvvvCxqKK
 ujCeUjxaCoydfe9FkPICgVU76JxXNnKoajRqyUl0ug==
X-Google-Smtp-Source: ABdhPJw79eBtwBgNaIl2ZcTK/cPqRyZb7BtTpgm+YE8+ssCbvckOKoeqxVWT4IlUKWv7BYthNQjzDv0cdeiPNmWCvMQ=
X-Received: by 2002:a05:6808:88:: with SMTP id
 s8mr5710875oic.101.1595401926052; 
 Wed, 22 Jul 2020 00:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
In-Reply-To: <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 22 Jul 2020 09:11:55 +0200
Message-ID: <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= <thomas_os@shipmail.org>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Daniel Stone <daniels@collabora.com>, linux-rdma <linux-rdma@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Steve Pronovost <spronovo@microsoft.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Dave Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgODo0NSBBTSBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwp
Cjx0aG9tYXNfb3NAc2hpcG1haWwub3JnPiB3cm90ZToKPgo+Cj4gT24gMjAyMC0wNy0yMiAwMDo0
NSwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4gPiBPbiBUdWUsIDIxIEp1bCAyMDIwIGF0IDE4OjQ3LCBU
aG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpCj4gPiA8dGhvbWFzX29zQHNoaXBtYWlsLm9yZz4gd3Jv
dGU6Cj4gPj4KPiA+PiBPbiA3LzIxLzIwIDk6NDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4gPj4+IEFtIDIxLjA3LjIwIHVtIDA5OjQxIHNjaHJpZWIgRGFuaWVsIFZldHRlcjoKPiA+Pj4+
IE9uIE1vbiwgSnVsIDIwLCAyMDIwIGF0IDAxOjE1OjE3UE0gKzAyMDAsIFRob21hcyBIZWxsc3Ry
w7ZtIChJbnRlbCkKPiA+Pj4+IHdyb3RlOgo+ID4+Pj4+IEhpLAo+ID4+Pj4+Cj4gPj4+Pj4gT24g
Ny85LzIwIDI6MzMgUE0sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gPj4+Pj4+IENvbWVzIHVwIGV2
ZXJ5IGZldyB5ZWFycywgZ2V0cyBzb21ld2hhdCB0ZWRpb3VzIHRvIGRpc2N1c3MsIGxldCdzCj4g
Pj4+Pj4+IHdyaXRlIHRoaXMgZG93biBvbmNlIGFuZCBmb3IgYWxsLgo+ID4+Pj4+Pgo+ID4+Pj4+
PiBXaGF0IEknbSBub3Qgc3VyZSBhYm91dCBpcyB3aGV0aGVyIHRoZSB0ZXh0IHNob3VsZCBiZSBt
b3JlIGV4cGxpY2l0IGluCj4gPj4+Pj4+IGZsYXQgb3V0IG1hbmRhdGluZyB0aGUgYW1ka2ZkIGV2
aWN0aW9uIGZlbmNlcyBmb3IgbG9uZyBydW5uaW5nIGNvbXB1dGUKPiA+Pj4+Pj4gd29ya2xvYWRz
IG9yIHdvcmtsb2FkcyB3aGVyZSB1c2Vyc3BhY2UgZmVuY2luZyBpcyBhbGxvd2VkLgo+ID4+Pj4+
IEFsdGhvdWdoIChpbiBteSBodW1ibGUgb3BpbmlvbikgaXQgbWlnaHQgYmUgcG9zc2libGUgdG8g
Y29tcGxldGVseQo+ID4+Pj4+IHVudGFuZ2xlCj4gPj4+Pj4ga2VybmVsLWludHJvZHVjZWQgZmVu
Y2VzIGZvciByZXNvdXJjZSBtYW5hZ2VtZW50IGFuZCBkbWEtZmVuY2VzIHVzZWQKPiA+Pj4+PiBm
b3IKPiA+Pj4+PiBjb21wbGV0aW9uLSBhbmQgZGVwZW5kZW5jeSB0cmFja2luZyBhbmQgbGlmdCBh
IGxvdCBvZiByZXN0cmljdGlvbnMKPiA+Pj4+PiBmb3IgdGhlCj4gPj4+Pj4gZG1hLWZlbmNlcywg
aW5jbHVkaW5nIHByb2hpYml0aW5nIGluZmluaXRlIG9uZXMsIEkgdGhpbmsgdGhpcyBtYWtlcwo+
ID4+Pj4+IHNlbnNlCj4gPj4+Pj4gZGVzY3JpYmluZyB0aGUgY3VycmVudCBzdGF0ZS4KPiA+Pj4+
IFllYWggSSB0aGluayBhIGZ1dHVyZSBwYXRjaCBuZWVkcyB0byB0eXBlIHVwIGhvdyB3ZSB3YW50
IHRvIG1ha2UgdGhhdAo+ID4+Pj4gaGFwcGVuIChmb3Igc29tZSBjcm9zcyBkcml2ZXIgY29uc2lz
dGVuY3kpIGFuZCB3aGF0IG5lZWRzIHRvIGJlCj4gPj4+PiBjb25zaWRlcmVkLiBTb21lIG9mIHRo
ZSBuZWNlc3NhcnkgcGFydHMgYXJlIGFscmVhZHkgdGhlcmUgKHdpdGggbGlrZSB0aGUKPiA+Pj4+
IHByZWVtcHRpb24gZmVuY2VzIGFtZGtmZCBoYXMgYXMgYW4gZXhhbXBsZSksIGJ1dCBJIHRoaW5r
IHNvbWUgY2xlYXIgZG9jcwo+ID4+Pj4gb24gd2hhdCdzIHJlcXVpcmVkIGZyb20gYm90aCBodywg
ZHJpdmVycyBhbmQgdXNlcnNwYWNlIHdvdWxkIGJlIHJlYWxseQo+ID4+Pj4gZ29vZC4KPiA+Pj4g
SSdtIGN1cnJlbnRseSB3cml0aW5nIHRoYXQgdXAsIGJ1dCBwcm9iYWJseSBzdGlsbCBuZWVkIGEg
ZmV3IGRheXMgZm9yCj4gPj4+IHRoaXMuCj4gPj4gR3JlYXQhIEkgcHV0IGRvd24gc29tZSAodmVy
eSkgaW5pdGlhbCB0aG91Z2h0cyBhIGNvdXBsZSBvZiB3ZWVrcyBhZ28KPiA+PiBidWlsZGluZyBv
biBldmljdGlvbiBmZW5jZXMgZm9yIHZhcmlvdXMgaGFyZHdhcmUgY29tcGxleGl0eSBsZXZlbHMg
aGVyZToKPiA+Pgo+ID4+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy90aG9tYXNoL2Rv
Y3MvLS9ibG9iL21hc3Rlci9VbnRhbmdsaW5nJTIwZG1hLWZlbmNlJTIwYW5kJTIwbWVtb3J5JTIw
YWxsb2NhdGlvbi5vZHQKPiA+IFdlIGFyZSBzZWVpbmcgSFcgdGhhdCBoYXMgcmVjb3ZlcmFibGUg
R1BVIHBhZ2UgZmF1bHRzIGJ1dCBvbmx5IGZvcgo+ID4gY29tcHV0ZSB0YXNrcywgYW5kIHNjaGVk
dWxlciB3aXRob3V0IHNlbWFwaG9yZXMgaHcgZm9yIGdyYXBoaWNzLgo+ID4KPiA+IFNvIGEgc2lu
Z2xlIGRyaXZlciBtYXkgaGF2ZSB0byBleHBvc2UgYm90aCBtb2RlbHMgdG8gdXNlcnNwYWNlIGFu
ZAo+ID4gYWxzbyBpbnRyb2R1Y2VzIHRoZSBwcm9ibGVtIG9mIGhvdyB0byBpbnRlcm9wZXJhdGUg
YmV0d2VlbiB0aGUgdHdvCj4gPiBtb2RlbHMgb24gb25lIGNhcmQuCj4gPgo+ID4gRGF2ZS4KPgo+
IEhtbSwgeWVzIHRvIGJlZ2luIHdpdGggaXQncyBpbXBvcnRhbnQgdG8gbm90ZSB0aGF0IHRoaXMg
aXMgbm90IGEKPiByZXBsYWNlbWVudCBmb3IgbmV3IHByb2dyYW1taW5nIG1vZGVscyBvciBBUElz
LCBUaGlzIGlzIHNvbWV0aGluZyB0aGF0Cj4gdGFrZXMgcGxhY2UgaW50ZXJuYWxseSBpbiBkcml2
ZXJzIHRvIG1pdGlnYXRlIG1hbnkgb2YgdGhlIHJlc3RyaWN0aW9ucwo+IHRoYXQgYXJlIGN1cnJl
bnRseSBpbXBvc2VkIG9uIGRtYS1mZW5jZSBhbmQgZG9jdW1lbnRlZCBpbiB0aGlzIGFuZAo+IHBy
ZXZpb3VzIHNlcmllcy4gSXQncyBiYXNpY2FsbHkgdGhlIGRyaXZlci1wcml2YXRlIG5hcnJvdyBj
b21wbGV0aW9ucwo+IEphc29uIHN1Z2dlc3RlZCBpbiB0aGUgbG9ja2RlcCBwYXRjaGVzIGRpc2N1
c3Npb25zIGltcGxlbWVudGVkIHRoZSBzYW1lCj4gd2F5IGFzIGV2aWN0aW9uLWZlbmNlcy4KPgo+
IFRoZSBtZW1vcnkgZmVuY2UgQVBJIHdvdWxkIGJlIGxvY2FsIHRvIGhlbHBlcnMgYW5kIG1pZGRs
ZS1sYXllcnMgbGlrZQo+IFRUTSwgYW5kIHRoZSBjb3JyZXNwb25kaW5nIGRyaXZlcnMuICBUaGUg
b25seSBjcm9zcy1kcml2ZXItbGlrZQo+IHZpc2liaWxpdHkgd291bGQgYmUgdGhhdCB0aGUgZG1h
LWJ1ZiBtb3ZlX25vdGlmeSgpIGNhbGxiYWNrIHdvdWxkIG5vdCBiZQo+IGFsbG93ZWQgdG8gd2Fp
dCBvbiBkbWEtZmVuY2VzIG9yIHNvbWV0aGluZyB0aGF0IGRlcGVuZHMgb24gYSBkbWEtZmVuY2Uu
CgpCZWNhdXNlIHdlIGNhbid0IHByZWVtcHQgKG9uIHNvbWUgZW5naW5lcyBhdCBsZWFzdCkgd2Ug
YWxyZWFkeSBoYXZlCnRoZSByZXF1aXJlbWVudCB0aGF0IGNyb3NzIGRyaXZlciBidWZmZXIgbWFu
YWdlbWVudCBjYW4gZ2V0IHN0dWNrIG9uIGEKZG1hLWZlbmNlLiBOb3QgZXZlbiB0YWtpbmcgaW50
byBhY2NvdW50IHRoZSBob3Jyb3JzIHdlIGRvIHdpdGgKdXNlcnB0ciwgd2hpY2ggYXJlIGNyb3Nz
IGRyaXZlciBubyBtYXR0ZXIgd2hhdC4gTGltaXRpbmcgbW92ZV9ub3RpZnkKdG8gbWVtb3J5IGZl
bmNlcyBvbmx5IGRvZXNuJ3Qgd29yaywgc2luY2UgdGhlIHB0ZSBjbGVhcmluZyBtaWdodCBuZWVk
CnRvIHdhaXQgZm9yIGEgZG1hX2ZlbmNlIGZpcnN0LiBIZW5jZSB0aGlzIGJlY29tZXMgYSBmdWxs
IGVuZC1vZi1iYXRjaApmZW5jZSwgbm90IGp1c3QgYSBsaW1pdGVkIGtlcm5lbC1pbnRlcm5hbCBt
ZW1vcnkgZmVuY2UuCgpUaGF0J3Mga2luZGEgd2h5IEkgdGhpbmsgb25seSByZWFzb25hYmxlIG9w
dGlvbiBpcyB0byB0b3NzIGluIHRoZQp0b3dlbCBhbmQgZGVjbGFyZSBkbWEtZmVuY2UgdG8gYmUg
dGhlIG1lbW9yeSBmZW5jZSAoYW5kIHN1Y2sgdXAgYWxsCnRoZSBjb25zZXF1ZW5jZXMgb2YgdGhh
dCBkZWNpc2lvbiBhcyB1YXBpLCB3aGljaCBpcyBraW5kYSB3aGVyZSB3ZQphcmUpLCBhbmQgY29u
c3RydWN0IHNvbWV0aGluZyBuZXcmZW50aXJlbHkgZnJlZS13aGVlbGluZyBmb3IgdXNlcnNwYWNl
CmZlbmNpbmcuIEJ1dCBvbmx5IGZvciBlbmdpbmVzIHRoYXQgYWxsb3cgZW5vdWdoIHByZWVtcHQv
Z3B1IHBhZ2UKZmF1bHRpbmcgdG8gbWFrZSB0aGF0IHBvc3NpYmxlLiBGcmVlIHdoZWVsaW5nIHVz
ZXJzcGFjZSBmZW5jZXMvZ3B1CnNlbWFwaG9yZXMgb3Igd2hhdGV2ZXIgeW91IHdhbnQgdG8gY2Fs
bCB0aGVtIChvbiB3aW5kb3dzIEkgdGhpbmsgaXQncwptb25pdG9yZWQgZmVuY2UpIG9ubHkgd29y
ayBpZiB5b3UgY2FuIHByZWVtcHQgdG8gZGVjb3VwbGUgdGhlIG1lbW9yeQpmZW5jZXMgZnJvbSB5
b3VyIGdwdSBjb21tYW5kIGV4ZWN1dGlvbi4KClRoZXJlJ3MgdGhlIGluLWJldHdlZW4gc3RlcCBv
ZiBqdXN0IGRlY291cGxpbmcgdGhlIGJhdGNoYnVmZmVyCnN1Ym1pc3Npb24gcHJlcCBmb3IgaHcg
d2l0aG91dCBhbnkgcHJlZW1wdCAoYnV0IGEgc2NoZWR1bGVyKSwgYnV0IHRoYXQKc2VlbXMga2lu
ZGEgcG9pbnRsZXNzLiBNb2Rlcm4gZXhlY2J1ZiBzaG91bGQgYmUgTygxKSBmYXN0cGF0aCwgd2l0
aAphbGwgdGhlIGFsbG9jYXRpb24vbWFwcGluZyB3b3JrIHB1bGxlZCBvdXQgYWhlYWQuIHZrIGV4
cG9zZXMgdGhhdAptb2RlbCBkaXJlY3RseSB0byBjbGllbnRzLCBHTCBkcml2ZXJzIGNvdWxkIHVz
ZSBpdCBpbnRlcm5hbGx5IHRvbywgc28KSSBzZWUgemVybyB2YWx1ZSBpbiBzcGVuZGluZyBsb3Rz
IG9mIHRpbWUgZW5naW5lZXJpbmcgdmVyeSB0cmlja3kKa2VybmVsIGNvZGUganVzdCBmb3Igb2xk
IHVzZXJzcGFjZS4gTXVjaCBtb3JlIHJlYXNvbmFibGUgdG8gZG8gdGhhdCBpbgp1c2Vyc3BhY2Us
IHdoZXJlIHdlIGhhdmUgcmVhbCBkZWJ1Z2dlcnMgYW5kIG5vIHBhbmljcyBhYm91dCBzZWN1cml0
eQpidWdzIChvciB3ZWxsLCBhIGxvdCBsZXNzLCB3ZWJnbCBpcyBzdGlsbCBhIHRoaW5nLCBidXQg
YXQgbGVhc3QKYnJvd3NlcnMgcmVhbGl6ZWQgeW91IG5lZWQgdG8gY29udGFpbmVyIHRoYXQgY29t
cGxldGVseSkuCgpDaGVlcnMsIERhbmllbAoKPiBTbyB3aXRoIHRoYXQgaW4gbWluZCwgSSBkb24n
dCBmb3Jlc2VlIGVuZ2luZXMgd2l0aCBkaWZmZXJlbnQKPiBjYXBhYmlsaXRpZXMgb24gdGhlIHNh
bWUgY2FyZCBiZWluZyBhIHByb2JsZW0uCj4KPiAvVGhvbWFzCj4KPgoKCi0tIApEYW5pZWwgVmV0
dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZnds
bC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
