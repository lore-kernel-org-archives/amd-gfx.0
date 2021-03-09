Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD056518C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD056518C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913B46E4B3;
	Tue,  9 Mar 2021 15:09:03 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11F889C98
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:52:18 +0000 (UTC)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Dvpqh2X62z9txd1;
 Tue,  9 Mar 2021 09:52:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dU0TJnMUe1p4; Tue,  9 Mar 2021 09:52:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Dvpqh1dGGz9txd0;
 Tue,  9 Mar 2021 09:52:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DA508B7DA;
 Tue,  9 Mar 2021 09:52:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Lti_ytR-jCZn; Tue,  9 Mar 2021 09:52:17 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 636798B7DB;
 Tue,  9 Mar 2021 09:52:16 +0100 (CET)
Subject: Re: [PATCH] powerpc: Fix missing declaration of
 [en/dis]able_kernel_vsx()
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
 <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b12f9128-790b-7d8b-5f3c-e0912f5bec0a@csgroup.eu>
Date: Tue, 9 Mar 2021 09:52:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW0Cn1So8ckvhsT+N+p2hiPiksmCS32jzM0xCUYU4UAdQ@mail.gmail.com>
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

CgpMZSAwOS8wMy8yMDIxIMOgIDA5OjQ1LCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDDqWNyaXTCoDoK
PiBIaSBDaHJpc3RvcGhlLAo+IAo+IE9uIFR1ZSwgTWFyIDksIDIwMjEgYXQgOTozOSBBTSBDaHJp
c3RvcGhlIExlcm95Cj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6Cj4+IEFk
ZCBzdHViIGluc3RhbmNlcyBvZiBlbmFibGVfa2VybmVsX3ZzeCgpIGFuZCBkaXNhYmxlX2tlcm5l
bF92c3goKQo+PiB3aGVuIENPTkZJR19WU1ggaXMgbm90IHNldCwgdG8gYXZvaWQgZm9sbG93aW5n
IGJ1aWxkIGZhaWx1cmUuCj4+Cj4+ICAgIENDIFtNXSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3Mubwo+PiBJbiBmaWxlIGluY2x1ZGVkIGZy
b20gLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RtX3NlcnZpY2Vz
X3R5cGVzLmg6MjksCj4+ICAgICAgICAgICAgICAgICAgIGZyb20gLi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RtX3NlcnZpY2VzLmg6MzcsCj4+ICAgICAgICAgICAg
ICAgICAgIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxj
cy9kY25fY2FsY3MuYzoyNzoKPj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9jYWxjcy9kY25fY2FsY3MuYzogSW4gZnVuY3Rpb24gJ2Rjbl9id19hcHBseV9yZWdpc3Ry
eV9vdmVycmlkZSc6Cj4+IC4vZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9vc190eXBlcy5oOjY0OjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biAnZW5hYmxlX2tlcm5lbF92c3gnOyBkaWQgeW91IG1lYW4gJ2VuYWJsZV9rZXJuZWxfZnAnPyBb
LVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPj4gICAgIDY0IHwgICBlbmFi
bGVfa2VybmVsX3ZzeCgpOyBcCj4+ICAgICAgICB8ICAgXn5+fn5+fn5+fn5+fn5+fn4KPj4gZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYzo2
NDA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdEQ19GUF9TVEFSVCcKPj4gICAgNjQw
IHwgIERDX0ZQX1NUQVJUKCk7Cj4+ICAgICAgICB8ICBefn5+fn5+fn5+fgo+PiAuL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaDo3NTozOiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Rpc2FibGVfa2VybmVsX3ZzeCc7IGRp
ZCB5b3UgbWVhbiAnZGlzYWJsZV9rZXJuZWxfZnAnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlv
bi1kZWNsYXJhdGlvbl0KPj4gICAgIDc1IHwgICBkaXNhYmxlX2tlcm5lbF92c3goKTsgXAo+PiAg
ICAgICAgfCAgIF5+fn5+fn5+fn5+fn5+fn5+fgo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jOjY3NjoyOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8gJ0RDX0ZQX0VORCcKPj4gICAgNjc2IHwgIERDX0ZQX0VORCgpOwo+PiAgICAg
ICAgfCAgXn5+fn5+fn5+Cj4+IGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVy
cm9ycwo+PiBtYWtlWzVdOiAqKiogW2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvY2FsY3MvZGNuX2NhbGNzLm9dIEVycm9yIDEKPj4KPj4gRml4ZXM6IDE2YTlkZWExMTBh
NiAoImFtZGdwdTogRW5hYmxlIGluaXRpYWwgRENOIHN1cHBvcnQgb24gUE9XRVIiKQo+PiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95
IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+Cj4gCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNo
IQo+IAo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmgKPj4gKysr
IGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCj4+IEBAIC03MSw2ICs3MSwx
NiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZGlzYWJsZV9rZXJuZWxfdnN4KHZvaWQpCj4+ICAgewo+
PiAgICAgICAgICBtc3JfY2hlY2tfYW5kX2NsZWFyKE1TUl9GUHxNU1JfVkVDfE1TUl9WU1gpOwo+
PiAgIH0KPj4gKyNlbHNlCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgZW5hYmxlX2tlcm5lbF92c3go
dm9pZCkKPj4gK3sKPj4gKyAgICAgICBCVUlMRF9CVUcoKTsKPj4gK30KPj4gKwo+PiArc3RhdGlj
IGlubGluZSB2b2lkIGRpc2FibGVfa2VybmVsX3ZzeCh2b2lkKQo+PiArewo+PiArICAgICAgIEJV
SUxEX0JVRygpOwo+PiArfQo+PiAgICNlbmRpZgo+IAo+IEknbSB3b25kZXJpbmcgaG93IHRoaXMg
aXMgYW55IGJldHRlciB0aGFuIHRoZSBjdXJyZW50IHNpdHVhdGlvbjogdXNpbmcKPiBCVUlMRF9C
VUcoKSB3aWxsIHN0aWxsIGNhdXNlIGEgYnVpbGQgZmFpbHVyZT8KCk5vIGl0IHdvbid0IGNhdXNl
IGEgZmFpbHVyZS4gSW4gZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL29zX3R5cGVzLmgg
eW91IGhhdmU6CgojZGVmaW5lIERDX0ZQX1NUQVJUKCkgeyBcCglpZiAoY3B1X2hhc19mZWF0dXJl
KENQVV9GVFJfVlNYX0NPTVApKSB7IFwKCQlwcmVlbXB0X2Rpc2FibGUoKTsgXAoJCWVuYWJsZV9r
ZXJuZWxfdnN4KCk7IFwKCX0gZWxzZSBpZiAoY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfQUxUSVZF
Q19DT01QKSkgeyBcCgkJcHJlZW1wdF9kaXNhYmxlKCk7IFwKCQllbmFibGVfa2VybmVsX2FsdGl2
ZWMoKTsgXAoJfSBlbHNlIGlmICghY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfRlBVX1VOQVZBSUxB
QkxFKSkgeyBcCgkJcHJlZW1wdF9kaXNhYmxlKCk7IFwKCQllbmFibGVfa2VybmVsX2ZwKCk7IFwK
CX0gXAoKV2hlbiBDT05GSUdfVlNYIGlzIG5vdCBzZWxlY3RlZCwgY3B1X2hhc19mZWF0dXJlKENQ
VV9GVFJfVlNYX0NPTVApIGNvbnN0YW50IGZvbGRzIHRvICdmYWxzZScgc28gdGhlIApjYWxsIHRv
IGVuYWJsZV9rZXJuZWxfdnN4KCkgaXMgZGlzY2FyZGVkIGFuZCB0aGUgYnVpbGQgc3VjY2VlZHMu
Cgo+IAo+IFdoYXQgYWJvdXQgYWRkaW5nICJkZXBlbmRzIG9uICFQT1dFUlBDIHx8IFZTWCIgaW5z
dGVhZCwgdG8gcHJldmVudAo+IHRoZSBpc3N1ZSBmcm9tIGhhcHBlbmluZyBpbiB0aGUgZmlyc3Qg
cGxhY2U/CgpDT05GSUdfVlNYIGlzIG5vdCByZXF1aXJlZCBhcyBwb2ludGVkIGJ5IHRoZSBEQ19G
UF9TVEFSVCgpIG1hY3JvIGFib3ZlIGFuZCB0aGUgbWF0Y2hpbmcgRENfRlBfRU5EKCkgCm1hY3Jv
LgoKPiAKPiBHcntvZXRqZSxlZXRpbmd9cywKPiAKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
R2VlcnQKPiAKCgpDaHJpc3RvcGhlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
