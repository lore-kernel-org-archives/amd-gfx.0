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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A75C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5787220659
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqrpWAcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5787220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C606F608;
	Wed,  5 Feb 2020 15:22:45 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DA26E9AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 15:22:44 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k11so3199923wrd.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vM5MCfdUB6s6QMgupT4EHugKMXntY5TqyXb9ORVNzow=;
 b=HqrpWAcO217vYrjqwUs4O8I337/M2qL1mz7AhfClhJ5t+c00P1Gpy192BFc5inh5WT
 JppGPdx/nWGKXh1ZXX7KpRlAZJ+AFso8he5DqHTTwRU3aG8HmYt7SEfVgO6g0KhU+Hlw
 JcWDQGxCJpWSrhAREOtmjn4IfPTgFFhJ68kabQYvoN6P/UOV9gCw5qJkW2Ryg6ZxReKG
 2piErYfryKrcbd+8hui60jLR45RE1h5+6Bn30Bghs+PC0N3bfGKA0hm/Fyo0qFBRKzoB
 kVaom43G6yUGrkrYddRIelBgLOCx8WBgqXkMT4kBz2neJczSQhjyefjwRmmaYdY3f214
 Dugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vM5MCfdUB6s6QMgupT4EHugKMXntY5TqyXb9ORVNzow=;
 b=NDax23t0bzXsjJrkUTST5jW46BjMmopWS6m8EADn3LiyEpBEBopFeY5hmFCBqTnO5v
 LoOxoxuy9CzXEiXpS6WKBowaAGFa8GL1/31f0PB9FJwfYp9uZ2tWCgJtbNIOfApzjPTm
 lz5Vh2T7TO4f8ijfCAH0qPDqSNjnVXS3plB4uv8dhFIA528mI4OgqUAHc9mYKWFobx9r
 GiW5PtOfJO+lw+juMkMbeDJNMktmYSRYJUgqHCNondda0G4SNZMOd5W363TB5Qg/4cj1
 /42JsCpXO+P5+DAHvdonjaKKlWLR/w9RPn9SlAITB1J7vMuoFhggPe60gNTI6GHie5P9
 WqPg==
X-Gm-Message-State: APjAAAXYfqLtL94KPRpmTuQfbhGZAQNibFCCqWFxt56A/KLUIsOxRrFD
 G8hwb83hA9zLYIHK+qvDy6I10cD2
X-Google-Smtp-Source: APXvYqxo4eeAdwpDDbpLDcDd/Ox6Hcb8bcjtOSnWCM4zjGVLh4NNyzNOE9COpUl2trvnoNCxbcBUwg==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr28485742wrr.211.1580916162508; 
 Wed, 05 Feb 2020 07:22:42 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7118:fd6f:1c5e:860a])
 by smtp.gmail.com with ESMTPSA id p3sm209169wrx.29.2020.02.05.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:22:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 3/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_vram_read
Date: Wed,  5 Feb 2020 16:22:37 +0100
Message-Id: <20200205152238.45258-3-christian.koenig@amd.com>
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

VGhpcyBzcGVlZHMgdXAgdGhlIGFjY2VzcyBxdWl0ZSBhIGJpdCBmcm9tIDIuMiBNQi9zIHRvCjIu
OSBNQi9zIG9uIDMyYml0IGFuZCAxMiw4IE1CL3Mgb24gNjRiaXQuCgpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMjcgKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRleCBhZTFiMDBkZWY1ZDgu
LjU4ZDE0M2IyNGJhMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpA
QCAtNTksNiArNTksOCBAQAogI2luY2x1ZGUgImFtZGdwdV9yYXMuaCIKICNpbmNsdWRlICJiaWYv
YmlmXzRfMV9kLmgiCiAKKyNkZWZpbmUgQU1ER1BVX1RUTV9WUkFNX01BWF9EV19SRUFECShzaXpl
X3QpMTI4CisKIHN0YXRpYyBpbnQgYW1kZ3B1X21hcF9idWZmZXIoc3RydWN0IHR0bV9idWZmZXJf
b2JqZWN0ICpibywKIAkJCSAgICAgc3RydWN0IHR0bV9tZW1fcmVnICptZW0sIHVuc2lnbmVkIG51
bV9wYWdlcywKIAkJCSAgICAgdWludDY0X3Qgb2Zmc2V0LCB1bnNpZ25lZCB3aW5kb3csCkBAIC0y
MjU1LDI3ICsyMjU3LDIwIEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV90dG1fdnJhbV9yZWFkKHN0
cnVjdCBmaWxlICpmLCBjaGFyIF9fdXNlciAqYnVmLAogCWlmICgqcG9zID49IGFkZXYtPmdtYy5t
Y192cmFtX3NpemUpCiAJCXJldHVybiAtRU5YSU87CiAKKwlzaXplID0gbWluKHNpemUsIChzaXpl
X3QpKGFkZXYtPmdtYy5tY192cmFtX3NpemUgLSAqcG9zKSk7CiAJd2hpbGUgKHNpemUpIHsKLQkJ
dW5zaWduZWQgbG9uZyBmbGFnczsKLQkJdWludDMyX3QgdmFsdWU7Ci0KLQkJaWYgKCpwb3MgPj0g
YWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSkKLQkJCXJldHVybiByZXN1bHQ7Ci0KLQkJc3Bpbl9sb2Nr
X2lycXNhdmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKLQkJV1JFRzMyX05PX0tJUSht
bU1NX0lOREVYLCAoKHVpbnQzMl90KSpwb3MpIHwgMHg4MDAwMDAwMCk7Ci0JCVdSRUczMl9OT19L
SVEobW1NTV9JTkRFWF9ISSwgKnBvcyA+PiAzMSk7Ci0JCXZhbHVlID0gUlJFRzMyX05PX0tJUSht
bU1NX0RBVEEpOwotCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT5tbWlvX2lkeF9sb2Nr
LCBmbGFncyk7CisJCXNpemVfdCBieXRlcyA9IG1pbihzaXplLCBBTURHUFVfVFRNX1ZSQU1fTUFY
X0RXX1JFQUQgKiA0KTsKKwkJdWludDMyX3QgdmFsdWVbQU1ER1BVX1RUTV9WUkFNX01BWF9EV19S
RUFEXTsKIAotCQlyID0gcHV0X3VzZXIodmFsdWUsICh1aW50MzJfdCAqKWJ1Zik7CisJCWFtZGdw
dV9kZXZpY2VfdnJhbV9hY2Nlc3MoYWRldiwgKnBvcywgdmFsdWUsIGJ5dGVzLCBmYWxzZSk7CisJ
CXIgPSBjb3B5X3RvX3VzZXIoYnVmLCB2YWx1ZSwgYnl0ZXMpOwogCQlpZiAocikKIAkJCXJldHVy
biByOwogCi0JCXJlc3VsdCArPSA0OwotCQlidWYgKz0gNDsKLQkJKnBvcyArPSA0OwotCQlzaXpl
IC09IDQ7CisJCXJlc3VsdCArPSBieXRlczsKKwkJYnVmICs9IGJ5dGVzOworCQkqcG9zICs9IGJ5
dGVzOworCQlzaXplIC09IGJ5dGVzOwogCX0KIAogCXJldHVybiByZXN1bHQ7Ci0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
