Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0427DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 13:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A2920658
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 13:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qDhQwNj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A2920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E3F6E296;
	Thu, 20 Aug 2020 13:19:25 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46A76E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 07:52:45 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id e1so1412143ybk.14
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=ZTZ7FeRGcuK/Hk+zj5oM9AwC2C+E4zSdizznNm3JGaw=;
 b=qDhQwNj/i9PSLJjNFzjvh270vkvMWiwNw4Xn4zB5msBMj/zonYxNr4zdkzs+kHxEKQ
 hsk4cTsctX3LU0jX3+aNU39vbHGAcgDW/7Kabwd7zA09xokQNLQT+l5OUTB18PY3jtc8
 3u1DD2f4zPraIZQBIOQgu9SC/UA+drjB87PyO+//YzeTsLTNXzTI13pixc0NmJ+t1Sig
 PSJynH6yZ+VT6N3palt7khJAXHuQF+GvVTeSVEFGUaZaKJmXq+GuZh7x882Oye0ACLPL
 isTCg2Gonbg6ZOLFRn+07HTT8f9TCbu/pBmgDuj3uzlMTq+fzWAWdRBL05rAShBbUOLe
 hRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZTZ7FeRGcuK/Hk+zj5oM9AwC2C+E4zSdizznNm3JGaw=;
 b=SCKW/GxMbhj/qP/kzu5SgCOMh9ruQXD2TKCnGRydYHLKmfUL04hqd2a32tfQIRdPhd
 0+nLkj8bXKAIpRBdGIHxHSSYh60VQ+FmljStyrMabrhbyUckMIIlvAajyEvg61cCfjeI
 nw+hq1vK6VgXhyECaImNV5NHSLIKla/4T6vn3xoZuhys1bAHyWTf4ExgJvMiVS00cXGi
 3E7Va18FjIVc3gJB5xAwSnFJKlfXWYkvfFdVN/cMR+z3liA97v1zsG200PBStFGMyhTb
 KtJkD21Duz0Uezqk8i8z3qUibaUyrgjnouzpNzk8PwCm9wfXLZQyY5b9eATT3mBOxCWY
 CSJQ==
X-Gm-Message-State: AOAM530aOEke/kzeiiXfOJqNgbcYNeQAayKdtl6wv1mXw93q8j/UUQtR
 vQINoA/CS06IebG3vmtXxbJXeEIpqq5q
X-Google-Smtp-Source: ABdhPJzAM44YvcI2eY5BDvZXP1CL91XTwHSk/ficRLHKynUx1ZaTtPmmgHpQyfkf4ayDeiiwEw2CVKu0Zo+Z
X-Received: from furquan.mtv.corp.google.com
 ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a5b:b45:: with SMTP id
 b5mr3114667ybr.294.1597909964605; 
 Thu, 20 Aug 2020 00:52:44 -0700 (PDT)
Date: Thu, 20 Aug 2020 00:52:41 -0700
In-Reply-To: <20200820052600.3069895-1-furquan@google.com>
Message-Id: <20200820075241.3160534-1-furquan@google.com>
Mime-Version: 1.0
References: <20200820052600.3069895-1-furquan@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps
 object to 0 in amdgpu_dm_update_backlight_caps
From: Furquan Shaikh <furquan@google.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
X-Mailman-Approved-At: Thu, 20 Aug 2020 13:19:23 +0000
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
Cc: Stylon Wang <stylon.wang@amd.com>, deepak.sharma@amd.com,
 Furquan Shaikh <furquan@google.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 adurbin@google.com, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In `amdgpu_dm_update_backlight_caps()`, there is a local
`amdgpu_dm_backlight_caps` object that is filled in by
`amdgpu_acpi_get_backlight_caps()`. However, this object is
uninitialized before the call and hence the subsequent check for
aux_support can fail since it is not initialized by
`amdgpu_acpi_get_backlight_caps()` as well. This change initializes
this local `amdgpu_dm_backlight_caps` object to 0.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
v2: Switched to using memset for initialization of object.

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4b33c67b634..da072998ce48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2855,6 +2855,8 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 #if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps;
 
+	memset(&caps, 0, sizeof(caps));
+
 	if (dm->backlight_caps.caps_valid)
 		return;
 
-- 
2.28.0.297.g1956fa8f8d-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
