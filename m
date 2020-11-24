Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D9C83014
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E4320B1F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdG+cicD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E4320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E8D6E99A;
	Wed, 25 Nov 2020 08:23:03 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F4F6E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:42 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so23531147wrg.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CKoWa37FzxxsWJDJ0MjgjJtMQHB06cJSx0w1D6sy2RI=;
 b=tdG+cicDEAw8D+/7A8LyoPxQlBhMODERMVzTZCPgy/dm9V6881vT914p6mw6lXskD5
 3ArdWa/noQjV+k4cQYkDPPD8/3gajo2kj0e2GNNtWDOVy2I7bG89rNmzHSU4ZtgoWU+q
 LnWmy27kyREHd/yLaic4WQeUwzBE7q9DRiMrsWgsdjDJDRtYj+Y7N2EbpALNPel9cQly
 2sv6/r2wFhrQMTcol2pmHaDSXwN848CyPzUC2OgzAmqXdXNJdGwCyP1Z6G4HNYheL54h
 a/lyERd/d3ymrIjCN7uGkTGg9s8qVnG//aYFyvz/eGIA9oug2tTU1S5AUQJJd4uvMqs7
 rJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CKoWa37FzxxsWJDJ0MjgjJtMQHB06cJSx0w1D6sy2RI=;
 b=Jvn0lSBQKPjr7x+EqqLKZ08ZuX+78dRNI19t7qqSw3XPggzsnOBwEEduegpGCeXFNa
 ofBk/ypXqU1mJHgZxt/R9ZUjzzgOd6HNrfYCD7Mrh/2EG+opb8tKs/QsKmj37wtRJHzI
 mOqjhGrEp9wXD9McKW0JLCBOaG/hXSaatl9XpWAY6Wtk8wm6Li2lk1DXkYFMOpOExjCZ
 HXr3Lz+WXNeyfaF4BcGwy33NLvUhfSYoCEYuJIWYvispMT8+VyhJbAc1CNBV4JETWxaP
 rQZf4wbOV/n9F1UZGI933+R//6YHNzDVyh6XZkrMiQYJl5GlBfN2dd696NLlm9UyERL2
 yJjQ==
X-Gm-Message-State: AOAM533/VzZd102yGwL+K2bII3MhKXaMOsn0zOxCsynxnhSIKdi7EwiJ
 BeE949ZAuuk1m0Xw8qtie08ivA==
X-Google-Smtp-Source: ABdhPJxEBa3RxG2cITK6ou296ZYyJhuQV6fQvAnP/c0MakF1oMc4IzcvdIwOvtz/0wRETKp74r+fPQ==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr62965wra.247.1606247081538;
 Tue, 24 Nov 2020 11:44:41 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 34/40] drm/amd/amdgpu/amdgpu_acp: Fix doc-rot issues
 pertaining to a couple of 'handle' params
Date: Tue, 24 Nov 2020 19:38:18 +0000
Message-Id: <20201124193824.1118741-35-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcC5jOjE4Mzogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnaGFuZGxlJyBub3QgZGVzY3JpYmVkIGluICdhY3BfaHdfaW5p
dCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3AuYzoxODM6IHdhcm5pbmc6
IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2FkZXYnIGRlc2NyaXB0aW9uIGluICdhY3BfaHdf
aW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3AuYzo0MTI6IHdhcm5p
bmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2hhbmRsZScgbm90IGRlc2NyaWJlZCBp
biAnYWNwX2h3X2ZpbmknCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmM6
NDEyOiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdhZGV2JyBkZXNjcmlwdGlv
biBpbiAnYWNwX2h3X2ZpbmknCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hY3AuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YWNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMKaW5kZXggMTQw
MDk1NzAzNGExMi4uYjg2NTVmZjczYTY1OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FjcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hY3AuYwpAQCAtMTc2LDcgKzE3Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgZGV2aWNlICpnZXRf
bWZkX2NlbGxfZGV2KGNvbnN0IGNoYXIgKmRldmljZV9uYW1lLCBpbnQgcikKIC8qKgogICogYWNw
X2h3X2luaXQgLSBzdGFydCBhbmQgdGVzdCBBQ1AgYmxvY2sKICAqCi0gKiBAYWRldjogYW1kZ3B1
X2RldmljZSBwb2ludGVyCisgKiBAaGFuZGxlOiBoYW5kbGUgdXNlZCB0byBwYXNzIGFtZGdwdV9k
ZXZpY2UgcG9pbnRlcgogICoKICAqLwogc3RhdGljIGludCBhY3BfaHdfaW5pdCh2b2lkICpoYW5k
bGUpCkBAIC00MDUsNyArNDA1LDcgQEAgc3RhdGljIGludCBhY3BfaHdfaW5pdCh2b2lkICpoYW5k
bGUpCiAvKioKICAqIGFjcF9od19maW5pIC0gc3RvcCB0aGUgaGFyZHdhcmUgYmxvY2sKICAqCi0g
KiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAaGFuZGxlOiBoYW5kbGUgdXNlZCB0
byBwYXNzIGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICoKICAqLwogc3RhdGljIGludCBhY3BfaHdf
ZmluaSh2b2lkICpoYW5kbGUpCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
