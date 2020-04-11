Return-Path: <SRS0=mFKL=53=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C6C38A29
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E293F20787
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a773GCsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E293F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7289A6E347;
	Sat, 11 Apr 2020 23:05:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39FF6E343;
 Sat, 11 Apr 2020 23:05:37 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9B2720787;
 Sat, 11 Apr 2020 23:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646337;
 bh=gxcoV2qpI5IWHpmQs+fyevwYN5HNxlyLXon5O6O47ZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a773GCsQbuJC+UxgyJ3kVLc4wghiNWzKDMulc6UGI0HxvmvYH1bfjdY1lxEwlljTL
 GPGgiqgMe520WZr1dOt6ExvWNPkiFGICofE2+jAvihD1ukN7w1Vx+8iQbzAEhPnQDk
 WU43FYqz50QGESc7PGuLd+hvZpR/IipSzEJ8byGk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 088/149] drm/amd/display: System crashes when
 add_ptb_to_table() gets called
Date: Sat, 11 Apr 2020 19:02:45 -0400
Message-Id: <20200411230347.22371-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Aric Cyr <Aric.Cyr@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Peikang Zhang <peikang.zhang@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[ Upstream commit 0062972b9d9f888d0273c6496769d02e8f509135 ]

[Why]
Unused VMIDs were not evicted correctly

[How]
1. evict_vmids() logic was fixed;
2. Added boundary check for add_ptb_to_table() and
   clear_entry_from_vmid_table() to avoid crash caused by array out of
   boundary;
3. For mod_vmid_get_for_ptb(), vimd is changed from unsigned to signed
   due to vimd is signed.

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
index f0a153704f6e0..00f132f8ad55d 100644
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
@@ -40,14 +40,18 @@ struct core_vmid {
 
 static void add_ptb_to_table(struct core_vmid *core_vmid, unsigned int vmid, uint64_t ptb)
 {
-	core_vmid->ptb_assigned_to_vmid[vmid] = ptb;
-	core_vmid->num_vmids_available--;
+	if (vmid < MAX_VMID) {
+		core_vmid->ptb_assigned_to_vmid[vmid] = ptb;
+		core_vmid->num_vmids_available--;
+	}
 }
 
 static void clear_entry_from_vmid_table(struct core_vmid *core_vmid, unsigned int vmid)
 {
-	core_vmid->ptb_assigned_to_vmid[vmid] = 0;
-	core_vmid->num_vmids_available++;
+	if (vmid < MAX_VMID) {
+		core_vmid->ptb_assigned_to_vmid[vmid] = 0;
+		core_vmid->num_vmids_available++;
+	}
 }
 
 static void evict_vmids(struct core_vmid *core_vmid)
@@ -57,7 +61,7 @@ static void evict_vmids(struct core_vmid *core_vmid)
 
 	// At this point any positions with value 0 are unused vmids, evict them
 	for (i = 1; i < core_vmid->num_vmid; i++) {
-		if (ord & (1u << i))
+		if (!(ord & (1u << i)))
 			clear_entry_from_vmid_table(core_vmid, i);
 	}
 }
@@ -91,7 +95,7 @@ static int get_next_available_vmid(struct core_vmid *core_vmid)
 uint8_t mod_vmid_get_for_ptb(struct mod_vmid *mod_vmid, uint64_t ptb)
 {
 	struct core_vmid *core_vmid = MOD_VMID_TO_CORE(mod_vmid);
-	unsigned int vmid = 0;
+	int vmid = 0;
 
 	// Physical address gets vmid 0
 	if (ptb == 0)
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
