Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5494C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A2B20882
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTrg6Tx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A2B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4E96EB29;
	Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7B06EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:12 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y12so2796918wrp.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/vzXOfe3LQJ1tPjw4mGTlBd2Hha/B9WB2NE4h+LPHsM=;
 b=CTrg6Tx6WbaAEcip1oP69BTNYGApk3DcwyCdUIuDQ2NDdnRBvWJ1vAX/ZU360Uj2H3
 z2RJwZ1+S16zy979ZmaON1OE5ShHP9tn4UZpPgSmyA/uBIfj1vjmH+jWAjbfh3kcAI+N
 vT9asDh4Mu/wxBCF1XvL2esu1JYbTTLz+JNFFGMzs0UJu4zl3JLxby5TvA9gZghh1n8E
 xgYZIZKANmxc4y1D04xef/nQe3Mc/WsFTjsItHINOS2+gcjAGg4rCIRkTLtMqCjztxQv
 AImujyKOROsE+WUyTvErplm6dKHsfOgyEv5JJ1hSVPExxmbbHfSR6B+4fSicdViUancm
 iJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/vzXOfe3LQJ1tPjw4mGTlBd2Hha/B9WB2NE4h+LPHsM=;
 b=Ym9CUhm3a2xOERv/BuXLZg3aDPTgrbgXftPzsR6FKfRF1TPHKomBLRE3miUOlKa5hT
 I//gahiCk3SGsYb1myj8f29rtBaK5/yONIMJVYVcb7/2+DOVnrP7O0DfjdPjRE82A7xL
 54pQPloWDu7yOtdcl2xPb7atNKNsBjQuIN9pg+QSqBV/45DDPOvw/s1IafVzPGMM0FCz
 qxkFIQeeLuMU+xbnwt1Cdu0sGl4ydxQjFqQ0EX0qGG74nrSgXeSPbUYaeE1cJIz7gsnR
 BCkBy1nEfY+UCwbsbYJVPvQhtrefpWVuEkDh9G9qvwPYCAGFyVdNnZYxdwrSYrc3JxEp
 /AIA==
X-Gm-Message-State: AOAM531Wjw3egA3ijAEq8fpncYxzO1vpal+S9YYQ0gzTJZ8EF8YSnt3x
 +uGYgM/LVZXQT4NT7xY8JTEV3RttGDvdO59B
X-Google-Smtp-Source: ABdhPJxQroqDiuh4YZmo0CrJXSKpglFCwdy1Ztrmqj30qO0MXpAppEYJtzGiZ8+5YyyQWuEL8dUjvA==
X-Received: by 2002:adf:e551:: with SMTP id z17mr4904423wrm.374.1604699411021; 
 Fri, 06 Nov 2020 13:50:11 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:10 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/19] drm/amd/amdgpu/amdgpu_device: Provide documentation for
 'reg_addr' params
Date: Fri,  6 Nov 2020 21:49:44 +0000
Message-Id: <20201106214949.2042120-15-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jOjU5NDogd2FybmluZzogRnVuY3Rp
b24gcGFyYW1ldGVyIG9yIG1lbWJlciAncmVnX2FkZHInIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdw
dV9kZXZpY2VfaW5kaXJlY3RfcnJlZycKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYzo2MjQ6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3Jl
Z19hZGRyJyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfZGV2aWNlX2luZGlyZWN0X3JyZWc2NCcK
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6
IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
bGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFy
by5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICsrCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCmluZGV4IDMwMGZjYWRlNGEyYjEuLjYzMzc0ZDEyZTAwZmUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTU4NSw2ICs1ODUs
NyBAQCB2b2lkIGFtZGdwdV9tbV93ZG9vcmJlbGw2NChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgdTMyIGluZGV4LCB1NjQgdikKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAq
IEBwY2llX2luZGV4OiBtbWlvIHJlZ2lzdGVyIG9mZnNldAogICogQHBjaWVfZGF0YTogbW1pbyBy
ZWdpc3RlciBvZmZzZXQKKyAqIEByZWdfYWRkcjogaW5kaXJlY3QgcmVnaXN0ZXIgYWRkcmVzcyB0
byByZWFkIGZyb20KICAqCiAgKiBSZXR1cm5zIHRoZSB2YWx1ZSBvZiBpbmRpcmVjdCByZWdpc3Rl
ciBAcmVnX2FkZHIKICAqLwpAQCAtNjE1LDYgKzYxNiw3IEBAIHUzMiBhbWRncHVfZGV2aWNlX2lu
ZGlyZWN0X3JyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAgKiBAYWRldjogYW1kZ3B1
X2RldmljZSBwb2ludGVyCiAgKiBAcGNpZV9pbmRleDogbW1pbyByZWdpc3RlciBvZmZzZXQKICAq
IEBwY2llX2RhdGE6IG1taW8gcmVnaXN0ZXIgb2Zmc2V0CisgKiBAcmVnX2FkZHI6IGluZGlyZWN0
IHJlZ2lzdGVyIGFkZHJlc3MgdG8gcmVhZCBmcm9tCiAgKgogICogUmV0dXJucyB0aGUgdmFsdWUg
b2YgaW5kaXJlY3QgcmVnaXN0ZXIgQHJlZ19hZGRyCiAgKi8KLS0gCjIuMjUuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
