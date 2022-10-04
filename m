Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAF0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 20:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B26D10E0E6;
	Tue,  4 Oct 2022 20:24:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9CE10E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664915080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=68Cjk2krWuLCLqwuVkKp32QKy4UuNZQ+DBLOl7qONe0=;
 b=SL4/zXp2FeQHoJhWFcfhQTN5jjxxEXuKgqEz5B+cI7xKc0GyGGtFHufoDu6wO6X+X5uojr
 Azl6//2tiv7Zs25e+OaAdjv6XrB8QOcfysEFDDD5f4RNtmur44BLch1ElEmh5mVUNiv1uR
 lbPJsJKEvzif9Uy74TRFXd7lH632Yeg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-6nYTxoTBMSiDvqWHTmPTnA-1; Tue, 04 Oct 2022 16:24:37 -0400
X-MC-Unique: 6nYTxoTBMSiDvqWHTmPTnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 385D01C0758C;
 Tue,  4 Oct 2022 20:24:36 +0000 (UTC)
Received: from emerald.stthomas.edu (unknown [10.22.18.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 855191121314;
 Tue,  4 Oct 2022 20:24:34 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of
 drm_dp_add_payload_part2()
Date: Tue,  4 Oct 2022 15:24:28 -0500
Message-Id: <20221004202429.124422-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
Cc: Ian Chen <ian.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 open list <linux-kernel@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Claudio Suarez <cssk@net-c.es>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Colin Ian King <colin.i.king@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yikes, it appears somehow I totally made a mistake here. We're currently
checking to see if drm_dp_add_payload_part2() returns a non-zero value to
indicate success. That's totally wrong though, as this function only
returns a zero value on success - not the other way around.

So, fix that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Issue: https://gitlab.freedesktop.org/drm/amd/-/issues/2171
Fixes: 4d07b0bc4034 ("drm/display/dp_mst: Move all payload info into the atomic state")
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b8077fcd4651..00598def5b39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -297,7 +297,7 @@ bool dm_helpers_dp_mst_send_payload_allocation(
 		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
 	}
 
-	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, payload)) {
+	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, payload) == 0) {
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			set_flag, false);
 	} else {
-- 
2.37.3

