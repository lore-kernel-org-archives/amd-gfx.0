Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696ACC61DD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212EF20715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbhv4k28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212EF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876F96E5A5;
	Fri, 13 Nov 2020 14:28:21 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E8E6E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:29 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id u12so2765039wrt.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYNTgRMVpRNL/FiK5ZAGdhQROE1FVRdCXLrN0ldkq14=;
 b=xbhv4k28x+rz7JYkl2nx+QIT1GO56rWtWgOVjpknc5Ye22Krl6lwzpW/2pOF1sCTy9
 2qJdTAnkUlFwEnmBo4XLt7h5rcQSg9vIHupq1v00bkPrICVU2Nr0U0BUPPaLocEBpsQ+
 4nJJonTvzNCGOCheLsfA5+uAxLmCTzjye3iipYGSA+dpTipVS2MBA3TbYfBnAYXuuiFb
 pvcq/v7eAhIXepTQQf+HvsBULlp1ndJZxlNDzogMtJ53kGXnKUTAWbOBLYHD+k7lbsPd
 m8NDRWDuvyKir3o6os4/s+FRDX3Zo5vPJeT9AFmJbroj6Km9vFfc3gxcMjvhND8EDXCl
 23tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYNTgRMVpRNL/FiK5ZAGdhQROE1FVRdCXLrN0ldkq14=;
 b=UzW/cSeXpC/1s5Q+Qbzdqy9XFgqFtu1jL+onPEuf997x2qCUdX0R3kjUeOfKQRTUw6
 Axoap6jKAXxMscHGtm4DGmiPCWwWoMGEN7+iQk89k5Z18IIeuight2CRa09bRXsyIaGA
 JGXPTsujQBSJRJdt9lHAIHmUJKNrw0H2Kj58Ldiq/i3RY/6NmDVSuKbjZzDf91dOdbZ9
 lX+YXag/qS1/dvym0FiDf7k+v4x/1mk5K2ebc7I5wW7k+RjF3benxKFGWBlXmcF3kV3/
 b84P1QEXCdF8BRooE8nWICQQgtXygvTlC1jWUZQvMrLp2ShWegFUd22lcjv5bjfnQb2+
 NtRw==
X-Gm-Message-State: AOAM533rJ3Vb6LlqfWkLKx3NIuCr2caEoglzl+d7f4xTTNhSxTJyz+zk
 aFeDSMVppTyCB/cvxBlE48eMUg==
X-Google-Smtp-Source: ABdhPJxGg8xVfkoLyRKc98fsfddvDgvzg2WvnhfQ31H4T81wJBlY94sbHLHZQmkIg0Ktxg25JJV+9A==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr3532493wrw.176.1605275427821; 
 Fri, 13 Nov 2020 05:50:27 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:27 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 37/40] drm/amd/amdgpu/smu_v11_0_i2c: Provide descriptions for
 'control' and 'data' params
Date: Fri, 13 Nov 2020 13:49:35 +0000
Message-Id: <20201113134938.4004947-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2kyYy5jOjIyNTogd2FybmluZzogRnVuY3Rp
b24gcGFyYW1ldGVyIG9yIG1lbWJlciAnY29udHJvbCcgbm90IGRlc2NyaWJlZCBpbiAnc211X3Yx
MV8wX2kyY190cmFuc21pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9p
MmMuYzozMjU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2NvbnRyb2wn
IG5vdCBkZXNjcmliZWQgaW4gJ3NtdV92MTFfMF9pMmNfcmVjZWl2ZScKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMuYzozMjU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ2RhdGEnIG5vdCBkZXNjcmliZWQgaW4gJ3NtdV92MTFfMF9pMmNfcmVj
ZWl2ZScKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAi
Q2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFp
cmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2kyYy5jIHwg
MyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVfdjExXzBfaTJjLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zbXVfdjExXzBfaTJjLmMKaW5kZXggN2ZiMjQwYzQ5OTBjYS4uNWM3ZDc2OWFl
ZTNmYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2ky
Yy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMuYwpAQCAt
MjEyLDYgKzIxMiw3IEBAIHN0YXRpYyB1aW50MzJfdCBzbXVfdjExXzBfaTJjX3BvbGxfcnhfc3Rh
dHVzKHN0cnVjdCBpMmNfYWRhcHRlciAqY29udHJvbCkKIC8qKgogICogc211X3YxMV8wX2kyY190
cmFuc21pdCAtIFNlbmQgYSBibG9jayBvZiBkYXRhIG92ZXIgdGhlIEkyQyBidXMgdG8gYSBzbGF2
ZSBkZXZpY2UuCiAgKgorICogQGNvbnRyb2w6IEkyQyBhZGFwdGVyIHJlZmVyZW5jZQogICogQGFk
ZHJlc3M6IFRoZSBJMkMgYWRkcmVzcyBvZiB0aGUgc2xhdmUgZGV2aWNlLgogICogQGRhdGE6IFRo
ZSBkYXRhIHRvIHRyYW5zbWl0IG92ZXIgdGhlIGJ1cy4KICAqIEBudW1ieXRlczogVGhlIGFtb3Vu
dCBvZiBkYXRhIHRvIHRyYW5zbWl0LgpAQCAtMzEzLDcgKzMxNCw5IEBAIHN0YXRpYyB1aW50MzJf
dCBzbXVfdjExXzBfaTJjX3RyYW5zbWl0KHN0cnVjdCBpMmNfYWRhcHRlciAqY29udHJvbCwKIC8q
KgogICogc211X3YxMV8wX2kyY19yZWNlaXZlIC0gUmVjZWl2ZSBhIGJsb2NrIG9mIGRhdGEgb3Zl
ciB0aGUgSTJDIGJ1cyBmcm9tIGEgc2xhdmUgZGV2aWNlLgogICoKKyAqIEBjb250cm9sOiBJMkMg
YWRhcHRlciByZWZlcmVuY2UKICAqIEBhZGRyZXNzOiBUaGUgSTJDIGFkZHJlc3Mgb2YgdGhlIHNs
YXZlIGRldmljZS4KKyAqIEBkYXRhOiBQbGFjZWhvbGRlciB0byBzdG9yZSByZWNlaXZlZCBkYXRh
LgogICogQG51bWJ5dGVzOiBUaGUgYW1vdW50IG9mIGRhdGEgdG8gdHJhbnNtaXQuCiAgKiBAaTJj
X2ZsYWc6IEZsYWdzIGZvciB0cmFuc21pc3Npb24KICAqCi0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
