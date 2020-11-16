Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F56C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D41B2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlJq01yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D41B2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369326E0CD;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B2089FA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:30:15 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id r17so19637194wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
 b=NlJq01yN62/e77yfB6ZomE53I8U56CttbAyj4clNq3rSMAmYjlSxdP0xAxdwITbYtW
 sNZ+AOXxf/dARjEuzp8azDZAHdjkgVt3bgmqM8kJb93CiPxgqwvl/zDtxvtZ3Nazf1xH
 u9C2opkk5AwyxzR1/c+HIM70U3y0+DMvcTOR3Ks+QceLv/sm37rlMYYDvKervOmliQyA
 UfA4WtUViRXgfqDRp0doP55lKhCFdsD8+fuQo7Whu60IdoD9P0nAGZkFxZjZawoE2go3
 wy7km/HXTpoxfzK7EE3prhyBihjsz+RHRU9qKmVPPhCHynV3oXCsokAfORHJ/A0SM0DI
 9B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
 b=qN1PQFJrMMOm+LNCoYHyxa6P0yfEFBx1hHH69apX5E9oiAwQB8ISktZzd4mcBsWd+H
 4+36I8Ncwy0sHz1VXTsluvGsvNnk15JpG5R+1R2+xqOJzf7PyojnTNyCbmKV7AiB3kOe
 PbeqNnAGm8X7F0gIbkaqe8CAsfRToC5clTl+9chaCRC+rEOqBoxIx6/u76oMviQMPToJ
 rzfeyMuvuQrxLk8ZGU5wRq+cO5raq4ju3+1mM2EU+OcpjHFn5XkBOZ8jJ1m/kCtDPtl6
 olcSUFpvYnlJdgj9Otjd0DWszZwBlEXKUUpCI3U9Dl8yoOpH1o40vPYonkkoB1clLdFE
 mVHQ==
X-Gm-Message-State: AOAM531Fi6EsUACLUMDn/IU/HIIctgQH28QOYfrIXCD7cMkT1sg1ns8L
 VjglVvLIcFyAAPqjXmbwiVAC6A==
X-Google-Smtp-Source: ABdhPJzNyPRVW8DvUesFVvmx/nClszHTRSPl0Vnt9bPBF1ji/XhJH0dcpzMuIM/ufUrQZsxhABOndg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr20990525wrr.1.1605547814676; 
 Mon, 16 Nov 2020 09:30:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:30:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/43] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Date: Mon, 16 Nov 2020 17:29:26 +0000
Message-Id: <20201116173005.1825880-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:12 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MjI2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICdkZXYnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9pbmZvX2lvY3Rs
JwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MjI2OiB3YXJuaW5nOiBFeGNl
c3MgZnVuY3Rpb24gcGFyYW1ldGVyICdyZGV2JyBkZXNjcmlwdGlvbiBpbiAncmFkZW9uX2luZm9f
aW9jdGwnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9rbXMuYwppbmRleCAwMDE5NDBiY2E5MGE2Li41MGNlZTQ4ODBiYjQ2IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwpAQCAtMjE0LDcgKzIxNCw3IEBAIHN0YXRp
YyB2b2lkIHJhZGVvbl9zZXRfZmlscF9yaWdodHMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIC8q
KgogICogcmFkZW9uX2luZm9faW9jdGwgLSBhbnN3ZXIgYSBkZXZpY2Ugc3BlY2lmaWMgcmVxdWVz
dC4KICAqCi0gKiBAcmRldjogcmFkZW9uIGRldmljZSBwb2ludGVyCisgKiBAZGV2OiBkcm0gZGV2
aWNlIHBvaW50ZXIKICAqIEBkYXRhOiByZXF1ZXN0IG9iamVjdAogICogQGZpbHA6IGRybSBmaWxw
CiAgKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
