Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5883C43600
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6915261001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6915261001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979186F45C;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9446897CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:19 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id y14so15303208wrm.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Az4ajU1UenYP4llap6LwYGAmlVb81FxvttX6ntbrKHw=;
 b=V0/Xcd4FORtoMvNKBEs95Uqtk9Dfnrrj1mowrOIgtUtj97/HkDTL7uz6D69vwAGAS3
 Tdl2wWWjwYVP6GP3fWhFHoNUw4SNR/zAKwaRH3y17fCdc3FVVXkmWPvH5s1HKhZo8AYz
 4Mk9Qc9YtTJ7V88BeOccyuqk2Y4USOt8e2/PyXVwFgBMsb8T0qZ+naXe5Nd7NLVINWsw
 /kmNqlR7g9ceexOxZxdMuoQ5CnkImv246XNufxmMTy+8b/4YhcUSXFy2+gAAuFtRSykz
 YYCfLFqI/SeFI26zM5Nz8d+d1R3bfy0llGMVZDcrq4MOJfmZXYJAQ6qcf/aTPzYBpVMh
 jeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Az4ajU1UenYP4llap6LwYGAmlVb81FxvttX6ntbrKHw=;
 b=Qisez4x4fPhUmCYkhqmXIqs8yw/8hIWq33SqG2XBjosNYYgIb0ioETu7aNjZBZ21Sq
 aCRThFEyeIArqzDszbmMrfX7hzVTtkbwFGqYyvDOl9SDUrrbRwpa7RhIUjscC5IZ9nCr
 kF2A4YpLj85RuC1ugwLZbiLagP3GNPPzmnGDsbHO7/7ahTvyIYEfvy5ago1/Nj5/fkwF
 9WdVs288rV20rY7iwRdVzd0R6n1Q5wy+A9ohSSXdX85szu7GkdxDA47joOekMvw8/z8b
 Sm+qr7jHWDr4UYhjiWt7MWOwRP2uEo0GH/yZulCEXGS7v3xmJtt8BsYNfhGelvwL3Tzh
 DWMQ==
X-Gm-Message-State: AOAM533LcAj7yQqVsOvlWd+7PzNUjexOgiUprzDGWVLEEZQ6frNOsEWC
 z1yW6mmxCV1sbFMndElJx9nmOQ==
X-Google-Smtp-Source: ABdhPJzvSnQab2ZlmzV8rwXYlbo6fahXqWIXfZ2GJOFB82qmSumOr0nFpfJ+gyT9ugbfaWxmxPTiug==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr3880003wrr.355.1621512198612; 
 Thu, 20 May 2021 05:03:18 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:18 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 26/38] drm/amd/amdgpu/gmc_v10_0: Fix potential copy/paste issue
Date: Thu, 20 May 2021 13:02:36 +0100
Message-Id: <20210520120248.3464013-27-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmM6OTU1OiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBnbWNfdjhfMF9nYXJ0X2ZpbmkoKS4gUHJvdG90eXBlIHdhcyBmb3IgZ21j
X3YxMF8wX2dhcnRfZmluaSgpIGluc3RlYWQKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxp
bmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNj
OiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVz
IDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKaW5kZXggZjAyZGM5
MDRlNGNmZS4uMTA1ZWQxYmY0YTg4YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Yx
MF8wLmMKQEAgLTk0Nyw3ICs5NDcsNyBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9zd19pbml0KHZv
aWQgKmhhbmRsZSkKIH0KIAogLyoqCi0gKiBnbWNfdjhfMF9nYXJ0X2ZpbmkgLSB2bSBmaW5pIGNh
bGxiYWNrCisgKiBnbWNfdjEwXzBfZ2FydF9maW5pIC0gdm0gZmluaSBjYWxsYmFjawogICoKICAq
IEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAqCi0tIAoyLjMxLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
