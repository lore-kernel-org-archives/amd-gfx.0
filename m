Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A81C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 13:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0612078B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 13:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0612078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013D56EA88;
	Thu,  2 Apr 2020 13:11:24 +0000 (UTC)
X-Greylist: delayed 2249 seconds by postgrey-1.36 at gabe;
 Thu, 02 Apr 2020 10:14:00 UTC
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD3B6EA3A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 10:14:00 +0000 (UTC)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jJwGv-0000jL-VM; Thu, 02 Apr 2020 11:36:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id E6FF1100D52; Thu,  2 Apr 2020 11:36:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jann Horn <jannh@google.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse,
 -msse2 without any visible FPU state protection
In-Reply-To: <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
Date: Thu, 02 Apr 2020 11:36:24 +0200
Message-ID: <87k12yns9z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-Mailman-Approved-At: Thu, 02 Apr 2020 13:11:23 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Leo Li <sunpeng.li@amd.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SmFubiBIb3JuIDxqYW5uaEBnb29nbGUuY29tPiB3cml0ZXM6Cj4gT24gVGh1LCBBcHIgMiwgMjAy
MCBhdCA5OjM0IEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
d3JvdGU6Cj4+IEFtIDAyLjA0LjIwIHVtIDA0OjM0IHNjaHJpZWIgSmFubiBIb3JuOgo+PiA+IFt4
ODYgZm9sa3MgaW4gQ0Mgc28gdGhhdCB0aGV5IGNhbiBjaGltZSBpbiBvbiB0aGUgcHJlY2lzZSBy
dWxlcyBmb3IKPj4gPiB0aGlzIHN0dWZmXQoKVGhleSBhcmUgcHJldHR5IHNpbXBsZS4KCkFueSBj
b2RlIHVzaW5nIEZQVSBuZWVkcyB0byBiZSBjb21wbGV0ZWx5IGlzb2xhdGVkIGZyb20gcmVndWxh
ciBjb2RlCmVpdGhlciBieSB1c2luZyBpbmxpbmUgYXNtIG9yIGJ5IG1vdmluZyBpdCB0byBhIGRp
ZmZlcmVudCBjb21waWxhdGlvbgp1bml0LiBUaGUgaW52b2NhdGlvbnMgbmVlZCBmcHVfYmVnaW4v
ZW5kKCkgb2YgY291cnNlLgoKPj4gPiBJIG5vdGljZWQgdGhhdCBzZXZlcmFsIG1ha2VmaWxlcyB1
bmRlciBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvCj4+ID4gdHVybiBvbiBmbG9hdGlu
Zy1wb2ludCBpbnN0cnVjdGlvbnMgaW4gdGhlIGNvbXBpbGVyIGZsYWdzCj4+ID4gKC1taGFyZC1m
bG9hdCwgLW1zc2UgYW5kIC1tc3NlMikgaW4gb3JkZXIgdG8gbWFrZSB0aGUgImZsb2F0IiBhbmQK
Pj4gPiAiZG91YmxlIiB0eXBlcyB1c2FibGUgZnJvbSBDIGNvZGUgd2l0aG91dCByZXF1aXJpbmcg
aGVscGVyIGZ1bmN0aW9ucy4KPj4gPgo+PiA+IEhvd2V2ZXIsIGFzIGZhciBhcyBJIGtub3csIGNv
ZGUgcnVubmluZyBpbiBub3JtYWwga2VybmVsIGNvbnRleHQgaXNuJ3QKPj4gPiBhbGxvd2VkIHRv
IHVzZSBmbG9hdGluZy1wb2ludCByZWdpc3RlcnMgd2l0aG91dCBzcGVjaWFsIHByb3RlY3Rpb24K
Pj4gPiB1c2luZyBoZWxwZXJzIGxpa2Uga2VybmVsX2ZwdV9iZWdpbigpIGFuZCBrZXJuZWxfZnB1
X2VuZCgpICh3aGljaCBhbHNvCj4+ID4gcmVxdWlyZSB0aGF0IHRoZSBwcm90ZWN0ZWQgY29kZSBu
ZXZlciBibG9ja3MpLiBJZiB5b3UgdmlvbGF0ZSB0aGF0Cj4+ID4gcnVsZSwgdGhhdCBjYW4gbGVh
ZCB0byB2YXJpb3VzIGlzc3VlcyAtIGFtb25nIG90aGVyIHRoaW5ncywgSSB0aGluawo+PiA+IHRo
ZSBrZXJuZWwgd2lsbCBjbG9iYmVyIHVzZXJzcGFjZSBGUFUgcmVnaXN0ZXIgc3RhdGUsIGFuZCBJ
IHRoaW5rIHRoZQo+PiA+IGtlcm5lbCBjb2RlIGNhbiBibG93IHVwIGlmIGEgY29udGV4dCBzd2l0
Y2ggaGFwcGVucyBhdCB0aGUgd3JvbmcgdGltZSwKPj4gPiBzaW5jZSBpbi1rZXJuZWwgdGFzayBz
d2l0Y2hlcyBkb24ndCBwcmVzZXJ2ZSBGUFUgc3RhdGUuCj4+ID4KPj4gPiBJcyB0aGVyZSBzb21l
IGhpZGRlbiB0cmljayBJJ20gbWlzc2luZyB0aGF0IG1ha2VzIGl0IG9rYXkgdG8gdXNlIEZQVQo+
PiA+IHJlZ2lzdGVycyBoZXJlPwo+PiA+Cj4+ID4gSSB3b3VsZCB0cnkgdGVzdGluZyB0aGlzLCBi
dXQgdW5mb3J0dW5hdGVseSBub25lIG9mIHRoZSBBTUQgZGV2aWNlcyBJCj4+ID4gaGF2ZSBoZXJl
IGhhdmUgdGhlIGFwcHJvcHJpYXRlIGdyYXBoaWNzIGhhcmR3YXJlLi4uCj4+Cj4+IHllcywgdXNp
bmcgdGhlIGZsb2F0aW5nIHBvaW50IGNhbGN1bGF0aW9ucyBpbiB0aGUgZGlzcGxheSBjb2RlIGhh
cyBiZWVuCj4+IGEgc291cmNlIG9mIG51bWVyb3VzIHByb2JsZW1zIGFuZCBjb25mdXNpb24gaW4g
dGhlIHBhc3QuCj4+Cj4+IFRoZSBjYWxscyB0byBrZXJuZWxfZnB1X2JlZ2luKCkgYW5kIGtlcm5l
bF9mcHVfZW5kKCkgYXJlIGhpZGRlbiBiZWhpbmQKPj4gdGhlIERDX0ZQX1NUQVJUKCkgYW5kIERD
X0ZQX0VORCgpIG1hY3JvcyB3aGljaCBhcmUgc3VwcG9zZWQgdG8gaGlkZSB0aGUKPj4gYXJjaGl0
ZWN0dXJlIGRlcGVuZCBoYW5kbGluZyBmb3IgeDg2IGFuZCBQUEM2NC4KPgo+IEhtbS4uLiBidXQg
YXMgZmFyIGFzIEkgY2FuIHRlbGwsIHlvdSdyZSB1c2luZyB0aG9zZSBtYWNyb3MgZnJvbSBpbnNp
ZGUKPiBmdW5jdGlvbnMgdGhhdCBhcmUgYWxyZWFkeSBjb21waWxlZCB3aXRoIHRoZSBGUFUgb246
Cj4KPiAgLSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLmMg
dXNlcyB0aGUgbWFjcm9zLAo+IGJ1dCBpcyBhbHJlYWR5IGNvbXBpbGVkIHdpdGggY2FsY3NfY2Nm
bGFncwo+ICAtIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNv
dXJjZS5jIHVzZXMgdGhlCj4gbWFjcm9zLCBidXQgaXMgYWxyZWFkeSBjb21waWxlZCB3aXRoICIt
bWhhcmQtZmxvYXQgLW1zc2UgLW1zc2UyIgo+ICAtIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jIHVzZXMgdGhlCj4gbWFjcm9zLCBidXQgaXMgYWxy
ZWFkeSBjb21waWxlZCB3aXRoICItbWhhcmQtZmxvYXQgLW1zc2UgLW1zc2UyIgo+Cj4gQUZBSUsg
YXMgc29vbiBhcyB5b3UgZW50ZXIgYW55IGZ1bmN0aW9uIGluIGFueSBmaWxlIGNvbXBpbGVkIHdp
dGggRlBVCj4gaW5zdHJ1Y3Rpb25zLCB5b3UgbWF5IGVuY291bnRlciBTU0UgaW5zdHJ1Y3Rpb25z
LCBlLmcuIHZpYSB0aGluZ3MgbGlrZQo+IGNvbXBpbGVyLWdlbmVyYXRlZCBtZW1vcnktemVyb2lu
ZyBjb2RlIC0gbm90IGp1c3Qgd2hlbiB5b3UncmUgYWN0dWFsbHkKPiB1c2luZyBkb3VibGVzIG9y
IGZsb2F0cy4KClRoYXQncyBjb3JyZWN0IGFuZCB0aGlzIHdpbGwgc2lsZW50bHkgY2F1c2UgRlBV
IHN0YXRlIGNvcnJ1cHRpb24gLi4uCgpXZSByZWFsbHkgbmVlZCBvYmp0b29sIHN1cHBvcnQgdG8g
dmFsaWRhdGUgdGhhdC4KClBldGVyLCBub3cgdGhhdCB3ZSBrbm93IGhvdyB0byBkbyBpdCAobm9p
bnN0ciwgY2xhYy9zdGFjKSB3ZSBjYW4gZW1pdAphbm5vdGF0aW9ucyAoc2VlIHBhdGNoIGJlbG93
KSBhbmQgdmFsaWRhdGUgdGhhdCBhbnkgRlBVIGluc3RydWN0aW9uIGlzCmluc2lkZSBhIHNhZmUg
cmVnaW9uLiBIbW0/CgpUaGFua3MsCgogICAgICAgIHRnbHgKCjg8LS0tLS0tLS0tLS0tLS0tCi0t
LSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9hcGkuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9mcHUvYXBpLmgKQEAgLTE5LDggKzE5LDI3IEBACiAgKiBJZiB5b3UgaW50ZW5kIHRvIHVz
ZSB0aGUgRlBVIGluIHNvZnRpcnEgeW91IG5lZWQgdG8gY2hlY2sgZmlyc3Qgd2l0aAogICogaXJx
X2ZwdV91c2FibGUoKSBpZiBpdCBpcyBwb3NzaWJsZS4KICAqLwotZXh0ZXJuIHZvaWQga2VybmVs
X2ZwdV9iZWdpbih2b2lkKTsKLWV4dGVybiB2b2lkIGtlcm5lbF9mcHVfZW5kKHZvaWQpOworZXh0
ZXJuIHZvaWQgX19rZXJuZWxfZnB1X2JlZ2luKHZvaWQpOworZXh0ZXJuIHZvaWQgX19rZXJuZWxf
ZnB1X2VuZCh2b2lkKTsKKworc3RhdGljIGlubGluZSB2b2lkIGtlcm5lbF9mcHVfYmVnaW4odm9p
ZCkKK3sKKwlhc20gdm9sYXRpbGUoIiVjMDpcblx0IgorCQkgICAgICIucHVzaHNlY3Rpb24gLmRp
c2NhcmQuZnB1X2JlZ2luXG5cdCIKKwkJICAgICAiLmxvbmcgJWMwYiAtIC5cblx0IgorCQkgICAg
ICIucG9wc2VjdGlvblxuXHQiIDogOiAiaSIgKF9fQ09VTlRFUl9fKSk7CisJX19rZXJuZWxfZnB1
X2JlZ2luKCk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBrZXJuZWxfZnB1X2VuZCh2b2lkKQor
eworCV9fa2VybmVsX2ZwdV9lbmQoKTsKKwlhc20gdm9sYXRpbGUoIiVjMDpcblx0IgorCQkgICAg
ICIucHVzaHNlY3Rpb24gLmRpc2NhcmQuZnB1X2VuZFxuXHQiCisJCSAgICAgIi5sb25nICVjMGIg
LSAuXG5cdCIKKwkJICAgICAiLnBvcHNlY3Rpb25cblx0IiA6IDogImkiIChfX0NPVU5URVJfXykp
OworfQorCiBleHRlcm4gYm9vbCBpcnFfZnB1X3VzYWJsZSh2b2lkKTsKIGV4dGVybiB2b2lkIGZw
cmVnc19tYXJrX2FjdGl2YXRlKHZvaWQpOwogCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9mcHUvY29y
ZS5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jCkBAIC04Miw3ICs4Miw3IEBAIGJv
b2wgaXJxX2ZwdV91c2FibGUodm9pZCkKIH0KIEVYUE9SVF9TWU1CT0woaXJxX2ZwdV91c2FibGUp
OwogCi12b2lkIGtlcm5lbF9mcHVfYmVnaW4odm9pZCkKK3ZvaWQgX19rZXJuZWxfZnB1X2JlZ2lu
KHZvaWQpCiB7CiAJcHJlZW1wdF9kaXNhYmxlKCk7CiAKQEAgLTEwMiwxNiArMTAyLDE2IEBAIHZv
aWQga2VybmVsX2ZwdV9iZWdpbih2b2lkKQogCX0KIAlfX2NwdV9pbnZhbGlkYXRlX2ZwcmVnc19z
dGF0ZSgpOwogfQotRVhQT1JUX1NZTUJPTF9HUEwoa2VybmVsX2ZwdV9iZWdpbik7CitFWFBPUlRf
U1lNQk9MX0dQTChfX2tlcm5lbF9mcHVfYmVnaW4pOwogCi12b2lkIGtlcm5lbF9mcHVfZW5kKHZv
aWQpCit2b2lkIF9fa2VybmVsX2ZwdV9lbmQodm9pZCkKIHsKIAlXQVJOX09OX0ZQVSghdGhpc19j
cHVfcmVhZChpbl9rZXJuZWxfZnB1KSk7CiAKIAl0aGlzX2NwdV93cml0ZShpbl9rZXJuZWxfZnB1
LCBmYWxzZSk7CiAJcHJlZW1wdF9lbmFibGUoKTsKIH0KLUVYUE9SVF9TWU1CT0xfR1BMKGtlcm5l
bF9mcHVfZW5kKTsKK0VYUE9SVF9TWU1CT0xfR1BMKF9fa2VybmVsX2ZwdV9lbmQpOwogCiAvKgog
ICogU2F2ZSB0aGUgRlBVIHN0YXRlIChtYXJrIGl0IGZvciByZWxvYWQgaWYgbmVjZXNzYXJ5KToK
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
