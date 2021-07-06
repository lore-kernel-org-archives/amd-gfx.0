Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79765C07E9C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4828B61C2C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4828B61C2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F5189FD3;
	Tue,  6 Jul 2021 11:14:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E0489FC9;
 Tue,  6 Jul 2021 11:14:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 805CC61C2B;
 Tue,  6 Jul 2021 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570072;
 bh=IbCVzeuJXy3t6zSTtGkGuC7n1zlfIHMOhE3M6l9qxQQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gHEDdIHv/z8TSJ3eTDRQ6nWo9eY5QxGhVIx3g1FOdqLaLfiAm67sp2Em8YLyV9UkC
 oWwbNGj2t+nUlc9hVHybF5eHIKaEXetK6XtIPi9b296C3b2nJk3oQnCmy2ncnNk2T6
 xCMf3F/8tWEC1rgg3mVw5PJHNpe/E8nAAL1SPtArmq4MqgAs487iWdkTfEopMFjIg/
 EcRGSVtu2oU7FOfOAtvat0hL2Un7prxGi4Pu0sCXwquG712YC4xMk0r8xh0alz2GB8
 cRB27oazgFj/dWjya1VaDcEBcwHtmM9dRIt8JtvbURERqYIw6HeMdIIwtuIqJcFrUn
 R7XzmvdKEpmGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 015/189] drm/amdgpu: change the default timeout
 for kernel compute queues
Date: Tue,  6 Jul 2021 07:11:15 -0400
Message-Id: <20210706111409.2058071-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKWyBVcHN0cmVh
bSBjb21taXQgNjczODdkZmUwZjY2MzBmMmQ0ZjQxMmNlNzdkZWJlYzIzYTQ5ZGI3YSBdCgpDaGFu
Z2UgdG8gNjBzLiAgVGhpcyBtYXRjaGVzIHdoYXQgd2UgYWxyZWFkeSBkbyBpbiB2aXJ0dWFsaXph
dGlvbi4KSW5maW5pdGUgdGltZW91dCBjYW4gbGVhZCB0byBkZWFkbG9ja3MgaW4gdGhlIGtlcm5l
bC4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkFja2VkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA4ICsrKy0tLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgICAgfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBmMDA4ZjAwMTk1MWIuLmQ4M2YyZWUxNTBiOCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzE4MSw4
ICszMTgxLDggQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2dldF9qb2JfdGltZW91dF9zZXR0
aW5ncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpbnQgcmV0ID0gMDsKIAogCS8qCi0J
ICogQnkgZGVmYXVsdCB0aW1lb3V0IGZvciBub24gY29tcHV0ZSBqb2JzIGlzIDEwMDAwLgotCSAq
IEFuZCB0aGVyZSBpcyBubyB0aW1lb3V0IGVuZm9yY2VkIG9uIGNvbXB1dGUgam9icy4KKwkgKiBC
eSBkZWZhdWx0IHRpbWVvdXQgZm9yIG5vbiBjb21wdXRlIGpvYnMgaXMgMTAwMDAKKwkgKiBhbmQg
NjAwMDAgZm9yIGNvbXB1dGUgam9icy4KIAkgKiBJbiBTUi1JT1Ygb3IgcGFzc3Rocm91Z2ggbW9k
ZSwgdGltZW91dCBmb3IgY29tcHV0ZQogCSAqIGpvYnMgYXJlIDYwMDAwIGJ5IGRlZmF1bHQuCiAJ
ICovCkBAIC0zMTkxLDEwICszMTkxLDggQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2dldF9q
b2JfdGltZW91dF9zZXR0aW5ncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKQogCQlhZGV2LT5jb21wdXRlX3RpbWVvdXQgPSBhbWRncHVfc3Jp
b3ZfaXNfcHBfb25lX3ZmKGFkZXYpID8KIAkJCQkJbXNlY3NfdG9famlmZmllcyg2MDAwMCkgOiBt
c2Vjc190b19qaWZmaWVzKDEwMDAwKTsKLQllbHNlIGlmIChhbWRncHVfcGFzc3Rocm91Z2goYWRl
dikpCi0JCWFkZXYtPmNvbXB1dGVfdGltZW91dCA9ICBtc2Vjc190b19qaWZmaWVzKDYwMDAwKTsK
IAllbHNlCi0JCWFkZXYtPmNvbXB1dGVfdGltZW91dCA9IE1BWF9TQ0hFRFVMRV9USU1FT1VUOwor
CQlhZGV2LT5jb21wdXRlX3RpbWVvdXQgPSAgbXNlY3NfdG9famlmZmllcyg2MDAwMCk7CiAKIAlp
ZiAoc3RybmxlbihpbnB1dCwgQU1ER1BVX01BWF9USU1FT1VUX1BBUkFNX0xFTkdUSCkpIHsKIAkJ
d2hpbGUgKCh0aW1lb3V0X3NldHRpbmcgPSBzdHJzZXAoJmlucHV0LCAiLCIpKSAmJgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmluZGV4IGY5Mzg4M2RiMmI0Ni4uNTdhMDU1
YWE4NTRkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCkBAIC0yODcs
OSArMjg3LDkgQEAgbW9kdWxlX3BhcmFtX25hbWVkKG1zaSwgYW1kZ3B1X21zaSwgaW50LCAwNDQ0
KTsKICAqICAgZm9yIFNETUEgYW5kIFZpZGVvLgogICoKICAqIEJ5IGRlZmF1bHQod2l0aCBubyBs
b2NrdXBfdGltZW91dCBzZXR0aW5ncyksIHRoZSB0aW1lb3V0IGZvciBhbGwgbm9uLWNvbXB1dGUo
R0ZYLCBTRE1BIGFuZCBWaWRlbykKLSAqIGpvYnMgaXMgMTAwMDAuIEFuZCB0aGVyZSBpcyBubyB0
aW1lb3V0IGVuZm9yY2VkIG9uIGNvbXB1dGUgam9icy4KKyAqIGpvYnMgaXMgMTAwMDAuIFRoZSB0
aW1lb3V0IGZvciBjb21wdXRlIGlzIDYwMDAwLgogICovCi1NT0RVTEVfUEFSTV9ERVNDKGxvY2t1
cF90aW1lb3V0LCAiR1BVIGxvY2t1cCB0aW1lb3V0IGluIG1zIChkZWZhdWx0OiBmb3IgYmFyZSBt
ZXRhbCAxMDAwMCBmb3Igbm9uLWNvbXB1dGUgam9icyBhbmQgaW5maW5pdHkgdGltZW91dCBmb3Ig
Y29tcHV0ZSBqb2JzOyAiCitNT0RVTEVfUEFSTV9ERVNDKGxvY2t1cF90aW1lb3V0LCAiR1BVIGxv
Y2t1cCB0aW1lb3V0IGluIG1zIChkZWZhdWx0OiBmb3IgYmFyZSBtZXRhbCAxMDAwMCBmb3Igbm9u
LWNvbXB1dGUgam9icyBhbmQgNjAwMDAgZm9yIGNvbXB1dGUgam9iczsgIgogCQkiZm9yIHBhc3N0
aHJvdWdoIG9yIHNyaW92LCAxMDAwMCBmb3IgYWxsIGpvYnMuIgogCQkiIDA6IGtlZXAgZGVmYXVs
dCB2YWx1ZS4gbmVnYXRpdmU6IGluZmluaXR5IHRpbWVvdXQpLCAiCiAJCSJmb3JtYXQ6IGZvciBi
YXJlIG1ldGFsIFtOb24tQ29tcHV0ZV0gb3IgW0dGWCxDb21wdXRlLFNETUEsVmlkZW9dOyAiCi0t
IAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
