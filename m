Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6023C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 14:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7AA10E624;
	Thu, 17 Mar 2022 14:23:20 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B56F10E126
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 14:01:22 +0000 (UTC)
Received: by mail-pj1-x104a.google.com with SMTP id
 ob7-20020a17090b390700b001c692ec6de4so654127pjb.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=AmXJz1T+DxTQ8cL3dWsBE4Euit10u/N4HtWuky6pYRE=;
 b=V3L1f0OpwlX27SXl8xzlUHsJrCaxgwXpjZ+thrxdmTARlLRSDFFBJ+xnGGLhlQsqqr
 tbkJyFaGSVmhVw5j9pAG34Rz8abgBSa0naQxCePa/cLUQx3nRMu9coTIGQ4vldyONv2K
 CMCnM93OSf6m0LNZ8U8XdMEZoOuwaLPvngsPbxN4Uxw/Tb/OW4209S1m0e9ri3orbvU/
 lAvYKhGN8KXNAv1FpIFUv/VOJSK3nG1Nx19pmWs7x5bECEHXR2C7f822KvYKqD5zP0M3
 UaNy/efqhy+qXYIxgLxHYB/ZbLn/li1zjGa9muAEbrTmPYtEZKC3/t2JySghT+nFOyXe
 LU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=AmXJz1T+DxTQ8cL3dWsBE4Euit10u/N4HtWuky6pYRE=;
 b=yOAkwi6iYTpc1etH1iVOX5P4lyBv1pWEkLbHFcVA74O8lEDxkYsu3p9ZGncY+8ombA
 QEtJG00Px6/nMJ0N/SQFV+2p9axReCvMPujkxssmHCehud2zSZHKHaLYr2FuS8iN+t7v
 mUkvkS8hdWPqxqI5oTeWqkFB9411vv271mM81HhJbdxCDHPrfPsHY58yLBpGZHuURgNE
 ooRVvLOAI663P+dqBg7WMDKZGhjToUBMsxlWdv2PuQhlAtQ3K2w6kG4aoBcoW79YdiW/
 RD8CX6qLXq04WH2r3abLP6yKP6QGURu18ycKGMxRdYvFoYUNmGiWX8VSl8kqiqvxiLPb
 EbkQ==
X-Gm-Message-State: AOAM531pXwdtx3aPbS0lR9fn2cpVcBqR6ghXwQ6xf+mDPXBq/CDAv6hv
 IlqQxVB8rQeRGqdWbTSzmKXSvXQeL32w
X-Google-Smtp-Source: ABdhPJxvoaqHM4SNfI3emat8G4zJ6gXkRPEt1XpB5btefTfHzZkskzhJq8f5SToxX3rJ2wl3pkTrR0UzOIew
X-Received: from ezekiel.c.googlers.com
 ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id
 f144-20020a623896000000b004f787dcde5bmr5201915pfa.49.1647525681892; Thu, 17
 Mar 2022 07:01:21 -0700 (PDT)
Date: Thu, 17 Mar 2022 19:31:15 +0530
Message-Id: <20220317140115.541007-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] drm/amd/display: Fixed the unused-but-set-variable warning
From: Aashish Sharma <shraash@google.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Pan Xinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Jake Wang <haonan.wang2@amd.com>, 
 Anson Jacob <Anson.Jacob@amd.com>, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Mar 2022 14:23:19 +0000
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
Cc: Aashish Sharma <shraash@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed this kernel test robot warning:

drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
warning: variable 'temp' set but not used [-Wunused-but-set-variable]

Replaced the assignment to the unused temp variable with READ_ONCE()
macro to flush the writes.

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 873ecd04e01d..b7981a781701 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2913,13 +2913,12 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
+		uint64_t *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
 		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
 		uint8_t i;
 
 		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
+			(void)READ_ONCE(*data++);
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1.723.g4982287a31-goog

