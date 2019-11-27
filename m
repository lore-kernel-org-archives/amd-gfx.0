Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6DC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 18:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6336207DD
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 18:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6336207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8467E6E58A;
	Wed, 27 Nov 2019 18:37:07 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A55C6E58A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 18:37:06 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id g7so7207788wrw.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 10:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nXnlHex+y37zGW1dAQIQZuUnVG8uziRbH6ilwcRwAM0=;
 b=Qig2n6UW/rK647WV/DITPcDbYYuspgVSvDDL6JnyDru5xF5X5ppE53/mcSrfaCGEfI
 647UdmNU4DPfZRnt/rQSsQgFQgp2F21knujUMtvnbkip1kviIu7hC4XiIZ6R6hh5l8b+
 Fab/8MpGtDTdYeQcd0cOAsh/ywZns6vmErYj6IUDlpoAeVLWXPNRaAE3TdmYGMVU6JEg
 99CPQrES31vmXUNf41ZtueekTq2UQAme4wn15k8iUDUELNY0WNwIgCmzirjcVfeqrR5z
 szjOyLyYk4ENRlWuimr3KkBVCiNDGtoE3W7q+bggE1njXK5GyPwAvOkrfEEkI92x7x0e
 2xWQ==
X-Gm-Message-State: APjAAAXMnNrj35iYPEZlW7Kf4CJUwf12q5Ni6Q9MjYlK06qIkAePI6Px
 gphPu8ECvA8N0E5rq9pzWf4XIA==
X-Google-Smtp-Source: APXvYqzymOSBNL6l1a613nukwLKfZUcJyuj2PCOFalY+ooMhF+R+AqSwEvzy2RTFecMOmtp1Cb30qg==
X-Received: by 2002:adf:e389:: with SMTP id e9mr11874187wrm.285.1574879824661; 
 Wed, 27 Nov 2019 10:37:04 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net.
 [212.51.149.96])
 by smtp.gmail.com with ESMTPSA id r63sm7890188wma.2.2019.11.27.10.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 10:37:02 -0800 (PST)
Date: Wed, 27 Nov 2019 19:37:00 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 5/5] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
Message-ID: <20191127183700.GN406127@phenom.ffwll.local>
References: <20191101130313.8862-1-emil.l.velikov@gmail.com>
 <20191101130313.8862-5-emil.l.velikov@gmail.com>
 <20191127084104.1ceb1f62@collabora.com>
 <CACvgo52UB-sAv55_kREgHbRsg6b5KXv7At0TbgUPdc0e1E+QaA@mail.gmail.com>
 <20191127180456.GD406127@phenom.ffwll.local>
 <CACvgo50j0sU18-AqeerkgDq9joJysT_0PuQrgVS1tVhUqV9rcg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACvgo50j0sU18-AqeerkgDq9joJysT_0PuQrgVS1tVhUqV9rcg@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nXnlHex+y37zGW1dAQIQZuUnVG8uziRbH6ilwcRwAM0=;
 b=akVveJe6oZAk94/6prXgzKLp8yGY5770vPlkS7wqL3XX6Z/zJEzUWErnrv2yI0tnMi
 kJ8GV8UEE7vDywGC3AcQzW/pjeBDRsWo3VvBGfsNR1ZmY/qHp7D/IyLzF9IPBSWN2fkk
 12uZSnZUOl9GVHMfeHU5uhU1Dw2jrzV0q8g1M=
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
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127183700.jKvPV-ctySbZqDPjV8SN2VgrzJOUNL-WlXeGTw3QZL8@z>

T24gV2VkLCBOb3YgMjcsIDIwMTkgYXQgMDY6MzI6NTZQTSArMDAwMCwgRW1pbCBWZWxpa292IHdy
b3RlOgo+IE9uIFdlZCwgMjcgTm92IDIwMTkgYXQgMTg6MDQsIERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBOb3YgMjcsIDIwMTkgYXQgMDQ6Mjc6
MjlQTSArMDAwMCwgRW1pbCBWZWxpa292IHdyb3RlOgo+ID4gPiBPbiBXZWQsIDI3IE5vdiAyMDE5
IGF0IDA3OjQxLCBCb3JpcyBCcmV6aWxsb24KPiA+ID4gPGJvcmlzLmJyZXppbGxvbkBjb2xsYWJv
cmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IEhpIEVtaWwsCj4gPiA+ID4KPiA+ID4gPiBP
biBGcmksICAxIE5vdiAyMDE5IDEzOjAzOjEzICswMDAwCj4gPiA+ID4gRW1pbCBWZWxpa292IDxl
bWlsLmwudmVsaWtvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gPiBGcm9tOiBF
bWlsIFZlbGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+ID4gPiA+ID4KPiA+ID4g
PiA+IEFzIG1lbnRpb25lZCBieSBDaHJpc3RpYW4sIGZvciBkcml2ZXJzIHdoaWNoIHN1cHBvcnQg
b25seSBwcmltYXJ5IG5vZGVzCj4gPiA+ID4gPiB0aGlzIGNoYW5nZXMgdGhlIHJldHVybmVkIGVy
cm9yIGZyb20gLUVBQ0NFUyBpbnRvIC1FT1BOT1RTVVBQLy1FTk9TWVMuCj4gPiA+ID4KPiA+ID4g
PiBBcmUgeW91IHN1cmUgdGhpcyBpcyB0cnVlIGZvciBNT0RFU0VULW9ubHkgbm9kZXMgKHRob3Nl
IHRoYXQgZG8gbm90Cj4gPiA+ID4gaGF2ZSB0aGUgUkVOREVSIGNhcCBzZXQpIGltcGxlbWVudGlu
ZyAtPntmZF90b19oYW5kbGUsaGFuZGxlX3RvX2ZkfSgpPwo+ID4gPiA+IFNob3VsZG4ndCB0aGUg
aXNfYXV0aGVudGljYXRlZCgpIGNoZWNrIHN0aWxsIGJlIGRvbmUgaW4gdGhhdCBjYXNlPwo+ID4g
PiA+Cj4gPiA+IFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4gSnVzdCBzZW50IG91dCB2Miwgd2hp
Y2ggSSBzaG91bGQgYWRkcmVzcyB0aGUgY29uY2Vybi4KPiA+Cj4gPiBXaHkgZG8gd2UgbmVlZCB0
aGlzIGFkZGl0aW9uYWwgY2hlY2sgaW4gdjI/IFdoYXQgY2FuIGdvIHdyb25nIG9uIG1vZGVzZXQK
PiA+IGRyaXZlcnMgaWYgbm9uLWF1dGhlbnRpY2F0ZWQgbGVnYWN5IHRoaW5ncyBjYW4gdXNlIHRo
aXM/IG1vZGVzZXQtb25seQo+ID4gZHJpdmVycyBoYXZlIGFsbCB0aGVpciByZXNvdXJjZXMgc2Vn
cmVnYXRlZCBieSB0aGUgZHJtIGNvcmUgKGRybV9mYiwKPiA+IG1tYXBzLCBidWZmZXIgbGlzdHMp
LCBzbyB0aGVyZSdzIHJlYWxseSBubyBhY2Nlc3MgbGltaXRhdGlvbnMgdGhhdCBjYW4gZ28KPiA+
IHdyb25nIGhlcmUuCj4gCj4gV2VsY29tZSBiYWNrIERhbmllbC4KPiAKPiBJIGhhdmVuJ3QgYXVk
aXRlZCB0aGUgY29yZSBkcm0gY29kZSwgc28gd2Fzbid0IHN1cmUgaWYgdGhlcmUncyBhbnkKPiBp
c3N1ZXMgdGhhdCBtYXkgYXJpc2UuCj4gSGVuY2UgdGhlIGNvbnNlcnZhdGl2ZSBhcHByb2FjaCBp
biB2Mi4KPiAKPiBJZiB5b3UgdGhpbmsgdGhpcyBpcyBmaW5lIGFzLWlzIGEgZm9ybWFsIFJldmll
d2VkLWJ5IHdvdWxkIGJlIGhpZ2hseQo+IGFwcHJlY2lhdGVkLgoKSSB0aGluayB0aGVyZSdzIGEg
bm9uLXplcm8gY2hhbmNlIEknbGwgaGF2ZSB0byBlYXQgYSBmZXcgaGF0cyBvbiB0aGlzLCBidXQK
SSB0aGluayB2MSBpcyBzb2xpZC4KClJldmlld2VkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwu
dmV0dGVyQGZmd2xsLmNoPgoKPiAKPiBUaGFua3MKPiBFbWlsCgotLSAKRGFuaWVsIFZldHRlcgpT
b2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
