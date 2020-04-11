Return-Path: <SRS0=mFKL=53=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC8C2BBC7
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58852166E
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKl3PKc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58852166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785766E3A8;
	Sat, 11 Apr 2020 23:11:02 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9016E3A6;
 Sat, 11 Apr 2020 23:11:01 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 038A32192A;
 Sat, 11 Apr 2020 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646661;
 bh=gxcoV2qpI5IWHpmQs+fyevwYN5HNxlyLXon5O6O47ZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lKl3PKc0kchAvaYBJ1gjdx/i2Apl9VTFPV8pgEOtk5VrdzmGr0gGWf8mU0eaMqFUQ
 MkhnWPc3x6giA8Sp/btfkxq0zxvkVn/KeN+nQmcWeDx/0wOljFtywrWixF/qinWX4l
 e+gFoGSu2efIKX8UtBK0tZhwCW0RO0/gPB/E3lHg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 062/108] drm/amd/display: System crashes when
 add_ptb_to_table() gets called
Date: Sat, 11 Apr 2020 19:08:57 -0400
Message-Id: <20200411230943.24951-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
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
