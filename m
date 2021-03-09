Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E59C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6812764D90
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6812764D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42DB6E429;
	Tue,  9 Mar 2021 15:09:02 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D62F6E8BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 09:16:36 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id d3so4301249uap.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 01:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DxSUjQGZz4/YjWnn3wACv5aSRYiuKXpXdqRpRz0A8i4=;
 b=DufLGann5aY/1DUksAmWLOH7D5Ct4/Bar+WO9rU/Fg5fI6vfGArDTICJyCODgjzZcv
 ekh6DvjxN/EAiVO8GNTtGrlqwzVkza9GD00LT7xxJaDZEC4x0bRJtjiJDD8S8YWVV9YY
 xfFiGfrAj3byFtWfIBNxztBTW9Dub07XZPW48hdqwMFfV24olvquTDH5L4mCrfCvSEFu
 ky2t7PZGjXnc4RMYzWM06HgLwQ9Ov9n0mGm4rqr48myvVZsjaldjVaNzp3liIfcqsohN
 f+T4PqPyGinioZdN1Jj+kdm03ETE0KK8WykemZCD1PSrMRYFBuOACQPGa6HIrsnJxjx3
 uxGw==
X-Gm-Message-State: AOAM530G5KQOBdIB3kZEOs7O1XM5wP3tqFpDJrzyr/bO3aMK4kPhWPmo
 8a9q8oH8y3ubuw2ZtJab2yd5fAyMWDd9Crrr7hw=
X-Google-Smtp-Source: ABdhPJww7xH7Oe5Pjr4n5IpImR4mF9lUTXCXGNF+o1r811zxaElWbHX29Xxb/k0BiTXqUy738t90tdAg9Vt/0gLMISg=
X-Received: by 2002:a9f:35a1:: with SMTP id t30mr14845428uad.106.1615281395334; 
 Tue, 09 Mar 2021 01:16:35 -0800 (PST)
MIME-Version: 1.0
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
 <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
In-Reply-To: <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Mar 2021 10:16:24 +0100
Message-ID: <CAMuHMdXM0qg23UN6VBqbb0Vm2bg3tRSM=OCD5r7U2K1brpnJAg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix missing declaration of
 [en/dis]able_kernel_vsx()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Mailman-Approved-At: Tue, 09 Mar 2021 15:09:02 +0000
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexdeucher@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0b3BoZSwKCk9uIFR1ZSwgTWFyIDksIDIwMjEgYXQgOTo1MiBBTSBDaHJpc3RvcGhl
IExlcm95CjxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOgo+IExlIDA5LzAzLzIw
MjEgw6AgMDk6NDUsIEdlZXJ0IFV5dHRlcmhvZXZlbiBhIMOpY3JpdCA6Cj4gPiBPbiBUdWUsIE1h
ciA5LCAyMDIxIGF0IDk6MzkgQU0gQ2hyaXN0b3BoZSBMZXJveQo+ID4gPGNocmlzdG9waGUubGVy
b3lAY3Nncm91cC5ldT4gd3JvdGU6Cj4gPj4gQWRkIHN0dWIgaW5zdGFuY2VzIG9mIGVuYWJsZV9r
ZXJuZWxfdnN4KCkgYW5kIGRpc2FibGVfa2VybmVsX3ZzeCgpCj4gPj4gd2hlbiBDT05GSUdfVlNY
IGlzIG5vdCBzZXQsIHRvIGF2b2lkIGZvbGxvd2luZyBidWlsZCBmYWlsdXJlLgo+ID4+Cj4gPj4g
ICAgQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNz
L2Rjbl9jYWxjcy5vCj4gPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBlcy5oOjI5LAo+ID4+ICAg
ICAgICAgICAgICAgICAgIGZyb20gLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RtX3NlcnZpY2VzLmg6MzcsCj4gPj4gICAgICAgICAgICAgICAgICAgZnJvbSBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jOjI3
Ogo+ID4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNu
X2NhbGNzLmM6IEluIGZ1bmN0aW9uICdkY25fYndfYXBwbHlfcmVnaXN0cnlfb3ZlcnJpZGUnOgo+
ID4+IC4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9vc190eXBlcy5o
OjY0OjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnZW5hYmxlX2tl
cm5lbF92c3gnOyBkaWQgeW91IG1lYW4gJ2VuYWJsZV9rZXJuZWxfZnAnPyBbLVdlcnJvcj1pbXBs
aWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiA+PiAgICAgNjQgfCAgIGVuYWJsZV9rZXJuZWxf
dnN4KCk7IFwKPiA+PiAgICAgICAgfCAgIF5+fn5+fn5+fn5+fn5+fn5+Cj4gPj4gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYzo2NDA6Mjog
bm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdEQ19GUF9TVEFSVCcKPiA+PiAgICA2NDAgfCAg
RENfRlBfU1RBUlQoKTsKPiA+PiAgICAgICAgfCAgXn5+fn5+fn5+fn4KPiA+PiAuL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaDo3NTozOiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Rpc2FibGVfa2VybmVsX3ZzeCc7IGRp
ZCB5b3UgbWVhbiAnZGlzYWJsZV9rZXJuZWxfZnAnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlv
bi1kZWNsYXJhdGlvbl0KPiA+PiAgICAgNzUgfCAgIGRpc2FibGVfa2VybmVsX3ZzeCgpOyBcCj4g
Pj4gICAgICAgIHwgICBefn5+fn5+fn5+fn5+fn5+fn4KPiA+PiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jOjY3NjoyOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8gJ0RDX0ZQX0VORCcKPiA+PiAgICA2NzYgfCAgRENfRlBfRU5EKCk7
Cj4gPj4gICAgICAgIHwgIF5+fn5+fn5+fgo+ID4+IGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwo+ID4+IG1ha2VbNV06ICoqKiBbZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3Mub10gRXJyb3IgMQo+ID4+Cj4gPj4g
Rml4ZXM6IDE2YTlkZWExMTBhNiAoImFtZGdwdTogRW5hYmxlIGluaXRpYWwgRENOIHN1cHBvcnQg
b24gUE9XRVIiKQo+ID4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gPj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pgo+ID4K
PiA+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCEKPiA+Cj4gPj4gLS0tIGEvYXJjaC9wb3dlcnBjL2lu
Y2x1ZGUvYXNtL3N3aXRjaF90by5oCj4gPj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNt
L3N3aXRjaF90by5oCj4gPj4gQEAgLTcxLDYgKzcxLDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBk
aXNhYmxlX2tlcm5lbF92c3godm9pZCkKPiA+PiAgIHsKPiA+PiAgICAgICAgICBtc3JfY2hlY2tf
YW5kX2NsZWFyKE1TUl9GUHxNU1JfVkVDfE1TUl9WU1gpOwo+ID4+ICAgfQo+ID4+ICsjZWxzZQo+
ID4+ICtzdGF0aWMgaW5saW5lIHZvaWQgZW5hYmxlX2tlcm5lbF92c3godm9pZCkKPiA+PiArewo+
ID4+ICsgICAgICAgQlVJTERfQlVHKCk7Cj4gPj4gK30KPiA+PiArCj4gPj4gK3N0YXRpYyBpbmxp
bmUgdm9pZCBkaXNhYmxlX2tlcm5lbF92c3godm9pZCkKPiA+PiArewo+ID4+ICsgICAgICAgQlVJ
TERfQlVHKCk7Cj4gPj4gK30KPiA+PiAgICNlbmRpZgo+ID4KPiA+IEknbSB3b25kZXJpbmcgaG93
IHRoaXMgaXMgYW55IGJldHRlciB0aGFuIHRoZSBjdXJyZW50IHNpdHVhdGlvbjogdXNpbmcKPiA+
IEJVSUxEX0JVRygpIHdpbGwgc3RpbGwgY2F1c2UgYSBidWlsZCBmYWlsdXJlPwo+Cj4gTm8gaXQg
d29uJ3QgY2F1c2UgYSBmYWlsdXJlLiBJbiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
b3NfdHlwZXMuaCB5b3UgaGF2ZToKPgo+ICNkZWZpbmUgRENfRlBfU1RBUlQoKSB7IFwKPiAgICAg
ICAgIGlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9WU1hfQ09NUCkpIHsgXAo+ICAgICAgICAg
ICAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsgXAo+ICAgICAgICAgICAgICAgICBlbmFibGVfa2Vy
bmVsX3ZzeCgpOyBcCj4gICAgICAgICB9IGVsc2UgaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRS
X0FMVElWRUNfQ09NUCkpIHsgXAo+ICAgICAgICAgICAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsg
XAo+ICAgICAgICAgICAgICAgICBlbmFibGVfa2VybmVsX2FsdGl2ZWMoKTsgXAo+ICAgICAgICAg
fSBlbHNlIGlmICghY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfRlBVX1VOQVZBSUxBQkxFKSkgeyBc
Cj4gICAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgpOyBcCj4gICAgICAgICAgICAgICAg
IGVuYWJsZV9rZXJuZWxfZnAoKTsgXAo+ICAgICAgICAgfSBcCj4KPiBXaGVuIENPTkZJR19WU1gg
aXMgbm90IHNlbGVjdGVkLCBjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9WU1hfQ09NUCkgY29uc3Rh
bnQgZm9sZHMgdG8gJ2ZhbHNlJyBzbyB0aGUKPiBjYWxsIHRvIGVuYWJsZV9rZXJuZWxfdnN4KCkg
aXMgZGlzY2FyZGVkIGFuZCB0aGUgYnVpbGQgc3VjY2VlZHMuCgpJQy4gU28geW91IG1pZ2h0IGFz
IHdlbGwgaGF2ZSBhbiBlbXB0eSAoZHVtbXkpIGZ1bmN0aW9uIGluc3RlYWQ/CgpHcntvZXRqZSxl
ZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVy
aG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51
eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9w
bGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJu
YWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
