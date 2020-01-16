Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF55C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 13:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D79F206D5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 13:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVlJchKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D79F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144796ECF3;
	Thu, 16 Jan 2020 13:09:12 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F381A6ECF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 13:09:10 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t2so19109719wrr.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 05:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ahofZJUWTUECai2cUtBvoNJY5oG0yoUYCxROgky5lJA=;
 b=XVlJchKBn096eH9Ug9//WhlYBkVPlIJyVjlPBv6eOSL6BOzFNMlNSoRi/ous/L6i2z
 oejigWl5jPNgxMx8dUueomhqkkypYJykf57lQQjl7Vw7nxpSl+Amlk37JF3rV83E9yVv
 7IW1s74V6CHlgEj/V0FPt7DxCzcie1EAmJR3fOr+Em9qzCEbk4JOTbJqxGXNOgSrktY8
 mBqQGXB7G5aGYa4P24dPGNG5Dcn3qCpOLDZSiG1Fyh610RRs2VBbs0tccS5aK4QVBsqO
 xCwh2RDxuB+47zfjGWNRl53vhpSPOQxwPbAiHRzNE0WxBerTkzvdvkPvFB4+D/AAoYyJ
 25zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ahofZJUWTUECai2cUtBvoNJY5oG0yoUYCxROgky5lJA=;
 b=hU+ZaQaadKaFL1x2neFNjPyIcMfT/8leAt3XHGAYEqz+KiJBxpZl4XhOS+4fE6ZrLq
 M1FMUG72d6oELLzZBN/p1+TJuzlu9yJ9ovV/0CYUH4Q/WABCaL2QMXrkvDq/lELGXKJ7
 vzkLBQBNoqjOlvkos6kxTBwGQtVORpeiZzZvrSyZpoEOf8niNs5yWt6kDC0q0Y35RhUR
 v51iW9kPGo1VGLjIHaM/YAZDH1Hpt+PM+VlOLcEM2JoRasyBfoiM/N7BLGOSR51DMgmB
 jT3oqUgr1bBb6CnIJeJxLzZFcGkxXJX272Twcq86nJD78sDsOloWHkCKlK1yIhfTMMqd
 Z4uw==
X-Gm-Message-State: APjAAAUXYihyd1FWzUr7dx7PIf8FgjiMmGuebWk8msPB+n2qc/Q/ZB+3
 nc/Fs1TUpjJXJvOFeUZMziuffnLX
X-Google-Smtp-Source: APXvYqwyd9d7Graani/Jkg1x3AYdRu3FkcJTawFb2GzXyqS6HUK7OcLXoA75vOKMmM86tviteKhcxQ==
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr3458472wrx.26.1579180149651; 
 Thu, 16 Jan 2020 05:09:09 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:6d08:8af2:5133:da45])
 by smtp.gmail.com with ESMTPSA id k8sm29084910wrl.3.2020.01.16.05.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 05:09:08 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: fredrik.bruhn@unibap.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
Date: Thu, 16 Jan 2020 14:09:07 +0100
Message-Id: <20200116130907.22410-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

Q29yZWJvb3Qgc2VlbXMgdG8gaGF2ZSBhIHByb2JsZW0gY29ycmVjdGx5IHNldHRpbmcgdXAgYWNj
ZXNzIHRvIHRoZSBzdG9sZW4gVlJBTQpvbiBLVi9LQi4gVXNlIHRoZSBkaXJlY3QgYWNjZXNzIG9u
bHkgd2hlbiBuZWNlc3NhcnkuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y3XzAuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMKaW5kZXggMTlkNWIxMzNl
MWQ3Li45ZGE5NTk2YTM2MzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192N18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwpA
QCAtMzgxLDcgKzM4MSw4IEBAIHN0YXRpYyBpbnQgZ21jX3Y3XzBfbWNfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAlhZGV2LT5nbWMuYXBlcl9zaXplID0gcGNpX3Jlc291cmNlX2xl
bihhZGV2LT5wZGV2LCAwKTsKIAogI2lmZGVmIENPTkZJR19YODZfNjQKLQlpZiAoYWRldi0+Zmxh
Z3MgJiBBTURfSVNfQVBVKSB7CisJaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSAmJgorCSAg
ICBhZGV2LT5nbWMucmVhbF92cmFtX3NpemUgPiBhZGV2LT5nbWMuYXBlcl9zaXplKSB7CiAJCWFk
ZXYtPmdtYy5hcGVyX2Jhc2UgPSAoKHU2NClSUkVHMzIobW1NQ19WTV9GQl9PRkZTRVQpKSA8PCAy
MjsKIAkJYWRldi0+Z21jLmFwZXJfc2l6ZSA9IGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZTsKIAl9
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
