From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'msg_out'
Date: Mon, 25 Nov 2019 22:54:45 +0800
Message-ID: <20191125145445.21648-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, yuehaibing@huawei.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c: In function mod_hdcp_hdcp2_enable_encryption:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:633:77: warning: variable msg_out set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c: In function mod_hdcp_hdcp2_enable_dp_stream_encryption:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:710:77: warning: variable msg_out set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 2dd5fee..468f5e6 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -630,14 +630,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
-	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
 	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
-	msg_out = &hdcp_cmd->out_msg.hdcp2_prepare_process_authentication_message_v2;
 
 	hdcp2_message_init(hdcp, msg_in);
 
@@ -707,14 +705,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
-	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
 	uint8_t i;
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
-	msg_out = &hdcp_cmd->out_msg.hdcp2_prepare_process_authentication_message_v2;
 
 	hdcp2_message_init(hdcp, msg_in);
 
-- 
2.7.4
