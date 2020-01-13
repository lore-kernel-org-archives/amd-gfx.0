Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD044C33CAE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B3520678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY/31HPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B3520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E970F6E0DE;
	Mon, 13 Jan 2020 14:41:00 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE476E0D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 14:40:59 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b6so8856015wrq.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R3fSzdbt1cDYaiK2OUJNHINaVy9gKx6uKwT8+y2OlOY=;
 b=GY/31HPEc1l0Tl9ft9aRUvr4CxAc977V+U1FuWOoBC+XieqwfNarD94U84TSQKiQ4B
 6ShPGQ4tyq7Ha6U4G+qaC1rmD5HpaiRaybw0V4fGNneN+fVqPKqLB1zQY9rEcTEhAQOU
 pUbrqxt15+uMijsFNe0foKDAUCrGx2RR9Z4rhFmDCwkKK0Gg60J+aCHh95XhBVjYSpMb
 pA8CdN/oDY6upqW7uw5vzJzqyn/zrvMDlfqmj7wEecJTLsHkU8C2d/E1mnh4hZdrR436
 xK7zcvCetbrjHZXHoMAbtIXrrShCdxcspb0koWCae85IwzAgHuYKeO15CWmtyRiwJdHO
 l4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R3fSzdbt1cDYaiK2OUJNHINaVy9gKx6uKwT8+y2OlOY=;
 b=FFNdpn9E28YZPvBIb/4baoBgKtV7G/kZe+/h+t0FODo/X8AzqJGOfyfYAhXhcpsvz6
 BN1iftnG1jg7MZ9xSazgUNXhAk88ieQcvn6bB3xHxgXY6mtjf0lQzyfu5EmGaHekvNHg
 QGYrmY/VdQQywC4k/48rQSfvtKzpqjFVin4IB1UOAHSypS2hLhzrDsa03KOCD/HUvWqm
 u8QeBIVb5gA+C49IHBpZ5pMNPFpt39VRETCp77rmvE65NZjxW9+W0rhlxWMB4YUzU8UU
 aRODF/l2L5qcb6mCmCpxIBhwkHG9R6gw3mzRb7W9D9rdmIyEsO7KviHmw2rsHfYFzRHL
 dkwQ==
X-Gm-Message-State: APjAAAWiK4WqBmbK334V5PiWe7uwPbxioiB740bo2GJZD3hhwd4fSCN/
 VVzjLVOzMi6wDFZzyAcHki+In+5V
X-Google-Smtp-Source: APXvYqwmdCEdiGMu3bnmOvo/D464TabNWPktiNLfiMN+ywtEs2w5LSjU47WveKysmdvEqexsRqg0cg==
X-Received: by 2002:adf:db41:: with SMTP id f1mr19350997wrj.392.1578926457705; 
 Mon, 13 Jan 2020 06:40:57 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd29:349f:9f33:2a26])
 by smtp.gmail.com with ESMTPSA id m10sm15347802wrx.19.2020.01.13.06.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:40:57 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 2/8] drm/amdgpu: explicitly sync VM update to PDs/PTs
Date: Mon, 13 Jan 2020 15:40:49 +0100
Message-Id: <20200113144055.3416-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113144055.3416-1-christian.koenig@amd.com>
References: <20200113144055.3416-1-christian.koenig@amd.com>
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

RXhwbGljaXRseSBzeW5jIFZNIHVwZGF0ZXMgdG8gdGhlIG1vdmluZyBmZW5jZSBpbiBQRHMgYW5k
IFBUcy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMg
IHwgNyArKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5j
IHwgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jCmluZGV4IDczZmVjN2EwY2VkNS4uNjhi
MDEzYmUzODM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm1fY3B1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5j
CkBAIC04Niw2ICs4NiwxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9jcHVfdXBkYXRlKHN0cnVj
dCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKIHsKIAl1bnNpZ25lZCBpbnQgaTsKIAl1aW50
NjRfdCB2YWx1ZTsKKwlpbnQgcjsKKworCWlmIChiby0+dGJvLm1vdmluZykgeworCQlyID0gZG1h
X2ZlbmNlX3dhaXQoYm8tPnRiby5tb3ZpbmcsIHRydWUpOworCQlpZiAocikKKwkJCXJldHVybiBy
OworCX0KIAogCXBlICs9ICh1bnNpZ25lZCBsb25nKWFtZGdwdV9ib19rcHRyKGJvKTsKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKaW5kZXggMTliN2Y4MDc1
OGYxLi40YmJkOGZmNzc4ZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bV9zZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtX3NkbWEuYwpAQCAtMjA4LDYgKzIwOCwxMSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9zZG1h
X3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCiAJdWludDY0X3QgKnB0
ZTsKIAlpbnQgcjsKIAorCS8qIFdhaXQgZm9yIFBEL1BUIG1vdmVzIHRvIGJlIGNvbXBsZXRlZCAq
LworCXIgPSBhbWRncHVfc3luY19mZW5jZSgmcC0+am9iLT5zeW5jLCBiby0+dGJvLm1vdmluZywg
ZmFsc2UpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKwogCWRvIHsKIAkJbmR3ID0gcC0+bnVtX2R3
X2xlZnQ7CiAJCW5kdyAtPSBwLT5qb2ItPmlicy0+bGVuZ3RoX2R3OwotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
