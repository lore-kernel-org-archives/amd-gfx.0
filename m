Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAB7C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 22:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C4510E331;
	Mon, 14 Nov 2022 22:18:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A0010E331
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 22:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668464314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RwcRf+sgKBzVMGMwiYjKfdsaYLAjnuLAh0sJqn3Tt7Q=;
 b=SVp0z1udNP9iKKoGuP6OYsh/s7PxHREk1DmXwAnT4FP9YeVnCBQ+8hbk+HLqmwx5pT5FzV
 AUBgX/31KzAfItkavvqHe2by+NP3A7+J1lgi3pICaErEg66IfeiRF4jGD9a1jYm9iECyUg
 q/dx3IgpadVd9SHkNLg1wJrI3IzOuYY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-XOSzf03KPPKs0McK4PCPuA-1; Mon, 14 Nov 2022 17:18:33 -0500
X-MC-Unique: XOSzf03KPPKs0McK4PCPuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E145729AB3FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 22:18:32 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0CB049BB60;
 Mon, 14 Nov 2022 22:18:32 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/4] drm/amdgpu: Regression fixes from MST atomic-only
 conversion
Date: Mon, 14 Nov 2022 17:17:51 -0500
Message-Id: <20221114221754.385090-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

There was a bit of unexpected fallout from the atomic-only conversion
patches that I had pushed a while ago, which mostly affected amdgpu.
This fixes most of the severe issues, although we're still investigating
some lingering issues (which I suspect may just fix themselves following
this patchset, but we'll see!).

This is -technically- a v2 as it's a continuation on this previous
series:

https://patchwork.freedesktop.org/series/110556/

and there were some rather important changes made since then that Wayne
pointed out, which may or may not fix the last few issues left on this
issue:

https://gitlab.freedesktop.org/drm/amd/-/issues/2171

Note I've omitted one KASAN fix, but that's because it was just getting
in the way of turning on KASAN and was definitely unrelated to this bug.
Will submit that one on it's own shortly.

Lyude Paul (4):
  drm/amdgpu/mst: Stop ignoring error codes and deadlocking
  drm/display/dp_mst: Fix drm_dp_mst_add_affected_dsc_crtcs() return
    code
  drm/amdgpu/dm/mst: Use the correct topology mgr pointer in
    amdgpu_dm_connector
  drm/amdgpu/dm/dp_mst: Don't grab mst_mgr->lock when computing DSC
    state

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 254 ++++++++++--------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  12 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c |   2 +-
 4 files changed, 155 insertions(+), 131 deletions(-)

-- 
2.37.3

