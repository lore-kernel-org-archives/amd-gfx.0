Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E2C64E7A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380B62225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2Zvmw9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380B62225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492366E0D4;
	Mon, 16 Nov 2020 19:18:44 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3706E07B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:38 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id 23so19607085wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6eWjxCy1b/Di1KDbBj5VEEMSjXTSXChj8189ArvQtHE=;
 b=R2Zvmw9KS2p/uW92MEVvMAZHk/cC36qiZDKxllEIdVedCqMaJxEhSpmCl8uEzkgxvs
 ziSwIPTt2zvHY39MLFUPlML1cC0Y4JOoKx3lqQ8apPiW9uNx0p0hyqKCg3mdkC1uGZpo
 9QZLpveawM4J2EiSh9h4Ky7yUMPlTMDW6etAsDjbjhYc6A4T792sIprRsqKM6TO+Cuia
 qRZodDurakwR/Sa0L1NztR38xENLghD8JYA7jLO9eYyDMWoNeqNc8F8voGZxgUOBAoiG
 PVYJw/2UeoXSIhRt0aiFE/6FKhjqwCslGMIL6Nvym5qzUA0y6W2dVcXzM/1fuh4TKJik
 2ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6eWjxCy1b/Di1KDbBj5VEEMSjXTSXChj8189ArvQtHE=;
 b=fyPglUF2/RZZF8b8TZVaZ7nN+4BfeIb0X/KPnhc6ydV2BCpsYvwKAvBjLVkQmrv8yb
 YDBZZQqGv+CyR48+/yLsbNDQ7SDDomnPttmX6mQUW3ZxHW/rboEC5Ysk9GbDNB7zO3M8
 Whu2AFVmg5GB2UcnLFq2VEV0Q8CuOGgl9RrDc1tYI4IwzJOtA/kSJklIENMxGkBPIsCJ
 dbHN1DKXecmZQ3VjhmzWvsoa7PhA3oGSXRnO6XAAW0lBJA1t8kBQqgF03lF+ekaWgr22
 1GHubXeWr3OGkQC7KVSgvIk452vccYShPQ/NvM3VIwIhiqjYsn8S3mXR+OF4FWtVvVxP
 jtmQ==
X-Gm-Message-State: AOAM5326wOEyF+nOjx9rGkDrwhXn2IFyzF141PY0R6SOZA1QDnuIGK+s
 JjDZo5g4sBs1c4QVxgbUG6OuEA==
X-Google-Smtp-Source: ABdhPJxROO5b9lILZ+JniBmhfb3OcM1XvkCvRfpWKPHTjgz7WGw0zIZm4kKfPGYNo/liMWytt2yiCQ==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr20117581wrq.236.1605548257084; 
 Mon, 16 Nov 2020 09:37:37 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:36 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 23/43] drm/radeon/evergreen_dma: Move
 'evergreen_gpu_check_soft_reset()'s prototype to shared header
Date: Mon, 16 Nov 2020 17:36:40 +0000
Message-Id: <20201116173700.1830487-24-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYzozODI1OjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYZXZlcmdyZWVuX2dwdV9jaGVja19zb2Z0X3Jlc2V04oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KIDM4MjUgfCB1MzIgZXZlcmdyZWVuX2dwdV9jaGVja19zb2Z0X3Jl
c2V0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uaCAgICAgfCAx
ICsKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2RtYS5jIHwgMyArLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2V2ZXJncmVlbi5oCmluZGV4IDMwYzljYTk5Y2VkOTAuLmViNDZhYzc3NzY5NTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmgKKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uaApAQCAtNDcsNSArNDcsNiBAQCBpbnQgc3Vtb19ybGNf
aW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB2b2lkIGV2ZXJncmVlbl9ncHVfcGNp
X2NvbmZpZ19yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB1MzIgZXZlcmdyZWVu
X2dldF9udW1iZXJfb2ZfZHJhbV9jaGFubmVscyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
CiB2b2lkIGV2ZXJncmVlbl9wcmludF9ncHVfc3RhdHVzX3JlZ3Moc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpOwordTMyIGV2ZXJncmVlbl9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldik7CiAKICNlbmRpZgkJCQkvKiBfX1JBREVPTl9FVkVSR1JFRU5fSF9f
ICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9kbWEuYyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2RtYS5jCmluZGV4IDc2Nzg1N2Q0YThj
NWMuLjUyYzc5ZGExZWNmNTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZl
cmdyZWVuX2RtYS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2RtYS5j
CkBAIC0yNCwxMCArMjQsOSBAQAogCiAjaW5jbHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFk
ZW9uX2FzaWMuaCIKKyNpbmNsdWRlICJldmVyZ3JlZW4uaCIKICNpbmNsdWRlICJldmVyZ3JlZW5k
LmgiCiAKLXUzMiBldmVyZ3JlZW5fZ3B1X2NoZWNrX3NvZnRfcmVzZXQoc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYpOwotCiAvKioKICAqIGV2ZXJncmVlbl9kbWFfZmVuY2VfcmluZ19lbWl0IC0g
ZW1pdCBhIGZlbmNlIG9uIHRoZSBETUEgcmluZwogICoKLS0gCjIuMjUuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
