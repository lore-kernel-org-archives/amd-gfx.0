Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4EDC2D0B1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9532821741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dps/34s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9532821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9CB6FA70;
	Thu,  6 Feb 2020 14:30:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D2A6FA70
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 14:30:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a5so225846wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kjnYjQkLVdrV83L/cArlPFnX1+jGl4d3vOIsj/zYg1g=;
 b=dps/34s80i9TsjZur7/6vn9JUWDxSuYEbhDcXy1eZ+CEvrjxnBPHcBU8lyDmO0Sh9+
 JYtpmuzoq9IkK2Bl3MgDLP0NTjGs0jKhQB55ofdsZuAIP7R9bYBblbA76rLEMGn35fZ0
 G0jR0Stvw4h8w6yitJudrzCTuQILK9GXb6j49IsEZrFygV/1byXkeX1urpZJ737Gfl6n
 IX3SkxxujwQIEwTg3hK6hjvi+b+ReYGicGm2s4BnWme1n+KNHoLekyvz6Grz9D5KMWLf
 jdaC24ZPACq+OpDhMXk+0q618y8iBn8fOfbR1W1xxehaSu6sQqVPQsLiARS14FFs3YoF
 YNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kjnYjQkLVdrV83L/cArlPFnX1+jGl4d3vOIsj/zYg1g=;
 b=CRIMj1CDJr0NdmT/Ir8/lNp9b4/OrCDXfHCa7rld11GD5icPqoDU1sQssTHQl/QGGB
 qTS23KhXO1fuHRb0wceqhRpkTuFGsx965ifG/89JxrgfldsKnAk95c7iFrXSD+It1W99
 3AW/oReia68jMfT2WpFikFxLAQ2fl7/TDUUKZLdSXrHx+CVySxpgr8wnpucfpM03/4Xp
 yvm1mDif+tn/9XSAstvuYvw0ikKjOIEIm1VTzXTCiIvyKo4EtNv8RCst1WvU8hrt6mHK
 O8O982StMrmuIyWLnu3fHPsjIXbA5tbqVDgAAcHrb2q2FuvN4Y/17q4zckb5FvvUt8t+
 0pyg==
X-Gm-Message-State: APjAAAUYqOKxIEPghjxljWmiN8VOWdVycb9KLwpDUiqLd0ef5yme3Q8f
 LNR1vQV4+wEY/+yl2eyCg8EbR92o
X-Google-Smtp-Source: APXvYqy/bArRo+gBrFelcSAWVKU4w48CrZXcB1RN4qqC38vpu7LK6LcthA/XLJy4m6ZYMDcOWdpnJw==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4838731wmi.58.1580999455191; 
 Thu, 06 Feb 2020 06:30:55 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:28f7:e4aa:841b:b35])
 by smtp.gmail.com with ESMTPSA id a198sm3878344wme.12.2020.02.06.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 06:30:54 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory v2
Date: Thu,  6 Feb 2020 15:30:51 +0100
Message-Id: <20200206143051.25809-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206143051.25809-1-christian.koenig@amd.com>
References: <20200206143051.25809-1-christian.koenig@amd.com>
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
dGNoIGlzIG9ubHkgY29tcGlsZSB0ZXN0ZWQhCgp2MjogZml4IGNhbGN1bGF0aW9uIGJ1ZyBwb2lu
dGVkIG91dCBieSBGZWxpeAoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTogSm9uYXRoYW4gS2ltIDxKb25hdGhhbi5LaW1A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAz
OCArKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jCmluZGV4IDU4ZDE0M2IyNGJhMC4uMmMxZDFlYjFhN2UxIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC0xNTY1LDcgKzE1NjUsNyBAQCBzdGF0aWMgaW50IGFt
ZGdwdV90dG1fYWNjZXNzX21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCiAJ
d2hpbGUgKGxlbiAmJiBwb3MgPCBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSB7CiAJCXVpbnQ2NF90
IGFsaWduZWRfcG9zID0gcG9zICYgfih1aW50NjRfdCkzOwotCQl1aW50MzJfdCBieXRlcyA9IDQg
LSAocG9zICYgMyk7CisJCXVpbnQ2NF90IGJ5dGVzID0gNCAtIChwb3MgJiAzKTsKIAkJdWludDMy
X3Qgc2hpZnQgPSAocG9zICYgMykgKiA4OwogCQl1aW50MzJfdCBtYXNrID0gMHhmZmZmZmZmZiA8
PCBzaGlmdDsKIApAQCAtMTU3NCwyMCArMTU3NCwyOCBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1f
YWNjZXNzX21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJYnl0ZXMgPSBs
ZW47CiAJCX0KIAotCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxh
Z3MpOwotCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVgsICgodWludDMyX3QpYWxpZ25lZF9wb3Mp
IHwgMHg4MDAwMDAwMCk7Ci0JCVdSRUczMl9OT19LSVEobW1NTV9JTkRFWF9ISSwgYWxpZ25lZF9w
b3MgPj4gMzEpOwotCQlpZiAoIXdyaXRlIHx8IG1hc2sgIT0gMHhmZmZmZmZmZikKLQkJCXZhbHVl
ID0gUlJFRzMyX05PX0tJUShtbU1NX0RBVEEpOwotCQlpZiAod3JpdGUpIHsKLQkJCXZhbHVlICY9
IH5tYXNrOwotCQkJdmFsdWUgfD0gKCoodWludDMyX3QgKilidWYgPDwgc2hpZnQpICYgbWFzazsK
LQkJCVdSRUczMl9OT19LSVEobW1NTV9EQVRBLCB2YWx1ZSk7Ci0JCX0KLQkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOwotCQlpZiAoIXdyaXRlKSB7
Ci0JCQl2YWx1ZSA9ICh2YWx1ZSAmIG1hc2spID4+IHNoaWZ0OwotCQkJbWVtY3B5KGJ1ZiwgJnZh
bHVlLCBieXRlcyk7CisJCWlmIChtYXNrICE9IDB4ZmZmZmZmZmYpIHsKKwkJCXNwaW5fbG9ja19p
cnFzYXZlKCZhZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7CisJCQlXUkVHMzJfTk9fS0lRKG1t
TU1fSU5ERVgsICgodWludDMyX3QpYWxpZ25lZF9wb3MpIHwgMHg4MDAwMDAwMCk7CisJCQlXUkVH
MzJfTk9fS0lRKG1tTU1fSU5ERVhfSEksIGFsaWduZWRfcG9zID4+IDMxKTsKKwkJCWlmICghd3Jp
dGUgfHwgbWFzayAhPSAweGZmZmZmZmZmKQorCQkJCXZhbHVlID0gUlJFRzMyX05PX0tJUShtbU1N
X0RBVEEpOworCQkJaWYgKHdyaXRlKSB7CisJCQkJdmFsdWUgJj0gfm1hc2s7CisJCQkJdmFsdWUg
fD0gKCoodWludDMyX3QgKilidWYgPDwgc2hpZnQpICYgbWFzazsKKwkJCQlXUkVHMzJfTk9fS0lR
KG1tTU1fREFUQSwgdmFsdWUpOworCQkJfQorCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRl
di0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOworCQkJaWYgKCF3cml0ZSkgeworCQkJCXZhbHVlID0g
KHZhbHVlICYgbWFzaykgPj4gc2hpZnQ7CisJCQkJbWVtY3B5KGJ1ZiwgJnZhbHVlLCBieXRlcyk7
CisJCQl9CisJCX0gZWxzZSB7CisJCQlieXRlcyA9IChub2Rlcy0+c3RhcnQgKyBub2Rlcy0+c2l6
ZSkgPDwgUEFHRV9TSElGVDsKKwkJCWJ5dGVzID0gbWluKGJ5dGVzIC0gcG9zLCAodWludDY0X3Qp
bGVuICYgfjB4M3VsbCk7CisKKwkJCWFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MoYWRldiwgcG9z
LCAodWludDMyX3QgKilidWYsCisJCQkJCQkgIGJ5dGVzLCB3cml0ZSk7CiAJCX0KIAogCQlyZXQg
Kz0gYnl0ZXM7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
