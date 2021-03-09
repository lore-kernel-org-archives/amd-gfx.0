Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B622C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8526564D90
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8526564D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEEDD6E902;
	Tue,  9 Mar 2021 15:09:06 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217FC6E32F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 10:55:16 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id m25so2878454vkk.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 02:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oX7AxwHbI6o3a5Bi4c9f3W+YD88gdE1RWPCa5CVMxh4=;
 b=iMUioR0H6NbVT4ZYLl2v72rdt9efdzHaf0BXGAWsq+MImJq5445eoKxD41+KG7eOQ5
 smQHvvxJo9f97lVDN9tkIfk5etvZx6pcHWwI6m/Pqpv6THNX0g0lWwnE9pR5gwyD+4vH
 N5t/G+MTlj7hUIBa9NGuM0lnmkHkO3AioWZ+JZI2QDgWcEIL4XKyKsusnJvsyAdvhQ1J
 oL/xPuRcOCyodWtKScZBlmjJGa3Ye3BRylqpPmr7QfiUZK9GI2dezGYEbMQDzfHR/yad
 K1kjD9+E8iUNNsOaNIoaTCgwnlA93CMkW3p19zqhRIv5eSHON7yksQHbzCjV4YXx5zie
 kQmA==
X-Gm-Message-State: AOAM531b8kEVPl/w6RN+31FxrN9ETKc/WuLnRNO8PhAuOhYJffxek5TX
 +khV8sRK3IBE44RuS4So2WxOodooG01F7T6GMxM=
X-Google-Smtp-Source: ABdhPJwveE/U9SAwH7PSfNB+ROkadaF3IBN/Y7JnqtqYAHB2l2g3/7Wr7l7W359+lNpN6E+AIE0VV7DgzraTAMlMtWs=
X-Received: by 2002:a1f:1a51:: with SMTP id a78mr15741334vka.2.1615287315138; 
 Tue, 09 Mar 2021 02:55:15 -0800 (PST)
MIME-Version: 1.0
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
 <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
 <CAMuHMdXM0qg23UN6VBqbb0Vm2bg3tRSM=OCD5r7U2K1brpnJAg@mail.gmail.com>
 <b64111a3-df3f-bf59-20ce-0af57715ad53@csgroup.eu>
In-Reply-To: <b64111a3-df3f-bf59-20ce-0af57715ad53@csgroup.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Mar 2021 11:55:03 +0100
Message-ID: <CAMuHMdUQcE7+O9NWH4Xxxv+r7ZFnTGqtHuteOMiSPY_gK5xkZw@mail.gmail.com>
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

SGkgQ2hyaXN0b3BoZSwKCk9uIFR1ZSwgTWFyIDksIDIwMjEgYXQgMTA6NTggQU0gQ2hyaXN0b3Bo
ZSBMZXJveQo8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToKPiBMZSAwOS8wMy8y
MDIxIMOgIDEwOjE2LCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDDqWNyaXQgOgo+ID4gT24gVHVlLCBN
YXIgOSwgMjAyMSBhdCA5OjUyIEFNIENocmlzdG9waGUgTGVyb3kKPiA+IDxjaHJpc3RvcGhlLmxl
cm95QGNzZ3JvdXAuZXU+IHdyb3RlOgo+ID4+IExlIDA5LzAzLzIwMjEgw6AgMDk6NDUsIEdlZXJ0
IFV5dHRlcmhvZXZlbiBhIMOpY3JpdCA6Cj4gPj4+IE9uIFR1ZSwgTWFyIDksIDIwMjEgYXQgOToz
OSBBTSBDaHJpc3RvcGhlIExlcm95Cj4gPj4+IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+
IHdyb3RlOgo+ID4+Pj4gQWRkIHN0dWIgaW5zdGFuY2VzIG9mIGVuYWJsZV9rZXJuZWxfdnN4KCkg
YW5kIGRpc2FibGVfa2VybmVsX3ZzeCgpCj4gPj4+PiB3aGVuIENPTkZJR19WU1ggaXMgbm90IHNl
dCwgdG8gYXZvaWQgZm9sbG93aW5nIGJ1aWxkIGZhaWx1cmUuCj4gPj4+Pgo+ID4+Pj4gICAgIEND
IFtNXSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25f
Y2FsY3Mubwo+ID4+Pj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBlcy5oOjI5LAo+ID4+Pj4gICAg
ICAgICAgICAgICAgICAgIGZyb20gLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RtX3NlcnZpY2VzLmg6MzcsCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgZnJvbSBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5j
OjI3Ogo+ID4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxj
cy9kY25fY2FsY3MuYzogSW4gZnVuY3Rpb24gJ2Rjbl9id19hcHBseV9yZWdpc3RyeV9vdmVycmlk
ZSc6Cj4gPj4+PiAuL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvb3Nf
dHlwZXMuaDo2NDozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Vu
YWJsZV9rZXJuZWxfdnN4JzsgZGlkIHlvdSBtZWFuICdlbmFibGVfa2VybmVsX2ZwJz8gWy1XZXJy
b3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gPj4+PiAgICAgIDY0IHwgICBlbmFi
bGVfa2VybmVsX3ZzeCgpOyBcCj4gPj4+PiAgICAgICAgIHwgICBefn5+fn5+fn5+fn5+fn5+fgo+
ID4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25f
Y2FsY3MuYzo2NDA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdEQ19GUF9TVEFSVCcK
PiA+Pj4+ICAgICA2NDAgfCAgRENfRlBfU1RBUlQoKTsKPiA+Pj4+ICAgICAgICAgfCAgXn5+fn5+
fn5+fn4KPiA+Pj4+IC4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9v
c190eXBlcy5oOjc1OjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAn
ZGlzYWJsZV9rZXJuZWxfdnN4JzsgZGlkIHlvdSBtZWFuICdkaXNhYmxlX2tlcm5lbF9mcCc/IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ID4+Pj4gICAgICA3NSB8ICAg
ZGlzYWJsZV9rZXJuZWxfdnN4KCk7IFwKPiA+Pj4+ICAgICAgICAgfCAgIF5+fn5+fn5+fn5+fn5+
fn5+fgo+ID4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxj
cy9kY25fY2FsY3MuYzo2NzY6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdEQ19GUF9F
TkQnCj4gPj4+PiAgICAgNjc2IHwgIERDX0ZQX0VORCgpOwo+ID4+Pj4gICAgICAgICB8ICBefn5+
fn5+fn4KPiA+Pj4+IGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwo+
ID4+Pj4gbWFrZVs1XTogKioqIFtkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2NhbGNzL2Rjbl9jYWxjcy5vXSBFcnJvciAxCj4gPj4+Pgo+ID4+Pj4gRml4ZXM6IDE2YTlk
ZWExMTBhNiAoImFtZGdwdTogRW5hYmxlIGluaXRpYWwgRENOIHN1cHBvcnQgb24gUE9XRVIiKQo+
ID4+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4KPiA+Pj4KPiA+Pj4g
VGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+ID4+Pgo+ID4+Pj4gLS0tIGEvYXJjaC9wb3dlcnBjL2lu
Y2x1ZGUvYXNtL3N3aXRjaF90by5oCj4gPj4+PiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9h
c20vc3dpdGNoX3RvLmgKPiA+Pj4+IEBAIC03MSw2ICs3MSwxNiBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZGlzYWJsZV9rZXJuZWxfdnN4KHZvaWQpCj4gPj4+PiAgICB7Cj4gPj4+PiAgICAgICAgICAg
bXNyX2NoZWNrX2FuZF9jbGVhcihNU1JfRlB8TVNSX1ZFQ3xNU1JfVlNYKTsKPiA+Pj4+ICAgIH0K
PiA+Pj4+ICsjZWxzZQo+ID4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBlbmFibGVfa2VybmVsX3Zz
eCh2b2lkKQo+ID4+Pj4gK3sKPiA+Pj4+ICsgICAgICAgQlVJTERfQlVHKCk7Cj4gPj4+PiArfQo+
ID4+Pj4gKwo+ID4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBkaXNhYmxlX2tlcm5lbF92c3godm9p
ZCkKPiA+Pj4+ICt7Cj4gPj4+PiArICAgICAgIEJVSUxEX0JVRygpOwo+ID4+Pj4gK30KPiA+Pj4+
ICAgICNlbmRpZgo+ID4+Pgo+ID4+PiBJJ20gd29uZGVyaW5nIGhvdyB0aGlzIGlzIGFueSBiZXR0
ZXIgdGhhbiB0aGUgY3VycmVudCBzaXR1YXRpb246IHVzaW5nCj4gPj4+IEJVSUxEX0JVRygpIHdp
bGwgc3RpbGwgY2F1c2UgYSBidWlsZCBmYWlsdXJlPwo+ID4+Cj4gPj4gTm8gaXQgd29uJ3QgY2F1
c2UgYSBmYWlsdXJlLiBJbiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMu
aCB5b3UgaGF2ZToKPiA+Pgo+ID4+ICNkZWZpbmUgRENfRlBfU1RBUlQoKSB7IFwKPiA+PiAgICAg
ICAgICBpZiAoY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfVlNYX0NPTVApKSB7IFwKPiA+PiAgICAg
ICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgpOyBcCj4gPj4gICAgICAgICAgICAgICAgICBl
bmFibGVfa2VybmVsX3ZzeCgpOyBcCj4gPj4gICAgICAgICAgfSBlbHNlIGlmIChjcHVfaGFzX2Zl
YXR1cmUoQ1BVX0ZUUl9BTFRJVkVDX0NPTVApKSB7IFwKPiA+PiAgICAgICAgICAgICAgICAgIHBy
ZWVtcHRfZGlzYWJsZSgpOyBcCj4gPj4gICAgICAgICAgICAgICAgICBlbmFibGVfa2VybmVsX2Fs
dGl2ZWMoKTsgXAo+ID4+ICAgICAgICAgIH0gZWxzZSBpZiAoIWNwdV9oYXNfZmVhdHVyZShDUFVf
RlRSX0ZQVV9VTkFWQUlMQUJMRSkpIHsgXAo+ID4+ICAgICAgICAgICAgICAgICAgcHJlZW1wdF9k
aXNhYmxlKCk7IFwKPiA+PiAgICAgICAgICAgICAgICAgIGVuYWJsZV9rZXJuZWxfZnAoKTsgXAo+
ID4+ICAgICAgICAgIH0gXAo+ID4+Cj4gPj4gV2hlbiBDT05GSUdfVlNYIGlzIG5vdCBzZWxlY3Rl
ZCwgY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfVlNYX0NPTVApIGNvbnN0YW50IGZvbGRzIHRvICdm
YWxzZScgc28gdGhlCj4gPj4gY2FsbCB0byBlbmFibGVfa2VybmVsX3ZzeCgpIGlzIGRpc2NhcmRl
ZCBhbmQgdGhlIGJ1aWxkIHN1Y2NlZWRzLgo+ID4KPiA+IElDLiBTbyB5b3UgbWlnaHQgYXMgd2Vs
bCBoYXZlIGFuIGVtcHR5IChkdW1teSkgZnVuY3Rpb24gaW5zdGVhZD8KPiA+Cj4KPiBCdXQgd2l0
aCBhbiBlbXB0eSBmdW5jdGlvbiwgeW91IHRha2UgdGhlIHJpc2sgdGhhdCBvbmUgZGF5LCBzb21l
b25lIGNhbGxzIGl0IHdpdGhvdXQgY2hlY2tpbmcgdGhhdAo+IENPTkZJR19WU1ggaXMgc2VsZWN0
ZWQuIEhlcmUgaWYgc29tZW9uZSBkb2VzIHRoYXQsIGJ1aWxkIHdpbGwgZmFpbC4KCk9LLCBjb252
aW5jZWQuCgo+IEFub3RoZXIgc29sdXRpb24gaXMgdG8gZGVjbGFyZSBhIG5vbiBzdGF0aWMgcHJv
dG90eXBlIG9mIGl0LCBsaWtlIF9fcHV0X3VzZXJfYmFkKCkgZm9yIGluc3RhbmNlLiBJbgo+IHRo
YXQgY2FzZSwgdGhlIGxpbmsgd2lsbCBmYWlsLgo+Cj4gSSBwcmVmZXIgdGhlIEJVSUxEX0JVRygp
IGFwcHJvYWNoIGFzIEkgZmluZCBpdCBjbGVhbmVyIGFuZCBtb3JlIGV4cGxpY2l0LCBhbmQgYWxz
byBiZWNhdXNlIGl0IGJyZWFrcwo+IHRoZSBidWlsZCBhdCBjb21waWxlIHRpbWUsIHlvdSBkb24n
dCBoYXZlIHRvIHdhaXQgbGluayB0aW1lIHRvIGNhdGNoIHRoZSBlcnJvci4KCkdye29ldGplLGVl
dGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tCkdlZXJ0IFV5dHRlcmhv
ZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgt
bTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxl
LCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFs
aXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
