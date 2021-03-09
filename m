Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B74FC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6CB6518C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6CB6518C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7BD6E900;
	Tue,  9 Mar 2021 15:09:04 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58531892F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 09:58:02 +0000 (UTC)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DvrHW3Jcrz9txfL;
 Tue,  9 Mar 2021 10:57:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id J6axhznGM18g; Tue,  9 Mar 2021 10:57:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DvrHW1tYWz9txfN;
 Tue,  9 Mar 2021 10:57:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DDA68B7E7;
 Tue,  9 Mar 2021 10:58:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ES4Klg5zpPJo; Tue,  9 Mar 2021 10:58:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C48CB8B7DC;
 Tue,  9 Mar 2021 10:57:59 +0100 (CET)
Subject: Re: [PATCH] powerpc: Fix missing declaration of
 [en/dis]able_kernel_vsx()
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
 <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
 <CAMuHMdXM0qg23UN6VBqbb0Vm2bg3tRSM=OCD5r7U2K1brpnJAg@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b64111a3-df3f-bf59-20ce-0af57715ad53@csgroup.eu>
Date: Tue, 9 Mar 2021 10:57:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXM0qg23UN6VBqbb0Vm2bg3tRSM=OCD5r7U2K1brpnJAg@mail.gmail.com>
Content-Language: fr
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpMZSAwOS8wMy8yMDIxIMOgIDEwOjE2LCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDDqWNyaXTCoDoK
PiBIaSBDaHJpc3RvcGhlLAo+IAo+IE9uIFR1ZSwgTWFyIDksIDIwMjEgYXQgOTo1MiBBTSBDaHJp
c3RvcGhlIExlcm95Cj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6Cj4+IExl
IDA5LzAzLzIwMjEgw6AgMDk6NDUsIEdlZXJ0IFV5dHRlcmhvZXZlbiBhIMOpY3JpdCA6Cj4+PiBP
biBUdWUsIE1hciA5LCAyMDIxIGF0IDk6MzkgQU0gQ2hyaXN0b3BoZSBMZXJveQo+Pj4gPGNocmlz
dG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6Cj4+Pj4gQWRkIHN0dWIgaW5zdGFuY2VzIG9m
IGVuYWJsZV9rZXJuZWxfdnN4KCkgYW5kIGRpc2FibGVfa2VybmVsX3ZzeCgpCj4+Pj4gd2hlbiBD
T05GSUdfVlNYIGlzIG5vdCBzZXQsIHRvIGF2b2lkIGZvbGxvd2luZyBidWlsZCBmYWlsdXJlLgo+
Pj4+Cj4+Pj4gICAgIENDIFtNXSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9jYWxjcy9kY25fY2FsY3Mubwo+Pj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZG1fc2VydmljZXNfdHlwZXMuaDoy
OSwKPj4+PiAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaDozNywKPj4+PiAgICAgICAgICAgICAgICAg
ICAgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rj
bl9jYWxjcy5jOjI3Ogo+Pj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkv
ZGMvY2FsY3MvZGNuX2NhbGNzLmM6IEluIGZ1bmN0aW9uICdkY25fYndfYXBwbHlfcmVnaXN0cnlf
b3ZlcnJpZGUnOgo+Pj4+IC4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9vc190eXBlcy5oOjY0OjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biAnZW5hYmxlX2tlcm5lbF92c3gnOyBkaWQgeW91IG1lYW4gJ2VuYWJsZV9rZXJuZWxfZnAnPyBb
LVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPj4+PiAgICAgIDY0IHwgICBl
bmFibGVfa2VybmVsX3ZzeCgpOyBcCj4+Pj4gICAgICAgICB8ICAgXn5+fn5+fn5+fn5+fn5+fn4K
Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9j
YWxjcy5jOjY0MDoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ0RDX0ZQX1NUQVJUJwo+
Pj4+ICAgICA2NDAgfCAgRENfRlBfU1RBUlQoKTsKPj4+PiAgICAgICAgIHwgIF5+fn5+fn5+fn5+
Cj4+Pj4gLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL29zX3R5cGVz
Lmg6NzU6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdkaXNhYmxl
X2tlcm5lbF92c3gnOyBkaWQgeW91IG1lYW4gJ2Rpc2FibGVfa2VybmVsX2ZwJz8gWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4+Pj4gICAgICA3NSB8ICAgZGlzYWJsZV9r
ZXJuZWxfdnN4KCk7IFwKPj4+PiAgICAgICAgIHwgICBefn5+fn5+fn5+fn5+fn5+fn4KPj4+PiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5j
OjY3NjoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ0RDX0ZQX0VORCcKPj4+PiAgICAg
Njc2IHwgIERDX0ZQX0VORCgpOwo+Pj4+ICAgICAgICAgfCAgXn5+fn5+fn5+Cj4+Pj4gY2MxOiBz
b21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4+Pj4gbWFrZVs1XTogKioqIFtk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5v
XSBFcnJvciAxCj4+Pj4KPj4+PiBGaXhlczogMTZhOWRlYTExMGE2ICgiYW1kZ3B1OiBFbmFibGUg
aW5pdGlhbCBEQ04gc3VwcG9ydCBvbiBQT1dFUiIpCj4+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcKPj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxl
cm95QGNzZ3JvdXAuZXU+Cj4+Pgo+Pj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+Pj4KPj4+PiAt
LS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmgKPj4+PiArKysgYi9hcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmgKPj4+PiBAQCAtNzEsNiArNzEsMTYgQEAg
c3RhdGljIGlubGluZSB2b2lkIGRpc2FibGVfa2VybmVsX3ZzeCh2b2lkKQo+Pj4+ICAgIHsKPj4+
PiAgICAgICAgICAgbXNyX2NoZWNrX2FuZF9jbGVhcihNU1JfRlB8TVNSX1ZFQ3xNU1JfVlNYKTsK
Pj4+PiAgICB9Cj4+Pj4gKyNlbHNlCj4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBlbmFibGVfa2Vy
bmVsX3ZzeCh2b2lkKQo+Pj4+ICt7Cj4+Pj4gKyAgICAgICBCVUlMRF9CVUcoKTsKPj4+PiArfQo+
Pj4+ICsKPj4+PiArc3RhdGljIGlubGluZSB2b2lkIGRpc2FibGVfa2VybmVsX3ZzeCh2b2lkKQo+
Pj4+ICt7Cj4+Pj4gKyAgICAgICBCVUlMRF9CVUcoKTsKPj4+PiArfQo+Pj4+ICAgICNlbmRpZgo+
Pj4KPj4+IEknbSB3b25kZXJpbmcgaG93IHRoaXMgaXMgYW55IGJldHRlciB0aGFuIHRoZSBjdXJy
ZW50IHNpdHVhdGlvbjogdXNpbmcKPj4+IEJVSUxEX0JVRygpIHdpbGwgc3RpbGwgY2F1c2UgYSBi
dWlsZCBmYWlsdXJlPwo+Pgo+PiBObyBpdCB3b24ndCBjYXVzZSBhIGZhaWx1cmUuIEluIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9vc190eXBlcy5oIHlvdSBoYXZlOgo+Pgo+PiAjZGVm
aW5lIERDX0ZQX1NUQVJUKCkgeyBcCj4+ICAgICAgICAgIGlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BV
X0ZUUl9WU1hfQ09NUCkpIHsgXAo+PiAgICAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgp
OyBcCj4+ICAgICAgICAgICAgICAgICAgZW5hYmxlX2tlcm5lbF92c3goKTsgXAo+PiAgICAgICAg
ICB9IGVsc2UgaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0FMVElWRUNfQ09NUCkpIHsgXAo+
PiAgICAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgpOyBcCj4+ICAgICAgICAgICAgICAg
ICAgZW5hYmxlX2tlcm5lbF9hbHRpdmVjKCk7IFwKPj4gICAgICAgICAgfSBlbHNlIGlmICghY3B1
X2hhc19mZWF0dXJlKENQVV9GVFJfRlBVX1VOQVZBSUxBQkxFKSkgeyBcCj4+ICAgICAgICAgICAg
ICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7IFwKPj4gICAgICAgICAgICAgICAgICBlbmFibGVfa2Vy
bmVsX2ZwKCk7IFwKPj4gICAgICAgICAgfSBcCj4+Cj4+IFdoZW4gQ09ORklHX1ZTWCBpcyBub3Qg
c2VsZWN0ZWQsIGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX1ZTWF9DT01QKSBjb25zdGFudCBmb2xk
cyB0byAnZmFsc2UnIHNvIHRoZQo+PiBjYWxsIHRvIGVuYWJsZV9rZXJuZWxfdnN4KCkgaXMgZGlz
Y2FyZGVkIGFuZCB0aGUgYnVpbGQgc3VjY2VlZHMuCj4gCj4gSUMuIFNvIHlvdSBtaWdodCBhcyB3
ZWxsIGhhdmUgYW4gZW1wdHkgKGR1bW15KSBmdW5jdGlvbiBpbnN0ZWFkPwo+IAoKQnV0IHdpdGgg
YW4gZW1wdHkgZnVuY3Rpb24sIHlvdSB0YWtlIHRoZSByaXNrIHRoYXQgb25lIGRheSwgc29tZW9u
ZSBjYWxscyBpdCB3aXRob3V0IGNoZWNraW5nIHRoYXQgCkNPTkZJR19WU1ggaXMgc2VsZWN0ZWQu
IEhlcmUgaWYgc29tZW9uZSBkb2VzIHRoYXQsIGJ1aWxkIHdpbGwgZmFpbC4KCkFub3RoZXIgc29s
dXRpb24gaXMgdG8gZGVjbGFyZSBhIG5vbiBzdGF0aWMgcHJvdG90eXBlIG9mIGl0LCBsaWtlIF9f
cHV0X3VzZXJfYmFkKCkgZm9yIGluc3RhbmNlLiBJbiAKdGhhdCBjYXNlLCB0aGUgbGluayB3aWxs
IGZhaWwuCgpJIHByZWZlciB0aGUgQlVJTERfQlVHKCkgYXBwcm9hY2ggYXMgSSBmaW5kIGl0IGNs
ZWFuZXIgYW5kIG1vcmUgZXhwbGljaXQsIGFuZCBhbHNvIGJlY2F1c2UgaXQgYnJlYWtzIAp0aGUg
YnVpbGQgYXQgY29tcGlsZSB0aW1lLCB5b3UgZG9uJ3QgaGF2ZSB0byB3YWl0IGxpbmsgdGltZSB0
byBjYXRjaCB0aGUgZXJyb3IuCgpDaHJpc3RvcGhlCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
