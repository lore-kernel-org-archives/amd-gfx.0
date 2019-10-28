Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB2CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D179204FD
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D179204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF216E852;
	Mon, 28 Oct 2019 12:47:42 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06106E4FF;
 Mon, 28 Oct 2019 09:20:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id r141so8252712wme.4;
 Mon, 28 Oct 2019 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UntOsok0RJA5xyBdV5DE84ry7KtJuNs3rA69E2z2DlM=;
 b=Hwxv0Udd4fLKgiyUQxBPsGFwTcFZsgzEiXppgartiQvYX/LnSG7/1NfbBfp9kNHhOO
 pUFvRE6brlxRtHjt3qmpiypGYC5Z4/ep11uSU3MWb3FKXPu8Dz5GIKntbpAjb3kCWspJ
 B3pf7cm/NXvRnkmLnNx1Jpncb/MIXXwfqOSv29dC4ODOfAfLiRZZqlud87DFEyVexJqn
 LsF7NUkZKfnvksCT2Qu99VR6AT/lRcz4/PQ0d7PMxHWp//mgWVdTS7gpHm/O6+rNcMjZ
 qI5jmqsP3cniavKdt5rsZYLzU92Ib2mCxD9BzvPFxNOwdecwRy5QdPyUd8aXRS/XZ3Xj
 cmUg==
X-Gm-Message-State: APjAAAU9qZho8+zAekfi+kj12v2sMaFs9N+6udRQzgruZ5l5LjG/GI/5
 ECD6cYqn655o3ppmi6OgNV98UuvfmncfpQ==
X-Google-Smtp-Source: APXvYqyJUBnyICbDWxYuvED5P/6503b/z3i6qtHWN/gRRjhaGQcOu9SUYbms5Y7BWsojxsYdr9mnyA==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr15828228wmk.25.1572254415073; 
 Mon, 28 Oct 2019 02:20:15 -0700 (PDT)
Received: from localhost.localdomain ([197.254.95.38])
 by smtp.googlemail.com with ESMTPSA id z9sm11427513wrv.1.2019.10.28.02.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 02:20:14 -0700 (PDT)
From: Wambui Karuga <wambui.karugax@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [Outreachy][PATCH 0/2] sparse warning cleanup
Date: Mon, 28 Oct 2019 12:20:03 +0300
Message-Id: <20191028092005.31121-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 28 Oct 2019 12:47:35 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=UntOsok0RJA5xyBdV5DE84ry7KtJuNs3rA69E2z2DlM=;
 b=JP4d5d7Rp2a/4tRoivSLq+T9QpD49Linqp+deoL1VU3fPfpuQx1pkHQc0AfSvCfx4S
 82e22oG+ChZcIaEWz2LAlG7Uv6N5f7OqHWgD8fs5Vi3gEPxj7GQtWAvfBDi0kHC32QWu
 /fyaI9E+kMjFLnw/Pe06IVT5vCAny2fA4QgtTxE0TW8ElrzkyucDbRNs74XJz1+s00My
 qFHluGcSUbJsjB/LxULcAycCqhuSAfpePvB4FQpwDD6QbgPQq7tQ15nlOWqRppw+sdpS
 rotuwM+0dwCWSbLcG2OwUT9Tc5Fc2UEbpWBRuTtCvWsFzWBgwBMmsSgnrcQc7tpmlbmp
 Us3Q==
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
Cc: David1.Zhou@amd.com, airlied@linux.ie, outreachy-kernel@googlegroups.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028092003.P6uVc-GHBYLzWd1zxZ8jZ_2Yv2UrIpfAtwVkq-QBfyg@z>

VGhpcyBwYXRjaHNldCBhZGRyZXNzZXMgdGhlIHNwYXJzZSB3YXJuaW5nIGFib3V0IHRoZQpgYW1k
Z3B1X2V4cF9od19zdXBwb3J0YCB2YXJpYWJsZSBhbmQgY29ycmVjdHMgdGhlIG1pc3BlbGxpbmcg
b2YgdGhlCndvcmQgIl9MRU5USCIuCgpXYW1idWkgS2FydWdhICgyKToKICBkcm0vYW1kOiBkZWNs
YXJlIGFtZGdwdV9leHBfaHdfc3VwcG9ydCBpbiBhbWRncHUuaAogIGRybS9hbWQ6IGNvcnJlY3Qg
Il9MRU5USCIgbWlzcGVsbGluZyBpbiBjb25zdGFudAoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oICAgICAgICB8IDUgKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDQgKystLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jICAgIHwgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
