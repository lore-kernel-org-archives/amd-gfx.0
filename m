Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9546BC35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D88E20659
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oriHJxby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D88E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5FC6F60B;
	Wed,  5 Feb 2020 15:22:46 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77956F608
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 15:22:44 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id w15so3229212wru.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qs72F68S8yjkzWPj2hqs2YR5PT1avRR3DLuAA0z3dzo=;
 b=oriHJxbyCsJe5BWl/jFjenDmX/qQR/WLBqQfFv39DfFz/w2tDvoBvVusd8n48Ng5a+
 gQmiXW269gFrHfN6R7OIw4sBI5pbk96K/6ctUxSgQZEPZJ2rybFKOKJ1g4exGY6FNr9i
 hg+rMMAHllZohfsZwzdjhYmgSdk15X35ahiGVtOhQxuMmhv42vuAamqu/LJVh7MOI6od
 iOvNweFslDX7bqcFq+jwbPQDAvKw8Cdy6dIUt/295K/xKJyrhLr+pphwW7mjfazsIZvM
 qO4UBJIUDF5+OTzvZCjN6yb3a52G+SEseunO3jXYQe2HL46fgm8DIE8qyzbPvartbNng
 MYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qs72F68S8yjkzWPj2hqs2YR5PT1avRR3DLuAA0z3dzo=;
 b=JTMryotZzUJ24DcCp6K4pg5S72XtkQPlPjpFs0r6emF0tSuiS/fo+uK5/FopfT0zx2
 1WE7E6OGgOLba0p40UzsHo6VJZ6mOh6aF8Gv8Zb4uwG0VUzNdNCiI+M0kmJx7ELhhz45
 QsfabDEN3W2paGUWQp2vA1Z21hmA7FXWXIk+lwCxTthUbNqmdmCKJyh6VHvRhFNOOYTi
 lTyPBJ+HRIGHkyu9RPdtMGfEVVqPPZEHfVPxtX6LvzjouBYuQEtO0+xW6HlYw2sXismU
 1cu5ar5a321u4HQv/rSiJOxwcsKkQ9Z8ZyT+b7GIWDvloK2F3NP4RZiFFO88flB7qioa
 KwPA==
X-Gm-Message-State: APjAAAXuIFxzTKtJRuouQFrwsmuml6qfwFSI6yPh4rxO39RNhPD30y+8
 t89P+l0cJBYqTpBLiPF4A6dPNboB
X-Google-Smtp-Source: APXvYqyVJovf8jpQAmBrfoOnqwxnMNlUMg/cL3gLwCQa3MqdSPz4kE3oRbjTif1HI9xB3swf9qZ6uA==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr25058637wrn.324.1580916163159; 
 Wed, 05 Feb 2020 07:22:43 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7118:fd6f:1c5e:860a])
 by smtp.gmail.com with ESMTPSA id p3sm209169wrx.29.2020.02.05.07.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:22:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory
Date: Wed,  5 Feb 2020 16:22:38 +0100
Message-Id: <20200205152238.45258-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205152238.45258-1-christian.koenig@amd.com>
References: <20200205152238.45258-1-christian.koenig@amd.com>
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

TWFrZSB1c2Ugb2YgdGhlIGJldHRlciBwZXJmb3JtYW5jZSBoZXJlIGFzIHdlbGwuCgpUaGlzIHBh
dGNoIGlzIG9ubHkgY29tcGlsZSB0ZXN0ZWQhCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jIHwgMzggKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRleCA1OGQxNDNiMjRiYTAuLjUzOGMzYjUyYjcx
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMTU2NSw3ICsx
NTY1LDcgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX2FjY2Vzc19tZW1vcnkoc3RydWN0IHR0bV9i
dWZmZXJfb2JqZWN0ICpibywKIAogCXdoaWxlIChsZW4gJiYgcG9zIDwgYWRldi0+Z21jLm1jX3Zy
YW1fc2l6ZSkgewogCQl1aW50NjRfdCBhbGlnbmVkX3BvcyA9IHBvcyAmIH4odWludDY0X3QpMzsK
LQkJdWludDMyX3QgYnl0ZXMgPSA0IC0gKHBvcyAmIDMpOworCQl1aW50NjRfdCBieXRlcyA9IDQg
LSAocG9zICYgMyk7CiAJCXVpbnQzMl90IHNoaWZ0ID0gKHBvcyAmIDMpICogODsKIAkJdWludDMy
X3QgbWFzayA9IDB4ZmZmZmZmZmYgPDwgc2hpZnQ7CiAKQEAgLTE1NzQsMjAgKzE1NzQsMjggQEAg
c3RhdGljIGludCBhbWRncHVfdHRtX2FjY2Vzc19tZW1vcnkoc3RydWN0IHR0bV9idWZmZXJfb2Jq
ZWN0ICpibywKIAkJCWJ5dGVzID0gbGVuOwogCQl9CiAKLQkJc3Bpbl9sb2NrX2lycXNhdmUoJmFk
ZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKLQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAo
KHVpbnQzMl90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwotCQlXUkVHMzJfTk9fS0lRKG1t
TU1fSU5ERVhfSEksIGFsaWduZWRfcG9zID4+IDMxKTsKLQkJaWYgKCF3cml0ZSB8fCBtYXNrICE9
IDB4ZmZmZmZmZmYpCi0JCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKLQkJaWYg
KHdyaXRlKSB7Ci0JCQl2YWx1ZSAmPSB+bWFzazsKLQkJCXZhbHVlIHw9ICgqKHVpbnQzMl90ICop
YnVmIDw8IHNoaWZ0KSAmIG1hc2s7Ci0JCQlXUkVHMzJfTk9fS0lRKG1tTU1fREFUQSwgdmFsdWUp
OwotCQl9Ci0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZs
YWdzKTsKLQkJaWYgKCF3cml0ZSkgewotCQkJdmFsdWUgPSAodmFsdWUgJiBtYXNrKSA+PiBzaGlm
dDsKLQkJCW1lbWNweShidWYsICZ2YWx1ZSwgYnl0ZXMpOworCQlpZiAobWFzayAhPSAweGZmZmZm
ZmZmKSB7CisJCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3Mp
OworCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQzMl90KWFsaWduZWRfcG9zKSB8
IDB4ODAwMDAwMDApOworCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYX0hJLCBhbGlnbmVkX3Bv
cyA+PiAzMSk7CisJCQlpZiAoIXdyaXRlIHx8IG1hc2sgIT0gMHhmZmZmZmZmZikKKwkJCQl2YWx1
ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKKwkJCWlmICh3cml0ZSkgeworCQkJCXZhbHVl
ICY9IH5tYXNrOworCQkJCXZhbHVlIHw9ICgqKHVpbnQzMl90ICopYnVmIDw8IHNoaWZ0KSAmIG1h
c2s7CisJCQkJV1JFRzMyX05PX0tJUShtbU1NX0RBVEEsIHZhbHVlKTsKKwkJCX0KKwkJCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKKwkJCWlmICgh
d3JpdGUpIHsKKwkJCQl2YWx1ZSA9ICh2YWx1ZSAmIG1hc2spID4+IHNoaWZ0OworCQkJCW1lbWNw
eShidWYsICZ2YWx1ZSwgYnl0ZXMpOworCQkJfQorCQl9IGVsc2UgeworCQkJYnl0ZXMgPSAobm9k
ZXMtPnN0YXJ0ICsgbm9kZXMtPnNpemUpIDw8IFBBR0VfU0hJRlQ7CisJCQlieXRlcyA9IG1pbihw
b3MgLSBieXRlcywgKHVpbnQ2NF90KWxlbiAmIH4weDN1bGwpOworCisJCQlhbWRncHVfZGV2aWNl
X3ZyYW1fYWNjZXNzKGFkZXYsIHBvcywgKHVpbnQzMl90ICopYnVmLAorCQkJCQkJICBieXRlcywg
d3JpdGUpOwogCQl9CiAKIAkJcmV0ICs9IGJ5dGVzOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
