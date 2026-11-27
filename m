Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1A606A32A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cH4hgqfo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5D0112973;
	Fri, 27 Nov 2026 09:59:00 +0000 (UTC)
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com
 [74.125.225.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA6410E4B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 00:05:55 +0000 (UTC)
Received: by mail-wr2-f10.google.com with SMTP id
 ffacd0b85a97d-48ded18b8d9so1938453f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795737953; x=1796342753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pqzmgKYMca4RBaxu31DAoXlIpLvnjkLq79oIDqJk3Ys=;
 b=cH4hgqfoQqH5YcbYI/tODaEW3Jbu1UFkM/5qt/ma38i5nhrZAnA/MPlBr5vk0PThOT
 sIfgxdXeuTkQz72BrgIJq2QvEQSvKrSU01Q89ZLTjoOALNdzQOAfR6+wKq+VOD0l+wXP
 6AO2UPlUuVJ1hh0SrplD0MvV/FYiVwe0rLxwOOd20EUe3PGeZMd8XkfoXr51UMiKTJ7s
 AKbG7Mh44u0h1saENlEi1c5uLH7+wx92sRxt4/uFH13ruz2q6aPtNqkyTCC6J7qwjkW8
 8glSrO7owrY4t3UmSmpZw10/gsiBX/cdRgVQBaZ5uPy8NeOcQEyocJIvVJO/CKr1vMcU
 SHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795737953; x=1796342753;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pqzmgKYMca4RBaxu31DAoXlIpLvnjkLq79oIDqJk3Ys=;
 b=RahAbc6NtLFnoQwFd2mqjsg+uggZ5jkPgOf7e7VZgIXmZ1TAklxtL4JrVmo//cruOA
 fmgmhB637vD+Oa7Zl+xkqfL2lsh+p/5nWfavuRqnOWymE0+wfFUUzRHqdmQNpNFnWWSW
 OqsouKwvhUry6jgIzIXCnIoGdXTw5glhkXDQE6HreZXJrgpfBINaiEBWowAHghfwyAQm
 4RRvJyXbrLy92Cjbq8stTBfNaVBnupn+CYYQBpHHFsJOzPp51GHci5pSNG61HMj+uwjS
 bHc/ulrQiyJdFkUQ61ZPlJroc153Fe1RZ7qjrqQ83Lsu/BmN6FzXjIQHU//cz43UxU3S
 ZdRQ==
X-Gm-Message-State: APuU4Z9du4jQB4prZn2XmAenUrU9nk97VSsQ9gBIR+GLZXVFwKEyu3I3
 HfE7gP6HezIHFlkSc976B7M2A9M73oDxe9C3FOUXPMdegnC2x5joZYk33l8ORakp2Jk=
X-Gm-Gg: AZFdTZcCkZSIt965pTCIJ+6yrt3fAHYmsyDMlEdP02Bz6e32etfjLIY9oE4B4M3pFhT
 DowgA8RBxHTENR3jBFECy3ATpjGVQMrgEmd8qvoh5KJFO6hWJc5X3Rnz+zgY6QqOtSGMMjfy+WG
 RhCLE9ktv97eYHMsuEKGdNUX+WTfquRyImXTQrzS4DgP01EU3auoR+h16356LHysSde5qSPPFOf
 5tS6vmij74ZAgWmu6n5qdoLmpA/rV570gaIfAZ2BE32Qd/6SHWLj024J8PAD6j9+DqquQvyso8R
 oXkRbrLSNY7lFUo0o3a641c4Bztz/dgS9FxWewmVvbAqYe9fWovMTPIwuBJUp5lyGyH5aoUwQt8
 v2J2ADhoIsyFskdLGpgiKhTbUliY1LG3I7LiV9LZY2oHURo1xIO5NGpBG80Ol/Jn3hnqrwlx+v5
 tGgl83EUQcsHn6GaURU59rKMrJ0GsvrpXOtnvMMmFnD4cfaobBhuoXyXwvqT6u2llt3KWXWuF4M
 XnFV4PMsFlr6fT7YtWnQtupCwYnENekx4zb6R7ac1m2ZkupcVTFANTWmyiUsho0hkpclB+fc0OB
 mDcm9rAnNcVN2IYxAZaUb8G2eRzHBNOxE+Q4
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id
 5b1f17b1804b1-4bb8881eea5mr456177705e9.27.1795737953420; 
 Thu, 26 Nov 2026 16:05:53 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm752070015e9.11.2026.11.26.16.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 16:05:52 -0800 (PST)
Message-ID: <07e54333-2391-4e8f-8819-fa431d981430@gmail.com>
Date: Fri, 27 Nov 2026 00:05:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v4 2/3] drm/amd/display: unlock secondary tile on Apple 4K/5K
 iMac panels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
iMac18,3, Polaris-based iMac19,1) Retina iMacs expose their internal
panel as a 2x1 tiled display over an eDP root link and a secondary DP
link. At boot, the panel TCON operates in single-pipe mode and holds the
secondary DP link's HPD line low until unlocked via DPCD registers.

Enable native tiled detection and link training for DCE < 12 Apple 4K/5K
Retina iMac panels:
- Latch the root eDP link via DPCD 0x4F1 prior to reading its EDID in
  dm_helpers_read_local_edid() on Apple hardware (DCE < 12) so the
  TCON exposes its full DisplayID tile properties even when Apple and
  OpenCore Legacy Patcher (OCLP) EFI folders are absent.
- Point the secondary DP dc_link to the root eDP dc_link
  (apple_tcon_peer) during EDID quirk matching on DCE < 12 iMac15,1
  (AE01/02), iMac17,1 (AE05/06), iMac18,3 (AE11/12), iMac18,2/19,2
  (AE19/1A), and Polaris-based iMac19,1 (AE25/26), checking
  connector_signal since panel IDs can flip across the two links after
  S3 wake. DCE >= 12 support for Vega-based iMac19,1, iMacPro1,1, and
  iMac20,x is documented as TODO.
- Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
  on the root eDP link when probing the secondary link, allowing the
  secondary link to read its EDID and populate DRM's DisplayID tile
  properties (has_tile, tile_group, and tile_is_single_monitor).
- Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
  0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
- Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
  and DP_EDP_CONFIGURATION_SET (0x10A) in amdgpu_dm_apple_tcon_unlatch()
  during dm_suspend() so the TCON returns to single-pipe mode for the
  EFI boot screen across reboots.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
 .../dc/link/protocols/link_dp_capability.c    |  4 +++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d2201285888..6275a585593c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1610,6 +1610,23 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_destroy_cached_state);
 
+static void amdgpu_dm_apple_imac_unlatch(struct dc *dc)
+{
+	const u8 zeros[3] = { 0 };
+
+	for (int i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (link->apple_imac_peer) {
+			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
+			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
+			core_link_write_dpcd(link, 0x4F1, zeros, 1);
+			core_link_write_dpcd(link->apple_imac_peer, 0x4F1, zeros, 1);
+			break;
+		}
+	}
+}
+
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1677,6 +1694,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 
+	amdgpu_dm_apple_imac_unlatch(dm->dc);
+
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
 	if (dm->dc->caps.ips_support && adev->in_s0ix)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6192c0f6086d..0863628c9d67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
+#include <linux/dmi.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_probe_helper.h>
@@ -173,6 +174,31 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
 		edid_caps->panel_patch.force_freesync_min_hz = 60;
 		break;
+	/*
+	 * Workaround for Apple 21.5" 4K and 27" 5K iMac 2x1 tiled panels
+	 * (eDP root + secondary DP). Point secondary->apple_imac_peer to root
+	 * so detection/suspend can latch/unlatch the TCON via DPCD; match both
+	 * single/tiled IDs and gate on eDP so only root sets the peer.
+	 * IDs (Single/Tiled): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
+	 * iMac18,3 (AE11/12), iMac18,2/19,2 (AE19/1A), iMac19,1 (AE25/26);
+	 * TODO (DCE >= 12): iMac19,1/19,2 Vega, iMacPro1,1 (AE1D/1E),
+	 * iMac20,x (AE31/32, AE35/36).
+	 */
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE19):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE1A):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
+		if (link->connector_signal == SIGNAL_TYPE_EDP &&
+		    link->ctx->dce_version < DCE_VERSION_12_0 &&
+		    (link->link_index ^ 1) < link->dc->link_count)
+			link->dc->links[link->link_index ^ 1]->apple_imac_peer = link;
+		break;
 	default:
 		return;
 	}
@@ -1299,6 +1325,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	if (link->dc->hwss.prepare_ddc)
 		link->dc->hwss.prepare_ddc(link);
 
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->ctx->dce_version < DCE_VERSION_12_0 &&
+	    dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
+		const char *product = dmi_get_system_info(DMI_PRODUCT_NAME);
+
+		if (product && str_has_prefix(product, "iMac"))
+			dm_helpers_dp_write_dpcd(ctx, link, 0x4F1, &(const uint8_t){1}, 1);
+	}
+
 	dm_helpers_wait_for_edid_ready(link, ddc);
 
 	/* some dongles read edid incorrectly the first time,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8471dcfe24fd..bd3857267331 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2018,6 +2018,7 @@ struct dc_scratch_space {
 	bool skip_implict_edp_power_control;
 	bool forced_psr_active;
 	enum backlight_control_type backlight_control_type;
+	struct dc_link *apple_imac_peer;
 };
 
 struct dc {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 5b257f003f13..02c6e5874c16 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -218,7 +218,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 			 * we assume signal is DVI; it could be corrected
 			 * to HDMI after dongle detection
 			 */
-			if (!dm_helpers_is_dp_sink_present(link))
+			if (!link->apple_imac_peer && !dm_helpers_is_dp_sink_present(link))
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		}
 		break;
@@ -1651,6 +1651,11 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		}
 	}
 
+	if (*type == dc_connection_none && link->apple_imac_peer) {
+		core_link_write_dpcd(link->apple_imac_peer, 0x4F1, &(const uint8_t){1}, 1);
+		*type = dc_connection_single;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c487c5b87dfd..74954702c5a9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 				link->dc->vendor_signature.data.raw,
 				sizeof(link->dc->vendor_signature.data.raw));
 	}
+
+	if (link->apple_imac_peer)
+		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
+				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
 }
 
 void dpcd_write_cable_id_to_dprx(struct dc_link *link)
-- 
2.55.0
