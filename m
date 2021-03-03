Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4D4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 13:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7A964EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 13:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A964EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EE76E989;
	Wed,  3 Mar 2021 13:52:12 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B756E8DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 13:43:38 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id d15so8497516wrv.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wtdOZUPejXIxG4DafVTSnIWvo2XUWaKv8nLuUC2cuVs=;
 b=UZEv1TixOjptA51Xf0D3ZWP6qBa1BuK4fprFPpRVDcuJ49xPXUPJGp6E+dNYNXVJVb
 +wirSDrdZyG+W4R4vXCa+dP800Du/zenIk68HzB2fuoOISKqgdhiA0Yo9Dw6klTLejAP
 njUqmMMsdKiLqi/ldUnjDL3a/hP1xjda+KEfypBrkeXVvofjvEQ/A/MZ4RtN27PbnryP
 0Fp/Tpi1gfoz7AUMR+Ibx7IharnIQuPfmLONZAFKP0/IGEiKunj9r4odx6NNNPjayLCZ
 JfFU7iUcQlv+uNB5/2b5otcEpP3m/Dd0Eeq1XR9kHdAkIqe8fzQggTMec9s32vZPWYbr
 8Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wtdOZUPejXIxG4DafVTSnIWvo2XUWaKv8nLuUC2cuVs=;
 b=qwjLB7RoNCUUC6utNX+mcQrmwDZMO6/4BaSRVsM/ylXJOseju220C6L53tg233C1jE
 taeZez7xdG4gV7GwYqf5yI7QzeyRPSMlnQjKopl1ZIBW34kxiHoTikltEywSlGsidVo+
 qapxTM0o5AmyZ3tLyC1Rr09qAK0f/44X/Adr+VQb7nYnYFzNUl+mMVOp3SH9awXWe224
 QBstYcw5XRbiQWukJR/IbpB2W7BeFgWqSFG5mM2NPln2M1Kh7JSci/jpY7B409Mt1TKt
 zg/tcgiAsqO1pm7nlF8bVF6X37d+JheQW8Ajlvk4z90op/Y1fxqKNwd9Sr/U4pX+y1gB
 9wZw==
X-Gm-Message-State: AOAM532FPpFQn9jsfCXM0TCCopSxCGJuI5wKdf4dS0voeevYjVP0Ju/D
 2IN+VPBjN9ULFqnP4Z04zUojtA==
X-Google-Smtp-Source: ABdhPJwcK9+jl2BDg1cjYoyYZxUkL7WUrEez2h4jezFZeCdqRD7CYTxftZHx2OfGFGjkntOswUUmDw==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr26589790wrq.136.1614779016850; 
 Wed, 03 Mar 2021 05:43:36 -0800 (PST)
Received: from dell.default ([91.110.221.155])
 by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 05:43:36 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/53] drm/amd/display/dc/bios/command_table: Remove unused
 variable and associated comment
Date: Wed,  3 Mar 2021 13:42:33 +0000
Message-Id: <20210303134319.3160762-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 03 Mar 2021 13:52:11 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGUuYzog
SW4gZnVuY3Rpb24g4oCYYWRqdXN0X2Rpc3BsYXlfcGxsX3Yy4oCZOgogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGUuYzoxNDYyOjExOiB3
YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYcGl4ZWxfY2xvY2tfMTBLSHpfaW7igJkgWy1XdW51
c2VkLXZhcmlhYmxlXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29t
PgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Nv
bW1hbmRfdGFibGUuYyB8IDQgLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90
YWJsZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJs
ZS5jCmluZGV4IDlkM2JjM2EwNzM4MjEuLmU4NzljZWIwYzQ5ZWQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGUuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlLmMKQEAgLTE1MTgs
MTAgKzE1MTgsNiBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgYWRqdXN0X2Rpc3BsYXlfcGxsX3Yy
KAogewogCWVudW0gYnBfcmVzdWx0IHJlc3VsdCA9IEJQX1JFU1VMVF9GQUlMVVJFOwogCi0JLyog
V2UgbmVlZCB0byBjb252ZXJ0IGZyb20gS0h6IHVuaXRzIGludG8gMTBLSHogdW5pdHMgYW5kIHRo
ZW4gY29udmVydAotCSAqIG91dHB1dCBwaXhlbCBjbG9jayBiYWNrIDEwS0h6LS0+S0h6ICovCi0J
dWludDMyX3QgcGl4ZWxfY2xvY2tfMTBLSHpfaW4gPSBicF9wYXJhbXMtPnBpeGVsX2Nsb2NrIC8g
MTA7Ci0KIAlicC0+Y21kX2hlbHBlci0+ZW5jb2Rlcl9pZF90b19hdG9tKAogCQlkYWxfZ3JhcGhp
Y3Nfb2JqZWN0X2lkX2dldF9lbmNvZGVyX2lkKGJwX3BhcmFtcy0+ZW5jb2Rlcl9vYmplY3RfaWQp
KTsKIAlicC0+Y21kX2hlbHBlci0+ZW5jb2Rlcl9tb2RlX2JwX3RvX2F0b20oYnBfcGFyYW1zLT5z
aWduYWxfdHlwZSwgZmFsc2UpOwotLSAKMi4yNy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
