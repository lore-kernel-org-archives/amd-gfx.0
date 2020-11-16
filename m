Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D771AC64E7C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C232225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnwVbJwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C232225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AFA6EA38;
	Mon, 16 Nov 2020 19:18:19 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBED26E04E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:25 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id p1so19598836wrf.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y2n5EAuxxaWf0Dm92MV4U7zHBQN4uYE06MkP3Ik/k8Q=;
 b=BnwVbJwRHIrWiSelgE8VUORGPDGET5j5wYZz3HQcFJYdlMvspKOuspFebmEah8Hjz6
 gr31bK0POXAE4z3LwjHafVrjp8+fYHxVWnm2p9z34efZ830IGvN9jlKtUbJcGYdha7En
 xZXaENA81gYhIFOEhMERcLgH3znBEyebE00yYVb1zJ6NnnNzRoWmik/7PBmcPfB1TaGn
 8j+nSptwK8yJ904NRY4L9MeSNKIm0mEVS8vfrkxgDP6BDDczdt9JbFF4myk3nh9Rh79S
 H+8NNQZYtlq81stY+zFgFh3rmhvPAnYDZ93qgC1jbZDxICbEWjNQbSlwg0FLj0ak9QwW
 iK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y2n5EAuxxaWf0Dm92MV4U7zHBQN4uYE06MkP3Ik/k8Q=;
 b=dkZ3rUs8/vprSnBGGpb+AU+aJEfw4ec3yFvGyDl+h5/xcO2Jw2D6kutyRBLDG8EHTL
 DSRaJcn1879ZrzKyNJQeXyrG+xru8cbJkmGKjZfXoJYXkx0mZEwB+J19RoaELZaJsRJp
 OW07JJumMqDvisABN6mhCtIdzTfoq+KGh1a0JAn6plVJPlT89VIwI3pqcKdBJo9NpkSe
 DfvKjjk87ijoBjdARbxeEqHxf8pgjuAf+9xvjJkvkfBq3cxWtLvcdFBZ2R+uNF0UbFC3
 vnpzGqnLLeez7WS2JGIH/MWxGlfsxpJA05qmCk/hESNxk0DcM1q63wTRk4cFF37x1qYO
 A7rg==
X-Gm-Message-State: AOAM533mHtQfgCCilAIvCDsH8EHe31zXdfNr69OKKURxDQG8/3VPMsmG
 1K/6pka8oQyS5XzbABgSG7GCcA==
X-Google-Smtp-Source: ABdhPJxvANXM3aKchSP4W3dRVCrfAA1T8q3gatRW71Sh24RLgAx9VaHVKFdu4fZkQBtH1WN6XZq8UA==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr20526445wru.49.1605548244607; 
 Mon, 16 Nov 2020 09:37:24 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:24 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/43] drm/radeon/atom: Move 'radeon_atom_hw_i2c_*()'s
 prototypes into shared header
Date: Mon, 16 Nov 2020 17:36:32 +0000
Message-Id: <20201116173700.1830487-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19pMmMuYzoxMDA6NTogd2FybmluZzogbm8gcHJldmlv
dXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fYXRvbV9od19pMmNfeGZlcuKAmSBbLVdtaXNzaW5n
LXByb3RvdHlwZXNdCiAxMDAgfCBpbnQgcmFkZW9uX2F0b21faHdfaTJjX3hmZXIoc3RydWN0IGky
Y19hZGFwdGVyICppMmNfYWRhcCwKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vYXRvbWJpb3NfaTJjLmM6MTUwOjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2F0b21faHdfaTJjX2Z1bmPigJkgWy1XbWlzc2luZy1w
cm90b3R5cGVzXQogMTUwIHwgdTMyIHJhZGVvbl9hdG9tX2h3X2kyY19mdW5jKHN0cnVjdCBpMmNf
YWRhcHRlciAqYWRhcCkKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9hdG9tLmggICAgICAgfCA3ICsrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2kyYy5jIHwgNCAtLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2F0b20uaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbS5oCmluZGV4IDFiZjA2YzkxY2Q5
NTkuLjVkZTA1NjNiNjNkMmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRv
bS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbS5oCkBAIC0xNTQsNiArMTU0LDEz
IEBAIGJvb2wgYXRvbV9wYXJzZV9kYXRhX2hlYWRlcihzdHJ1Y3QgYXRvbV9jb250ZXh0ICpjdHgs
IGludCBpbmRleCwgdWludDE2X3QgKnNpemUsCiBib29sIGF0b21fcGFyc2VfY21kX2hlYWRlcihz
dHJ1Y3QgYXRvbV9jb250ZXh0ICpjdHgsIGludCBpbmRleCwKIAkJCSAgIHVpbnQ4X3QgKmZyZXYs
IHVpbnQ4X3QgKmNyZXYpOwogaW50IGF0b21fYWxsb2NhdGVfZmJfc2NyYXRjaChzdHJ1Y3QgYXRv
bV9jb250ZXh0ICpjdHgpOworCitzdHJ1Y3QgaTJjX21zZzsKK3N0cnVjdCBpMmNfYWRhcHRlcjsK
K2ludCByYWRlb25fYXRvbV9od19pMmNfeGZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmkyY19hZGFw
LAorCQkJICAgIHN0cnVjdCBpMmNfbXNnICptc2dzLCBpbnQgbnVtKTsKK3UzMiByYWRlb25fYXRv
bV9od19pMmNfZnVuYyhzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXApOworCiAjaW5jbHVkZSAiYXRv
bS10eXBlcy5oIgogI2luY2x1ZGUgImF0b21iaW9zLmgiCiAjaW5jbHVkZSAiT2JqZWN0SUQuaCIK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2kyYy5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faTJjLmMKaW5kZXggYWE2MWIzY2I0MDQ5Yy4uZTU0M2Q5
OTNmNzNlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faTJjLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faTJjLmMKQEAgLTM0LDEwICszNCw2
IEBACiAjaW5jbHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAiYXRvbS5oIgogCi1leHRlcm4gaW50
IHJhZGVvbl9hdG9tX2h3X2kyY194ZmVyKHN0cnVjdCBpMmNfYWRhcHRlciAqaTJjX2FkYXAsCi0J
CQkJICAgc3RydWN0IGkyY19tc2cgKm1zZ3MsIGludCBudW0pOwotZXh0ZXJuIHUzMiByYWRlb25f
YXRvbV9od19pMmNfZnVuYyhzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXApOwotCiBib29sIHJhZGVv
bl9kZGNfcHJvYmUoc3RydWN0IHJhZGVvbl9jb25uZWN0b3IgKnJhZGVvbl9jb25uZWN0b3IsIGJv
b2wgdXNlX2F1eCkKIHsKIAl1OCBvdXQgPSAweDA7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
