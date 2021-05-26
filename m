Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445DEC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B4760FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B4760FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC596ECFC;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C116E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:55 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id r10so172912wrj.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4jVnFwrLdvYbe+J6fnuiCvB9x4vw8NgmPskUsZo7eXM=;
 b=HNTh7zdUvwEtjEWA62LQCOv5WbZVwfiFak+3qFdaky7HvKVpVvwY4opo1mlTiR/meN
 WP6x3hiWK3l/gA1WqdHuuXaoJZZPW/6FNAur7QJr5Dy+04ye7p4buPeL+pvqMMBriARj
 arf+UEDOVQTSXNCioRBw3xKVZE2ClviZA+yuMCNkXKULUH3AaKGKpUahBxLV3HHyuJQS
 NljYpyEQQmc6uP/gq9zUSEaqvwrK776TkKxHAC9XDGl1IMaWrCxsCSGSTmD4gBYL4pD8
 qr7KJhvkL0jsF8keu21jzl+o4JSzogjgYcXzffE2KH4dt10f7dRqJueXo8n9tO7sBzU2
 UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4jVnFwrLdvYbe+J6fnuiCvB9x4vw8NgmPskUsZo7eXM=;
 b=XhnXHve+g8koMTZVtPZXKJCMKah/m6tkVdpyzn841MTvA0t7fpEnUjfeWV+alO/p2w
 7Jh4Id3Z0Kwf3ETdyguGnyy3jKm9mCokcn6poOuW04Q/KsPGsrQDyrN5wNqRgXj9gYvU
 4ZuwFSdoPl+B7U/LHPXB3XZESeOUf2Zo5446tJLV05fNjwCC6RhwduU0B9Lm65IHi8KO
 Sfg5oyBrjgVE8tKF0g0+AUzdhNviIX3aKF+hw6pzbB8A21LLsGH+AuMxSmzX0kzWL6FO
 iLnHMbZdea+1BSLza9rNbjX0BkYvJnTB8x4zbtDLYcb9ypNKG5cwAgiNhwpxnY+m3C/x
 5Zrw==
X-Gm-Message-State: AOAM531oZ2EYI4p5HX6eNNF49QcghXpzP/+GTsxz5gWGHhdDFA4K5wNd
 oiO2FHKP1/5dsyOdQOQy6zk3Eg==
X-Google-Smtp-Source: ABdhPJy3fD/qyOe5xh29n4/y0jvix0HVQE48nrimbqrGSprkCLU68dwAISlYsNwaN55GcVMxHjfWVg==
X-Received: by 2002:a05:6000:104a:: with SMTP id
 c10mr31722911wrx.45.1622018874571; 
 Wed, 26 May 2021 01:47:54 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:54 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 23/34] drm/amd/display/dmub/src/dmub_srv_stat: Convert
 function header to kernel-doc
Date: Wed, 26 May 2021 09:47:15 +0100
Message-Id: <20210526084726.552052-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydl9zdGF0LmM6
Mzg6IHdhcm5pbmc6IENhbm5vdCB1bmRlcnN0YW5kICAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgoKQ2M6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5w
ZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IEp1biBMZWkgPEp1bi5MZWlAYW1kLmNvbT4KQ2M6IE1lZW5ha3NoaWt1
bWFyIFNvbWFzdW5kYXJhbSA8bWVlbmFrc2hpa3VtYXIuc29tYXN1bmRhcmFtQGFtZC5jb20+CkNj
OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+CkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIC4u
Li9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9zcnZfc3RhdC5jICB8IDE5ICsrKysrKy0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9k
bXViX3Nydl9zdGF0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11
Yl9zcnZfc3RhdC5jCmluZGV4IGU2ZjNiZmFiMzNkM2UuLjcwNzY2ZDUzNGM5YzggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydl9zdGF0LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2X3N0YXQu
YwpAQCAtMzUsMjAgKzM1LDEzIEBACiAgKi8KIAogLyoqCi0gKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioK
LSAqICBGdW5jdGlvbjogZG11Yl9zcnZfc3RhdF9nZXRfbm90aWZpY2F0aW9uCisgKiBkbXViX3Ny
dl9zdGF0X2dldF9ub3RpZmljYXRpb24gLSBSZXRyaWV2ZXMgYSBkbXViIG91dGJveCBub3RpZmlj
YXRpb24sIHNldCB1cCBkbXViIG5vdGlmaWNhdGlvbgorICogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0dXJlIHdpdGggbWVzc2FnZSBpbmZvcm1hdGlvbi4gQWxzbyBhIHBl
bmRpbmcgYml0IGlmIHF1ZXVlCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
cyBoYXZpbmcgbW9yZSBub3RpZmljYXRpb25zCisgKiAgQGRtdWI6IGRtdWIgc3J2IHN0cnVjdHVy
ZQorICogIEBub3RpZnk6IGRtdWIgbm90aWZpY2F0aW9uIHN0cnVjdHVyZSB0byBiZSBmaWxsZWQg
dXAKICAqCi0gKiAgQGJyaWVmCi0gKgkJUmV0cmlldmVzIGEgZG11YiBvdXRib3ggbm90aWZpY2F0
aW9uLCBzZXQgdXAgZG11YiBub3RpZmljYXRpb24KLSAqCQlzdHJ1Y3R1cmUgd2l0aCBtZXNzYWdl
IGluZm9ybWF0aW9uLiBBbHNvIGEgcGVuZGluZyBiaXQgaWYgcXVldWUKLSAqCQlpcyBoYXZpbmcg
bW9yZSBub3RpZmljYXRpb25zCi0gKgotICogIEBwYXJhbSBbaW5dIGRtdWI6IGRtdWIgc3J2IHN0
cnVjdHVyZQotICogIEBwYXJhbSBbb3V0XSBwbm90aWZ5OiBkbXViIG5vdGlmaWNhdGlvbiBzdHJ1
Y3R1cmUgdG8gYmUgZmlsbGVkIHVwCi0gKgotICogIEByZXR1cm4KLSAqICAgICBkbXViX3N0YXR1
cwotICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqCisgKiAgUmV0dXJuczogZG11Yl9zdGF0dXMKICAqLwog
ZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl9zdGF0X2dldF9ub3RpZmljYXRpb24oc3RydWN0IGRt
dWJfc3J2ICpkbXViLAogCQkJCQkJc3RydWN0IGRtdWJfbm90aWZpY2F0aW9uICpub3RpZnkpCi0t
IAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
