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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482B6C33CB1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E71420678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rticY3wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E71420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9EB6E0E9;
	Mon, 13 Jan 2020 14:41:05 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210236E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 14:41:03 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c9so8829915wrw.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H5RkmGRZ30GgNVtyQFHdvi3ttaKYcZFVyPftq084q/s=;
 b=rticY3wAMF9goopNYRnipe1SqEWusBSt4Bh2lIcUkGjh/jIyHGi2ZiDUl0hQVpl1S5
 ppQNE+2UbGiLUppqy6hYmDkUoRQTarN8Se5t7vU0k4/y9IhrBeUEDmWgJZ1PIPQxKyEV
 uRRxQZh/LHAjF8n/5shvzA0q2wiNBQXPKJ0tqsRQIklV1hy4qv7jG1deg3Prqo0ECUIk
 hL7VNoQpe8OQUUrRCdbYAQX+CUsF6AzueR02wwijGsaV6crGip2EDzZIZrAiNs0Ajp7B
 PXO+MWixtiUuq6p7OqsKBZxHIOUCzqmx2Ke/y0/cf2MOHsqzzkBlEzwiK0xw3ZfDLwtT
 Gt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H5RkmGRZ30GgNVtyQFHdvi3ttaKYcZFVyPftq084q/s=;
 b=pnkE+Q+Ubm95AH3WiS7ov5skz8n9l/2YtD7MFAuICA/fcwRddJwrAU8wpwicNc1YKW
 n5iIMd+83c26C9+kHEG3QixDymLcGzxdFGmy+prPgpdXLn3WxgCkCmWr14a1CWYgBF/u
 5VWVT2ExOSZFGc6D1XSe0sy1UOihOfUreOvaJDDIXJArrAvGXUjQjlic2kuORi/1uc7Z
 RpMPuwLvwFpmEoJCZhUCx1fUdfk7+TUhjN52mLlMy1/wF+k+rLzC1oB+Fish/DbQ3TwZ
 utdcJsSUzqBgUzOqgzRwMkmZv3KxK9sk7gIh8kOj335zJGok5g2QY7V580eL1KnACUkz
 q0ZQ==
X-Gm-Message-State: APjAAAVdTj0yC+gZjE27846k7KXEQ3kiPTUXcp3CoV6KJdxMsqJteiH1
 Ime+Ijl9hbxa6of6cJavlk0axP44
X-Google-Smtp-Source: APXvYqz2ddGiqgHs5svR4bBA0BSRRDqK553GJ9PVNEfLb18il142VSiNmqNSyjFFHdV4ijqG9Yld3w==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr19293171wrr.312.1578926461669; 
 Mon, 13 Jan 2020 06:41:01 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd29:349f:9f33:2a26])
 by smtp.gmail.com with ESMTPSA id m10sm15347802wrx.19.2020.01.13.06.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:41:01 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 7/8] drm/amdgpu: drop unnecessary restriction for huge root
 PDEs
Date: Mon, 13 Jan 2020 15:40:54 +0100
Message-Id: <20200113144055.3416-7-christian.koenig@amd.com>
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

VGhlIHJvb3QgUEQgY2FuIGFsc28gY29udGFpbiBodWdlIFBERXMuCgpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyNSArKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDU1MTY1YTQ0ZTRiYi4uNGRl
OWIzMzAwODcwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
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
