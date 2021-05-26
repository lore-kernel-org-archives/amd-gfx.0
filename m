Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E4C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5199861090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5199861090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A076ECEA;
	Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7026EC2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:52 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id d11so189654wrw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7L06mynHw/Hvp7IRLB9pK1ya6b4whZKrsJ5rjcKPGDA=;
 b=p6dcifpgLEh0iuGoFQK2sK66NWHym2V+MK8Mgj2Gbu/s3pxQpqNCHtulzP0eEwjZrY
 4tLExkvLFAZ7n3wVD5ZNye6+hzn+kXamD+QGeriuWID3n3FGGixGYHkvug2JciMuvZ8W
 5Bxhq7HvBx1KgntYp8NgJlzoyA/n79QXt2c17qR6kmkq4mxv/im0kF0i7b425G9BfDYc
 Pe7JbaSsicLm68CiND0fuJr8KunrGw7U6+OEjwTY3RZPloUNp/PPutNRq/VcOuifCJ6u
 LlOR/QhJkBUayFg11eW5qX/3K1QBsFiv3Qg8qkTuZSrkI57AS/nS7hRN5THRTKD4441l
 iozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7L06mynHw/Hvp7IRLB9pK1ya6b4whZKrsJ5rjcKPGDA=;
 b=gf1OGLqGjqK70tj/t4IQUyT18o7DzbX3fLtLuwY+4GjEIbS956zxmbuay3Llj/xRMR
 fkEdB4KVX/oF6ScY0h+UtnzojiYfMfWsrLkqeVEmzsAUgnb0TR20LOATjhknc1BZkj2Y
 8DizMK8tq9F4W1iWv4e3FlXcwLEAYfHIafDBn5kXatF5V+3nqDtAGLy3uXuv7lNNGvqa
 Nfi5pVDIvLIdjAg7AOi4c6UDTJP11b3w1bDvCWHHcV/aDI66ZkOwu+G6/8Fy/74Qb74a
 L2LQ4Hzs8Q/5IKq9FVEOfWV6xMbIPsTtAIF6MeWoIH1kLY1it9W9CpuLcMiyswelyw5i
 I7Iw==
X-Gm-Message-State: AOAM5318MR+Llq32Br39o1moqaljY+edKinWMaRxBC7PKBPZGO5zxG/m
 uKbwhF/WqSMtZezPAZSVCkQZ9jdnyrSBGA==
X-Google-Smtp-Source: ABdhPJztuqUrTTlF820RG/YpKIy9kbje3NTxS+Y/DPltHPd2xWY9oQPpPtmaMh8sTZnnxSSSeP3iXw==
X-Received: by 2002:a5d:4346:: with SMTP id u6mr31619647wrr.304.1622018871538; 
 Wed, 26 May 2021 01:47:51 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:51 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 20/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Fix kernel-doc
 formatting issue
Date: Wed, 26 May 2021 09:47:12 +0100
Message-Id: <20210526084726.552052-21-lee.jones@linaro.org>
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
dV9kbS9hbWRncHVfZG0uYwppbmRleCBhZTBhOTVjNWYxZDhjLi4wYjQ4NDFmMzc3ZTQxIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
QEAgLTYwNSw3ICs2MDUsNyBAQCBzdGF0aWMgdm9pZCBkbV9jcnRjX2hpZ2hfaXJxKHZvaWQgKmlu
dGVycnVwdF9wYXJhbXMpCiAvKioKICAqIGRtX2Rjbl92ZXJ0aWNhbF9pbnRlcnJ1cHQwX2hpZ2hf
aXJxKCkgLSBIYW5kbGVzIE9URyBWZXJ0aWNhbCBpbnRlcnJ1cHQwIGZvcgogICogRENOIGdlbmVy
YXRpb24gQVNJQ3MKLSAqIEBpbnRlcnJ1cHQgcGFyYW1zIC0gaW50ZXJydXB0IHBhcmFtZXRlcnMK
KyAqIEBpbnRlcnJ1cHRfcGFyYW1zOiBpbnRlcnJ1cHQgcGFyYW1ldGVycwogICoKICAqIFVzZWQg
dG8gc2V0IGNyYyB3aW5kb3cvcmVhZCBvdXQgY3JjIHZhbHVlIGF0IHZlcnRpY2FsIGxpbmUgMCBw
b3NpdGlvbgogICovCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
