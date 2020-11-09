Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A14C56201
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D947206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FioJyxPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D947206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B408896E5;
	Mon,  9 Nov 2020 21:21:44 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4634589272
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:25 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s8so3284332wrw.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R1FKv2blGXbscAB7wKDEc1cac5g15gUeFIAgqfSJF6w=;
 b=FioJyxPLeJAUtobkLDaKIkmME9xBKEy47Q9FG/W/6yyZv2S0N5LgGTxjipqJH0Ic7z
 7O7aoSIH0b6KWnTCeiLyOlX4PzanvzFhWVpR5qoa0amSEfrtzUxepB6fY5WLRJ5Jfnzm
 c2dNShFGlyjTrh/hS4rsX1zH+8qYiS6WOQ67brpZ7qzIgUOHVvSwuWENmC9jIFj645MA
 Xb33uxmCmy6o2SGrzeyUwHROne1dbDp9fNKNXUfk9+yFZ1dsf8gX3f4tLB/9FuW590/1
 VLciwVZw8Kh8nvtdTJ2ejXFLbWRrQ68+EyhhQ4bPpezIErzIqIbGGJ9GOki4QtKA/G8m
 tiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R1FKv2blGXbscAB7wKDEc1cac5g15gUeFIAgqfSJF6w=;
 b=bRT61Knne0kYCyiHZzmEtBul3FrD7E9asjsIrtW0RmIZu6MhXEt/KQkTCSrQQWN3Of
 Whh+8opOsvALVRhMCDl7Tcjq4BtGtO3CGEW5/L8vm5SIvhLLAU5KcBB3f+wWMhBgwve+
 SmLAk8LE+8iklmVPAabd4Etmv46XktZVdNh2x/c3RYSP9fEaoWYZz9r/xHstGSMID7a4
 PCLz9qk4dYovlR45Mh9sJf/ty1nPo/wvJFZ4HHxK4LqtcyXgnkWcMYGNlyNRiPNncCh6
 Tp+vq/v/k/0/n/XUhYJgq6zHddJgDnv2l1cD7jJXiBWFyCseXkQTrcMgzik4ixizB8le
 KdWg==
X-Gm-Message-State: AOAM5322z5yEUussrfjL4tZ9xTvLbO21Qf3iFBL8uJrmz5JvwXwg7WOO
 jMeWGm10nGVDdC4+fVr6JM6OLg==
X-Google-Smtp-Source: ABdhPJzNnYeInLP+RtXqqmtawFUWK07GI7u6mpPZ0kizGCkgqhol2+QTYdIKxwXXMGpk9hHbdCma7w==
X-Received: by 2002:adf:f546:: with SMTP id j6mr6858247wrp.219.1604956763980; 
 Mon, 09 Nov 2020 13:19:23 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:23 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/20] drm/radeon/radeon_i2c: Remove pointless function header
Date: Mon,  9 Nov 2020 21:18:43 +0000
Message-Id: <20201109211855.3340030-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faTJjLmM6NDY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ3JhZGVvbl9jb25uZWN0b3InIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVv
bl9kZGNfcHJvYmUnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9pMmMuYzo0Njogd2Fy
bmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAndXNlX2F1eCcgbm90IGRlc2NyaWJl
ZCBpbiAncmFkZW9uX2RkY19wcm9iZScKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25faTJjLmMgfCA0IC0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2kyYy5jIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25faTJjLmMKaW5kZXggNTQ1ZTMxZTZjYzNhOS4uYWE2MWIzY2I0MDQ5
YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faTJjLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faTJjLmMKQEAgLTM4LDEwICszOCw2IEBAIGV4
dGVybiBpbnQgcmFkZW9uX2F0b21faHdfaTJjX3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICppMmNf
YWRhcCwKIAkJCQkgICBzdHJ1Y3QgaTJjX21zZyAqbXNncywgaW50IG51bSk7CiBleHRlcm4gdTMy
IHJhZGVvbl9hdG9tX2h3X2kyY19mdW5jKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCk7CiAKLS8q
KgotICogcmFkZW9uX2RkY19wcm9iZQotICoKLSAqLwogYm9vbCByYWRlb25fZGRjX3Byb2JlKHN0
cnVjdCByYWRlb25fY29ubmVjdG9yICpyYWRlb25fY29ubmVjdG9yLCBib29sIHVzZV9hdXgpCiB7
CiAJdTggb3V0ID0gMHgwOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
