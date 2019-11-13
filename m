Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16400C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 16:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA99F21A49
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 16:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA99F21A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E796ED91;
	Wed, 13 Nov 2019 16:23:26 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F98F6ED90
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 16:23:25 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id i2so866036ywg.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 08:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hALMIjpHC96yVtoj/bWb3eWYZzA8IRuXiLvIGM5YHak=;
 b=iVG0/oGYzQPifn7KlT0gZuW4sjzZYinYy1lmES4TClY1G0AEupwMGgIFYj2NYkGBvQ
 9M9WYgHNXmG2duWaILynlViLy2jaMZcsBfYRqVOtokOE90a13KywN0Pc8yFZrrg+N/HM
 f9pUO9ngNFusxFjMrfkeOJ5eeAGkoU4Er/pR6g/sAjNxC4mtT1Cy0Etbt+l/06e5rt/1
 K1mLHu5UkkF3YHYUKHr9tRFJ4NL5valnEPEc+82mlvX0lZzr5KVcJ8FbxlMj2AEQPENW
 eoSyzJy4voHsenO8uTxI/Ou5nCWJmWI/Rq1GaplMxmXdL8cO8G6K4j1MymI3AneGO4EH
 S9uA==
X-Gm-Message-State: APjAAAVHitRaHgLzgVTrUW7kv7SCAwpJ+j3rajMGSmLsThthA7OiCsXk
 PzGDD3NhVdMlZoluAx7KO9475pDF
X-Google-Smtp-Source: APXvYqyTdVV22rZVKFDnetA83Vt+/yiiwANSu33sLDxmL087ZtJ+xQc3rUfvyks0JxDf0PVZJxMpcA==
X-Received: by 2002:a81:516:: with SMTP id 22mr2711721ywf.504.1573662203727;
 Wed, 13 Nov 2019 08:23:23 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id u7sm2284946ywu.45.2019.11.13.08.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 08:23:23 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK
Date: Wed, 13 Nov 2019 11:23:13 -0500
Message-Id: <20191113162314.520605-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hALMIjpHC96yVtoj/bWb3eWYZzA8IRuXiLvIGM5YHak=;
 b=eEEjak99DSM1YMedC+xaduJPTTewYU4vnRNjgHvweye0Ly4z/rH3dchzkBHR1bJeHL
 Ddjs4z4mc5Im7q2Q9DILG9/c4xNKko8O2ZxrCC/216OTZIAvJy78cHLx8aqHWeyhzqRO
 cw73Q+0AtDw5beTYyN0ty1sZw8ZQIbAa3iKfY36Q5dNnOG3vvDg/4pOVXnNqkU0ucvdY
 /iErvu5ZlL3lNmG9J+0YNwQa1/P7EANiMq86TRF8kAy8h1mZOfm3Pi6JtLxwEr5ESZSc
 9fmcNJaY+TFn7Emgb+HRTDw+lcsrQnTCscLkZn0rg8Z1OCQIDtlVQxdRp4KXwaqYTG6T
 MUaw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191113162313.8XkJsl7vbGRdJfa6RRZ1bIEPAvlvpXEX28YbopALjkc@z>

U28gdGhhdCB0aGUgc2V0dGluZyByZWZsZWN0cyB3aGF0IHRoZSBodyBzdXBwb3J0cy4gVGhpcyB3
aWxsCmJlIHVzZWQgaW4gYSBzdWJzZXF1ZW50IHBhdGNoIHNvIG5lZWRzIHRvIGJlIGNvcnJlY3Qu
CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jICB8IDIgKysK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMgfCA3ICsrKysrKysK
IDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IDU3NDU5YTY1ZWI0NC4uYWQzOWRiNDlhMjlkIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC03MTksNiAr
NzE5LDcgQEAgc3RhdGljIGludCBzbXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENISVBfVkVHQTIwOgor
CQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZfTUFTSzsKIAkJdmVnYTIwX3NldF9w
cHRfZnVuY3Moc211KTsKIAkJYnJlYWs7CiAJY2FzZSBDSElQX05BVkkxMDoKQEAgLTcyNyw2ICs3
MjgsNyBAQCBzdGF0aWMgaW50IHNtdV9zZXRfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJCW5hdmkxMF9zZXRfcHB0X2Z1bmNzKHNtdSk7CiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9B
UkNUVVJVUzoKKwkJYWRldi0+cG0ucHBfZmVhdHVyZSAmPSB+UFBfR0ZYT0ZGX01BU0s7CiAJCWFy
Y3R1cnVzX3NldF9wcHRfZnVuY3Moc211KTsKIAkJLyogT0QgaXMgbm90IHN1cHBvcnRlZCBvbiBB
cmN0dXJ1cyAqLwogCQlzbXUtPm9kX2VuYWJsZWQgPWZhbHNlOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMKaW5kZXggYTI0YmVhYTRmYjAxLi40NDM2MjVjODNl
YzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdy
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYwpAQCAt
ODEsNiArODEsOCBAQCBzdGF0aWMgdm9pZCBod21ncl9pbml0X3dvcmtsb2FkX3Byb3JpdHkoc3Ry
dWN0IHBwX2h3bWdyICpod21ncikKIAogaW50IGh3bWdyX2Vhcmx5X2luaXQoc3RydWN0IHBwX2h3
bWdyICpod21ncikKIHsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGh3bWdyLT5hZGV2
OworCiAJaWYgKCFod21ncikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKQEAgLTk2LDYgKzk4LDcgQEAg
aW50IGh3bWdyX2Vhcmx5X2luaXQoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAogCXN3aXRjaCAo
aHdtZ3ItPmNoaXBfZmFtaWx5KSB7CiAJY2FzZSBBTURHUFVfRkFNSUxZX0NJOgorCQlhZGV2LT5w
bS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZfTUFTSzsKIAkJaHdtZ3ItPnNtdW1ncl9mdW5jcyA9
ICZjaV9zbXVfZnVuY3M7CiAJCWNpX3NldF9hc2ljX3NwZWNpYWxfY2Fwcyhod21ncik7CiAJCWh3
bWdyLT5mZWF0dXJlX21hc2sgJj0gfihQUF9WQklfVElNRV9TVVBQT1JUX01BU0sgfApAQCAtMTA2
LDEyICsxMDksMTQgQEAgaW50IGh3bWdyX2Vhcmx5X2luaXQoc3RydWN0IHBwX2h3bWdyICpod21n
cikKIAkJc211N19pbml0X2Z1bmN0aW9uX3BvaW50ZXJzKGh3bWdyKTsKIAkJYnJlYWs7CiAJY2Fz
ZSBBTURHUFVfRkFNSUxZX0NaOgorCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZf
TUFTSzsKIAkJaHdtZ3ItPm9kX2VuYWJsZWQgPSBmYWxzZTsKIAkJaHdtZ3ItPnNtdW1ncl9mdW5j
cyA9ICZzbXU4X3NtdV9mdW5jczsKIAkJaHdtZ3ItPmZlYXR1cmVfbWFzayAmPSB+UFBfR0ZYT0ZG
X01BU0s7CiAJCXNtdThfaW5pdF9mdW5jdGlvbl9wb2ludGVycyhod21ncik7CiAJCWJyZWFrOwog
CWNhc2UgQU1ER1BVX0ZBTUlMWV9WSToKKwkJYWRldi0+cG0ucHBfZmVhdHVyZSAmPSB+UFBfR0ZY
T0ZGX01BU0s7CiAJCWh3bWdyLT5mZWF0dXJlX21hc2sgJj0gflBQX0dGWE9GRl9NQVNLOwogCQlz
d2l0Y2ggKGh3bWdyLT5jaGlwX2lkKSB7CiAJCWNhc2UgQ0hJUF9UT1BBWjoKQEAgLTE1Myw2ICsx
NTgsNyBAQCBpbnQgaHdtZ3JfZWFybHlfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCWNh
c2UgQU1ER1BVX0ZBTUlMWV9BSToKIAkJc3dpdGNoIChod21nci0+Y2hpcF9pZCkgewogCQljYXNl
IENISVBfVkVHQTEwOgorCQkJYWRldi0+cG0ucHBfZmVhdHVyZSAmPSB+UFBfR0ZYT0ZGX01BU0s7
CiAJCQlod21nci0+ZmVhdHVyZV9tYXNrICY9IH5QUF9HRlhPRkZfTUFTSzsKIAkJCWh3bWdyLT5z
bXVtZ3JfZnVuY3MgPSAmdmVnYTEwX3NtdV9mdW5jczsKIAkJCXZlZ2ExMF9od21ncl9pbml0KGh3
bWdyKTsKQEAgLTE2Miw2ICsxNjgsNyBAQCBpbnQgaHdtZ3JfZWFybHlfaW5pdChzdHJ1Y3QgcHBf
aHdtZ3IgKmh3bWdyKQogCQkJdmVnYTEyX2h3bWdyX2luaXQoaHdtZ3IpOwogCQkJYnJlYWs7CiAJ
CWNhc2UgQ0hJUF9WRUdBMjA6CisJCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZf
TUFTSzsKIAkJCWh3bWdyLT5mZWF0dXJlX21hc2sgJj0gflBQX0dGWE9GRl9NQVNLOwogCQkJaHdt
Z3ItPnNtdW1ncl9mdW5jcyA9ICZ2ZWdhMjBfc211X2Z1bmNzOwogCQkJdmVnYTIwX2h3bWdyX2lu
aXQoaHdtZ3IpOwotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
