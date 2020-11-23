Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B98C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B6420702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2K/cwXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B6420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67DE89E8C;
	Mon, 23 Nov 2020 13:58:02 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAAD89D5F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:11 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id m6so18185575wrg.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=++Vz68Fmu1On4IoEFcmE3A4sGOg19/cMuiuu88qyFq4=;
 b=q2K/cwXYQSgDLZTSTd16fYGp8epOrbJawkVeEFI3/Pfsv/JGDv5qaPXYej0iOxd2ph
 48gor7LDZtGHEP5ggv34K4U71CCZv9PNpVNhUskTNwtJpMYERc9plx2o33yuqougCGaK
 yh+M9Fe4ynTg2rknsoZZeLyM8Li+5AUSRduvQKHd/942b6drv28cCsPj6Zau/rquxKGQ
 F+YRrQad5JTANuegzhgxb0GJ0o76zcEYQu+iUST9WB0x+lzVqqR3ZdSgZlreFanFYD2E
 Nh+s2voMHLrEHv9VGA3bJOwwKuePJECNJP1WSvjQ5MZDdOOehYGs7KqF4AdWw00B8RsW
 0rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=++Vz68Fmu1On4IoEFcmE3A4sGOg19/cMuiuu88qyFq4=;
 b=dmPq2jYapR0pVO9BiETiC4xzPTSauUxV/pujYU0KUjl71547GiJjNl0fa2M0Lyn75k
 U97jnJWq7CfmknkBsm1qCQ6KJxBst6w4B/lUp4afHoXgJp8DlAp7fOfUlOjm6KdMyWeW
 E4C6lpltDbnGHyf1FmOm4LXO/NwHbpPdtQMxgxZjqkgU3YqXLXBBThlsXx/naBHyGoL2
 NcwsY2RkVOFsWrxwk6pymZ8afMpGYo0BiwONd5qnyEloun6VsOEHm9IsJ94bedHWvBir
 xJ5tRn7GK8LjxCw5kmAHb8yczfrCES4wVUOOEOv94c4lJGpsj6lWanB+y/6KBQ5WlP33
 ms4A==
X-Gm-Message-State: AOAM530qMzAUKA8OCdl7Z6JFxVIqJDdlx2nTz3+NAtOoZHJr8mw6Y67m
 lqrU62ttMLsd4ssnbA595C5bug==
X-Google-Smtp-Source: ABdhPJw2M/yqWnzgMlKNV8eXvBuu+WRBtKXJ5jRrXE1nwLmznM70HcqS7e2cgfQC7oeumVBTkUrHgw==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr5885075wru.266.1606130410214; 
 Mon, 23 Nov 2020 03:20:10 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:09 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 34/40] drm/amd/amdgpu/uvd_v4_2: Add one and remove another
 function param description
Date: Mon, 23 Nov 2020 11:19:13 +0000
Message-Id: <20201123111919.233376-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYzo0NDg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2ZsYWdzJyBub3QgZGVzY3JpYmVkIGluICd1dmRfdjRfMl9yaW5n
X2VtaXRfZmVuY2UnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jOjQ0ODog
d2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZmVuY2UnIGRlc2NyaXB0aW9uIGlu
ICd1dmRfdjRfMl9yaW5nX2VtaXRfZmVuY2UnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3V2ZF92NF8yLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djRfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYwppbmRleCAyYzhj
MzVjM2JjYTUyLi5iZjNkMWM2MzczOWI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS91dmRfdjRfMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92
NF8yLmMKQEAgLTQzOSw3ICs0MzksNyBAQCBzdGF0aWMgdm9pZCB1dmRfdjRfMl9zdG9wKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogICogQHJpbmc6IGFtZGdwdV9yaW5nIHBvaW50ZXIKICAq
IEBhZGRyOiBhZGRyZXNzCiAgKiBAc2VxOiBzZXF1ZW5jZSBudW1iZXIKLSAqIEBmZW5jZTogZmVu
Y2UgdG8gZW1pdAorICogQGZsYWdzOiBmZW5jZSByZWxhdGVkIGZsYWdzCiAgKgogICogV3JpdGUg
YSBmZW5jZSBhbmQgYSB0cmFwIGNvbW1hbmQgdG8gdGhlIHJpbmcuCiAgKi8KLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
