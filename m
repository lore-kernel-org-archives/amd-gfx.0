Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2702EC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0735C20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0735C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D406E95A;
	Fri, 15 Nov 2019 16:50:59 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF2F6E958
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:57 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id s18so4031081qvr.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7FGoEDMcY3bsTDzE5n31NNKpbGzTd5lhcWG/27KJrPg=;
 b=RqCZCSiV/UhU1krbbuMt7PaFhgPxCp2juzzYquznfw3tVn7c7SF0N19sGC1eU5HUbd
 h0eC7FEyse5j9g9IT6afWFwnXwDklU8L72EWF3v7bb+NpSMkuPO/KziZ2k7u/znPWOVJ
 Egh8vVuTmV5/9sszbpQCF69rQg3uLgDdkR3jdJyg82vpAGM6jZDbKImMB+0FMDrqqWSI
 FiUcPNfD66MK0lV+PccNNC3mCKjqxOUXjjYKebhyKDh3DbfdZRjkHhQQEZhvvh/+mjhT
 3KbTvggqxququjgiDsTdaaom5FOo5njr/T4tpt6ZY2mxAO+Rv8gQkGRvsK6vsSnIa11P
 q+Fg==
X-Gm-Message-State: APjAAAV/PFwRfdU4ktWbKcgFkITScbg5qhNJwjD2RIZ/Gfx3IYIM2Jmr
 xy1KmfojF7VDX/DBqDoebFO2r5EY
X-Google-Smtp-Source: APXvYqy7Kp7MZMRd3jHLnKAtZzaTP/Xm5oGgpnF0isM9GWTFmSjZH/yoMv4nsjoYt+xStkXDzuiXiA==
X-Received: by 2002:a05:6214:22c:: with SMTP id
 j12mr13792174qvt.150.1573836656032; 
 Fri, 15 Nov 2019 08:50:56 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:55 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 09/20] drm/amdgpu: add additional boco checks to runtime
 suspend/resume (v2)
Date: Fri, 15 Nov 2019 11:50:27 -0500
Message-Id: <20191115165038.56646-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7FGoEDMcY3bsTDzE5n31NNKpbGzTd5lhcWG/27KJrPg=;
 b=EZaCgRjn1F2Vvebsp1g5cmFobbn+Jo7LkyQcR6Z6WX0aSOUHkcrMc3jZA6BZFPzgp8
 s8zUtlQxWHNDiOJWGkcETLoWNxuZ5hZs6+Y1dre+23zv684O8kmgD7XDEXcrP5VTatSb
 paB9XTwgA2AFMkK+9YI70+opSCJ21dqV6VfULAhiSGL/1XQTzhjjpl6BQY+yH+7i8IBn
 oVV5gcdwwaGMfxs1hqcMXDYWnD/gx4qb0c4fxkQD6ntiwlhF/Knj739ZX09E8mjV7TxX
 ZUBBjuEiQz5pUPxSs/cRUupJpcmDG3OhazxxlwDXH7tMr1mY3ItrLfdPHAVhdiyzchhY
 Sccw==
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
Message-ID: <20191115165027.BsjFUCjT0Dc3dql1q9T7BPyEn9xr5nGso3HuiogbCJc@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCkJPQ08gLSBCdXMgT2ZmLCBDaGlwIE9mZgoKV2Ug
d2lsbCB0YWtlIHNsaWdodGx5IGRpZmZlcmVudCBwYXRocyBmb3IgYm9jbyBhbmQgYmFjby4KCnYy
OiBmb2xkIHRvZ2V0aGVyIHR3byBjb25zZWN1dGl2ZSBpZiBjbGF1c2VzCgpSZXZpZXdlZC1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gKHYxKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgNDcgKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCBiZmQ5MWNmOTE1MGIuLmQwNWY4YzAz
ZTU1OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtMTIxOSwx
OCArMTIxOSwyMSBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1c3BlbmQoc3Ry
dWN0IGRldmljZSAqZGV2KQogCQlyZXR1cm4gLUVCVVNZOwogCX0KIAotCWRybV9kZXYtPnN3aXRj
aF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7CisJaWYgKGFtZGdwdV9k
ZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1fZGV2KSkKKwkJZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0
YXRlID0gRFJNX1NXSVRDSF9QT1dFUl9DSEFOR0lORzsKIAlkcm1fa21zX2hlbHBlcl9wb2xsX2Rp
c2FibGUoZHJtX2Rldik7CiAKIAlyZXQgPSBhbWRncHVfZGV2aWNlX3N1c3BlbmQoZHJtX2Rldiwg
ZmFsc2UsIGZhbHNlKTsKLQlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsKLQlwY2lfZGlzYWJsZV9kZXZp
Y2UocGRldik7Ci0JcGNpX2lnbm9yZV9ob3RwbHVnKHBkZXYpOwotCWlmIChhbWRncHVfaXNfYXRw
eF9oeWJyaWQoKSkKLQkJcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDNjb2xkKTsKLQll
bHNlIGlmICghYW1kZ3B1X2hhc19hdHB4X2RncHVfcG93ZXJfY250bCgpKQotCQlwY2lfc2V0X3Bv
d2VyX3N0YXRlKHBkZXYsIFBDSV9EM2hvdCk7Ci0JZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0YXRl
ID0gRFJNX1NXSVRDSF9QT1dFUl9EWU5BTUlDX09GRjsKKwlpZiAoYW1kZ3B1X2RldmljZV9zdXBw
b3J0c19ib2NvKGRybV9kZXYpKSB7CisJCXBjaV9zYXZlX3N0YXRlKHBkZXYpOworCQlwY2lfZGlz
YWJsZV9kZXZpY2UocGRldik7CisJCXBjaV9pZ25vcmVfaG90cGx1ZyhwZGV2KTsKKwkJaWYgKGFt
ZGdwdV9pc19hdHB4X2h5YnJpZCgpKQorCQkJcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lf
RDNjb2xkKTsKKwkJZWxzZSBpZiAoIWFtZGdwdV9oYXNfYXRweF9kZ3B1X3Bvd2VyX2NudGwoKSkK
KwkJCXBjaV9zZXRfcG93ZXJfc3RhdGUocGRldiwgUENJX0QzaG90KTsKKwkJZHJtX2Rldi0+c3dp
dGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9QT1dFUl9EWU5BTUlDX09GRjsKKwl9CiAKIAly
ZXR1cm4gMDsKIH0KQEAgLTEyNDQsMjAgKzEyNDcsMjIgQEAgc3RhdGljIGludCBhbWRncHVfcG1v
cHNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQogCWlmICghYW1kZ3B1X2Rldmlj
ZV9zdXBwb3J0c19ib2NvKGRybV9kZXYpKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWRybV9kZXYt
PnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7Ci0KLQlpZiAo
YW1kZ3B1X2lzX2F0cHhfaHlicmlkKCkgfHwKLQkgICAgIWFtZGdwdV9oYXNfYXRweF9kZ3B1X3Bv
d2VyX2NudGwoKSkKLQkJcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDApOwotCXBjaV9y
ZXN0b3JlX3N0YXRlKHBkZXYpOwotCXJldCA9IHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpOwotCWlm
IChyZXQpCi0JCXJldHVybiByZXQ7Ci0JcGNpX3NldF9tYXN0ZXIocGRldik7Ci0KKwlpZiAoYW1k
Z3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9kZXYpKSB7CisJCWRybV9kZXYtPnN3aXRjaF9w
b3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7CisKKwkJaWYgKGFtZGdwdV9p
c19hdHB4X2h5YnJpZCgpIHx8CisJCSAgICAhYW1kZ3B1X2hhc19hdHB4X2RncHVfcG93ZXJfY250
bCgpKQorCQkJcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDApOworCQlwY2lfcmVzdG9y
ZV9zdGF0ZShwZGV2KTsKKwkJcmV0ID0gcGNpX2VuYWJsZV9kZXZpY2UocGRldik7CisJCWlmIChy
ZXQpCisJCQlyZXR1cm4gcmV0OworCQlwY2lfc2V0X21hc3RlcihwZGV2KTsKKwl9CiAJcmV0ID0g
YW1kZ3B1X2RldmljZV9yZXN1bWUoZHJtX2RldiwgZmFsc2UsIGZhbHNlKTsKIAlkcm1fa21zX2hl
bHBlcl9wb2xsX2VuYWJsZShkcm1fZGV2KTsKLQlkcm1fZGV2LT5zd2l0Y2hfcG93ZXJfc3RhdGUg
PSBEUk1fU1dJVENIX1BPV0VSX09OOworCWlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28o
ZHJtX2RldikpCisJCWRybV9kZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9X
RVJfT047CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
