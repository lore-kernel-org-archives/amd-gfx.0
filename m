Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D37EC48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 12:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5750613AE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 12:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5750613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE346EE7D;
	Fri, 11 Jun 2021 12:03:04 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943FC6EE7D;
 Fri, 11 Jun 2021 12:03:03 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 m41-20020a05600c3b29b02901b9e5d74f02so5251221wms.3; 
 Fri, 11 Jun 2021 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1e/SbMbCf5qJDsFem7oEWojdln1rq60P/UViM2oZ51I=;
 b=P5jX7UQ3XtdtLYqFtl8P4xcJyC6r9W4LK4G5Qnwsa6wLNoNdV+dHeMhPdGUmQfF3i4
 tLeV5Kwtz9T1ZGWoOxUJqUpZX0ao/4iCw8UQLQ+a2ifibuKqoue5u2bbIQNNPl90XbDn
 dpi+Tm3AjuRqUEbL7zTmyMoirKvFl/1C9VYaw3gz7ZE0yq++7N8TgUw/n/0xPexXkVNn
 4AG3OKnZfAX68S2kMHWfS/yvJYXDGDSr4c20L2RY2Qak1PsI+2qxLr5ewrsu2GR0sKqT
 2tqCczA1M1R8Wu8UPoDFOEzVkZ9QonMZQ0dMDQiYynQQLAUSV5cXjVhnbQP5ViaZabU1
 ViNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1e/SbMbCf5qJDsFem7oEWojdln1rq60P/UViM2oZ51I=;
 b=DCiOnaBmibtyFWeEn8F7wbHt82DKgJsJBlWMdstig/TVbkmu7WRVlXGXjJtayCyp/y
 NiIDUwKeZJi4K+7v3ala2bCTTes3hWlWZ3cws4BskYeg1P8U/mmNcGNJYqmUuVkm9A/J
 1agyBPvevNOQbyqSaiyiLCbMAQsvDIdC6CSiKGkhae8Pt2d6gMTBJ+j+BxqsIcKqFtIh
 ofFAkazgnTURaYnOPA1LXnVfcBkbwSa7yknYlPyA2B++MyAwin2/2C+/eHiJ8RflrhT6
 2FjjGRvcIR0wMyBuj3RURdrvd+tF26shCrlDRCfbD1+p79rI1WmvQ/VHYDn9ZGEqwbF4
 p5cg==
X-Gm-Message-State: AOAM533MXLH2PqndgNcxIEbnHLKkJVbcCszAw436zVQ7xExGChlViXVu
 4zSL08DPRs+ThLjukPiEOARnB7x4a5M=
X-Google-Smtp-Source: ABdhPJwS8YWPiFfPJlQs73UG0eCo9FSB8F5w9X7Q6HMZrXS2f+N1aQfRbXHQkPEQ+eXAHgMpu4kTMA==
X-Received: by 2002:a1c:3dc2:: with SMTP id k185mr19891415wma.15.1623412982297; 
 Fri, 11 Jun 2021 05:03:02 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:657d:4ae8:def3:d96a])
 by smtp.gmail.com with ESMTPSA id f13sm6898361wrt.86.2021.06.11.05.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 05:03:01 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] dma-buf: fix dma_resv_test_signaled test_all handling
Date: Fri, 11 Jun 2021 14:02:57 +0200
Message-Id: <20210611120301.10595-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

QXMgdGhlIG5hbWUgaW1wbGllcyBpZiB0ZXN0aW5nIGFsbCBmZW5jZXMgaXMgcmVxdWVzdGVkIHdl
CnNob3VsZCBpbmRlZWQgdGVzdCBhbGwgZmVuY2VzIGFuZCBub3Qgc2tpcCB0aGUgZXhjbHVzaXZl
Cm9uZSBiZWNhdXNlIHdlIHNlZSBzaGFyZWQgb25lcy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2RtYS1idWYv
ZG1hLXJlc3YuYyB8IDMzICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZG1hLWJ1Zi9kbWEtcmVzdi5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMK
aW5kZXggZjI2YzcxNzQ3ZDQzLi5jNjZiZmRkZTk0NTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1h
LWJ1Zi9kbWEtcmVzdi5jCisrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtcmVzdi5jCkBAIC02MTUs
MjUgKzYxNSwyMSBAQCBzdGF0aWMgaW5saW5lIGludCBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3Np
bmdsZShzdHJ1Y3QgZG1hX2ZlbmNlICpwYXNzZWRfZmVuY2UpCiAgKi8KIGJvb2wgZG1hX3Jlc3Zf
dGVzdF9zaWduYWxlZChzdHJ1Y3QgZG1hX3Jlc3YgKm9iaiwgYm9vbCB0ZXN0X2FsbCkKIHsKLQl1
bnNpZ25lZCBpbnQgc2VxLCBzaGFyZWRfY291bnQ7CisJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2U7
CisJdW5zaWduZWQgaW50IHNlcTsKIAlpbnQgcmV0OwogCiAJcmN1X3JlYWRfbG9jaygpOwogcmV0
cnk6CiAJcmV0ID0gdHJ1ZTsKLQlzaGFyZWRfY291bnQgPSAwOwogCXNlcSA9IHJlYWRfc2VxY291
bnRfYmVnaW4oJm9iai0+c2VxKTsKIAogCWlmICh0ZXN0X2FsbCkgewogCQlzdHJ1Y3QgZG1hX3Jl
c3ZfbGlzdCAqZm9iaiA9IGRtYV9yZXN2X3NoYXJlZF9saXN0KG9iaik7Ci0JCXVuc2lnbmVkIGlu
dCBpOwotCi0JCWlmIChmb2JqKQotCQkJc2hhcmVkX2NvdW50ID0gZm9iai0+c2hhcmVkX2NvdW50
OworCQl1bnNpZ25lZCBpbnQgaSwgc2hhcmVkX2NvdW50OwogCisJCXNoYXJlZF9jb3VudCA9IGZv
YmogPyBmb2JqLT5zaGFyZWRfY291bnQgOiAwOwogCQlmb3IgKGkgPSAwOyBpIDwgc2hhcmVkX2Nv
dW50OyArK2kpIHsKLQkJCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOwotCiAJCQlmZW5jZSA9IHJj
dV9kZXJlZmVyZW5jZShmb2JqLT5zaGFyZWRbaV0pOwogCQkJcmV0ID0gZG1hX3Jlc3ZfdGVzdF9z
aWduYWxlZF9zaW5nbGUoZmVuY2UpOwogCQkJaWYgKHJldCA8IDApCkBAIC02NDEsMjQgKzYzNywx
OSBAQCBib29sIGRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWQoc3RydWN0IGRtYV9yZXN2ICpvYmosIGJv
b2wgdGVzdF9hbGwpCiAJCQllbHNlIGlmICghcmV0KQogCQkJCWJyZWFrOwogCQl9Ci0KLQkJaWYg
KHJlYWRfc2VxY291bnRfcmV0cnkoJm9iai0+c2VxLCBzZXEpKQotCQkJZ290byByZXRyeTsKIAl9
CiAKLQlpZiAoIXNoYXJlZF9jb3VudCkgewotCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZV9leGNs
ID0gZG1hX3Jlc3ZfZXhjbF9mZW5jZShvYmopOwotCi0JCWlmIChmZW5jZV9leGNsKSB7Ci0JCQly
ZXQgPSBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3NpbmdsZShmZW5jZV9leGNsKTsKLQkJCWlmIChy
ZXQgPCAwKQotCQkJCWdvdG8gcmV0cnk7CisJZmVuY2UgPSBkbWFfcmVzdl9leGNsX2ZlbmNlKG9i
aik7CisJaWYgKGZlbmNlKSB7CisJCXJldCA9IGRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWRfc2luZ2xl
KGZlbmNlKTsKKwkJaWYgKHJldCA8IDApCisJCQlnb3RvIHJldHJ5OwogCi0JCQlpZiAocmVhZF9z
ZXFjb3VudF9yZXRyeSgmb2JqLT5zZXEsIHNlcSkpCi0JCQkJZ290byByZXRyeTsKLQkJfQogCX0K
IAorCWlmIChyZWFkX3NlcWNvdW50X3JldHJ5KCZvYmotPnNlcSwgc2VxKSkKKwkJZ290byByZXRy
eTsKKwogCXJjdV9yZWFkX3VubG9jaygpOwogCXJldHVybiByZXQ7CiB9Ci0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
