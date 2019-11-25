Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC91C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4DE20740
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4DE20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33EE689F2E;
	Mon, 25 Nov 2019 14:36:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292FE89F2E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 14:36:27 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id n5so6109580wmc.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 06:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y2YRMqMT0bvcDWJ8AKR5/r5VkAGX/dM1AITjtSwP4Ys=;
 b=LANU9CBodKaXVUZprqQjMsDQAxwylqPovNcZkAQ6Bo5GRQH833igrcuTArI0+gDfvC
 THAJDq9p0WHe7XuHgpey6Om3TeH+kXa6hmbbETEfD/FIuDWl/juN66q0znGJXYGPZZ/I
 joHBqteMDfDjk1KVJITT8ua174rVZy8CH1p6khdsXWbyFxh1V0t+hgEYYkvSmSRg70Vt
 EE8ebREuy8oqEommthcFcewgudXyAqsanPMb6v86dimXXs7gffGBdNY87lnGOwD+g6Jn
 Kz403UlF7DKt8vfc1BuCWqkwZcqca4JmZns91rIbbpXpniWXgckYzrpto2lETmrG3WDE
 KOgw==
X-Gm-Message-State: APjAAAXVScg2oo4X2y2u7GJvZtE+yBiXmJCGTxvDr+Eqx5Okz+yb7XEK
 IUsxjo85VapfeiiNFdnHhoEwRRoo9rK+tElhZJ8=
X-Google-Smtp-Source: APXvYqyQD9g/D/RKv2QuQQh+1KuhTaot/Ycolo8uqR4YRAxkIgwRfmg5cwf93AVKo3RMfoLsMYgfaJ0kvmtFmKUzf+4=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr30306902wmi.67.1574692585663; 
 Mon, 25 Nov 2019 06:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20191115160119.658620-1-alexander.deucher@amd.com>
 <CADnq5_P5m-eWDy5Xb5qs2HpcZbh3FxLTAxhxsXRZGDbkYrTZnA@mail.gmail.com>
 <CAD=4a=UAKO9Y+6fwy8QTBsemUuGe6yhwB8eVgkGHZzYWa_nDpQ@mail.gmail.com>
In-Reply-To: <CAD=4a=UAKO9Y+6fwy8QTBsemUuGe6yhwB8eVgkGHZzYWa_nDpQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Nov 2019 09:36:13 -0500
Message-ID:
 <CADnq5_NMWQo_rFT4_szEccq17-8FGBW+bHtGZoZmPsTttOzbYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: re-enable wait in pipelock,
 but add timeout
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y2YRMqMT0bvcDWJ8AKR5/r5VkAGX/dM1AITjtSwP4Ys=;
 b=NdJI+q6xv7Y6jh55dOqYQyoZvlmXaIfa9daEBRShAqdVZsjYbvZuGjvgGZ4lZDUwKd
 RD3ElKmowLWI/5I9mczM63bKE0k9zRJjE9WPpuBK5GkLqsEWBxPpXGDTeHmey4Cw5SQH
 b6iHnF+FTdeggYFWTQ1UzEFYyQjoywSOkKThQuzOxzm1laArBxi4/tfUy3YEEd8QYNfT
 PvWNV/xdtYkWepBwiIuvUQ9Ccy90234igyo09jM06cDAY4J0DaiR6c4j+3uZcHwH4EaZ
 e0oYaNIW2hQ6cseSBjMehRdH95ZN4eeMVdJsh39EkY5H2Ivp47KQh3NpQugl8bTOApOh
 ED/A==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125143613.CLIlOhIILLomzvfZxTlvgX_0yzSQziRTDWnZPm7OTrM@z>

T24gU3VuLCBOb3YgMjQsIDIwMTkgYXQgOTo1NiBQTSBFcm5zdCBTasO2c3RyYW5kIDxlcm5zdHBA
Z21haWwuY29tPiB3cm90ZToKPgo+IFRoZSBzYW1lIGJ1ZyBpcyBsaXN0ZWQgdHdpY2UuIERpZCB5
b3UgbWVhbiBhIHRoaXJkIGJ1Zz8KCk5vIGp1c3QgYSB0eXBvLiAgQWxyZWFkeSBmaXhlZCB1cCBs
b2NhbGx5LgoKQWxleAoKPgo+Cj4gRGVuIHRvcnMgMjEgbm92LiAyMDE5IGtsIDAwOjI1IHNrcmV2
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjoKPiA+Cj4gPiBQaW5nPwo+ID4K
PiA+IE9uIEZyaSwgTm92IDE1LCAyMDE5IGF0IDExOjAxIEFNIEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gUmVtb3ZpbmcgdGhpcyBjYXVzZXMg
aGFuZ3MgaW4gc29tZSBnYW1lcywgc28gcmUtYWRkIGl0LCBidXQgYWRkCj4gPiA+IGEgdGltZW91
dCBzbyB3ZSBkb24ndCBoYW5nIHdoaWxlIHN3aXRjaGluZyBmbGlwIHR5cGVzLgo+ID4gPgo+ID4g
PiBCdWc6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA1MTY5
Cj4gPiA+IEJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
MTEyMjY2Cj4gPiA+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0yMDUxNjkKPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+ID4gPiAtLS0KPiA+ID4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMjAvZGNuMjBfaHdzZXEuYyAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCj4gPiA+IGluZGV4
IDAwNDZhMDk5YzllOS4uMTIwZTYyYzUxOTNjIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+ID4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+ID4gPiBAQCAt
MTAzMyw2ICsxMDMzLDI1IEBAIHZvaWQgZGNuMjBfcGlwZV9jb250cm9sX2xvY2soCj4gPiA+ICAg
ICAgICAgaWYgKHBpcGUtPnBsYW5lX3N0YXRlICE9IE5VTEwpCj4gPiA+ICAgICAgICAgICAgICAg
ICBmbGlwX2ltbWVkaWF0ZSA9IHBpcGUtPnBsYW5lX3N0YXRlLT5mbGlwX2ltbWVkaWF0ZTsKPiA+
ID4KPiA+ID4gKyAgICAgICBpZiAoZmxpcF9pbW1lZGlhdGUgJiYgbG9jaykgewo+ID4gPiArICAg
ICAgICAgICAgICAgY29uc3QgaW50IFRJTUVPVVRfRk9SX0ZMSVBfUEVORElORyA9IDEwMDAwMDsK
PiA+ID4gKyAgICAgICAgICAgICAgIGludCBpOwo+ID4gPiArCj4gPiA+ICsgICAgICAgICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgVElNRU9VVF9GT1JfRkxJUF9QRU5ESU5HOyArK2kpIHsKPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFwaXBlLT5wbGFuZV9yZXMuaHVicC0+ZnVuY3Mt
Pmh1YnBfaXNfZmxpcF9wZW5kaW5nKHBpcGUtPnBsYW5lX3Jlcy5odWJwKSkKPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgdWRlbGF5KDEpOwo+ID4gPiArICAgICAgICAgICAgICAgfQo+ID4gPiArCj4gPiA+ICsg
ICAgICAgICAgICAgICBpZiAocGlwZS0+Ym90dG9tX3BpcGUgIT0gTlVMTCkgewo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgVElNRU9VVF9GT1JfRkxJUF9QRU5E
SU5HOyArK2kpIHsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXBp
cGUtPmJvdHRvbV9waXBlLT5wbGFuZV9yZXMuaHVicC0+ZnVuY3MtPmh1YnBfaXNfZmxpcF9wZW5k
aW5nKHBpcGUtPmJvdHRvbV9waXBlLT5wbGFuZV9yZXMuaHVicCkpCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1ZGVsYXkoMSk7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IH0KPiA+ID4gKyAgICAgICAgICAgICAgIH0KPiA+ID4gKyAgICAgICB9Cj4gPiA+ICsKPiA+ID4g
ICAgICAgICAvKiBJbiBmbGlwIGltbWVkaWF0ZSBhbmQgcGlwZSBzcGxpdHRpbmcgY2FzZSwgd2Ug
bmVlZCB0byB1c2UgR1NMCj4gPiA+ICAgICAgICAgICogZm9yIHN5bmNocm9uaXphdGlvbi4gT25s
eSBkbyBzZXR1cCBvbiBsb2NraW5nIGFuZCBvbiBmbGlwIHR5cGUgY2hhbmdlLgo+ID4gPiAgICAg
ICAgICAqLwo+ID4gPiAtLQo+ID4gPiAyLjIzLjAKPiA+ID4KPiA+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
