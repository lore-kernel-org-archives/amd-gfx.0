Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B3CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13531218BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13531218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C278B6EAAF;
	Mon, 28 Oct 2019 21:43:48 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407226EAAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:48 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id g77so4356327ywb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NmuQsbCHKb7BkJ6zh/WNcWYe2RbOykwS3NQHXLqtDhs=;
 b=cdLVQgvJYQd/hw3/ykSRuBIQiUqH/FKq5Iax42JkYkj8s+ZjmTJAZkKSo4K4CFdJZ8
 oM/QDKKGSFJkDMr8/a48xSDmV+rs8lM6LZCkfJsl61LphFwfVmws+47Dnd+Z+9ioKfMZ
 a0UkZahHhBCQuGSMq1yChwE5nHCY6oppZ2D9faI3XWdJCRFW5Lq0ATAVsHTmKBa4yH6x
 IWI6Mo0XMp5lYrpkXN6oaFnPx8CeiYPrNfQYaN8yJXmwFUNrVqeT0i8rXxwXQ05c8wwO
 vYZMjkgboI/c2YvCYuTsbthhpc/Am/kQICYMpf0hqzkjNFMiYdSxaS7fM/G/CrQsfleA
 PekQ==
X-Gm-Message-State: APjAAAWOmLgxDbGQgjBa+sgTGOt28qznJL88O77DbbjF4SQI36fPdvTL
 l5Mjp9PSFBy0GohYdDIXyWMYMIwTyAU=
X-Google-Smtp-Source: APXvYqwEfAtxsHHey0gA75G29M9zoivrzSdMucDftnFHD02cqWioBTmAjbg43BqJbHlP+XoD2J8n0Q==
X-Received: by 2002:a81:bd05:: with SMTP id b5mr14658593ywi.243.1572299026966; 
 Mon, 28 Oct 2019 14:43:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 15/21] drm/amdgpu: disentangle runtime pm and vga_switcheroo
Date: Mon, 28 Oct 2019 17:42:10 -0400
Message-Id: <20191028214216.1508370-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NmuQsbCHKb7BkJ6zh/WNcWYe2RbOykwS3NQHXLqtDhs=;
 b=LmoO/6X5fu2ZRkja6BHX0ytKpwDljwEeMDkFSusx4gve7xOtBmJPqZMx6V8htZNC7b
 fblhqvgdkvGcnWmDolrMI9aL6Hjxzj0TtCdRIVupeavycnRHkNdpEtWe17zWaovYeio8
 7CaYze78R1lFH4VCjoppqHhO4MUXGC9hcY2oFsW0b3mG1mXC1OcDo7V+u/9HtIXDVtFA
 FPJl/LhX71hT3PFHpAdfY5A83YWVScP9yaZiUy3FaM2qWAdweOHA7dCeiLJhJ2xRCCdv
 iLrbBn8VKALbibpUeOS+OZjZCUawcq/nckfgn2xTVdy5gP62q2o9aqvWQCVmmj/uQA8O
 t7DA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214210.Ni_-iMrWvor_TgsL9n5fP8FO3rNcy_8B1kZa3KsqTII@z>

T3JpZ2luYWxseSB3ZSBvbmx5IHN1cHBvcnRlZCBydW50aW1lIHBtIG9uIFBYL0hHIGxhcHRvcHMK
c28gdmdhX3N3aXRjaGVyb28gYW5kIHJ1bnRpbWUgcG0gYXJlIHNvcnQgb2YgZW50YW5nbGVkLgoK
QXR0ZW1wdCB0byBsb2dpY2FsbHkgc2VwYXJhdGUgdGhlbS4KClJldmlld2VkLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDI0MTZhNTEwMzE1NC4uMGRkNGZmMzY1OGYxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yNzExLDcg
KzI3MTEsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCQkgICAgICAgdWludDMyX3QgZmxhZ3MpCiB7CiAJaW50IHIsIGk7Ci0JYm9vbCBydW50
aW1lID0gZmFsc2U7CisJYm9vbCBib2NvID0gZmFsc2U7CiAJdTMyIG1heF9NQnBzOwogCiAJYWRl
di0+c2h1dGRvd24gPSBmYWxzZTsKQEAgLTI4ODIsMTEgKzI4ODIsMTQgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl2Z2FfY2xpZW50X3JlZ2lz
dGVyKGFkZXYtPnBkZXYsIGFkZXYsIE5VTEwsIGFtZGdwdV9kZXZpY2VfdmdhX3NldF9kZWNvZGUp
OwogCiAJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkZGV2KSkKLQkJcnVudGltZSA9
IHRydWU7Ci0JaWYgKCFwY2lfaXNfdGh1bmRlcmJvbHRfYXR0YWNoZWQoYWRldi0+cGRldikpCisJ
CWJvY28gPSB0cnVlOworCWlmIChhbWRncHVfaGFzX2F0cHgoKSAmJgorCSAgICAoYW1kZ3B1X2lz
X2F0cHhfaHlicmlkKCkgfHwKKwkgICAgIGFtZGdwdV9oYXNfYXRweF9kZ3B1X3Bvd2VyX2NudGwo
KSkgJiYKKwkgICAgIXBjaV9pc190aHVuZGVyYm9sdF9hdHRhY2hlZChhZGV2LT5wZGV2KSkKIAkJ
dmdhX3N3aXRjaGVyb29fcmVnaXN0ZXJfY2xpZW50KGFkZXYtPnBkZXYsCi0JCQkJCSAgICAgICAm
YW1kZ3B1X3N3aXRjaGVyb29fb3BzLCBydW50aW1lKTsKLQlpZiAocnVudGltZSkKKwkJCQkJICAg
ICAgICZhbWRncHVfc3dpdGNoZXJvb19vcHMsIGJvY28pOworCWlmIChib2NvKQogCQl2Z2Ffc3dp
dGNoZXJvb19pbml0X2RvbWFpbl9wbV9vcHMoYWRldi0+ZGV2LCAmYWRldi0+dmdhX3BtX2RvbWFp
bik7CiAKIAlpZiAoYW1kZ3B1X2VtdV9tb2RlID09IDEpIHsKQEAgLTMwNjMsNyArMzA2Niw3IEBA
IGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAKIGZh
aWxlZDoKIAlhbWRncHVfdmZfZXJyb3JfdHJhbnNfYWxsKGFkZXYpOwotCWlmIChydW50aW1lKQor
CWlmIChib2NvKQogCQl2Z2Ffc3dpdGNoZXJvb19maW5pX2RvbWFpbl9wbV9vcHMoYWRldi0+ZGV2
KTsKIAogCXJldHVybiByOwpAQCAtMzExMCw5ICszMTEzLDEyIEBAIHZvaWQgYW1kZ3B1X2Rldmlj
ZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJa2ZyZWUoYWRldi0+Ymlvcyk7
CiAJYWRldi0+YmlvcyA9IE5VTEw7Ci0JaWYgKCFwY2lfaXNfdGh1bmRlcmJvbHRfYXR0YWNoZWQo
YWRldi0+cGRldikpCisJaWYgKGFtZGdwdV9oYXNfYXRweCgpICYmCisJICAgIChhbWRncHVfaXNf
YXRweF9oeWJyaWQoKSB8fAorCSAgICAgYW1kZ3B1X2hhc19hdHB4X2RncHVfcG93ZXJfY250bCgp
KSAmJgorCSAgICAhcGNpX2lzX3RodW5kZXJib2x0X2F0dGFjaGVkKGFkZXYtPnBkZXYpKQogCQl2
Z2Ffc3dpdGNoZXJvb191bnJlZ2lzdGVyX2NsaWVudChhZGV2LT5wZGV2KTsKLQlpZiAoYWRldi0+
ZmxhZ3MgJiBBTURfSVNfUFgpCisJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhhZGV2
LT5kZGV2KSkKIAkJdmdhX3N3aXRjaGVyb29fZmluaV9kb21haW5fcG1fb3BzKGFkZXYtPmRldik7
CiAJdmdhX2NsaWVudF9yZWdpc3RlcihhZGV2LT5wZGV2LCBOVUxMLCBOVUxMLCBOVUxMKTsKIAlp
ZiAoYWRldi0+cmlvX21lbSkKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
