Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B23AC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADF364FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADF364FE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6F06EA20;
	Wed, 10 Mar 2021 14:13:07 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F056EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 13:33:29 +0000 (UTC)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DwY1f18kQzB09Zs;
 Wed, 10 Mar 2021 14:33:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id UW49o0QEjYh0; Wed, 10 Mar 2021 14:33:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DwY1d6BkdzB09Zn;
 Wed, 10 Mar 2021 14:33:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F0FE88B78C;
 Wed, 10 Mar 2021 14:33:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id tX8OhmiwHzB5; Wed, 10 Mar 2021 14:33:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C11A8B77E;
 Wed, 10 Mar 2021 14:33:26 +0100 (CET)
Subject: Re: [PATCH] powerpc: Fix missing declaration of
 [en/dis]able_kernel_vsx()
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
 <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
 <CAMuHMdXM0qg23UN6VBqbb0Vm2bg3tRSM=OCD5r7U2K1brpnJAg@mail.gmail.com>
 <b64111a3-df3f-bf59-20ce-0af57715ad53@csgroup.eu>
 <CAMuHMdUQcE7+O9NWH4Xxxv+r7ZFnTGqtHuteOMiSPY_gK5xkZw@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5b579a54-e596-bcf2-b003-5c28345447b7@csgroup.eu>
Date: Wed, 10 Mar 2021 14:33:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUQcE7+O9NWH4Xxxv+r7ZFnTGqtHuteOMiSPY_gK5xkZw@mail.gmail.com>
Content-Language: fr
X-Mailman-Approved-At: Wed, 10 Mar 2021 14:13:06 +0000
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

SGkgR2VlcnQsCgpMZSAwOS8wMy8yMDIxIMOgIDExOjU1LCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDD
qWNyaXTCoDoKPiBIaSBDaHJpc3RvcGhlLAo+IAo+IE9uIFR1ZSwgTWFyIDksIDIwMjEgYXQgMTA6
NTggQU0gQ2hyaXN0b3BoZSBMZXJveQo+IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdy
b3RlOgo+PiBMZSAwOS8wMy8yMDIxIMOgIDEwOjE2LCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDDqWNy
aXQgOgo+Pj4gT24gVHVlLCBNYXIgOSwgMjAyMSBhdCA5OjUyIEFNIENocmlzdG9waGUgTGVyb3kK
Pj4+IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOgo+Pj4+IExlIDA5LzAzLzIw
MjEgw6AgMDk6NDUsIEdlZXJ0IFV5dHRlcmhvZXZlbiBhIMOpY3JpdCA6Cj4+Pj4+IE9uIFR1ZSwg
TWFyIDksIDIwMjEgYXQgOTozOSBBTSBDaHJpc3RvcGhlIExlcm95Cj4+Pj4+IDxjaHJpc3RvcGhl
Lmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOgo+Pj4+Pj4gQWRkIHN0dWIgaW5zdGFuY2VzIG9mIGVu
YWJsZV9rZXJuZWxfdnN4KCkgYW5kIGRpc2FibGVfa2VybmVsX3ZzeCgpCj4+Pj4+PiB3aGVuIENP
TkZJR19WU1ggaXMgbm90IHNldCwgdG8gYXZvaWQgZm9sbG93aW5nIGJ1aWxkIGZhaWx1cmUuCj4+
Pj4+Pgo+Pj4+Pj4gICAgICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLm8KPj4+Pj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAu
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZG1fc2VydmljZXNfdHlw
ZXMuaDoyOSwKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaDozNywKPj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2NhbGNzL2Rjbl9jYWxjcy5jOjI3Ogo+Pj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYzogSW4gZnVuY3Rpb24gJ2Rjbl9id19h
cHBseV9yZWdpc3RyeV9vdmVycmlkZSc6Cj4+Pj4+PiAuL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaDo2NDozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gJ2VuYWJsZV9rZXJuZWxfdnN4JzsgZGlkIHlvdSBtZWFuICdlbmFi
bGVfa2VybmVsX2ZwJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4+
Pj4+PiAgICAgICA2NCB8ICAgZW5hYmxlX2tlcm5lbF92c3goKTsgXAo+Pj4+Pj4gICAgICAgICAg
fCAgIF5+fn5+fn5+fn5+fn5+fn5+Cj4+Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jOjY0MDoyOiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8gJ0RDX0ZQX1NUQVJUJwo+Pj4+Pj4gICAgICA2NDAgfCAgRENfRlBfU1RBUlQoKTsK
Pj4+Pj4+ICAgICAgICAgIHwgIF5+fn5+fn5+fn5+Cj4+Pj4+PiAuL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaDo3NTozOiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Rpc2FibGVfa2VybmVsX3ZzeCc7IGRpZCB5b3UgbWVh
biAnZGlzYWJsZV9rZXJuZWxfZnAnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJh
dGlvbl0KPj4+Pj4+ICAgICAgIDc1IHwgICBkaXNhYmxlX2tlcm5lbF92c3goKTsgXAo+Pj4+Pj4g
ICAgICAgICAgfCAgIF5+fn5+fn5+fn5+fn5+fn5+fgo+Pj4+Pj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYzo2NzY6Mjogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvICdEQ19GUF9FTkQnCj4+Pj4+PiAgICAgIDY3NiB8ICBEQ19GUF9F
TkQoKTsKPj4+Pj4+ICAgICAgICAgIHwgIF5+fn5+fn5+fgo+Pj4+Pj4gY2MxOiBzb21lIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4+Pj4+PiBtYWtlWzVdOiAqKiogW2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLm9dIEVycm9y
IDEKPj4+Pj4+Cj4+Pj4+PiBGaXhlczogMTZhOWRlYTExMGE2ICgiYW1kZ3B1OiBFbmFibGUgaW5p
dGlhbCBEQ04gc3VwcG9ydCBvbiBQT1dFUiIpCj4+Pj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5s
ZXJveUBjc2dyb3VwLmV1Pgo+Pj4+Pgo+Pj4+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghCj4+Pj4+
Cj4+Pj4+PiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmgKPj4+Pj4+
ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9zd2l0Y2hfdG8uaAo+Pj4+Pj4gQEAgLTcx
LDYgKzcxLDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkaXNhYmxlX2tlcm5lbF92c3godm9pZCkK
Pj4+Pj4+ICAgICB7Cj4+Pj4+PiAgICAgICAgICAgIG1zcl9jaGVja19hbmRfY2xlYXIoTVNSX0ZQ
fE1TUl9WRUN8TVNSX1ZTWCk7Cj4+Pj4+PiAgICAgfQo+Pj4+Pj4gKyNlbHNlCj4+Pj4+PiArc3Rh
dGljIGlubGluZSB2b2lkIGVuYWJsZV9rZXJuZWxfdnN4KHZvaWQpCj4+Pj4+PiArewo+Pj4+Pj4g
KyAgICAgICBCVUlMRF9CVUcoKTsKPj4+Pj4+ICt9Cj4+Pj4+PiArCj4+Pj4+PiArc3RhdGljIGlu
bGluZSB2b2lkIGRpc2FibGVfa2VybmVsX3ZzeCh2b2lkKQo+Pj4+Pj4gK3sKPj4+Pj4+ICsgICAg
ICAgQlVJTERfQlVHKCk7Cj4+Pj4+PiArfQo+Pj4+Pj4gICAgICNlbmRpZgo+Pj4+Pgo+Pj4+PiBJ
J20gd29uZGVyaW5nIGhvdyB0aGlzIGlzIGFueSBiZXR0ZXIgdGhhbiB0aGUgY3VycmVudCBzaXR1
YXRpb246IHVzaW5nCj4+Pj4+IEJVSUxEX0JVRygpIHdpbGwgc3RpbGwgY2F1c2UgYSBidWlsZCBm
YWlsdXJlPwo+Pj4+Cj4+Pj4gTm8gaXQgd29uJ3QgY2F1c2UgYSBmYWlsdXJlLiBJbiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaCB5b3UgaGF2ZToKPj4+Pgo+Pj4+ICNk
ZWZpbmUgRENfRlBfU1RBUlQoKSB7IFwKPj4+PiAgICAgICAgICAgaWYgKGNwdV9oYXNfZmVhdHVy
ZShDUFVfRlRSX1ZTWF9DT01QKSkgeyBcCj4+Pj4gICAgICAgICAgICAgICAgICAgcHJlZW1wdF9k
aXNhYmxlKCk7IFwKPj4+PiAgICAgICAgICAgICAgICAgICBlbmFibGVfa2VybmVsX3ZzeCgpOyBc
Cj4+Pj4gICAgICAgICAgIH0gZWxzZSBpZiAoY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfQUxUSVZF
Q19DT01QKSkgeyBcCj4+Pj4gICAgICAgICAgICAgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7IFwK
Pj4+PiAgICAgICAgICAgICAgICAgICBlbmFibGVfa2VybmVsX2FsdGl2ZWMoKTsgXAo+Pj4+ICAg
ICAgICAgICB9IGVsc2UgaWYgKCFjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9GUFVfVU5BVkFJTEFC
TEUpKSB7IFwKPj4+PiAgICAgICAgICAgICAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsgXAo+Pj4+
ICAgICAgICAgICAgICAgICAgIGVuYWJsZV9rZXJuZWxfZnAoKTsgXAo+Pj4+ICAgICAgICAgICB9
IFwKPj4+Pgo+Pj4+IFdoZW4gQ09ORklHX1ZTWCBpcyBub3Qgc2VsZWN0ZWQsIGNwdV9oYXNfZmVh
dHVyZShDUFVfRlRSX1ZTWF9DT01QKSBjb25zdGFudCBmb2xkcyB0byAnZmFsc2UnIHNvIHRoZQo+
Pj4+IGNhbGwgdG8gZW5hYmxlX2tlcm5lbF92c3goKSBpcyBkaXNjYXJkZWQgYW5kIHRoZSBidWls
ZCBzdWNjZWVkcy4KPj4+Cj4+PiBJQy4gU28geW91IG1pZ2h0IGFzIHdlbGwgaGF2ZSBhbiBlbXB0
eSAoZHVtbXkpIGZ1bmN0aW9uIGluc3RlYWQ/Cj4+Pgo+Pgo+PiBCdXQgd2l0aCBhbiBlbXB0eSBm
dW5jdGlvbiwgeW91IHRha2UgdGhlIHJpc2sgdGhhdCBvbmUgZGF5LCBzb21lb25lIGNhbGxzIGl0
IHdpdGhvdXQgY2hlY2tpbmcgdGhhdAo+PiBDT05GSUdfVlNYIGlzIHNlbGVjdGVkLiBIZXJlIGlm
IHNvbWVvbmUgZG9lcyB0aGF0LCBidWlsZCB3aWxsIGZhaWwuCj4gCj4gT0ssIGNvbnZpbmNlZC4K
PiAKCk5vdGUgdGhhdCBmb2xsb3dpbmcgYnVpbGQgdGVzdCBwZXJmb3JtZWQgb24ga2lzc2tiLCB3
aXRoIGdjYyA0LjkgdGhlIGZvbGxvd2luZyBjaGFuZ2UgaXMgcmVxdWlyZWQgaW4gCmFkZGl0aW9u
OiAKaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4cHBjLWRldi9wYXRj
aC9iMjMxZGZhMDQwY2U0Y2MzN2Y3MDJmNWMzYTU5NWZkZWFiZmUwNDYyLjE2MTUzNzgyMDkuZ2l0
LmNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldS8KCkNocmlzdG9waGUKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
