Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD36DE68151
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860B610E48B;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JqsEv0Km";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D3710E3B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:25 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8fc023934dso18311666b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260323; x=1771865123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CU4lePUCCJ3xj5OwOvFkst/VeREzzL5189XbX5ib9YU=;
 b=JqsEv0Km48LNpFhiBtUrIj04x/ezCqAWqa3weH+iADk4WbXdXdeHSwkNfdRO9VQ2II
 EcpN8MGdl+yI7MpLnrBlLVqd89cuet1wWDsrwv3zOJQSuf3Jhv3EUwbmwoChaMuzpf7/
 +8+f/vwnXx6Q/m+he70e02UOIxTvps64pcukvz42KdbRDUnskSI2mP83LCp+Vf+iUU0U
 pbJc3UhC3dAi1OgKXBFdHAa/BTXYT65691S5fUwDFUnbQa2G2YJODt7pVESXAchZBVa3
 pW4KJdTaM8Ujvsq2xCata0gCemZxJBrPuMPf4XF0ROLdGaVQOD3C45XiWB8cye0t4lso
 0qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260323; x=1771865123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CU4lePUCCJ3xj5OwOvFkst/VeREzzL5189XbX5ib9YU=;
 b=NysinJaBRTFoOt3Pe8d6YEBgb58KZAUcKdpNva03XoYQJpqwxA9BSfLiafYI5XJ4Q1
 B9ez4esNw+Twk5PoSvgof87Mc+/caFO6wgRwmOkL5b6UTKOoG1qxQx06W/83yLlEbjO1
 f/suzcaGUThpoE+7Ix6uTebmL092xpCisHZuiP0H1I0ASd6pfVMpSrgFSMo3h9gPkqgD
 ihRP+eZf+hLByTkJfXRmq+0u9NM63BVGUeO4xOHZYZs3aJPNDtFrgHOxAYkeab2gqAx7
 XinZ6dKzGQXYx4ZsuePCyR0cAHJUSMb5SlWxqUuNc6lyIP0DaVegn+MCrKtMWeIyjpw6
 1r3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Pqj8F25196cbIoJEzqQe1ltgBmaDjiWtNWjxDo6uedKADbfZK5NaDxwkN7u+FHu/kZzRj/SS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSXPNMrRM8+720AO9A/2vaYQJmFp+4g9Q/DCA3jDOAUPVahp6l
 gx4C3NOvErtQOnz9kQ//ubR5R7K8l82kxBmtzqz2Xf99kBIJkqO5qtBi
X-Gm-Gg: AZuq6aIFfqub2OQY8LAzpklnU4WjXLmGiw5N1eRLCCynS1O9MQA+l+fQdivxkW37vJr
 kH/EUNpMRTMTxoQvhsBTC6Evt2+bSIoiSJS5BGfJTiUoFKuqPscval8HTnputh3tCij3Ulqe/SX
 eu+MECD/jimM05Ydgwol80l98bq8Q8qAwBOCdxA6rOeQ9SG48Sy7drguQDBiQCvxtWruy5Ee3Zl
 vefhqePXqs1hr9zHUZxkXSaCLjRWYfMGwk0J6bG5EyK92XJQnnStSgKsHGHZmtYsLe5vBheDC7d
 pMDytilI5oAEI++XEzkNePC1ixdnTiHf8HNhYQ3T5VYqc1hZ5pEbafW6x6eGv8JBrrBz+YaHjbC
 B6amOKH/z1sZTcnb+WKutC3pPEQKzOsmhgnWEd/EZ1fVnG5OPqEjr081tOhLPinHi0p0wFWtjMB
 7+FM273A8gXVAJkHPBMSTgcTxUqjBM4XF8DLN3Q/ZGPXRhAGhlAyYi2Dp3q+D3Av79rKz68ZyAj
 oVm
X-Received: by 2002:a17:906:c108:b0:b8e:9ac2:9e0d with SMTP id
 a640c23a62f3a-b8face3fd6fmr326171166b.8.1771260323206; 
 Mon, 16 Feb 2026 08:45:23 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:22 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 03/27] drm/amd/display: Remove redundant edid checks
Date: Mon, 16 Feb 2026 17:44:52 +0100
Message-ID: <20260216164516.36803-4-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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

[Why]
Edid parsing functions check if edid is not null themselves. In a case
where edid is not present, the structs will be left initialised to 0
so anu possible assigment won't change the detected (or undetected)
functionality.

[How]
Remove edid pointer checks

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6218ad911fde..903264b26d1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13330,8 +13330,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (is_monitor_range_invalid(connector))
 		parse_edid_displayid_vrr(connector, edid);
 
-	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
-		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
+	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    sink->sink_signal == SIGNAL_TYPE_EDP) {
 
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
@@ -13344,8 +13344,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
-	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
-		   drm_edid) {
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
 		if (vsdb_info.freesync_supported) {
 			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
@@ -13356,7 +13355,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && drm_edid) {
+	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
 		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
 		if (vsdb_info.freesync_supported) {
 			amdgpu_dm_connector->pack_sdp_v1_3 = true;
-- 
2.53.0

