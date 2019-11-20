Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11FC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966E920715
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966E920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2C66EA1D;
	Wed, 20 Nov 2019 19:23:06 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389E06EA1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 19:23:05 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id y18so422696ybs.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 11:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jJlAfqBX3njZvjWZgQ2fnJHaYWWJoo/LFj7+sY1vDL8=;
 b=UfDALDaVbqUH6uOJqdy9MRdMRkMpJG+czF6IxY+70scvQmgquZbNto9WSjtibNg49+
 rmyy9QcOCWF7UTrOxlhtkXB0XriwwJI3ggx7MCFUqkCb4pnKwz2IYrMpwf+TDKljLJEI
 pSzVLMJhM5dejLP+hkWFuZ44PEyPjtv1VoMaSRYW+9y7pY9Czi9w0roAJECltzaMp5oA
 VbJTayIhNXOjR51/2gR2BlbMcEGfXVje3Z/eGt4BLUVcdomVh9GdbMslcQEuNrd1ZLit
 4+ak2YPuDUB5CapvJ7nxgM4BqH050m49UIBZKYTvML+ZNx+OAuUny8hr1fIzV971ebMu
 yHcQ==
X-Gm-Message-State: APjAAAUKF6C7LI9GrTXcDvuYAm+Gpisj6/6L+tQcUF+kyJexEPGS88A9
 gG2OkyZouiVhi0VeMyJVENm1bebC
X-Google-Smtp-Source: APXvYqz6Uck/8EONE8ZFm/GhCjeTilUGFMTOBGFkxXHOHzLkE/B49KV/8LNg/g9du774Gpw9xyqVVg==
X-Received: by 2002:a25:cf43:: with SMTP id f64mr3319939ybg.248.1574277783769; 
 Wed, 20 Nov 2019 11:23:03 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k184sm134648ywc.64.2019.11.20.11.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 11:23:02 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: simplify runtime suspend
Date: Wed, 20 Nov 2019 14:22:53 -0500
Message-Id: <20191120192253.1299713-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jJlAfqBX3njZvjWZgQ2fnJHaYWWJoo/LFj7+sY1vDL8=;
 b=JBdd82p1VKMZXUoV1iKXD+BzU8H6bIp2yEiu4vfSxarwtPDzK4Dv4+OOhmWBcIKn/Z
 gKsDF2zlbjls8t4DnZQZdTJc8d64HYx3ByrnbeumRm38MMVqkxwHQfSnd65QfmbGwdgy
 ezUu9gbADrbfbLFrErXWbdSXNsrEzLSCnNNMq7mp3j5165KhfEs9HRUZDgS4HrdqEm6n
 EZ6xo5lFlZPUZ1udf3abTW1OoHUGM28xDZ6/dVQc06V/GSXIK+cXX1h1SZHaws/CO/Z6
 n8Lr7Wydyeiaw5CJhgT+/j3bxmfGc4fvrFD/AjN3YqlZ9B/iIpkPh8l1kfQAZqyHrpLk
 vK5A==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120192253.XJOWXMRcJJgZLAMuVHBSrDvQFqbWUS2YoEOgOqmVVsk@z>

SW4gdGhlIHN0YW5kYXJkIF9QUjMgY2FzZSwgdGhlIHBjaSBjb3JlIGhhbmRsZXMgdGhlIHBjaSBz
dGF0ZS4KVGhlIGRyaXZlciBvbmx5IG5lZWRzIHRvIGhhbmRsZSBpdCBpbiB0aGUgbGVnYWN5IEFU
UFggY2FzZS4KClRoaXMgbWF5IGZpeCBpc3N1ZXMgd2l0aCBydW50aW1lIHN1c3BlbmQvcmVzdW1l
IG9uIGNlcnRhaW4KaHlicmlkIGdyYXBoaWNzIGxhcHRvcHMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMzUgKysrKysrKysrKysrKysrKy0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCBlYTc2M2JjNWIyMzMuLmRmMmY0
NzIwYTJmMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtMTIy
NywxMyArMTIyNywxNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1c3BlbmQo
c3RydWN0IGRldmljZSAqZGV2KQogCiAJcmV0ID0gYW1kZ3B1X2RldmljZV9zdXNwZW5kKGRybV9k
ZXYsIGZhbHNlLCBmYWxzZSk7CiAJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1f
ZGV2KSkgewotCQlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsKLQkJcGNpX2Rpc2FibGVfZGV2aWNlKHBk
ZXYpOwotCQlwY2lfaWdub3JlX2hvdHBsdWcocGRldik7Ci0JCWlmIChhbWRncHVfaXNfYXRweF9o
eWJyaWQoKSkKKwkJLyogT25seSBuZWVkIHRvIGhhbmRsZSBQQ0kgc3RhdGUgaW4gdGhlIGRyaXZl
ciBmb3IgQVRQWAorCQkgKiBQQ0kgY29yZSBoYW5kbGVzIGl0IGZvciBfUFIzLgorCQkgKi8KKwkJ
aWYgKGFtZGdwdV9pc19hdHB4X2h5YnJpZCgpKSB7CisJCQlwY2lfaWdub3JlX2hvdHBsdWcocGRl
dik7CisJCX0gZWxzZSB7CisJCQlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsKKwkJCXBjaV9kaXNhYmxl
X2RldmljZShwZGV2KTsKKwkJCXBjaV9pZ25vcmVfaG90cGx1ZyhwZGV2KTsKIAkJCXBjaV9zZXRf
cG93ZXJfc3RhdGUocGRldiwgUENJX0QzY29sZCk7Ci0JCWVsc2UgaWYgKCFhbWRncHVfaGFzX2F0
cHhfZGdwdV9wb3dlcl9jbnRsKCkpCi0JCQlwY2lfc2V0X3Bvd2VyX3N0YXRlKHBkZXYsIFBDSV9E
M2hvdCk7CisJCX0KIAkJZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9Q
T1dFUl9EWU5BTUlDX09GRjsKIAl9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFj
byhkcm1fZGV2KSkgewogCQlhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoZHJtX2Rldik7CkBAIC0x
MjU1LDE0ICsxMjU5LDE5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Btb3BzX3J1bnRpbWVfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikKIAlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRy
bV9kZXYpKSB7CiAJCWRybV9kZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9X
RVJfQ0hBTkdJTkc7CiAKLQkJaWYgKGFtZGdwdV9pc19hdHB4X2h5YnJpZCgpIHx8Ci0JCSAgICAh
YW1kZ3B1X2hhc19hdHB4X2RncHVfcG93ZXJfY250bCgpKQorCQkvKiBPbmx5IG5lZWQgdG8gaGFu
ZGxlIFBDSSBzdGF0ZSBpbiB0aGUgZHJpdmVyIGZvciBBVFBYCisJCSAqIFBDSSBjb3JlIGhhbmRs
ZXMgaXQgZm9yIF9QUjMuCisJCSAqLworCQlpZiAoYW1kZ3B1X2lzX2F0cHhfaHlicmlkKCkpIHsK
KwkJCXBjaV9zZXRfbWFzdGVyKHBkZXYpOworCQl9IGVsc2UgewogCQkJcGNpX3NldF9wb3dlcl9z
dGF0ZShwZGV2LCBQQ0lfRDApOwotCQlwY2lfcmVzdG9yZV9zdGF0ZShwZGV2KTsKLQkJcmV0ID0g
cGNpX2VuYWJsZV9kZXZpY2UocGRldik7Ci0JCWlmIChyZXQpCi0JCQlyZXR1cm4gcmV0OwotCQlw
Y2lfc2V0X21hc3RlcihwZGV2KTsKKwkJCXBjaV9yZXN0b3JlX3N0YXRlKHBkZXYpOworCQkJcmV0
ID0gcGNpX2VuYWJsZV9kZXZpY2UocGRldik7CisJCQlpZiAocmV0KQorCQkJCXJldHVybiByZXQ7
CisJCQlwY2lfc2V0X21hc3RlcihwZGV2KTsKKwkJfQogCX0gZWxzZSBpZiAoYW1kZ3B1X2Rldmlj
ZV9zdXBwb3J0c19iYWNvKGRybV9kZXYpKSB7CiAJCWFtZGdwdV9kZXZpY2VfYmFjb19leGl0KGRy
bV9kZXYpOwogCX0KLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
