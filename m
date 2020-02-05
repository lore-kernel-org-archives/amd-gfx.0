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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF5C3F68F
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBA120730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfBXGEUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBA120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56676F612;
	Wed,  5 Feb 2020 15:40:21 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CE26F612;
 Wed,  5 Feb 2020 15:40:20 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id t141so2671904ywc.11;
 Wed, 05 Feb 2020 07:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4p9znhhB5vE3fVJEzAq+piHOIAc6BksjmnQcQMYSiD4=;
 b=IfBXGEUXp2lvRYs1SkeXpykPkiutBaGl9s0TFAU43GLO+gE2+lmKenzeAd0K/OlruC
 xTC3DvdI7vzHuTZbimKryvhfxf5HGZtxMdYZM8c9isde7DRpRhOf+IHhs245/ZuJ+o4S
 blCB419/qfqrasrEIo6CwTcdIdSELpiRgCqjLyaUcO9e3uP+KQA/tldFe9KbD1FLjDDX
 Q6eK8pImTB2ET7OqxVK+e6yLjjNVYDs9TCO+to1smHQFYTJ490ZeVjdND6io0SDQtfJZ
 tti4Gc6fzAFinKQBSOQN0lD1Y6ILxrIhayoBjOLd69E1dZ7RgzBAcioZSxP2zfMBFyk7
 2T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4p9znhhB5vE3fVJEzAq+piHOIAc6BksjmnQcQMYSiD4=;
 b=Bks+Mp2fvcguxu2H/HCGkT8B3cg6J2gaP6bCgy8ZmcjkIg30Lp2Kq7qbjyMnhh9wsC
 CzBdfZRUDy76/tfMWGbu7tX+r8foeA9PZLq2HTTGtcubIU2XI+tLh0hdnQu/ZlZkYhYD
 B/g4X6EA2SlE7tqbIjVvs01tr0FyLZPNokdUSx4B7v5faY29hfLrQOJKyVAUq2hmJtQF
 6ypEV2dJgeHBiErDdltAP7yoYbLq9AQw4VHqeJ6hCFcO46xt2rD+aCba+9I4pCqnEDam
 on4UnAEODa/cPhwgaIIT29Od816tbASa96GPMGTECOnzeqrdZbzBRM4EnQeXgSpzLHZc
 6IDw==
X-Gm-Message-State: APjAAAXWG/LXb5GKE/OakeA9+xMgsCBIMTLpBwtrF5z/FuqNT1j17E41
 ZD6fqNobdwYVnchRJHbquv44lUAT
X-Google-Smtp-Source: APXvYqxamsgv+VcMAsj8GCx4BDfX31ChXSBAbgXpvtn8GfMmr7IkKaIrDZCYiVHrfJROvf2tkg8FXQ==
X-Received: by 2002:a5b:ac9:: with SMTP id a9mr28450299ybr.307.1580917219147; 
 Wed, 05 Feb 2020 07:40:19 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:18 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 10/15] drm/amdgpu/display: move debugfs init into core amdgpu
 debugfs
Date: Wed,  5 Feb 2020 10:39:55 -0500
Message-Id: <20200205154000.536145-11-alexander.deucher@amd.com>
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

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgZGlzcGxheS4KClJldmlld2VkLWJ5OiBI
YXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgICAgICAgfCA2ICsrKysrKwogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDUgLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IDViZjQzZjIwZWMzMC4uODJkMzBi
YWUyYmEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVi
dWdmcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMK
QEAgLTMyLDYgKzMyLDcgQEAKIAogI2luY2x1ZGUgImFtZGdwdS5oIgogI2luY2x1ZGUgImFtZGdw
dV9wbS5oIgorI2luY2x1ZGUgImFtZGdwdV9kbV9kZWJ1Z2ZzLmgiCiAKIC8qKgogICogYW1kZ3B1
X2RlYnVnZnNfYWRkX2ZpbGVzIC0gQWRkIHNpbXBsZSBkZWJ1Z2ZzIGVudHJpZXMKQEAgLTEyNjAs
NiArMTI2MSwxMSBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBmaXJtd2FyZSBkZWJ1
Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7CiAKKwlpZiAoYW1kZ3B1X2RldmljZV9oYXNfZGNfc3Vw
cG9ydChhZGV2KSkgeworCQlpZiAoZHRuX2RlYnVnZnNfaW5pdChhZGV2KSkKKwkJCURSTV9FUlJP
UigiYW1kZ3B1OiBmYWlsZWQgaW5pdGlhbGl6ZSBkdG4gZGVidWdmcyBzdXBwb3J0LlxuIik7CisJ
fQorCiAJcmV0dXJuIGFtZGdwdV9kZWJ1Z2ZzX2FkZF9maWxlcyhhZGV2LCBhbWRncHVfZGVidWdm
c19saXN0LAogCQkJCQlBUlJBWV9TSVpFKGFtZGdwdV9kZWJ1Z2ZzX2xpc3QpKTsKIH0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4
IDUwMTM3ZGY5Y2RhZC4uODFjOGQ4YzYxZDYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTk5MSwxMSArOTkxLDYgQEAgc3Rh
dGljIGludCBhbWRncHVfZG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJZ290
byBlcnJvcjsKIAl9CiAKLSNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykKLQlpZiAoZHRuX2Rl
YnVnZnNfaW5pdChhZGV2KSkKLQkJRFJNX0VSUk9SKCJhbWRncHU6IGZhaWxlZCBpbml0aWFsaXpl
IGR0biBkZWJ1Z2ZzIHN1cHBvcnQuXG4iKTsKLSNlbmRpZgotCiAJRFJNX0RFQlVHX0RSSVZFUigi
S01TIGluaXRpYWxpemVkLlxuIik7CiAKIAlyZXR1cm4gMDsKLS0gCjIuMjQuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
