Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B19FC64E69
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC91F2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPuaAhSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC91F2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040716EA31;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DACE6E038
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:11 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id r17so19661644wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sc1pkIB+FW/k5gLv6YQPQhC4CZ1RwfaoeaGhthq0b4c=;
 b=mPuaAhSddpX0TY3ZOxs/irH2uOKqIchw+XgeJzhGsetdcsBXHVK93VOGNAfvw00h2A
 RXXmy0+ahdAZxG37S0KzyocdNXVyH1e4Luo5P6OGLZUH3UmeHNgJhubVQ0P//WvV23EM
 FlsR3laPq+0oWJlRkbm8x9gXl91boEdF8JdRy9dO8Es04tZC9zAaS//aUF+KveB8SpSk
 uD4Okgb3cB0vsK7Iu6ALQ5nYFNr+Y7gM3OGe4WAz/RiItYAIMlMGMl62RJetUQLtVH85
 FywTI4ViK53ViNmFVMYUo00yJwlS00aQBZ0C+XZ2Grt6XYuogGK9d5W0nlntcX9vOCUs
 6dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sc1pkIB+FW/k5gLv6YQPQhC4CZ1RwfaoeaGhthq0b4c=;
 b=eQGQab0LFKQdSwB0unqDX9VbZUf1ba53E1TwERGwCUoOrOd/KPPADYPasqP4pa73yi
 Sl8j4vZV3qWmsIiNgSmtbXmeo5nh6shlEG9mQIR6dvpllChMN5uMMARYF7QS6yMtfh0e
 MNKPv+1hwA/HhCpi/0QWX8xyb3q1pXdU10MFgFy5yY9jCpDGZO2/ace/5sJK4tuEOqPj
 ivamfFU89GO0bp+vmxJFL0DFYIaqKfqcd2x+aaNzIOXsoSi+/zkyE1NaSXcrXRNtOE5S
 viRfZ2AlxC4v+MUbtcCpMWxF05S81wqZBovKxDVzzuBo28h2zAMu/Wj4cnUJP1SRxpZL
 B2TA==
X-Gm-Message-State: AOAM530UaW/SACGHEO69+QZnivetVl8CEgZOEeoIexfPJl0V4Ry5tKrv
 C0Go67p5TjoOUpBfkuZpXPDTNw==
X-Google-Smtp-Source: ABdhPJx/CgDQnJgp2vUU18Py1OgzA+nGyj8bmKcejT6CvCOBDYKMmVYShIvkZKlWr78Pq9qiZQ96Zg==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr21993925wre.55.1605548229923; 
 Mon, 16 Nov 2020 09:37:09 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:09 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/43] drm/radeon: Move radeon_ttm{init,
 fini} to shared location
Date: Mon, 16 Nov 2020 17:36:22 +0000
Message-Id: <20201116173700.1830487-6-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmM6IEF0IHRvcCBsZXZlbDoKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jOjgxNzo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yIOKAmHJhZGVvbl90dG1faW5pdOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiA4
MTcgfCBpbnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogfCBe
fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jOjg3ODo2
OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl90dG1fZmluaeKA
mSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiA4NzggfCB2b2lkIHJhZGVvbl90dG1fZmluaShzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldikKIHwgXn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgfCAgMyArLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX3R0bS5jICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
dHRtLmggICAgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2Vk
LCAzOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5oCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9vYmplY3QuYwppbmRleCBhYjgxZTM1Y2IwNjA2Li44YmM1YWQxZDY1ODU3IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYwpAQCAtNDAsOSArNDAsOCBAQAogCiAjaW5j
bHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFkZW9uX3RyYWNlLmgiCisjaW5jbHVkZSAicmFk
ZW9uX3R0bS5oIgogCi1pbnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpy
ZGV2KTsKLXZvaWQgcmFkZW9uX3R0bV9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsK
IHN0YXRpYyB2b2lkIHJhZGVvbl9ib19jbGVhcl9zdXJmYWNlX3JlZyhzdHJ1Y3QgcmFkZW9uX2Jv
ICpibyk7CiAKIC8qCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90
dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCmluZGV4IDI5MzllNzFj
ZWI3MDAuLjI4YjMwMGVkMjAwZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCkBA
IC01MSw2ICs1MSw3IEBACiAKICNpbmNsdWRlICJyYWRlb25fcmVnLmgiCiAjaW5jbHVkZSAicmFk
ZW9uLmgiCisjaW5jbHVkZSAicmFkZW9uX3R0bS5oIgogCiBzdGF0aWMgaW50IHJhZGVvbl90dG1f
ZGVidWdmc19pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHN0YXRpYyB2b2lkIHJh
ZGVvbl90dG1fZGVidWdmc19maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5oIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fdHRtLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAwMC4uOTFlYTcxNDFiYzgxMgotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3R0bS5oCkBAIC0wLDAgKzEsMzYgQEAKKy8qIHJhZGVvbl90dG0uaCAt
LSBQcml2YXRlIGhlYWRlciBmb3IgcmFkZW9uIGRyaXZlciAtKi0gbGludXgtYyAtKi0KKyAqCisg
KiBDb3B5cmlnaHQgMTk5OSBQcmVjaXNpb24gSW5zaWdodCwgSW5jLiwgQ2VkYXIgUGFyaywgVGV4
YXMuCisgKiBDb3B5cmlnaHQgMjAwMCBWQSBMaW51eCBTeXN0ZW1zLCBJbmMuLCBGcmVtb250LCBD
YWxpZm9ybmlhLgorICogQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiBQZXJtaXNzaW9uIGlz
IGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcg
YQorICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24g
ZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4gdGhlIFNvZnR3YXJlIHdpdGhv
dXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24KKyAqIHRoZSByaWdo
dHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJs
aWNlbnNlLAorICogYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBl
cm1pdCBwZXJzb25zIHRvIHdob20gdGhlCisgKiBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8gZG8g
c28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92
ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIChpbmNsdWRpbmcg
dGhlIG5leHQKKyAqIHBhcmFncmFwaCkgc2hhbGwgYmUgaW5jbHVkZWQgaW4gYWxsIGNvcGllcyBv
ciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUKKyAqIFNvZnR3YXJlLgorICoKKyAqIFRIRSBT
T0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5E
LCBFWFBSRVNTIE9SCisgKiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRI
RSBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSwKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUiBQVVJQT1NFIEFORCBOT05JTkZSSU5HRU1FTlQuICBJTiBOTyBFVkVOVCBTSEFMTAorICog
UFJFQ0lTSU9OIElOU0lHSFQgQU5EL09SIElUUyBTVVBQTElFUlMgQkUgTElBQkxFIEZPUiBBTlkg
Q0xBSU0sIERBTUFHRVMgT1IKKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJ
T04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLAorICogQVJJU0lORyBGUk9NLCBPVVQg
T0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVS
CisgKiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCisgKgorICovCisKKyNpZm5kZWYgX19SQURF
T05fVFRNX0hfXworI2RlZmluZSBfX1JBREVPTl9UVE1fSF9fCisKK3N0cnVjdCByYWRlb25fZGV2
aWNlOworCitpbnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsK
K3ZvaWQgcmFkZW9uX3R0bV9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKKworI2Vu
ZGlmCQkJCS8qIF9fUkFERU9OX1RUTV9IX18gKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
