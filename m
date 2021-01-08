Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A964C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B422399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B422399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C2F6E90E;
	Fri,  8 Jan 2021 20:24:24 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15EE6E8C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:13 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id g185so9441051wmf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q1ACHhoDM3J5dELVH57xIAQUcf34vzdyN5ALWF0ycEQ=;
 b=RobXHiCalmxUMxBiwWjqlom0EWAsiBTcsj1Ei8+x90LUZCySBXgpU8xTX9j2i46Rr3
 KSEcIB2YfsMjrstXrKYwkRG9S1If6LX4l2XOFGd7hNeAZrjH6sXILEd0IAS6XiFAQOgP
 oPfRfGEI174ndsVXFXEAz/OemllVs6/5jWzo3rBlLT0dR2vnoBtSk5InuOzokUvtH8RJ
 MbVPJkJv5LWD4s19zLMoylEtumeVPqUuJaIuxcUHvNwlTm6fgh+SlhRWIRYdDDGerMJF
 vmL8H/PY2X2kTd3fyJBMupz9k0C8eoN5qBx+vAeLkglLl/mqFwST4u7pA+1GkBiup3HT
 zhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q1ACHhoDM3J5dELVH57xIAQUcf34vzdyN5ALWF0ycEQ=;
 b=ioVsUfs8jAMH3EphWtJ9arIWtbUmssRsdKKmJtjQumRri3Xzjfax47+1DV2UcfSBHx
 vmJ43XtbN4lxps4aMZBpYxeW97KIzKnrMKSFZDigXRc/ot5VytcwoVnqouqpl2HOLHUR
 1LElWhvyTo3lMS/bY34pXSSVzTPYPqOLZH5L7kpdgxAY5hWiZb6QF31JXDNQlxyfzZ5Z
 Eg6RDONkWnT0H7Zwc0IRA3IgL7dwLT8M5E6WUo+p7cEF6q9hTm0cVcaFur+NS0jCIe/H
 u63wncPIhbF0LR7eoZ13mMua+0VfeyP7pDbN2bc6PYP7MDPcx2Fo4LIVJWOt6YERvyoz
 VNEA==
X-Gm-Message-State: AOAM530+PxfOkagnBwx+ouQ8Xu2DH27GVZJuNZt4Jtw/p7W0WHaRXk7Y
 p2J2ufeeutvUea4/ZVjSudCmbA==
X-Google-Smtp-Source: ABdhPJwIiHZnNFkLdYTqXNaGhsCT91nMtjQP7O3ZYXC9abXxyA0R72iKa5HOrjtFAsz6QNJH+FjOTA==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr4578911wmc.39.1610136912570;
 Fri, 08 Jan 2021 12:15:12 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:11 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/40] drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0:
 Provide description of 'call_back_func'
Date: Fri,  8 Jan 2021 20:14:23 +0000
Message-Id: <20210108201457.3078600-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3Byb2Nlc3NfcHB0YWJs
ZXNfdjFfMC5jOjEzNzE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Nh
bGxfYmFja19mdW5jJyBub3QgZGVzY3JpYmVkIGluICdnZXRfcG93ZXJwbGF5X3RhYmxlX2VudHJ5
X3YxXzAnCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4Lmll
PgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVk
LW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9wcm9jZXNzX3BwdGFibGVzX3YxXzAuYyB8IDEg
KwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHJvY2Vzc19wcHRhYmxlc192MV8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9wcm9jZXNzX3BwdGFibGVzX3Yx
XzAuYwppbmRleCA3NDFlMDNhZDUzMTFmLi5mMmE1NWMxNDEzZjU5IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9wcm9jZXNzX3BwdGFibGVzX3YxXzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9wcm9jZXNzX3Bw
dGFibGVzX3YxXzAuYwpAQCAtMTM2Miw2ICsxMzYyLDcgQEAgc3RhdGljIGludCBwcHRfZ2V0X3Zj
ZV9zdGF0ZV90YWJsZV9lbnRyeV92MV8wKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIHVpbnQzMl90
IGkKICAqIEBod21ncjogUG9pbnRlciB0byB0aGUgaGFyZHdhcmUgbWFuYWdlci4KICAqIEBlbnRy
eV9pbmRleDogVGhlIGluZGV4IG9mIHRoZSBlbnRyeSB0byBiZSBleHRyYWN0ZWQgZnJvbSB0aGUg
dGFibGUuCiAgKiBAcG93ZXJfc3RhdGU6IFRoZSBhZGRyZXNzIG9mIHRoZSBQb3dlclN0YXRlIGlu
c3RhbmNlIGJlaW5nIGNyZWF0ZWQuCisgKiBAY2FsbF9iYWNrX2Z1bmM6IFRoZSBmdW5jdGlvbiB0
byBjYWxsIGludG8gdG8gZmlsbCBwb3dlciBzdGF0ZQogICogUmV0dXJuOiAtMSBpZiB0aGUgZW50
cnkgY2Fubm90IGJlIHJldHJpZXZlZC4KICAqLwogaW50IGdldF9wb3dlcnBsYXlfdGFibGVfZW50
cnlfdjFfMChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAotLSAKMi4yNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
