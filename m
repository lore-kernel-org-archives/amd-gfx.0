Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DFEC47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2E061090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2E061090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE6C6ECDE;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BA76E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:43 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso2907947wmc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X92MMk5kMi/9Whx04jPkFETzN+cajEcLCrynmOFE/4E=;
 b=h9EonsBwz/L4qhRXfcmGTgEQaj4rDXaTaENbNk0xlbWhzOzw3iokduWpAr1XGqvUYN
 mCQkU7iW5Ma/zft9eiE3GgFXXMsv0TDecBvlMSmwZWwY7ZGw4yQ73VZqRG+4OGWcHcsw
 AZH1HqlOL6gyIIGI5k42oq5XLy2rYWrZmQkya+Anjm0IScxY7bMXLGi+fvFVR0BAATM5
 14SQjCaAeDmemdH/qHWXKgE/GLkh/lKQILaBoIVP1pkFXhTxLckAaIcg+AcEPnrEv4re
 WgukuG4TDE9/Uz7FvNnqB9w/Mk6LFDWBrDCr+Lz0T2ooic53RQuR70abTxVsWAVfvGkc
 CBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X92MMk5kMi/9Whx04jPkFETzN+cajEcLCrynmOFE/4E=;
 b=hFnJN2xPsYdbkRCKBXTV5J4kSRcRGOaRnonKpTgx0OEF90BspTDEJ+CSZTgmKhIW0L
 5ZoUBVpUg1YzzqAU+U/uyxyFZdGTsfAAgmGBpfmK6Sd7HeQm0UEzEn7ixf4QIyhKXySi
 gWEE0i4BYcd774oaIdetcQuNEvqf5rhaugKiu9dJJesJkCcp2KWlHXDzTbRpmJ7i3EO2
 ZIEXufOdlgcMsrFsd5KeskSQ3DXY+DUSfbuos7G0i5NU+fdiTL2cKFfVtZtgdX1ACFqi
 jNsq5CfB2j7SdUGeektCzknsMBdTzXeArFqhpxclefErVjRMlJdlRgwndNvCcXlJ496a
 MZuA==
X-Gm-Message-State: AOAM53068pJcOxHCPwPxOmnEX4LRXkZdGOiet6erOiz2/YgZ2Z9cY/uV
 CfrybnN4KEqRS4uDySTx9d8d6Q==
X-Google-Smtp-Source: ABdhPJyx1uFISeXmdtKQQhnTK23vTXiJRYW6DYcboA9WMr5VX5C3wH+hrPWw8ug/Shp608nkyZ0i8A==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr1717471wmg.108.1622018862620; 
 Wed, 26 May 2021 01:47:42 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:42 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Functions must
 directly follow their headers
Date: Wed, 26 May 2021 09:47:04 +0100
Message-Id: <20210526084726.552052-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6NjA4
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpbnRlcnJ1cHRfcGFyYW1z
JyBub3QgZGVzY3JpYmVkIGluICdkbV9kY25fdmVydGljYWxfaW50ZXJydXB0MF9oaWdoX2lycScK
CkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8
c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwppbmRleCBiNGU5NWQzZmYzYjg4Li5hZTBhOTVjNWYxZDhjIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
QEAgLTYwMSw2ICs2MDEsNyBAQCBzdGF0aWMgdm9pZCBkbV9jcnRjX2hpZ2hfaXJxKHZvaWQgKmlu
dGVycnVwdF9wYXJhbXMpCiB9CiAKICNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikK
KyNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX1NFQ1VSRV9ESVNQTEFZKQogLyoqCiAgKiBkbV9k
Y25fdmVydGljYWxfaW50ZXJydXB0MF9oaWdoX2lycSgpIC0gSGFuZGxlcyBPVEcgVmVydGljYWwg
aW50ZXJydXB0MCBmb3IKICAqIERDTiBnZW5lcmF0aW9uIEFTSUNzCkBAIC02MDgsNyArNjA5LDYg
QEAgc3RhdGljIHZvaWQgZG1fY3J0Y19oaWdoX2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1zKQog
ICoKICAqIFVzZWQgdG8gc2V0IGNyYyB3aW5kb3cvcmVhZCBvdXQgY3JjIHZhbHVlIGF0IHZlcnRp
Y2FsIGxpbmUgMCBwb3NpdGlvbgogICovCi0jaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9TRUNV
UkVfRElTUExBWSkKIHN0YXRpYyB2b2lkIGRtX2Rjbl92ZXJ0aWNhbF9pbnRlcnJ1cHQwX2hpZ2hf
aXJxKHZvaWQgKmludGVycnVwdF9wYXJhbXMpCiB7CiAJc3RydWN0IGNvbW1vbl9pcnFfcGFyYW1z
ICppcnFfcGFyYW1zID0gaW50ZXJydXB0X3BhcmFtczsKLS0gCjIuMzEuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
