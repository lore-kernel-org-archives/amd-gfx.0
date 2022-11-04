Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7AEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 23:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC67410E8DA;
	Fri,  4 Nov 2022 23:59:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5FE10E8D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667606370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XVLxx8A9tJVHYfxplyNGpiAcrnYJUCckSuVUEsaFzbM=;
 b=eJ9pa+q33IR4vhXWYU6bLkMy56aeCMTC1DXy3zC1WQB2uI9OVK1vOSM8WztCSiOtomxxZE
 mBjM4bgl5GtluTZ6zQA+MQeYynhK+8LYmPCUvsLWjzFQcGHQIF1d9S2pr9hJRwC8J2ChCv
 U7mKXiNEOGzXIKCULNh2V325uT8mm3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-jZ43R2dMMAeurq1uA28S6Q-1; Fri, 04 Nov 2022 19:59:29 -0400
X-MC-Unique: jZ43R2dMMAeurq1uA28S6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECAE4833AED
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 23:59:28 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.11.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9A60112132C;
 Fri,  4 Nov 2022 23:59:28 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] MST deadlocking fixes
Date: Fri,  4 Nov 2022 19:59:24 -0400
Message-Id: <20221104235926.302883-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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

Some deadlock related fixes for amdgpu and DRM, spurred by:
https://gitlab.freedesktop.org/drm/amd/-/issues/2171

Unfortunately these don't fully fix the problem yet, but I'm getting
there!

Lyude Paul (2):
  drm/amdgpu/mst: Stop ignoring error codes and deadlocking
  drm/display/dp_mst: Fix drm_dp_mst_add_affected_dsc_crtcs() return
    code

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 107 ++++++++++--------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  12 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c |   2 +-
 4 files changed, 74 insertions(+), 65 deletions(-)

-- 
2.37.3

