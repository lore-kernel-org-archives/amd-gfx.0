Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45428C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBB623AC0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBB623AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772306E8ED;
	Fri,  8 Jan 2021 20:24:15 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F43B6E8CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:16 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id 190so8767226wmz.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=In1Q+qm5MHof1cMenavqGuBcxDO1piRqNKsllQjE02s=;
 b=F0x9Z4fMGLhfw4n1u93Uhq62eitL0BqRg63/OQZI2nqJtMtnb9XFw10b/oNSbZ/Cc0
 q31JJtFD6ZTSRwnAx4cJeg4an6vd/rYODFPbszdZtF93dGSF1MRSxMcgIEJOX6vMwZX+
 EqyACqU4CLHmNULkAudqGDWMnThQDuoKmVRbS7LWZW+kxv8MP4xtylC6wA+JIKcVlkdy
 7PKpzIU37QV483rrhKqjjM1TFYouFh0iiXuRKQm4l+0NVaAIecM2G1PIps8vSmApgcFQ
 0NeVx4QXyNmRNjJZyPvJjFrytki1lBlcvL3D6nGE1jt8TKEJRI4f6Ab0SIhiTiu8K+gJ
 iwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=In1Q+qm5MHof1cMenavqGuBcxDO1piRqNKsllQjE02s=;
 b=hgzICQzk4EcJIC16Gb7zRAVDjTvOPC0SJIIBqYwcE9flM6PevVZ4jR4l+qOrw29DJr
 MNYWkSPQboy9Pk1CTbJAX6diPgqXQrPgF0VyXZxcr1Gjn/g9vmaF/k1S6UMy8SYEhmfZ
 dVtfEifMNbKzdM3/bzecykxprdYl0jhS1lKPw2NLQd8OwtX+WwCQVyyvBfYDLn+Ui5rO
 xTcKGrJDq6gxEcp9OIx9RViaIed+nYQXqoj3+cT6KFPoqxwl4uN12Q0s2S9mhHLv8Ym5
 lb7sSfWdDg+weCX807T4KBl1JfSwtK96wMHaXnmeFGfDNY8unoU6aRoppLeZb14DIDc/
 xk4A==
X-Gm-Message-State: AOAM533mFstJOqOtTj9AyRmFPIcbtpsghKTVkbII60HLRP/Kahmapvuq
 MmecEfJmXleFbSNUJG7iGq9wjw==
X-Google-Smtp-Source: ABdhPJwFSK+0YlIspGTWyuvGUJ0/L03PXFBojprO/7tBVgl4tWjcjgXy4YV3r9026QikmhFjfkBElg==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr4479570wmj.52.1610136915105;
 Fri, 08 Jan 2021 12:15:15 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:14 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Fix legacy
 function header formatting
Date: Fri,  8 Jan 2021 20:14:25 +0000
Message-Id: <20210108201457.3078600-9-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5j
OjcyODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnaHdtZ3InIG5vdCBk
ZXNjcmliZWQgaW4gJ3ZlZ2ExMl9pbml0X3NtY190YWJsZScKCkNjOiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3ZlZ2ExMl9od21nci5jIHwgMTEgKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYwppbmRleCBkYzIwNmZhODhjNWU1Li5j
MDc1MzAyOWE4ZTJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxh
eS9od21nci92ZWdhMTJfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci92ZWdhMTJfaHdtZ3IuYwpAQCAtNzE4LDEyICs3MTgsMTEgQEAgc3RhdGljIGlu
dCB2ZWdhMTJfc2F2ZV9kZWZhdWx0X3Bvd2VyX3Byb2ZpbGUoc3RydWN0IHBwX2h3bWdyICpod21n
cikKICNlbmRpZgogCiAvKioKLSogSW5pdGlhbGl6ZXMgdGhlIFNNQyB0YWJsZSBhbmQgdXBsb2Fk
cyBpdAotKgotKiBAcGFyYW0gICAgaHdtZ3IgIHRoZSBhZGRyZXNzIG9mIHRoZSBwb3dlcnBsYXkg
aGFyZHdhcmUgbWFuYWdlci4KLSogQHBhcmFtICAgIHBJbnB1dCAgdGhlIHBvaW50ZXIgdG8gaW5w
dXQgZGF0YSAoUG93ZXJTdGF0ZSkKLSogQHJldHVybiAgIGFsd2F5cyAwCi0qLworICogSW5pdGlh
bGl6ZXMgdGhlIFNNQyB0YWJsZSBhbmQgdXBsb2FkcyBpdAorICoKKyAqIEBod21ncjogIHRoZSBh
ZGRyZXNzIG9mIHRoZSBwb3dlcnBsYXkgaGFyZHdhcmUgbWFuYWdlci4KKyAqIHJldHVybjogIGFs
d2F5cyAwCisgKi8KIHN0YXRpYyBpbnQgdmVnYTEyX2luaXRfc21jX3RhYmxlKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IpCiB7CiAJaW50IHJlc3VsdDsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
