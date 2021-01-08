Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7443EC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300A823AC0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300A823AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50CD6E8F2;
	Fri,  8 Jan 2021 20:24:15 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8126E8D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:17 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id g185so9441191wmf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4m+UfJ8aX5WLjKwBG1Xu8sQ5BNsQhd/cnOc6646uVLM=;
 b=xLshuzqR1S5leuYqYt+i5O0pzH6SK7237sKx76ydZAZ12/sCmWGMaKpZAn5ORm5VxA
 b7AM62dLqUYFa3QkxepEi2Glma4JBkROyGwMzVvdYsXkkMaw3Sgda6nSa6R/FaF31Dpm
 ZiX7Q7jWTDA32xLpGC0RqCfHNihxlDNszP5NaU/LTHZ0sULnT8MXDlKC4miJYJIs4C3X
 7UFv+/hFIZWuQxni+OkJp+bCWx2MOgrkuvoeByqrNPXePBhFcRcz6Mix2yTuGTBFwC9f
 jIbx6kAGiVERht+t17b65sHTRyNoCN2dT3DF3NTdbtSk17MqvxIcY2afNbxf8gFeFwwY
 YJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4m+UfJ8aX5WLjKwBG1Xu8sQ5BNsQhd/cnOc6646uVLM=;
 b=N86IIxAxEoSjwQOvUKPqmL5eEj7oRPM2hFx4Kdgd6sEWWN/MfZ0iQKTLNWpq0zsOoZ
 KCduAFo/LxeQdxtX258Scf82bpt4uc+FAASJ66D0VeCzW7E3lUeM4CJrDN7Szk4KeO/F
 ekvklhkfm1H2zLVBYirB+Lr6CfQtluCqpGbZkP7NlYAWqHiC9A4PKb+SjqnVqQhAoz8K
 M6Lic00DUYXrMz44cvFNlD8993zVtSzIC/4xh3REAo7YPTVgM6moWx1HxQB2d1UkMa8i
 j5kwEhC3gRP37FCLBPIF0vMqxkUL1Q2YStYMdrM86tzaX3uE4RohjK5AeuyS2wadsLJA
 AVrg==
X-Gm-Message-State: AOAM532OzI/gvwI8egN9rhn4UgQb+N6j5y0+NYWW2tSVOmq8iMW/eJ49
 57zVQk7KK9p45sehwtGhQlkAmQ==
X-Google-Smtp-Source: ABdhPJzzFAJVmK21o2vqWktdG8/jT/HrmCYeMykde37kQ//uOudXLb2wVW4KTK+B7j9Unkk/ciS3Lg==
X-Received: by 2002:a05:600c:313:: with SMTP id
 q19mr4477223wmd.126.1610136916383; 
 Fri, 08 Jan 2021 12:15:16 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 09/40] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Fix legacy
 function header formatting
Date: Fri,  8 Jan 2021 20:14:26 +0000
Message-Id: <20210108201457.3078600-10-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5j
Ojc4MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnaHdtZ3InIG5vdCBk
ZXNjcmliZWQgaW4gJ3ZlZ2EyMF9pbml0X3NtY190YWJsZScKCkNjOiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3ZlZ2EyMF9od21nci5jIHwgMTEgKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYwppbmRleCBkYTg0MDEyYjdmZDUxLi44
NzgxMWIwMDViODVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxh
eS9od21nci92ZWdhMjBfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci92ZWdhMjBfaHdtZ3IuYwpAQCAtNzcxLDEyICs3NzEsMTEgQEAgc3RhdGljIGlu
dCB2ZWdhMjBfc2V0dXBfZGVmYXVsdF9kcG1fdGFibGVzKHN0cnVjdCBwcF9od21nciAqaHdtZ3Ip
CiB9CiAKIC8qKgotKiBJbml0aWFsaXplcyB0aGUgU01DIHRhYmxlIGFuZCB1cGxvYWRzIGl0Ci0q
Ci0qIEBwYXJhbSAgICBod21nciAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2Fy
ZSBtYW5hZ2VyLgotKiBAcGFyYW0gICAgcElucHV0ICB0aGUgcG9pbnRlciB0byBpbnB1dCBkYXRh
IChQb3dlclN0YXRlKQotKiBAcmV0dXJuICAgYWx3YXlzIDAKLSovCisgKiBJbml0aWFsaXplcyB0
aGUgU01DIHRhYmxlIGFuZCB1cGxvYWRzIGl0CisgKgorICogQGh3bWdyOiAgdGhlIGFkZHJlc3Mg
b2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5hZ2VyLgorICogcmV0dXJuOiAgYWx3YXlzIDAK
KyAqLwogc3RhdGljIGludCB2ZWdhMjBfaW5pdF9zbWNfdGFibGUoc3RydWN0IHBwX2h3bWdyICpo
d21ncikKIHsKIAlpbnQgcmVzdWx0OwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
