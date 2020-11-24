Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C77C8300B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D3620872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDVEve22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D3620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D306E91E;
	Wed, 25 Nov 2020 08:23:06 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4866E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:41 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id e7so6013597wrv.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ea+MZ4SETfT4WFr3DgwI9kjy4D+XbqEDvpGgUqZKcMo=;
 b=HDVEve22PQjQLPJNjH06mAipBi1w1c7FoGv7APARQFJEB8Lr7iNE1bZmbMz/vKKHML
 MQbRNDETI8MJrbuDGnUlheO5oFIYvZhdgDkHAWeSfRGV1g30bzYvMQC0uEsTFezPno+9
 UfEdVjcFhZTiVurEuXLqw5ZwLN5D4ZJ7ZS3kLSvAEnWM2zOsNvbeT9xnwv53Fi3X9pHC
 a7tn66AwHqo1Sj+a3BtoVJKB/w0noZKMEJQGi2O4xjUktRfbFIY/yWoLkJgvzDOnwNsz
 WfchD4urO01qtQaCsZzEiMMD1eTjxmLWUBlzX04sdihIgMKaIKJu5vEY/dxR3jXH12Hf
 yHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ea+MZ4SETfT4WFr3DgwI9kjy4D+XbqEDvpGgUqZKcMo=;
 b=MTfRe/qhJcuv9SUy5/4EKxRODtMTphEa90ec9Vh3YJIrTkCLL1I27Uf+Qfa+hQTYud
 qVD1Zad9D/wgl3AbGMpemuXplmwzrg4ggbDELKR8DQTYuIjyKqLuaJD6eH6FnOK2yQjA
 jDgzJAkgQ9+8f7V2Iwy+rVOK44ueeY4/ryVowJ7vVh23Uv1KDVx0cyPVg1XHwM2tIuAL
 HGHqbQiq3OPyVbTd3WEZvQHMgER5rWMblcNWSVefVt1xbpNt4rCXkuakIYeY6TFu0+2N
 3kxJJljdnM+slf/r2Ta6qiLuHIJqC9ryztVUI6J2TL4ZbNSOPwa0G/vy1domYwZwC1NI
 q27w==
X-Gm-Message-State: AOAM531OqF+Nciv6DAjNZp6Yw4lFm0kyjS1cRGMcsc2PzsnqPRejHFwF
 kAsGVkFmP7v/Sjx+NRH+9UN+wQ==
X-Google-Smtp-Source: ABdhPJzJscRsPSjrCdloGZX4iKtODDfMRSxXemQOx5ZBCJc8vyH6N4DZpRSGqUy0OS0ELBbGEslFew==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr66630wrh.205.1606247080372;
 Tue, 24 Nov 2020 11:44:40 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:39 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 33/40] drm/amd/amdgpu/vcn_v3_0: Remove unused variable
 'direct_poll' from 'vcn_v3_0_start_sriov()'
Date: Tue, 24 Nov 2020 19:38:17 +0000
Message-Id: <20201124193824.1118741-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYzogSW4gZnVuY3Rpb24g4oCYdmNuX3YzXzBf
c3RhcnRfc3Jpb3bigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jOjEy
NDI6Mzogd2FybmluZzogdmFyaWFibGUg4oCYZGlyZWN0X3BvbGzigJkgc2V0IGJ1dCBub3QgdXNl
ZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmll
bCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YzXzAuYyB8IDQgLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMKaW5kZXggYzVlMGE1MzFjYWJhZi4u
ZTA1YWY2OTY1MTcyMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCkBAIC0x
MjM4LDggKzEyMzgsNiBAQCBzdGF0aWMgaW50IHZjbl92M18wX3N0YXJ0X3NyaW92KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCQlkaXJlY3Rfd3QgPSB7IHswfSB9OwogCXN0cnVjdCBtbXNj
aF92M18wX2NtZF9kaXJlY3RfcmVhZF9tb2RpZnlfd3JpdGUKIAkJZGlyZWN0X3JkX21vZF93dCA9
IHsgezB9IH07Ci0Jc3RydWN0IG1tc2NoX3YzXzBfY21kX2RpcmVjdF9wb2xsaW5nCi0JCWRpcmVj
dF9wb2xsID0geyB7MH0gfTsKIAlzdHJ1Y3QgbW1zY2hfdjNfMF9jbWRfZW5kIGVuZCA9IHsgezB9
IH07CiAJc3RydWN0IG1tc2NoX3YzXzBfaW5pdF9oZWFkZXIgaGVhZGVyOwogCkBAIC0xMjQ3LDgg
KzEyNDUsNiBAQCBzdGF0aWMgaW50IHZjbl92M18wX3N0YXJ0X3NyaW92KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCQlNTVNDSF9DT01NQU5EX19ESVJFQ1RfUkVHX1dSSVRFOwogCWRpcmVj
dF9yZF9tb2Rfd3QuY21kX2hlYWRlci5jb21tYW5kX3R5cGUgPQogCQlNTVNDSF9DT01NQU5EX19E
SVJFQ1RfUkVHX1JFQURfTU9ESUZZX1dSSVRFOwotCWRpcmVjdF9wb2xsLmNtZF9oZWFkZXIuY29t
bWFuZF90eXBlID0KLQkJTU1TQ0hfQ09NTUFORF9fRElSRUNUX1JFR19QT0xMSU5HOwogCWVuZC5j
bWRfaGVhZGVyLmNvbW1hbmRfdHlwZSA9CiAJCU1NU0NIX0NPTU1BTkRfX0VORDsKIAotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
