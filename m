Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1CAC8300E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4503420872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhF37QAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4503420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62D66E917;
	Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F6D6E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:39 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id e7so6013492wrv.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WTQ5gL/fFZGCODd+MpCfGseH3ViN6nmo6i+7UzfYda0=;
 b=vhF37QAFFTx6Db8V5kbTsDQoerTQjzFKn+ANrhtYl406/gkriHZ4ylI6iyUyHWakwL
 syhFicrl2QLMplXmezvxYV3ooX/dPhH+NAidO5uSgGBAsQKnXFaAa6nOiAE5/MIIqqim
 OMmeTkMW09SFmEzT4aTu3PXKiARnItjTQhCGDuZmz1rc2F7fsFs83nenchpwEI4xkYp1
 R8gHJTGIsSuPWgE8dpuoi+9FMQZt2f1AJKvbNTvNPL32C/06y6x55EQh6Ltz2MoxLmYA
 KjSBVlNHDSKg6spfxS0RARtsaRiHc7rKP+0tTem+q/z7LcztsPne7B3iF743KIvnBR66
 I1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WTQ5gL/fFZGCODd+MpCfGseH3ViN6nmo6i+7UzfYda0=;
 b=FVVy3qhKLWneXo0zMgSuloSW6AATVrJdj3L7FoyodsFeNVBYnKm9zR740gN2Y/y3ug
 vAjgIKPq3d93iAJUPuNXUYatcfFQqFAPYsjhXOZoANGPyfVBPIeP/nSybgvmW2Y/yqg1
 2kAv6mnXwwGF76esKBL2zkhimbxIPhGXk6gwt0KSrOZyb0nZU72VXWHge6wmlLnfNfsO
 0EEfiDdAnCjeosNWv4+Do2FWEN7JzZg/rQa3g/eJQDaAVgcpk4O7WfHpLLuezp7cFgqR
 /5qQFcFznJakDdpO4QkUag561GIRaiBg/to8I/RLYwx7AM62UeEjmlMVRkgi8uYpgIMn
 BZjA==
X-Gm-Message-State: AOAM5329D0JsfOiNBidqFTEUp+Y+nXejPV9UW3Vm1v0EwXTqwY5SsKso
 CNoHrPVTy2e6GvM0IaWhLp3oMg==
X-Google-Smtp-Source: ABdhPJwPLyBXb00eAHfohzKLGLKoQMLk9bEUJuVpLR76WQmyJ6H7DoAgkfyLfw6viWi9n7ydO3Jwzw==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr80073wrq.11.1606247078052;
 Tue, 24 Nov 2020 11:44:38 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:37 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/40] drm/amd/amdgpu/jpeg_v2_0: Add some missing kernel-doc
 descriptions
Date: Tue, 24 Nov 2020 19:38:15 +0000
Message-Id: <20201124193824.1118741-32-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmM6NDk4OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdhZGRyJyBub3QgZGVzY3JpYmVkIGluICdqcGVnX3YyXzBfZGVj
X3JpbmdfZW1pdF9mZW5jZScKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5j
OjQ5ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc2VxJyBub3QgZGVz
Y3JpYmVkIGluICdqcGVnX3YyXzBfZGVjX3JpbmdfZW1pdF9mZW5jZScKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jOjQ5ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
IG9yIG1lbWJlciAnZmxhZ3MnIG5vdCBkZXNjcmliZWQgaW4gJ2pwZWdfdjJfMF9kZWNfcmluZ19l
bWl0X2ZlbmNlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmM6NDk4OiB3
YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdmZW5jZScgZGVzY3JpcHRpb24gaW4g
J2pwZWdfdjJfMF9kZWNfcmluZ19lbWl0X2ZlbmNlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvanBlZ192Ml8wLmM6NTQ5OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdqb2InIG5vdCBkZXNjcmliZWQgaW4gJ2pwZWdfdjJfMF9kZWNfcmluZ19lbWl0X2liJwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmM6NTQ5OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbGFncycgbm90IGRlc2NyaWJlZCBpbiAnanBlZ192Ml8w
X2RlY19yaW5nX2VtaXRfaWInCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdf
djJfMC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Yy
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jCmluZGV4IDZiODBk
Y2VhODBlYzguLjE1YzAyMjRkNDhiMDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2pwZWdfdjJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdf
djJfMC5jCkBAIC00ODksNyArNDg5LDkgQEAgdm9pZCBqcGVnX3YyXzBfZGVjX3JpbmdfaW5zZXJ0
X2VuZChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAgKiBqcGVnX3YyXzBfZGVjX3JpbmdfZW1p
dF9mZW5jZSAtIGVtaXQgYW4gZmVuY2UgJiB0cmFwIGNvbW1hbmQKICAqCiAgKiBAcmluZzogYW1k
Z3B1X3JpbmcgcG9pbnRlcgotICogQGZlbmNlOiBmZW5jZSB0byBlbWl0CisgKiBAYWRkcjogYWRk
cmVzcworICogQHNlcTogc2VxdWVuY2UgbnVtYmVyCisgKiBAZmxhZ3M6IGZlbmNlIHJlbGF0ZWQg
ZmxhZ3MKICAqCiAgKiBXcml0ZSBhIGZlbmNlIGFuZCBhIHRyYXAgY29tbWFuZCB0byB0aGUgcmlu
Zy4KICAqLwpAQCAtNTM4LDcgKzU0MCw5IEBAIHZvaWQganBlZ192Ml8wX2RlY19yaW5nX2VtaXRf
ZmVuY2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1NjQgYWRkciwgdTY0IHNlcSwKICAqIGpw
ZWdfdjJfMF9kZWNfcmluZ19lbWl0X2liIC0gZXhlY3V0ZSBpbmRpcmVjdCBidWZmZXIKICAqCiAg
KiBAcmluZzogYW1kZ3B1X3JpbmcgcG9pbnRlcgorICogQGpvYjogam9iIHRvIHJldHJpdmUgdm1p
ZCBmcm9tCiAgKiBAaWI6IGluZGlyZWN0IGJ1ZmZlciB0byBleGVjdXRlCisgKiBAZmxhZ3M6IHVu
dXNlZAogICoKICAqIFdyaXRlIHJpbmcgY29tbWFuZHMgdG8gZXhlY3V0ZSB0aGUgaW5kaXJlY3Qg
YnVmZmVyLgogICovCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
