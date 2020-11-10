Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB5C56202
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7475320665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMF+3pG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7475320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D29389CA4;
	Tue, 10 Nov 2020 19:35:52 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349E989BD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:19 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p22so4335752wmg.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C+zBR+LtvSmQF6WK85h0NeZVtoTEWkwyfZr5+ZdAWFg=;
 b=tMF+3pG5AXC3vlK8/vqtMujSz3Ljj+0p0heESDtpmL4we/th6iHGh+8nFxtYussM0a
 bMz4xEQZrR9KqTeE5hNq4bcSASyfm9uV4r+G23Av61RM+6SOH6NnB1Ynyq+Xs/TMfwpP
 WYnsHEtHkeSxZHAqsaWMDvHEkiDyYfdZD4ckndsph6cVHgRSb5Di9q3kfRjfy4Qf9qSm
 S1Z7kx0IqXLikmDSocmxhrrCXxtVPuqbtPgiLglKGcXr3YDrt1aGKXNzHSCwyzgE9ZN5
 jtMiGwewAgwbjqbxNG4AdtVdOklXLu36yfH1kB3UQxNm8ywdFzklqlvYLJttGr9JN7N6
 HQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C+zBR+LtvSmQF6WK85h0NeZVtoTEWkwyfZr5+ZdAWFg=;
 b=IwlLNAm+7+dF0ec14V7rKw+2HZZaWqEkuK1mJcZkYyVu5sNrj3fmo6a5694y3XO6yH
 9jd+Qk4e542/lm/fEXLxx8fY86ySIYCYev8YTiDu38YWOKs+0mkEmuUAjZ1MX7sHK22l
 JfKJB6ugZy1OFim/SRoT2NPbpn81bKnceaMMKKQz/AhE0xsVQTT2ncyXGeDb4pGAgZ+y
 7dTiIQ2v6zPw8eL5+1AR4lmYxn/xeeievNci4wvU65JTPhBDNdvpWziAiGHXuEGHA6XT
 pqXXBenklNT8vcA+h8YkjSAAJCiyoDRyfR9ZdLBEayulIF3U4XDIJzw8snnbCAWwrUII
 Jykg==
X-Gm-Message-State: AOAM5339w4XbNrVUb7jWoiNs5AbwIuWcrDnm043f1NIXdjtAtCycKRe0
 cZU+zMeD6ZlA11/3BK5lX8WaWg==
X-Google-Smtp-Source: ABdhPJweRmEkGhTCPihLk1lOn7tT5/NJE06idgEUjsbpo9M/smhM1lSR8C+7+QrbEbuwYgd5fw7Tgg==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr726295wmb.162.1605036677804; 
 Tue, 10 Nov 2020 11:31:17 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/30] drm/radeon/evergreen: Add comment for
 'evergreen_page_flip()'s 'async' param
Date: Tue, 10 Nov 2020 19:30:43 +0000
Message-Id: <20201110193112.988999-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYzogSW4gZnVuY3Rpb24g4oCYZXZlcmdyZWVuX2dw
dV9pbml04oCZOgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYzoxNDE5OiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhc3luYycgbm90IGRlc2NyaWJlZCBp
biAnZXZlcmdyZWVuX3BhZ2VfZmxpcCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVy
Z3JlZW4uYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vZXZlcmdyZWVuLmMKaW5kZXggNGViM2Y5YmM4ZmE4Yi4uYzlhOWE4Nzk1OWY5ZSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5jCkBAIC0xNDEyLDYgKzE0MTIsNyBAQCB2b2lkIGRj
ZTRfd2FpdF9mb3JfdmJsYW5rKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgY3J0YykK
ICAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50ZXIKICAqIEBjcnRjX2lkOiBjcnRjIHRvIGNs
ZWFudXAgcGFnZWZsaXAgb24KICAqIEBjcnRjX2Jhc2U6IG5ldyBhZGRyZXNzIG9mIHRoZSBjcnRj
IChHUFUgTUMgYWRkcmVzcykKKyAqIEBhc3luYzogU2V0IHJldHJhY2UKICAqCiAgKiBUcmlnZ2Vy
cyB0aGUgYWN0dWFsIHBhZ2VmbGlwIGJ5IHVwZGF0aW5nIHRoZSBwcmltYXJ5CiAgKiBzdXJmYWNl
IGJhc2UgYWRkcmVzcyAoZXZlcmdyZWVuKykuCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
