Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D41C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A630B23976
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A630B23976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E10F6E08C;
	Fri,  8 Jan 2021 10:58:28 +0000 (UTC)
Received: from forward105j.mail.yandex.net (forward105j.mail.yandex.net
 [5.45.198.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0BE6E08C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 10:58:26 +0000 (UTC)
Received: from sas1-35b601a382d3.qloud-c.yandex.net
 (sas1-35b601a382d3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c08:c505:0:640:35b6:1a3])
 by forward105j.mail.yandex.net (Yandex) with ESMTP id 8E203B2341C;
 Fri,  8 Jan 2021 13:58:24 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net
 (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
 by sas1-35b601a382d3.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 NxOlGcaPxF-wOE84EGM; Fri, 08 Jan 2021 13:58:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1610103504; bh=qHxINHpNJcqdFyCR8rlrI2CUDj09hKz30MDn7cSDzA4=;
 h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
 b=SZDuBbwrQndNPEYR3a67DSK8vnPEAdVnFXSULfxEO+sRgrGpTxuPAz0/MlRgCYon7
 /Lv9L41eOjqmuFlvI2ZWkwMIk5XaQpdffiHcpWtBa/ZiYhSV0hBC7WYwTgCNHxA/uw
 9FdgHB0l7ffpGV5msHvlzkuGgb+PT8m1DUKUVHnA=
Authentication-Results: sas1-35b601a382d3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id 8KVVaS46Wx-wNI06ilT; Fri, 08 Jan 2021 13:58:23 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Message-ID: <9dafa913d1ab2846f936689b3a5aec49c2f9ee50.camel@yandex.ru>
Subject: Re: [PATCH] Revert "drm/amd/display: Fixed Intermittent blue screen
 on OLED panel"
From: Konstantin Kharlamov <hi-angel@yandex.ru>
To: amd-gfx@lists.freedesktop.org
Date: Fri, 08 Jan 2021 13:58:22 +0300
In-Reply-To: <20210108104847.152847-1-Hi-Angel@yandex.ru>
References: <20210108104847.152847-1-Hi-Angel@yandex.ru>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Naveed.Ashfaq@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T2gsIEkganVzdCBmb3VuZCBvbiBNTCBhcmNoaXZlIHRoYXQgdGhlIHJldmVydCBhbHJlYWR5IHdh
cyBzZW50LiBEaXNyZWdhcmQgdGhlbgp0aGlzIGVtYWlsLiBJdCdzIGp1c3QgdGhhdCBub2JvZHkg
bWVudGlvbmVkIG9uIHRoZSBnaXRsYWIgdGhyZWFkIHRoYXQgcmV2ZXJ0IHdhcwpzZW50LCBzbyBJ
IGRlY2lkZWQgdG8gZ28gYWhlYWQuIE5pY2UgdG8ga25vdyByZXZlcnQgaXMgb24gTUwgYWxyZWFk
eSDimLoKCk9uIEZyaSwgMjAyMS0wMS0wOCBhdCAxMzo0OCArMDMwMCwgS29uc3RhbnRpbiBLaGFy
bGFtb3Ygd3JvdGU6Cj4gVGhpcyByZXZlcnRzIGNvbW1pdCBhODYxNzM2ZGFlNjQ0YTBkN2FiYmNh
MGM2MzhhZTZhYWQyOGZlZWI4Lgo+IAo+IFRoaXMgY29tbWl0IGxlZCB0byBhIHBvd2VyIHJlZ3Jl
c3Npb24gd2hlcmUgQU1EIGNhcmRzIGRyYXcgbG90cyBvZiBwb3dlcgo+IHdoaWxlIGJlaW5nIGlk
bGUuCj4gCj4gQnVnOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lz
c3Vlcy8xNDA3Cj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUuMTAKPiBTaWduZWQt
b2ZmLWJ5OiBLb25zdGFudGluIEtoYXJsYW1vdiA8SGktQW5nZWxAeWFuZGV4LnJ1Pgo+IC0tLQo+
IMKgLi4uL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24yMC9kaXNwbGF5X21vZGVfdmJhXzIwdjIuY8Kg
IHwgMTEgKysrKysrLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMKPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMKPiBpbmRl
eCA4NjBlNzJhNTE1MzQuLjgwMTcwZjk3MjFjZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24yMC9kaXNwbGF5X21vZGVf
dmJhXzIwdjIuYwo+IEBAIC0yNjM1LDE0ICsyNjM1LDE1IEBAIHN0YXRpYyB2b2lkCj4gZG1sMjB2
Ml9ESVNQQ0xLRFBQQ0xLRENGQ0xLRGVlcFNsZWVwUHJlZmV0Y2hQYXJhbWV0ZXJzV2F0ZXJtYXJr
c0FuZFAKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChtb2Rl
X2xpYi0+dmJhLkRSQU1DbG9ja0NoYW5nZVN1cHBvcnRzVkFjdGl2ZSAmJgo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZV9saWItPnZiYS5NaW5BY3Rp
dmVEUkFNQ2xvY2tDaGFuZ2VNYXJnaW4gPiA2MCAmJgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZV9saWItPnZiYS5QcmVmZXRjaE1vZGVbbW9kZV9s
aWItCj4gPnZiYS5Wb2x0YWdlTGV2ZWxdW21vZGVfbGliLT52YmEubWF4TXBjQ29tYl0gPT0gMCkg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZV9s
aWItPnZiYS5NaW5BY3RpdmVEUkFNQ2xvY2tDaGFuZ2VNYXJnaW4gPiA2MCkgewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VXYXRl
cm1hcmsgKz0gMjU7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvciAo
ayA9IDA7IGsgPCBtb2RlX2xpYi0+dmJhLk51bWJlck9mQWN0aXZlUGxhbmVzOyArK2spIHsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChtb2RlX2xp
Yi0+dmJhLkRSQU1DbG9ja0NoYW5nZVdhdGVybWFyayA+Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkbWxfbWF4KG1vZGVfbGliLT52YmEuU3R1dHRlckVu
dGVyUGx1c0V4aXRXYXRlcm1hcmssCj4gbW9kZV9saWItPnZiYS5VcmdlbnRXYXRlcm1hcmspKQo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG1vZGVfbGliLT52YmEuTWluVFRVVkJsYW5rW2tdICs9IDI1Owo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1vZGVfbGliLT52YmEuUHJl
ZmV0Y2hNb2RlW21vZGVfbGliLQo+ID52YmEuVm9sdGFnZUxldmVsXVttb2RlX2xpYi0+dmJhLm1h
eE1wY0NvbWJdID09IDApIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobW9kZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFu
Z2VXYXRlcm1hcmsgPgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRtbF9tYXgobW9kZV9saWItCj4gPnZiYS5TdHV0dGVyRW50
ZXJQbHVzRXhpdFdhdGVybWFyaywgbW9kZV9saWItPnZiYS5VcmdlbnRXYXRlcm1hcmspKQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBtb2RlX2xpYi0+dmJhLk1pblRUVVZCbGFua1trXSArPSAyNTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbW9kZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VTdXBwb3J0WzBdWzBdID0K
PiBkbV9kcmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlOwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
