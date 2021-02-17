Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C4C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5530164DE0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5530164DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8CA6E5CE;
	Wed, 17 Feb 2021 19:00:37 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F7E6E558
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 19:00:34 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id q10so17869825edt.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zk5YbaQ2wlF4SI9zzEK5NquqmdG2upu9yp94h/lr6JY=;
 b=PA8ntTe0ODc6exvtdoHflX8RohdufeHjeOXbd00vhQx4oELAL1G16basdhQKhmaqzD
 vV2PG5xH3gR2ERFIKo303HVMMUfWGPYCGIBDrKkwQsIwjd+rAw3gewGlyp4hv0w+fNOE
 D8WVeF2UQIH2udYeLBMU/V9jCaDyT+wAvPle5OYMyXdwIDZAKxBvk0lY6UBAOcNj+yZc
 YI1dtXwfQY4+IQNr6um46+a5NtFAaJW+BJhilhQsTrbLwXFWk7BMHgLRPErySSO/ojyX
 WGg4x/wYdyF0Wys8T/D805jf/AlTDdeDySsZf/akde/atScAa/0qAc9s2WXMevMbduc3
 ZTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zk5YbaQ2wlF4SI9zzEK5NquqmdG2upu9yp94h/lr6JY=;
 b=dfu7biynUuOFxVrg9SgkltV7tBCBbm18n30X98YPR5LXg+MeoSw4KBlUF6y+BWWUOb
 L+dDo3wbScKI2nUqeVqy802SHYixv5RFXv1p878u156QsSmIwPYsxSH/0O+cvN3DGOYY
 iNDmWREGJM1qARiXB+5vW5z6BaZQh45uEl6/jTcMi7333doHjmYqzCDl+ynXW/wz+Q1Q
 weyPBCLYD0gZVXRdB42wlKQ/0+lZcLvPu0T1eheFf9HOg0MSLC9EzcxcZvV7NPhD7ioX
 Ie871zUfiOEB1Zm3eKFXTJd9ZnU8ycoraAlx3OFy6r1XwnvR5rdcO5p0oT683G7ipQn/
 6CYw==
X-Gm-Message-State: AOAM532D5EIJiHUI8jXHi9jEaZKacWYGtpIU2C848NxcW4LWe8WZMhxQ
 yws+yBT6k2qsL59WSdHBP7U=
X-Google-Smtp-Source: ABdhPJzHdMnLYTw3xGvdLESWPwOy3uEqCuYjjVCfybhUKJai+T4WPvpsnGOSdTcCqD4DaVRNtPSuGw==
X-Received: by 2002:aa7:c95a:: with SMTP id h26mr299289edt.166.1613588433657; 
 Wed, 17 Feb 2021 11:00:33 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b7c6:d2d7:631c:11b7])
 by smtp.gmail.com with ESMTPSA id r4sm1562710edv.27.2021.02.17.11.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:00:33 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: use new cursor in amdgpu_mem_visible
Date: Wed, 17 Feb 2021 20:00:26 +0100
Message-Id: <20210217190028.16409-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
References: <20210217190028.16409-1-christian.koenig@amd.com>
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDEwICsr
KysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IDIwNDk5OWQ0OWZh
OC4uOGVjODBhMzg0YmUzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
CkBAIC01NjAsNyArNTYwLDggQEAgc3RhdGljIGludCBhbWRncHVfbW92ZV9yYW1fdnJhbShzdHJ1
Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBib29sIGV2aWN0LAogc3RhdGljIGJvb2wgYW1kZ3B1
X21lbV92aXNpYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAgICAgIHN0cnVj
dCB0dG1fcmVzb3VyY2UgKm1lbSkKIHsKLQlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGVzID0gbWVt
LT5tbV9ub2RlOworCXVpbnQ2NF90IG1lbV9zaXplID0gKHU2NCltZW0tPm51bV9wYWdlcyA8PCBQ
QUdFX1NISUZUOworCXN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciBjdXJzb3I7CiAKIAlpZiAobWVt
LT5tZW1fdHlwZSA9PSBUVE1fUExfU1lTVEVNIHx8CiAJICAgIG1lbS0+bWVtX3R5cGUgPT0gVFRN
X1BMX1RUKQpAQCAtNTY4LDEyICs1NjksMTMgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X21lbV92aXNp
YmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChtZW0tPm1lbV90eXBlICE9IFRU
TV9QTF9WUkFNKQogCQlyZXR1cm4gZmFsc2U7CiAKKwlhbWRncHVfcmVzX2ZpcnN0KG1lbSwgMCwg
bWVtX3NpemUsICZjdXJzb3IpOworCiAJLyogdHRtX3Jlc291cmNlX2lvcmVtYXAgb25seSBzdXBw
b3J0cyBjb250aWd1b3VzIG1lbW9yeSAqLwotCWlmIChub2Rlcy0+c2l6ZSAhPSBtZW0tPm51bV9w
YWdlcykKKwlpZiAoY3Vyc29yLnNpemUgIT0gbWVtX3NpemUpCiAJCXJldHVybiBmYWxzZTsKIAot
CXJldHVybiAoKG5vZGVzLT5zdGFydCArIG5vZGVzLT5zaXplKSA8PCBQQUdFX1NISUZUKQotCQk8
PSBhZGV2LT5nbWMudmlzaWJsZV92cmFtX3NpemU7CisJcmV0dXJuIGN1cnNvci5zdGFydCArIGN1
cnNvci5zaXplIDw9IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZTsKIH0KIAogLyoKLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
