Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661ABD31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C7A10E5E1;
	Wed, 14 Jan 2026 08:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxhMTMNm";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EB410E553
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:41:10 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64b5b68a9bdso1334398a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768340469; x=1768945269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TVnYGVRm+Z+bM0lIMVs1bFQFPxij1W9a0LrjLJBefs=;
 b=CxhMTMNmKWAlLcx8pH89Db6oNIjsWwlyVpxE0it2E9hd1yZtuI+hPISqhaIqSrVRId
 U4U4jiBwY6YnbPmX0mFHH3hEXDW+spt6pEUvxUqg5eavvqMkl3x7V39Xf4JF96hZ2fzt
 U3FpLmhaHyd0BLBRZaZlatcwkzAxI2e8riphqhxBqzTNyP5BPQiBGWl2wIfTJercRdsX
 VKCvLVaxRT6WV1GtW9Zn4AluP02pHCMF/4u4qz0D+yszEZpHq9y7mlZMxM9zESAlXWbj
 PTAhB4nlbayzu7IXUuQgTPxI868Xj4EhI8N/1HwIdN9Wp2B1Awa5chsp8R1GsugMdJbe
 V32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768340469; x=1768945269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5TVnYGVRm+Z+bM0lIMVs1bFQFPxij1W9a0LrjLJBefs=;
 b=FkFG0sx4OVc4laOG0BrqTXlXT5yXRJLgrW5MLId0kd6/zgY1H0ddT9dl+jcjVyp1Ll
 djpcBQYEi+0L6i3xxTBmK5nP9a2L5gvTVomgQE8uEu0Rrb+ny+wdhYK/kVHuVDDbHCid
 DOm2tsD/qG0N9j31S8opuHczPmfSKWwiDsITmy7kmNDYfChFqtdVu0YiEJusyuJmNAm0
 arBg3TntkRnL23xo1O8lBwde0SDuggwkcv713p+HWKk4+SyA+0sdXorabf/RycrlzsLQ
 Fj7CGo8vUpOUCWLu7sEQYWPGWteBBhOHL03WU+Do/mE+W2ZbExhyPYZ0zq3KO8SEpqEP
 UufQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv68MrQDym5LXqbogUmf6ysC+/9k9lVZmUpCpJI+bw/+qDcTKcpyHeHc6sKwlHzXtsYAEG2P9i@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnW2HR2M2maA0/uL9ZiGKGjQ2r3KyGgoyH+E/SElrUT4dVhiCy
 UmR56vlJXLq6N7QdCHXzaQCUkN7f5GdGsAtCCckwpJGp+Y4pwOxahgI9
X-Gm-Gg: AY/fxX7hsWr3B744svTnKE+EOjPAwofnTXI0Tm2uHo9JRyyOtMYBZHvjTFseqy/H4q9
 LXymx8Sk9NaomKa6WH8MgBOKXbME7UFXYBZCYfhOtXUtsoEQndBDja3/XWJIil8L/Y/bCgTO33K
 PsNXzD2/hT1bzJh9cQQuuhPeS+Xqt1ewDEqWYfBOga8k7MdeNJ6HTys1LUSeMBHUEe8Gcv4LZO2
 FsxcoqShL8UPxF6LsUssU49I0LtIa3lIjCtY0hCAEkRnxtHhr1RtbcbMG8q4PnkpVYMxzaqWZ7a
 OXJB1uXgsitHC11oUll46cPTjkKQBj4jfcBMBJGh0g8JbFZF8yC9shbUWtG8YxOWq4tmUtAynmK
 c4MCZGdAW1ZT0jefcp2x26AFvg32spzBnNQZigiNoPS6HQa2lwUyMTz5+moyKMwmF3LsPXyBZa6
 QjwCjOExEOm4Y6YPLJomYWD9cvnDl5OwCGOz265JxGYdbPaQAYp/2SPB0Hy6Jq67Ax
X-Received: by 2002:a05:6402:2816:b0:645:7d1b:e151 with SMTP id
 4fb4d7f45d1cf-653ec1086d0mr204044a12.1.1768340469025; 
 Tue, 13 Jan 2026 13:41:09 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d5e0sm20858052a12.31.2026.01.13.13.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 13:41:08 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amd/display: rename PCON adaptive sync types
Date: Tue, 13 Jan 2026 22:41:03 +0100
Message-ID: <20260113214104.146856-3-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Jan 2026 08:29:27 +0000
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

Make the name more generic for the upcoming HDMI VRR over PCON
implementation

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c     | 2 +-
 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h     | 4 ++--
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7fe40bbba265..1318d88687ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9342,7 +9342,7 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+	if (aconn && (aconn->as_type == ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
@@ -13003,7 +13003,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
+	if (as_type == ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d0f770dd0a95..63dc9382c48e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1393,7 +1393,7 @@ enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
 		if (dpcd_caps->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT == true &&
 			dpcd_caps->allow_invalid_MSA_timing_param == true &&
 			dm_is_freesync_pcon_whitelist(dpcd_caps->branch_dev_id))
-			as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
+			as_type = ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 66dc9a19aebe..91fe039c0c95 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -44,8 +44,8 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 enum adaptive_sync_type {
 	ADAPTIVE_SYNC_TYPE_NONE                  = 0,
 	ADAPTIVE_SYNC_TYPE_DP                    = 1,
-	FREESYNC_TYPE_PCON_IN_WHITELIST          = 2,
-	FREESYNC_TYPE_PCON_NOT_IN_WHITELIST      = 3,
+	ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST     = 2,
+	ADAPTIVE_SYNC_TYPE_PCON_NOT_IN_WHITELIST = 3,
 	ADAPTIVE_SYNC_TYPE_EDP                   = 4,
 };
 
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index b3d55cac3569..429bc0ab86d6 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -535,12 +535,12 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		if (stream != NULL)
 			mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
 		break;
-	case FREESYNC_TYPE_PCON_IN_WHITELIST:
+	case ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST:
 	case ADAPTIVE_SYNC_TYPE_EDP:
 		mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
-	case FREESYNC_TYPE_PCON_NOT_IN_WHITELIST:
+	case ADAPTIVE_SYNC_TYPE_PCON_NOT_IN_WHITELIST:
 	default:
 		break;
 	}
-- 
2.52.0

