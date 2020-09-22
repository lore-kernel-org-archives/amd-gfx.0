Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03904C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0B0207C3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/H8Iys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0B0207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C56A6E885;
	Tue, 22 Sep 2020 13:32:46 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34ED56E86E;
 Tue, 22 Sep 2020 13:32:21 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id p9so22896248ejf.6;
 Tue, 22 Sep 2020 06:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gAZD3x5VykasyIbtJagFDzDdJj6Xtk55XEkRgouYaPw=;
 b=dJ/H8IysREOknJr3zuT+zLV4wQE5lSMnlTc581J0nPfiI5QN8BxO6uRSWqCloypyuV
 gGSNGTBXeNim3nxpPPPMcInyd16SG3VT4AuC2JP6R5p+V5r84Fe2gC9lw+cko6DDI/N0
 bB4pOYLN759YJ6ifmuHMCIHELlkgIqHH7cLRwRmT3LWNCvwCL/wEuGJmgOR3Tbkost/a
 1MNIBdNCESFKrNraLR1+FO7+lNyG3aSHhcfb7qVu0zegY20jW/irZrkkT8lIhzHoataz
 L6SOIB6WXn3CuP7lcIy0upbt2LxzMhlULK7fUMU+LuOC7CIjHbGVbSxpm7sHwN7gPrEl
 GHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gAZD3x5VykasyIbtJagFDzDdJj6Xtk55XEkRgouYaPw=;
 b=PommbTdcZ3VONONC+UQ6lKHA14O7Pu0fvcWqWXk+D8+SgseSubzHnLVk6Z0bYzo1Cj
 dneEambkWgAY0bJPFB6SxgJpiy9eIISHKMkFETJYxfn1NTor/bP6x3pBBtwmyUQTLgnS
 HcLo3eBORlZO5BDq25ZzFK9vseTLExBi/FNbqy399orUpS7tpCiNpyq/HYdsAXMtuzJi
 3zqgjKix1GiJ92Kira9OYK8P5NhvoeD67HAadz21pzW14W1nUIa2fn4RPlOVmnkIK24N
 N+Cozmp9/IRjBTcp//lV0arcz8EJR+TpjpmKPU9qu+BQYckUbtunFbL2wTkO97OO8yN/
 1SOg==
X-Gm-Message-State: AOAM533/0hCco7OI+x2htIr0yZXXei0xwf/2s8CBEiD7RY+Z7exp7XUz
 auWvKF9rVHYiY6hn5emHqIY=
X-Google-Smtp-Source: ABdhPJy3aaCs3uOjTtEEJYs/AGwB8mCmWg0yHiVfRN+/nYb5/acwPX+KmM5QWmI4bMti1zoD0ZIMUA==
X-Received: by 2002:a17:906:b285:: with SMTP id
 q5mr4813056ejz.545.1600781539847; 
 Tue, 22 Sep 2020 06:32:19 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:11af:3d77:a1c7:4f3a])
 by smtp.gmail.com with ESMTPSA id z21sm11541028eja.72.2020.09.22.06.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 06:32:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-graphics-maintainer@vmware.com, sroland@vmware.com, airlied@linux.ie,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, ray.huang@amd.com
Subject: [PATCH 10/11] drm/ttm: remove ttm_bo_create
Date: Tue, 22 Sep 2020 15:32:07 +0200
Message-Id: <20200922133208.1273-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922133208.1273-1-christian.koenig@amd.com>
References: <20200922133208.1273-1-christian.koenig@amd.com>
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

Tm90IHVzZWQgYW55IG1vcmUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyB8
IDQwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9kcm0vdHRt
L3R0bV9ib19hcGkuaCB8IDI0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgNjQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
Ym8uYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKaW5kZXggYjgyYjQ5ZDQzOTQyLi4x
YTRiMjUwODMzMjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwpAQCAtMTI1NCwxOSArMTI1NCw2IEBAIGlu
dCB0dG1fYm9faW5pdChzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwKIH0KIEVYUE9SVF9TWU1C
T0wodHRtX2JvX2luaXQpOwogCi1zdGF0aWMgc2l6ZV90IHR0bV9ib19hY2Nfc2l6ZShzdHJ1Y3Qg
dHRtX2JvX2RldmljZSAqYmRldiwKLQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgYm9fc2l6ZSwKLQkJ
CSAgICAgIHVuc2lnbmVkIHN0cnVjdF9zaXplKQotewotCXVuc2lnbmVkIG5wYWdlcyA9IChQQUdF
X0FMSUdOKGJvX3NpemUpKSA+PiBQQUdFX1NISUZUOwotCXNpemVfdCBzaXplID0gMDsKLQotCXNp
emUgKz0gdHRtX3JvdW5kX3BvdChzdHJ1Y3Rfc2l6ZSk7Ci0Jc2l6ZSArPSB0dG1fcm91bmRfcG90
KG5wYWdlcyAqIHNpemVvZih2b2lkICopKTsKLQlzaXplICs9IHR0bV9yb3VuZF9wb3Qoc2l6ZW9m
KHN0cnVjdCB0dG1fdHQpKTsKLQlyZXR1cm4gc2l6ZTsKLX0KLQogc2l6ZV90IHR0bV9ib19kbWFf
YWNjX3NpemUoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsCiAJCQkgICB1bnNpZ25lZCBsb25n
IGJvX3NpemUsCiAJCQkgICB1bnNpZ25lZCBzdHJ1Y3Rfc2l6ZSkKQEAgLTEyODEsMzMgKzEyNjgs
NiBAQCBzaXplX3QgdHRtX2JvX2RtYV9hY2Nfc2l6ZShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRl
diwKIH0KIEVYUE9SVF9TWU1CT0wodHRtX2JvX2RtYV9hY2Nfc2l6ZSk7CiAKLWludCB0dG1fYm9f
Y3JlYXRlKHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LAotCQkJdW5zaWduZWQgbG9uZyBzaXpl
LAotCQkJZW51bSB0dG1fYm9fdHlwZSB0eXBlLAotCQkJc3RydWN0IHR0bV9wbGFjZW1lbnQgKnBs
YWNlbWVudCwKLQkJCXVpbnQzMl90IHBhZ2VfYWxpZ25tZW50LAotCQkJYm9vbCBpbnRlcnJ1cHRp
YmxlLAotCQkJc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICoqcF9ibykKLXsKLQlzdHJ1Y3QgdHRt
X2J1ZmZlcl9vYmplY3QgKmJvOwotCXNpemVfdCBhY2Nfc2l6ZTsKLQlpbnQgcmV0OwotCi0JYm8g
PSBremFsbG9jKHNpemVvZigqYm8pLCBHRlBfS0VSTkVMKTsKLQlpZiAodW5saWtlbHkoYm8gPT0g
TlVMTCkpCi0JCXJldHVybiAtRU5PTUVNOwotCi0JYWNjX3NpemUgPSB0dG1fYm9fYWNjX3NpemUo
YmRldiwgc2l6ZSwgc2l6ZW9mKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCkpOwotCXJldCA9IHR0
bV9ib19pbml0KGJkZXYsIGJvLCBzaXplLCB0eXBlLCBwbGFjZW1lbnQsIHBhZ2VfYWxpZ25tZW50
LAotCQkJICBpbnRlcnJ1cHRpYmxlLCBhY2Nfc2l6ZSwKLQkJCSAgTlVMTCwgTlVMTCwgTlVMTCk7
Ci0JaWYgKGxpa2VseShyZXQgPT0gMCkpCi0JCSpwX2JvID0gYm87Ci0KLQlyZXR1cm4gcmV0Owot
fQotRVhQT1JUX1NZTUJPTCh0dG1fYm9fY3JlYXRlKTsKLQogaW50IHR0bV9ib19ldmljdF9tbShz
dHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwgdW5zaWduZWQgbWVtX3R5cGUpCiB7CiAJc3RydWN0
IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4gPSB0dG1fbWFuYWdlcl90eXBlKGJkZXYsIG1lbV90
eXBlKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmggYi9pbmNsdWRl
L2RybS90dG0vdHRtX2JvX2FwaS5oCmluZGV4IDMzYWNhNjA4NzBlMi4uNmNiZTU5YmM5N2FiIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCisrKyBiL2luY2x1ZGUvZHJt
L3R0bS90dG1fYm9fYXBpLmgKQEAgLTQ0NywzMCArNDQ3LDYgQEAgaW50IHR0bV9ib19pbml0KHN0
cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LCBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAog
CQlzdHJ1Y3Qgc2dfdGFibGUgKnNnLCBzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YsCiAJCXZvaWQgKCpk
ZXN0cm95KSAoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICopKTsKIAotLyoqCi0gKiB0dG1fYm9f
Y3JlYXRlCi0gKgotICogQGJkZXY6IFBvaW50ZXIgdG8gYSB0dG1fYm9fZGV2aWNlIHN0cnVjdC4K
LSAqIEBzaXplOiBSZXF1ZXN0ZWQgc2l6ZSBvZiBidWZmZXIgb2JqZWN0LgotICogQHR5cGU6IFJl
cXVlc3RlZCB0eXBlIG9mIGJ1ZmZlciBvYmplY3QuCi0gKiBAcGxhY2VtZW50OiBJbml0aWFsIHBs
YWNlbWVudC4KLSAqIEBwYWdlX2FsaWdubWVudDogRGF0YSBhbGlnbm1lbnQgaW4gcGFnZXMuCi0g
KiBAaW50ZXJydXB0aWJsZTogSWYgbmVlZGluZyB0byBzbGVlcCB3aGlsZSB3YWl0aW5nIGZvciBH
UFUgcmVzb3VyY2VzLAotICogc2xlZXAgaW50ZXJydXB0aWJsZS4KLSAqIEBwX2JvOiBPbiBzdWNj
ZXNzZnVsIGNvbXBsZXRpb24gKnBfYm8gcG9pbnRzIHRvIHRoZSBjcmVhdGVkIG9iamVjdC4KLSAq
Ci0gKiBUaGlzIGZ1bmN0aW9uIGFsbG9jYXRlcyBhIHR0bV9idWZmZXJfb2JqZWN0LCBhbmQgdGhl
biBjYWxscyB0dG1fYm9faW5pdAotICogb24gdGhhdCBvYmplY3QuIFRoZSBkZXN0cm95IGZ1bmN0
aW9uIGlzIHNldCB0byBrZnJlZSgpLgotICogUmV0dXJucwotICogLUVOT01FTTogT3V0IG9mIG1l
bW9yeS4KLSAqIC1FSU5WQUw6IEludmFsaWQgcGxhY2VtZW50IGZsYWdzLgotICogLUVSRVNUQVJU
U1lTOiBJbnRlcnJ1cHRlZCBieSBzaWduYWwgd2hpbGUgd2FpdGluZyBmb3IgcmVzb3VyY2VzLgot
ICovCi1pbnQgdHRtX2JvX2NyZWF0ZShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwgdW5zaWdu
ZWQgbG9uZyBzaXplLAotCQkgIGVudW0gdHRtX2JvX3R5cGUgdHlwZSwgc3RydWN0IHR0bV9wbGFj
ZW1lbnQgKnBsYWNlbWVudCwKLQkJICB1aW50MzJfdCBwYWdlX2FsaWdubWVudCwgYm9vbCBpbnRl
cnJ1cHRpYmxlLAotCQkgIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqKnBfYm8pOwotCiAvKioK
ICAqIHR0bV9ib19ldmljdF9tbQogICoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
