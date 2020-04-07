Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB737C2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5B22078C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYNDOhvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5B22078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337B989CAF;
	Tue,  7 Apr 2020 14:54:44 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4035F89CAF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 14:54:43 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id s30so2874205qth.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Apr 2020 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4bIn+DlcGYm3DPB6N6oGq1wArClMMDiBHH1Okf8ZI/M=;
 b=gYNDOhvj7qLlqgTkQMiFZ+1QSObl4BjPPxfOtBrAlkfeFGioK+gntt+ATLy4xWJqzw
 YstRLz5seuRdXc1A7LejeJpU24zU+fIl8NIUtb5aIyrwjpEqA8vd+jU+24a3LN7WqYKo
 nWBrLIrUKa5FlwOvyyT9Xpe+B/T+s7qaChXbBdGgZSwqW1DMav7Ro9Sjt3675qpA5dtQ
 4PRSqV6FxjEi9uL9Yj3XNmrdabzPnth4CmmBHc/mb+9++/zvFZ69FAh01EGWSD9tDGxf
 C7xAbUbEFei248OrztHqFydjDfA+hlDRlinZ9kfTDO0wGZ250486WmGTmojzey09dWgY
 P2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4bIn+DlcGYm3DPB6N6oGq1wArClMMDiBHH1Okf8ZI/M=;
 b=mBO5hw38FT3y1efK4iF04TTx3++CVEKtWpq+DnotQgBXokaSwWiTXE2dwhy2DAKK/Z
 wY/ZGA3dG8SVQl3fDb0u9X95uEsQ+WWV20xFO5kw/j0uCwTyve1Xv05Ujz42g/GJojbu
 Sdz2qAfpikuaCSGoLmMbPUlclxgFvfljsk2b+JMhvZZ4dX6fKUjc7hv8L939ZGdMxDPl
 bNv6HwI00X+Qor9d1Blq9VFxdwv1yzUggo6J9zFPR+purkYHaeiA/Yu4ey4o+q9Niq8p
 T2u6UCbaobMI4FkqbCTAhhJY90bmxWZBvb/Y1hMG/ZDfTzDpfRDDO31fhxJcGvp+WoeM
 WYKg==
X-Gm-Message-State: AGi0PuZSDirI6c9AKd0GmnYpkfogvhiSbvcK4cRAJq2AhkILW0Y1RDhY
 T3offwO/jm2zylvEBr2mwmGxRABQ
X-Google-Smtp-Source: APiQypIzW/e8iebDHXDN7e1ZeYW0C+QsD6VYAzZZik72jOEzv8wZsXH5wJoPUaXaaYqgn0YSBK1Qug==
X-Received: by 2002:ac8:16d2:: with SMTP id y18mr1712304qtk.64.1586271279069; 
 Tue, 07 Apr 2020 07:54:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c8sm17725280qke.90.2020.04.07.07.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 07:54:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/eeprom: fix possible read overflow in memcpy
Date: Tue,  7 Apr 2020 10:54:31 -0400
Message-Id: <20200407145431.1090867-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIHNpemUgY291bGQgYmUgdXAgdG8gMzIgYnl0ZXMgYW5kIHdlIHN0YXJ0IGZyb20gaW5kZXgg
Mi4KCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvdXVpZC5oOjEyLAogICAg
ICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L21vZF9kZXZpY2V0YWJsZS5oOjEzLAog
ICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3BjaS5oOjI3LAogICAgICAgICAg
ICAgICAgIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20u
YzoyMzoKSW4gZnVuY3Rpb24g4oCYbWVtY3B54oCZLAogICAgaW5saW5lZCBmcm9tIOKAmGFtZGdw
dV9mcnVfZ2V0X3Byb2R1Y3RfaW5mb+KAmSBhdCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZnJ1X2VlcHJvbS5jOjEzNzoyOgouL2luY2x1ZGUvbGludXgvc3RyaW5nLmg6Mzc2OjQ6
IGVycm9yOiBjYWxsIHRvIOKAmF9fcmVhZF9vdmVyZmxvdzLigJkgZGVjbGFyZWQgd2l0aCBhdHRy
aWJ1dGUgZXJyb3I6IGRldGVjdGVkIHJlYWQgYmV5b25kIHNpemUgb2Ygb2JqZWN0IHBhc3NlZCBh
cyAybmQgcGFyYW1ldGVyCiAgMzc2IHwgICAgX19yZWFkX292ZXJmbG93MigpOwogICAgICB8ICAg
IF5+fn5+fn5+fn5+fn5+fn5+fgptYWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6
MjY2OiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5vXSBFcnJv
ciAxCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCmluZGV4IDlk
MTc3NjE3MjFkZS4uYzdlNTVmZTE3MGJkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMKQEAgLTg1LDcgKzg1LDcgQEAgaW50IGFtZGdwdV9mcnVf
cmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IGFkZHJwdHIs
CiAKIGludCBhbWRncHVfZnJ1X2dldF9wcm9kdWN0X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiB7Ci0JdW5zaWduZWQgY2hhciBidWZmWzMyXTsKKwl1bnNpZ25lZCBjaGFyIGJ1ZmZb
MzRdOwogCWludCBhZGRycHRyID0gMCwgc2l6ZSA9IDA7CiAKIAlpZiAoIWlzX2ZydV9lZXByb21f
c3VwcG9ydGVkKGFkZXYpKQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
