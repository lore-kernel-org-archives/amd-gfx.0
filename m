Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C38CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1110217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1110217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F416EAA9;
	Mon, 28 Oct 2019 21:43:26 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C51D6EAA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:25 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id r134so4375412ywg.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tbg+nGZs28cfdi4lLSwu0wN/GLAMpH0syoOpZnLkTNQ=;
 b=loScmn0Zht8ijp1mC0QuZyGZdF/18jxmycnsAg41dh3A+N+4gYlpyMEn31emr+Cyxb
 Pe3a4cht2zAaa7UGjP3xZ9Vyo9qZjkdzTnfx9wrkUqLFgV0qKJAM/xl3gUAnZx3ZbML6
 WjxC+/DedYpJuvSnBEVrMWyhraBwmu5skLtsH8OmMYfhhH42D0qqzkZZd2gteDtbnoTn
 b2ebMeVTMYVyuwg/KN9uHJjIUAb0O3SQqOiWY4wCQBIdWuST/P380xrCLrA+3r/XFugH
 qgNlWonWs4GSUpzN2AsrEAsRB6dXTJBZAdHUCLT8LMA++td4YS+JzFynnViM6p354MIh
 ESTA==
X-Gm-Message-State: APjAAAVkK8QQyuBHKJCFhsdkDfUmyjX+ZZX9QrHq58svF/Msw3M0Hh+j
 xFQgp3YKrtCZXiUKQJjhvv24/MB2i9o=
X-Google-Smtp-Source: APXvYqzP2Ti26LoW6HupwE2mT1DU+9HALPRm9lRVVWgKkJGI8mB3ybkldJmxWVpKaRp8kMoZAa9JwQ==
X-Received: by 2002:a0d:c985:: with SMTP id l127mr14915831ywd.68.1572299003959; 
 Mon, 28 Oct 2019 14:43:23 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 10/21] drm/amdgpu: add additional boco checks to runtime
 suspend/resume (v2)
Date: Mon, 28 Oct 2019 17:42:05 -0400
Message-Id: <20191028214216.1508370-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tbg+nGZs28cfdi4lLSwu0wN/GLAMpH0syoOpZnLkTNQ=;
 b=rWasITr/0jsEy1mN+Ka/9Le/gpZ4XdPbp/N/QbpcqXBC4lSu4+Ql3nC1c95KrHUgNo
 1MTazFeg7AdbkGnsqnFvqR+XUMcsl6sMlSFkJZLSr/nud9SveDP5OFgRgwlmrn5Mo6j5
 Ynj3w0BYjX7xpcv//ClKU95pmAVwbwdg/AIEcYFsBtMgBd3FghI5XislekLHbLf4pPwl
 x50h/pD5vJ7bzy31acswM9eMKGRd26mP50pbaZbpJuzsnWCABjKg7gIO3/psfny4dJ4K
 Hituo+ofKPH4qvFFYzGzxsaBfgcig/sNqtkUFwgtsKLSFHF6HsqvEeia6GyHK4snYL+Z
 HooQ==
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
Message-ID: <20191028214205.9P368NOugrksKxRkJ2btQ7WC5JhtW47U7KQMbNUWu6I@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCkJPQ08gLSBCdXMgT2ZmLCBDaGlwIE9mZgoKV2Ug
d2lsbCB0YWtlIHNsaWdodGx5IGRpZmZlcmVudCBwYXRocyBmb3IgYm9jbyBhbmQgYmFjby4KCnYy
OiBmb2xkIHRvZ2V0aGVyIHR3byBjb25zZWN1dGl2ZSBpZiBjbGF1c2VzCgpSZXZpZXdlZC1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gKHYxKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgNDcgKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwppbmRleCAzMTAxODJiZjFkYjUuLjdiODQ3OGQw
OGIyYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwpAQCAtMTIxNywx
OCArMTIxNywyMSBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1c3BlbmQoc3Ry
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
ZXR1cm4gMDsKIH0KQEAgLTEyNDIsMjAgKzEyNDUsMjIgQEAgc3RhdGljIGludCBhbWRncHVfcG1v
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
