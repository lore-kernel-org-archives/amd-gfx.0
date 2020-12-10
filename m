Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF9C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D512022AAF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512022AAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A2D6EAD1;
	Thu, 10 Dec 2020 18:48:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B626F6EAD1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 18:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUeeHVdLWVryW8iZr81W52EKTgnVV+pmPuAFqVL7ATmX4rEbCu+WFXtB31Lvj+DBvjlp7vH1wz5EP5gi7d4jtwlS8JQkQUCC/Xqo2wNjD+RtIuuDrjTy51Lkq54/8S3NVFEorKzJ40cA9Kz+Ly81KY3fBBeNIAU2jDryHr92RUqRfrOmEk6RJ+vC929a8xGayQSwSrAlHBOnq2ucFKR/fEztgOQ5zbIBXkNKe38+kHAhT2ynZqugvRgjurzKA8qeceyqsyTbNWC80LeA/3e8cHEenBvBEmUPypM4IcIG9tx2QGJ7obz3xc5wLp7X4rg4BrjbRdH+KXuVQK5WU8VB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4koSxNBuNUqhSBi972sBWWHkhpmvQIw/7uFBTWeu7QQ=;
 b=N5nEAM7thrdrUttdkJGmnn0U/mc9GDIjEZX6PnRnVwDlImR8pWtvSVcGT9LSgugbmIF/l2/Ovd2CPi/O2UXc8Zmzlkk9j+kKAMKXo0kg4fFa6C9PjhmfvA9JP3Lv39wR8RHLons5pYV/XH4zJi8vvVsxzqH9puQMlef+GKJKQDgl4I+pdyjSgP/6d1yvvyA2JihxDTxc6zW0PhvPF1RpfA95eGNzNrxyrJUq2wfTvkTx/cj5REF9fA6A1K6ZIwMZqkhN1BgVxxZ4oPioLeWFBZkCr8bFr0jOvOIyEnn2KQKZDChiWPVcagqE6IwK8AfeGEmpaQEJ6hZHG0KQjebmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4koSxNBuNUqhSBi972sBWWHkhpmvQIw/7uFBTWeu7QQ=;
 b=JwX2goAf8qDhEw9c5DNfVG9wBS3uhQBWf740hKGnMumV4BsJjcIyAwkdj1gMg0ht9e/y1qzRf7MT7xCq+ig4xrjJ9Opm/1mQ0GMP3ep5jyEUzgwhNRluEbemnVZbn789VLg6rJGeuTJrhajWtpMI0AtUCdZ0tH31H1wRyp/1t+I=
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by BY5PR12MB3699.namprd12.prod.outlook.com (2603:10b6:a03:195::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 18:48:27 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::24) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 18:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 18:48:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:27 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:26 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Dec 2020 12:48:26 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd/display: Add freesync video modes based on
 preferred modes
Date: Thu, 10 Dec 2020 13:48:22 -0500
Message-ID: <20201210184823.285415-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210184823.285415-1-aurabindo.pillai@amd.com>
References: <20201210184823.285415-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 144e6b0b-5fbe-4d48-3582-08d89d3c2e82
X-MS-TrafficTypeDiagnostic: BY5PR12MB3699:
X-Microsoft-Antispam-PRVS: <BY5PR12MB36991DAABA7D6CDDB27A52BC8BCB0@BY5PR12MB3699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CwBCoSw+B8ePIlRT/qiNFbHWWf/JZ+SlQoW7trO9dEOZsCq8LVxRJsdD+TRunIdnAKsq2i3TcKKOeRQq9Zmr//p6hY3wM9t03EyZJ2X5RZS46vcNlP+w4A6A0Ds6imMpg6K0T3EUqB36Mp9nI1R42mvOfT+wO6ym8nlGy+C/6b89RtlBcK4S6giBbKOgGy4HwqdzJWtZxjTn9UhYDBHfZdf64oZD3vTn54HRduAE4pxh0AAF7MBKAgJFXYMwRv/vxgPuSRUyiW71BuSx+53LII88JYLnVQ5SxTLCsS8TK6eI8mAL/eEWV2bhsNnCiHUXMq1SvhWqpmzREorQ+zsBT+1yqHpvcsvqi0O8RjrctAIvW/49+vVdMxwskDMIxEAM3KabHaT8mt27oZXYYAzEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(46966005)(81166007)(8676002)(83380400001)(86362001)(54906003)(70586007)(82310400003)(426003)(508600001)(44832011)(70206006)(336012)(2906002)(7696005)(186003)(1076003)(356005)(2616005)(6916009)(47076004)(8936002)(5660300002)(36756003)(4326008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 18:48:27.6359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144e6b0b-5fbe-4d48-3582-08d89d3c2e82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3699
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
Cc: stylon.wang@amd.com, shashank.sharma@amd.com, thong.thai@amd.com,
 aurabindo.pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
 Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
If experimental freesync video mode module parameter is enabled, add
few extra display modes into the driver's mode list corresponding to common
video frame rates. When userspace sets these modes, no modeset will be
performed (if current mode was one of freesync modes or the base freesync mode
based off which timings have been generated for the rest of the freesync modes)
since these modes only differ from the base mode with front porch timing.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbff8d693e03..d15453b400d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5178,6 +5178,54 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 	set_master_stream(context->streams, context->stream_count);
 }
 
+static struct drm_display_mode *
+get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
+			  bool use_probed_modes)
+{
+	struct drm_display_mode *m, *m_high = NULL;
+	u16 current_refresh, highest_refresh;
+	struct list_head *list_head = use_probed_modes ?
+						    &aconnector->base.probed_modes :
+						    &aconnector->base.modes;
+	/* Find the preferred mode */
+	list_for_each_entry (m, list_head, head) {
+		if (!(m->type & DRM_MODE_TYPE_PREFERRED))
+			continue;
+
+		m_high = m;
+		highest_refresh = drm_mode_vrefresh(m_high);
+		break;
+	}
+
+	if (!m_high) {
+		/* Probably an EDID with no preferred mode. Fallback to first entry */
+		m_high = list_first_entry_or_null(&aconnector->base.modes,
+						  struct drm_display_mode, head);
+		if (!m_high)
+			return NULL;
+		else
+			highest_refresh = drm_mode_vrefresh(m_high);
+	}
+
+	/*
+	 * Find the mode with highest refresh rate with same resolution.
+	 * For some monitors, preferred mode is not the mode with highest
+	 * supported refresh rate.
+	 */
+	list_for_each_entry (m, list_head, head) {
+		current_refresh  = drm_mode_vrefresh(m);
+
+		if (m->hdisplay == m_high->hdisplay &&
+		    m->vdisplay == m_high->vdisplay &&
+		    highest_refresh < current_refresh) {
+			highest_refresh = current_refresh;
+			m_high = m;
+		}
+	}
+
+	return m_high;
+}
+
 static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
@@ -7006,6 +7054,124 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 	}
 }
 
+static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
+			      struct drm_display_mode *mode)
+{
+	struct drm_display_mode *m;
+
+	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+		if (drm_mode_equal(m, mode))
+			return true;
+	}
+
+	return false;
+}
+
+static uint add_fs_modes(struct amdgpu_dm_connector *aconnector,
+			 struct detailed_data_monitor_range *range)
+{
+	const struct drm_display_mode *m, *m_save;
+	struct drm_display_mode *new_mode;
+	uint i;
+	uint64_t target_vtotal, target_vtotal_diff;
+	uint32_t new_modes_count = 0;
+	uint64_t num, den;
+
+	/* Standard FPS values
+	 *
+	 * 23.976 - TV/NTSC
+	 * 24	  - Cinema
+	 * 25     - TV/PAL
+	 * 29.97  - TV/NTSC
+	 * 30     - TV/NTSC
+	 * 48	  - Cinema HFR
+	 * 50	  - TV/PAL
+	 */
+	const uint32_t neededrates[] = { 23976, 24000, 25000, 29970,
+					 30000, 48000, 50000, 72000, 96000 };
+
+	/*
+	 * Find mode with highest refresh rate with the same resolution
+	 * as the preferred mode. Some monitors report a preferred mode
+	 * with lower resolution than the highest refresh rate supported.
+	 */
+
+	m_save = get_highest_refresh_rate_mode(aconnector, true);
+	if (!m_save)
+		goto out;
+
+	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+		if (m != m_save)
+			continue;
+
+		for (i = 0; i < sizeof(neededrates) / sizeof(uint32_t); i++) {
+			if (drm_mode_vrefresh(m) * 1000 < neededrates[i])
+				continue;
+
+			if (neededrates[i] < range->min_vfreq * 1000)
+				continue;
+
+			num = (unsigned long long)m->clock * 1000 * 1000;
+			den = neededrates[i] * (unsigned long long)m->htotal;
+			target_vtotal = div_u64(num, den);
+			target_vtotal_diff = target_vtotal - m->vtotal;
+
+			/* Check for illegal modes */
+			if (m->vsync_start + target_vtotal_diff < m->vdisplay ||
+			    m->vsync_end + target_vtotal_diff < m->vsync_start ||
+			    m->vtotal + target_vtotal_diff < m->vsync_end)
+				continue;
+
+			new_mode = drm_mode_duplicate(aconnector->base.dev, m);
+			if (!new_mode)
+				goto out;
+
+			new_mode->vtotal += (u16)target_vtotal_diff;
+			new_mode->vsync_start += (u16)target_vtotal_diff;
+			new_mode->vsync_end += (u16)target_vtotal_diff;
+			new_mode->type &= ~DRM_MODE_TYPE_PREFERRED;
+			new_mode->type |= DRM_MODE_TYPE_DRIVER;
+
+			if (!is_duplicate_mode(aconnector, new_mode)) {
+				drm_mode_probed_add(&aconnector->base, new_mode);
+				new_modes_count += 1;
+			} else
+				drm_mode_destroy(aconnector->base.dev, new_mode);
+		}
+	}
+ out:
+	return new_modes_count;
+}
+
+static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
+						   struct edid *edid)
+{
+	uint8_t i;
+	struct detailed_timing *timing;
+	struct detailed_non_pixel *data;
+	struct detailed_data_monitor_range *range;
+	struct amdgpu_dm_connector *amdgpu_dm_connector =
+		to_amdgpu_dm_connector(connector);
+
+	if (!(amdgpu_exp_freesync_vid_mode && edid))
+		return;
+
+	if (edid->version == 1 && edid->revision > 1) {
+		for (i = 0; i < 4; i++) {
+			timing = &edid->detailed_timings[i];
+			data = &timing->data.other_data;
+			range = &data->data.range;
+
+			/* Check if monitor has continuous frequency mode */
+			if (data->type == EDID_DETAIL_MONITOR_RANGE &&
+			    range->max_vfreq - range->min_vfreq > 10) {
+				amdgpu_dm_connector->num_modes += add_fs_modes(amdgpu_dm_connector, range);
+				break;
+			}
+		}
+	}
+}
+
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -7021,6 +7187,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
 		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
