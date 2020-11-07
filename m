Return-Path: <SRS0=Me3y=EN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E0EC2D0A3
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Nov 2020 02:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A420220728
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Nov 2020 02:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420220728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6301A6E118;
	Sat,  7 Nov 2020 02:02:44 +0000 (UTC)
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 17D906E118
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Nov 2020 02:02:42 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id 5FBC61840153; Fri,  6 Nov 2020 21:02:41 -0500 (EST)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix incorrect logic to increment VCN doorbell
 index
Date: Fri,  6 Nov 2020 21:02:39 -0500
Message-Id: <20201107020239.61768-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- The original logic uses a counter based index assignment,
  which is incorrect if we only assign VCN1 to this VF but no VCN0

  The doorbell index is absolute, so we can calculate it by
  using index variable i and j

Change-Id: Ica36b2bc80efa896f3753f2f2e2539ca2ca6649f
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 269002816109..3970a0ccb6a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -155,6 +155,13 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/*
+	 * Note: doorbell assignment is fixed for SRIOV multiple VCN engines
+	 * Formula:
+	 *   vcn_db_base  = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
+	 *   dec_ring_i   = vcn_db_base + i * (adev->vcn.num_enc_rings + 1)
+	 *   enc_ring_i,j = vcn_db_base + i * (adev->vcn.num_enc_rings + 1) + 1 + j
+	 */
 	if (amdgpu_sriov_vf(adev)) {
 		vcn_doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1;
 		/* get DWORD offset */
@@ -192,9 +199,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		ring = &adev->vcn.inst[i].ring_dec;
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev)) {
-			ring->doorbell_index = vcn_doorbell_index;
-			/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
-			vcn_doorbell_index++;
+			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
 		} else {
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 		}
@@ -216,9 +221,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			ring = &adev->vcn.inst[i].ring_enc[j];
 			ring->use_doorbell = true;
 			if (amdgpu_sriov_vf(adev)) {
-				ring->doorbell_index = vcn_doorbell_index;
-				/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
-				vcn_doorbell_index++;
+				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
 			} else {
 				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 			}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
