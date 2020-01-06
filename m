Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C95C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 11:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9942D2072E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 11:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9942D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EF689D99;
	Mon,  6 Jan 2020 11:30:05 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 25C7C8800A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 11:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id E24142A604E;
 Mon,  6 Jan 2020 12:30:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 1F-LcxBlJexm; Mon,  6 Jan 2020 12:30:01 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 207DA2A604B;
 Mon,  6 Jan 2020 12:30:00 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1ioQa8-003Crs-2y; Mon, 06 Jan 2020 12:30:00 +0100
Subject: Re: Warning: check cp_fw_version and update it to realize GRBM
 requires 1-cycle delay in cp firmware
To: Alex Deucher <alexdeucher@gmail.com>,
 Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
References: <745c5951-5304-9651-34f1-6b3f6a713ece@molgen.mpg.de>
 <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <3553af46-c9c5-cd33-e7f9-bf7a1a5f49a7@daenzer.net>
Date: Mon, 6 Jan 2020 12:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Chang Zhu <Changfeng.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0yNiA1OjUzIHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUaHUsIERl
YyAyNiwgMjAxOSBhdCA1OjExIEFNIFBhdWwgTWVuemVsCj4+Cj4+PiBbICAgMTMuNDQ2OTc1XSBb
ZHJtXSBXYXJuaW5nOiBjaGVjayBjcF9md192ZXJzaW9uIGFuZCB1cGRhdGUgaXQgdG8gcmVhbGl6
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgR1JCTSByZXF1aXJlcyAxLWN5Y2xlIGRlbGF5IGlu
IGNwIGZpcm13YXJlCj4+Cj4+IENoYW5nLCBpdCBsb29rcyBsaWtlIHlvdSBhZGRlZCB0aGF0IHdh
cm5pbmcgaW4gY29tbWl0IDExYzYxMDg5MzQuCj4+Cj4+PiBkcm0vYW1kZ3B1OiBhZGQgd2Fybmlu
ZyBmb3IgR1JCTSAxLWN5Y2xlIGRlbGF5IGlzc3VlIGluIGdmeDkKPj4+Cj4+PiBJdCBuZWVkcyB0
byBhZGQgd2FybmluZyB0byB1cGRhdGUgZmlybXdhcmUgaW4gZ2Z4OQo+Pj4gaW4gY2FzZSB0aGF0
IGZpcm13YXJlIGlzIHRvbyBvbGQgdG8gaGF2ZSBmdW5jdGlvbiB0bwo+Pj4gcmVhbGl6ZSBkdW1t
eSByZWFkIGluIGNwIGZpcm13YXJlLgo+Pgo+PiBVbmZvcnR1bmF0ZWx5LCBpdCBsb29rcyBsaWtl
IHlvdSBkaWQgbm90IGV2ZW4gY2hlY2sgaG93IHRoZSB3YXJuaW5nIGlzCj4+IGZvcm1hdHRlZCAo
bmVlZGxlc3Mgc3BhY2VzKSwgc28gSSBndWVzcyB0aGlzIHdhcyB0b3RhbGx5IHVudGVzdGVkLiBB
bHNvLAo+PiB3aGF0IGlzIHRoYXQgd2FybmluZyBhYm91dCwgYW5kIHdoYXQgaXMgdGhlIHVzZXIg
c3VwcG9zZWQgdG8gZG8/IEkgYW0KPj4gdW5hYmxlIHRvIGZpbmQgYGNwX2Z3X3ZlcnNpb25gIGlu
IHRoZSBzb3VyY2UgY29kZSBhdCBhbGwuCj4+Cj4gCj4gVGhlIGNvZGUgbG9va3MgZmluZS4gIE5v
dCBzdXJlIHdoeSBpdCdzIHJlbmRlcmluZyBmdW5ueSBpbiB5b3VyIGxvZy4KPiAgICAgICAgICAg
ICAgICBEUk1fV0FSTl9PTkNFKCJXYXJuaW5nOiBjaGVjayBjcF9md192ZXJzaW9uIGFuZCB1cGRh
dGUKPiBpdCB0byByZWFsaXplIFwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdSQk0g
cmVxdWlyZXMgMS1jeWNsZSBkZWxheSBpbiBjcCBmaXJtd2FyZVxuIik7CgpMb29rcyBsaWtlIHRo
ZSBsZWFkaW5nIHNwYWNlcyBhZnRlciB0aGUgYmFja3NsYXNoIGFyZSBpbmNsdWRlZCBpbiB0aGUK
c3RyaW5nLiBTb21ldGhpbmcgbGlrZSB0aGlzIHNob3VsZCBiZSBiZXR0ZXI6CgogICAgICAgIERS
TV9XQVJOX09OQ0UoIldhcm5pbmc6IGNoZWNrIGNwX2Z3X3ZlcnNpb24gYW5kIHVwZGF0ZSAiCiAg
ICAgICAgICAgICAgICAgICAgICAiR1JCTSByZXF1aXJlcyAxLWN5Y2xlIGRlbGF5IGluIGNwIGZp
cm13YXJlXG4iKTsKCihvciBtYXliZSB0aGUgaW50ZW50aW9uIHdhcyB0byBwdXQgdGhlIHNlY29u
ZCBzZW50ZW5jZSBvbiBhIG5ldyBsaW5lPykKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
