Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB3DC352A2
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5564E20730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECfgHskL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5564E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D56E6F615;
	Wed,  5 Feb 2020 15:40:21 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4627A6F615;
 Wed,  5 Feb 2020 15:40:19 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id f204so2687042ywc.10;
 Wed, 05 Feb 2020 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aG4tWD4Bf63nrdqVyzzXgsS9Nnk8tFLF0JhSz+Or+5U=;
 b=ECfgHskLmaXsNYSv+MjjVFTRpOlgi/ojYPNEnX2SIxhw6y09JOspu2C29YeLlvR6++
 2oJA6vFQcDPR9dzQV3Do4GS1LBLqpdZZBOpCHoxO/K7/OIePub2JAt/N9BV6lIjV1Y6B
 CnTpIOC2SFz3g+ma0V8MUMRUQKJdEtgDzgCVnY8GR37iow27nRluTl8vsqdv8OGNxIWv
 d3yMvIYXmVI2nVE5GzpdZsGKICUDhxxt2RSYnmNX6OGstaJfJnn1N3Iosv7LMMDLd+tN
 X1ZcWORfsVLRpAd23SFvm8Q7Ydn7PcDR0lS3kYoe6BauzGsI6irp3s5zWbWciIbcwiNi
 /cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aG4tWD4Bf63nrdqVyzzXgsS9Nnk8tFLF0JhSz+Or+5U=;
 b=nkYmZQTR3LZAh261nsEUaHVj7fG3jcfEnftp8V9IYygEfAcjkk9MsI6Veww0cry9y+
 2xp5S96njH6xw2ZAX+fdI+729cJqUK2qslr4zumi4UZsuJ9qBvWar1kwZi1sDu2VKPoX
 zx59GD7mDO9lhmt7kKcwM0WG5QEsdNmg+ek2TVw8FX3/Xz2UyfCeAPhWiP/gJfoL1wxO
 Jq6nzbFmG86L4OV5HIIT1kes6uPGru0Lm6ES7lydHUpmoAPXpesOfJFdQHOvFFDMzaRc
 dTANntNITSngsjW8uqMDPK1s2XCGVPizqz3TlHZn6MczNtqHQRnf0lNM04ybmdpTCH+R
 0GKw==
X-Gm-Message-State: APjAAAVdk4fl/Q0lFWesqJGKuHjshCrbl6bIRMcWt9psi5aGEUfjKoSX
 vZZSJ4t3IxLOzDstHkRYyvFM1PeP
X-Google-Smtp-Source: APXvYqw1RdLUprCAgQ+o5Tdwr6daV+5bxevxjuBibiJArC6L8VRXJ010+Bc+tQfMEaNf9VXCICmXWA==
X-Received: by 2002:a81:30a:: with SMTP id 10mr10591751ywd.162.1580917216860; 
 Wed, 05 Feb 2020 07:40:16 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 08/15] drm/amdgpu/firmware: move debugfs init into core amdgpu
 debugfs
Date: Wed,  5 Feb 2020 10:39:53 -0500
Message-Id: <20200205154000.536145-9-alexander.deucher@amd.com>
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgZmlybXdhcmUuCgpBY2tlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDQgKysrKwogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICB8IDQgLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKaW5kZXggNzcyMWYxNDE2Y2RiLi41YmY0M2YyMGVjMzAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwpAQCAtMTI1Niw2
ICsxMjU2LDEwIEBAIGludCBhbWRncHVfZGVidWdmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCWlmIChyKQogCQlEUk1fRVJST1IoInJlZ2lzdGVyaW5nIHJlZ2lzdGVyIGRlYnVn
ZnMgZmFpbGVkICglZCkuXG4iLCByKTsKIAorCXIgPSBhbWRncHVfZGVidWdmc19maXJtd2FyZV9p
bml0KGFkZXYpOworCWlmIChyKQorCQlEUk1fRVJST1IoInJlZ2lzdGVyaW5nIGZpcm13YXJlIGRl
YnVnZnMgZmFpbGVkICglZCkuXG4iLCByKTsKKwogCXJldHVybiBhbWRncHVfZGVidWdmc19hZGRf
ZmlsZXMoYWRldiwgYW1kZ3B1X2RlYnVnZnNfbGlzdCwKIAkJCQkJQVJSQVlfU0laRShhbWRncHVf
ZGVidWdmc19saXN0KSk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKaW5kZXggZDg0YTYxZTE4YmY4Li40ZGM3MTQ1MzY4ZmMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTMwOTEsMTAgKzMwOTEsNiBAQCBpbnQg
YW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCX0gZWxzZQog
CQlhZGV2LT51Y29kZV9zeXNmc19lbiA9IHRydWU7CiAKLQlyID0gYW1kZ3B1X2RlYnVnZnNfZmly
bXdhcmVfaW5pdChhZGV2KTsKLQlpZiAocikKLQkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBmaXJt
d2FyZSBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0KIAlyID0gYW1kZ3B1X2RlYnVnZnNf
aW5pdChhZGV2KTsKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJDcmVhdGluZyBkZWJ1Z2ZzIGZpbGVz
IGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0tIAoyLjI0LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
