Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A703DC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFD1206F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auHG+41H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFD1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B065E6F99C;
	Thu, 30 Jan 2020 12:49:47 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EDB6F99A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 12:49:45 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a5so3654529wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TeJUkUowH0Ej87BgXO0w/b7m9cuEeGknrSsbGDdVzO8=;
 b=auHG+41HOcRsIiFniVJ7lQ8TjjfkqYLIcrMBBI2DLWnYK6zfTWjgisRccj3HaYQTOS
 ORwzeILC4c2l5pEd5IEq5aCdbS1eFfIAWEfKPZWVfPbKTqA5d5vUBbhFmx+aLFocgKsK
 O/JzqSrGgY2urIgWsnFNv4s3oi7R/D+HkoGrAL9gbNu9CRoVzfTECTNrxihvNcmd3xzk
 jkBg8Kx9iOIKmfDDsRdpKaeMJQbnit5asZAwx/5ahQST092xvSN3uJwVHKEw5PlakOv+
 915x3mFQlhvL5TXXjkJNPAlgsz6+bQFl+g9DVJJlVMhhXHu20WtO1GUxehqDMXujq7t1
 FneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TeJUkUowH0Ej87BgXO0w/b7m9cuEeGknrSsbGDdVzO8=;
 b=Yp1nbDt7OPfZ5UOUEdRDLc8IoGyVvLJwl8gyH65OnPlmEBGLT8kjZLN3D8UbtA1DOe
 AMKhnKlOflHRCJeSxHzB7luOel2AY6VBqXN5VJvX8JqEsMNJD4R0+y+lXhKM7GsqM5N9
 gr4fz9+cY+B9XHyS+Dmgsd8AE/10r0GkjpFEprU/52B8tVTmM7YjqeLklbA5ni9+J+iN
 s/UeNgNkxrlxhiKkgW92yL3N6F7YahdSosOLzoORY6HCEgXIUkKnWobkH8FxAk4UWQ6p
 FS+ButgYILh+FmkHWwXiiKZo2fImK7MYw65GNHnCAktuPt3MxVXH6MRO/+somHxqXqtc
 Snuw==
X-Gm-Message-State: APjAAAXATwCz6C95LKu1/iqvQeRKvaYPZubtZXsxzwPjBdGq54a5/LpK
 irV0bZ1mIFKPRCqkrdai7cfhD6jC
X-Google-Smtp-Source: APXvYqwFvBZ7IYxSgdRaxRH+vPPCF7H4ZpqW3pd6jPVIt+Zuhr5iyNno+FdtTOaMtomOUyvc3dJ8pg==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr5828545wmg.13.1580388584192; 
 Thu, 30 Jan 2020 04:49:44 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:dc0f:106a:b4b9:c241])
 by smtp.gmail.com with ESMTPSA id i2sm6496912wmb.28.2020.01.30.04.49.43
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:49:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: return EINVAL instead of ENOENT in the VM code
Date: Thu, 30 Jan 2020 13:49:37 +0100
Message-Id: <20200130124940.30380-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130124940.30380-1-christian.koenig@amd.com>
References: <20200130124940.30380-1-christian.koenig@amd.com>
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

VGhhdCB3ZSBjYW4ndCBmaW5kIGEgUEQgYWJvdmUgdGhlIHJvb3QgaXMgZXhwZWN0ZWQgY2FuIG9u
bHkgaGFwcGVuIGlmCndlIHRyeSB0byB1cGRhdGUgYSBsYXJnZXIgcmFuZ2UgdGhhbiBhY3R1YWxs
eSBtYW5hZ2VkIGJ5IHRoZSBWTS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KVGVzdGVkLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRl
bmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDRiYTZhNWU1ZDA5NC4uOTcw
NWM5NjE0MDViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTQ3
NSw3ICsxNDc1LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFt
ZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCiAJCQkgKiBzaGlmdCB3ZSBzaG91bGQgZ28g
dXAgb25lIGxldmVsIGFuZCBjaGVjayBpdCBhZ2Fpbi4KIAkJCSAqLwogCQkJaWYgKCFhbWRncHVf
dm1fcHRfYW5jZXN0b3IoJmN1cnNvcikpCi0JCQkJcmV0dXJuIC1FTk9FTlQ7CisJCQkJcmV0dXJu
IC1FSU5WQUw7CiAJCQljb250aW51ZTsKIAkJfQogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
