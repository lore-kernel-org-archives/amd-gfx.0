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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C228C33CAF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CA720678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuGV4GY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CA720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A686E0D8;
	Mon, 13 Jan 2020 14:41:02 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D967D6E0D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 14:40:59 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t14so9920029wmi.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+uptDv3y8tSXuln43+mg3NZsB+UqXPgfucNzBDBXods=;
 b=KuGV4GY/hHe9VVHcsGPaxtRFfEQcxKVWBhrES6j1qKnl8BMzeFTgcLNPToDpkAo00Y
 zqitnrL5HbSsfpGW+o69vWODn0CovmaxwPF4r4sLoeZefYsVcrOgQrsOCbqfhIZzS2EJ
 ykotEy3zkDHnA+Qw8ifmQt8Zby31bSWNfBvTrshqfRMD2KGCI2B9eNLxAW2tllv8QV5M
 Btf4pZb5cMyCTB4RhcXXOWS02Rj3tviSTYo64jR8KEbzso218T7Oerd6mIwY0mhwXuAV
 wwExZshJ0W3SBbdAyxKyPQXMbISGeYiRemBoRsqKivIEF8Yzq2cG1IvfcdsNw0/qehtH
 7apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+uptDv3y8tSXuln43+mg3NZsB+UqXPgfucNzBDBXods=;
 b=SoAtBlw0YyD5BEw9MnSbzH/caINpQFndIIRf3MQfvitIm3R7NdmDosXrmnCSd+TxXg
 vzT55YvayR4bF7kl59p3tD7n1VwIWRC63kvNXwQ3wZq6tRabF0n3XTm7ysIYVXBziGXX
 hu9ShTR2CN3fazeG6SJP0EKWesDVtwX6VlKRhoqC+Vsde7KLG9v6ff6LenLXpnRmIG5r
 DtaAGAiNdhEVJU2mCzJJpKcHSJJud7CFtVnV3iH1jDsyLFFxolVA2fxDo4cZfvjgct1q
 Hw4FDKzLjkpy0+3LyeCQ0rMi7yh35lPLecpk0Un17mWfP1B/32SdZzCznJJcMn4KdAN7
 DUpw==
X-Gm-Message-State: APjAAAVMW1w1T6Ok+GXJnH4ihFtr5PCCDgnZdc5tCGwM0JEvR+W+JbpM
 TNFnK57d77k/dVOD4dMPlnyGYnwq
X-Google-Smtp-Source: APXvYqz8HRE29adi1ta+Jsp9jLf74tGeEY4bHHVpEsejUo34nilC6ZvqHiYrJaWySG9BBFJRZgI34g==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr19447619wmi.166.1578926458437; 
 Mon, 13 Jan 2020 06:40:58 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd29:349f:9f33:2a26])
 by smtp.gmail.com with ESMTPSA id m10sm15347802wrx.19.2020.01.13.06.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:40:58 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 3/8] drm/amdgpu: use the VM as job owner
Date: Mon, 13 Jan 2020 15:40:50 +0100
Message-Id: <20200113144055.3416-3-christian.koenig@amd.com>
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

Rm9yIEhNTSB3ZSBuZWVkIHRvIHJld29yayBob3cgVk0gc3luY2hyb25pemF0aW9uIHdvcmtzLCBz
byBpbnN0ZWFkIG9mIHRoZSBmaWxwIHVzZSBWTSBhcyBqb2Igb3duZXIuCgpTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMKaW5kZXggYzRhODE0OGI5YjZmLi5jZjc5ZjMwYzBhZjYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCkBAIC02NTUsNiArNjU1LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfY3NfcGFyc2VyX2JvcyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwKIAog
c3RhdGljIGludCBhbWRncHVfY3Nfc3luY19yaW5ncyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAq
cCkKIHsKKwlzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICpmcHJpdiA9IHAtPmZpbHAtPmRyaXZlcl9wcml2
OwogCXN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSAqZTsKIAlpbnQgcjsKIApAQCAtNjYyLDcg
KzY2Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N5bmNfcmluZ3Moc3RydWN0IGFtZGdwdV9j
c19wYXJzZXIgKnApCiAJCXN0cnVjdCBhbWRncHVfYm8gKmJvID0gdHRtX3RvX2FtZGdwdV9ibyhl
LT50di5ibyk7CiAJCXN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IGJvLT50Ym8uYmFzZS5yZXN2Owog
Ci0JCXIgPSBhbWRncHVfc3luY19yZXN2KHAtPmFkZXYsICZwLT5qb2ItPnN5bmMsIHJlc3YsIHAt
PmZpbHAsCisJCXIgPSBhbWRncHVfc3luY19yZXN2KHAtPmFkZXYsICZwLT5qb2ItPnN5bmMsIHJl
c3YsICZmcHJpdi0+dm0sCiAJCQkJICAgICBhbWRncHVfYm9fZXhwbGljaXRfc3luYyhibykpOwog
CiAJCWlmIChyKQpAQCAtMTIxMCw3ICsxMjExLDcgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfc3Vi
bWl0KHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogCWpvYiA9IHAtPmpvYjsKIAlwLT5qb2Ig
PSBOVUxMOwogCi0JciA9IGRybV9zY2hlZF9qb2JfaW5pdCgmam9iLT5iYXNlLCBlbnRpdHksIHAt
PmZpbHApOworCXIgPSBkcm1fc2NoZWRfam9iX2luaXQoJmpvYi0+YmFzZSwgZW50aXR5LCAmZnBy
aXYtPnZtKTsKIAlpZiAocikKIAkJZ290byBlcnJvcl91bmxvY2s7CiAKLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
