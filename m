Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D54C433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7699623AC0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7699623AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0E06E8F1;
	Fri,  8 Jan 2021 20:24:15 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBEE6E8CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:15 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id 190so8767174wmz.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ynto/MZpBe5G42s9vReiED0PRGKZttvk/p9R7rGmhMU=;
 b=j5gRi8kb1z9r9v0Wmdcr1/+GgOq0BvFyxJd3BMOSmd4YTFM9odpHw4ntJ7o8srreTK
 S+xjPLLW6HLRvT3SnpwpcsrZ6FjgNgB9VKnHAMH+LkkNEPfWTGHknUnph7WJ+0t402qx
 lZVdInz3sXRPqLHWXmm6oPdMFtEm0C41JiZYtbEdkuSbsa44LvSHR2DR/G5EEKK+Z8nN
 fPmxUsaC/tqeOXjSV9F3HDn81aNwuhIdvjg2dDQM3HQHU+YpmYvr5SbxP0Gjpb5wxsl5
 orEaLRKjsqCfTCOsLh2r/OzNDWUTWM6P63onC+JtQKk2z0ulnnB6/Owyd1hvoNIy6478
 rJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ynto/MZpBe5G42s9vReiED0PRGKZttvk/p9R7rGmhMU=;
 b=PUEZFSK9WHM17U4rwvMMcUxBceOB8uQUQhxcWdecJLcEiLfeNWwI9RM71nppBM0Z2K
 1Mwqpot3AiB8q+M+O/Ndyjtf+wNoKhnPVP/kE+4nVk5PhWxNAkhfDeOWys9beCCh2kZs
 PRTOCsMMUDLuzxmG6K7bESobPxUyUZWG+EFm8566rWfNAo+dqaqBz/NdtnWkJshMnOPn
 pB4z/09TJx+rBqOaEsUKiLiHY8v5nUkxZait8ZZm5x6rM+SejwXf8U82Niz8RB467iZU
 kZQ27G5moHfbHG9xDRY49brqq41UpNbvJPV461oemyP9B86HQN8iJoRMRreEXTtUKYJV
 qfPw==
X-Gm-Message-State: AOAM530iGysYQQIEUbtRIoYkIaf3KjzvuD0SJghF8/QYS2BQarC/8cbc
 KTU+Wg9Qrugx1niRCDcDhB9ZSQ==
X-Google-Smtp-Source: ABdhPJxAsGGcg5ElEg6lbsPL0Qt2RrOVM2OAs+h+KSs4vC433L+e+4yx8PbxvRflV0mz9r7K5QcWjQ==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr4489592wmr.162.1610136913799; 
 Fri, 08 Jan 2021 12:15:13 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix
 documentation for 'mpll_param'
Date: Fri,  8 Jan 2021 20:14:24 +0000
Message-Id: <20210108201457.3078600-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3BwYXRvbWN0cmwuYzoy
OTA6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ21wbGxfcGFyYW0nIG5v
dCBkZXNjcmliZWQgaW4gJ2F0b21jdHJsX2dldF9tZW1vcnlfcGxsX2RpdmlkZXJzX3NpJwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3BwYXRvbWN0cmwu
YzoyOTA6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2RpdmlkZXJzJyBkZXNj
cmlwdGlvbiBpbiAnYXRvbWN0cmxfZ2V0X21lbW9yeV9wbGxfZGl2aWRlcnNfc2knCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tY3RybC5jOjMz
OTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbXBsbF9wYXJhbScgbm90
IGRlc2NyaWJlZCBpbiAnYXRvbWN0cmxfZ2V0X21lbW9yeV9wbGxfZGl2aWRlcnNfdmknCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvcHBhdG9tY3RybC5j
OjMzOTogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZGl2aWRlcnMnIGRlc2Ny
aXB0aW9uIGluICdhdG9tY3RybF9nZXRfbWVtb3J5X3BsbF9kaXZpZGVyc192aScKCkNjOiBFdmFu
IFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L2h3bWdyL3BwYXRvbWN0cmwuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3Bvd2VycGxheS9od21nci9wcGF0b21jdHJsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci9wcGF0b21jdHJsLmMKaW5kZXggODNhNjUwNGUwOTNjYi4uYjEw
MzhkMzBjOGRjYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkv
aHdtZ3IvcHBhdG9tY3RybC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5
L2h3bWdyL3BwYXRvbWN0cmwuYwpAQCAtMjc5LDcgKzI3OSw3IEBAIHN0YXRpYyBjb25zdCBBVE9N
X1ZPTFRBR0VfT0JKRUNUX1YzICphdG9tY3RybF9sb29rdXBfdm9sdGFnZV90eXBlX3YzKAogICoK
ICAqIEBod21ncjogICAgICAgICAgIGlucHV0IHBhcmFtZXRlcjogcG9pbnRlciB0byBId01ncgog
ICogQGNsb2NrX3ZhbHVlOiAgICAgaW5wdXQgcGFyYW1ldGVyOiBtZW1vcnkgY2xvY2sKLSAqIEBk
aXZpZGVyczogICAgICAgIG91dHB1dCBwYXJhbWV0ZXI6IG1lbW9yeSBQTEwgZGl2aWRlcnMKKyAq
IEBtcGxsX3BhcmFtOiAgICAgIG91dHB1dCBwYXJhbWV0ZXI6IG1lbW9yeSBjbG9jayBwYXJhbWV0
ZXJzCiAgKiBAc3Ryb2JlX21vZGU6ICAgICBpbnB1dCBwYXJhbWV0ZXI6IDEgZm9yIHN0cm9iZSBt
b2RlLCAgMCBmb3IgcGVyZm9ybWFuY2UgbW9kZQogICovCiBpbnQgYXRvbWN0cmxfZ2V0X21lbW9y
eV9wbGxfZGl2aWRlcnNfc2koCkBAIC0zMzIsNyArMzMyLDcgQEAgaW50IGF0b21jdHJsX2dldF9t
ZW1vcnlfcGxsX2RpdmlkZXJzX3NpKAogICoKICAqIEBod21ncjogICAgICAgICAgICAgICAgIGlu
cHV0IHBhcmFtZXRlcjogcG9pbnRlciB0byBId01ncgogICogQGNsb2NrX3ZhbHVlOiAgICAgICAg
ICAgaW5wdXQgcGFyYW1ldGVyOiBtZW1vcnkgY2xvY2sKLSAqIEBkaXZpZGVyczogICAgICAgICAg
ICAgIG91dHB1dCBwYXJhbWV0ZXI6IG1lbW9yeSBQTEwgZGl2aWRlcnMKKyAqIEBtcGxsX3BhcmFt
OiAgICAgICAgICAgIG91dHB1dCBwYXJhbWV0ZXI6IG1lbW9yeSBjbG9jayBwYXJhbWV0ZXJzCiAg
Ki8KIGludCBhdG9tY3RybF9nZXRfbWVtb3J5X3BsbF9kaXZpZGVyc192aShzdHJ1Y3QgcHBfaHdt
Z3IgKmh3bWdyLAogCQl1aW50MzJfdCBjbG9ja192YWx1ZSwgcHBfYXRvbWN0cmxfbWVtb3J5X2Ns
b2NrX3BhcmFtICptcGxsX3BhcmFtKQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
