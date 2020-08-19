Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8D3C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B52204FD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN2LdlzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B52204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FEC89C7F;
	Wed, 19 Aug 2020 13:46:26 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DC56E077;
 Wed, 19 Aug 2020 08:18:20 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id o23so25281087ejr.1;
 Wed, 19 Aug 2020 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Dy+2OELhVDdm1DxklsrmDDS8Lu3aUtSBuyTN0DczS8k=;
 b=QN2LdlzXC/iWoVnvzjtShkG79VByoSWMJ0PGEvfCBxDt/cOl/FifqXc3Z4DxDI+jbO
 U0EX7DHcdDsmZeTj9BLD1GCuPT1hGS5ySxbAauEkzX0omK0Y7DixjnR3ygpB61Kl5Hu/
 nHr1pohz2HJda1AJ2cK2eofrpnPvxF+LJKzTcRz+dKyZpCsCNM/6sypYNpCInJzNCwgq
 MIxlUAKRGypbjbxTBHdOBNaJPSlD0AYXuXqWjxJoD84Ci8vJzTSlt9O5Cq85Ul1oOqpU
 tbLFZnKvcBmTfsPf0Cju7d5CgFX3pwkbtLsVzi7tfkhO25POEwMGsKACLh9R6939Az00
 iHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Dy+2OELhVDdm1DxklsrmDDS8Lu3aUtSBuyTN0DczS8k=;
 b=Nx1UvJejUaZ2ZyksMgXI8lvj4NwVlZyjQqNBdGnYeaqtzkq/N56dfRljq+Py9rfL5G
 pNFQFbFmaLDxnTiOlhMZJa9F+C5MhOsw1TxTvvrAzwaxZ0OVeYlkqlls6Ji9YKb5w0Fj
 imW7dOXGJtwFzAUj9ASZtsUzqph5htTZa6Yz8TIldJyr7uw+TVAxaj5/o/j2jEeYJhkc
 W0vkbwF7gwjVVZ+kE1218dQLfuTB7IoTX1eG9rlS6zT1OdMFiCNqt1Zi3+8EyxL5DYMG
 7OK8Ul8Isggd0q4a7vC2Hbyw4jh6c0qY5RHPfpjsle44WyoyYJaspNaQsrDTWqEt+Bgj
 chGw==
X-Gm-Message-State: AOAM5323C38V87aghmHfdPR6xEZVUpvg1nv4yALP/FlmrXy4v+Xn9/dQ
 yB7bkehH5AP4qv53nhaxA90=
X-Google-Smtp-Source: ABdhPJxbTmCq+bnKTWd+oh5WAn5yWBTYt4w7rCTNOjbtzeU/xdueaFs38zLAtFWMKtPdqRf3d+UzGg==
X-Received: by 2002:a17:906:4f0f:: with SMTP id
 t15mr23482886eju.337.1597825098654; 
 Wed, 19 Aug 2020 01:18:18 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1b:6b00:888f:331b:5459:5921])
 by smtp.gmail.com with ESMTPSA id g27sm18312043edf.57.2020.08.19.01.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 01:18:17 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH] drm/amd/display: remove unintended executable mode
Date: Wed, 19 Aug 2020 10:18:08 +0200
Message-Id: <20200819081808.26796-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 19 Aug 2020 13:46:25 +0000
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
Cc: Guchun Chen <guchun.chen@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Besides the intended change, commit 4cc1178e166a ("drm/amdgpu: replace DRM
prefix with PCI device info for gfx/mmhub") also set the source files
mmhub_v1_0.c and gfx_v9_4.c to be executable, i.e., changed fromold mode
644 to new mode 755.

Commit 241b2ec9317e ("drm/amd/display: Add dcn30 Headers (v2)") added the
four header files {dpcs,dcn}_3_0_0_{offset,sh_mask}.h as executable, i.e.,
mode 755.

Set to the usual modes for source and headers files and clean up those
mistakes. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20200819

Alex, Christian, please pick this minor non-urgent cleanup patch.

Dennis, Jerry, please ack.

Dennis, Jerry, you might want to check your development environment
introducing those executable modes on files.

 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c                         | 0
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c                       | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h   | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
old mode 100755
new mode 100644
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
