Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66396C3A5A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388722145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISoQquZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388722145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1AE6E258;
	Mon, 20 Apr 2020 06:59:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC5E6E129;
 Mon, 20 Apr 2020 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=KJGMy6qN76yx7ax6LuAFFNBWUTNhaNlEH4GjR48Hg1o=; b=ISoQquZurSP+DdbjfC2/kZDoun
 +CE5CvUHZdMKHKy28y3uwYPVzQMqz8SizGvSeY0sB+HF19SRJTs4S6O0GZPJ3IEI6v5ZWsHgoWP8r
 jO+aLciAznsxr8Bhp79sp6DgPtd48t+wcGc7kMbxc1hZzC2ry4ppXayHH/DC6zTu1oLkcoA/oNnmm
 HTKm0cyDBGXy12JjVMdyKi3R/aZUmTiuT8ZM7TK3XtOJFDKV7N/Mjbc5XTiPf0PFvifiajzPviaVp
 WHcdmdAY7KPk3Ba30oorh66zUeMO3j/Y+LBQSSUkhAUTId1M8KEk8HuAdPMauXtYZ7jUpm8S1EQYU
 /dIQhzXg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQLZh-0002EU-Vy; Mon, 20 Apr 2020 01:50:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: amd: display: fix kernel-doc struct warning
Date: Sun, 19 Apr 2020 18:50:14 -0700
Message-Id: <20200420015015.27991-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
X-Mailman-Approved-At: Mon, 20 Apr 2020 06:59:07 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a kernel-doc warning of missing struct field desription:

../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:331: warning: Function parameter or member 'hdcp_workqueue' not described in 'amdgpu_display_manager'

Fixes: 52704fcaf74b ("drm/amd/display: Initialize HDCP work queue")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-57-rc2.orig/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ lnx-57-rc2/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -139,6 +139,7 @@ struct amdgpu_dm_backlight_caps {
  * @backlight_link: Link on which to control backlight
  * @backlight_caps: Capabilities of the backlight device
  * @freesync_module: Module handling freesync calculations
+ * @hdcp_workqueue: workqueue for display manager interaction with HDCP module
  * @fw_dmcu: Reference to DMCU firmware
  * @dmcu_fw_version: Version of the DMCU firmware
  * @soc_bounding_box: SOC bounding box values provided by gpu_info FW
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
