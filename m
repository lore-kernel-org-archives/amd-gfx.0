Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE59C6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CCC2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ut8jxO1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CCC2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1736EA2D;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749D26E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:19 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r17so19662457wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZUOfHDa8VKjKfvaDOIZ0lG7+TRmewMW6pKq0nq4Yf40=;
 b=ut8jxO1lAmNq7OzJ9R4sz0vJdyrWQMXwL0AD6ih0EUtENjbT02f+txcqG8JOqBTl3G
 y8DyBeyPhhRECA9RCvjs4fvoaJ8rikWI8AKq0WhKNu4bFRC/xeyjdEMsORqjufwFFK82
 O4ZF7LtxJ/AOhxvXXu0e4DCqSSxUbH13n4bil2XlmGi2/fGURIoBCpx4Wbfq0Xh04L3b
 A3xYKjycgkl/XqpmhTHokEo4RtdlampZs0ZzrbVb36g/PSvC5p57RNjdkbjU1+kVsSkY
 yhaEPK+mpcZO8E+qjDbR8BUK3bXeBNtVCXID4/wbENNRoQeZ+MLf06BPQ72PlLc8BSFg
 cQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZUOfHDa8VKjKfvaDOIZ0lG7+TRmewMW6pKq0nq4Yf40=;
 b=pFs/orAAs6DdxV86Xq+kg7OKI7UYMW3AFJ4/fftI0SuuC6ITlme5cRoXQ9RJpgbf1x
 k96CjtykRyU7dqkVZuKpxWZJSM4j5tY8cUp2podFvfRRBjMKKzlX/qo6HURYj8l2Pt7A
 W/02Dp1lQdXxG3mnAPUCac/CfyYDgi1jUWARQcLgbJnrfK8jrSJzjtBrChHvrV9irw7A
 xTfKCMwd4fQvRVzO5wUWX6yu234kns9SHbiY0RdaQ6XN6Inuzju+Oec/2V5n8H18lwEq
 P9onnOC26F1PIRYy/pICobw6+ggIAKo5c3h9V+KooBvQBaLdHjroHE1mTQ3nQTVpdYOU
 1bCA==
X-Gm-Message-State: AOAM533qyHC94sUT67boXaeSyyGEOymBGJvLNhSRzFcm2R+imvfY/eRB
 W3dQhC1+X8v21Jdd6++5JT5XJQ==
X-Google-Smtp-Source: ABdhPJx2zAlCsh+71uTEhUoKN+Lvzh21s/GlhOo5TSlZcYkH4N2jg/QIQ2KTKWXCwfHDyQEx5HqGaw==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr20432633wrq.52.1605548238161; 
 Mon, 16 Nov 2020 09:37:18 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/43] drm/radeon/radeon_pm: Move
 'radeon_pm_acpi_event_handler' prototype into shared header
Date: Mon, 16 Nov 2020 17:36:27 +0000
Message-Id: <20201116173700.1830487-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fcG0uYzo3NDo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBw
cm90b3R5cGUgZm9yIOKAmHJhZGVvbl9wbV9hY3BpX2V2ZW50X2hhbmRsZXLigJkgWy1XbWlzc2lu
Zy1wcm90b3R5cGVzXQogNzQgfCB2b2lkIHJhZGVvbl9wbV9hY3BpX2V2ZW50X2hhbmRsZXIoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4K
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6
IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
bGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFy
by5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hY3BpLmMgfCAgMyArLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX3BtLmMgICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX3BtLmggICB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmls
ZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9wbS5oCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYWNwaS5jIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fYWNwaS5jCmluZGV4IDZjZjE2NDVlN2ExYTguLjFiYWVmN2I0OTNkZWYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2FjcGkuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hY3BpLmMKQEAgLTM2LDYgKzM2LDcgQEAKICNpbmNs
dWRlICJhdG9tLmgiCiAjaW5jbHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFkZW9uX2FjcGku
aCIKKyNpbmNsdWRlICJyYWRlb25fcG0uaCIKIAogI2lmIGRlZmluZWQoQ09ORklHX1ZHQV9TV0lU
Q0hFUk9PKQogYm9vbCByYWRlb25fYXRweF9kZ3B1X3JlcV9wb3dlcl9mb3JfZGlzcGxheXModm9p
ZCk7CkBAIC00NSw4ICs0Niw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCByYWRlb25fYXRweF9kZ3B1
X3JlcV9wb3dlcl9mb3JfZGlzcGxheXModm9pZCkgeyByZXR1cm4gZmFsc2U7CiAKICNkZWZpbmUg
QUNQSV9BQ19DTEFTUyAgICAgICAgICAgImFjX2FkYXB0ZXIiCiAKLWV4dGVybiB2b2lkIHJhZGVv
bl9wbV9hY3BpX2V2ZW50X2hhbmRsZXIoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotCiBz
dHJ1Y3QgYXRpZl92ZXJpZnlfaW50ZXJmYWNlIHsKIAl1MTYgc2l6ZTsJCS8qIHN0cnVjdHVyZSBz
aXplIGluIGJ5dGVzIChpbmNsdWRlcyBzaXplIGZpZWxkKSAqLwogCXUxNiB2ZXJzaW9uOwkJLyog
dmVyc2lvbiAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fcG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3BtLmMKaW5kZXggNjVkMTcyYjEzZTA2
NS4uMTk5NWRhZDU5ZGQwOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9wbS5jCkBAIC0zMyw2
ICszMyw3IEBACiAjaW5jbHVkZSAiYXZpdm9kLmgiCiAjaW5jbHVkZSAicjYwMF9kcG0uaCIKICNp
bmNsdWRlICJyYWRlb24uaCIKKyNpbmNsdWRlICJyYWRlb25fcG0uaCIKIAogI2RlZmluZSBSQURF
T05fSURMRV9MT09QX01TIDEwMAogI2RlZmluZSBSQURFT05fUkVDTE9DS19ERUxBWV9NUyAyMDAK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3BtLmggYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9wbS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwMDAuLjVlZjE0Nzc4NWU4MTUKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9wbS5oCkBAIC0wLDAgKzEsMzMgQEAKKy8qIHJhZGVvbl9wbS5o
IC0tIFByaXZhdGUgaGVhZGVyIGZvciByYWRlb24gZHJpdmVyIC0qLSBsaW51eC1jIC0qLQorICoK
KyAqIENvcHlyaWdodCAxOTk5IFByZWNpc2lvbiBJbnNpZ2h0LCBJbmMuLCBDZWRhciBQYXJrLCBU
ZXhhcy4KKyAqIENvcHlyaWdodCAyMDAwIFZBIExpbnV4IFN5c3RlbXMsIEluYy4sIEZyZW1vbnQs
IENhbGlmb3JuaWEuCisgKiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqIFBlcm1pc3Npb24g
aXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmlu
ZyBhCisgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlv
biBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLAorICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0
aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgorICogdGhlIHJp
Z2h0cyB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1
YmxpY2Vuc2UsCisgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8g
cGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBk
byBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgorICogVGhlIGFi
b3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2UgKGluY2x1ZGlu
ZyB0aGUgbmV4dAorICogcGFyYWdyYXBoKSBzaGFsbCBiZSBpbmNsdWRlZCBpbiBhbGwgY29waWVz
IG9yIHN1YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZQorICogU29mdHdhcmUuCisgKgorICogVEhF
IFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJ
TkQsIEVYUFJFU1MgT1IKKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8g
VEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAorICogRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UIFNIQUxMCisg
KiBQUkVDSVNJT04gSU5TSUdIVCBBTkQvT1IgSVRTIFNVUFBMSUVSUyBCRSBMSUFCTEUgRk9SIEFO
WSBDTEFJTSwgREFNQUdFUyBPUgorICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFD
VElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9V
VCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RI
RVIKKyAqIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KKyAqCisgKi8KKworI2lmbmRlZiBfX1JB
REVPTl9QTV9IX18KKyNkZWZpbmUgX19SQURFT05fUE1fSF9fCisKK3ZvaWQgcmFkZW9uX3BtX2Fj
cGlfZXZlbnRfaGFuZGxlcihzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CisKKyNlbmRpZgkJ
CQkvKiBfX1JBREVPTl9QTV9IX18gKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
