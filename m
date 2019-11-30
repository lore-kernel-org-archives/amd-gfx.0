Return-Path: <SRS0=vS0Q=ZX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3CC432C0
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C92D2071F
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C92D2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=universe2.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5106489F24;
	Sun,  1 Dec 2019 13:33:15 +0000 (UTC)
Received: from universe2.us (65-101-31-211.dia.static.qwest.net
 [65.101.31.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8316689DA5
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 20:15:23 +0000 (UTC)
Received: by universe2.us (Postfix, from userid 1003)
 id 3BBE43A8431; Sat, 30 Nov 2019 20:15:22 +0000 (UTC)
Received: from [192.168.0.22] (unknown [192.168.0.22])
 (Authenticated sender: subsentient@universe2.us)
 by universe2.us (Postfix) with ESMTPSA id 84A4F3A841E;
 Sat, 30 Nov 2019 13:15:18 -0700 (MST)
Subject: Re: AMDGPU bug
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <8a4cb7112cf6ed44581c838e84306e9c@universe2.us>
 <464fc90a-2d58-20e3-559f-9d8e2b9c11f7@amd.com>
From: Subsentient <subsentient@universe2.us>
Message-ID: <cecdfb45-3519-bdbe-0273-08a695a0e473@universe2.us>
Date: Sat, 30 Nov 2019 13:15:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <464fc90a-2d58-20e3-559f-9d8e2b9c11f7@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Sun, 01 Dec 2019 13:33:13 +0000
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMS0xMSAwNzozNSwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4gT24gMjAx
OS0xMS0xMCA3OjAwIHAubS4sIFN1YnNlbnRpZW50IHdyb3RlOgo+PiBIaSwgSSd2ZSBiZWVuIGV4
cGVyaWVuY2luZyBhIGJ1ZyBvbiBrZXJuZWxzIDUuMiBhbmQgdXAgdGhhdCAKPj4gYXBwYXJlbnRs
eSBpcyB1bmNvbW1vbiBhbmQvb3IgdW5pbXBvcnRhbnQgZW5vdWdoIHRvIGhhdmUgYm90aCB0aHJl
YWRzIAo+PiBtZW50aW9uaW5nIGl0IGRpZS4KPj4KPj4gT24gYSBSeXplbiAzIDIyMDBHLCB0aGUg
YW1kZ3B1IGRyaXZlciBmYWlscyB1cG9uIGxpZ2h0ZG0gbG9naW46Cj4+Cj4+IGh0dHBzOi8vYnVn
emlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTc1MjE4OAo+Pgo+PiBJIHRob3VnaHQg
SSdkIGJyaW5nIHRoaXMgdG8geW91ciBhdHRlbnRpb24gYXMgdGhlIG90aGVycyByZXBvcnRpbmcg
Cj4+IHRoaXMgYnVnIGhhdmUgc28gZmFyIGJlZW4gbWV0IHdpdGggc2lsZW5jZSwgYW5kIHRoaXMg
aGFzIHRyYXBwZWQgbWUgCj4+IGFuZCBvdGhlcnMgb24gdGhlIHVuc3VwcG9ydGVkIGtlcm5lbCA1
LjEuMjEuCj4+Cj4+IFRoYW5rcyBmb3IgeW91ciB0aW1lLgo+Pgo+Pgo+Pgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPj4KPgo+IEknbSBub3Qgc3Vy
ZSB0aGF0IHRoZSBiYWNrdHJhY2UgbGlzdGVkIGlzIHBhcnRpY3VsYXJseSByZWxldmFudCBmb3Ig
Cj4gZGVzY3JpYmluZyB3aGF0IGlzc3VlIGlzIGFjdHVhbGx5IG9jY3VycmluZywgYnV0IGlmIEkg
aGFkIHRvIHRha2UgYSAKPiBndWVzcyBiYXNlZCBvbiB0aGUgQVNJQyBhbmQga2VybmVsIHZlcnNp
b24gSSB3b3VsZCBpbWFnaW5lIHRoYXQgaXQncyAKPiBSYXZlbidzIGRpc3BsYXlhYmxlIERDQyBz
dXBwb3J0IHRoYXQncyBjYXVzaW5nIHlvdSBpc3N1ZXMuCj4KPiBJIGJlbGlldmUgeW91J2QgbmVl
ZCB0byBiZSBydW5uaW5nIG1lc2EsIHhmODYtdmlkZW8tYW1kZ3B1IGFuZCBydW5uaW5nIAo+IHdp
dGhvdXQgYSBjb21wb3NpdG9yIGluIHlvdXIgZGVza3RvcCBtYW5hZ2VyLiBEb2VzIHRoaXMgZGVz
Y3JpYmUgeW91ciAKPiBzZXR1cD8KPgo+IElmIHlvdSBjYW4gYmlzZWN0IHRoYXQgd291bGQgaGVs
cCBuYXJyb3cgdGhpbmdzIGRvd24gZnVydGhlci4gVGhlIAo+IGJpc2VjdCBjb21taXQgd291bGQg
bGlrZWx5IGJlIG9uZSB0aGF0J3MganVzdCBjaGFuZ2luZyB0aGUgYW1kZ3B1IAo+IHZlcnNpb24g
bnVtYmVyIGlmIGl0J3MgRENDIChzaW5jZSBtZXNhIGNoZWNrcyB0aGF0IGJlZm9yZSBkZWNpZGlu
ZyB0byAKPiBlbmFibGUgZGlzcGxheWFibGUgRENDKS4KPgo+IE5pY2hvbGFzIEthemxhdXNrYXMK
CkFmdGVybm9vbi4gTXkgYXBvbG9naWVzIGZvciB0aGUgZXh0ZW5kZWQgZGVsYXksIEkgaGF2ZSBh
biBleHRyZW1lbHkgYnVzeSAKc2NoZWR1bGUgYW5kIGl0IHRha2VzIGEgcmFyZSBjb21iaW5hdGlv
biBvZiB0aW1lIGFuZCBlbmVyZ3kgZm9yIG1lIHRvIGJlIAphYmxlIHRvIGRlYWwgd2l0aCBzdWNo
IG1hdHRlcnMuCgpJJ20gYWZyYWlkIGl0IGRvZXNuJ3QgYXBwZWFyIHRvIGJlIERDQywgYXMgSSBo
YXZlIGJlZW4gdXNpbmcgCiJSQURWX0RFQlVHPW5vZGNjIiwgYW5kIEkgYW0gbm90IHVzaW5nIFhv
cmcncyBhbWRncHUgZHJpdmVyLiBUaGUgCnhvcmcteDExLWRydi1hbWRncHUgcGFja2FnZSBpc24n
dCBpbnN0YWxsZWQuCgpJIGFtIHJ1bm5pbmcgd2l0aCBDb21waXogZm9yIGEgY29tcG9zaXRvciBv
biBYRkNFNCwgYnV0IHRoZSBoYW5nIG9jY3VycyAKd2VsbCBiZWZvcmUgbXkgdGltZS1kZWxheWVk
IHNjcmlwdCBjYW4gZXhlY3V0ZSBDb21waXouIE15IDIyMDBHIHJlbWFpbnMgCmJyb2tlbiBpbiBr
ZXJuZWwgNS40LjEuIEkgYW0gc3RpbGwgc3RyYW5kZWQgb24gNS4xLjIxLgoKSSBhcHByZWNpYXRl
IGFueSBpbnNpZ2h0IG9yIHN1Z2dlc3Rpb25zLgoKVGhhbmtzLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
