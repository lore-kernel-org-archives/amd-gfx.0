Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42677C49EA4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1436361156
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1436361156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41BF89DA3;
	Mon, 21 Jun 2021 07:09:13 +0000 (UTC)
Received: from mail-m17639.qiye.163.com (mail-m17639.qiye.163.com
 [59.111.176.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACFC6EA53;
 Sat, 19 Jun 2021 06:44:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=V7U9SUoPmwi6dCxg84nX2VemV9THIQztla0KW9b/w8RzxJGQ6E9L3N3Jlg+J/5dbZnZOx/ZIvmeF1q3nLDZ4SfqDDENrTehFTVivHVt/HVk7M01oVkIUDH7LYcFLM8VyLW7h/7fnAYJ2LGnOoWe2A2Z4I3naFac75W5dg/NhJAY=;
 s=default; c=relaxed/relaxed; d=vivo.com; v=1;
 bh=s42oowK7cO0V1ZW3C3sS49FrZZtUENhP2zLbYkd5Fe8=;
 h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.181])
 by mail-m17639.qiye.163.com (Hmail) with ESMTPA id F243C380113;
 Sat, 19 Jun 2021 14:44:04 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] delete useless function return values & remove
 meaningless if(r) check code
Date: Fri, 18 Jun 2021 23:43:44 -0700
Message-Id: <20210619064349.26676-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGhlCH1ZCTx5IQx4eGRpNGkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Ljo*PT8cTkIJKxcXTSkD
 NVYaCRNVSlVKTUlPS0NOS09OT0tOVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
 TklVSk9OVUpDSllXWQgBWUFJTk1NNwY+
X-HM-Tid: 0a7a23031f84d994kuwsf243c380113
X-Mailman-Approved-At: Mon, 21 Jun 2021 07:09:08 +0000
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
Cc: Bernard Zhao <bernard@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Function radeon_fence_driver_init always returns success,
the function type maybe coule be changed to void.
This patch series will first delete the check of the return
value of the function call radeon_fence_driver_init, then,
optimise the function declaration and function to void type.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Bernard Zhao (4):
  drm/radeon: remove meaningless if(r) check code
  drm/radeon: remove meaningless if(r) check code
  drm/radeon: remove meaningless if(r) check code
  drm/radeon: delete useless return values

 drivers/gpu/drm/radeon/cik.c          | 4 +---
 drivers/gpu/drm/radeon/evergreen.c    | 4 +---
 drivers/gpu/drm/radeon/ni.c           | 4 +---
 drivers/gpu/drm/radeon/r100.c         | 4 +---
 drivers/gpu/drm/radeon/r300.c         | 4 +---
 drivers/gpu/drm/radeon/r420.c         | 5 +----
 drivers/gpu/drm/radeon/r520.c         | 4 +---
 drivers/gpu/drm/radeon/r600.c         | 4 +---
 drivers/gpu/drm/radeon/radeon.h       | 2 +-
 drivers/gpu/drm/radeon/radeon_fence.c | 5 +----
 drivers/gpu/drm/radeon/rs400.c        | 4 +---
 drivers/gpu/drm/radeon/rs600.c        | 4 +---
 drivers/gpu/drm/radeon/rs690.c        | 4 +---
 drivers/gpu/drm/radeon/rv515.c        | 4 +---
 drivers/gpu/drm/radeon/rv770.c        | 4 +---
 drivers/gpu/drm/radeon/si.c           | 4 +---
 16 files changed, 16 insertions(+), 48 deletions(-)

-- 
2.31.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
