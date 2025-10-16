Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A514CCD19E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 07:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05DB10E976;
	Thu, 16 Oct 2025 07:06:23 +0000 (UTC)
X-Greylist: delayed 503 seconds by postgrey-1.36 at gabe;
 Thu, 16 Oct 2025 06:59:47 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3E47810E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:59:47 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8DxM9DnlfBo6cQWAA--.49245S3;
 Thu, 16 Oct 2025 14:51:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJAxusDllfBoAX3pAA--.33076S2;
 Thu, 16 Oct 2025 14:51:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/amd: Fix set but not used warnings
Date: Thu, 16 Oct 2025 14:51:17 +0800
Message-ID: <20251016065117.2797-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxusDllfBoAX3pAA--.33076S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw47Zr15Cry7Kw1xZr4DKFX_yoW7Aw1rpF
 WkJFyY9r18ZF47t347Aa4xWr98Jwn3XFWxKrZ7GasI9a15Ar93Ca17AryUGryDWFsrAF43
 ZFs3X3yUX3ZFvrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
 WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1RBT5UU
 UUU==
X-Mailman-Approved-At: Thu, 16 Oct 2025 07:06:21 +0000
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

There are many set but not used warnings under drivers/gpu/drm/amd when
compiling with the latest upstream mainline GCC:

  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:305:18: warning: variable ‘p’ set but not used [-Wunused-but-set-variable=]
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:103:26: warning: variable ‘internal_reg_offset’ set but not used [-Wunused-but-set-variable=]
  ...
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: warning: variable ‘internal_reg_offset’ set but not used [-Wunused-but-set-variable=]
  ...
  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445:13: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]
  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:875:21: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]

Remove the variables actually not used or add __maybe_unused attribute for
the variables actually used to fix them, compile tested only.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h      | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 9 +++------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index b2033f8352f5..83f3b94ed975 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -302,7 +302,6 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			int pages)
 {
 	unsigned t;
-	unsigned p;
 	int i, j;
 	u64 page_base;
 	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
@@ -316,8 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 		return;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
-	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
-	for (i = 0; i < pages; i++, p++) {
+	for (i = 0; i < pages; i++) {
 		page_base = adev->dummy_page_addr;
 		if (!adev->gart.ptr)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index dc8a17bcc3c8..82624b44e661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -100,7 +100,8 @@
 
 #define SOC15_DPG_MODE_OFFSET(ip, inst_idx, reg) 						\
 	({											\
-		uint32_t internal_reg_offset, addr;						\
+		/* To avoid a -Wunused-but-set-variable warning. */				\
+		uint32_t internal_reg_offset __maybe_unused, addr;				\
 		bool video_range, video1_range, aon_range, aon1_range;				\
 												\
 		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
@@ -161,7 +162,8 @@
 
 #define SOC24_DPG_MODE_OFFSET(ip, inst_idx, reg)						\
 	({											\
-		uint32_t internal_reg_offset, addr;						\
+		/* To avoid a -Wunused-but-set-variable warning. */				\
+		uint32_t internal_reg_offset __maybe_unused, addr;				\
 		bool video_range, video1_range, aon_range, aon1_range;				\
 												\
 		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 53a088ebddef..6518d5639d66 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -442,7 +442,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	int i = 0, k = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
-	int pipe_idx = 0;
 	struct dc_stream_status *stream_status = NULL;
 
 	if (dc == NULL)
@@ -457,7 +456,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled = visual_confirm_enabled;
 
 	if (should_manage_pstate) {
-		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (!pipe->stream)
@@ -472,7 +471,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us = dc->debug.fpo_vactive_margin_us;
 				break;
 			}
-			pipe_idx++;
 		}
 	}
 
@@ -872,7 +870,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		bool enable)
 {
 	uint8_t cmd_pipe_index = 0;
-	uint32_t i, pipe_idx;
+	uint32_t i;
 	uint8_t subvp_count = 0;
 	union dmub_rb_cmd cmd;
 	struct pipe_ctx *subvp_pipes[2];
@@ -899,7 +897,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 
 	if (enable) {
 		// For each pipe that is a "main" SUBVP pipe, fill in pipe data for DMUB SUBVP cmd
-		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 			pipe_mall_type = dc_state_get_pipe_subvp_type(context, pipe);
 
@@ -922,7 +920,6 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
 
 			}
-			pipe_idx++;
 		}
 		if (subvp_count == 2) {
 			update_subvp_prefetch_end_to_mall_start(dc, context, &cmd, subvp_pipes);
-- 
2.42.0

