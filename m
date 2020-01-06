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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A2C33CA3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6D12075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrOsOOD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6D12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C256E48E;
	Mon,  6 Jan 2020 15:03:52 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFD36E48D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:49 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z3so49984984wru.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QGwAc3HBR6++XfbV+CxyQK/TcBeX0ty7d0H32ppMiaE=;
 b=IrOsOOD+oaAQnqrFmrjkc83IHCJcQrKT2RMriDz6JPOW4CrZ4q3MpN20lC0Xt7U710
 nMedL2tIPsW2gZkDGxPdxjuKlOqxyfJmAWTqTIqpyDvC+ta/tRJ7PWMzTnNKpxWw96qL
 6Juga4GHf9afyqqWKHLtXz83itQltEFwDR4v8nmE/TLj35PycaJ6uWL+GWiyvmSP4o9t
 +8j1feTPfVk3i1lPoXVyba7hJd0U50PywQoLKJYDxT/I1SkFcz2ifize6zY/BIYO5Ixn
 uTyu7gNhIpzqSl0Idm40/YaCLYKC/IAo64mMk40qNwBGPoqmYPHP6+OSJq3QIpgk3ogj
 ekYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QGwAc3HBR6++XfbV+CxyQK/TcBeX0ty7d0H32ppMiaE=;
 b=kJvpvtnk+U6oQ0mk6MvyetsaA4UNEwZfpZHuxjgv39MD9AoFbcm3+8uYkMbHIFWNjS
 jkcBxjJM+SNTN8x25cAT5OSHmUuIfxeub68dXdS027vyT/FblD2D6v9t6N0uaKnrqGCl
 6agcb5afSllZIHbov1GRk3LEAWQYYlwa6Oc30g1tecaoheR4iofRKXcYsYcIVGLBPZy+
 E4IO1dCyV8labF+aQ6zYzFEcmNhs7RgkAzCvZOSLEv0N6yweCOyuRur7d9560I0XtAT7
 W7M5fi1pFn89egRhfUVd3KpWU1OkVOAAvhEP4aFcxO248uSwJe+B38lQBeEL1H+8yohY
 Sgsw==
X-Gm-Message-State: APjAAAVXFsEIGzdLE+KEx9HSgXZS9IoKobG6UkIiolHW1oMcNlmnsXKD
 V/sKANoixmuEZwbaizsyiI8=
X-Google-Smtp-Source: APXvYqwvX0ltkKDS+Sm9tMNu8P2wxTS+bwD7rGxtP/aPI2FSKFxysODOpQwu5BOlMIgI5vUbzfuGuQ==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr99759504wrw.373.1578323028527; 
 Mon, 06 Jan 2020 07:03:48 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] drm/amdgpu: drop unnecessary restriction for huge root
 PDEs
Date: Mon,  6 Jan 2020 16:03:34 +0100
Message-Id: <20200106150335.1738-12-christian.koenig@amd.com>
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

VGhlIHJvb3QgUEQgY2FuIGFsc28gY29udGFpbiBodWdlIFBERXMuCgpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyNSArKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDY4NDRiYTc0NjdhNi4uMjM3
MjlmZGQzNGZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtOTQs
MjMgKzk0LDE3IEBAIHN0cnVjdCBhbWRncHVfcHJ0X2NiIHsKIHN0YXRpYyB1bnNpZ25lZCBhbWRn
cHVfdm1fbGV2ZWxfc2hpZnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJICAgICAg
dW5zaWduZWQgbGV2ZWwpCiB7Ci0JdW5zaWduZWQgc2hpZnQgPSAweGZmOwotCiAJc3dpdGNoIChs
ZXZlbCkgewogCWNhc2UgQU1ER1BVX1ZNX1BEQjI6CiAJY2FzZSBBTURHUFVfVk1fUERCMToKIAlj
YXNlIEFNREdQVV9WTV9QREIwOgotCQlzaGlmdCA9IDkgKiAoQU1ER1BVX1ZNX1BEQjAgLSBsZXZl
bCkgKworCQlyZXR1cm4gOSAqIChBTURHUFVfVk1fUERCMCAtIGxldmVsKSArCiAJCQlhZGV2LT52
bV9tYW5hZ2VyLmJsb2NrX3NpemU7Ci0JCWJyZWFrOwogCWNhc2UgQU1ER1BVX1ZNX1BUQjoKLQkJ
c2hpZnQgPSAwOwotCQlicmVhazsKKwkJcmV0dXJuIDA7CiAJZGVmYXVsdDoKLQkJZGV2X2Vycihh
ZGV2LT5kZXYsICJ0aGUgbGV2ZWwlZCBpc24ndCBzdXBwb3J0ZWQuXG4iLCBsZXZlbCk7CisJCXJl
dHVybiB+MDsKIAl9Ci0KLQlyZXR1cm4gc2hpZnQ7CiB9CiAKIC8qKgpAQCAtMTQzMiwxMyArMTQy
Niw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1f
dXBkYXRlX3BhcmFtcyAqcGFyYW1zLAogCiAJCXB0ID0gY3Vyc29yLmVudHJ5LT5iYXNlLmJvOwog
Ci0JCS8qIFRoZSByb290IGxldmVsIGNhbid0IGJlIGEgaHVnZSBwYWdlICovCi0JCWlmIChjdXJz
b3IubGV2ZWwgPT0gYWRldi0+dm1fbWFuYWdlci5yb290X2xldmVsKSB7Ci0JCQlpZiAoIWFtZGdw
dV92bV9wdF9kZXNjZW5kYW50KGFkZXYsICZjdXJzb3IpKQotCQkJCXJldHVybiAtRU5PRU5UOwot
CQkJY29udGludWU7Ci0JCX0KLQogCQlzaGlmdCA9IGFtZGdwdV92bV9sZXZlbF9zaGlmdChhZGV2
LCBjdXJzb3IubGV2ZWwpOwogCQlwYXJlbnRfc2hpZnQgPSBhbWRncHVfdm1fbGV2ZWxfc2hpZnQo
YWRldiwgY3Vyc29yLmxldmVsIC0gMSk7CiAJCWlmIChhZGV2LT5hc2ljX3R5cGUgPCBDSElQX1ZF
R0ExMCAmJgpAQCAtMTQ1NywxMSArMTQ0NCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0
ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAogCQkJaWYgKCFh
bWRncHVfdm1fcHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkKIAkJCQlyZXR1cm4gLUVOT0VO
VDsKIAkJCWNvbnRpbnVlOwotCQl9IGVsc2UgaWYgKGZyYWcgPj0gcGFyZW50X3NoaWZ0ICYmCi0J
CQkgICBjdXJzb3IubGV2ZWwgLSAxICE9IGFkZXYtPnZtX21hbmFnZXIucm9vdF9sZXZlbCkgewor
CQl9IGVsc2UgaWYgKGZyYWcgPj0gcGFyZW50X3NoaWZ0KSB7CiAJCQkvKiBJZiB0aGUgZnJhZ21l
bnQgc2l6ZSBpcyBldmVuIGxhcmdlciB0aGFuIHRoZSBwYXJlbnQKLQkJCSAqIHNoaWZ0IHdlIHNo
b3VsZCBnbyB1cCBvbmUgbGV2ZWwgYW5kIGNoZWNrIGl0IGFnYWluCi0JCQkgKiB1bmxlc3Mgb25l
IGxldmVsIHVwIGlzIHRoZSByb290IGxldmVsLgorCQkJICogc2hpZnQgd2Ugc2hvdWxkIGdvIHVw
IG9uZSBsZXZlbCBhbmQgY2hlY2sgaXQgYWdhaW4uCiAJCQkgKi8KIAkJCWlmICghYW1kZ3B1X3Zt
X3B0X2FuY2VzdG9yKCZjdXJzb3IpKQogCQkJCXJldHVybiAtRU5PRU5UOwotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
