Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2290C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666182399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRPuHdkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666182399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93B66ED37;
	Fri, 25 Sep 2020 20:11:04 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E3B6ED1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:02 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id cr8so2025138qvb.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ajzzmoD83PzXBE46cKMofgJfUeIwoIYyKrqyKuCHAjA=;
 b=HRPuHdkLY3A3J+MzoYJ9Zgys80iUJFE0Kwy9xPSWmKlm0ehZloo2GENKs/0MEmWdbw
 5nOCMem7gSGhmSVHAvwSFBLokm4S74p/3WciFRBD53gE0a/yuTE8K0IjAt3W75vKy7ku
 KBou5D0xj9TPcGlZ6dFwThiSdzD3WLMbe0RBVPu565v2lD7RsKTZvcISujBtsO8hPnUz
 rn+oaUC4eXtwN9vGIpPsok50Tubppk+aBVtxb4MIgNdRw6Tep39Arw8OXQ1anQGd0slK
 R/F/eju6Sx+tRBbP/6EtCmoT6RkzkEVdzCYnvoVLo0KskfRJPJwJ5dmQOjCvMZg6bUq4
 llpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajzzmoD83PzXBE46cKMofgJfUeIwoIYyKrqyKuCHAjA=;
 b=CJdSGR5h9wNyFZBGDiH0QmdPvWL9pYBfsneSpkttcqyEZrF6pm3oPZ45H8/2TmF9uI
 N4jPpN+9HFi/X/xsYq7fkQfYAogxxKyTkPwf7uEQiuWei/WzZechxHBBZJdbzc+412PA
 mfbqop7AbViP/jpBpwHXNEMYvwvkm+eOF2wgwMXPT8ptbdb/XX19Wa/OlKPT/kTim49Z
 sgYYhJS1jfiS7PMJNULewsRxRbzUZ0u4oef6kKGkN2jKjw/rwIByCqLs8tqAWJFUwc3s
 VmP4r2DglSdEBhR9/NoFSCR80R7rPDU3w1ln0sXvlpZOiMjvTYBUlodTiCKLxSMfJbP3
 G9sA==
X-Gm-Message-State: AOAM5339jZ+ctRkEeOmI2zhwW3+6rqCtQgOetvZZzbB55LBgq+hh4CMB
 yBg4jFN4d0rxsO3RAtlmYg5b+1LBl+U=
X-Google-Smtp-Source: ABdhPJxO9rtNEr3++jX8KfpRTta1rMGKIXCju3sXtP+ByBZdALcx747ZGdziT7d8MxdO2sqcPrguPQ==
X-Received: by 2002:a05:6214:84:: with SMTP id n4mr362940qvr.26.1601064661076; 
 Fri, 25 Sep 2020 13:11:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/45] drm/amdgpu: add uapi to define van gogh series
Date: Fri, 25 Sep 2020 16:09:47 -0400
Message-Id: <20200925201029.1738724-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add a flag to define van gogh series.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d3dadf10b13d..8d416188ddb3 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1086,6 +1086,7 @@ struct drm_amdgpu_info_vce_clock_table {
 #define AMDGPU_FAMILY_AI			141 /* Vega10 */
 #define AMDGPU_FAMILY_RV			142 /* Raven */
 #define AMDGPU_FAMILY_NV			143 /* Navi10 */
+#define AMDGPU_FAMILY_VGH			144 /* Van Gogh */
 
 /*
  * Definition of free sync enter and exit signals
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
