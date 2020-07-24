Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220D9206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220D9206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63076EA09;
	Fri, 24 Jul 2020 21:21:42 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2276E994;
 Fri, 24 Jul 2020 21:20:02 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5af26d.dynamic.kabel-deutschland.de
 [95.90.242.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4C4162002EE2A;
 Fri, 24 Jul 2020 23:20:00 +0200 (CEST)
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
To: Kees Cook <keescook@chromium.org>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
 <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
 <202007241016.922B094AAA@keescook>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3c92db94-3b62-a70b-8ace-f5e34e8f268f@molgen.mpg.de>
Date: Fri, 24 Jul 2020 23:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007241016.922B094AAA@keescook>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 24 Jul 2020 21:21:41 +0000
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
Cc: anthony.ruhier@gmail.com, 1i5t5.duncan@cox.net, sunpeng.li@amd.com,
 Mazin Rezk <mnrzk@protonmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, regressions@leemhuis.info,
 amd-gfx@lists.freedesktop.org, Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, mphantomx@yahoo.com.br,
 Harry Wentland <Harry.Wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkRlYXIgS2VlcywKCgpBbSAyNC4wNy4yMCB1bSAxOTozMyBzY2hyaWViIEtlZXMgQ29vazoKPiBP
biBGcmksIEp1bCAyNCwgMjAyMCBhdCAwOTo0NToxOEFNICswMjAwLCBQYXVsIE1lbnplbCB3cm90
ZToKPj4gQW0gMjQuMDcuMjAgdW0gMDA6MzIgc2NocmllYiBLZWVzIENvb2s6Cj4+PiBPbiBUaHUs
IEp1bCAyMywgMjAyMCBhdCAwOToxMDoxNVBNICswMDAwLCBNYXppbiBSZXprIHdyb3RlOgo+PiBB
cyBMaW51eCA1LjgtcmM3IGlzIGdvaW5nIHRvIGJlIHJlbGVhc2VkIHRoaXMgU3VuZGF5LCBJIHdv
bmRlciwgaWYgY29tbWl0Cj4+IDMyMDJmYTYyZiAoInNsdWI6IHJlbG9jYXRlIGZyZWVsaXN0IHBv
aW50ZXIgdG8gbWlkZGxlIG9mIG9iamVjdCIpIHNob3VsZCBiZQo+PiByZXZlcnRlZCBmb3Igbm93
IHRvIGZpeCB0aGUgcmVncmVzc2lvbiBmb3IgdGhlIHVzZXJzIGFjY29yZGluZyB0byBMaW51eOKA
mSBubwo+PiByZWdyZXNzaW9uIHBvbGljeS4gT25jZSB0aGUgQU1ER1BVL0RSTSBkcml2ZXIgaXNz
dWUgaXMgZml4ZWQsIGl0IGNhbiBiZQo+PiByZWFwcGxpZWQuIEkga25vdyBpdOKAmXMgbm90IG9w
dGltYWwsIGJ1dCBhcyBzb21lIHRlc3RpbmcgaXMgZ29pbmcgdG8gYmUKPj4gaW52b2x2ZWQgZm9y
IHRoZSBmaXgsIEnigJlkIGFyZ3VlIGl04oCZcyB0aGUgYmVzdCBvcHRpb24gZm9yIHRoZSB1c2Vy
cy4KPiAKPiBXZWxsLCB0aGUgU0xVQiBkZWZlbnNlIHdhcyBhbHJlYWR5IHJlbGVhc2VkIGluIHY1
LjcsIHNvIEknbSBub3Qgc3VyZSBpdAo+IHJlYWxseSBoZWxwcyBmb3IgYW1kZ3B1X2RtIHVzZXJz
IHNlZWluZyBpdCB0aGVyZSB0b28uCgpJbiBteSBvcGluaW9uLCBpdCB3b3VsZCBoZWxwLCBhcyB0
aGUgc3RhYmxlIHJlbGVhc2UgY291bGQgcGljayB1cCB0aGUgCnJldmVydCwgb25lcyBpdOKAmXMg
aW4gTGludXPigJkgbWFzdGVyIGJyYW5jaC4KCj4gVGhlcmUgd2FzIGEgZml4IHRvIGRpc2FibGUg
dGhlIGFzeW5jIHBhdGggZm9yIHRoaXMgZHJpdmVyIHRoYXQgd29ya2VkCj4gYXJvdW5kIHRoZSBi
dWcgdG9vLCB5ZXM/IFRoYXQgc2VlbXMgbGlrZSBhIHNhZmVyIGFuZCBtb3JlIGZvY3VzZWQKPiBj
aGFuZ2UgdGhhdCBkb2Vzbid0IHJldmVydCB0aGUgU0xVQiBkZWZlbnNlIGZvciBhbGwgdXNlcnMs
IGFuZCB3b3VsZAo+IGFjdHVhbGx5IHByb3ZpZGUgYSBjb21wbGV0ZSwgSSB0aGluaywgd29ya2Fy
b3VuZCB3aGVyZWFzIHJldmVydGluZwo+IHRoZSBTTFVCIGNoYW5nZSBtZWFucyB0aGUgcmFjZSBz
dGlsbCBleGlzdHMuIEZvciBleGFtcGxlLCBpdCB3b3VsZCBiZQo+IGhpdCB3aXRoIHNsYWIgcG9p
c29uaW5nLCBldGMuCgpJIGRvIG5vdCBrbm93LiBJZiB0aGVyZSBpcyBzdWNoIGEgZml4LCB0aGF0
IHdvdWxkIGJlIGdyZWF0LiBCdXQgaWYgeW91IApkbyBub3Qga25vdywgaG93IHNob3VsZCBhIG5v
cm1hbCB1c2VyPyA7LSkKCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCgoKS2luZCByZWdhcmRzLAoKUGF1
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
