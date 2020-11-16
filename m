Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F7DC63798
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279782225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVJh/Ke+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279782225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B2F6EA2A;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309CF89F89
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:30:13 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id p1so19572910wrf.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o9jTMX+lMkxyW4xpU+ilcx7gbWHjRBMJqKFY5D9XSUE=;
 b=cVJh/Ke+OD3Oll6rBgHwkuRb+Nz6wo5pKXlIS2z7NkqcZeSlGdbl1LW03toVNELEle
 LB9raRwisH2MTIhDMoAq6JwKRfx6IpDTYKgM1JwYpOtE82ZmIIXVjcsRCCY3EVqVwYgA
 1IdOzo7dyBuR/SyeCiFrCs9DOxgyv4VbvC7PJ62Gq9ymaVUBVuPyvlhwxd1ywS70eaQg
 9NtGYiwVYJ3135AaW2b8kuQ93Fg0M+ZZ89cYlkYsqlUqnZnLZPULjeVzLuH9CxQBZNwJ
 Ax0EseW8X5M3aMygECFAh6szNkJH5IZSQqJkTJLvffdI2+VLjE+ITqmAzQwVp5Lp++Us
 Kb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o9jTMX+lMkxyW4xpU+ilcx7gbWHjRBMJqKFY5D9XSUE=;
 b=UeMnJbYbh7kiozbXw1SChlL4ig1IVcEjBP6730ql1aocWXlROA+SeTCkc/WpBcb4PE
 IrtlzD37DxBhYVmIHZ9Hi9sWk74BBqVaTSpQQFaOul500DJYBPZKBq2/J5ac5VWR+FIP
 hp1Y2PiwbvCGbxONfWej+MvpKJW+JCaN8BmlHrviP6CCGgLXf1jbVjLfihmLeujjyW2M
 mWx4txwoX9Tk9J+CbkyjI6UMRmtKCAMlndPrI/iVjM2BHkEhb1UIjzu3AFTEgIYv+iJ7
 ELp0I3vdRg//cxz+wWvGT86UJqEA2+47Nr9RuFHPwD4aLFncoYxivKA/UUGi23BoWDHa
 v+MA==
X-Gm-Message-State: AOAM531HXN20AF0CzwjsHJjP8VuTVHGZgub58cQYsCdyFDKyabzcX/nH
 d9m7APgQaWjFd8B/oCtcI86Qgw==
X-Google-Smtp-Source: ABdhPJztg/GMLQiJsp56ZgQw+18EozlHIZfdrJ3OccOyQp9MQYy9FV43/uUUpAIaYwVj4+6W27OXmQ==
X-Received: by 2002:adf:b78b:: with SMTP id s11mr20356134wre.42.1605547811771; 
 Mon, 16 Nov 2020 09:30:11 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:30:11 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/43] drm/radeon/radeon: Move prototype into shared header
Date: Mon, 16 Nov 2020 17:29:24 +0000
Message-Id: <20201116173005.1825880-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:12 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VW5mb3J0dW5hdGVseSwgYSBzdWl0YWJsZSBvbmUgZGlkbid0IGFscmVhZHkgZXhpc3QuCgpGaXhl
cyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYzo2Mzc6Njogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhyYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWzigJkgWy1XbWlzc2luZy1w
cm90b3R5cGVzXQogNjM3IHwgYm9vbCByYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWwodm9pZCkKIHwg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5h
cm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzog
bGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
ZGV2aWNlLmMgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuaCB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9kcnYuYyAgICB8ICAzICstLQogMyBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2RldmljZS5oCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYwpp
bmRleCA3ZjM4NGZmZTg0OGE3Li5hZDU3MmY5NjUxOTBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kZXZpY2UuYwpAQCAtNDIsNiArNDIsNyBAQAogI2luY2x1ZGUgPGRybS9kcm1fcHJv
YmVfaGVscGVyLmg+CiAjaW5jbHVkZSA8ZHJtL3JhZGVvbl9kcm0uaD4KIAorI2luY2x1ZGUgInJh
ZGVvbl9kZXZpY2UuaCIKICNpbmNsdWRlICJyYWRlb25fcmVnLmgiCiAjaW5jbHVkZSAicmFkZW9u
LmgiCiAjaW5jbHVkZSAiYXRvbS5oIgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fZGV2aWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2Uu
aApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAwLi4zMTEyYjk5YWUzNmYx
Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNl
LmgKQEAgLTAsMCArMSwzMiBAQAorLyogcmFkZW9uX2RldmljZS5oIC0tIFByaXZhdGUgaGVhZGVy
IGZvciByYWRlb24gZGV2aWNlIC0qLSBsaW51eC1jIC0qLQorICoKKyAqIENvcHlyaWdodCAxOTk5
IFByZWNpc2lvbiBJbnNpZ2h0LCBJbmMuLCBDZWRhciBQYXJrLCBUZXhhcy4KKyAqIENvcHlyaWdo
dCAyMDAwIFZBIExpbnV4IFN5c3RlbXMsIEluYy4sIEZyZW1vbnQsIENhbGlmb3JuaWEuCisgKiBB
bGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQs
IGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhCisgKiBjb3B5IG9mIHRo
aXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0
d2FyZSIpLAorICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91dCByZXN0cmljdGlvbiwg
aW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgorICogdGhlIHJpZ2h0cyB0byB1c2UsIGNvcHks
IG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsCisgKiBhbmQv
b3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8g
d2hvbSB0aGUKKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0
aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgorICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3Rp
Y2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2UgKGluY2x1ZGluZyB0aGUgbmV4dAorICogcGFy
YWdyYXBoKSBzaGFsbCBiZSBpbmNsdWRlZCBpbiBhbGwgY29waWVzIG9yIHN1YnN0YW50aWFsIHBv
cnRpb25zIG9mIHRoZQorICogU29mdHdhcmUuCisgKgorICogVEhFIFNPRlRXQVJFIElTIFBST1ZJ
REVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MgT1IKKyAq
IElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0Yg
TUVSQ0hBTlRBQklMSVRZLAorICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5E
IE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UIFNIQUxMCisgKiBQUkVDSVNJT04gSU5TSUdI
VCBBTkQvT1IgSVRTIFNVUFBMSUVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBP
UgorICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwg
VE9SVCBPUiBPVEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNU
SU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIKKyAqIERFQUxJTkdTIElO
IFRIRSBTT0ZUV0FSRS4KKyAqLworCisjaWZuZGVmIF9fUkFERU9OX0RFVklDRV9IX18KKyNkZWZp
bmUgX19SQURFT05fREVWSUNFX0hfXworCitib29sIHJhZGVvbl9kZXZpY2VfaXNfdmlydHVhbCh2
b2lkKTsKKworI2VuZGlmCQkJCS8qIF9fUkFERU9OX0RFVklDRV9IX18gKi8KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZHJ2LmMKaW5kZXggZjgxM2ViNWUxNDBkZC4uNTM2YjI0NmI5YTZhYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKQEAgLTUyLDYgKzUyLDcgQEAKIAogI2luY2x1
ZGUgInJhZGVvbl9kcnYuaCIKICNpbmNsdWRlICJyYWRlb24uaCIKKyNpbmNsdWRlICJyYWRlb25f
ZGV2aWNlLmgiCiAKIC8qCiAgKiBLTVMgd3JhcHBlci4KQEAgLTI5Myw4ICsyOTQsNiBAQCBNT0RV
TEVfREVWSUNFX1RBQkxFKHBjaSwgcGNpaWRsaXN0KTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBk
cm1fZHJpdmVyIGttc19kcml2ZXI7CiAKLWJvb2wgcmFkZW9uX2RldmljZV9pc192aXJ0dWFsKHZv
aWQpOwotCiBzdGF0aWMgaW50IHJhZGVvbl9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
CiAJCQkgICAgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkKIHsKLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
