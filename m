Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA751C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 10:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BE220709
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 10:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BE220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAE16E3F9;
	Mon, 10 Aug 2020 10:50:51 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id DC3C76E3F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 10:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id A582E2A6042;
 Mon, 10 Aug 2020 12:50:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Mpbg-h6jHzk1; Mon, 10 Aug 2020 12:50:48 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 9C3F02A6016;
 Mon, 10 Aug 2020 12:50:46 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1k55O9-000Uyj-S3; Mon, 10 Aug 2020 12:50:45 +0200
Subject: Re: [PATCH] gpu/drm: Remove TTM_PL_FLAG_WC of VRAM to fix
 writecombine issue for Loongson64
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1596871502-3432-1-git-send-email-yangtiezhu@loongson.cn>
 <20200808134147.GA5772@alpha.franken.de>
 <b7b16df1-d661-d59a-005b-da594ce9fc95@flygoat.com>
 <38857c24-25c4-cff3-569e-5bcb773bfae6@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <2f3fd325-8093-98e7-5bc8-75490258baac@daenzer.net>
Date: Mon, 10 Aug 2020 12:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <38857c24-25c4-cff3-569e-5bcb773bfae6@amd.com>
Content-Language: en-CA
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOC0wOSAyOjEzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDgu
MDguMjAgdW0gMTU6NTAgc2NocmllYiBKaWF4dW4gWWFuZzoKPj4g5ZyoIDIwMjAvOC84IOS4i+WN
iDk6NDEsIFRob21hcyBCb2dlbmRvZXJmZXIg5YaZ6YGTOgo+Pj4gT24gU2F0LCBBdWcgMDgsIDIw
MjAgYXQgMDM6MjU6MDJQTSArMDgwMCwgVGllemh1IFlhbmcgd3JvdGU6Cj4+Pj4gTG9vbmdzb24g
cHJvY2Vzc29ycyBoYXZlIGEgd3JpdGVjb21iaW5lIGlzc3VlIHRoYXQgbWF5YmUgZmFpbGVkIHRv
Cj4+Pj4gd3JpdGUgYmFjayBmcmFtZWJ1ZmZlciB1c2VkIHdpdGggQVRJIFJhZGVvbiBvciBBTUQg
R1BVIGF0IHRpbWVzLAo+Pj4+IGFmdGVyIGNvbW1pdCA4YTA4ZTUwY2VlNjYgKCJkcm06IFBlcm1p
dCB2aWRlby1idWZmZXJzIHdyaXRlY29tYmluZQo+Pj4+IG1hcHBpbmcgZm9yIE1JUFMiKSwgdGhl
cmUgZXhpc3RzIHNvbWUgZXJyb3JzIHN1Y2ggYXMgYmx1cnJlZCBzY3JlZW4KPj4+PiBhbmQgbG9j
a3VwLCBhbmQgc28gb24uCj4+Pj4KPj4+PiBSZW1vdmUgdGhlIGZsYWcgVFRNX1BMX0ZMQUdfV0Mg
b2YgVlJBTSB0byBmaXggd3JpdGVjb21iaW5lIGlzc3VlIGZvcgo+Pj4+IExvb25nc29uNjQgdG8g
d29yayB3ZWxsIHdpdGggQVRJIFJhZGVvbiBvciBBTUQgR1BVLCBhbmQgaXQgaGFzIG5vIGFueQo+
Pj4+IGluZmx1ZW5jZSBvbiB0aGUgb3RoZXIgcGxhdGZvcm1zLgo+Pj4gd2VsbCBpdCdzIG5vdCBt
eSBjYWxsIHRvIHRha2Ugb3IgcmVqZWN0IHRoaXMgcGF0Y2gsIGJ1dCBJIGFscmVhZHkKPj4+IGlu
ZGljYXRlZCBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gZGlzYWJsZSB3cml0ZWNvbWJpbmUgb24gdGhl
IENQVQo+Pj4gZGV0ZWN0aW9uIHNpZGUgKG9yIGRvIHlvdSBoYXZlIG90aGVyIGRldmljZXMgd2hl
cmUgd3JpdGVjb21iaW5pbmcKPj4+IHdvcmtzID8pLiBTb21ldGhpbmcgbGlrZSBiZWxvdyB3aWxs
IGRpc2JhbGUgaXQgZm9yIGFsbCBsb29uZ3NvbjY0IENQVXMuCj4+PiBJZiB5b3Ugbm93IGZpbmQg
b3V0IHdoZXJlIGl0IHdvcmtzIGFuZCB3aGVyZSBpdCBkb2Vzbid0LCB5b3UgY2FuIGV2ZW4KPj4+
IHJlZHVjZSBpdCB0byB0aGUgcmVxdWlyZWQgbWluaXVtIG9mIGFmZmVjdGVkIENQVXMuCj4+IEhp
IFRpZXpodSwgVGhvbWFzLAo+Pgo+PiBZZXMsIHdyaXRlY29tYmluZSB3b3JrcyB3ZWxsIG9uIExT
N0EncyBpbnRlcm5hbCBHUFUuLi4uCj4+IEFuZCBldmVuIHdvcmtzIHdlbGwgd2l0aCBzb21lIEFN
RCBHUFVzIChpbiBteSBjYXNlLCBSWDU1MCkuCj4gCj4gSW4gdGhpcyBjYXNlIHRoZSBwYXRjaCBp
cyBhIGNsZWFyIE5BSyBzaW5jZSB5b3UgaGF2ZW4ndCByb290IGNhdXNlZCB0aGUKPiBpc3N1ZSBh
bmQgYXJlIGp1c3Qgd29ya2luZyBhcm91bmQgaXQgaW4gYSB2ZXJ5IHF1ZXN0aW9uYWJsZSBtYW5u
ZXIuCgpUbyBiZSBmYWlyIHRob3VnaCwgYW1kZ3B1ICYgcmFkZW9uIGFyZSBhbHJlYWR5IGRpc2Fi
bGluZyB3cml0ZS1jb21iaW5pbmcKZm9yIHN5c3RlbSBtZW1vcnkgcGFnZXMgaW4gMzItYml0IHg4
NiBrZXJuZWxzIGZvciBzaW1pbGFyIHJlYXNvbnMuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOk
bnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGli
cmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5k
IFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
