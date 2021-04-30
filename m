Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2860C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B2E6140C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2E6140C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11EB6F51E;
	Fri, 30 Apr 2021 13:33:44 +0000 (UTC)
X-Greylist: delayed 549 seconds by postgrey-1.36 at gabe;
 Fri, 30 Apr 2021 13:33:43 UTC
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3AD406F51E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 13:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id D4DE12020D1;
 Fri, 30 Apr 2021 15:24:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id E6woeWIHKkYk; Fri, 30 Apr 2021 15:24:33 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 5B9D62020C9;
 Fri, 30 Apr 2021 15:24:33 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lcT8C-000FLu-2b; Fri, 30 Apr 2021 15:24:32 +0200
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20210429205024.892894-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] Revert "drm/amdgpu: Verify bo size can fit framebuffer
 size on init."
Message-ID: <88f8bff1-7750-515d-24ca-24c76cad9bdf@daenzer.net>
Date: Fri, 30 Apr 2021 15:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429205024.892894-1-bas@basnieuwenhuizen.nl>
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
Cc: alexdeucher@gmail.com, markyacoub@chromium.org,
 xinhui pan <xinhui.pan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNC0yOSAxMDo1MCBwLm0uLCBCYXMgTmlldXdlbmh1aXplbiB3cm90ZToKPiBUaGlz
IHJldmVydHMgY29tbWl0IGYyNTg5MDdmZGQ4MzVlMWFlZDZkNjY2YjAwY2RkMGYxODY2NzZiN2Mu
Cj4gCj4gU2FtZSBwcm9ibGVtIGFzICJkcm0vYW1kZ3B1OiBWZXJpZnkgYm8gc2l6ZSBjYW4gZml0
IGZyYW1lYnVmZmVyIHNpemUiLAo+IGJ1dCBiZWNhdXNlIGl0IGdldHMgY2hlY2tlZCBlYXJsaWVy
IGl0IG5vdyBvbmx5IHRyaWdnZXJzIG9uIHRoZQo+IG1vZGlmaWVycyBjYXNlLgo+IAo+IFRoZXJl
IGFyZSBhIGNvdXBsZSBvZiByZWFzb25zIHdoeSB0aGUgRFJNIGNvcmUgQk8gc2l6ZSBjaGVjayB3
b24ndAo+IHdvcmsgZm9yIEFNREdQVSwgZXNwZWNpYWxseSBhcm91bmQgRENDIHBsYW5lcy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBCYXMgTmlldXdlbmh1aXplbiA8YmFzQGJhc25pZXV3ZW5odWl6ZW4u
bmw+Cj4gLS0tCj4gCj4gRm9yIC1maXhlcy4gTWlnaHQgaGF2ZSBzb21lIGNvbmZsaWN0cyB3aXRo
Cj4gImRybS9hbWRncHU6IEVuc3VyZSB0aGF0IHRoZSBtb2RpZmllciByZXF1ZXN0ZWQgaXMgc3Vw
cG9ydGVkIGJ5IHBsYW5lIgo+IGZvciBhbWQtc3RhZ2luZy1kcm0tbmV4dAoKVGhpcyBpbnRlcmFj
dHMgYmFkbHkgd2l0aCA3OWZjZDQ0NmU3ZTEgImRybS9hbWRncHU6IEZpeCBtZW1vcnkgbGVhayIs
IHJlc3VsdGluZyBpbiBCT3MgZ2V0dGluZyBkZXN0cm95ZWQgcHJlbWF0dXJlbHkgYW5kIGVuc3Vp
bmcgYmFkbmVzcy4gVG8gYXZvaWQgdGhhdCwgYXQgbGVhc3QgdGhlIGRybV9nZW1fb2JqZWN0X3B1
dCBjYWxsIG5lZWRzIHRvIGJlIHJlbW92ZWQgZnJvbSB0aGUgZW5kIG9mIGFtZGdwdV9kaXNwbGF5
X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlIG5lZWRzIHRvIGJlIHJlbW92ZWQgYXMgd2VsbCwgaWYg
bm90IDc5ZmNkNDQ2ZTdlMSByZXZlcnRlZCBhbHRvZ2V0aGVyLgoKCkkgc3VzcGVjdCA3OWZjZDQ0
NmU3ZTEgd2FzIGF0IGxlYXN0IHBhcnRseSBhIGZpeC11cCBmb3IgZjI1ODkwN2ZkZDgzLCB0byBj
b21wZW5zYXRlIGZvciBkcm1fZ2VtX2ZiX2luaXRfd2l0aF9mdW5jcyBpbmNyZW1lbnRpbmcgdGhl
IEJPIHJlZmVyZW5jZSBjb3VudHMuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdh
cmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxv
cGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
