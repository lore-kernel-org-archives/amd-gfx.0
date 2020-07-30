Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8708B2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzsmcu2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8708B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399F16E964;
	Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575BF6E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:32 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id x12so12815054qtp.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MC7aLIbaULp13pojqAgZoWa/iY/smL3x9YscZpfYH+U=;
 b=Hzsmcu2dOADDrsGbN8KmBQIsUQGQ5f2NAMfXercJN2WENJx25+/hbEQaXGyRnmhBOf
 UMLjHImrvFUWsnwIff/+TrBaBngzirrhNV5FA1XMvN5JnHwVX02NXI9oaOus+NyRIM1u
 I66S+HEe65087Auq82BrUDDORqT8g+r2ZwfkytTBICi1EKFg++Buv1Crf3uOKd+8CXob
 PgTKe6b0QnkPArA0RsJI8wjGzCukyohyuMuQO8cDuKLQCZ9uYiq9YQp3AbRsblgBt7Pt
 6m1A9fLF30ORpoxV13XPwk5u5YlDQ7GN0bPK2HZLV533uUFsxIsDI9mepgbOQZfyyjlN
 MDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MC7aLIbaULp13pojqAgZoWa/iY/smL3x9YscZpfYH+U=;
 b=uhYlStN9AsylKMGRHqkvQ81BY/XPBlkvDvXm5HVuiVKWZuWBF5BkTa6vxXNaFt+LxJ
 A+RZ368xrIbgZXNvDRladED+YKdgUKnxwcCz3WPNMlLr1i1JUj24BXzb+bGn0ztZUfE2
 J+90hrCfhhlD0zz0tz3nWUgzI7SuTHByJgivlb0/uLtQ5bDwFMVREF3yDkVfznyM06n3
 DJOShLc58K8oSzoWh5JZgfl2n9fAbrtJcRt8UjbUCT/av/4TLOpuwDViJqA5wcFVAQO+
 ljXYwcvQZDUy4qqHIamYJpJPomc1gyAplzRuIA83d1tkzBr6e5veS8c0l2URocw/F4hJ
 Vghg==
X-Gm-Message-State: AOAM532OUc5OSxPgVI0O+Llxfg+9UuZjcJ2MgPhcY++cp2WXZAO1GdYt
 NRTVvSPJ71GKOe9abaYZNnEHuCFb
X-Google-Smtp-Source: ABdhPJzPSDFW+q1Wt3Cl6GLMWOKv39DDP5O3FVdcHtv8CHSgyK6PDMob6JJbqzR9NXLo8obNntdnAQ==
X-Received: by 2002:ac8:24cf:: with SMTP id t15mr364623qtt.270.1596139471209; 
 Thu, 30 Jul 2020 13:04:31 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/17] drm/amdgpu/gmc6: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Thu, 30 Jul 2020 16:04:05 -0400
Message-Id: <20200730200414.40485-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIG5ldyBoZWxwZXIgY2VudHJhbGl6ZXMgdGhlIGxvZ2ljIGluIG9uZSBwbGFjZS4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMgfCA2ICsrLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y2XzAuYwppbmRleCAyOGRkYjQxYTc4YzguLjk1YTkxMTdlOTU2NCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2XzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjZfMC5jCkBAIC04MTIsOSArODEyLDYgQEAgc3RhdGljIHVu
c2lnbmVkIGdtY192Nl8wX2dldF92Ymlvc19mYl9zaXplKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCQkJUkVHX0dFVF9GSUVMRCh2aWV3cG9ydCwgVklFV1BPUlRfU0laRSwgVklFV1BPUlRf
V0lEVEgpICoKIAkJCTQpOwogCX0KLQkvKiByZXR1cm4gMCBpZiB0aGUgcHJlLU9TIGJ1ZmZlciB1
c2VzIHVwIG1vc3Qgb2YgdnJhbSAqLwotCWlmICgoYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplIC0g
c2l6ZSkgPCAoOCAqIDEwMjQgKiAxMDI0KSkKLQkJcmV0dXJuIDA7CiAJcmV0dXJuIHNpemU7CiB9
CiAKQEAgLTg2Miw3ICs4NTksNyBAQCBzdGF0aWMgaW50IGdtY192Nl8wX3N3X2luaXQodm9pZCAq
aGFuZGxlKQogCWlmIChyKQogCQlyZXR1cm4gcjsKIAotCWFkZXYtPmdtYy5zdG9sZW5fdmdhX3Np
emUgPSBnbWNfdjZfMF9nZXRfdmJpb3NfZmJfc2l6ZShhZGV2KTsKKwlhbWRncHVfZ21jX2dldF92
Ymlvc19hbGxvY2F0aW9ucyhhZGV2KTsKIAogCXIgPSBhbWRncHVfYm9faW5pdChhZGV2KTsKIAlp
ZiAocikKQEAgLTExMzYsNiArMTEzMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2dt
Y19mdW5jcyBnbWNfdjZfMF9nbWNfZnVuY3MgPSB7CiAJLnNldF9wcnQgPSBnbWNfdjZfMF9zZXRf
cHJ0LAogCS5nZXRfdm1fcGRlID0gZ21jX3Y2XzBfZ2V0X3ZtX3BkZSwKIAkuZ2V0X3ZtX3B0ZSA9
IGdtY192Nl8wX2dldF92bV9wdGUsCisJLmdldF92Ymlvc19mYl9zaXplID0gZ21jX3Y2XzBfZ2V0
X3ZiaW9zX2ZiX3NpemUsCiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9pcnFfc3Jj
X2Z1bmNzIGdtY192Nl8wX2lycV9mdW5jcyA9IHsKLS0gCjIuMjUuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
