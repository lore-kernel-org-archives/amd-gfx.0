Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93464C4727D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E90207C3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPPR5JfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E90207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484AB6E878;
	Tue, 22 Sep 2020 13:32:27 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8DE6E86E;
 Tue, 22 Sep 2020 13:32:16 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id c8so16180968edv.5;
 Tue, 22 Sep 2020 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Eb67u7mOJ0u5yXWzhxHN2pF59S7g9xP9PmxaS5dUJpY=;
 b=WPPR5JfM9zK9/wBcwEw83fmHZFZ2KS5XoLf96OE/djNpBXnDkPkGNe/7vwCZOPAbx5
 1mt2t77v7LvRTGg9B4i3eExVud2Xw69M7fpUsfq1hewqpnbCoSPuf0f+/tGsdCf0MGvQ
 j6RDPvRypr2wGXZzKGPTYbeuYk0cJIVExHx3gOn3WfpPMrKAF2LwDUBSjV8ud8Uc/qW/
 wwcOap4Xts48FM45hJ0am6NjSvh6VMKHucyFirAew3B79SN42p3S70Ee+OIyioHm01+q
 ZgvtsYtt51F+GAWdgNU5oEORbY2gEXvycamHiQPef0mvB+F08I1q73CHWueRzD3QuP7y
 MD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eb67u7mOJ0u5yXWzhxHN2pF59S7g9xP9PmxaS5dUJpY=;
 b=MmM85TZ/Vfc/ALrWmCSqa1e3o2JLCWib6j0/z6wTTQV7eWGxkF2SJXPMSgii224Fo6
 Vd6lfbL9IOQzCEJVkKUz8NLWPvT0ytm4hPnaZ/3dqisHfXUaLG9mOA9wMhDuqvt4QpGT
 a+Sz5iGcpVzn2ci3YCCvXTca1L6c3mNxqanOPTz5+aTU170lhs0UoaiUfBUH8RJvWnYB
 9hErCArF1K3qNZPfUEW/OYfCXFX7iDw4UCrSZkifhXwIaKNwTCv0eZaL8KQBkMGZXppZ
 XDJ1+0mYdQGLxjKWKITpZMZPQ/m45blVXumwwY1KMWZ0H6xLy2a5DZ5OqSLS+MUmFRHa
 JUfg==
X-Gm-Message-State: AOAM530jI48LxAIMEG7PrE9MGRR3a2cXj12P1mXeaO1qJ+Je4AsZaLW7
 cxuOpi+2zVWUEqnCZ2P1GF0=
X-Google-Smtp-Source: ABdhPJzYmBiBmlkA0vPW9huI5qc12V9oDGmk51uF9Il8C7BvorfkzUmLuKWO139krdegoNNkCejnLQ==
X-Received: by 2002:a50:8881:: with SMTP id d1mr3984071edd.306.1600781535566; 
 Tue, 22 Sep 2020 06:32:15 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:11af:3d77:a1c7:4f3a])
 by smtp.gmail.com with ESMTPSA id z21sm11541028eja.72.2020.09.22.06.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 06:32:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-graphics-maintainer@vmware.com, sroland@vmware.com, airlied@linux.ie,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, ray.huang@amd.com
Subject: [PATCH 06/11] drm/vram-helper: switch over to the new pin interface
Date: Tue, 22 Sep 2020 15:32:03 +0200
Message-Id: <20200922133208.1273-6-christian.koenig@amd.com>
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

U3RvcCB1c2luZyBUVE1fUExfRkxBR19OT19FVklDVC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IFRob21hcyBaaW1t
ZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2Vt
X3ZyYW1faGVscGVyLmMgfCAzNyArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGluY2x1ZGUv
ZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIuaCAgICAgfCAgMyAtLS0KIDIgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2dlbV92cmFtX2hlbHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fdnJh
bV9oZWxwZXIuYwppbmRleCA1MGNhZDBlNGE5MmUuLmJkM2RkMTdhZDgxZCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vZHJtX2dlbV92cmFtX2hlbHBlci5jCkBAIC0zMDEsNyArMzAxLDcgQEAgc3RhdGljIHU2NCBk
cm1fZ2VtX3ZyYW1fcGdfb2Zmc2V0KHN0cnVjdCBkcm1fZ2VtX3ZyYW1fb2JqZWN0ICpnYm8pCiAg
Ki8KIHM2NCBkcm1fZ2VtX3ZyYW1fb2Zmc2V0KHN0cnVjdCBkcm1fZ2VtX3ZyYW1fb2JqZWN0ICpn
Ym8pCiB7Ci0JaWYgKFdBUk5fT05fT05DRSghZ2JvLT5waW5fY291bnQpKQorCWlmIChXQVJOX09O
X09OQ0UoIWdiby0+Ym8ucGluX2NvdW50KSkKIAkJcmV0dXJuIChzNjQpLUVOT0RFVjsKIAlyZXR1
cm4gZHJtX2dlbV92cmFtX3BnX29mZnNldChnYm8pIDw8IFBBR0VfU0hJRlQ7CiB9CkBAIC0zMTAs
MjQgKzMxMCwyMSBAQCBFWFBPUlRfU1lNQk9MKGRybV9nZW1fdnJhbV9vZmZzZXQpOwogc3RhdGlj
IGludCBkcm1fZ2VtX3ZyYW1fcGluX2xvY2tlZChzdHJ1Y3QgZHJtX2dlbV92cmFtX29iamVjdCAq
Z2JvLAogCQkJCSAgIHVuc2lnbmVkIGxvbmcgcGxfZmxhZykKIHsKLQlpbnQgaSwgcmV0OwogCXN0
cnVjdCB0dG1fb3BlcmF0aW9uX2N0eCBjdHggPSB7IGZhbHNlLCBmYWxzZSB9OworCWludCByZXQ7
CiAKLQlpZiAoZ2JvLT5waW5fY291bnQpCisJaWYgKGdiby0+Ym8ucGluX2NvdW50KQogCQlnb3Rv
IG91dDsKIAogCWlmIChwbF9mbGFnKQogCQlkcm1fZ2VtX3ZyYW1fcGxhY2VtZW50KGdibywgcGxf
ZmxhZyk7CiAKLQlmb3IgKGkgPSAwOyBpIDwgZ2JvLT5wbGFjZW1lbnQubnVtX3BsYWNlbWVudDsg
KytpKQotCQlnYm8tPnBsYWNlbWVudHNbaV0uZmxhZ3MgfD0gVFRNX1BMX0ZMQUdfTk9fRVZJQ1Q7
Ci0KIAlyZXQgPSB0dG1fYm9fdmFsaWRhdGUoJmdiby0+Ym8sICZnYm8tPnBsYWNlbWVudCwgJmN0
eCk7CiAJaWYgKHJldCA8IDApCiAJCXJldHVybiByZXQ7CiAKIG91dDoKLQkrK2diby0+cGluX2Nv
dW50OworCXR0bV9ib19waW4oJmdiby0+Ym8pOwogCiAJcmV0dXJuIDA7CiB9CkBAIC0zNjksMjYg
KzM2Niw5IEBAIGludCBkcm1fZ2VtX3ZyYW1fcGluKHN0cnVjdCBkcm1fZ2VtX3ZyYW1fb2JqZWN0
ICpnYm8sIHVuc2lnbmVkIGxvbmcgcGxfZmxhZykKIH0KIEVYUE9SVF9TWU1CT0woZHJtX2dlbV92
cmFtX3Bpbik7CiAKLXN0YXRpYyBpbnQgZHJtX2dlbV92cmFtX3VucGluX2xvY2tlZChzdHJ1Y3Qg
ZHJtX2dlbV92cmFtX29iamVjdCAqZ2JvKQorc3RhdGljIHZvaWQgZHJtX2dlbV92cmFtX3VucGlu
X2xvY2tlZChzdHJ1Y3QgZHJtX2dlbV92cmFtX29iamVjdCAqZ2JvKQogewotCWludCBpLCByZXQ7
Ci0Jc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4IGN0eCA9IHsgZmFsc2UsIGZhbHNlIH07Ci0KLQlp
ZiAoV0FSTl9PTl9PTkNFKCFnYm8tPnBpbl9jb3VudCkpCi0JCXJldHVybiAwOwotCi0JLS1nYm8t
PnBpbl9jb3VudDsKLQlpZiAoZ2JvLT5waW5fY291bnQpCi0JCXJldHVybiAwOwotCi0JZm9yIChp
ID0gMDsgaSA8IGdiby0+cGxhY2VtZW50Lm51bV9wbGFjZW1lbnQgOyArK2kpCi0JCWdiby0+cGxh
Y2VtZW50c1tpXS5mbGFncyAmPSB+VFRNX1BMX0ZMQUdfTk9fRVZJQ1Q7Ci0KLQlyZXQgPSB0dG1f
Ym9fdmFsaWRhdGUoJmdiby0+Ym8sICZnYm8tPnBsYWNlbWVudCwgJmN0eCk7Ci0JaWYgKHJldCA8
IDApCi0JCXJldHVybiByZXQ7Ci0KLQlyZXR1cm4gMDsKKwl0dG1fYm9fdW5waW4oJmdiby0+Ym8p
OwogfQogCiAvKioKQEAgLTQwNiwxMCArMzg2LDExIEBAIGludCBkcm1fZ2VtX3ZyYW1fdW5waW4o
c3RydWN0IGRybV9nZW1fdnJhbV9vYmplY3QgKmdibykKIAlyZXQgPSB0dG1fYm9fcmVzZXJ2ZSgm
Z2JvLT5ibywgdHJ1ZSwgZmFsc2UsIE5VTEwpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7Ci0J
cmV0ID0gZHJtX2dlbV92cmFtX3VucGluX2xvY2tlZChnYm8pOworCisJZHJtX2dlbV92cmFtX3Vu
cGluX2xvY2tlZChnYm8pOwogCXR0bV9ib191bnJlc2VydmUoJmdiby0+Ym8pOwogCi0JcmV0dXJu
IHJldDsKKwlyZXR1cm4gMDsKIH0KIEVYUE9SVF9TWU1CT0woZHJtX2dlbV92cmFtX3VucGluKTsK
IApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2dlbV92cmFtX2hlbHBlci5oIGIvaW5jbHVk
ZS9kcm0vZHJtX2dlbV92cmFtX2hlbHBlci5oCmluZGV4IDYyY2M2ZTZjM2E0Zi4uMTI4Zjg4MTc0
ZDMyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9kcm1fZ2VtX3ZyYW1faGVscGVyLmgKKysrIGIv
aW5jbHVkZS9kcm0vZHJtX2dlbV92cmFtX2hlbHBlci5oCkBAIC0zNSw3ICszNSw2IEBAIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdDsKICAqIEBwbGFjZW1lbnQ6CVRUTSBwbGFjZW1lbnQgaW5mb3JtYXRp
b24uIFN1cHBvcnRlZCBwbGFjZW1lbnRzIGFyZSBcCiAJJVRUTV9QTF9WUkFNIGFuZCAlVFRNX1BM
X1NZU1RFTQogICogQHBsYWNlbWVudHM6CVRUTSBwbGFjZW1lbnQgaW5mb3JtYXRpb24uCi0gKiBA
cGluX2NvdW50OglQaW4gY291bnRlcgogICoKICAqIFRoZSB0eXBlIHN0cnVjdCBkcm1fZ2VtX3Zy
YW1fb2JqZWN0IHJlcHJlc2VudHMgYSBHRU0gb2JqZWN0IHRoYXQgaXMKICAqIGJhY2tlZCBieSBW
UkFNLiBJdCBjYW4gYmUgdXNlZCBmb3Igc2ltcGxlIGZyYW1lYnVmZmVyIGRldmljZXMgd2l0aApA
QCAtNjQsOCArNjMsNiBAQCBzdHJ1Y3QgZHJtX2dlbV92cmFtX29iamVjdCB7CiAJLyogU3VwcG9y
dGVkIHBsYWNlbWVudHMgYXJlICVUVE1fUExfVlJBTSBhbmQgJVRUTV9QTF9TWVNURU0gKi8KIAlz
dHJ1Y3QgdHRtX3BsYWNlbWVudCBwbGFjZW1lbnQ7CiAJc3RydWN0IHR0bV9wbGFjZSBwbGFjZW1l
bnRzWzJdOwotCi0JaW50IHBpbl9jb3VudDsKIH07CiAKIC8qKgotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
