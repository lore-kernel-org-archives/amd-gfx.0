Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECEC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E35C2089D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0QMjTcHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E35C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADCA6E9BE;
	Mon,  8 Jun 2020 23:21:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725BF6E9BE;
 Mon,  8 Jun 2020 23:21:48 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91D7120872;
 Mon,  8 Jun 2020 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658508;
 bh=tL/acNf1vHtTAwCq0RaBlHXUprEJKc6+sPNDpB+oLs4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0QMjTcHNlMz/TSom2mL1W4o5WXs3gwyHs+AYBDQVMLINBbB5Px3Ip0tl52vank/XO
 G9R2uY6CazapOJz91wpmV82ZLDc2v/3o7RP53Dul3f8Pyjb3GiVuZApTURoT70jiwo
 yYb1hSdQ8wRpbGfCkjxZ7Lhdqo7j4VILldJIcpt0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 138/175] drm/amd/powerpay: Disable gfxoff when
 setting manual mode on picasso and raven
Date: Mon,  8 Jun 2020 19:18:11 -0400
Message-Id: <20200608231848.3366970-138-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogY2hlbiBnb25nIDxjdXJyeS5nb25nQGFtZC5jb20+CgpbIFVwc3RyZWFtIGNvbW1pdCBj
YmQyZDA4Yzc0NjNlNzhkNjI1YTY5ZTlkYjI3YWQzMDA0Y2JiZDk5IF0KCltQcm9ibGVtIGRlc2Ny
aXB0aW9uXQoxLiBCb290IHVwIHBpY2Fzc28gcGxhdGZvcm0sIGxhdW5jaGVzIGRlc2t0b3AsIERv
bid0IGRvIGFueXRoaW5nIChBUFUgZW50ZXIgaW50byAiZ2Z4b2ZmIiBzdGF0ZSkKMi4gUmVtb3Rl
IGxvZ2luIHRvIHBsYXRmb3JtIHVzaW5nIFNTSCwgdGhlbiB0eXBlIHRoZSBjb21tYW5kIGxpbmU6
CglzdWRvIHN1IC1jICJlY2hvIG1hbnVhbCA+IC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9w
b3dlcl9kcG1fZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwiCglzdWRvIHN1IC1jICJlY2hvIDIgPiAv
c3lzL2NsYXNzL2RybS9jYXJkMC9kZXZpY2UvcHBfZHBtX3NjbGsiIChmaXggU0NMSyB0byAxNDAw
TUh6KQozLiBNb3ZlIHRoZSBtb3VzZSBhcm91bmQgaW4gV2luZG93CjQuIFBoZW5vbWVub24gOiAg
VGhlIHNjcmVlbiBmcm96ZW4KClRlc3RlciB3aWxsIHN3aXRjaCBzY2xrIGxldmVsIGR1cmluZyBn
bG1hcmsyIHJ1biB0aW1lLgpBUFUgd2lsbCBlbnRlciAiZ2Z4b2ZmIiBzdGF0ZSBpbnRlcm1pdHRl
bnRseSBkdXJpbmcgZ2xtYXJrMiBydW4gdGltZS4KVGhlIHN5c3RlbSBnb3QgaGFuZ2VkIGlmIGZp
eCBHRlhDTEsgdG8gMTQwME1IeiB3aGVuIEFQVSBpcyBpbiAiZ2Z4b2ZmIgpzdGF0ZS4KCltEZWJ1
Z10KMS4gRml4IFNDTEsgdG8gWCBNSHoKCTE0MDA6IHNjcmVlbiBmcm96ZW4sIHNjcmVlbiBibGFj
aywgdGhlbiBPUyB3aWxsIHJlYm9vdC4KCTEzMDA6IHNjcmVlbiBmcm96ZW4uCgkxMjAwOiBzY3Jl
ZW4gZnJvemVuLCBzY3JlZW4gYmxhY2suCgkxMTAwOiBzY3JlZW4gZnJvemVuLCBzY3JlZW4gYmxh
Y2ssIHRoZW4gT1Mgd2lsbCByZWJvb3QuCgkxMDAwOiBzY3JlZW4gZnJvemVuLCBzY3JlZW4gYmxh
Y2suCgk5MDA6ICBzY3JlZW4gZnJvemVuLCBzY3JlZW4gYmxhY2ssIHRoZW4gT1Mgd2lsbCByZWJv
b3QuCgk4MDA6ICBTaXR1YXRpb24gTm9tYWwsIGlzc3VlIGRpc2FwcGVhci4KCTcwMDogIFNpdHVh
dGlvbiBOb21hbCwgaXNzdWUgZGlzYXBwZWFyLgoyLiBTQklPUyBzZXR0aW5nOiBBTUQgQ0JTIC0t
PiBTTVUgRGVidWcgT3B0aW9ucyAtLT5TTVUgRGVidWcgLS0+ICJHRlggRExETyBQc20gTWFyZ2lu
IENvbnRyb2wiOgoJNTAgOiBTaXR1YXRpb24gTm9tYWwsIGlzc3VlIGRpc2FwcGVhci4KCTQ1IDog
U2l0dWF0aW9uIE5vbWFsLCBpc3N1ZSBkaXNhcHBlYXIuCgk0MCA6IFNpdHVhdGlvbiBOb21hbCwg
aXNzdWUgZGlzYXBwZWFyLgoJMzUgOiBTaXR1YXRpb24gTm9tYWwsIGlzc3VlIGRpc2FwcGVhci4K
CTMwIDogc2NyZWVuIGJsYWNrLgoJMjUgOiBzY3JlZW4gZnJvemVuLCB0aGVuIGJsdXJyZWQgc2Ny
ZWVuLgoJMjAgOiBzY3JlZW4gZnJvemVuLgoJMTUgOiBzY3JlZW4gYmxhY2suCgkxMCA6IHNjcmVl
biBmcm96ZW4uCgk1ICA6IHNjcmVlbiBmcm96ZW4sIHRoZW4gYmx1cnJlZCBzY3JlZW4uCjMuIERp
c2FibGUgR0ZYT0ZGIGZlYXR1cmUKCVNpdHVhdGlvbiBOb21hbCwgaXNzdWUgZGlzYXBwZWFyLgoK
W1doeV0KVGhyb3VnaCBhIHBlcmlvZCBvZiB0aW1lIGRlYnVnZ2luZyB3aXRoIFN5cyBFbmcgdGVh
bSBhbmQgU01VIHRlYW0sIFN5cwpFbmcgdGVhbSBzYWlkIHRoaXMgaXMgdm9sdGFnZS9mcmVxdWVu
Y3kgbWFyZ2luYWwgaXNzdWUgbm90IGEgRi9XIG9yIEgvVwpidWcuIFRoaXMgZXhwZXJpbWVudCBw
cm92ZXMgdGhhdCBkZWZhdWx0IHRhcmdldFBzbSBbZm9yIGY9MTQwME1Iel0gaXMKbm90IHN1ZmZp
Y2llbnQgd2hlbiBHRlhPRkYgaXMgZW5hYmxlZCBvbiBQaWNhc3NvLgoKU01VIHRlYW0gdGhpbmsg
aXQgaXMgYW4gb2RkIHRlc3QgY29uZGl0aW9ucyB0byBmb3JjZSBzY2xrPSIxNDAwTUh6IiB3aGVu
CkdQVSBpcyBpbiAiZ2Z4b2ZmIiBzdGF0Ze+8jHRoZW4gd2FrZSB1cCB0aGUgR0ZYLiBTQ0xLIHNo
b3VsZCBiZSBpbiB0aGUKImxvd2VzdCBmcmVxdWVuY3kiIHdoZW4gZ2Z4b2ZmLgoKW0hvd10KRGlz
YWJsZSBnZnhvZmYgd2hlbiBzZXR0aW5nIG1hbnVhbCBtb2RlLgpFbmFibGUgZ2Z4b2ZmIHdoZW4g
c2V0dGluZyBvdGhlciBtb2RlKGV4aXRpbmcgbWFudWFsIG1vZGUpIGFnYWluLgoKQnkgdGhlIHdh
eSwgZnJvbSB0aGUgdXNlciBwb2ludCBvZiB2aWV3LCBub3cgdGhhdCB1c2VyIHN3aXRjaCB0byBt
YW51YWwKbW9kZSBhbmQgZm9yY2UgU0NMSyBGcmVxdWVuY3ksIGhlIGRvbid0IHdhbnQgU0NMSyBi
ZSBjb250cm9sbGVkIGJ5Cndvcmtsb2FkLkl0IGJlY29tZXMgbWVhbmluZ2xlc3MgdG8gInN3aXRj
aCB0byBtYW51YWwgbW9kZSIgaWYgQVBVIGVudGVyICJnZnhvZmYiCmR1ZSB0byBsYWNrIG9mIHdv
cmtsb2FkIGF0IHRoaXMgcG9pbnQuCgpUaXBzOiBTYW1lIGlzc3VlIG9ic2VydmVkIG9uIFJhdmVu
LgoKU2lnbmVkLW9mZi1ieTogY2hlbiBnb25nIDxjdXJyeS5nb25nQGFtZC5jb20+ClJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wbS5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCmluZGV4IGM4
MDA4Yjk1NjM2My4uZDFkMjM3MmFiN2NhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcG0uYwpAQCAtMzcwLDYgKzM3MCwxNSBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfc2V0X2Rw
bV9mb3JjZWRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0IGRldmljZSAqZGV2LAogCWlmIChjdXJy
ZW50X2xldmVsID09IGxldmVsKQogCQlyZXR1cm4gY291bnQ7CiAKKwlpZiAoYWRldi0+YXNpY190
eXBlID09IENISVBfUkFWRU4pIHsKKwkJaWYgKGFkZXYtPnJldl9pZCA8IDgpIHsKKwkJCWlmIChj
dXJyZW50X2xldmVsICE9IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX01BTlVBTCAmJiBsZXZlbCA9PSBB
TURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUwpCisJCQkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2
LCBmYWxzZSk7CisJCQllbHNlIGlmIChjdXJyZW50X2xldmVsID09IEFNRF9EUE1fRk9SQ0VEX0xF
VkVMX01BTlVBTCAmJiBsZXZlbCAhPSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUwpCisJCQkJ
YW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsKKwkJfQorCX0KKwogCS8qIHByb2ZpbGVf
ZXhpdCBzZXR0aW5nIGlzIHZhbGlkIG9ubHkgd2hlbiBjdXJyZW50IG1vZGUgaXMgaW4gcHJvZmls
ZSBtb2RlICovCiAJaWYgKCEoY3VycmVudF9sZXZlbCAmIChBTURfRFBNX0ZPUkNFRF9MRVZFTF9Q
Uk9GSUxFX1NUQU5EQVJEIHwKIAkgICAgQU1EX0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9NSU5f
U0NMSyB8Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
