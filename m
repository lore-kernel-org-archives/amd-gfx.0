Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D5C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B292072B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV/Pxv31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B292072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCBE892D2;
	Thu, 16 Jan 2020 15:28:25 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2547892D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:28:24 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f129so4262972wmf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JQNq+NEREexueNyaw31T4Y4D2FCKo3wDkFwbezAHPBY=;
 b=JV/Pxv31Dclwd8oxLSidwiShIIchykyEC2cVQpV06FAqvVR+d9XKxfsLpZAT6FLfR8
 oj22l3L/ONsrfxvJNaQ+kRoncOH28+gtoJewaq6ZG1V2S+MGioJKBfmhgD47d77pJZfm
 uVHSzNfrxFU0JJFq21nHEB6WV2bP814bJNjw+CLkwTiUGhzJN7tsGfqSVK1kMzF+Mg/T
 lSbmr3jgD1GO1DAfsiAwzk3ICH3Pi8zKpEfkOV1XxLtuDQkq+cHcbXT4cwLtq1WJbGJm
 HCqwApfVoRy1ZHvfVMYCzPKaMeFvmE7YXxhgbVuY5i2NbGFGtu/vGOJ3scaTZTM7us4/
 +lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JQNq+NEREexueNyaw31T4Y4D2FCKo3wDkFwbezAHPBY=;
 b=TFtSk+Dm5AyoFEkz0CK9shaBhNl4ufrt4aYSBGrnlwyxACGAeGRNRTSnLl8w+vP88O
 UaOz4f1ORdLUWVvHZtdXNfPqzYd7Wk+6pNaeqmRIa1+gCmMDUzIzDa9aHBLr4nQSuob9
 eze3NXLMJKTm9lGm8uVDCpcNQD/b0b/SBYzf1VMfwYS2uIpMlANV6HKIogX60IcE3a0Q
 odOjfIgSvd1Qkg/d3/52nVkHnkgh/kHDNPfybWTlA/nTMqsVq8EqTyMRHu2Xwq89o/mC
 /ESuFhetB9fECXTll7OcgJ8/7o+NikA/9hybDTMR/8XT6nKlGfvvfcSyerEIPpxtZV9h
 itOg==
X-Gm-Message-State: APjAAAXgGr/elXN9B7d+P9iB5ThPzIptiVggkd6r/bV+oGXeB4B7vRUd
 iiIRgAE6Dv4KtkCGWwPogB0=
X-Google-Smtp-Source: APXvYqwDIAxRe0S9fd2O75c18nmZ+MDayIs4sJgvq//HIIKvwbk/lDomH5HjSOGP+oCZllJdRFUr/A==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr6475422wmj.37.1579188503690;
 Thu, 16 Jan 2020 07:28:23 -0800 (PST)
Received: from baker.fritz.box ([2a02:908:1252:fb60:f03e:783:8232:6d17])
 by smtp.gmail.com with ESMTPSA id k82sm5290568wmf.10.2020.01.16.07.28.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:28:23 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: skip unallocated PDs/PTs while invalidating
Date: Thu, 16 Jan 2020 16:28:22 +0100
Message-Id: <20200116152822.2327-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
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

V2UgZG9uJ3QgbmVlZCB0byByZXR1cm4gYW4gZXJyb3IgaW4gdGhpcyBjYXNlLgoKU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpGaXhlczog
ZDY5MzJhNGQ4NmU0IGRybS9hbWRncHU6IG1ha2Ugc3VyZSB0byBuZXZlciBhbGxvY2F0ZSBQRHMv
UFRzIGZvciBpbnZhbGlkYXRpb25zCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXgg
NWNiMTgyMjMxZjVkLi42Y2Y0MDdhYWIyNzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCkBAIC0xNDY3LDggKzE0NjcsMTIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBk
YXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCiAJCQkgKiBz
bWFsbGVyIHRoYW4gdGhlIGFkZHJlc3Mgc2hpZnQuIEdvIHRvIHRoZSBuZXh0CiAJCQkgKiBjaGls
ZCBlbnRyeSBhbmQgdHJ5IGFnYWluLgogCQkJICovCi0JCQlpZiAoIWFtZGdwdV92bV9wdF9kZXNj
ZW5kYW50KGFkZXYsICZjdXJzb3IpKQotCQkJCXJldHVybiAtRU5PRU5UOworCQkJaWYgKCFhbWRn
cHVfdm1fcHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkgeworCQkJCWlmIChmbGFncyAmIEFN
REdQVV9QVEVfVkFMSUQpCisJCQkJCXJldHVybiAtRU5PRU5UOworCQkJCWVsc2UKKwkJCQkJYW1k
Z3B1X3ZtX3B0X25leHQoYWRldiwgJmN1cnNvcik7CisJCQl9CiAJCQljb250aW51ZTsKIAkJfSBl
bHNlIGlmIChmcmFnID49IHBhcmVudF9zaGlmdCkgewogCQkJLyogSWYgdGhlIGZyYWdtZW50IHNp
emUgaXMgZXZlbiBsYXJnZXIgdGhhbiB0aGUgcGFyZW50Ci0tIAoyLjE0LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
