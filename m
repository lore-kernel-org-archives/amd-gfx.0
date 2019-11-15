Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3252BC43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114032073B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114032073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A1D6E84F;
	Fri, 15 Nov 2019 15:29:01 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D0A6E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 15:29:00 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id o11so11160533qtr.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 07:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OLgVcvmt42wHQDovME0O655huiurgGBc88/7JF2wUVU=;
 b=EzROgdoieAbD+xiwOpvrKJY8iznlp28kDJYl+VxZtH3ZJE/Kk3btGJey62IaZRIqmf
 Tgmxf11nkS+kLUw2hgiSp6HBygQ3qfNNVm1mGT/VnspoFe1nhjZ05QIkphMKpj8HuNqp
 0dDSGimPeLUve8KLPkjR3kMMuMd0cTR+p7sbY6nLLsSjx13no0g0Etg8qoVd/NLpvRSW
 9lbBgnBAMHL1sGHysm0X8/3KIHq3n9RDX/5zn+BsBDrJzAbyt53Cj1ttumOSILDgrDzC
 mzEv+pYoDldbZNNBJCGztH9hVDJIic3xVUvBupfYTpkNHd04my0oMLjlPdodPS2YtVDj
 SwgQ==
X-Gm-Message-State: APjAAAU6yrOkQhf4oHtfB0ip3Z63OM2yZCvwVhTPGW/bGI85xuvsJ/tv
 mdaf4RhkothUaMc1x72Om5q7WHQp
X-Google-Smtp-Source: APXvYqxLhLZJQp6pq4b6T2RiZ8cyAXGe/u9FgQkiSAVRnjp+Xlcl5Iche0/rPvefJjECmjEjvZ7X9w==
X-Received: by 2002:aed:3e96:: with SMTP id n22mr14155117qtf.73.1573831739237; 
 Fri, 15 Nov 2019 07:28:59 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id n66sm4466227qkb.72.2019.11.15.07.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:28:58 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] Revert "drm/amd/display: enable S/G for RAVEN chip"
Date: Fri, 15 Nov 2019 10:28:50 -0500
Message-Id: <20191115152850.618879-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115152850.618879-1-alexander.deucher@amd.com>
References: <20191115152850.618879-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OLgVcvmt42wHQDovME0O655huiurgGBc88/7JF2wUVU=;
 b=WPfw2kFJx5MB+itYFnrqbKaCx5Lbs3+2oNbDDPaFvK/ftwG0Ureirr7JExWjG9M+m3
 3QcdPy7iJGzBxp6IIYOw9iKkpjgVBq+fTGIgB7KobuFqUWuJH08hRG2mJr30kOcYZUqX
 tZSBNRAiuuizJ64YP4gCTAUZQX5M4Modzg4QUI8PDtl4/wWJcMBeCLqjv+DHR8luKyTQ
 LvfGTDtxmxIK5M5YLK65UrO6MBzbrc3fkPIU/Xq1PFprYxj7kyT+l8B4C7OH2PHIjAkQ
 bn3AeKuS4HBsEmzjLNZl24DDGmhteOYVm/keRPWavQ4tOu1wvhqi3nKVVnDnqQ3lXuYB
 z/aQ==
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
Message-ID: <20191115152850.x2uQ87yliuizYK3Ea0I7KNjxtp2Hp2IGnw93YO0vcOY@z>

VGhpcyByZXZlcnRzIGNvbW1pdCAxYzQyNTkxNTkxMzJhZTRjZWFmN2M2ZGIzN2E2Y2Y3NjQxN2Y3
M2Q5LgoKUy9HIGRpc3BsYXkgaXMgbm90IHN0YWJsZSB3aXRoIHRoZSBJT01NVSBlbmFibGVkIG9u
IHNvbWUKcGxhdGZvcm1zLgoKQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTIwNTUyMwpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c3BsYXkuYyAgICAgICB8IDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3Bs
YXkuYwppbmRleCA2YTI3MDI3YTZmMjAuLjRlNjk5MDcxZDE0NCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCkBAIC01MTQsNyArNTE0LDcgQEAgdWludDMy
X3QgYW1kZ3B1X2Rpc3BsYXlfc3VwcG9ydGVkX2RvbWFpbnMoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAJICogQWxzbywgZG9uJ3QgYWxsb3cgR1RUIGRvbWFpbiBpZiB0aGUgQk8gZG9lbnMn
dCBoYXZlIFVTV0MgZmFsZyBzZXQuCiAJICovCiAJaWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQ
X0NBUlJJWk8gJiYKLQkgICAgYWRldi0+YXNpY190eXBlIDw9IENISVBfUkFWRU4gJiYKKwkgICAg
YWRldi0+YXNpY190eXBlIDwgQ0hJUF9SQVZFTiAmJgogCSAgICAoYWRldi0+ZmxhZ3MgJiBBTURf
SVNfQVBVKSAmJgogCSAgICAoYm9fZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VT
V0MpICYmCiAJICAgIGFtZGdwdV9ib19zdXBwb3J0X3Vzd2MoYm9fZmxhZ3MpICYmCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCBj
MjcwMGJjMjhjMDIuLmQ5NTJiNjUyZDUwNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBAIC05MjksNyArOTI5LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfZG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkgKi8KIAlp
ZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmCiAJICAgIGFkZXYtPmFzaWNfdHlwZSA+PSBD
SElQX0NBUlJJWk8gJiYKLQkgICAgYWRldi0+YXNpY190eXBlIDw9IENISVBfUkFWRU4pCisJICAg
IGFkZXYtPmFzaWNfdHlwZSA8IENISVBfUkFWRU4pCiAJCWluaXRfZGF0YS5mbGFncy5ncHVfdm1f
c3VwcG9ydCA9IHRydWU7CiAKIAlpZiAoYW1kZ3B1X2RjX2ZlYXR1cmVfbWFzayAmIERDX0ZCQ19N
QVNLKQotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
