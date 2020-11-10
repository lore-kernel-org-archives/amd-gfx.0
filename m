Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1150C63777
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EF720678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFqI6aqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EF720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3227789CD3;
	Tue, 10 Nov 2020 19:35:53 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8872289BFC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:42 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c9so4342430wml.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FO92cL0QjF/6Dy4FIvl+P0IasJ1CYr1sR86S5Uq88PQ=;
 b=tFqI6aqT9V0J73yOVy/As6jFhTZnzDFC3gBR73vSwhOML2NlW3/13opSb0++qsLvrq
 d6zBUZPpWQGXuYx6E5PVuNnX/o4KbeH6ZHx1M8Hz8Ek8zLEShZOcpZlXmis/hKhlod+y
 ZIIyb2JDTqXbPcX5rHohL6LOAoQuoWGtn2YbJGg8UaY9XuhZqcbkjO7zcx9Uxnb6yFRF
 NU0X0tOov9irRbLq9JiYub1od4CmmXk7ckxkzpm9LC9/WxgqHwD4/ZrU50La4T54DUOZ
 Qu3RbX8ch0cHg4o/cSUxoaWOGGMwt3D1gl/w+8JLU/AWVNdmhP0OGlZE9uNKqH320MeF
 9dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FO92cL0QjF/6Dy4FIvl+P0IasJ1CYr1sR86S5Uq88PQ=;
 b=XcawHjp3vyhWrOh7ydNrrXYLUOr98JleYqN1ftlq0CrIh/WdDJaBkI5oFxeQd2EQ2D
 3N6vl2YOpCsXiZVNvuVYzq/3XedniERRTps1pYnEzpyvYN9Db7C7YYuI4YXkUNBDaxkK
 JXUdtljPE9mkwPRTplSe395PH4U0gkaIShLS9HcwFhY/g1rj0USgmf9PIYtjTscKzlyL
 jO/W3hzKS6HChrSc3Sxx9vEvZr52RBIwH0zL9DagN78KDq/m3onNrPMa2f8A1XOfZZpu
 1xmkyD9bm6NXUqA4RMWDL9jGc+9FZaV+vW6IfgqCfodxV7db1OrFB4A8HSUu/xWgSoU+
 AUYA==
X-Gm-Message-State: AOAM532TCvfauQamNaaubjL5QbMteB3VmyBd0J5BkJXiX2/4Ic9VB47i
 BQslswtkFdvp6mtVXsqGHrgsFw==
X-Google-Smtp-Source: ABdhPJwi0mRoMPTaC+iz+dNbvhBdCvFOfNPNWeY3B4R74Bkz1ECRu6hN6qcnliXZkCtMVHnEr+K4zw==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr742033wmf.133.1605036701212; 
 Tue, 10 Nov 2020 11:31:41 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 20/30] drm/radeon/radeon_drv: Move
 'radeon_driver_irq_handler_kms's prototype into shared header
Date: Tue, 10 Nov 2020 19:31:02 +0000
Message-Id: <20201110193112.988999-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
 Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjUzOjEzOiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9kcml2ZXJfaXJxX2hhbmRsZXJfa21z4oCZIFst
V21pc3NpbmctcHJvdG90eXBlc10KIDUzIHwgaXJxcmV0dXJuX3QgcmFkZW9uX2RyaXZlcl9pcnFf
aGFuZGxlcl9rbXMoaW50IGlycSwgdm9pZCAqYXJnKQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjEyMDo2OiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9kcml2ZXJfaXJxX3By
ZWluc3RhbGxfa21z4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDEyMCB8IHZvaWQgcmFkZW9u
X2RyaXZlcl9pcnFfcHJlaW5zdGFsbF9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldikKIHwgXn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2lycV9rbXMuYzoxNTI6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDi
gJhyYWRlb25fZHJpdmVyX2lycV9wb3N0aW5zdGFsbF9rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5
cGVzXQogMTUyIHwgaW50IHJhZGVvbl9kcml2ZXJfaXJxX3Bvc3RpbnN0YWxsX2ttcyhzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2lycV9rbXMuYzoxNzE6Njogd2FybmluZzogbm8g
cHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fZHJpdmVyX2lycV91bmluc3RhbGxfa21z
4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDE3MSB8IHZvaWQgcmFkZW9uX2RyaXZlcl9pcnFf
dW5pbnN0YWxsX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBHYXJldGggSHVnaGVzIDxnYXJldGhAdmFsaW51eC5jb20+CkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jICAgICB8IDUgKy0tLS0KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2lycV9rbXMuYyB8IDEgKwogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fa21zLmggICAgIHwgNSArKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cnYuYwppbmRleCAyYjlkZWFlYWQ5OWIyLi4yMTE5MzJkNzNiMTkxIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kcnYuYwpAQCAtNTEsNiArNTEsNyBAQAogI2luY2x1ZGUgPGRybS9yYWRlb25f
ZHJtLmg+CiAKICNpbmNsdWRlICJyYWRlb25fZHJ2LmgiCisjaW5jbHVkZSAicmFkZW9uX2ttcy5o
IgogI2luY2x1ZGUgInJhZGVvbl90dG0uaCIKICNpbmNsdWRlICJyYWRlb24uaCIKICNpbmNsdWRl
ICJyYWRlb25fZGV2aWNlLmgiCkBAIC0xMTcsMTAgKzExOCw2IEBACiBpbnQgcmFkZW9uX3N1c3Bl
bmRfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgc3VzcGVuZCwKIAkJICAgICAgIGJv
b2wgZmJjb24sIGJvb2wgZnJlZXplKTsKIGludCByYWRlb25fcmVzdW1lX2ttcyhzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LCBib29sIHJlc3VtZSwgYm9vbCBmYmNvbik7Ci12b2lkIHJhZGVvbl9kcml2
ZXJfaXJxX3ByZWluc3RhbGxfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpOwotaW50IHJhZGVv
bl9kcml2ZXJfaXJxX3Bvc3RpbnN0YWxsX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KTsKLXZv
aWQgcmFkZW9uX2RyaXZlcl9pcnFfdW5pbnN0YWxsX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
KTsKLWlycXJldHVybl90IHJhZGVvbl9kcml2ZXJfaXJxX2hhbmRsZXJfa21zKGludCBpcnEsIHZv
aWQgKmFyZyk7CiBleHRlcm4gaW50IHJhZGVvbl9nZXRfY3J0Y19zY2Fub3V0cG9zKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBjcnRjLAogCQkJCSAgICAgIHVuc2lnbmVkIGlu
dCBmbGFncywgaW50ICp2cG9zLCBpbnQgKmhwb3MsCiAJCQkJICAgICAga3RpbWVfdCAqc3RpbWUs
IGt0aW1lX3QgKmV0aW1lLApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25faXJxX2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jCmlu
ZGV4IDM1MjEwODQwMzBkMjQuLjczNDhhZTUyZTJlZjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2lycV9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9pcnFfa21zLmMKQEAgLTM4LDYgKzM4LDcgQEAKIAogI2luY2x1ZGUgImF0b20uaCIK
ICNpbmNsdWRlICJyYWRlb24uaCIKKyNpbmNsdWRlICJyYWRlb25fa21zLmgiCiAjaW5jbHVkZSAi
cmFkZW9uX3JlZy5oIgogCiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2ttcy5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmgKaW5kZXggMzZl
NzNjZWE5MjE1NC4uOTEzYzgyMzlkNWQ4ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fa21zLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21z
LmgKQEAgLTMyLDQgKzMyLDkgQEAgdTMyIHJhZGVvbl9nZXRfdmJsYW5rX2NvdW50ZXJfa21zKHN0
cnVjdCBkcm1fY3J0YyAqY3J0Yyk7CiBpbnQgcmFkZW9uX2VuYWJsZV92Ymxhbmtfa21zKHN0cnVj
dCBkcm1fY3J0YyAqY3J0Yyk7CiB2b2lkIHJhZGVvbl9kaXNhYmxlX3ZibGFua19rbXMoc3RydWN0
IGRybV9jcnRjICpjcnRjKTsKIAoraXJxcmV0dXJuX3QgcmFkZW9uX2RyaXZlcl9pcnFfaGFuZGxl
cl9rbXMoaW50IGlycSwgdm9pZCAqYXJnKTsKK3ZvaWQgcmFkZW9uX2RyaXZlcl9pcnFfcHJlaW5z
dGFsbF9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldik7CitpbnQgcmFkZW9uX2RyaXZlcl9pcnFf
cG9zdGluc3RhbGxfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpOwordm9pZCByYWRlb25fZHJp
dmVyX2lycV91bmluc3RhbGxfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpOworCiAjZW5kaWYJ
CQkJLyogX19SQURFT05fS01TX0hfXyAqLwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
