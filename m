Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99917606A329
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B4D10EEED;
	Mon,  2 Nov 2026 14:16:01 +0000 (UTC)
X-Greylist: delayed 380 seconds by postgrey-1.36 at gabe;
 Mon, 02 Nov 2026 11:36:37 UTC
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com
 [94.136.29.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508EF10ED2D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 11:36:37 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5677543DCA;
 Mon, 02 Nov 2026 12:30:15 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dmytro.laktyushkin@amd.com, dillon.varone@amd.com, roman.li@amd.com,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Don't warn about links without an HPD GPIO
Date: Mon,  2 Nov 2026 12:29:43 +0100
Message-ID: <20261102113002.3408350-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793619014499
X-Mailman-Approved-At: Mon, 02 Nov 2026 14:15:56 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit def3488eb0fd ("drm/amd/display: refactor HPD to increase
flexibility"), the link encoder programs the HPD filter, and
dce110_program_hpd_filter() and dcn10_program_hpd_filter() hit ASSERT(0)
if the encoder has no HPD GPIO. That is the case if link_get_hpd_gpio()
finds no usable HPD info for the connector in the VBIOS, where
program_hpd_filter() used to return early without a warning.

This logs a warning with a stack trace on every boot of some systems,
for example with Ryzen 7 PRO 4750G APUs on ASRock Rack X570D4U and
X470D4U2-2T boards:

  WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/dio/dcn10/dcn10_link_encoder.c:1514 at dcn10_program_hpd_filter+0x39/0x90 [amdgpu], CPU#7: (udev-worker)/836
  Call Trace:
   program_hpd_filter+0x5d/0xb0 [amdgpu]
   construct_phy+0x96f/0xe60 [amdgpu]
   link_create+0x1f0/0x240 [amdgpu]
   create_links+0x164/0x4f0 [amdgpu]
   dc_create+0x3ba/0x720 [amdgpu]
   amdgpu_dm_init+0x2c9/0x420 [amdgpu]

Return false without asserting if there is no HPD GPIO, as before, and
keep the assertion for failing to lock the pin.

Fixes: def3488eb0fd ("drm/amd/display: refactor HPD to increase flexibility")
Link: https://forum.proxmox.com/threads/kernel-7-0-14-24-and-7-0-14-25-bug-in-amdgpu.187181/
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c        | 5 ++++-
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index c6a20378121b..0c1fcfd088ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1841,8 +1841,11 @@ bool dce110_get_hpd_state(struct link_encoder *enc)
 
 bool dce110_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms)
 {
+	if (!enc->hpd_gpio)
+		return false;
+
 	/* Setup HPD filtering */
-	if (enc->hpd_gpio && dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
+	if (dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
 		struct gpio_hpd_config config;
 
 		config.delay_on_connect = delay_on_connect_in_ms;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 32e12d894e31..ddb40e6507b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -1506,8 +1506,11 @@ bool dcn10_get_hpd_state(struct link_encoder *enc)
 
 bool dcn10_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms)
 {
+	if (!enc->hpd_gpio)
+		return false;
+
 	/* Setup HPD filtering */
-	if (enc->hpd_gpio && dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
+	if (dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
 		struct gpio_hpd_config config;
 
 		config.delay_on_connect = delay_on_connect_in_ms;
-- 
2.47.3


