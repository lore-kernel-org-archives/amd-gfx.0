Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13853C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A59320825
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ib0DToee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A59320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51DA6E415;
	Thu, 12 Nov 2020 19:56:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63746E2D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:01:01 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d12so7119509wrr.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n1giXMZdt7DXXb4r+KpLOxZ7r3xrDsxCnH5SvILJq7Y=;
 b=ib0DToee6dhVaRCUYKKSQZMNQ/g4EomiT7zCeAwept+8CGssffnj+IMD9+KiqTmiZj
 SGEOXt3jJRypKYdUcKHv/clochvz8K0Thkh9J9nRJEr9WICmtddIe800t7AbEKn+kOFZ
 QOimSE57uPMsVNj95xM3N3msL0+JXs46v/cw3S5mzNx6M3Z5SMFThcN3/SLyEMNkCsoM
 uZZ5zQjvQ6ToX1qDTiXDHZJKKH29DcPFRIA9lWJ6ryGv21IT+mOjGFmoPVNwP6e89fPO
 1yJ9yzLTZKjqtYrAAXAlsWtnYc8H9MMNFADImPh+MXjWW5AY/Mn5BjDUvZvIr3Nutgf+
 Vwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n1giXMZdt7DXXb4r+KpLOxZ7r3xrDsxCnH5SvILJq7Y=;
 b=EE8+S3mA2hiMmNdOIQe7Z0vho9hvVXdj7kbxKV0UE+nqpIkTaff7X8S8cYCH7XaIQr
 n8vm0f+h3Vj+0Z8o8kx3U4ar+7hqBIc1y4fZKJbJ8dcVLCQ/w8l9zYPgZmYf8EoYsw7R
 HnU/HOQIPphaUrODpdRNXd7UpNqYsbDoHgNOVbPiMWGGlSEARAOk5aG0v7tZTNLl8frI
 3ALpVFw/fQeSpLLwOR3cj1xNWflTQ/bBIx3CSo0HucxiuljHrr3wSJ3vcUyg65xxw0lf
 875+Tk7BEhSsY+gFbXVIOa+Wpwv6fJ0VrNyOuY5CE6tHLdq6rRiHlbhpi1nJA07eYEfJ
 ukiw==
X-Gm-Message-State: AOAM53072VKmMWkjgqgOAwhy02BKoWdZNf9P2ZACBJVBs8bpiqnd6hp9
 ej3E2DxiZmn9sPS5WJeLOHQ/hVXXhFbJedPr
X-Google-Smtp-Source: ABdhPJzNHArCwbL4pI4uwIksua2841x4CDh9pe2Fw90mcckGWAkWLhZAVXF5LL+GbNyzZfSJFQ7Wfg==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr1119093wrv.266.1605207660599; 
 Thu, 12 Nov 2020 11:01:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 11:01:00 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/30] drm/amd/amdgpu/amdgpu_kms: Fix misnaming of parameter
 'dev'
Date: Thu, 12 Nov 2020 19:00:15 +0000
Message-Id: <20201112190039.2785914-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Nov 2020 19:56:04 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jOjQ4Nzogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnZGV2JyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfaW5mb19p
b2N0bCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYzo0ODc6IHdhcm5p
bmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2FkZXYnIGRlc2NyaXB0aW9uIGluICdhbWRn
cHVfaW5mb19pb2N0bCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCmluZGV4IGNlYzlhYWQ4YmRm
YTkuLjk4NzIxYWU5MzE4NDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMKQEAgLTQ3NCw3ICs0NzQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9od19pcF9pbmZvKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogLyoqCiAgKiBhbWRncHVfaW5mb19pb2N0bCAtIGFuc3dl
ciBhIGRldmljZSBzcGVjaWZpYyByZXF1ZXN0LgogICoKLSAqIEBhZGV2OiBhbWRncHUgZGV2aWNl
IHBvaW50ZXIKKyAqIEBkZXY6IGRybSBkZXZpY2UgcG9pbnRlcgogICogQGRhdGE6IHJlcXVlc3Qg
b2JqZWN0CiAgKiBAZmlscDogZHJtIGZpbHAKICAqCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
