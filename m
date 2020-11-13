Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA772C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA7220715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tq3YEaY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA7220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC416E570;
	Fri, 13 Nov 2020 14:28:20 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0F26E4EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:09 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id h62so8559385wme.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XGQ7i9boPClQe1oyR8utsPB6lLJWRf0r7to87NlJAVY=;
 b=tq3YEaY/3TDVCn8qdDXnhOaaOrrxOH5BxxOKr+wdKm7kChxUnNxuggo9rpj/reOkjV
 y2Vq9KREeLPXJ2WPiKYB3kyRIdXpbfStNqg8NRiCJGsQPIv4MByCZaHm49tkAMEe2wBs
 cfNqUTziP7ShG4PEJp8SzklYk/xeH3dDelLf/Wx2lp+x31i3n0JZoW9dx2eYNwmEwAKm
 RnODfEx3Pa5h79269T7DHlX6YJwhZRbTZBp1deopMe5/QXVB7d6soWsuO75rkZsRYhPk
 kqtEpTC9r9eMqE13Rg74gHGz0LWVhWtVR/MoppqMCXKEF4pTzRd7lbijMk2oOz7YZdp7
 hjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XGQ7i9boPClQe1oyR8utsPB6lLJWRf0r7to87NlJAVY=;
 b=nkw3USECn9vMh9SDDj37WQUkHqngiKhJmoEzOZh7E/OMeJCS/AFF8muY8Ib/F6XIW4
 OrO8O2u6sFIAfUJJXvKV7AFJMvmZGne6ASsb+tc70dM2mylrP1PCTeVgRuD+NgOe9CEM
 MooPBw+jWQlG0kcTeSbZAzfJ8S2HMlucpXqIBbK5j4B7Ub6RpJe1bfUOi/gvtxjJkkeq
 wHeRA0Znkex38EK81QuVK9ERXKHUSynigQrsXsewSQc27wc1qeB3Gy+DdW9fiYCkyhQ4
 4nRaNO52NGuKdaAnElzLNF7pkTq5pr1BxSF+wJw2KbneZVxYKH0xi5o8Dm6sPnsfL8KC
 S6Zg==
X-Gm-Message-State: AOAM5302PYEMmf79gDmWSKE3pLKC+gv44sptlGTtvUit++/hwPAmU2A6
 z6HXDv0AC4YoIOTGWBzOFWZdjQ==
X-Google-Smtp-Source: ABdhPJwD0bDR7huq2ppkbFkSvCBisuFBCTTr0W+eZnfRWOkea8mefvO6GAjT1RzC0ZQfM0qVBMnLmw==
X-Received: by 2002:a1c:bb02:: with SMTP id l2mr2555867wmf.166.1605275407774; 
 Fri, 13 Nov 2020 05:50:07 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:07 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 21/40] drm/amd/amdgpu/amdgpu_virt: Make local function
 'amdgpu_virt_update_vf2pf_work_item()' static
Date: Fri, 13 Nov 2020 13:49:19 +0000
Message-Id: <20201113134938.4004947-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYzo1NjA6Njogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhhbWRncHVfdmlydF91cGRhdGVfdmYycGZfd29ya19pdGVt
4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZpcnQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92aXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCmlu
ZGV4IDhhZmY2ZWY1MGY5MTguLjkwNWI4NTM5MWU2NGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZpcnQuYwpAQCAtNTU3LDcgKzU1Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3ZpcnRfd3JpdGVfdmYycGZfZGF0YShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlyZXR1
cm4gMDsKIH0KIAotdm9pZCBhbWRncHVfdmlydF91cGRhdGVfdmYycGZfd29ya19pdGVtKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykKK3N0YXRpYyB2b2lkIGFtZGdwdV92aXJ0X3VwZGF0ZV92ZjJw
Zl93b3JrX2l0ZW0oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogewogCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBhbWRncHVfZGV2aWNlLCB2
aXJ0LnZmMnBmX3dvcmsud29yayk7CiAKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
