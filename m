Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D3C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D07423102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D07423102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A215B6E112;
	Wed, 13 Jan 2021 08:24:28 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB4A6E061
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:19 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id y187so712580wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UzSVTfnGeF4QxtWxeHYTIcFMIY4s6ebauA3+cdnRC38=;
 b=TY9K9YP3KeN4jJ31pGivkq0dF1YT54ldZJqLn6MYgdukuVkCp1zu+y0mPY6lahL/cy
 1RZcx437IV0+wAEUKVyLgcGDYpTDNEL1Ppn0vXUncrWgNbXQ1NAXE1SAV8ys9N81RnYq
 L80CoeEUDBznRtSXNf5aVJiLBgu/M3NW5YWML2KRwTpalTbHmI2lrvEOUNFIZGcJmyVN
 AN22iAp7L+Z2f5Prz8MYydOsJDYBrFjKJ6ueQI3EeMHXH6x5NltDhYkzPnWAsnjVgG1m
 3f+UnLYOmmG+9ZtdtXLtJus/mi94hGo7N9uqHpmNiDUIXrk0xJ0Ap+OMgc5sowuOA4BC
 Xa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UzSVTfnGeF4QxtWxeHYTIcFMIY4s6ebauA3+cdnRC38=;
 b=n6nAtZXXdU2/EPTrTZzQpKD7fGfTl27BIdRN7zaon1ePIt2/bPz2ixrKG6vXHMCaMV
 WgfaoovJIz6FV1SgkQ4MD32MQj96zCzxk4LcWsQXFPU07o04w1CsnXx6lUTAuDgKK33/
 ELE3bawq6/sMJyRgHpn4FWK/Pmei6a6q8sORQpuOpbR1tMx6affsdF8PpnI06pwOB429
 AxjFPC+BfBA7GcXaBk5P8Rbe6d3GG8qq8/XkNTyUKVzHylJmZJWuG2r0eZTr8ubF9Mmq
 egHyfZk9BqYPf15EjelQZmqRidhFxAV/nLzaB+cMB1U9jQErY7spwOBXPtHlmJWQDYwa
 VdOA==
X-Gm-Message-State: AOAM530EpoDT8ILVG5bpnEq7jpHFaIFDd0CoGxqICjFfKPd7VeXTp/HI
 heKLqeRbPxE/zxi5pvFVX7fRTQ==
X-Google-Smtp-Source: ABdhPJysnmI+q/9hcXh4YnGhQ3w5WlvU1D7CpFhRu8UDUu/rw7x3VueRmXRn3MgpQ7OuewfpCDNVGg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr939751wme.189.1610525298154; 
 Wed, 13 Jan 2021 00:08:18 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/30] drm/amd/display/dc/core/dc_link: Move some local data
 from the stack to the heap
Date: Wed, 13 Jan 2021 08:07:40 +0000
Message-Id: <20210113080752.1003793-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Jan 2021 08:24:28 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzogSW4gZnVu
Y3Rpb24g4oCYZGNfbGlua19jb25zdHJ1Y3TigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jOjE1ODg6MTogd2FybmluZzogdGhlIGZyYW1l
IHNpemUgb2YgMTE3NiBieXRlcyBpcyBsYXJnZXIgdGhhbiAxMDI0IGJ5dGVzIFstV2ZyYW1lLWxh
cmdlci10aGFuPV0KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
Q2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyB8IDEyICsrKysrKysrKy0tLQogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKaW5kZXggOGNjZGE4YjlhYzJlYi4uMzM2NmE0
OWYxMWRjNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGluay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmsuYwpAQCAtMTM2NCwxMyArMTM2NCwxNyBAQCBzdGF0aWMgYm9vbCBkY19saW5rX2NvbnN0cnVj
dChzdHJ1Y3QgZGNfbGluayAqbGluaywKIAlzdHJ1Y3QgZGNfY29udGV4dCAqZGNfY3R4ID0gaW5p
dF9wYXJhbXMtPmN0eDsKIAlzdHJ1Y3QgZW5jb2Rlcl9pbml0X2RhdGEgZW5jX2luaXRfZGF0YSA9
IHsgMCB9OwogCXN0cnVjdCBwYW5lbF9jbnRsX2luaXRfZGF0YSBwYW5lbF9jbnRsX2luaXRfZGF0
YSA9IHsgMCB9OwotCXN0cnVjdCBpbnRlZ3JhdGVkX2luZm8gaW5mbyA9IHt7eyAwIH19fTsKKwlz
dHJ1Y3QgaW50ZWdyYXRlZF9pbmZvICppbmZvOwogCXN0cnVjdCBkY19iaW9zICpiaW9zID0gaW5p
dF9wYXJhbXMtPmRjLT5jdHgtPmRjX2Jpb3M7CiAJY29uc3Qgc3RydWN0IGRjX3ZiaW9zX2Z1bmNz
ICpicF9mdW5jcyA9IGJpb3MtPmZ1bmNzOwogCXN0cnVjdCBicF9kaXNwX2Nvbm5lY3Rvcl9jYXBz
X2luZm8gZGlzcF9jb25uZWN0X2NhcHNfaW5mbyA9IHsgMCB9OwogCiAJRENfTE9HR0VSX0lOSVQo
ZGNfY3R4LT5sb2dnZXIpOwogCisJaW5mbyA9IGt6YWxsb2Moc2l6ZW9mKGluZm8pLCBHRlBfS0VS
TkVMKTsKKwlpZiAoIWluZm8pCisJCWdvdG8gY3JlYXRlX2ZhaWw7CisKIAlsaW5rLT5pcnFfc291
cmNlX2hwZCA9IERDX0lSUV9TT1VSQ0VfSU5WQUxJRDsKIAlsaW5rLT5pcnFfc291cmNlX2hwZF9y
eCA9IERDX0lSUV9TT1VSQ0VfSU5WQUxJRDsKIApAQCAtMTUzMiwxMiArMTUzNiwxMiBAQCBzdGF0
aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNfbGluayAqbGluaywKIAl9CiAKIAlp
ZiAoYmlvcy0+aW50ZWdyYXRlZF9pbmZvKQotCQlpbmZvID0gKmJpb3MtPmludGVncmF0ZWRfaW5m
bzsKKwkJbWVtY3B5KGluZm8sIGJpb3MtPmludGVncmF0ZWRfaW5mbywgc2l6ZW9mKCppbmZvKSk7
CiAKIAkvKiBMb29rIGZvciBjaGFubmVsIG1hcHBpbmcgY29ycmVzcG9uZGluZyB0byBjb25uZWN0
b3IgYW5kIGRldmljZSB0YWcgKi8KIAlmb3IgKGkgPSAwOyBpIDwgTUFYX05VTUJFUl9PRl9FWFRf
RElTUExBWV9QQVRIOyBpKyspIHsKIAkJc3RydWN0IGV4dGVybmFsX2Rpc3BsYXlfcGF0aCAqcGF0
aCA9Ci0JCQkmaW5mby5leHRfZGlzcF9jb25uX2luZm8ucGF0aFtpXTsKKwkJCSZpbmZvLT5leHRf
ZGlzcF9jb25uX2luZm8ucGF0aFtpXTsKIAogCQlpZiAocGF0aC0+ZGV2aWNlX2Nvbm5lY3Rvcl9p
ZC5lbnVtX2lkID09IGxpbmstPmxpbmtfaWQuZW51bV9pZCAmJgogCQkgICAgcGF0aC0+ZGV2aWNl
X2Nvbm5lY3Rvcl9pZC5pZCA9PSBsaW5rLT5saW5rX2lkLmlkICYmCkBAIC0xNTg0LDYgKzE1ODgs
OCBAQCBzdGF0aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNfbGluayAqbGluaywK
IAkJbGluay0+aHBkX2dwaW8gPSBOVUxMOwogCX0KIAorCWtmcmVlKGluZm8pOworCiAJcmV0dXJu
IGZhbHNlOwogfQogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
