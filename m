Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0990EC55178
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2C020882
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCGvUbcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2C020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F2C6EB43;
	Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29226EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:13 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id n15so2791846wrq.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XN+cgxXjY3IWekASuJPYqV0dOA81c47vUDG0BBQb6c0=;
 b=HCGvUbcx5ZEN2tfKGwHJicVvv+pm5x43BHYd0mWRsxxz1IOqVirgnGczw7oawgtQXB
 7UygpB7ndYtvwbAuuhuaC6Qb2sfQK60p1OUOxbmCjKhcxzjmmm4TTDd1LFZtaWUZIudH
 GCsTzPE/zuBUGTLoiaFz52M0clHGNBXnsdLFW2mOxaO0RaV/pUYsX07zEX7Z0XNI/n1q
 AgU2ChqZX7giA7oo56qtWu8HkTrMDdt2oxJk+AYpkaHiYP0Ns4cEFV9WglGGP6sGMmVL
 FmVkjlPKqeawp62wfvotAn2I65hfXYwautS3PIWf0NqQV4Ei7ry86OU7eRNamQLgA1q1
 3crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XN+cgxXjY3IWekASuJPYqV0dOA81c47vUDG0BBQb6c0=;
 b=soILuIVjOpOSlDqXsErf7mlLeHkSaRKcG5voyQ7Zvc30BGZk0W5H0peKirm94/7v4Q
 FvLCEbqV5i19XTODiovxRcK7+LIYDo6Ts7epggvzFFZteLHG5hNQT4aCqcFNDNJQ0ehe
 QlaR3xCZ9rRGNrMIRKhfWQEchh83caFbCucDAXxHd9BmwdYQWUzdaSXCJQZyOCjK7Ncz
 8siUTLX6BSRkl3crmgcRIAMpDVUbYddAFHRq3W3u60auTaj8lvh28mZiBq1Ezv0TVQlb
 vCNjtdEDoH7W/uIlcqVB8bfCvApz7eKYb+cXMQmugDg2lNY4dMaY0ZygSOe52HSdkpG4
 Dkyg==
X-Gm-Message-State: AOAM532KEulwthkci2jFou8fZndJ9bSHl8VFqAoivRZZSB2XbfGsvoCE
 ZkV9sa15t1XhvfEH90BcsslsVA==
X-Google-Smtp-Source: ABdhPJz9VXDl2U52UY4eXa5169UHGNjCTgPviCAyaRgtL3TzMxHGPQw76W+ApIl3BeVptCZSq2myUQ==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr4927117wrp.426.1604699412401; 
 Fri, 06 Nov 2020 13:50:12 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:11 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/19] drm/radeon: Move prototypes to shared header
Date: Fri,  6 Nov 2020 21:49:45 +0000
Message-Id: <20201106214949.2042120-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
dS9kcm0vcmFkZW9uL3JhZGVvbi5oICAgICAgICAgfCA2ICsrKysrKwogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIHwgNCAtLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbi5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaAppbmRleCBl
MTEzMmQ4NmQyNTA3Li45NjFhMzFiODgwNWMyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKQEAg
LTI4MzIsNiArMjgzMiwxMiBAQCBleHRlcm4gdm9pZCByYWRlb25fcHJvZ3JhbV9yZWdpc3Rlcl9z
ZXF1ZW5jZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKIAkJCQkJICAgICBjb25zdCB1MzIg
YXJyYXlfc2l6ZSk7CiBzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmFkZW9uX2dldF9yZGV2KHN0cnVj
dCB0dG1fYm9fZGV2aWNlICpiZGV2KTsKIAorLyogS01TICovCisKK3UzMiByYWRlb25fZ2V0X3Zi
bGFua19jb3VudGVyX2ttcyhzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOworaW50IHJhZGVvbl9lbmFi
bGVfdmJsYW5rX2ttcyhzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOwordm9pZCByYWRlb25fZGlzYWJs
ZV92Ymxhbmtfa21zKHN0cnVjdCBkcm1fY3J0YyAqY3J0Yyk7CisKIC8qCiAgKiB2bQogICovCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKaW5kZXggYjc5Njg2Y2Y4YmRiZC4u
YmQ2MGYxNmZkMGQ3OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
ZGlzcGxheS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYwpA
QCAtNDUsMTAgKzQ1LDYgQEAKICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVkZSAicmFkZW9uLmgi
CiAKLXUzMiByYWRlb25fZ2V0X3ZibGFua19jb3VudGVyX2ttcyhzdHJ1Y3QgZHJtX2NydGMgKmNy
dGMpOwotaW50IHJhZGVvbl9lbmFibGVfdmJsYW5rX2ttcyhzdHJ1Y3QgZHJtX2NydGMgKmNydGMp
Owotdm9pZCByYWRlb25fZGlzYWJsZV92Ymxhbmtfa21zKHN0cnVjdCBkcm1fY3J0YyAqY3J0Yyk7
Ci0KIHN0YXRpYyB2b2lkIGF2aXZvX2NydGNfbG9hZF9sdXQoc3RydWN0IGRybV9jcnRjICpjcnRj
KQogewogCXN0cnVjdCByYWRlb25fY3J0YyAqcmFkZW9uX2NydGMgPSB0b19yYWRlb25fY3J0Yyhj
cnRjKTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
