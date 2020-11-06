Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F418CC5DF9D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA962087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/dYjguv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA962087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8416EB3F;
	Fri,  6 Nov 2020 21:52:23 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542F36EB36
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:16 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id n15so2791927wrq.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nopEvpxJII5W2X0oKSxO5qTCMfgTR4xaU1b6yHoTHoc=;
 b=Q/dYjguv8S6NsqfuKHgA061fmsexpTGcj3625pXi+PgAAgyL2muaEoshXwa+Kvnc8M
 59TG+TyhDa9fhxU8kIXiT3LXDmM8E9cUAyQ7qO59NrYbQDdRF+hOw9843TRurp2N1BXe
 Ai8xtWFs0fS315EoPuu8iPpZCzNdgLs2ST/VfWYd4RdGXIlr+q7rTJ/aFjdxIEqIbH7z
 hP83MnWVORZUN1gv5M7ZnOV+MDikTRoRWtIUNZdw6XIMqWWeiuQDjJ/ZnLMS3CEpivUb
 LxqLrkuSh1nL7vsvi5aSkA8MPdprs4DsYk5wo3vhBTOD+9cNuMocqJbzAgsCAtPi2h1X
 wi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nopEvpxJII5W2X0oKSxO5qTCMfgTR4xaU1b6yHoTHoc=;
 b=i6bHH1gKJiRWxY1AyVwh1zE3EYEhR6errNL5lj27ALECeHAXsNGG32nARfk8rveLMF
 N44vUrr51OL6kw5cU5U4aD9Et8Vty6xMllrUqIk05wvgVEScw1lRrBJuDMLOLQZ9F2Da
 KQ7zZlAANTi3JmGKrPs74hozoMqGXfltE0t/1pZa5w0A7/S1Xc6uwwOfAvsgVw1zkuCS
 NiZbxeFMgfqRvAon4/8hqueQ2i8O1FjPcSvIMMXBGiYM7nGIYNzDa9UyjlQ/GGbvgzB4
 fEwJyvR8jghJiUX5a0jrbU+JhjTBeSvIiblCbuCe9HNu+A/ZQ1SQYrRISIFuhO+ozqCh
 xcWA==
X-Gm-Message-State: AOAM532//QhbghzbNLTH3MWZksSwnkDvNr+Dd64D9hT924MNxaSX9TEX
 VLyf0+eoW4ySozEfK6s6yGbrVA==
X-Google-Smtp-Source: ABdhPJwhjl524rbpYWNO1C3Rgl/wInBAegWkXlKb202St9OQIldxQWVbP3BbXf2lvC5EiamcJEuT0A==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr5108985wrg.150.1604699415033; 
 Fri, 06 Nov 2020 13:50:15 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:14 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Date: Fri,  6 Nov 2020 21:49:47 +0000
Message-Id: <20201106214949.2042120-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
cmFkZW9uL3JhZGVvbl9rbXMuYwppbmRleCAwZDhmYmFiZmZjZWFkLi4yMWMyMDY3OTVjMzY0IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwpAQCAtMjEzLDcgKzIxMyw3IEBAIHN0YXRp
YyB2b2lkIHJhZGVvbl9zZXRfZmlscF9yaWdodHMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIC8q
KgogICogcmFkZW9uX2luZm9faW9jdGwgLSBhbnN3ZXIgYSBkZXZpY2Ugc3BlY2lmaWMgcmVxdWVz
dC4KICAqCi0gKiBAcmRldjogcmFkZW9uIGRldmljZSBwb2ludGVyCisgKiBAZGV2OiByYWRlb24g
ZGV2aWNlIHBvaW50ZXIKICAqIEBkYXRhOiByZXF1ZXN0IG9iamVjdAogICogQGZpbHA6IGRybSBm
aWxwCiAgKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
