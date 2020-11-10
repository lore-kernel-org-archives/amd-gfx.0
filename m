Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC32C55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F1120665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlTwq3M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F1120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C2889C9D;
	Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3430F89C27
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a65so4312119wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yZG8b3VSvYC13jIZxtAzuDvkZe5JEeqWAbsGA92XYsQ=;
 b=PlTwq3M/AnxqB4it2zELA31g8xTkrmipGiAiUpyRoXp86grITjzcET7M5mbdvGW3lq
 jBzstjuCKRAiKDf6MGVtBf4Xv+PCU+UJEhTiD+NT0f64OnFgVJ1dIsoIkAE+ujw1/U42
 Vu3uVodNEJupMp4SunieavkN3LdV3WeqTT8tvtpi/j0hQ5UkUWPa+ISjf0hCOrSELHvY
 5VohlWvYGlOkiJZX8Kux1RkuyzKXIDRA9kJ8cgPdhefeGBUCsl6nAO3ky7vxw5QPp1ky
 IUHYfN7JQbqmXt7dh0KWpIWhreJbKnNZ/BJSzNKn3qA5jiqvTdkIsTO2vv9kHexAoB94
 ptWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yZG8b3VSvYC13jIZxtAzuDvkZe5JEeqWAbsGA92XYsQ=;
 b=U5SFsJlI9aCatLYM6dRWEWaze5zW7eqzMZyRgx89xdcUAsAPOeZh1dhQijBR9DnXrm
 nUgB89gsxX8zBe/aoQHLbYjZ8DoGkuHmsiRw/jhSdyE8mx12qdpkgIAJMUHiGSLfu26H
 A3yZlZcpFg1a+X4QoeehAYWMa2mswzRdscBhihmdv8kn3pM3ASxAQ4rvntaISJr6ouQA
 9sVjbEjNc+vZg7wtR3HdGCwcQIFiAA//Txp7BkOBXyh+VPhig7CEDIz0FTKNSUdESsxz
 UdnXIYAPl0ERIDJ8m+mF5PJHM1A3HCwFo0cHSRe9kLvaQN7jLtRqaqB0oZ16q29+AFRc
 DXdw==
X-Gm-Message-State: AOAM530xMHFb/8ECLZOdZHkFLEOkEf1Bx6F3N1MP7+Pw4Uyfiw2WfqSW
 Io9o9PSJGUyzhHmPG1lNqKKIRg==
X-Google-Smtp-Source: ABdhPJyFX4EIySZjnq8I6WF/JdNy53Tt+dwFFrIcPtMzg1PSx9VchypF3YcPFlJNIm11CfwAdPrzZg==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr766401wme.0.1605036712676;
 Tue, 10 Nov 2020 11:31:52 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 29/30] drm/radeon/r600_dma: Move
 'r600_gpu_check_soft_reset()'s prototype to shared location
Date: Tue, 10 Nov 2020 19:31:11 +0000
Message-Id: <20201110193112.988999-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
NjAwLmggICAgIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yNjAwX2RtYS5jIHwgIDMgKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yNjAwLmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jCmluZGV4IGYwOWI2ZGM1Y2Jl
YjMuLjk0ZTg4MTVlNTA2N2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYw
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jCkBAIC0zOSw2ICszOSw3IEBA
CiAKICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVkZSAiYXZpdm9kLmgiCisjaW5jbHVkZSAicjYw
MC5oIgogI2luY2x1ZGUgInI2MDBkLmgiCiAjaW5jbHVkZSAicnY3NzAuaCIKICNpbmNsdWRlICJy
YWRlb24uaCIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5oIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwMC4uMWJmMmQwNTcyZjA0NwotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcjYwMC5oCkBAIC0wLDAgKzEsMzMgQEAKKy8qIHI2MDAuaCAtLSBQcml2YXRl
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
ZmluZSBfX1I2MDBfSF9fCisKK3UzMiByNjAwX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2KTsKKworI2VuZGlmCQkJCS8qIF9fUjYwMF9IX18gKi8KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9kbWEuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcjYwMF9kbWEuYwppbmRleCBhZjZjMGRhNDVmMjhhLi44OWNhMjczOGM1ZDRjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfZG1hLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yNjAwX2RtYS5jCkBAIC0yNCwxMCArMjQsOSBAQAogCiAjaW5jbHVk
ZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFkZW9uX2FzaWMuaCIKKyNpbmNsdWRlICJyNjAwLmgi
CiAjaW5jbHVkZSAicjYwMGQuaCIKIAotdTMyIHI2MDBfZ3B1X2NoZWNrX3NvZnRfcmVzZXQoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotCiAvKgogICogRE1BCiAgKiBTdGFydGluZyB3aXRo
IFI2MDAsIHRoZSBHUFUgaGFzIGFuIGFzeW5jaHJvbm91cwotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
