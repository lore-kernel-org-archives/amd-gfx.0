Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980BC64E7C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A38B20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzDylEEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A38B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940916EC09;
	Fri, 27 Nov 2020 10:15:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829006E96C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:38 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 23so2190408wrc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y2L4ju+uZ20D0/2E1suojqs76azBxprDmuerWKuUkXg=;
 b=FzDylEEID+ChIWfzEFmWZz2uTH3H493rVHv8wAvc/cf9fkvCuUjCYRsUuc0NZXnjf1
 RKC6y9MRt2HtbaXRd/+MWYzK3N9y1OvjOlg09FC4aGlO7LmuK5ZixylQLIKi9ABmiFAo
 hxbj4w7/JM80JHphzbW5XttO40XyJrkWmTUouAZskGFh9ZE8MPiRS2TN49jrHkQZx6hZ
 Aj25a2l0d3gBcvRIXwPGQzYr1D559lBW3CGtJNZHzHYeW9lMFGYoPiaggT+FfcVDLXNu
 mZnqjJF1Rj3ZrfBjjJAt8qSov1+FvRd4MW2OiLuZ0SRwmY5hra7HcnjZIiR9Ez4Gc2pf
 QU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y2L4ju+uZ20D0/2E1suojqs76azBxprDmuerWKuUkXg=;
 b=TF2dC/8g3yKJdG07gCba4intM1brcBY5t93p/vhRlhRisAnOtcXkTLcman0SQ4FnZj
 3t8sUioccP3kU2DS+PuyK2menuKqQgzsXMbh0XWFRZZMSdqcZAGU7E3yy+5W3RFIFqby
 +vk4F+qXDKWAiKC4WpMvBEttcZn82FbSLv6LbjPYeQRyTa4tL6lgXOhJN9HKkjmDX5fo
 gX2Auwklpyt9uVWuZPtj2sU7Zhf4H8F/IBUweUNMqv1tLYDACt1waGmI3BOxn/ppUStX
 vuQ5xLQ+VM0qcr2ENI4HM8RZI4OUE9dejw3arumckCCoWHQZg08lgFgny0vVZT5S3QbV
 r0Rw==
X-Gm-Message-State: AOAM530lcsN5sIDkcHJ+cNDoRmLtzY4HnEHd+kaw5BO4DTB+hchdY5CY
 OB3DGi9zJ13GswLJ79CJ6+wpfQ==
X-Google-Smtp-Source: ABdhPJxfGQggZwM6noRk+tdnupoa9wCcjIPp3cRIt3Lxi9cHuFJWCdN0QQSBGG4Qw8BvZOr+tcmuvA==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr4041256wrn.124.1606398217128; 
 Thu, 26 Nov 2020 05:43:37 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:36 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 35/40] drm/amd/display/amdgpu_dm/amdgpu_dm_color: Demote a
 misuse and fix another kernel-doc header
Date: Thu, 26 Nov 2020 13:42:35 +0000
Message-Id: <20201126134240.3214176-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2NvbG9y
LmM6MTI4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdsdXQnIG5vdCBk
ZXNjcmliZWQgaW4gJ19fZHJtX2x1dF90b19kY19nYW1tYScKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9jb2xvci5jOjEyODogd2Fybmlu
ZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZ2FtbWEnIG5vdCBkZXNjcmliZWQgaW4g
J19fZHJtX2x1dF90b19kY19nYW1tYScKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9jb2xvci5jOjEyODogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnaXNfbGVnYWN5JyBub3QgZGVzY3JpYmVkIGluICdfX2RybV9s
dXRfdG9fZGNfZ2FtbWEnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fY29sb3IuYzo0MjY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ2RjX3BsYW5lX3N0YXRlJyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfZG1f
dXBkYXRlX3BsYW5lX2NvbG9yX21nbXQnCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9jb2xvci5jIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2Nv
bG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9j
b2xvci5jCmluZGV4IDVkZjA1ZjBkMThiYzkuLjE1N2ZlNGVmYmI1OTkgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2NvbG9yLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fY29sb3Iu
YwpAQCAtMTE5LDcgKzExOSw3IEBAIHN0YXRpYyBib29sIF9faXNfbHV0X2xpbmVhcihjb25zdCBz
dHJ1Y3QgZHJtX2NvbG9yX2x1dCAqbHV0LCB1aW50MzJfdCBzaXplKQogCXJldHVybiB0cnVlOwog
fQogCi0vKioKKy8qCiAgKiBDb252ZXJ0IHRoZSBkcm1fY29sb3JfbHV0IHRvIGRjX2dhbW1hLiBU
aGUgY29udmVyc2lvbiBkZXBlbmRzIG9uIHRoZSBzaXplCiAgKiBvZiB0aGUgbHV0IC0gd2hldGhl
ciBvciBub3QgaXQncyBsZWdhY3kuCiAgKi8KQEAgLTQxMyw3ICs0MTMsNyBAQCBpbnQgYW1kZ3B1
X2RtX3VwZGF0ZV9jcnRjX2NvbG9yX21nbXQoc3RydWN0IGRtX2NydGNfc3RhdGUgKmNydGMpCiAv
KioKICAqIGFtZGdwdV9kbV91cGRhdGVfcGxhbmVfY29sb3JfbWdtdDogTWFwcyBEUk0gY29sb3Ig
bWFuYWdlbWVudCB0byBEQyBwbGFuZS4KICAqIEBjcnRjOiBhbWRncHVfZG0gY3J0YyBzdGF0ZQot
ICogQCBkY19wbGFuZV9zdGF0ZTogdGFyZ2V0IERDIHN1cmZhY2UKKyAqIEBkY19wbGFuZV9zdGF0
ZTogdGFyZ2V0IERDIHN1cmZhY2UKICAqCiAgKiBVcGRhdGUgdGhlIHVuZGVybHlpbmcgZGNfc3Ry
ZWFtX3N0YXRlJ3MgaW5wdXQgdHJhbnNmZXIgZnVuY3Rpb24gKElURikgaW4KICAqIHByZXBhcmF0
aW9uIGZvciBoYXJkd2FyZSBjb21taXQuIFRoZSB0cmFuc2ZlciBmdW5jdGlvbiB1c2VkIGRlcGVu
ZHMgb24KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
