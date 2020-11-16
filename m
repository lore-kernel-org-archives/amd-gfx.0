Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02154C64EBC
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDC92225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8HzgcFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDC92225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB666EA30;
	Mon, 16 Nov 2020 19:18:44 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCC46E067
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:35 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 19so36380wmf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bUgD99dAZfuLWNam3kGxkjEykoel9F1pl4Jg76K7MCg=;
 b=A8HzgcFmHJlDoRnxOLVZNJsNZd5RSaDMhSbJjyA6Zsf+uOVZiwxgsrZ3qS/yomov6M
 ImfkYga1c9za82A3rxY+3q1sgd1dKCR4FLFTq54FzNvsOXjP4jT3rk7iNq4V+OfNY1qz
 HA3Guu8rubwWPgTwa96fKsPnDlmxn4lljezuu9Htm+kOdivDmj83mDkrl9I0Lgmt7hAI
 NcjebhEvuNFy98kZ0fjw6avLJaR4r/+QtLJqJbYxr/c1rqXQdoPd7Z2LCUKWcWb219aN
 MtgPdH+xHTSR3WfhZ6yXP6rToCbCsx2/OQ7yUsk6/6IyW62TPiCBhsUK01Z3RQsgytV9
 pl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bUgD99dAZfuLWNam3kGxkjEykoel9F1pl4Jg76K7MCg=;
 b=eZ719vDp/p94HIC4xofXUeFcgRypdGb0brns++OtGb9jL3LVdOsry6rKDHAg2yg5R0
 a/5WwU2jxxTYRh4sb4Kwz2Q0ZGZrkpKZx/eA96cbPHd0nN2YsRlPWD7DRBe7lpTr9Qwd
 r+RYXNOSWXw0lXjydI7UUgLm+wB9U1d809QJY7P/nJ5nth+MqJeUEf8Y5Bo1ZAgtpaWE
 O21vk0y/C9K++GtwjTPwmGTM3ZqaCa0xcBzbD3pmj2kC06IEUFjlfVYsH51MmdUoLCL9
 m7BEbjS2ZI70/y8S8pMuZzR1LJHdFBPt8AFr+QtccyMS6XTC/FiT9by6VIKRnvBJ1Ue8
 r8Ig==
X-Gm-Message-State: AOAM533wYF2deJ7IgfK5n+lGnj5NKkDzqFEojo1UXDGKa8dwmbajfOJ4
 dHidZE4wgrVeGA5tSEWyg4WmgQ==
X-Google-Smtp-Source: ABdhPJxlyykqsXt354bAFqYf+ZEcs9kf2t4KuZ489r99dtOsPjsfVIxOwBijBEqB1CWFQJ+qtJiSng==
X-Received: by 2002:a05:600c:2204:: with SMTP id
 z4mr15910947wml.57.1605548254381; 
 Mon, 16 Nov 2020 09:37:34 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:33 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 21/43] drm/radeon/r600_dma: Move
 'r600_gpu_check_soft_reset()'s prototype to shared location
Date: Mon, 16 Nov 2020 17:36:38 +0000
Message-Id: <20201116173700.1830487-22-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yNjAwLmM6MTYxNTo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yIOKAmHI2MDBfZ3B1X2NoZWNrX3NvZnRfcmVzZXTigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQogMTYxNSB8IHUzMiByNjAwX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWci
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13
YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlh
QHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yNjAwLmMgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
NjAwLmggICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yNjAwX2RtYS5jIHwgIDMgKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yNjAwLmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jCmluZGV4IGYwOWI2ZGM1Y2Jl
YjMuLjk0ZTg4MTVlNTA2N2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYw
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jCkBAIC0zOSw2ICszOSw3IEBA
CiAKICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVkZSAiYXZpdm9kLmgiCisjaW5jbHVkZSAicjYw
MC5oIgogI2luY2x1ZGUgInI2MDBkLmgiCiAjaW5jbHVkZSAicnY3NzAuaCIKICNpbmNsdWRlICJy
YWRlb24uaCIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5oIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwMC4uMmEzOTE1ZjAwMzllNAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcjYwMC5oCkBAIC0wLDAgKzEsMzUgQEAKKy8qIHI2MDAuaCAtLSBQcml2YXRl
IGhlYWRlciBmb3IgcmFkZW9uIGRyaXZlciAtKi0gbGludXgtYyAtKi0KKyAqCisgKiBDb3B5cmln
aHQgMTk5OSBQcmVjaXNpb24gSW5zaWdodCwgSW5jLiwgQ2VkYXIgUGFyaywgVGV4YXMuCisgKiBD
b3B5cmlnaHQgMjAwMCBWQSBMaW51eCBTeXN0ZW1zLCBJbmMuLCBGcmVtb250LCBDYWxpZm9ybmlh
LgorICogQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBn
cmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYQorICogY29w
eSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRo
ZSAiU29mdHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJp
Y3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24KKyAqIHRoZSByaWdodHMgdG8gdXNl
LCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLAor
ICogYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJz
b25zIHRvIHdob20gdGhlCisgKiBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8gZG8gc28sIHN1Ympl
Y3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmln
aHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIChpbmNsdWRpbmcgdGhlIG5leHQK
KyAqIHBhcmFncmFwaCkgc2hhbGwgYmUgaW5jbHVkZWQgaW4gYWxsIGNvcGllcyBvciBzdWJzdGFu
dGlhbCBwb3J0aW9ucyBvZiB0aGUKKyAqIFNvZnR3YXJlLgorICoKKyAqIFRIRSBTT0ZUV0FSRSBJ
UyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNT
IE9SCisgKiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5U
SUVTIE9GIE1FUkNIQU5UQUJJTElUWSwKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFIEFORCBOT05JTkZSSU5HRU1FTlQuICBJTiBOTyBFVkVOVCBTSEFMTAorICogUFJFQ0lTSU9O
IElOU0lHSFQgQU5EL09SIElUUyBTVVBQTElFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERB
TUFHRVMgT1IKKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09O
VFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLAorICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4g
Q09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSCisgKiBERUFM
SU5HUyBJTiBUSEUgU09GVFdBUkUuCisgKgorICovCisKKyNpZm5kZWYgX19SNjAwX0hfXworI2Rl
ZmluZSBfX1I2MDBfSF9fCisKK3N0cnVjdCByYWRlb25fZGV2aWNlOworCit1MzIgcjYwMF9ncHVf
Y2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CisKKyNlbmRpZgkJ
CQkvKiBfX1I2MDBfSF9fICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2
MDBfZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfZG1hLmMKaW5kZXggYWY2YzBk
YTQ1ZjI4YS4uODljYTI3MzhjNWQ0YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yNjAwX2RtYS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9kbWEuYwpAQCAt
MjQsMTAgKzI0LDkgQEAKIAogI2luY2x1ZGUgInJhZGVvbi5oIgogI2luY2x1ZGUgInJhZGVvbl9h
c2ljLmgiCisjaW5jbHVkZSAicjYwMC5oIgogI2luY2x1ZGUgInI2MDBkLmgiCiAKLXUzMiByNjAw
X2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKLQogLyoK
ICAqIERNQQogICogU3RhcnRpbmcgd2l0aCBSNjAwLCB0aGUgR1BVIGhhcyBhbiBhc3luY2hyb25v
dXMKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
