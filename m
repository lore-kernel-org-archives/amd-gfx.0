Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C34C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A002087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccFvN7q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A002087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D622A6EB3C;
	Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7066A6EB36
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:17 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g12so2772606wrp.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H95rA0QKKaL3+FIhv21U45aIyhbFkd+FiaPq5zaa4zk=;
 b=ccFvN7q5RxD4CM0NZ+0NxOOG6O0PgSIXE+amCe86rCTSBZLuWX37GhNGsshfXsaMgJ
 iJ+m8coKTU8tmP8qge3HwIuTlw6dRtNHcwYQoDi0f2+qc7AJiR+nGeV09VYcqv3176Ps
 Z4rIW0Ek+Ibod01RSdTTLjdionhBuOzof//ifUqw8gtS7OVpCBHufYnY7iISAOwDON89
 8xox35G1GiJLy2sNXn3sNnHV8RbvddMWz/MEVUR8Lekn7rI/ELHoZ3UWfBQdxqeSpqyX
 4Z0EBLkLyasPaxfUW9RF1jPxDJT4MtCVhxwJV7ziZHtyfaZlgC6YN1pEUtBZ0X+ZzIJj
 +nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H95rA0QKKaL3+FIhv21U45aIyhbFkd+FiaPq5zaa4zk=;
 b=T+sxvIKfULbEUrTH2vlPUITgzLh4c2aeizvzC2KGzGG0ydomyX3bFMQSzfN5f1rZVB
 hrzbIX34AECJPGwQODDzaT1bcfeXGGqWUJL6QZCdz+893aMcuzS/kyB5Jz35LBS93Iy4
 6zkH5hQH80LysH03PJauogSn9UbQUlsV9eNh/oscndxBmlWFjH1Kv0ReWICrbJoIJy5+
 xB21hQcURzDMiKHmi++BgSEA3X7sWZAg2Rn1rA6CRRCb3C52GnL+uVp9inIqxj0jSRYO
 1k8azHFH64t0/dwZwUbqV8DMPmrA1iABkCU5hX4GjGKbTUTOQOVgxTw0MhpiQNrR6yzC
 3nzw==
X-Gm-Message-State: AOAM532wnF0Uz1BcVoc+W2ZuziiaygZ311TEJVOmX7VJQhUrUOMx8t7l
 wwxUzEQLFOMlcwjTiIKDjBwtfw==
X-Google-Smtp-Source: ABdhPJz9AWUMB39aA8Da4lz3LdJLIZWfCG0guHXHUnmy1PklBu/Fnl293iGu8GFZZ/mVR1JdkoPY7g==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr2494726wrm.382.1604699416188; 
 Fri, 06 Nov 2020 13:50:16 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/19] drm/radeon/atombios_crtc: Remove description of
 non-existent function param 'encoder'
Date: Fri,  6 Nov 2020 21:49:48 +0000
Message-Id: <20201106214949.2042120-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19jcnRjLmM6MTc5Njogd2FybmluZzogRXhjZXNzIGZ1
bmN0aW9uIHBhcmFtZXRlciAnZW5jb2RlcicgZGVzY3JpcHRpb24gaW4gJ3JhZGVvbl9nZXRfc2hh
cmVkX25vbmRwX3BwbGwnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfY3J0
Yy5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9hdG9tYmlvc19jcnRjLmMKaW5kZXggOTE4MTE3NTcxMDRjMC4uMTk3OWVkM2Q2NTQ3MiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19jcnRjLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19jcnRjLmMKQEAgLTE3ODcsNyArMTc4Nyw2
IEBAIHN0YXRpYyBpbnQgcmFkZW9uX2dldF9zaGFyZWRfZHBfcHBsbChzdHJ1Y3QgZHJtX2NydGMg
KmNydGMpCiAgKiByYWRlb25fZ2V0X3NoYXJlZF9ub25kcF9wcGxsIC0gcmV0dXJuIHRoZSBQUExM
IHVzZWQgYnkgYW5vdGhlciBub24tRFAgY3J0YwogICoKICAqIEBjcnRjOiBkcm0gY3J0YwotICog
QGVuY29kZXI6IGRybSBlbmNvZGVyCiAgKgogICogUmV0dXJucyB0aGUgUFBMTCAoUGl4ZWwgUExM
KSB1c2VkIGJ5IGFub3RoZXIgbm9uLURQIGNydGMvZW5jb2RlciB3aGljaCBjYW4KICAqIGJlIHNo
YXJlZCAoaS5lLiwgc2FtZSBjbG9jaykuCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
