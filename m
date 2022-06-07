Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CB4C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 19:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B065310EF33;
	Tue,  7 Jun 2022 19:10:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE68810EF31
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654629057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UILT9WGW3d0IxemmFu2Q9nTCU5K37LJyUJt0iSrwqk0=;
 b=f5bmZ4BD0oi2x54BIPMhDoqZgG+sRMBaH8gMijnzckMVFNg1jcaCK48WFwzcBXD/wKqRWy
 i7Jx9yX+Noe8gA3EYFimlv/ukXC4idJ+J1sAstwkdT9MHdE1EfARCtrunwk1MMmt9Y+uAA
 tYH+TRQup1Vg/TEtt5oxkAbRQLHxQy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-RfDcGG7yMvyhqyGswC6abw-1; Tue, 07 Jun 2022 15:10:51 -0400
X-MC-Unique: RfDcGG7yMvyhqyGswC6abw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 080C280418F;
 Tue,  7 Jun 2022 19:09:00 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.9.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC0740FD372;
 Tue,  7 Jun 2022 19:08:23 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [RFC 02/18] drm/amdgpu/dm/mst: Rename get_payload_table()
Date: Tue,  7 Jun 2022 15:06:59 -0400
Message-Id: <20220607190715.1331124-3-lyude@redhat.com>
In-Reply-To: <20220607190715.1331124-1-lyude@redhat.com>
References: <20220607190715.1331124-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
Cc: Ian Chen <ian.chen@amd.com>, Colin Ian King <colin.king@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 open list <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Claudio Suarez <cssk@net-c.es>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function isn't too confusing if you see the comment around the
call-site for it, but if you don't then it's not at all obvious this is
meant to copy DRM's payload table over to DC's internal state structs.
Seeing this function before finding that comment definitely threw me into a
loop a few times.

So, let's rename this to make it's purpose more obvious regardless of where
in the code you are.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1bd70d306c22..1eaacab0334b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -153,8 +153,9 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	return result;
 }
 
-static void get_payload_table(struct amdgpu_dm_connector *aconnector,
-			      struct dc_dp_mst_stream_allocation_table *proposed_table)
+static void
+fill_dc_mst_payload_table_from_drm(struct amdgpu_dm_connector *aconnector,
+				   struct dc_dp_mst_stream_allocation_table *proposed_table)
 {
 	int i;
 	struct drm_dp_mst_topology_mgr *mst_mgr =
@@ -252,7 +253,7 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	 * stream. AMD ASIC stream slot allocation should follow the same
 	 * sequence. copy DRM MST allocation to dc */
 
-	get_payload_table(aconnector, proposed_table);
+	fill_dc_mst_payload_table_from_drm(aconnector, proposed_table);
 
 	return true;
 }
-- 
2.35.3

