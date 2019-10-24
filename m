Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED5CA9EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 08:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32398206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 08:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32398206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA176E914;
	Fri, 25 Oct 2019 08:12:43 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB33A6E82C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 22:08:58 +0000 (UTC)
Received: by mail-pl1-x641.google.com with SMTP id j11so129675plk.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 15:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7wPBWsyoRhhryb3J0bD0S+K3mPGWRQAeLMgGyEAh8NA=;
 b=X/FeuG+OhJEt5UxEBsi8JTP4LW1nKwxTUruPcMC3Q1oM2bb+Rq+wpXlto6WA/VKZOY
 D5pno6SPO6werwiQSQVBcyrda3wlS31ZajtQWdGOKtoDRlOp9mpDo4xNJaEExuxZZzWb
 zqUekMJKZ5tLiNmrQFFgkJET1O/xMD1urdHv29fBBy/U4BDXqF6YZssItJb4Avz/30eu
 wyiwfxwiGDR2cTP78ihQompKgXa15lrZpPPS76O9Uyg+5OzNDm3ArGzI94YrJvgqL2Cu
 Hsf47HuGP2eBMxQRaDa6M6H/QLncZJuuwHBdJN2mlMJfnOV7kW5pFPdHli0IZd8aKJOQ
 3OPw==
X-Gm-Message-State: APjAAAUMi6sJ17meqj+HH+eN8H0AK3fNBtHkFZjRyjYSiBkbAu8F8XeY
 xlYuUf/k1NZ25X0FQVXRqenkeTndJTYkeSdlox49Lg==
X-Google-Smtp-Source: APXvYqzMMqI2/Ki1cf7/37Wuw+l9BTH1Xi6VyQPxUeoQt6GTWlVjj1sr7Smw/haUnuNf40UudnwnXjn6LWFu59enO2A=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr40405plp.179.1571954937563; 
 Thu, 24 Oct 2019 15:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191016230209.39663-1-ndesaulniers@google.com>
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 Oct 2019 15:08:44 -0700
Message-ID:
 <CAKwvOdkDCeNCg7N0jyjo9oQmVX6seOXjSv06DvQDCDz_7qSo=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: fix stack alignment ABI mismatch
To: Harry Wentland <harry.wentland@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, yshuiv7@gmail.com, 
 "S, Shirish" <shirish.s@amd.com>
X-Mailman-Approved-At: Fri, 25 Oct 2019 08:12:41 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=7wPBWsyoRhhryb3J0bD0S+K3mPGWRQAeLMgGyEAh8NA=;
 b=hZV5ThvEMUe1+H05W87KipW9wh8W8qyemLiokSK/yWiGkKnR/ch3kMUXgljY2w7zvW
 /Ipbf87Yb3kijE0T/t66H8q1lyMED+KuoZVVkIu8AfIue0j3r1w3INIvCHuyClmQZ5qJ
 L5yoYY48V7XqsWggkovSZkM4/DzpOMEyr2Q4PTDLkvIsHvpRpGGzYvQnho9QSFySXs95
 VYbtizX1cePFwi4McJi5HaVzUpTEt/ComD7KFvZXiO8HRrPPaZAB855XykN4NaXJiAcv
 r9Ev5jxZak+jKKW4lYvE0WZA/72DJ5Fmz3n3K3BXGaCsXeW4xlijy41BM1lXyl3ttbJD
 Kimw==
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 Arnd Bergmann <arnd@arndb.de>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Matthias Kaehlcke <mka@google.com>, "Koenig,
 Christian" <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024220844.yzP2k3T7ntx_dvhwWa-ltO2a9P3DQeVGMbajletSwvo@z>

T24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgNDowMiBQTSBOaWNrIERlc2F1bG5pZXJzCjxuZGVzYXVs
bmllcnNAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4KPiBUaGUgeDg2IGtlcm5lbCBpcyBjb21waWxlZCB3
aXRoIGFuIDhCIHN0YWNrIGFsaWdubWVudCB2aWEKPiBgLW1wcmVmZXJyZWQtc3RhY2stYm91bmRh
cnk9M2AgZm9yIEdDQyBzaW5jZSAzLjYtcmMxIHZpYQo+IGNvbW1pdCBkOWIwY2RlOTFjNjAgKCJ4
ODYtNjQsIGdjYzogVXNlIC1tcHJlZmVycmVkLXN0YWNrLWJvdW5kYXJ5PTMgaWYgc3VwcG9ydGVk
IikKPiBvciBgLW1zdGFjay1hbGlnbm1lbnQ9OGAgZm9yIENsYW5nLiBQYXJ0cyBvZiB0aGUgQU1E
R1BVIGRyaXZlciBhcmUKPiBjb21waWxlZCB3aXRoIDE2QiBzdGFjayBhbGlnbm1lbnQuCj4KPiBH
ZW5lcmFsbHksIHRoZSBzdGFjayBhbGlnbm1lbnQgaXMgcGFydCBvZiB0aGUgQUJJLiBMaW5raW5n
IHRvZ2V0aGVyIHR3bwo+IGRpZmZlcmVudCB0cmFuc2xhdGlvbiB1bml0cyB3aXRoIGRpZmZlcmlu
ZyBzdGFjayBhbGlnbm1lbnQgaXMgZGFuZ2Vyb3VzLAo+IHBhcnRpY3VsYXJseSB3aGVuIHRoZSB0
cmFuc2xhdGlvbiB1bml0IHdpdGggdGhlIHNtYWxsZXIgc3RhY2sgYWxpZ25tZW50Cj4gbWFrZXMg
Y2FsbHMgaW50byB0aGUgdHJhbnNsYXRpb24gdW5pdCB3aXRoIHRoZSBsYXJnZXIgc3RhY2sgYWxp
Z25tZW50Lgo+IFdoaWxlIDhCIGFsaWduZWQgc3RhY2tzIGFyZSBzb21ldGltZXMgYWxzbyAxNkIg
YWxpZ25lZCwgdGhleSBhcmUgbm90Cj4gYWx3YXlzLgo+Cj4gTXVsdGlwbGUgdXNlcnMgaGF2ZSBy
ZXBvcnRlZCBHZW5lcmFsIFByb3RlY3Rpb24gRmF1bHRzIChHUEYpIHdoZW4gdXNpbmcKPiB0aGUg
QU1ER1BVIGRyaXZlciBjb21waWxlZCB3aXRoIENsYW5nLiBDbGFuZyBpcyBwbGFjaW5nIG9iamVj
dHMgaW4gc3RhY2sKPiBzbG90cyBhc3N1bWluZyB0aGUgc3RhY2sgaXMgMTZCIGFsaWduZWQsIGFu
ZCBzZWxlY3RpbmcgaW5zdHJ1Y3Rpb25zIHRoYXQKPiByZXF1aXJlIDE2QiBhbGlnbmVkIG1lbW9y
eSBvcGVyYW5kcy4KPgo+IEF0IHJ1bnRpbWUsIHN5c2NhbGwgaGFuZGxlcnMgd2l0aCA4QiBhbGln
bmVkIHN0YWNrIGNhbGwgaW50byBjb2RlIHRoYXQKPiBhc3N1bWVzIDE2QiBzdGFjayBhbGlnbm1l
bnQuICBXaGVuIHRoZSBzdGFjayBpcyBhIG11bHRpcGxlIG9mIDhCIGJ1dCBub3QKPiAxNkIsIHRo
ZXNlIGluc3RydWN0aW9ucyByZXN1bHQgaW4gYSBHUEYuCj4KPiBSZW1vdmUgdGhlIGNvZGUgdGhh
dCBhZGRlZCBjb21wYXRpYmlsaXR5IGJldHdlZW4gdGhlIGRpZmZlcmluZyBjb21waWxlcgo+IGZs
YWdzLCBhcyBpdCB3aWxsIHJlc3VsdCBpbiBydW50aW1lIEdQRnMgd2hlbiBidWlsdCB3aXRoIENs
YW5nLgo+Cj4gVGhlIHNlcmllcyBpcyBicm9rZW4gaW50byAzIHBhdGNoZXMsIHRoZSBmaXJzdCBp
cyBhbiBpbXBvcnRhbnQgZml4IGZvcgo+IENsYW5nIGZvciBDaHJvbWVPUy4gVGhlIHJlc3QgYXJl
IGF0dGVtcHRlZCBjbGVhbnVwcyBmb3IgR0NDLCBidXQgcmVxdWlyZQo+IGFkZGl0aW9uYWwgYm9v
dCB0ZXN0aW5nLiBUaGUgZmlyc3QgcGF0Y2ggaXMgY3JpdGljYWwsIHRoZSByZXN0IGFyZSBuaWNl
Cj4gdG8gaGF2ZS4gSSd2ZSBjb21waWxlIHRlc3RlZCB0aGUgc2VyaWVzIHdpdGggVG9UIENsYW5n
LCBHQ0MgNC45LCBhbmQgR0NDCj4gOC4zICoqYnV0KiogSSBkbyBub3QgaGF2ZSBoYXJkd2FyZSB0
byB0ZXN0IG9uLCBzbyBJIG5lZWQgZm9sa3Mgd2l0aCB0aGUKPiBhYm92ZSBjb21waWxlcnMgYW5k
IHJlbGV2YW50IGhhcmR3YXJlIHRvIGhlbHAgdGVzdCB0aGUgc2VyaWVzLgo+Cj4gVGhlIGZpcnN0
IHBhdGNoIGlzIGEgZnVuY3Rpb25hbCBjaGFuZ2UgZm9yIENsYW5nIG9ubHkuIEl0IGRvZXMgbm90
Cj4gY2hhbmdlIGFueXRoaW5nIGZvciBhbnkgdmVyc2lvbiBvZiBHQ0MuIFl1eHVhbiBib290IHRl
c3RlZCBhIHByZXZpb3VzCj4gaW5jYXJuYXRpb24gb24gaGFyZHdhcmUsIGJ1dCBJJ3ZlIGNoYW5n
ZWQgaXQgZW5vdWdoIHRoYXQgSSB0aGluayBpdCBtYWRlCj4gc2Vuc2UgdG8gZHJvcCB0aGUgcHJl
dmlvdXMgdGVzdGVkIGJ5IHRhZy4KClRoYW5rcyBmb3IgdGVzdGluZyB0aGUgZmlyc3QgcGF0Y2gg
U2hpcmlzaC4gQXJlIHlvdSBvciBZdXh1YW4gYWJsZSB0bwp0ZXN0IHRoZSByZXN0IG9mIHRoZSBz
ZXJpZXMgd2l0aCBhbnkgY29tYmluYXRpb24gb2Yge2NsYW5nfGdjYyA8IDcuMXwKZ2NjID49IDcu
MX0gb24gaGFyZHdhcmUgYW5kIHJlcG9ydCB5b3VyIGZpbmRpbmdzPwoKPgo+IFRoZSBzZWNvbmQg
cGF0Y2ggaXMgYSBmdW5jdGlvbmFsIGNoYW5nZSBmb3IgR0NDIDcuMSsgb25seS4gSXQgZG9lcyBu
b3QKPiBhZmZlY3Qgb2xkZXIgdmVyc2lvbnMgb2YgR0NDIG9yIENsYW5nICh0aG91Z2ggaWYgc29t
ZW9uZSB3YW50ZWQgdG8KPiBkb3VibGUgY2hlY2sgd2l0aCBwcmUtR0NDIDcuMSBpdCB3b3VsZG4n
dCBodXJ0KS4gIEl0IHNob3VsZCBiZSBib290Cj4gdGVzdGVkIG9uIEdDQyA3LjErIG9uIHRoZSBy
ZWxldmFudCBoYXJkd2FyZS4KPgo+IFRoZSBmaW5hbCBwYXRjaCBpcyBhbHNvIGEgZnVuY3Rpb25h
bCBjaGFuZ2UgZm9yIEdDQyA3LjErIG9ubHkuIEl0IGRvZXMKPiBub3QgYWZmZWN0IG9sZGVyIHZl
cnNpb25zIG9mIEdDQyBvciBDbGFuZy4gSXQgc2hvdWxkIGJlIGJvb3QgdGVzdGVkIG9uCj4gR0ND
IDcuMSsgb24gdGhlIHJlbGV2YW50IGhhcmR3YXJlLiBUaGVvcmV0aWNhbGx5LCB0aGVyZSBtYXkg
YmUgYW4gaXNzdWUKPiB3aXRoIGl0LCBhbmQgaXQncyBvayB0byBkcm9wIGl0LiBUaGUgc2VyaWVz
IHdhcyBpbnRlbnRpb25hbCBicm9rZW4gaW50bwo+IDMgaW4gb3JkZXIgdG8gYWxsb3cgdGhlbSB0
byBiZSBpbmNyZW1lbnRhbGx5IHRlc3RlZCBhbmQgYWNjZXB0ZWQuIEl0J3MKPiBvayB0byB0YWtl
IGVhcmxpZXIgcGF0Y2hlcyB3aXRob3V0IHRoZSBsYXRlciBwYXRjaGVzLgo+Cj4gQW5kIGZpbmFs
bHksIEkgZG8gbm90IGNvbmRvbmUgbGlua2luZyBvYmplY3QgZmlsZXMgb2YgZGlmZmVyaW5nIHN0
YWNrCj4gYWxpZ25tZW50cy4gIElkZWFsaXN0aWNhbGx5LCB3ZSdkIG1hcmsgdGhlIGRyaXZlciBi
cm9rZW4gZm9yIHByZS1HQ0MKPiA3LjEuICBQcmFnbWF0aWNhbGx5LCAiaWYgaXQgYWluJ3QgYnJv
a2UsIGRvbid0IGZpeCBpdC4iCgpIYXJyeSwgQWxleCwKVGhvdWdodHMgb24gdGhlIHNlcmllcz8g
SGFzIEFNRCBiZWVuIGFibGUgdG8gc3RyZXNzIHRlc3QgdGhlc2UgbW9yZSBpbnRlcm5hbGx5PwoK
Pgo+IE5pY2sgRGVzYXVsbmllcnMgKDMpOgo+ICAgZHJtL2FtZGdwdTogZml4IHN0YWNrIGFsaWdu
bWVudCBBQkkgbWlzbWF0Y2ggZm9yIENsYW5nCj4gICBkcm0vYW1kZ3B1OiBmaXggc3RhY2sgYWxp
Z25tZW50IEFCSSBtaXNtYXRjaCBmb3IgR0NDIDcuMSsKPiAgIGRybS9hbWRncHU6IGVuYWJsZSAt
bXNzZTIgZm9yIEdDQyA3LjErIHVzZXJzCj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NhbGNzL01ha2VmaWxlIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvTWFrZWZpbGUgfCAxOSArKysrKysrKysrKystLS0t
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9NYWtlZmlsZSB8IDE5
ICsrKysrKysrKysrKy0tLS0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rt
bC9NYWtlZmlsZSAgIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZHNjL01ha2VmaWxlICAgfCAxOSArKysrKysrKysrKystLS0tLS0tCj4g
IDUgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pCj4KPiAt
LQo+IDIuMjMuMC43MDAuZzU2Y2Y3NjdiZGItZ29vZwo+CgoKLS0gClRoYW5rcywKfk5pY2sgRGVz
YXVsbmllcnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
