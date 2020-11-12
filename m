Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A36C55ABD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D40D20825
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKv9Y9oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D40D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CC86E417;
	Thu, 12 Nov 2020 19:56:07 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D7F6E3DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:01:45 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 10so6195271wml.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xZd7d6xqls8jDl+M8ybA/csJQ/XOet7ACTV4JHLbfR4=;
 b=JKv9Y9oU0JhE2143HXtvB0mFtf5ERN77Q+DLf+PeSGB5sCN2dC7AZILVbxIh31xHSc
 8k1pm/1KJOEo3/ArxZJ8DKvzExo09zMPG4iXTqFFGnj8nrSFCh7c7sq4z79vWFjaCUhF
 cu4fJW1K//nCA7e7k0RRLxi0M51e5DxMihSLptphtScOCeHe/hfDg4S0voMBktpD+0/i
 JZEIwYVDd4b7qpIp1CcSn8FE9VB/WPm1Sm4sIHFjeDyxvJKAuMC+KMKBxCwuGgwTwt+K
 hE4wStSmmI2U1HpMNaEeHCn09SRh/SW0rrv3fFBLfXRzIfDor1UtNowtcSPSrC1A1GO8
 Lplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xZd7d6xqls8jDl+M8ybA/csJQ/XOet7ACTV4JHLbfR4=;
 b=Q3s7jhFmswQJhsWQqKHJiRu6vHXILARDfbu8nw/93GVhqmVTUoUsIWZz33gf3rDYqC
 X3pKPl8fcGZUZNAUpDk3xTdL6asmzryQXysSeoYUTDJw6nUQMOv/WnVY7XibJg7tQf6k
 9hQHPYIUw+hJQgf8tvqTOM/g+slxA4MFer/x/mYmALPqrohVjRZBGzaZdrqIcpW945nT
 F7P7tsjNwktxNEyc1QTlKZ2rfPvCq3wpaszrBiFI00Bb1rsiBxgtwWJzw/2SSLbWwegm
 AlCsQG/NDiyQ/JXJpy4F5DdwUxb4NhZDkmQ1ofHC6eLeEBst41VAkwy5CLXR3JdGmRtb
 MpHg==
X-Gm-Message-State: AOAM530epXvC2Mp/KKnyWTh9feJoijL/TyEW93VR4wDo3JX/9iuUU22G
 0Pnd8eaJeggAjxxXm4Qs0M0aDt77IWeP9zPh
X-Google-Smtp-Source: ABdhPJxssIxVYH+hdM3iTUSfocLV+rScXqNtIh5LmjSZQBzffjCk/HPBo0B9+7pPvlDzmWHoFcUuMw==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr1084482wmg.155.1605207684974; 
 Thu, 12 Nov 2020 11:01:24 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 11:01:24 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/30] drm/amd/amdgpu/amdgpu_cs: Add a couple of missing
 function param descriptions
Date: Thu, 12 Nov 2020 19:00:28 +0000
Message-Id: <20201112190039.2785914-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Nov 2020 19:56:04 +0000
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
 linaro-mm-sig@lists.linaro.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmM6Njg1OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdiYWNrb2ZmJyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfY3Nf
cGFyc2VyX2ZpbmknCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYzoxNjU1
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdtYXAnIG5vdCBkZXNjcmli
ZWQgaW4gJ2FtZGdwdV9jc19maW5kX21hcHBpbmcnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdh
bEBsaW5hcm8ub3JnPgpDYzogSmVyb21lIEdsaXNzZSA8Z2xpc3NlQGZyZWVkZXNrdG9wLm9yZz4K
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1t
bS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5j
IHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMKaW5kZXggOGQyODc4ZTk1MGRhYi4uNTk0YTAxMDhlOTBmYSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKQEAgLTY3Niw2ICs2NzYsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9jc19zeW5jX3JpbmdzKHN0cnVjdCBhbWRncHVfY3NfcGFyc2Vy
ICpwKQogICogY3NfcGFyc2VyX2ZpbmkoKSAtIGNsZWFuIHBhcnNlciBzdGF0ZXMKICAqIEBwYXJz
ZXI6CXBhcnNlciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQuCiAgKiBAZXJyb3I6
CWVycm9yIG51bWJlcgorICogQGJhY2tvZmY6CWluZGljYXRvciB0byBiYWNrb2ZmIHRoZSByZXNl
cnZhdGlvbgogICoKICAqIElmIGVycm9yIGlzIHNldCB0aGFuIHVudmFsaWRhdGUgYnVmZmVyLCBv
dGhlcndpc2UganVzdCBmcmVlIG1lbW9yeQogICogdXNlZCBieSBwYXJzaW5nIGNvbnRleHQuCkBA
IC0xNjQ0LDYgKzE2NDUsNyBAQCBpbnQgYW1kZ3B1X2NzX3dhaXRfZmVuY2VzX2lvY3RsKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCiAgKiBAcGFyc2VyOiBjb21tYW5kIHN1Ym1p
c3Npb24gcGFyc2VyIGNvbnRleHQKICAqIEBhZGRyOiBWTSBhZGRyZXNzCiAgKiBAYm86IHJlc3Vs
dGluZyBCTyBvZiB0aGUgbWFwcGluZyBmb3VuZAorICogQG1hcDogUGxhY2Vob2xkZXIgdG8gcmV0
dXJuIGZvdW5kIEJPIG1hcHBpbmcKICAqCiAgKiBTZWFyY2ggdGhlIGJ1ZmZlciBvYmplY3RzIGlu
IHRoZSBjb21tYW5kIHN1Ym1pc3Npb24gY29udGV4dCBmb3IgYSBjZXJ0YWluCiAgKiB2aXJ0dWFs
IG1lbW9yeSBhZGRyZXNzLiBSZXR1cm5zIGFsbG9jYXRpb24gc3RydWN0dXJlIHdoZW4gZm91bmQs
IE5VTEwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
