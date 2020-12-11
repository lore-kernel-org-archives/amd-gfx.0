Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C13BC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 18:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB15C22248
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 18:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15C22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138E36E1F8;
	Fri, 11 Dec 2020 18:49:43 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91AD6E1F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cbMHRu+HhMxJ7ZbfLIkfK/7A0UsLCACwu1MKvSaD4Iw=; b=bSARb8CnOVLovA4xQukAYxykkd
 iyJbDeBZEfRt7V972mGDJjCam1j35a+j53D+VHrMeDdOIlJmw/lFUTy0O1FZCE/XgEkQSuVcWLQ/F
 YwvKaP8aRHYTu09AEzhrNzKj7DAXgvoAGpEgFrdOC3UZz3I//444gWXwSaBjtv6VfazIk9zhlUSoK
 wCNqPyYQv8r6aw7bnoKryCF40sP4CbaXwZwtFOI1EmSQYm8+Pldbe32gnS3tuFntA4942K+vgjrM7
 QtzEuEA+b5aCj/AgtAROq3EykEjyNieLOAeUKoJDR5kREjWr5Iy86MzUVByblQGsvZsQJn4l4ft5G
 mrhDFjBQ==;
Received: from [2001:8b0:897:1650::2]
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knnU3-0005FJ-JK; Fri, 11 Dec 2020 18:49:39 +0000
Date: Fri, 11 Dec 2020 17:31:50 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: christian.koenig@amd.com
Subject: Re: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
Message-ID: <58E2B73AC8%devspam@moreofthesa.me.uk>
In-Reply-To: <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com>
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk> 
 <20201211005506.4554-4-devspam@moreofthesa.me.uk> 
 <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com>
Mail-Followup-To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Darren Salt <devspam@moreofthesa.me.uk>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Fri, 13160 Dec 1984 17:31:50 +0000
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBkZW1hbmQgdGhhdCBDaHJpc3RpYW4gS8O2bmlnIG1heSBvciBtYXkgbm90IGhhdmUgd3JpdHRl
bi4uLgoKPiBBbSAxMS4xMi4yMCB1bSAwMTo1NSBzY2hyaWViIERhcnJlbiBTYWx0Ogpbc25pcF0K
Pj4gKwlyYmFyX3NpemUgPSBwY2lfcmViYXJfYnl0ZXNfdG9fc2l6ZShhZGV2LT5nbWMucmVhbF92
cmFtX3NpemUpOwo+PiArCWN1cnJlbnRfc2l6ZSA9IHBjaV9yZWJhcl9nZXRfY3VycmVudF9zaXpl
KGFkZXYtPnBkZXYsIDApOwo+PiArCj4+ICsJLyogU2tpcCBpZiB0aGUgQklPUyBoYXMgYWxyZWFk
eSBlbmFibGVkIGxhcmdlIEJBUiwgY292ZXJpbmcgdGhlIFZSQU0gKi8KPj4gKwlpZiAoY3VycmVu
dF9zaXplID49IHJiYXJfc2l6ZSkKCj4gWW91IHNob3VsZCBwcm9iYWJseSBrZWVwIHRoZSBjb21w
YXJpc29uIGFzIGl0IGlzIGFuZCBjaGVjayB0aGUgcmVzb3VyY2UgCj4gbGVuZ3RoIGFnYWluc3Qg
dGhlIFZSQU0gc2l6ZSBpbnN0ZWFkLgoKUGVyaGFwcy4gSSB3b25kZXIsIHRob3VnaCwgaWYgSSBz
aG91bGQgZG8KCiAgICBpZiAoYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplID09IDApCiAgICAgIHJl
dHVybjsKCmluc3RlYWQgb2YgdGhlIGZpcnN0IHBhcnQgb2YgdGhlIG9yaWdpbmFsIGNvbmRpdGlv
bi4KCltzbmlwXQo+PiArCWRldl9kYmcoYWRldi0+ZGV2LCAiQklPUy1hbGxvY2F0ZWQgQkFSMCB3
YXMgJWxsdU1COyB0cnlpbmcgdG8gZ2V0ICVsbHVNQiIsCj4+ICsJICAgICAgICBjdXJyZW50X3Np
emUgPCAwID8gMCA6IChwY2lfcmViYXJfc2l6ZV90b19ieXRlcyhjdXJyZW50X3NpemUpID4+IDIw
KSwKPj4gKwkgICAgICAgIHBjaV9yZWJhcl9zaXplX3RvX2J5dGVzKHJiYXJfc2l6ZSkgPj4gMjAp
OwoKPiBQbGVhc2Ugbm8gZXh0cmEgZGVidWdnaW5nIG91dHB1dCwgd2Ugc3BhbSBzeXNsb2cgdGhh
dCBlbm91Z2ggd2l0aCB0aGUgCj4gZXhpc3RpbmcgcmVzaXplLgoKT2theSwgSSdsbCBkaXNwb3Nl
IG9mIHRoYXQuCiAKW3NuaXBdCj4+IC0JciA9IHBjaV9yZXNpemVfcmVzb3VyY2UoYWRldi0+cGRl
diwgMCwgcmJhcl9zaXplKTsKPj4gLQlpZiAociA9PSAtRU5PU1BDKQo+PiAtCQlEUk1fSU5GTygi
Tm90IGVub3VnaCBQQ0kgYWRkcmVzcyBzcGFjZSBmb3IgYSBsYXJnZSBCQVIuIik7Cj4+IC0JZWxz
ZSBpZiAociAmJiByICE9IC1FTk9UU1VQUCkKPj4gLQkJRFJNX0VSUk9SKCJQcm9ibGVtIHJlc2l6
aW5nIEJBUjAgKCVkKS4iLCByKTsKPj4gKwlyID0gMDsKPj4gKwlmb3IgKDsgcmJhcl9zaXplID49
IDAgJiYgcmJhcl9zaXplID4gY3VycmVudF9zaXplOyAtLXJiYXJfc2l6ZSkgewo+PiArCQkvKiBT
a2lwIHRoaXMgc2l6ZSBpZiBpdCBpc24ndCBhZHZlcnRpc2VkLgo+PiArCQkgKiBUaGlzIGF2b2lk
cyBwY2lfcmVzaXplX3Jlc291cmNlcyByZXR1cm5pbmcgLUVJTlZBTCBmb3IgdGhhdCByZWFzb24u
Cj4+ICsJCSAqLwo+PiArCQlpZiAoIShhdmFpbGFibGVfc2l6ZXMgJiBCSVQocmJhcl9zaXplKSkp
Cj4+ICsJCQljb250aW51ZTsKCj4gV2VsbCBleGFjdGx5IHRoYXQgdHJ5IGFuZCBlcnJvciBpcyBh
IHJhdGhlciBiaWcgTkFLLgoKPiBXaGF0IHlvdSBuZWVkIHRvIGRvIGluc3RlYWQgaXMgdG8gbG9v
ayBhdCB0aGUgcmV0dXJuIHZhbHVlIGZyb20KPiBwY2lfcmViYXJfZ2V0X3Bvc3NpYmxlX3NpemVz
KCkgYW5kIGRldGVybWluZSB0aGUgc2l6ZSBjbG9zZWQgdG8gdGhlIGRlc2lyZWQKPiBvbmUuIFvi
gKZdCgpXZWxs4oCmIHRoZXJlJ3MgdGhhdCByYXBpZCByZWplY3QgaW1tZWRpYXRlbHkgZm9sbG93
aW5nOyBhbmQgdGhlIG92ZXJyaWRlIHBhdGNoCmFsdGVycyB0aGF0IGNvbmRpdGlvbi4KCj4gRS5n
LiB3aGVuIG5lZWQgYSBzaXplIG9mIDEzIGlzIG5lZWRlZCB5b3UgZmlyc3QgY2hlY2sgaWYgYW55
IGJpdCA+PSAxMyAKPiBhcmUgc2V0LiBZb3UgY2FuIHVzZSB0aGUgZmZzKCkgZm9yIHRoaXMuCgpT
b+KApiBmaW5kIHRoZSBsb3dlc3QgYml0IHNldCwgYWZ0ZXIgbWFza2luZyBvdXQgYml0cyAwIHRv
IChyYmFyX3NpemUtMSksCmFuZCB0cnkgdG8gcmUtYWxsb2NhdGUgYWNjb3JkaW5nbHkuCgpJIGNv
dWxkIGhhdmUgaXQgY2hlY2sgZm9yIGxhcmdlciBzaXplcyBpZiB0aGF0IGZhaWxzLCBidXQgSSBk
b24ndCB0aGluayB0aGF0Cml0J3Mgd29ydGggaXQuIElmIHRoZSBCQVIgc2l6ZSBpcyA+PSAyw5cg
dGhlIFZSQU0gc2l6ZSwgaXQncyBhIHdhc3RlIG9mCmFkZHJlc3Mgc3BhY2U7IGFuZCB0aGUgYWR2
ZXJ0aXNlbWVudCBvZiBzdWNoIGEgc2l6ZSBpcyBhcmd1YWJseSBhIFZCSU9TIGJ1Zwphbnl3YXku
Cgo+IElmIHRoYXQgaXNuJ3QgdGhlIGNhc2UgdXNlIGZscygpIHRvIGdldCB0aGUgaGlnaGVzdCBz
ZXQgYml0IDwgMTMuCgpUaGF0IHN1Z2dlc3RzIHRoYXQgaXQnbGwgYmUgZWFzaWVzdCB0byBjbGVh
ciBlYWNoIGJpdCBhZnRlciB0aGUgY29ycmVzcG9uZGluZwpzaXplIGlzIGNoZWNrZWQsIEkgdGhp
bmsuIEFsc28sIHRoaXMgbG9va3MgbGlrZSBpdCdzIGFkZGluZyBjb21wbGV4aXR5IHRvCnRyeSB0
byBtYWtlIHJhcmVseS1leGVjdXRlZCBjb2RlIHNsaWdodGx5IGZhc3RlciBpbiBzb21lIGNhc2Vz
IChJIGNhbid0IHNlZQppdCBoZWxwaW5nIHdoZXJlIGF2YWlsYWJsZV9zaXplcyA9PSAweDNGMDAs
IGZvciBleGFtcGxlKS4KCkluY2lkZW50YWxseSwgaXMgaXQgd29ydGggdHJ5aW5nIHRvIHJlZHVj
ZSB0aGUgQkFSIHNpemUgYXQgYWxsPyBUaGlua2luZwptYWlubHkgb2YgdHdvIHNpdHVhdGlvbnMg
4oCTIGxpbWl0aW5nIHRoZSBtYXhpbXVtIHNpemUsIGFuZCB0aGUgQklPUyBoYXZpbmcKYWxsb2Nh
dGVkIG9uZSBtdWNoIHRvbyBsYXJnZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
