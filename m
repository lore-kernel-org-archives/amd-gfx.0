Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F3C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 12:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888A2113D5A;
	Mon, 27 Jun 2022 12:51:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4485710E41E
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656253267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ahf2yCApAVRKZIV4QgwQyLJ3X4VNm/eYrF4Rb3afHBs=;
 b=HRbLhbf9ZF6YfHAqpHZo/wvNLzxpgAD/X/1Mx7UAEfX9/QKDO4OKIFD3umRsbu7KkTyGnI
 ElVaEh+y7TzyF7G17vUlN/kEuSzxA6OlPlilj3Ar/2hyDc26yfYfihbXfX6BTuq6a6jWgF
 z/a317FEs6J4Mre4L1nwqJafYZQyON8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-TVqFQe6wMeS4xJgI0N1muA-1; Sun, 26 Jun 2022 10:21:05 -0400
X-MC-Unique: TVqFQe6wMeS4xJgI0N1muA-1
Received: by mail-qk1-f197.google.com with SMTP id
 o10-20020a05620a2a0a00b006a77a64cd23so7862987qkp.21
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 07:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ahf2yCApAVRKZIV4QgwQyLJ3X4VNm/eYrF4Rb3afHBs=;
 b=fG8wI5A8H141F/UeWIaxFeZg6NLO9mP1WLzGUcAvmevQT30syoc6J+LfGTj83wK0Tp
 Kw/p7tA7wOhdryVwlA3VU6w/IS9l1U2kIIPjgsi/5kB7ZGqzPYvuk8dFz+YrAbne+kEp
 lSdxekcVmH/OCHuLP8pg0OSEKPijpolzr3Be9sbSaxXQ6phzlqyWTqD1Qtk3gGJAdhMi
 nYSaxTv32IP774SUE69DPouGDQ6LQMWLNDV1XLUgvcb33JHe7wIC+6hIvlMpMuZ2GeW6
 4ruGBzfTINqB8QzpkvpXmGbLdi5AjLS1wZzpi/8sb/bhZKEUrOWvN7qZDNe52ZbFG0hf
 YRLQ==
X-Gm-Message-State: AJIora+rhhG4BHwbtTBPcAAs5pxouS1OvrdNTGTA9nfniUxXFZgwoPby
 P/cRZFB9nQoR937b1Qgrvi9H6mNL7HFPd3+YvdETgXLQkuGZuaPyniE7wcEEz91g49kvcyHl+Ag
 svLd33O/YF7uvhxnAlHGuhxttvg==
X-Received: by 2002:a05:620a:471f:b0:6a6:f574:8b78 with SMTP id
 bs31-20020a05620a471f00b006a6f5748b78mr5486450qkb.469.1656253264887; 
 Sun, 26 Jun 2022 07:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1taraKCxi2XWY8/KIXCz5Sr4ylSIyPsZkkuTt119Zkfdt3zbyYiMOzX4TAVcI2CZmI4Sd2wRg==
X-Received: by 2002:a05:620a:471f:b0:6a6:f574:8b78 with SMTP id
 bs31-20020a05620a471f00b006a6f5748b78mr5486420qkb.469.1656253264652; 
 Sun, 26 Jun 2022 07:21:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a05620a291600b006aef641865esm6399256qkp.128.2022.06.26.07.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 07:21:04 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, wenjing.liu@amd.com, Jun.Lei@amd.com,
 George.Shen@amd.com, Jimmy.Kizito@amd.com, Jerry.Zuo@amd.com,
 michael.strauss@amd.com, aurabindo.pillai@amd.com
Subject: [PATCH] drm/amd/display: Remove unused globals FORCE_RATE and
 FORCE_LANE_COUNT
Date: Sun, 26 Jun 2022 10:20:53 -0400
Message-Id: <20220626142053.3373970-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 27 Jun 2022 12:51:35 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sparse reports
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3885:6: warning: symbol 'FORCE_RATE' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3886:10: warning: symbol 'FORCE_LANE_COUNT' was not declared. Should it be static?

Neither of thse variables is used in dc_link_dp.c.  Reviewing the commit listed in
the fixes tag shows neither was used in the original patch.  So remove them.

Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index be1dcb0a2a06..f3421f2bd52e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3882,9 +3882,6 @@ static bool decide_mst_link_settings(const struct dc_link *link, struct dc_link_
 	return true;
 }
 
-bool FORCE_RATE = false;
-uint32_t FORCE_LANE_COUNT = 0;
-
 void decide_link_settings(struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting)
 {
-- 
2.27.0

