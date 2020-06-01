Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F9A2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euHkRx8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F9A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686E96E354;
	Mon,  1 Jun 2020 18:22:30 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A016E354
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:28 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id j32so8460222qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WoQyAtH1vXfF7fnjKMhzQGxZauXjRphu0d1tFhATdmk=;
 b=euHkRx8dhRg1ZaYb95fCWMmFCblw7vBVRLBsgaRlSV3GxUqWVsAEfawa/Q9ZMoM40n
 ylU7Yxlno8rPi2L6KtTEaftkye5BtGcB25OJGEtjzoDmCkCy9xyCR4Vy2eKymhik5tA4
 NQ/ZI37nX59Hf0piCjZOgyduIOjlQMYKRHMsfWxaew/DulCE8p3Sj1Jzx7O/9re6lgGv
 Os36x4whvZVeViNQZjHkzF/XK533UCzOcMsuukKwoY1S9RRE660aIOUWdfG1d/4CIWDe
 qUG0jyFhAiqMCKxJ1mBrXFeBoI366egaruDq9I4YdZtAgc9/Jx1/vLFJBdxAYOt7F8pI
 a/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WoQyAtH1vXfF7fnjKMhzQGxZauXjRphu0d1tFhATdmk=;
 b=DfQv9yp8uT7poWkKSEN47EQVE1yE8m71yR40DID2rFREhdNyTRiDwBpQGsQNBb5I15
 X63ZVRrCP5VsX0pdP2npvdx8IsJCGAxFaHL3ySlckzglE8qCM1gdn+98YnQz2eAL34Wc
 /nq89KeKc6P4z0IaR2+iRULEVhdE10jl1apj6xvEcPX4I9tJIGUxxrW8oIh6lljjJQsy
 yUQT/B2/PQHsL3+WxhuqlF5xERaYxdKmVGacoiRmmtcBZqKnVLbE1ImTQ7Tl7IaaU3i3
 AysAW25NK7EXQP336DWbHMvLj+i4JvMoYY+rJq5GlweTkiuBxg7pp3FMWcjHR9Ays86/
 nJVA==
X-Gm-Message-State: AOAM532JaRmZJqIytPGTEjfBnHQNhlOHXtDsi40l2EwxskXIGikdNp5J
 ++3d+Ag3nWtR5bD4ICZFS3E38tXM
X-Google-Smtp-Source: ABdhPJwavWrJ13ipyQUUfy60ncSPelhbP32971qIcFoSlIZFX6umAP76sYET59aNrcH+vxP1fXdvWg==
X-Received: by 2002:ac8:2dea:: with SMTP id q39mr23517611qta.2.1591035747620; 
 Mon, 01 Jun 2020 11:22:27 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 154/207] drm/amdgpu/sriov : Use kiq to do tlb invalidation for
 gfx10 on sriov
Date: Mon,  1 Jun 2020 14:20:01 -0400
Message-Id: <20200601182054.1267858-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogc2hhb3l1bmwgPHNoYW95dW4ubGl1QGFtZC5jb20+CgpPbiBTUklPViBydW4gdGltZSwg
ZHJpdmVyIHNob3VsZG4ndCBkaXJlY3RseSBhY2Nlc3MgaW52YWxpZGF0aW9uIHJlZ2lzdGVycyB0
aHJvdWdoIE1NSU8uClVzZSBraXEgdG8gc3VibWl0IHdhaXRfcmVnX21lbSBwYWNrYWdlIGZvciB0
aGUgaW52YWxpZGF0aW9uCgpTaWduZWQtb2ZmLWJ5OiBzaGFveXVubCA8c2hhb3l1bi5saXVAYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgIDMgKysr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDE4ICsrKysrKysrKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCA4OTM1YjliODFkNjguLmYwOTU1YjMyNTc5OCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTM0ODAsNiArMzQ4MCw5
IEBAIHN0YXRpYyB2b2lkIGdmeF92MTBfMF9jaGVja19md193cml0ZV93YWl0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCQkgICAgKGFkZXYtPmdmeC5tZWNfZmVhdHVyZV92ZXJzaW9uID49
IDI3KSkKIAkJCWFkZXYtPmdmeC5jcF9md193cml0ZV93YWl0ID0gdHJ1ZTsKIAkJYnJlYWs7CisJ
Y2FzZSBDSElQX1NJRU5OQV9DSUNITElEOgorCQlhZGV2LT5nZnguY3BfZndfd3JpdGVfd2FpdCA9
IHRydWU7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCWJyZWFrOwogCX0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMKaW5kZXggY2UyZjcyNDMwNDAzLi4wNjE5MDBlOGFmZDMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCkBAIC0zNTAsNiArMzUwLDI0IEBA
IHN0YXRpYyB2b2lkIGdtY192MTBfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCB1aW50MzJfdCB2bWlkLAogCS8qIGZsdXNoIGhkcCBjYWNoZSAqLwogCWFkZXYtPm5i
aW8uZnVuY3MtPmhkcF9mbHVzaChhZGV2LCBOVUxMKTsKIAorCS8qIEZvciBTUklPViBydW4gdGlt
ZSwgZHJpdmVyIHNob3VsZG4ndCBhY2Nlc3MgdGhlIHJlZ2lzdGVyIHRocm91Z2ggTU1JTworCSAq
IERpcmVjdGx5IHVzZSBraXEgdG8gZG8gdGhlIHZtIGludmFsaWRhdGlvbiBpbnN0ZWFkCisJICov
CisJaWYgKGFkZXYtPmdmeC5raXEucmluZy5zY2hlZC5yZWFkeSAmJgorCSAgICAoYW1kZ3B1X3Ny
aW92X3J1bnRpbWUoYWRldikgfHwgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgJiYKKwkgICAgIWFk
ZXYtPmluX2dwdV9yZXNldCkgeworCisJCXN0cnVjdCBhbWRncHVfdm1odWIgKmh1YiA9ICZhZGV2
LT52bWh1Ylt2bWh1Yl07CisJCWNvbnN0IHVuc2lnbmVkIGVuZyA9IDE3OworCQl1MzIgaW52X3Jl
cSA9IGdtY192MTBfMF9nZXRfaW52YWxpZGF0ZV9yZXEodm1pZCwgZmx1c2hfdHlwZSk7CisJCXUz
MiByZXEgPSBodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZzsKKwkJdTMyIGFjayA9IGh1Yi0+dm1f
aW52X2VuZzBfYWNrICsgZW5nOworCisJCWFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dh
aXQoYWRldiwgcmVxLCBhY2ssIGludl9yZXEsCisJCQkJMSA8PCB2bWlkKTsKKwkJcmV0dXJuOwor
CX0KKwogCW11dGV4X2xvY2soJmFkZXYtPm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsKIAogCWlmICh2
bWh1YiA9PSBBTURHUFVfTU1IVUJfMCkgewotLSAKMi4yNS40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
