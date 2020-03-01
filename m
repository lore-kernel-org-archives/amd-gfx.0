Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7765C3F2D5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE12246B6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="13LsT36R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE12246B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025446E120;
	Mon,  2 Mar 2020 08:19:36 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F397D6E22E
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2020 14:27:29 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id p62so4910672qkb.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2020 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=Vt75wDU9UMss0WdpIsnKwFhGF1GAn+eY03d4jfucIdg=;
 b=13LsT36RJ7ELQXJScaSSfK1ouXiVJ3UU9w+Nt2QBoloGLZRp0FO6JCbLQ8X8m/f11o
 R/2y6E1dSKg21xSySE9ogPGt2B/v3aUv6cYaiur4w5/6BIfnrYPFbHmUOf8GmCbK6q1z
 LkfCEDtcdeAXm/g0fctYGNus52crxoxG6O46yX2Rpsxry1KQapz5hTxVVGvB71omSJ8N
 0yR5Bvl6dl+Xioj1YeQJ8NCIwP7Pu3rsilzSnHsiG8dBnlEZ4FuVglR3sDs/tIVl50eR
 V25v+SAeS3n4GPf2BJzmUWZA7eUNlk4/wK/RYCq8DY0rv5UoAYWLAn3dmlQYIBr4ad+5
 01VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=Vt75wDU9UMss0WdpIsnKwFhGF1GAn+eY03d4jfucIdg=;
 b=pdSYYezm/p7lnyh3Sz7T1LZcAg/wObVUSCPpRPWXQ88yrsScgLsE/hno8UYrleDsHk
 NKR2813iV4+pSD7lzWM+0Jf3h/7yLYWN6mesmvrW4Y7YCqo7Oveboax4X3mMyUTp8TNW
 sdkDFevaPLtHv+Ict2n1D5xuehxKVG5eQtjRA4OEa2UiCpOiSZEutHwrtjq8gkZoDkLj
 IuKDcAmAWAON77Y/cg2aGs3/BlB9OHW/ARiUNwgjAZ33XVJGZ6S5HHwdbdYp1RW8vOVg
 bYyxRq0jvOmUa6M3bRSxct7t4EecsWSzkiZfo0DqDVWMuJpNydi1Sq15zubVWDDTXNar
 BXUQ==
X-Gm-Message-State: ANhLgQ0uIBby1Tj/TTjjil57vYXUj7xATrIgXhZnixF8N0QGeqjHD1sX
 QZkSTPKzE8HQouRHj79Cj1+rkw==
X-Google-Smtp-Source: ADFU+vtSf1Uui+5btU9rAtQco9nPOF5mxYM0Wx4y9v2x1kr27+gTscbEJ0KOjioQ+M1uvDTMH3a6og==
X-Received: by 2002:a37:47d3:: with SMTP id u202mr1372407qka.264.1583072848717; 
 Sun, 01 Mar 2020 06:27:28 -0800 (PST)
Received: from skullcanyon ([192.222.193.21])
 by smtp.gmail.com with ESMTPSA id k13sm3418451qkk.113.2020.03.01.06.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 06:27:27 -0800 (PST)
Message-ID: <93d7158b1ab49e51d14d991d5bdb2dba38ad6025.camel@ndufresne.ca>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and
 impact on services
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Discussion of the
 development of and with GStreamer <gstreamer-devel@lists.freedesktop.org>,
 Daniel Stone <daniel@fooishbar.org>,  Erik Faye-Lund
 <erik.faye-lund@collabora.com>
Date: Sun, 01 Mar 2020 09:27:26 -0500
In-Reply-To: <9b0b31b8-7610-d5c5-790a-617178cc8c1e@daenzer.net>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <59f4ea1f13a9a9d37f7801b93061b4ae7dd595e2.camel@gmail.com>
 <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
 <9b0b31b8-7610-d5c5-790a-617178cc8c1e@daenzer.net>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Mar 2020 08:19:29 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TGUgZGltYW5jaGUgMDEgbWFycyAyMDIwIMOgIDE1OjE0ICswMTAwLCBNaWNoZWwgRMOkbnplciBh
IMOpY3JpdCA6Cj4gT24gMjAyMC0wMi0yOSA4OjQ2IHAubS4sIE5pY29sYXMgRHVmcmVzbmUgd3Jv
dGU6Cj4gPiBMZSBzYW1lZGkgMjkgZsOpdnJpZXIgMjAyMCDDoCAxOToxNCArMDEwMCwgVGltdXIg
S3Jpc3TDs2YgYSDDqWNyaXQgOgo+ID4gPiAxLiBJIHRoaW5rIHdlIHNob3VsZCBjb21wbGV0ZWx5
IGRpc2FibGUgcnVubmluZyB0aGUgQ0kgb24gTVJzIHdoaWNoIGFyZQo+ID4gPiBtYXJrZWQgV0lQ
LiBTcGVha2luZyBmcm9tIHBlcnNvbmFsIGV4cGVyaWVuY2UsIEkgdXN1YWxseSBtYWtlIGEgbG90
IG9mCj4gPiA+IGNoYW5nZXMgdG8gbXkgTVJzIGJlZm9yZSB0aGV5IGFyZSBtZXJnZWQsIHNvIGl0
IGlzIGEgd2FzdGUgb2YgQ0kKPiA+ID4gcmVzb3VyY2VzLgo+IAo+IEludGVyZXN0aW5nIGlkZWEs
IGRvIHlvdSB3YW50IHRvIGNyZWF0ZSBhbiBNUiBpbXBsZW1lbnRpbmcgaXQ/Cj4gCj4gCj4gPiBJ
biB0aGUgbWVhbiB0aW1lLCB5b3UgY2FuIGhlbHAgYnkgdGFraW5nIHRoZSBoYWJpdCB0byB1c2U6
Cj4gPiAKPiA+ICAgZ2l0IHB1c2ggLW8gY2kuc2tpcAo+IAo+IFRoYXQgYnJlYWtzIE1hcmdlIEJv
dC4KPiAKPiAKPiA+IE5vdGFibHksIHdlIHdvdWxkIGxpa2UgdG8gZ2V0IHJpZCBvZiB0aGUgcG9z
dCBtZXJnZSBDSSwgYXMgaW4gYSByZWJhc2UKPiA+IGZsb3cgbGlrZSB3ZSBoYXZlIGluIEdTdHJl
YW1lciwgaXQncyBhIHJlYWxseSBtaW5vciByaXNrLgo+IAo+IFRoYXQgc2hvdWxkIGJlIHByZXR0
eSBlYXN5LCBzZWUgTWVzYSBhbmQKPiBodHRwczovL2RvY3MuZ2l0bGFiLmNvbS9jZS9jaS92YXJp
YWJsZXMvcHJlZGVmaW5lZF92YXJpYWJsZXMuaHRtbC4KPiBTb21ldGhpbmcgbGlrZSB0aGlzIHNo
b3VsZCB3b3JrOgo+IAo+ICAgcnVsZXM6Cj4gICAgIC0gaWY6ICckQ0lfUFJPSkVDVF9OQU1FU1BB
Q0UgIT0gImdzdHJlYW1lciInCj4gICAgICAgd2hlbjogbmV2ZXIKPiAKPiBUaGlzIGlzIGFub3Ro
ZXIgaW50ZXJlc3RpbmcgaWRlYSB3ZSBjb3VsZCBjb25zaWRlciBmb3IgTWVzYSBhcyB3ZWxsLiBJ
dAo+IHdvdWxkIGhvd2V2ZXIgcmVxdWlyZSAobW9zdGx5KSBiYW5uaW5nIGRpcmVjdCBwdXNoZXMg
dG8gdGhlIG1haW4gcmVwb3NpdG9yeS4KCldlIGFscmVhZHkgaGF2ZSB0aGlzIHBvbGljeSBpbiBH
U3RyZWFtZXIgZ3JvdXAuIFdlIHJlbHkgb24gbWFpbnRhaW5lcnMKdG8gbWFrZSB0aGUgcmlnaHQg
Y2FsbCB0aG91Z2gsIGFzIHdlIGhhdmUgZmV3IGNhc2VzIGluIG11bHRpLXJlcG8gdXNhZ2UKd2hl
cmUgcHVzaGluZyBtYW51YWxseSBpcyB0aGUgb25seSB3YXkgdG8gcmVkdWNlIHRoZSBicmVha2Fn
ZSB0aW1lCihlLmcuIHdoZW4gd2UgdW5kbyBhIG5ldyBBUEkgaW4gZGV2ZWxvcG1lbnQgYnJhbmNo
KS4gKFdlIGhhdmUKaW1wbGVtZW50ZWQgc3VwcG9ydCBzbyB0aGF0IENJIGlzIHJ1biBhY3Jvc3Mg
dXNlcnMgcmVwb3NpdG9yeSB3aXRoIHRoZQpzYW1lIGJyYW5jaCBuYW1lLCBzbyB0aGF0IGFsbG93
IGRvaW5nIENJIHdpdGggYWxsIHRoZSBjaGFuZ2VzLCBidXQgdGhlCm1lcmdlIHJlbWFpbnMgbm9u
LWF0b21pYy4pCgo+IAo+IAo+ID4gPiAyLiBNYXliZSB3ZSBjb3VsZCB0YWtlIHRoaXMgb25lIHN0
ZXAgZnVydGhlciBhbmQgb25seSBhbGxvdyB0aGUgQ0kgdG8KPiA+ID4gYmUgb25seSB0cmlnZ2Vy
ZWQgbWFudWFsbHkgaW5zdGVhZCBvZiBhdXRvbWF0aWNhbGx5IG9uIGV2ZXJ5IHB1c2guCj4gCj4g
VGhhdCB3b3VsZCBhZ2FpbiBicmVhayBNYXJnZSBCb3QuCgpNYXJnZSBpcyBqdXN0IGEgc29mdHdh
cmUsIHdlIGNhbiB1cGRhdGUgaXQgdG8gdHJpZ2dlciBDSSBvbiByZWJhc2VzLCBvcgppZiB0aGUg
Q0kgaGF2ZW4ndCBiZWVuIHJ1bi4gVGhlcmUgd2FzIHByb3Bvc2FsIHRvIGFjdHVhbGx5IGRvIHRo
YXQgYW5kCmxldCBtYXJnZSB0cmlnZ2VyIENJIG9uIG1lcmdlIGZyb20gbWFpbnRhaW5lcnMuIFRo
b3VnaCwgZnJvbSBteSBwb2ludAp2aWV3LCBoYXZpbmcgYSBsb25nZXIgZGVsYXkgYmV0d2VlbiBz
dWJtaXNzaW9uIGFuZCB0aGUgYXV0aG9yIGJlaW5nCmF3YXJlIG9mIENJIGJyZWFrYWdlIGhhdmUg
c29tZSBzaWRlIGVmZmVjdHMuIEF1dGhvcnMgYXJlIG9mdGVuIGxlc3MKYXZhaWxhYmxlIGEgd2Vl
ayBsYXRlciwgd2hlbiBzb21lb25lIHJldmlldyBhbmQgdHJ5IHRvIG1lcmdlLCB3aGljaAptYWtl
IG1lcmdpbmcgcGF0Y2hlcyBhIGxvdCBsb25nZXIuCgo+IAo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
