Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593F7C55178
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCDA2087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYaXK275"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCDA2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F34F6EB22;
	Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3996EB26
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:08 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id h62so2646917wme.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Egmlgv9H3fW37Nl0/DO7Y7+0OQCWufEB+r7yIAqkua0=;
 b=eYaXK275kZ6tl5bZ2mLwFa4Hvd2EKmC0/VME8B9G/DISC2ffhyEptBOVG0KMjuNOLC
 XsEsCBmAoM7RHtAu3Qlc9CDxH+LWQ1uBALNxpw6HcSXEq0Pwu0m95yHxCdsAjrL12ceV
 KKvpLWrKJWTh5XU+PgrRW9YhQWWPAJMptrUEfAahqFedytbPfoYgCfYmvN5loU/6Lx/p
 jUyrunnT1AJH5g9RK08Qcpg1guaWrUBsccPIJSv44/qAOHunj6+eiN42lzj/+reg9vaX
 FXAGldEVoHjpHPVRlk78/1fsZaFkU/N2gn3wWzFRiBhdyL1xxlo9jkwAjDu4MIG2RFV2
 2N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Egmlgv9H3fW37Nl0/DO7Y7+0OQCWufEB+r7yIAqkua0=;
 b=RBNlujoPfpIz2jimHv9ALfn5/jhkakgA/e/EKx9rpYc4JwWgKBX0F0DbhkrfXeeNa9
 0SVHmj3ixbKpd95zutGklyDyKYNcg8gSoSyNkkkvV/DOYIPWGi8147XxjDMrZcnYQ0mE
 4UMicmBbB2AG7atzdDvO15/WpPd7Aw3+qZuzcar8mWxV7hBZ2bpxriWIZm2LlKbMe3Dl
 5Fl5Rav5FdCJLxX+lx9RmQeVao7MRS6xkEQmWlU7XlE0nOmcQaVBkU56sFLeLi6p8XCw
 Qoxzc+IIpKq6C8XpVYCbbjuY36idigT+8kPho5ccVLqtAhIE5aFmN3ucThPUE0lsWWA3
 EzOQ==
X-Gm-Message-State: AOAM533fsVDQZzLV/kF/ZZCqiIAY4OZtqrt/WgBuWJIGsR2a325+NNQx
 R4ScrcS1PO+3IStEZ5ffCoZ/1Q==
X-Google-Smtp-Source: ABdhPJy2bIjiZLuZODIqlT1CvO+CLjkrEG+vzynMbmZJqKxhgkUCFDhXVQmJzX4wCSLbFC2K6m9Glg==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr1515842wmb.141.1604699407208; 
 Fri, 06 Nov 2020 13:50:07 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:06 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/19] drm/radeon/radeon_drv: Source file headers are not good
 candidates for kernel-doc
Date: Fri,  6 Nov 2020 21:49:41 +0000
Message-Id: <20201106214949.2042120-12-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmM6Mjogd2FybmluZzogQ2Fubm90IHVuZGVyc3Rh
bmQgICogZmlsZSByYWRlb25fZHJ2LmMKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEdhcmV0aCBIdWdoZXMgPGdhcmV0aEB2YWxpbnV4LmNv
bT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2Rydi5jCmluZGV4IDU2MDI2N2NjMjU4OTIuLmJiN2IzM2U1MzVmODEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCkBAIC0xLDQgKzEsNCBAQAotLyoqCisvKgog
ICogXGZpbGUgcmFkZW9uX2Rydi5jCiAgKiBBVEkgUmFkZW9uIGRyaXZlcgogICoKLS0gCjIuMjUu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
