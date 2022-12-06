Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F4AC47089
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 08:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454DC10E371;
	Wed,  7 Dec 2022 08:09:16 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Wed, 07 Dec 2022 01:08:54 UTC
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16D710E163;
 Wed,  7 Dec 2022 01:08:54 +0000 (UTC)
X-UUID: 1d9768ea3ee7409fbadf070d522c1465-20221206
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 108 audit/email.address 1 dict/adv 1
 dict/notice 1 meta/cnt.alert 1
X-CPASD-INFO: 39af155ca83541728b69beb22f595b1b@fImbhl5nY5ONWHWBg3SCbFiTZmmSkYK
 BdKBVaWOSXYKVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3gnubhmFjZQ==
X-CLOUD-ID: 39af155ca83541728b69beb22f595b1b
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:184.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:284.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:0.0, SPC:0,
 SIG:-
 5, AUF:0, DUF:10036, ACD:163, DCD:163, SL:0, EISP:0, AG:0, CFC:0.383,
 CFSR:0.082, UAT:0
 , RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM: 0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 1d9768ea3ee7409fbadf070d522c1465-20221206
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 1d9768ea3ee7409fbadf070d522c1465-20221206
X-User: xurui@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <xurui@kylinos.cn>) (Generic MTA)
 with ESMTP id 1051931821; Tue, 06 Dec 2022 15:31:35 +0800
From: xurui <xurui@kylinos.cn>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Retry DDC probing on DVI on failure if we got an
 HPD interrupt
Date: Tue,  6 Dec 2022 15:31:56 +0800
Message-Id: <20221206073156.43453-1-xurui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Dec 2022 08:09:13 +0000
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
Cc: tzimmermann@suse.de, guchun.chen@amd.com, airlied@gmail.com,
 Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, sam@ravnborg.org, aurabindo.pillai@amd.com,
 cssk@net-c.es, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 xurui <xurui@kylinos.cn>, harry.wentland@amd.com, christian.koenig@amd.com,
 ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HPD signals on DVI ports can be fired off before the pins required for
DDC probing actually make contact, due to the pins for HPD making
contact first. This results in a HPD signal being asserted but DDC
probing failing, resulting in hotplugging occasionally failing.

Rescheduling the hotplug work for a second when we run into an HPD
signal with a failing DDC probe usually gives enough time for the rest
of the connector's pins to make contact, and fixes this issue.

Signed-off-by: xurui <xurui@kylinos.cn>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 22 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index cfb262911bfc..dd8d414249a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -997,13 +997,33 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 		}
 	}
 
+	if (amdgpu_connector->detected_hpd_without_ddc) {
+		force = true;
+		amdgpu_connector->detected_hpd_without_ddc = false;
+	}
+
 	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
 		ret = connector->status;
 		goto exit;
 	}
 
-	if (amdgpu_connector->ddc_bus)
+	if (amdgpu_connector->ddc_bus) {
 		dret = amdgpu_display_ddc_probe(amdgpu_connector, false);
+
+		/* Sometimes the pins required for the DDC probe on DVI
+		 * connectors don't make contact at the same time that the ones
+		 * for HPD do. If the DDC probe fails even though we had an HPD
+		 * signal, try again later
+		 */
+		if (!dret && !force &&
+		    amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
+			DRM_DEBUG_KMS("hpd detected without ddc, retrying in 1 second\n");
+			amdgpu_connector->detected_hpd_without_ddc = true;
+			schedule_delayed_work(&adev->hotplug_work,
+					      msecs_to_jiffies(1000));
+			goto exit;
+		}
+	}
 	if (dret) {
 		amdgpu_connector->detected_by_load = false;
 		amdgpu_connector_free_edid(connector);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 37322550d750..bf009de59710 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -535,6 +535,7 @@ struct amdgpu_connector {
 	void *con_priv;
 	bool dac_load_detect;
 	bool detected_by_load; /* if the connection status was determined by load */
+	bool detected_hpd_without_ddc; /* if an HPD signal was detected on DVI, but ddc probing failed */
 	uint16_t connector_object_id;
 	struct amdgpu_hpd hpd;
 	struct amdgpu_router router;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
