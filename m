Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B054DC4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A682225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrJ7nX+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A682225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B6C6EA24;
	Mon, 16 Nov 2020 19:18:17 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F8E89F8B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:30:14 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id d12so19570433wrr.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XmKc1pxfWNIhhVZbat4IeYMq2SqMBDzsHL5Wfk03ato=;
 b=ZrJ7nX+Ss2SwWtGJ5a77Xmq6naZYfFaODqVex6B0ksRVu6CPODbPoqrLXrQzYtwaPO
 g2v5cNvW2Nq96enR9+AbUk3KUpTCjHRBie7PJXTRF2+zjdR2dFZ5wzFfvYmprBW28PPX
 gd8RqEttaE44L9FUKUGhdDo3sNt32I5PLbysKwTyGi5YOJN+PueBEhdW4f9haTBRn06T
 /iMwHs1+TC6BEalMW/9cWcHAGfDzJnRwWBoQBrZ8mIkc02e5cKDWTcy2S2gs04DAvUAv
 N8Kv7DD+nUHndcbDQag4Pqnp55eMgu8spglrTL8SXYWmnuOdWnT07R02S97rOIad1pmx
 XPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XmKc1pxfWNIhhVZbat4IeYMq2SqMBDzsHL5Wfk03ato=;
 b=HVf7fjT4TFc1xLPXpHe/j9oCCcXDEW8yD0FItpGWantnppKl4oJgaigJzXWOmdeVfu
 QmrcS2gRm57wHEimz4+bFFDqRWzvojEEu/1+BzM4BkzREYy9sVr3HIuXAfRb6amezIff
 pPJBFsZAGiRQIrtRmrym29zQO3JMURHYvi3kmCM1T9/hGgMPEgXFHUPFaNTEj1psz06H
 QZKmElHGSN6b3pd780zsxpaPiqJNO+dadADx/pPALLv9dzs9KuiaHtQZNjXfr0Adp7DY
 jaoeIu1P4Wbz51Ju8af7RmTrVhS/VZmBqzb+pHhQpDeav2A14cpuMZFqcwCWe3oj+KNf
 Sp6Q==
X-Gm-Message-State: AOAM532Fq4ue69COs7uMd3YE0G8zyd7hh+4YfDDqg6vsvuBYR9b4EQLw
 miH4CWApMvU9D1mBh3jyT2+HEg==
X-Google-Smtp-Source: ABdhPJxDW0C9hokk5Jgdhjsw1VAWin7x+QtQzgHNDV1EILyPJhWE374L4EcFm7kOrhI0qm1a5ONMjQ==
X-Received: by 2002:adf:e287:: with SMTP id v7mr21597907wri.252.1605547813193; 
 Mon, 16 Nov 2020 09:30:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:30:12 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 03/43] drm/radeon/radeon_kms: Move 'radeon_*_kms' prototypes
 to shared header
Date: Mon, 16 Nov 2020 17:29:25 +0000
Message-Id: <20201116173005.1825880-4-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6NzU2OjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2dldF92YmxhbmtfY291bnRlcl9rbXPigJkgWy1XbWlz
c2luZy1wcm90b3R5cGVzXQogNzU2IHwgdTMyIHJhZGVvbl9nZXRfdmJsYW5rX2NvdW50ZXJfa21z
KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4K
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jOjgyNjo1OiB3YXJuaW5nOiBubyBw
cmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9lbmFibGVfdmJsYW5rX2ttc+KAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdCiA4MjYgfCBpbnQgcmFkZW9uX2VuYWJsZV92Ymxhbmtfa21zKHN0
cnVjdCBkcm1fY3J0YyAqY3J0YykKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYzo4NTM6Njogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhyYWRlb25fZGlzYWJsZV92Ymxhbmtfa21z4oCZIFstV21pc3Npbmct
cHJvdG90eXBlc10KIDg1MyB8IHZvaWQgcmFkZW9uX2Rpc2FibGVfdmJsYW5rX2ttcyhzdHJ1Y3Qg
ZHJtX2NydGMgKmNydGMpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdh
bCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFA
dmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVk
LW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9rbXMuYyAgICAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9rbXMuaCAgICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5n
ZWQsIDM3IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9rbXMuaAoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXku
YwppbmRleCBlYjBkNGNiOTVmMGE2Li4zYTZmZWRhZDAwMmQ3IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZGlzcGxheS5jCkBAIC00NCw2ICs0NCw3IEBACiAKICNpbmNsdWRlICJhdG9t
LmgiCiAjaW5jbHVkZSAicmFkZW9uLmgiCisjaW5jbHVkZSAicmFkZW9uX2ttcy5oIgogCiBzdGF0
aWMgdm9pZCBhdml2b19jcnRjX2xvYWRfbHV0KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKIHsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKaW5kZXggM2QzMWMwNGU0YjNkYi4uMDAxOTQwYmNh
OTBhNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKQEAgLTQxLDYgKzQxLDcgQEAK
ICNpbmNsdWRlICJyYWRlb24uaCIKICNpbmNsdWRlICJyYWRlb25fYXNpYy5oIgogI2luY2x1ZGUg
InJhZGVvbl9kcnYuaCIKKyNpbmNsdWRlICJyYWRlb25fa21zLmgiCiAKICNpZiBkZWZpbmVkKENP
TkZJR19WR0FfU1dJVENIRVJPTykKIGJvb2wgcmFkZW9uX2hhc19hdHB4KHZvaWQpOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmggYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9rbXMuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAwMDAwLi4zNmU3M2NlYTkyMTU0Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fa21zLmgKQEAgLTAsMCArMSwzNSBAQAorLyogcmFkZW9uX2ttcy5oIC0t
IFByaXZhdGUgaGVhZGVyIGZvciByYWRlb24gZHJpdmVyIC0qLSBsaW51eC1jIC0qLQorICoKKyAq
IENvcHlyaWdodCAxOTk5IFByZWNpc2lvbiBJbnNpZ2h0LCBJbmMuLCBDZWRhciBQYXJrLCBUZXhh
cy4KKyAqIENvcHlyaWdodCAyMDAwIFZBIExpbnV4IFN5c3RlbXMsIEluYy4sIEZyZW1vbnQsIENh
bGlmb3JuaWEuCisgKiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqIFBlcm1pc3Npb24gaXMg
aGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBh
CisgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBm
aWxlcyAodGhlICJTb2Z0d2FyZSIpLAorICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91
dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgorICogdGhlIHJpZ2h0
cyB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1Ymxp
Y2Vuc2UsCisgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVy
bWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBz
bywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgorICogVGhlIGFib3Zl
IGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2UgKGluY2x1ZGluZyB0
aGUgbmV4dAorICogcGFyYWdyYXBoKSBzaGFsbCBiZSBpbmNsdWRlZCBpbiBhbGwgY29waWVzIG9y
IHN1YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZQorICogU29mdHdhcmUuCisgKgorICogVEhFIFNP
RlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQs
IEVYUFJFU1MgT1IKKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhF
IFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAorICogRklUTkVTUyBGT1IgQSBQQVJUSUNV
TEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UIFNIQUxMCisgKiBQ
UkVDSVNJT04gSU5TSUdIVCBBTkQvT1IgSVRTIFNVUFBMSUVSUyBCRSBMSUFCTEUgRk9SIEFOWSBD
TEFJTSwgREFNQUdFUyBPUgorICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElP
TiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9VVCBP
RiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIK
KyAqIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KKyAqCisgKi8KKworI2lmbmRlZiBfX1JBREVP
Tl9LTVNfSF9fCisjZGVmaW5lIF9fUkFERU9OX0tNU19IX18KKwordTMyIHJhZGVvbl9nZXRfdmJs
YW5rX2NvdW50ZXJfa21zKHN0cnVjdCBkcm1fY3J0YyAqY3J0Yyk7CitpbnQgcmFkZW9uX2VuYWJs
ZV92Ymxhbmtfa21zKHN0cnVjdCBkcm1fY3J0YyAqY3J0Yyk7Cit2b2lkIHJhZGVvbl9kaXNhYmxl
X3ZibGFua19rbXMoc3RydWN0IGRybV9jcnRjICpjcnRjKTsKKworI2VuZGlmCQkJCS8qIF9fUkFE
RU9OX0tNU19IX18gKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
