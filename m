Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17009C001B3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23A310E4C8;
	Wed, 21 Jun 2023 15:38:50 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
 by gabe.freedesktop.org (Postfix) with SMTP id 6BB2210E15E;
 Tue, 20 Jun 2023 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [180.167.10.98])
 by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 09F1760C12808;
 Tue, 20 Jun 2023 16:55:44 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] =?UTF-8?q?drm/amd/amdgpu:=20Use=20=E2=80=9C=5F=5Fpacked?=
 =?UTF-8?q?=E2=80=9C=20instead=20of=20"pragma=20pack()"?=
Date: Tue, 20 Jun 2023 16:55:43 +0800
Message-Id: <20230620085543.576733-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Jun 2023 15:38:42 +0000
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
Cc: Su Hui <suhui@nfschina.com>, Jane.Jian@amd.com, David.Francis@amd.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Likun.Gao@amd.com, dan.carpenter@linaro.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use "__packed" is clearer amd better than “pragma pack()”.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
As Dan Carpenter mentioned:
'"Mark the associated types properly packed individually, rather than
use the disgusting "pragma pack()" that should never be used."
https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/'
use "__packed" is better.
the previous wrong patch's address:
https://lore.kernel.org/kernel-janitors/c12c4031-52fb-25a2-b411-e668eb9baaa2@tom.com/T/#t
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..025adc950026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -83,8 +83,6 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID__MAX
 };
 
-#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed
-
 union amd_sriov_msg_feature_flags {
 	struct {
 		uint32_t error_log_collect : 1;
@@ -210,7 +208,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t pcie_atomic_ops_support_flags;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 struct amd_sriov_msg_vf2pf_info_header {
 	/* the total structure size in byte */
@@ -263,7 +261,7 @@ struct amd_sriov_msg_vf2pf_info {
 	struct {
 		uint8_t id;
 		uint32_t version;
-	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	} __packed ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
 
 	/* reserved */
@@ -301,8 +299,6 @@ enum amd_sriov_gpu_init_data_version {
 	GPU_INIT_DATA_READY_V1 = 1,
 };
 
-#pragma pack(pop) // Restore previous packing option
-
 /* checksum function between host and guest */
 unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned int key,
 				    unsigned int checksum);
-- 
2.30.2

