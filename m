Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7BC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461A723136
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461A723136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138CD6E145;
	Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B87189F45
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:07 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id r7so1068536wrc.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mCRcVC8RkZNOsTZmH5MrfFMxeQad14MXuEtj32uCB2s=;
 b=SpmtloZ/cSZhuSXJ9UQ5EJpwFNOKanG/Bh7X1ETpsmkC49Bq+w103SFSlgUo4pLIMH
 2zKhjWxoUnAtjIDu+O6SHLaEgUkdKy4qCZEP7+tBNDWSP9CUt+1Z8x2nm0wSiq8uyq2M
 Ma/YOj18A45z0ky396eCJnoyUf0zmIrZyeR1V4/RYkslXirRP378ubPBXG5RuEKedpSe
 cFbrG8IQ3GYECv1TK7vuuUf8Jl9WAJCn7m9EbmGKl7ng+wYlDrsDlZkUx4y3zv9RdyA9
 B4wot+hsMGmQQqtj9AgLGGvNVnO0BtwuAwu1ZvRizlL9o/HbLAFaiG7V+mY6GCF+NRQj
 YU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mCRcVC8RkZNOsTZmH5MrfFMxeQad14MXuEtj32uCB2s=;
 b=svbx0rKyfXdFqHe3xh9utOSmXXG2yxF3NIlpV9+awsGxGOr3bH6MfbCpwpdv851Gki
 Io2fhPKPgrpjTrbsxXBJLbaa7BtcHiz9lh04rG1hf16K4YYXB31veGUYfkg1OLaXHyJd
 MZeOkg8CDIGAM9I801EVILkqoIXWbZkaU1m1h3MrTO6dvocDs+DY3yy9fEWxWlJwT+gJ
 MWuqs3oS0qFeYsLj/PKPjq02kU+J09tb4l/l2nCNz8yIlzQNVX26QnpaBn3L7DWAVBpa
 /rBXP/klPGdoKsVu7S78uQJtOtlV3X3MRyngasb9BcJbM2Z9GhyFMhrbp/rZEf77mCJq
 uHzg==
X-Gm-Message-State: AOAM532AvmwrGzSQxo50oqR3UGoEyM08Y++egqEX7u0HHAxucEP49X9Z
 Bbg/Ldie5rqS1V+ghAOiGYg4Bg==
X-Google-Smtp-Source: ABdhPJzn69sZitxlxCughkD08VyFfr7F+gsx//bI3xmhw/alZxDQ3q/KiVOwA0KLVvEE1NsA8yaYew==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr1191325wrv.363.1610525286253; 
 Wed, 13 Jan 2021 00:08:06 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:05 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/30] drm/amd/display/dc/core/dc_link_dp: Staticify local
 function 'linkRateInKHzToLinkRateMultiplier'
Date: Wed, 13 Jan 2021 08:07:30 +0000
Message-Id: <20210113080752.1003793-9-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYzozNzEw
OjE5OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGxpbmtSYXRlSW5LSHpU
b0xpbmtSYXRlTXVsdGlwbGllcuKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jOiBJbiBmdW5j
dGlvbiDigJhkcGNkX3NldF9zb3VyY2Vfc3BlY2lmaWNfZGF0YeKAmToKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmM6NDQwMzoxODogd2Fy
bmluZzogdmFyaWFibGUg4oCYcmVzdWx0X3dyaXRlX21pbl9oYmxhbmvigJkgc2V0IGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYwppbmRleCAyZmMx
MjIzOWIyMmNiLi4zYzMzYjhmZTIxOGU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCkBAIC0zNzA3LDcgKzM3MDcsNyBAQCBib29sIGRl
dGVjdF9kcF9zaW5rX2NhcHMoc3RydWN0IGRjX2xpbmsgKmxpbmspCiAJLyogVE9ETyBzYXZlIHNp
bmsgY2FwcyBpbiBsaW5rLT5zaW5rICovCiB9CiAKLWVudW0gZGNfbGlua19yYXRlIGxpbmtSYXRl
SW5LSHpUb0xpbmtSYXRlTXVsdGlwbGllcih1aW50MzJfdCBsaW5rX3JhdGVfaW5fa2h6KQorc3Rh
dGljIGVudW0gZGNfbGlua19yYXRlIGxpbmtSYXRlSW5LSHpUb0xpbmtSYXRlTXVsdGlwbGllcih1
aW50MzJfdCBsaW5rX3JhdGVfaW5fa2h6KQogewogCWVudW0gZGNfbGlua19yYXRlIGxpbmtfcmF0
ZTsKIAkvLyBMaW5rUmF0ZSBpcyBub3JtYWxseSBzdG9yZWQgYXMgYSBtdWx0aXBsaWVyIG9mIDAu
MjcgR2JwcyBwZXIgbGFuZS4gRG8gdGhlIHRyYW5zbGF0aW9uLgotLSAKMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
