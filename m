Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F81BC43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD4E20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD4E20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258716E673;
	Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492596E673
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:51 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id g12so3998503qvy.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=h5pPCbpcW/c2OJ8HB0Wn2iCeM83n2V04+HBXnTnhyd6T1vJrKfeH04iLM49MswQaJK
 ymirQK+2j+E/RCAWvg6x/eUYToxzWEKD4E0eKfSWPFZLy1XTi+Jo/TkV9ASkjEueIPzN
 pBkuDxAxI94v4qkeBKjqwLt8Ip6qPtX6VyylnjXFW4rbD1iCO50HSHWndafe+aGjgp6a
 inFUT8nj5CuhR1gxZDvQWK6kSZD+7P1e2dxF0wpHQBQ0g8G5DREo41m5n/YKVIx0SfQS
 IkZAX1RW3Q5JFgldJfXY+R8kJy6B2HX2GJzYaM96s+6YA+OIiLgDpEcSVMzdhUNW6ZCA
 ZoXg==
X-Gm-Message-State: APjAAAUI0qzl0+IObQehAduHbYFOZLq7VjYu+LIdjjdWwFZTg1gBJ7qL
 XocukRIjF1P2Mw8mwl8ltGCVsQvV
X-Google-Smtp-Source: APXvYqwym8WcQSfdzXEn9QA+9uo60hF+W0BRETn6JImdbqpPfgbUVJzW+sFkUw2mrm8ZoW5g9UQ9Iw==
X-Received: by 2002:a0c:cd8b:: with SMTP id v11mr14436226qvm.66.1573836650183; 
 Fri, 15 Nov 2019 08:50:50 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:49 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 03/20] drm/amdgpu: add supports_baco callback for SI asics.
Date: Fri, 15 Nov 2019 11:50:21 -0500
Message-Id: <20191115165038.56646-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=bq23hm2qPCoADVjFQxSIbYklRU8bnvJR6vE8sqzIyk0vWIQRX8WmKk1IluI+LV9KNi
 kaoO8ZwoAR2Lt2J2U7+pWJJoHMilaZ0CT/qe1RTZ+wc9d9ZbtLnf7WsAG/GFPX1ScRsF
 5F2vp3JNa5qIL6k0RYwbjCY9iHATdf8wt8a/Fh+a982yqjYJJfs8Hh0U6o2ymIrufKac
 Wu85aQFRe8mUY22VfzTjGni2wrXX/M4AM+ffyi8UxwqdpD1g8Ziyzvt+zcLG9auk7kYA
 MJqNFTsEeRELIZjGtu5vvtZHeSjrs8uKCFqwlLcGkEnPrekvc/UIPyN/p9Uuq1Uc9Gr6
 rdWw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115165021.L5OGjVedv1e-nTLTfK8W9t-kZXy8DUHjhzRObRsE7F8@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpOb3Qgc3VwcG9ydGVkLgoKUmV2aWV3ZWQtYnk6
IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zaS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2kuYwppbmRleCAyOTAyNGU2NGM4ODYuLmNiNjgyZDQ0NzM3YSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zaS5jCkBAIC0xMTk3LDYgKzExOTcsMTEgQEAgc3RhdGljIGludCBz
aV9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVybiAwOwogfQog
CitzdGF0aWMgYm9vbCBzaV9hc2ljX3N1cHBvcnRzX2JhY28oc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCit7CisJcmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgZW51bSBhbWRfcmVzZXRfbWV0
aG9kCiBzaV9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsK
QEAgLTE0MjUsNiArMTQzMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVu
Y3Mgc2lfYXNpY19mdW5jcyA9CiAJLmdldF9wY2llX3VzYWdlID0gJnNpX2dldF9wY2llX3VzYWdl
LAogCS5uZWVkX3Jlc2V0X29uX2luaXQgPSAmc2lfbmVlZF9yZXNldF9vbl9pbml0LAogCS5nZXRf
cGNpZV9yZXBsYXlfY291bnQgPSAmc2lfZ2V0X3BjaWVfcmVwbGF5X2NvdW50LAorCS5zdXBwb3J0
c19iYWNvID0gJnNpX2FzaWNfc3VwcG9ydHNfYmFjbywKIH07CiAKIHN0YXRpYyB1aW50MzJfdCBz
aV9nZXRfcmV2X2lkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQotLSAKMi4yMy4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
