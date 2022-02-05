Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D528C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 09:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D012610F360;
	Mon,  7 Feb 2022 09:10:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E1510F56E
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644073220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=713HQL5x//o/KghlUsgMrDORBx+gP5N718ebtgS9CfI=;
 b=hAle3Hqglukr3X0g/raY0wf7FNeSa20aKiZaBCPeLavEwsb/DS4NPWGS4Y3L+/S5+YCgwQ
 ceMmu2BWBGXSWiKW2bJuCi6GctaP3sFN4gpnVcQM5SH1wWWt1poPD60pzFqCzKA7ysQXIl
 i3W6ZAAf9es9QXUT/kfI2Ar2bCXCkQw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-Y9h_PxY8P_uc9r7RdNUXfQ-1; Sat, 05 Feb 2022 10:00:19 -0500
X-MC-Unique: Y9h_PxY8P_uc9r7RdNUXfQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 h10-20020a05620a284a00b0047649c94bc7so4672451qkp.20
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Feb 2022 07:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=713HQL5x//o/KghlUsgMrDORBx+gP5N718ebtgS9CfI=;
 b=P4WIdGpOV0aFbDiejj6HebV+s6b+rsi3eb2wKTXbyqj7pgNKQ7zPz0D9esJY71w2+g
 vwhJk/9kpd0fmBbjobdXY5wLHVXZNuqwvmG2GsuB1lh3RtY6gLZoKoUri7lKr/fSh1ux
 hVEuXI5szBH8hW4pCnIw29b8l+dnI/LV8+YcVunXmCU3D8LdkDQzLi5W6bDItKVad9Yr
 UgGllXsfpThoZeE+KCmwsqmr+H2kDc6v9H1mCJicStHFkMnK0c+IMdHg8fnpqfT77dp0
 FKnwDkawSEfz4yg2Z7aHBd/Img9jzrLTFSkQy8VX/5/IbaAhp6qevmzWMLvLUYfSaTSQ
 D/Aw==
X-Gm-Message-State: AOAM532pvcxrib8ICBuU5yssNpT+GV0o3zOlH+2cGp6IhHLauoOUWxgs
 ace0sGYXmM9QrOHaG2H+LeTpqYkEyqQnTeb+M44vCYuPyR4s6x29TpP4MTBTedus6PFCHNKoPAD
 Ej1b4jRJBEj1rO7/mMTzgswvQOA==
X-Received: by 2002:a05:620a:371d:: with SMTP id
 de29mr2218858qkb.300.1644073219092; 
 Sat, 05 Feb 2022 07:00:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQMqxJhjsehYnlrGdRYlEx/4uzDQf3AvY1i5RUhxDDhxx+wOwMtIaQmWd3GyZr4OF2gUxNaQ==
X-Received: by 2002:a05:620a:371d:: with SMTP id
 de29mr2218834qkb.300.1644073218865; 
 Sat, 05 Feb 2022 07:00:18 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id d22sm2657159qkn.112.2022.02.05.07.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Feb 2022 07:00:17 -0800 (PST)
From: trix@redhat.com
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, lijo.lazar@amd.com, darren.powell@amd.com,
 guchun.chen@amd.com, andrey.grodzovsky@amd.com
Subject: [PATCH] drm/amd/pm: fix error handling
Date: Sat,  5 Feb 2022 07:00:08 -0800
Message-Id: <20220205150008.1968218-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 07 Feb 2022 09:10:31 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

clang static analysis reports this error
amdgpu_smu.c:2289:9: warning: Called function pointer
  is null (null dereference)
        return smu->ppt_funcs->emit_clk_levels(
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is a logic error in the earlier check of
emit_clk_levels.  The error value is set to
the ret variable but ret is never used.  Return
directly and remove the unneeded ret variable.

Fixes: 5d64f9bbb628 ("amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index af368aa1fd0ae..5f3b3745a9b7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2274,7 +2274,6 @@ static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *bu
 {
 	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
-	int ret = 0;
 
 	clk_type = smu_convert_to_smuclk(type);
 	if (clk_type == SMU_CLK_COUNT)
@@ -2284,7 +2283,7 @@ static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *bu
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->emit_clk_levels)
-		ret = -ENOENT;
+		return -ENOENT;
 
 	return smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
 
-- 
2.26.3

