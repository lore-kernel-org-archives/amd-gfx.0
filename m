Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C82C04A6A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AC910E5AD;
	Thu,  3 Aug 2023 07:25:05 +0000 (UTC)
Received: from out28-104.mail.aliyun.com (out28-104.mail.aliyun.com
 [115.124.28.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C69110E055;
 Wed,  2 Aug 2023 07:53:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09949107|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.051677-0.00259581-0.945727;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047207; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6d9036_1690962790; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6d9036_1690962790) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:53:12 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in vcn_v3_0.c
Date: Wed,  2 Aug 2023 07:53:09 +0000
Message-Id: <20230802075309.13950-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 03 Aug 2023 07:25:02 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space required before the open brace '{'
ERROR: "foo * bar" should be "foo *bar"
ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b76ba21b5a89..1e7613bb80ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1105,7 +1105,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG){
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 			continue;
 		}
@@ -1789,7 +1789,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
-	void * ptr;
+	void *ptr;
 	int r;
 
 	addr &= AMDGPU_GMC_HOLE_MASK;
@@ -2129,7 +2129,7 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 		return 0;
 	}
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2137,7 +2137,7 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 	else
 		ret = vcn_v3_0_start(adev);
 
-	if(!ret)
+	if (!ret)
 		adev->vcn.cur_state = state;
 
 	return ret;
@@ -2228,8 +2228,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.set_powergating_state = vcn_v3_0_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version vcn_v3_0_ip_block =
-{
+const struct amdgpu_ip_block_version vcn_v3_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCN,
 	.major = 3,
 	.minor = 0,
-- 
2.17.1

