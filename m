Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A86C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 07:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C709C23A34
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 07:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C709C23A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EF889B33;
	Thu, 14 Jan 2021 07:53:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5414089B33;
 Thu, 14 Jan 2021 07:53:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 317DC23A1D;
 Thu, 14 Jan 2021 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610610830;
 bh=idK8XxiiyoaOs4dRWdbCzNyTgXtfNWQ9SoHpDwL3m2Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b8dswQE7d/kB9wq8ybsSfUBXKKkwU+3so8XJ12vaHCSCAOzrG/sIRTcotmO+FIOzz
 1vYZ9ljGc1MW0Dj8OJg8cwTbG7ah/bKjkBpZS81UQc9bIZT7kpwEtysxp9kyeC8YNj
 BMMhNdj1HDHIU9lKBErMLGWf4PUEUI/PXXdnQHHtLit/GTocSZ6mEiu4Nylnqtzsul
 ksCxayncQ43o2mIIT9YzYNt5rl3Nf9z6BzewjVkiJbV7Q+HxaIxb1oeDssyR4stJ7v
 EYAIbYlNrw8cYi6Lm52mUAvcyXiJjjdqMR0SlsYePai6Os9DQUGBzvjpx8uYG1+sIY
 /zv635ZwB6Tmw==
Received: by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kzxRz-00EPuD-9C; Thu, 14 Jan 2021 08:53:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@linux.ie>
Subject: [PATCH 06/10] drm: amd: amdgpu_dm.h: fix a wrong kernel-doc markup
Date: Thu, 14 Jan 2021 08:53:41 +0100
Message-Id: <8e16f3aa553786cd193e49882ce5131e3769afb8.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
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
Cc: Eryk Brol <eryk.brol@amd.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, dri-devel@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's a missing colon, causing the markup to be ignored,
solving those warnings:

	../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:340: warning: Incorrect use of kernel-doc format:          * @active_vblank_irq_count
	../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:379: warning: Function parameter or member 'active_vblank_irq_count' not described in 'amdgpu_display_manager'

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f084e2fc9569..5ee1b766884e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -337,7 +337,7 @@ struct amdgpu_display_manager {
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
 	/**
-	 * @active_vblank_irq_count
+	 * @active_vblank_irq_count:
 	 *
 	 * number of currently active vblank irqs
 	 */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
