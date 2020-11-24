Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8E3C64E7A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355DA20B1F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzIcHL0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355DA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FA06E92B;
	Wed, 25 Nov 2020 08:23:00 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404596E5A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:50 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t4so10609046wrr.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LAMUF0M+5e5QxYGdyHTIO/CIT9L6gglBGUvPq+MzHBg=;
 b=jzIcHL0eMMZm6DtlZ9fd+0W/Qjf5OD3r//36xPdi8sot0v4hYcjWBJGo5JsdiMAylp
 59cVzB0oYdEJPt6mdkziyQpaCf9SGy3mSSb/GS6zD2UgphuNsEksk+mdbzN58DTfIKHq
 EAOM2xRHO5Peg/72jxA8+vV69v1RYabIKSnergZZ0ZMBcl+60CIl9Iq3i0vVOQ24h4iG
 GvSC+Xkk8n07CN7qKU+XEd44EJWCpmiRlNYWrlWHzqAYUhnJHcFSBkYV+/Ut8MP8+xxf
 pr0QrRWs6YAUEhSh5t8ghtWxnO/bqpAlEyi4IUA21Oj2pQc67sOd7YpbMJx2fSqqXAju
 XxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LAMUF0M+5e5QxYGdyHTIO/CIT9L6gglBGUvPq+MzHBg=;
 b=LIBcs8AnJrFDnK/uqNoOJz0nEIsYDj7iwnF+nBnrpjeDy/Nf5lloeQLwJvHbRc0AEH
 bYgZ3J80I5cnt7XXwLpjfiuAXpIqFieBGzoj/kLfStrPArMt0mZn4fFnzuxxOOLOspZx
 q9+zrRBKZsxZtj6HXHXtlnLKO+jdDxZyqT7HB2XzexYWbHVvLG8hg2OtOUq+DtwoI+Vs
 +xNZFN+Sm1l9NymRjrr1O4eRBXjOTBU6sdGwIDD2MjwmWZgo1N5KvTFMrpZouyJa+3Fo
 rTnP26j0xOXoFU7EEsJ3CqSxAE/FN7oyiE8O2Ym7+cwoWDLy5Imk0GLSXugVHO10IFVu
 TU9Q==
X-Gm-Message-State: AOAM532/NzfnMZCKbOW/veKys/YTMC1R2YfoLUooK2jvLGyU6aDs7+vy
 Unfq7XWfdvbRzYIvxNpXqxTYGw==
X-Google-Smtp-Source: ABdhPJwGpjx8U/47ZgWVIMjepZQiRgQQJIP/hnzr40LeSboZi3EXQzjARjAY1rA2rTYNNnVeMWqbpA==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr44599wru.405.1606247088972;
 Tue, 24 Nov 2020 11:44:48 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:48 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 40/40] drm/amd/amdgpu/amdgpu_uvd: Add description for
 amdgpu_uvd_cs_msg_decode()'s 'buf_sizes' param
Date: Tue, 24 Nov 2020 19:38:24 +0000
Message-Id: <20201124193824.1118741-41-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jOjU1NTogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnYnVmX3NpemVzJyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVf
dXZkX2NzX21zZ19kZWNvZGUnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3Jn
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJv
LW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2
ZC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKaW5kZXggZjhmMDM4NGE4ZDlhZC4uN2M1YjYwZTUzNDgy
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwpAQCAtNTQ3LDYgKzU0
Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3V2ZF9jc19wYXNzMShzdHJ1Y3QgYW1kZ3B1X3V2ZF9j
c19jdHggKmN0eCkKICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKiBAbXNn
OiBwb2ludGVyIHRvIG1lc3NhZ2Ugc3RydWN0dXJlCisgKiBAYnVmX3NpemVzOiBwbGFjZWhvbGRl
ciB0byBwdXQgdGhlIGRpZmZlcmVudCBidWZmZXIgbGVuZ3RocwogICoKICAqIFBlZWsgaW50byB0
aGUgZGVjb2RlIG1lc3NhZ2UgYW5kIGNhbGN1bGF0ZSB0aGUgbmVjZXNzYXJ5IGJ1ZmZlciBzaXpl
cy4KICAqLwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
