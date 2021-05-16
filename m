Return-Path: <SRS0=K/ap=KL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08530C433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 16 May 2021 12:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C113B61155
	for <amd-gfx@archiver.kernel.org>; Sun, 16 May 2021 12:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C113B61155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A39F6E503;
	Sun, 16 May 2021 12:13:20 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC03189B01;
 Sun, 16 May 2021 12:13:18 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3306BB118;
 Sun, 16 May 2021 12:13:17 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
 sakari.ailus@linux.intel.com
Subject: [PATCH 0/4] drm: Finally retire struct drm_format_name_buf
Date: Sun, 16 May 2021 14:13:11 +0200
Message-Id: <20210516121315.30321-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a cleanup patchset to remove drm_format_name_buf et al. There
are two instances in drivers that need to be replaced with the %4cc
printk format modifier. Patch 3 was left over back from an earlier
patchset. [1] Patch 4 removes struct drm_format_name_buf.

I built-tested with drm-tip. The patchsetcan be mered through drm-misc.

[1] https://lore.kernel.org/dri-devel/20210216155723.17109-1-sakari.ailus@linux.intel.com/

Sakari Ailus (1):
  drm: Remove drm_get_format_name()

Thomas Zimmermann (3):
  drm/amdgpu: Use %p4cc to print 4CC format
  drm/simpledrm: Use %p4cc to print 4CC format
  drm/fourcc: Remove struct drm_format_buf_name

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  7 ++----
 drivers/gpu/drm/drm_fourcc.c                | 25 ---------------------
 drivers/gpu/drm/tiny/simpledrm.c            |  6 ++---
 include/drm/drm_fourcc.h                    |  9 --------
 4 files changed, 4 insertions(+), 43 deletions(-)

--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
