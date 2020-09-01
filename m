Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ACC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D952078B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GskaF1kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D952078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F4C6E04E;
	Tue,  1 Sep 2020 07:57:23 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED8D6E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:57:22 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z4so393982wrr.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=rrZPyEuOW4gt2fLPsnE2aYxR3CZ6Y4Hrk6qHrKHaP8I=;
 b=GskaF1kg/N4ahzRezyNm9HMo9jOEjpYg+X92QkXkvRd6KPq6QrCAEsRYawNYTDdBrL
 AX39iYyERO/0Nz+r1wAfkwQH4ykT3junwWuI5FOKwWz1H7DQX4VTPp/xeAm+hc1Mynn4
 Ga5t0k+o7CdfbGEJc1n2jt+ojs6niLoZcZ92Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rrZPyEuOW4gt2fLPsnE2aYxR3CZ6Y4Hrk6qHrKHaP8I=;
 b=Yo2KNpTtjlLONEuwZu9ikHEm1Ev5BkTLVKxgZ6rxJE0uhVoNsNaRQ84bZwD1RbHr2F
 L+XylhNAVzLZvBJTAJHVzrqgt2AUjhyOVskVNN2DmbWn3vzFa0MJuRbFgXT+m+0Ny11e
 Vg8aZBo1znb6+NNfl6AF7WDYTNj1SLc/rRuWQLi3iA4hOSc98PyOKWZZJeOx3NwYvu60
 EzmIe1FtcYLXtDyLp8XflsjRRLQsZ3Nt+v1SA9McCT72vXWz7xoDXBvTbvFRb2JrNRAf
 P3mMkGNkj2HMdpD3RRY0ugbwd/3i3ZVWCWUfGMEIgU9ShueoyeSbWkFhLRqGWp8sST/B
 qC7w==
X-Gm-Message-State: AOAM530RR0yI+5O3ArTB1ZXmVkpc3KXzxT2MYNiQuvGpTOQFIXu+hgtR
 0Wb+h4bTVkAK+yMamJle30cjug==
X-Google-Smtp-Source: ABdhPJwfD+EhmfzeMt6v/bgdClMn7aGeTDfZBO6rhaDGRA8f8/v4FpV8euIujF4hZVI0QkPkp/eBPg==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr438128wrj.215.1598947041402; 
 Tue, 01 Sep 2020 00:57:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id c4sm926955wrt.41.2020.09.01.00.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 00:57:20 -0700 (PDT)
Date: Tue, 1 Sep 2020 09:57:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu/dc: Require primary plane to be enabled
 whenever the CRTC is
Message-ID: <20200901075719.GX2352366@phenom.ffwll.local>
References: <20200821165758.1106210-1-michel@daenzer.net>
 <58dc5ed0-307e-74c9-1a8b-1e998be04900@amd.com>
 <91391bb3-a855-1a29-2d2e-a31856c99946@daenzer.net>
 <20200824104327.559503f7@eldfell>
 <b8bc3e37-d9b3-2aeb-8580-f265f1b8c830@daenzer.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8bc3e37-d9b3-2aeb-8580-f265f1b8c830@daenzer.net>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Leo Li <sunpeng.li@amd.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBBdWcgMjUsIDIwMjAgYXQgMDQ6NTU6MjhQTSArMDIwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gLS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQo+IEhhc2g6IFNIQTEK
PiAKPiBPbiAyMDIwLTA4LTI0IDk6NDMgYS5tLiwgUGVra2EgUGFhbGFuZW4gd3JvdGU6Cj4gPiBP
biBTYXQsIDIyIEF1ZyAyMDIwIDExOjU5OjI2ICswMjAwIE1pY2hlbCBEw6RuemVyCj4gPiA8bWlj
aGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+PiBPbiAyMDIwLTA4LTIxIDg6MDcgcC5tLiwgS2F6
bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4gPj4+IE9uIDIwMjAtMDgtMjEgMTI6NTcgcC5tLiwg
TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gPj4+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWRhZW56
ZXJAcmVkaGF0LmNvbT4KPiA+Pj4+Cj4gPj4+PiBEb24ndCBjaGVjayBkcm1fY3J0Y19zdGF0ZTo6
YWN0aXZlIGZvciB0aGlzIGVpdGhlciwgcGVyIGl0cwo+ID4+Pj4gZG9jdW1lbnRhdGlvbiBpbiBp
bmNsdWRlL2RybS9kcm1fY3J0Yy5oOgo+ID4+Pj4KPiA+Pj4+ICogSGVuY2UgZHJpdmVycyBtdXN0
IG5vdCBjb25zdWx0IEBhY3RpdmUgaW4gdGhlaXIgdmFyaW91cyAqCj4gPj4+PiAmZHJtX21vZGVf
Y29uZmlnX2Z1bmNzLmF0b21pY19jaGVjayBjYWxsYmFjayB0byByZWplY3QgYW4KPiA+Pj4+IGF0
b21pYyAqIGNvbW1pdC4KPiA+Pj4+Cj4gPj4+PiBUaGUgYXRvbWljIGhlbHBlcnMgZGlzYWJsZSB0
aGUgQ1JUQyBhcyBuZWVkZWQgZm9yIGRpc2FibGluZwo+ID4+Pj4gdGhlIHByaW1hcnkgcGxhbmUu
Cj4gPj4+Pgo+ID4+Pj4gVGhpcyBwcmV2ZW50cyBhdCBsZWFzdCB0aGUgZm9sbG93aW5nIHByb2Js
ZW1zIGlmIHRoZSBwcmltYXJ5Cj4gPj4+PiBwbGFuZSBnZXRzIGRpc2FibGVkIChlLmcuIGR1ZSB0
byBkZXN0cm95aW5nIHRoZSBGQiBhc3NpZ25lZAo+ID4+Pj4gdG8gdGhlIHByaW1hcnkgcGxhbmUs
IGFzIGhhcHBlbnMgZS5nLiB3aXRoIG11dHRlciBpbiBXYXlsYW5kCj4gPj4+PiBtb2RlKToKPiA+
Pj4+Cj4gPj4+PiAqIFRvZ2dsaW5nIENSVEMgYWN0aXZlIHRvIDEgZmFpbGVkIGlmIHRoZSBjdXJz
b3IgcGxhbmUgd2FzCj4gPj4+PiBlbmFibGVkIChlLmcuIHZpYSBsZWdhY3kgRFBNUyBwcm9wZXJ0
eSAmIGN1cnNvciBpb2N0bCkuICoKPiA+Pj4+IEVuYWJsaW5nIHRoZSBjdXJzb3IgcGxhbmUgZmFp
bGVkLCBlLmcuIHZpYSB0aGUgbGVnYWN5IGN1cnNvcgo+ID4+Pj4gaW9jdGwuCj4gPj4+Cj4gPj4+
IFdlIHByZXZpb3VzbHkgaGFkIHRoZSByZXF1aXJlbWVudCB0aGF0IHRoZSBwcmltYXJ5IHBsYW5l
IG11c3QKPiA+Pj4gYmUgZW5hYmxlZCBidXQgc29tZSB1c2Vyc3BhY2UgZXhwZWN0cyB0aGF0IHRo
ZXkgY2FuIGVuYWJsZQo+ID4+PiBqdXN0IHRoZSBvdmVybGF5IHBsYW5lIHdpdGhvdXQgYW55dGhp
bmcgZWxzZS4KPiA+Pj4KPiA+Pj4gSSB0aGluayB0aGUgY2hyb211aXVtb3MgYXRvbWljdGVzdCB2
YWxpZGF0ZXMgdGhhdCB0aGlzIHdvcmtzCj4gPj4+IGFzIHdlbGw6Cj4gPj4+Cj4gPj4+IFNvIGlz
IERSTSBnb2luZyBmb3J3YXJkIHRoZW4gd2l0aCB0aGUgZXhwZWN0YXRpb24gdGhhdCB0aGlzIGlz
Cj4gPj4+IHdyb25nIGJlaGF2aW9yIGZyb20gdXNlcnNwYWNlPwo+ID4+Pgo+ID4+PiBXZSByZXF1
aXJlIGF0IGxlYXN0IG9uZSBwbGFuZSB0byBiZSBlbmFibGVkIHRvIGRpc3BsYXkgYQo+ID4+PiBj
dXJzb3IsIGJ1dCBpdCBkb2Vzbid0IG5lY2Vzc2FyaWx5IG5lZWQgdG8gYmUgdGhlIHByaW1hcnku
Cj4gPj4KPiA+PiBJdCdzIGEgInBpY2sgeW91ciBwb2lzb24iIHNpdHVhdGlvbjoKPiA+Pgo+ID4+
IDEpIEN1cnJlbnRseSB0aGUgY2hlY2tzIGFyZSBpbnZhbGlkIChhdG9taWNfY2hlY2sgbXVzdCBu
b3QKPiA+PiBkZWNpZGUgYmFzZWQgb24gZHJtX2NydGNfc3RhdGU6OmFjdGl2ZSksIGFuZCBpdCdz
IGVhc3kgZm9yIGxlZ2FjeQo+ID4+IEtNUyB1c2Vyc3BhY2UgdG8gYWNjaWRlbnRhbGx5IGhpdCBl
cnJvcnMgdHJ5aW5nIHRvIGVuYWJsZS9tb3ZlCj4gPj4gdGhlIGN1cnNvciBvciBzd2l0Y2ggRFBN
UyBvZmYg4oaSIG9uLgo+ID4+Cj4gPj4gMikgQWNjdXJhdGVseSByZWplY3Rpbmcgb25seSBhdG9t
aWMgc3RhdGVzIHdoZXJlIHRoZSBjdXJzb3IKPiA+PiBwbGFuZSBpcyBlbmFibGVkIGJ1dCBhbGwg
b3RoZXIgcGxhbmVzIGFyZSBvZmYgd291bGQgYnJlYWsgdGhlCj4gPj4gS01TIGhlbHBlciBjb2Rl
LCB3aGljaCBjYW4gb25seSBkZWFsIHdpdGggdGhlICJDUlRDIG9uICYgcHJpbWFyeQo+ID4+IHBs
YW5lIG9mZiBpcyBub3QgYWxsb3dlZCIgY2FzZSBzcGVjaWZpY2FsbHkuCj4gPj4KPiA+PiAzKSBU
aGlzIHBhdGNoIGFkZHJlc3NlcyAxKSAmIDIpIGJ1dCBtYXkgYnJlYWsgZXhpc3RpbmcgYXRvbWlj
Cj4gPj4gdXNlcnNwYWNlIHdoaWNoIHdhbnRzIHRvIGVuYWJsZSBhbiBvdmVybGF5IHBsYW5lIHdo
aWxlIGRpc2FibGluZwo+ID4+IHRoZSBwcmltYXJ5IHBsYW5lLgo+ID4+Cj4gPj4KPiA+PiBJIGRv
IHRoaW5rIGluIHByaW5jaXBsZSBhdG9taWMgdXNlcnNwYWNlIGlzIGV4cGVjdGVkIHRvIGhhbmRs
ZQo+ID4+IGNhc2UgMykgYW5kIGxlYXZlIHRoZSBwcmltYXJ5IHBsYW5lIGVuYWJsZWQuCj4gPgo+
ID4gSGksCj4gPgo+ID4gbXkgb3BpbmlvbiBhcyBhIHVzZXJzcGFjZSBkZXZlbG9wZXIgaXMgdGhh
dCBlbmFibGluZyBhIENSVEMKPiA+IHdpdGhvdXQgYSBwcmltYXJ5IHBsYW5lIGhhcyB0cmFkaXRp
b25hbGx5IG5vdCB3b3JrZWQsIHNvIHVzZXJzcGFjZQo+ID4gY2Fubm90ICpyZWx5KiBvbiBpdCBl
dmVyIHdvcmtpbmcuIEkgdGhpbmsgbGVnYWN5IEtNUyBBUEkgZG9lcyBub3QKPiA+IGV2ZW4gYWxs
b3cgdG8gZXhwcmVzcyB0aGF0IHJlYWxseSwgb3IgaGFzIGJ1aWx0LWluIGFzc3VtcHRpb25zIHRo
YXQKPiA+IGl0IGRvZXNuJ3Qgd29yayAtIHlvdSBjYW4gY2FsbCB0aGUgbGVnYWN5IGN1cnNvciBp
b2N0bHMsIHRoZXkKPiA+IGRvbid0IGZhaWwsIGJ1dCBhbHNvIHRoZSBDUlRDIHJlbWFpbnMgb2Zm
LiBDb3JyZWN0IG1lIGlmIHRoaXMgaXMKPiA+IG5vdCB0cnVlLgo+ID4KPiA+IEF0b21pYyB1c2Vy
c3BhY2UgT1RPSCBpcyByZXF1aXJlZCB0byB0ZXN0IHRoZSBzdHJhbmdlIChhbmQgYWxsISkKPiA+
IGNhc2VzIGxpa2UgdGhpcyB0byBzZWUgaWYgdGhleSB3b3JrIG9yIG5vdCwgYW5kIGNhcnJ5IG9u
IHdpdGggYQo+ID4gZmFsbGJhY2sgaWYgdGhleSBkb24ndC4gVXNlcnNwYWNlIHRoYXQgd2FudHMg
dG8gdXNlIGEgQ1JUQyB3aXRob3V0Cj4gPiBhIHByaW1hcnkgcGxhbmUgbGlrZWx5IG5lZWRzIG90
aGVyIENSVEMgcHJvcGVydGllcyBhcyB3ZWxsLCBsaWtlCj4gPiBiYWNrZ3JvdW5kIGNvbG9yLgo+
ID4KPiA+IEkgd291bGQgZ3Vlc3MgdGhhdCB3aGVuIHR3byByZWdyZXNzaW9ucyBjb25mbGljdCwg
dGhlIG9sZGVyCj4gPiB1c2Vyc3BhY2Ugd291bGQgd2luLiBIZW5jZSBsZWdhY3kgS01TIHVzaW5n
IE11dHRlciBzaG91bGQga2VlcAo+ID4gd29ya2luZywgd2hpbGUgYXRvbWljIHVzZXJzcGFjZSBp
cyBsZWZ0IHdpdGggaW5jcmVhc2VkIHBvd2VyCj4gPiBjb25zdW1wdGlvbi4gTm90IHVzaW5nIGEg
aGFyZHdhcmUgY3Vyc29yIChNdXR0ZXIpIGlzIG11Y2ggbW9yZQo+ID4gZWFzaWx5IGFuIGVuZC11
c2VyIHZpc2libGUgcmVncmVzc2lvbiB0aGFuIHNsaWdodGx5IHNob3J0ZXIKPiA+IGJhdHRlcnkg
bGlmZS4KPiA+Cj4gPiBBdG9taWMgdGVzdCBjb21taXRzIGFyZSBhbGxvd2VkIHRvIGZhaWwgYXQg
YW55IHRpbWUgZm9yIGFueSByZWFzb24KPiA+IGFuZCBzb21ldGhpbmcgdGhhdCBwcmV2aW91c2x5
IHdvcmtlZCBjYW4gZmFpbCBvbiB0aGUgbmV4dCBmcmFtZSBvcgo+ID4gb24gdGhlIG5leHQga2Vy
bmVsLCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kLgo+IAo+IEFsbCBvZiB0aGlzIGJhc2ljYWxseSBt
YXRjaGVzIG15IHVuZGVyc3RhbmRpbmcuCj4gCj4gCj4gPiBTb3VuZHMgbGlrZSB0aGUgaGVscGVy
cyB5b3UgcmVmZXIgdG8gYXJlIGluYWRlcXVhdGUgZm9yIHlvdXIgY2FzZS4KPiA+IENhbid0IHlv
dSBmaXggdGhlIGhlbHBlcnMgaW4gdGhlIGxvbmcgcnVuIGFuZCBsYW5kIHRoaXMgcGF0Y2ggYXMg
YW4KPiA+IGltbWVkaWF0ZSBmaXg/Cj4gCj4gSSdkIHJhdGhlciBsZWF2ZSB3b3JraW5nIG9uIHRo
b3NlIGhlbHBlcnMgdG8gS01TIGRldmVsb3BlcnMuIDopCgpJIHRob3VnaHQgdGhlIGlzc3VlIGlz
IHRoZSBybWZiIGlvY3RsIHRyaWNrZXJ5LCB3aGljaCBoYXMgdGhpcyBhc3N1bXB0aW9uCmZ1bGx5
IGJhY2tlZCBpbi4gVGhlIHdpZ2dsZSByb29tIGluIHRoZXJlIGZvciBzZW1hbnRpYyBjaGFuZ2Vz
IGlzIGlpcmMKcHJldHR5IG11Y2ggbmlsLCBpdCB0b29rIHVzIGEgcGlsZSBvZiBwYXRjaGVzIHRv
IGp1c3QgZ2V0IHRvIHRoZSBjdXJyZW50CnN0YXRlLiBTbyBpdCdzIG5vdCBoZWxwZXIgY29kZSwg
aXQncyBjb3JlIGxlZ2FjeSBpb2N0bCBjb2RlIGZvciBhdG9taWMKZHJpdmVycy4KLURhbmllbAoK
PiAKPiAKPiAtIC0tIAo+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KPiBMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKPiAtLS0t
LUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQo+IAo+IGlGMEVBUkVDQUIwV0lRU3duNjgxdnBGRkla
Z0pVUlJhZ2ErT2F0dXlBQVVDWDBVbVhBQUtDUkJhZ2ErT2F0dXkKPiBBSWVOQUpvQzlVZ09yRitx
QnEwOHVPeWphVjdWZnArUGdBQ2ZTcDNuWEIzdW4zTFVaUXhydmF4TUFPTitlSXM9Cj4gPVBiZDIK
PiAtLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVu
Z2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
