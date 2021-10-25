Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0273C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 22:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734746103C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 22:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 734746103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C1F6E250;
	Mon, 25 Oct 2021 22:40:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22EBB6E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635201601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S4KYRoHVnLHt6UICdy2GjiPz6RdGZIQTNnxSEUr7b9A=;
 b=fUKc2ADpQKY75EGrxgw53N9eC+42K65Od0Fw02ycp45lwkG9pUerA7pQ3pmoMGZG0MUuS9
 rWNRnr1IFkCZ6B/syARlIjYE0llKKCXcZaEYjUzsox8XfKgH0/+LNuT8WgVUzjxBAH2qPF
 KLo+rTkr8Nhifs66L+Hhl8PJ2iDKv+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-KUDzJBhzM5O3IgyVimpXEQ-1; Mon, 25 Oct 2021 18:38:34 -0400
X-MC-Unique: KUDzJBhzM5O3IgyVimpXEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8462719057A1;
 Mon, 25 Oct 2021 22:38:33 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.9.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E94B860BF1;
 Mon, 25 Oct 2021 22:38:31 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH RESEND v5 0/4] drm/amdgpu,
 Add DP 2.0 MST support + drm/dp_mst helpers
Date: Mon, 25 Oct 2021 18:38:20 -0400
Message-Id: <20211025223825.301703-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(Sorry for the noise, had to resend because I typo'd amd's mailing list
email address by accident)

Just resubmitting this patch series from AMD with _very_ minor changes
(just a typo and fixing a debug message) so that this can be pushed
upstream with a proper patchwork link. Will be pushing this into a topic
branch and submitting to airlied in a moment.

Bhawanpreet Lakha (3):
  drm: Remove slot checks in dp mst topology during commit
  drm: Update MST First Link Slot Information Based on Encoding Format
  drm/amd/display: Add DP 2.0 MST DM Support

Fangzhi Zuo (1):
  drm/amd/display: Add DP 2.0 MST DC Support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  14 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 292 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  19 ++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  13 +
 drivers/gpu/drm/drm_dp_mst_topology.c         |  42 ++-
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   2 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c        |   4 +-
 include/drm/drm_dp_mst_helper.h               |   5 +-
 13 files changed, 423 insertions(+), 16 deletions(-)

-- 
2.31.1

