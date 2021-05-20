Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E456C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089B461163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089B461163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12788986D;
	Thu, 20 May 2021 12:49:10 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 376F2892BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:40 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id d11so17360880wrw.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bMsBteM78sLZWfgoifTN7rbSr2W6UwGZKOyU98K9lCk=;
 b=xSRTCGcu0REc2dYZptHzRuhKcPm1H9u122v4lhRKXyyiFVkdAZ9ovsqzg0hnRDraB9
 EWpa1FP+mB8V74m/438XjQgRMh12C4wJDZOXXAyT95kTzjJcjjif1wZD2jhNcCdRTjhd
 tF7R/BcntVQUtUCaVo7NC0MbSwRBSKMWSh7YpUvC5JFpxLIbSbu94EIDF02NiLluUZ0a
 VHh+ojVGIH3DrkTiXBQaXbcwkbxwqPsGadxZ0qLQaM516IeuW6uqAMLkog+qKJBgk2an
 SfBbPaIr/eVlm9KBGjm5w6y7cZqfj/57En6BsfmOg0Vs8wdAxkgGLL3RZx5JkD93NL1w
 Ww1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bMsBteM78sLZWfgoifTN7rbSr2W6UwGZKOyU98K9lCk=;
 b=unLtS8gSUJbjfdha/X536ash1GZjw3sDm8D8RXS8ku0vxPfdHqV1PeQl3/w4fOqfbs
 2A4YP5t3hT9bcMnOztNCL5de0LR8Lu+LnX3CBZ9necXcKqUGbBLya82mfxI/se2ooRLl
 KI2JE6jYp7vyq1tUaOOordIfWWDkhpGiMxeK9Jvq3Cs3QtQY0XXKOIJQSN+04f+UHxWA
 bZKQ+N3C8t9oTAp4MjL2wUvlKuLfAKMeLJBgkbLgC/ztWr7lUXK/8kl8XhFtzyKsqcx1
 CFDdqVxzd3skbc19PtBMcBMW0MHdjkbo19jixP8kKZD8pkIPNl2xGKj5P6ADK04Gfvo+
 ykzg==
X-Gm-Message-State: AOAM532Frca4mNZWple0odcCye/Ue4dQkJPTrs88eBnlaySQ3FBH/Fdb
 rkTnfflquHynkCkg9YFcASnXhw==
X-Google-Smtp-Source: ABdhPJwyGDhnqi/8RHVMK2lWOHVz5VhQxaBzjq2jtP5sUVYHgFuD5cjW3Am5cCQ6JmYxEbj+vwnwHA==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4011768wrq.2.1621512218851;
 Thu, 20 May 2021 05:03:38 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:38 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 36/38] drm/amd/amdgpu/vcn_v1_0: Fix some function naming
 disparity
Date: Thu, 20 May 2021 13:02:46 +0100
Message-Id: <20210520120248.3464013-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYzo3NzU6IHdhcm5pbmc6IGV4cGVjdGluZyBw
cm90b3R5cGUgZm9yIHZjbl92MV8wX3N0YXJ0KCkuIFByb3RvdHlwZSB3YXMgZm9yIHZjbl92MV8w
X3N0YXJ0X3NwZ19tb2RlKCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3YxXzAuYzoxMTExOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciB2Y25fdjFfMF9z
dG9wKCkuIFByb3RvdHlwZSB3YXMgZm9yIHZjbl92MV8wX3N0b3Bfc3BnX21vZGUoKSBpbnN0ZWFk
CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgfCA0ICsrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKaW5kZXggMGMxYmVlZmEzZTQ5OC4uMmM5YWYxODY4M2Zl
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCkBAIC03NjUsNyArNzY1LDcg
QEAgc3RhdGljIHZvaWQgdmNuXzFfMF9lbmFibGVfc3RhdGljX3Bvd2VyX2dhdGluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIH0KIAogLyoqCi0gKiB2Y25fdjFfMF9zdGFydCAtIHN0YXJ0
IFZDTiBibG9jaworICogdmNuX3YxXzBfc3RhcnRfc3BnX21vZGUgLSBzdGFydCBWQ04gYmxvY2sK
ICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKgpAQCAtMTEwMSw3ICsxMTAx
LDcgQEAgc3RhdGljIGludCB2Y25fdjFfMF9zdGFydChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIH0KIAogLyoqCi0gKiB2Y25fdjFfMF9zdG9wIC0gc3RvcCBWQ04gYmxvY2sKKyAqIHZjbl92
MV8wX3N0b3Bfc3BnX21vZGUgLSBzdG9wIFZDTiBibG9jawogICoKICAqIEBhZGV2OiBhbWRncHVf
ZGV2aWNlIHBvaW50ZXIKICAqCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
