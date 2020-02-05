Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03AFC35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72CD20730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crW/sohT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72CD20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA936F61B;
	Wed,  5 Feb 2020 15:40:24 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352A46F617;
 Wed,  5 Feb 2020 15:40:22 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id l5so2751629ywd.4;
 Wed, 05 Feb 2020 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L1GhNIx2PtGdglnqeJklgMjlbabviVksiURR6t7YZis=;
 b=crW/sohTg4tf71e+LTEw20AP/18jsAWMuJpJmhTtVSkVZ+tIC8knq1onma+vbRy75i
 EW/0XLf3Fc2LXH0F0bY76xSOr8XMTqxkYt12x8KE1h2jQKjp6uc4SO1nImOO/K+NaBYQ
 l+MiNx2Qyu7VnfzjHDnEQ+PdSEzwXg/MUj6JWLMI/Upc4MCOI2/0LDdhHMQbivhHpccx
 CsUjg4PLmftjOBJ2p4ELBLtDT8PPLTi89+pDDiT4aT46Z/dK0TZqO11+O6XUb3KksKFh
 LzMbSItO2X5jYRuO7JrswoKkH4V+fUznaDfdVLPN3NXc42t8gyZgE8Qa9fwpZ0vEw2yt
 elnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1GhNIx2PtGdglnqeJklgMjlbabviVksiURR6t7YZis=;
 b=V2DGlFhOZ85EyXuECeP3pFVQWW8n5+VBdLDixwd4eYPI82DyJaR3cyYpYT6DSXojw1
 EUSAeKovImuN8Y/wy395ioTjaWL3whM8W5jco3fl1GgipT9El2g0shvtWmGlmKjIcOVo
 IsLlbviAn2zaCznRTb9ix7QpEYn7HcT2272eMzcIRxEHcdFo1/NFSRZhxOq4H2JcBasZ
 0xx6y44tQtGQsaTXG4VvUrS7cCq3L+CeLhPiFx7UA8lGzVGpIbipG5NJeoZIY+N/NDTd
 G5ZYDkGG31A2zb8pif/ZIeIMseYB60xtGQGMnK478ozfAfE0Pc65qSQQc3DvR1tFKllo
 BzSw==
X-Gm-Message-State: APjAAAXAbZnUzbMM+8u20UrwbG+irxMlMwXTPHVXZH3JoAkY7O0vjYT4
 AG4Y+NGYH7M84e1ZtDts9SBFuDZY
X-Google-Smtp-Source: APXvYqxJT2hnjCnK0y2binaiQ5hGaB1YpTPQxxislAp68vH+gunHFDaBLTZuInr1SLscODK9V5sijw==
X-Received: by 2002:a25:868e:: with SMTP id z14mr29423185ybk.413.1580917221229; 
 Wed, 05 Feb 2020 07:40:21 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:20 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 12/15] drm/amdgpu/display: add a late register connector
 callback
Date: Wed,  5 Feb 2020 10:39:57 -0500
Message-Id: <20200205154000.536145-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205154000.536145-1-alexander.deucher@amd.com>
References: <20200205154000.536145-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VG8gaGFuZGxlIGRlYnVnZnMgc2V0dXAgb24gbm9uIERQIE1TVCBjb25uZWN0b3JzLgoKUmV2aWV3
ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpBY2tlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jICB8IDE4ICsrKysrKysrKysrKysr
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
aW5kZXggYWY4MTU1NzA4NTY5Li5iNjE5MDA3OWVkM2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtNDQ4Niw2ICs0NDg2LDE5
IEBAIGFtZGdwdV9kbV9jb25uZWN0b3JfYXRvbWljX2R1cGxpY2F0ZV9zdGF0ZShzdHJ1Y3QgZHJt
X2Nvbm5lY3RvciAqY29ubmVjdG9yKQogCXJldHVybiAmbmV3X3N0YXRlLT5iYXNlOwogfQogCitz
dGF0aWMgaW50CithbWRncHVfZG1fY29ubmVjdG9yX2xhdGVfcmVnaXN0ZXIoc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3RvcikKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYW1k
Z3B1X2RtX2Nvbm5lY3RvciA9CisJCXRvX2FtZGdwdV9kbV9jb25uZWN0b3IoY29ubmVjdG9yKTsK
KworI2lmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQorCWNvbm5lY3Rvcl9kZWJ1Z2ZzX2luaXQo
YW1kZ3B1X2RtX2Nvbm5lY3Rvcik7CisjZW5kaWYKKworCXJldHVybiAwOworfQorCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGRybV9jb25uZWN0b3JfZnVuY3MgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9mdW5j
cyA9IHsKIAkucmVzZXQgPSBhbWRncHVfZG1fY29ubmVjdG9yX2Z1bmNzX3Jlc2V0LAogCS5kZXRl
Y3QgPSBhbWRncHVfZG1fY29ubmVjdG9yX2RldGVjdCwKQEAgLTQ0OTUsNiArNDUwOCw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9mdW5jcyBhbWRncHVfZG1fY29ubmVjdG9y
X2Z1bmNzID0gewogCS5hdG9taWNfZGVzdHJveV9zdGF0ZSA9IGRybV9hdG9taWNfaGVscGVyX2Nv
bm5lY3Rvcl9kZXN0cm95X3N0YXRlLAogCS5hdG9taWNfc2V0X3Byb3BlcnR5ID0gYW1kZ3B1X2Rt
X2Nvbm5lY3Rvcl9hdG9taWNfc2V0X3Byb3BlcnR5LAogCS5hdG9taWNfZ2V0X3Byb3BlcnR5ID0g
YW1kZ3B1X2RtX2Nvbm5lY3Rvcl9hdG9taWNfZ2V0X3Byb3BlcnR5LAorCS5sYXRlX3JlZ2lzdGVy
ID0gYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9sYXRlX3JlZ2lzdGVyLAogCS5lYXJseV91bnJlZ2lzdGVy
ID0gYW1kZ3B1X2RtX2Nvbm5lY3Rvcl91bnJlZ2lzdGVyCiB9OwogCkBAIC01ODM0LDEwICs1ODQ4
LDYgQEAgc3RhdGljIGludCBhbWRncHVfZG1fY29ubmVjdG9yX2luaXQoc3RydWN0IGFtZGdwdV9k
aXNwbGF5X21hbmFnZXIgKmRtLAogCWRybV9jb25uZWN0b3JfYXR0YWNoX2VuY29kZXIoCiAJCSZh
Y29ubmVjdG9yLT5iYXNlLCAmYWVuY29kZXItPmJhc2UpOwogCi0jaWYgZGVmaW5lZChDT05GSUdf
REVCVUdfRlMpCi0JY29ubmVjdG9yX2RlYnVnZnNfaW5pdChhY29ubmVjdG9yKTsKLSNlbmRpZgot
CiAJaWYgKGNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RFX0NPTk5FQ1RPUl9EaXNwbGF5UG9ydAog
CQl8fCBjb25uZWN0b3JfdHlwZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQogCQlhbWRncHVf
ZG1faW5pdGlhbGl6ZV9kcF9jb25uZWN0b3IoZG0sIGFjb25uZWN0b3IpOwotLSAKMi4yNC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
