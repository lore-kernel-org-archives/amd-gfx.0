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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E011C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D1220730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/ixeOT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D1220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EC289CCB;
	Wed,  5 Feb 2020 15:40:16 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B1689E35;
 Wed,  5 Feb 2020 15:40:15 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id l5so2751271ywd.4;
 Wed, 05 Feb 2020 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2OA8lB2OrGh8nJkA0X7sKAlsz1UEuNurcUSKsfyXOw8=;
 b=f/ixeOT6fnzJFPCmD2pJnSq0PAib1LY0yliODigYy6EvY2/vTZ3cf9c0TKTnBoajSj
 iWZhzfsRaJ8iBEelVMSEUlMMQQ/BJmlsi6xLZh3TLGwmpT06ybZTCAUviLa1q1yqG14M
 oYHQQ/j9fxwm4oO/LVdQv1CoUh7COvpMvQXj5rGHLN7B9n88TR3KcaG7N6uNuL2LSqUR
 xdjTq/k+FX+y4fsiXIQIVvGf0SbjQcDZmDJ2d0Siy1LPsh0KAsP2mQu0kr3IWp3aJh9z
 gfPfCIibNs69/U79KCi7keEQxG6y8FolyXzXQg9EXNwHMDSyeJ5UC9E2RgGkHm6B4LC2
 6IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2OA8lB2OrGh8nJkA0X7sKAlsz1UEuNurcUSKsfyXOw8=;
 b=YSq6zFw6tXE2OQ5vF3fYRLkQ26sTlOgYAhN+E8fI9u+zaeoC8moKKNfeetCOr16ygU
 tfth0gMNn+2cxrsc0FB9UwKYl6Q/+ygdK+x4aUdcteNFmCfsdR8UdarDVTIV7gtMbUSf
 rmO11CpCop/1zggmx26zG5AzzLvuRL2wAhSKJYNl6krC8awhCrJcAW9AiQqc11UZTxeZ
 hLtPcFU0+Hqo/33Cbx4Cc8+2YobXeqMnbXOpO/YfJ2KuvIQlbRrf43LgODM7tdsLvCmr
 SGs8zhwC9J8HRrlmv2dbL0RuKLJL4elarBqWnWk9TMnsV0RYEqWhFRhkYUHu2q/XiA/n
 h24g==
X-Gm-Message-State: APjAAAVCU0jkKgnazN2AuloTCwtoL9H3/D6Hea6QUYQalVlx7+VBiWqH
 DpPjXaXMduz+UYkR1ZCpCLKH3B4I
X-Google-Smtp-Source: APXvYqzNPGWqXj/B4XVQY8UcxPVqUcF17G3wP9DtZ6QwOh44gN4xrGxBE0em2p9IOAIGuNU8vwR+wA==
X-Received: by 2002:a25:868e:: with SMTP id z14mr29422720ybk.413.1580917214634; 
 Wed, 05 Feb 2020 07:40:14 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 06/15] drm/amdgpu/gem: move debugfs init into core amdgpu
 debugfs
Date: Wed,  5 Feb 2020 10:39:51 -0500
Message-Id: <20200205154000.536145-7-alexander.deucher@amd.com>
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
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgZ2VtLgoKQWNrZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAgfCA0IC0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGVidWdmcy5jCmluZGV4IGJjZDEwZGFhNmUzOS4uY2I3ZGI3ZWRmYzNmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKQEAgLTEyNDgsNiArMTI0
OCwxMCBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAlpZiAoYW1kZ3B1X2RlYnVnZnNfZmVuY2VfaW5pdChhZGV2KSkKIAkJZGV2X2VycihhZGV2
LT5kZXYsICJmZW5jZSBkZWJ1Z2ZzIGZpbGUgY3JlYXRpb24gZmFpbGVkXG4iKTsKIAorCXIgPSBh
bWRncHVfZGVidWdmc19nZW1faW5pdChhZGV2KTsKKwlpZiAocikKKwkJRFJNX0VSUk9SKCJyZWdp
c3RlcmluZyBnZW0gZGVidWdmcyBmYWlsZWQgKCVkKS5cbiIsIHIpOworCiAJcmV0dXJuIGFtZGdw
dV9kZWJ1Z2ZzX2FkZF9maWxlcyhhZGV2LCBhbWRncHVfZGVidWdmc19saXN0LAogCQkJCQlBUlJB
WV9TSVpFKGFtZGdwdV9kZWJ1Z2ZzX2xpc3QpKTsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCAzYjA5ODk3ZWIxZTkuLjY0YTI3NTY2NGM3MiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzA5MSwxMCAr
MzA5MSw2IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCiAJfSBlbHNlCiAJCWFkZXYtPnVjb2RlX3N5c2ZzX2VuID0gdHJ1ZTsKIAotCXIgPSBhbWRn
cHVfZGVidWdmc19nZW1faW5pdChhZGV2KTsKLQlpZiAocikKLQkJRFJNX0VSUk9SKCJyZWdpc3Rl
cmluZyBnZW0gZGVidWdmcyBmYWlsZWQgKCVkKS5cbiIsIHIpOwotCiAJciA9IGFtZGdwdV9kZWJ1
Z2ZzX3JlZ3NfaW5pdChhZGV2KTsKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBy
ZWdpc3RlciBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0tIAoyLjI0LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
