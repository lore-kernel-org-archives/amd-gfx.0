Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D2C33C9B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB1E2075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj900mE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A166E486;
	Mon,  6 Jan 2020 15:03:46 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D83B6E484
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:45 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so15596150wma.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+uptDv3y8tSXuln43+mg3NZsB+UqXPgfucNzBDBXods=;
 b=Qj900mE/iLTEEffCVElVGUor9WU43GzNlkIbAqS6vJHgtfw6vT1m9N1U1c4a84UPQk
 ebPVIL41efrV4EQLJSUInTp3pLiNh/pzOl8lZqcFpU1R87vmD+bm21r5z8PWzNCoGFlW
 uZMd9YHt6wmUGSIo+lgJR7D1herRwLaRtS9lcBLfZysTaeYtCemWGMcQh+mas4rSqjHx
 KMHzcGTio1Bp0dXIdt0sB55ygxwUn4fYFZXoVkRfivTl5zeA1Xct5en+PTFwIpPW/03X
 tmMWsfO3A0XCNmq5yPZtq4NdDwjn7+y2lwAql4/PXmhi2lY2vbrvUWP3N3KyRUbcEBUc
 r17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+uptDv3y8tSXuln43+mg3NZsB+UqXPgfucNzBDBXods=;
 b=PhnzWu93aWD/hPp5BdQzFOqz1WsWkX4P8kAwT0HXUpxNMCOgn5wytW7SJpvrMo/P05
 uF6TkCBDlQ6CyaPJJpl7S+DDCyi8d2YDm75lRqLX2qURHX9HhrZCiDYYhkbCQGELF5Wi
 aVkAALi++DftsqP/AYgt/1zfQL38LT5ql3m3UaFMxJrmygHuWU9xcPvLK0B5fJ04ydTE
 Uousta3+rccuCOrdMz2/fMVqNau0oAWUDrn5WjDWdDZ3CSr8Svs969aRd8WXN29KNQoL
 l8ByLHRXosIn4Wxqng0WNtApM8jlByt6bLvKMMsjpquD87JMYCMlI9IGU04p3aqxHzXT
 dqtQ==
X-Gm-Message-State: APjAAAV7n6Nlzzlyknz4l1S1F16LasH3/K635ACx5Umn4VwmOQkF3iw8
 qwnnYEZkulWft24vlE8hjEc=
X-Google-Smtp-Source: APXvYqzt2jNZ6duKYRhshGakr7jyTVfW7JbHp9JP4tJQZ02gmW9OyHMfXIVb4a5WgZ213TgnjkYuVQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr35205698wmc.21.1578323024065; 
 Mon, 06 Jan 2020 07:03:44 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] drm/amdgpu: use the VM as job owner
Date: Mon,  6 Jan 2020 16:03:29 +0100
Message-Id: <20200106150335.1738-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106150335.1738-1-christian.koenig@amd.com>
References: <20200106150335.1738-1-christian.koenig@amd.com>
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
