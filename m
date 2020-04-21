Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CDC54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 14:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E7A20663
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+gw5nc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E7A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0626E094;
	Tue, 21 Apr 2020 14:22:41 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1D16E094
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 14:22:39 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id u127so3905525wmg.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z5ul8vWxvy4b754IS8xlhcdOcU5WaUZ8VmKj4CYx3uc=;
 b=L+gw5nc2ms+uy1vlBFwCLP4msAxp9NHrPuTqRPkUQAcJ7Uu3xnwXD0aVz4f+Cr2Jhi
 S7gHv1V7s5FHR4DASK62Axa+Rea/6QwYETfJaiELbYa3vlYObmSle7aD3JERuiXBxO60
 /j3rYA+S0OZH536a5HoJbmg9nLNs8XykzVnd4eNxBEg1KRXXM5dg/2+3Hc1vBdbus6Dr
 Du+TvhmTSpZOvZKRo7f3msUnZC7IX8/AImFsUJjYgdEdBjJXLPTTF2wjXjOd3kW/uY34
 5yMcctz1TLAjlskqgedBzS9Tdn8UqT69tZHhEvwVQbVqzjXttqOeFOS6oOcwFnQTiJw+
 7XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z5ul8vWxvy4b754IS8xlhcdOcU5WaUZ8VmKj4CYx3uc=;
 b=Ezx1FafvEh8a38dNIUbiJasYdhTSXPR81RAWlix/KUXaDrenqSNuCVo1akzDXHNgLh
 olp1EMnkC2QNCT/AlqFzxn9Svqw2dj0q5T6fmAL7hCZfQTvoZ0+jYcGFhofI/DVhi7Pu
 aGf0oB+p/6idhO5pAiymMvKgqtHlNkYHnRjbWybuoyT+Ik1Mv/2ddr4wiVz0eZUqt9Vp
 vO4z9nJ7MMErJy9IF8XHbn4TtTNDowXZ3hMlJuv6Dc+Ea9thi1OWTdzw1i3VBc64I/Ca
 tsasYhsfyc4V9R4F44fT8Guo2zUj/BrdmKjlm5Yiks4btpAj3OES1hoDVEn8MllzsC+T
 fFeA==
X-Gm-Message-State: AGi0PuY2eMq4Wa/byCUcFgtYmSAnO50vBelAJ+B7bq0lWYcrLG9MjgA6
 CXwNWsn5hurm8VzsSxrbtO4N9A81
X-Google-Smtp-Source: APiQypL9AMvKXsODcYC+0BBVnQEk99T767O/S8q5qe30OT2ZRskZUjUGPd7BKL0t2usgtcP1MPJx9g==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr5475877wmi.50.1587478958306; 
 Tue, 21 Apr 2020 07:22:38 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7833:1411:6069:2e5b])
 by smtp.gmail.com with ESMTPSA id t2sm3844425wmt.15.2020.04.21.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 07:22:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Monk.Liu@amd.com, Jacob.He@amd.com, Yintian.Tao@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: change how we update mmRLC_SPM_MC_CNTL
Date: Tue, 21 Apr 2020 16:22:36 +0200
Message-Id: <20200421142236.41131-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gcHBfb25lX3ZmIG1vZGUgYXZvaWQgdGhlIGV4dHJhIG92ZXJoZWFkIGFuZCByZWFkL3dyaXRl
IHRoZQpyZWdpc3RlcnMgd2l0aG91dCB0aGUgS0lRLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMTMgKysrKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyAgfCAxMCArKysrKysrKy0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jICB8IDEzICsrKysrKysrKystLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jCmluZGV4IDBhMDNlMmFkNWQ5NS4uNTYwZWMxYzI5OTc3IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtNzAzMCwxNCArNzAzMCwyMSBAQCBz
dGF0aWMgaW50IGdmeF92MTBfMF91cGRhdGVfZ2Z4X2Nsb2NrX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAogc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3VwZGF0ZV9zcG1fdm1pZChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkKIHsKLQl1MzIgZGF0YTsK
Kwl1MzIgcmVnLCBkYXRhOwogCi0JZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BN
X01DX0NOVEwpOworCXJlZyA9IFNPQzE1X1JFR19PRkZTRVQoR0MsIDAsIG1tUkxDX1NQTV9NQ19D
TlRMKTsKKwlpZiAoYW1kZ3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2KSkKKwkJZGF0YSA9IFJS
RUczMl9OT19LSVEocmVnKTsKKwllbHNlCisJCWRhdGEgPSBSUkVHMzIocmVnKTsKIAogCWRhdGEg
Jj0gflJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0s7CiAJZGF0YSB8PSAodm1pZCAm
IFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fTUNfQ05UTF9f
UkxDX1NQTV9WTUlEX19TSElGVDsKIAotCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01D
X0NOVEwsIGRhdGEpOworCWlmIChhbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQorCQlX
UkVHMzJfU09DMTVfTk9fS0lRKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCwgZGF0YSk7CisJZWxz
ZQorCQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsKIH0KIAog
c3RhdGljIGJvb2wgZ2Z4X3YxMF8wX2NoZWNrX3JsY2dfcmFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwppbmRleCBmYzZjMmYy
YmM3NmMuLmE5YmNjMDBmNDM0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5j
CkBAIC01NjE1LDEyICs1NjE1LDE4IEBAIHN0YXRpYyB2b2lkIGdmeF92OF8wX3VwZGF0ZV9zcG1f
dm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkKIHsKIAl1MzIg
ZGF0YTsKIAotCWRhdGEgPSBSUkVHMzIobW1STENfU1BNX1ZNSUQpOworCWlmIChhbWRncHVfc3Jp
b3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQorCQlkYXRhID0gUlJFRzMyX05PX0tJUShtbVJMQ19TUE1f
Vk1JRCk7CisJZWxzZQorCQlkYXRhID0gUlJFRzMyKG1tUkxDX1NQTV9WTUlEKTsKIAogCWRhdGEg
Jj0gflJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX01BU0s7CiAJZGF0YSB8PSAodm1pZCAmIFJM
Q19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fVk1JRF9fUkxDX1NQTV9W
TUlEX19TSElGVDsKIAotCVdSRUczMihtbVJMQ19TUE1fVk1JRCwgZGF0YSk7CisJaWYgKGFtZGdw
dV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikpCisJCVdSRUczMl9OT19LSVEobW1STENfU1BNX1ZN
SUQsIGRhdGEpOworCWVsc2UKKwkJV1JFRzMyKG1tUkxDX1NQTV9WTUlELCBkYXRhKTsKIH0KIAog
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmxjX2Z1bmNzIGljZWxhbmRfcmxjX2Z1bmNzID0g
ewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggNTRlZGVkOWE2YWM1Li5j
N2RlMTA4NjljODEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtNDk1
MCwxNCArNDk1MCwyMSBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3VwZGF0ZV9nZnhfY2xvY2tfZ2F0
aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiBzdGF0aWMgdm9pZCBnZnhfdjlfMF91
cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIHZtaWQp
CiB7Ci0JdTMyIGRhdGE7CisJdTMyIHJlZywgZGF0YTsKIAotCWRhdGEgPSBSUkVHMzJfU09DMTUo
R0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMKTsKKwlyZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAw
LCBtbVJMQ19TUE1fTUNfQ05UTCk7CisJaWYgKGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRl
dikpCisJCWRhdGEgPSBSUkVHMzJfTk9fS0lRKHJlZyk7CisJZWxzZQorCQlkYXRhID0gUlJFRzMy
KHJlZyk7CiAKIAlkYXRhICY9IH5STENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLOwog
CWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBS
TENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7CiAKLQlXUkVHMzJfU09DMTUoR0Ms
IDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsKKwlpZiAoYW1kZ3B1X3NyaW92X2lzX3BwX29u
ZV92ZihhZGV2KSkKKwkJV1JFRzMyX1NPQzE1X05PX0tJUShHQywgMCwgbW1STENfU1BNX01DX0NO
VEwsIGRhdGEpOworCWVsc2UKKwkJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05U
TCwgZGF0YSk7CiB9CiAKIHN0YXRpYyBib29sIGdmeF92OV8wX2NoZWNrX3JsY2dfcmFuZ2Uoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
