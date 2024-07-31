Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E723BC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 07:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE5910E3F5;
	Wed, 31 Jul 2024 07:20:00 +0000 (UTC)
X-Greylist: delayed 137497 seconds by postgrey-1.36 at gabe;
 Wed, 31 Jul 2024 04:11:10 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2F610E0E1;
 Wed, 31 Jul 2024 04:11:10 +0000 (UTC)
X-QQ-mid: bizesmtpsz14t1722399046t8cj53
X-QQ-Originating-IP: YfBrOmRzqW2rVkujMiT2lCl0fnRmfKRUSfKubBNGB0g=
Received: from localhost.localdomain ( [113.57.152.160])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 31 Jul 2024 12:10:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8046675919235854722
From: WangYuli <wangyuli@uniontech.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Jingwen.Chen2@amd.com,
 suhui@nfschina.com, dan.carpenter@linaro.org, bokun.zhang@amd.com,
 wangyuli@uniontech.com, chongli2@amd.com, Luqmaan.Irshad@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
 shaoyang@uniontech.com, hongao@uniontech.com,
 wenlunpeng <wenlunpeng@uniontech.com>
Subject: [PATCH v3] drm/amd/amdgpu: Properly tune the size of struct
Date: Wed, 31 Jul 2024 12:10:40 +0800
Message-ID: <3BC6F04B763EF430+20240731041040.43863-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-Mailman-Approved-At: Wed, 31 Jul 2024 07:19:57 +0000
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

The struct assertion is failed because sparse cannot parse
`#pragma pack(push, 1)` and `#pragma pack(pop)` correctly.
GCC's output is still 1-byte-aligned. No harm to memory layout.

The error can be filtered out by sparse-diff, but sometimes
multiple lines queezed into one, making the sparse-diff thinks
its a new error. I'm trying to aviod this by fixing errors.

Link: https://lore.kernel.org/all/20230620045919.492128-1-suhui@nfschina.com/
Link: https://lore.kernel.org/all/93d10611-9fbb-4242-87b8-5860b2606042@suswa.mountain/
Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: wenlunpeng <wenlunpeng@uniontech.com>
Reported-by: Su Hui <suhui@nfschina.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index fb2b394bb9c5..6e9eeaeb3de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -213,7 +213,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t gpu_capacity;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 struct amd_sriov_msg_vf2pf_info_header {
 	/* the total structure size in byte */
@@ -273,7 +273,7 @@ struct amd_sriov_msg_vf2pf_info {
 	uint32_t mes_info_size;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 /* mailbox message send from guest to host  */
 enum amd_sriov_mailbox_request_message {
-- 
2.43.4

