Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F7CA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133D1204FD
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133D1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEEC6E84E;
	Mon, 28 Oct 2019 12:47:36 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132076E50C;
 Mon, 28 Oct 2019 09:20:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id q130so8272015wme.2;
 Mon, 28 Oct 2019 02:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wIuGwn2jgbDtMcHHOszupBu+fQifNyNj/PTHe+Q5iEw=;
 b=hZzbvCOM8aDRz/3UwzrNiz4yfzR30lrsPfejnq6jzNMVAsv1YPKd+2O3LnUKkPmX+R
 8AqCxQpiQkGNKyAcX9LLX97NU6mfHDs9VpRNfN6CX1/eqL4nchkve2waPTH9jwLXv2hc
 Brp+1yz+cOajigXNVKR9VtX8rFVoFEDsU0ou9qJY6nL5OhaqZc6xqO0uS4mZDDw6CCiz
 AdadQjxLa294ly+HSju5psbZTaHpytwQZOojyPbMYkOAVVgxIUVp+bpZ82ojr5FqXBdJ
 oFVUyvEVfSqCbewwTCVMv2pkbU9VRQh9dRxpSwOawtQkLxV5XxX+l2w0qTrA1LYvwiCl
 hOtw==
X-Gm-Message-State: APjAAAX7WObblBTKhptZ0vN5BkEbETC2S18OXcTGjxZh/LO4KiGpQ/Ol
 O5uqpJVXGJfyPwgMh1eXYs9V+8Fp+lcRUg==
X-Google-Smtp-Source: APXvYqxBcssIkhamPko/fax5AmALlb8thgEIQaTOHQbgFgVvAlPSNmDGOtswJVwTfhME3llhdxSSmw==
X-Received: by 2002:a1c:1d10:: with SMTP id d16mr15486351wmd.14.1572254417401; 
 Mon, 28 Oct 2019 02:20:17 -0700 (PDT)
Received: from localhost.localdomain ([197.254.95.38])
 by smtp.googlemail.com with ESMTPSA id z9sm11427513wrv.1.2019.10.28.02.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 02:20:16 -0700 (PDT)
From: Wambui Karuga <wambui.karugax@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [Outreachy][PATCH 1/2] drm/amd: declare amdgpu_exp_hw_support in
 amdgpu.h
Date: Mon, 28 Oct 2019 12:20:04 +0300
Message-Id: <20191028092005.31121-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028092005.31121-1-wambui.karugax@gmail.com>
References: <20191028092005.31121-1-wambui.karugax@gmail.com>
X-Mailman-Approved-At: Mon, 28 Oct 2019 12:47:35 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wIuGwn2jgbDtMcHHOszupBu+fQifNyNj/PTHe+Q5iEw=;
 b=CMh/MkDfospgY1lS3Xa8YLvgA9gN95y9aLEw+FmGBfX8eZl2bSwff0ji6BoiaaTSLy
 MOJK+6FLYglo4N6XVNJmnHdND7sNqftfNoXJocRfHqY8UgcbKumVjpa7W7zjCIHbjphq
 Bpsq49P0mzhpqPzd1E2iLq2T1Yka06IFlCMvpJAl5jyGgJp0O0Pwz43p6dJmNQ4csW9l
 T5RLdsVBLcBayfL+eTTaDCLM7Pq+42LucGCwv9KfRrGvRvVt4stEiYwVyGh0LkMF4pBb
 LkrHy+VKanwipDT7oyQZU28VX1uF6YWijZbK+woXWBY/8RAsAdecnMhEVnz4uW68Issh
 qwsg==
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
Message-ID: <20191028092004.HtkzgqS0ndMdFngxvgIRL5_jr5YZd48XzehfpeQmCF4@z>

RGVjbGFyZSBgYW1kZ3B1X2V4cF9od19zdXBwb3J0YCBhcyBleHRlcm4gaW4gYW1kZ3B1LmggdG8g
YWRkcmVzcyB0aGUKZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nOgpkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmM6MTE4OjU6IHdhcm5pbmc6IHN5bWJvbCAnYW1kZ3B1X2V4cF9o
d19zdXBwb3J0JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPwoKU2lnbmVk
LW9mZi1ieTogV2FtYnVpIEthcnVnYSA8d2FtYnVpLmthcnVnYXhAZ21haWwuY29tPgpTdWdnZXN0
ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IGY0ZDkwNDFl
ZjQzMC4uMzYxMGRlZmRmYWUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAt
MTQwLDYgKzE0MCw3IEBAIGV4dGVybiBpbnQgYW1kZ3B1X3ZtX2ZyYWdtZW50X3NpemU7CiBleHRl
cm4gaW50IGFtZGdwdV92bV9mYXVsdF9zdG9wOwogZXh0ZXJuIGludCBhbWRncHVfdm1fZGVidWc7
CiBleHRlcm4gaW50IGFtZGdwdV92bV91cGRhdGVfbW9kZTsKK2V4dGVybiBpbnQgYW1kZ3B1X2V4
cF9od19zdXBwb3J0OwogZXh0ZXJuIGludCBhbWRncHVfZGM7CiBleHRlcm4gaW50IGFtZGdwdV9z
Y2hlZF9qb2JzOwogZXh0ZXJuIGludCBhbWRncHVfc2NoZWRfaHdfc3VibWlzc2lvbjsKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
