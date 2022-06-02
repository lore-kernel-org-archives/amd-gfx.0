Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E69C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 21:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFB511327E;
	Thu,  2 Jun 2022 21:07:18 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A084311328D
 for <amd-gfx@freedesktop.org>; Thu,  2 Jun 2022 21:07:17 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11C8780088A
 for <amd-gfx@freedesktop.org>; Thu,  2 Jun 2022 21:01:04 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.34.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4C301410F36;
 Thu,  2 Jun 2022 21:01:03 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@freedesktop.org
Subject: [PATCH 0/3] Drive-by MST fixes for amdgpu
Date: Thu,  2 Jun 2022 17:00:53 -0400
Message-Id: <20220602210056.73316-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

Now that I'm finishing up my work to remove the legacy MST code from the
tree, I've come across a couple of various issues that I wrote up
patches for along the way. These are some of those patches for amdgpu.

Lyude Paul (3):
  drm/amdgpu/dm/mst: Stop grabbing mst_mgr->lock in
    compute_mst_dsc_configs_for_state()
  drm/amdgpu/dm/mst: Stop grabbing mst_mgr->lock in
    pre_compute_mst_dsc_configs_for_state()
  drm/amdgpu/dm: Drop != NULL check in dm_mst_get_pbn_divider()

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

-- 
2.35.3

