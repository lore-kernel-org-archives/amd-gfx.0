Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA06C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18C0239D1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18C0239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927826E2D1;
	Thu, 10 Dec 2020 02:45:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08B96E2D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPTZCT1Rv0VVG1bQ+4WXlVBoEHU+pCLqgbvxDdfbfkTwk4dG9B2rupaKYHfC1GC8nK1eOjHqlreovy+qk5EvCpH2zjKyrzB7zUZ9A4eGDlkcGc6KD4bze/TNRbRYzbRCbXfnQn5iCq+Qeqlj9KLlQN9RXJvcm3/rBDnO5U7hnf1UaUUzdLZ+oCNSIhjodlAPTk+mNtK7Pgpl20LOKg/eZ2ihTB0v/nL1METUCNZwiRfOPC81biB2S0ZbTFTXbcD/k1bGCbewpP6W8hCDO9Lq2WZbj3G7CobwsHOLFTCWrFs8iIZe3wmhXFSFUqgZ3N22FYn2ZR5GjLChg0iI84YCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBI3lNJ6tN8ky5wQ7qXTyuOYoZxosqUZwPOB3sA224=;
 b=SwVojpzNwhp3XuUwjxmRWjd+5yGaqvYBIxmjHr1SaDVbgzuyE1VGY0KPVdtTrwrmk86WQ3ip4Q9EjPftaBwLmxBePQ2WpZUTz/4hHgXTFYPpzExNRfKmzUHGl6I5yUgXGTZpy3d3yjFjZVQkBZo+4VNDgxtB7SsGr3HvAqC0smeoQWlQ4k9h4ns1kYOR+ddjpIn68BUSfYL3ydluSPuNlPJpheDAIgTghYXpBtZTcC96oMwRA/0h2zvFm6jePMbqzXZLwDH51ii6PegLHU8PYjoXmJuEduPMOz2+G47NC1zDoMUgSOUwajSsF3+Tqqi+KXJ2SEX+B/QGWjlqPKrA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBI3lNJ6tN8ky5wQ7qXTyuOYoZxosqUZwPOB3sA224=;
 b=sGnq/rdr221h80hiquc7SUe6fwGP6j3ht3wu+3hehAxk3ls3M45M3hSErOi0FihrPK1lUZf5ZmChXuODoh2Vv+18C0h6RZ329dJh7VrLrQqmTYSrCbYcBFbfh02okRJq8kFQAyoMt57Mwn26JH7tjXDSxYniv312kuUn3xJTnV8=
Received: from MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) by DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 02:45:32 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::cf) by MWHPR1701CA0011.outlook.office365.com
 (2603:10b6:301:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 02:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 02:45:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:30 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:30 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Dec 2020 20:45:29 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/display: Add freesync video modes based on
 preferred modes
Date: Wed, 9 Dec 2020 21:45:25 -0500
Message-ID: <20201210024526.1151447-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1968483-70f7-41ca-6748-08d89cb5a95e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865BBAC7ACCB8C67EE67ADC8BCB0@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLNGYa7UOfFTqV0Tl70pdMaFnmNTInHNA2+Sf85dlEqMnmCTuOUFFife1Lu0BhXqHmOddxCiiqb6vpEHyquDbp/mIrJNCO6ZeEFYsd1dzNrmbAsBMURc083GI5ECZzrkSR4Ag8DAmcqeMTXvMBeFa7xqabLFKnR+8Uu7OnDvLh9eHUNdJMwrjXU9lOy5olVs5+u/geTVvm+gatYQ0I0K4XB1XHbYC2e3pr1wlnEoDIes95vW3Fe9N+C1Sfu6K/+c/Cyzc9mX6+STqVumPnU+GayxXzyDbqOMMwj2pCsd5V3afz4VaJYUZ0z0nnG7EC5PfuWqJ99QoiHFP6yrpli/E1yKscu1FjqXYGAgbQSi5FEyOd3i9rjwMLC+Mf4afrfwPs0f0rHPDseju/8phKu6aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(47076004)(44832011)(86362001)(54906003)(5660300002)(8936002)(70206006)(83380400001)(6666004)(36756003)(426003)(508600001)(6916009)(70586007)(8676002)(186003)(81166007)(26005)(2616005)(1076003)(2906002)(82310400003)(7696005)(336012)(4326008)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 02:45:31.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1968483-70f7-41ca-6748-08d89cb5a95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbff8d693e03..f699a3d41cad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5178,6 +5178,69 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 	set_master_stream(context->streams, context->stream_count);
 }
 
+static struct drm_display_mode *
+get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
+			  bool use_probed_modes)
+{
+	struct drm_display_mode *m, *m_high = NULL;
+	u16 current_refresh, highest_refresh, preferred_mode_h, preferred_mode_w;
+	struct list_head *list_head = use_probed_modes ?
+						    &aconnector->base.probed_modes :
+						    &aconnector->base.modes;
+
+	/*
+	 * Find the preferred mode
+	 */
+
+	list_for_each_entry (m, list_head, head) {
+		if (!(m->type & DRM_MODE_TYPE_PREFERRED))
+			continue;
+
+		m_high = m;
+		preferred_mode_h = m_high->hdisplay;
+		preferred_mode_w = m_high->vdisplay;
+		highest_refresh = drm_mode_vrefresh(m_high);
+		break;
+	}
+
+	if (!m_high) {
+
+		/*
+		 * Probably an EDID with no preferred mode.
+		 * Fallback to first entry;
+		 */
+		m_high = list_first_entry_or_null(&aconnector->base.modes,
+						  struct drm_display_mode, head);
+		if (!m_high)
+			return NULL;
+		else {
+			preferred_mode_h = m_high->hdisplay;
+			preferred_mode_w = m_high->vdisplay;
+			highest_refresh = drm_mode_vrefresh(m_high);
+		}
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
+		if (m->hdisplay == preferred_mode_h &&
+		    m->vdisplay == preferred_mode_w &&
+		    highest_refresh < current_refresh) {
+			highest_refresh = current_refresh;
+			preferred_mode_h = m->hdisplay;
+			preferred_mode_w = m->vdisplay;
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
@@ -7006,6 +7069,139 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 	}
 }
 
+static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
+			      struct drm_display_mode *mode)
+{
+	struct drm_display_mode *m;
+
+	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+		if (m->clock == mode->clock &&
+		    m->htotal == mode->htotal &&
+		    m->vtotal == mode->vtotal &&
+		    m->hdisplay == mode->hdisplay &&
+		    m->vdisplay == mode->vdisplay &&
+		    m->hsync_start == mode->hsync_start &&
+		    m->vsync_start == mode->vsync_start &&
+		    m->vsync_end == mode->vsync_end &&
+		    m->hsync_end == mode->hsync_end)
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
+	m_save = get_highest_freesync_mode(aconnector, true);
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
+			/*
+			 * Check for illegal modes
+			 */
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
+			strcat(new_mode->name, "_FSV\0");
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
+	if (!(amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP ||
+	      amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	      amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A))
+		return;
+
+	if (edid->version == 1 && edid->revision > 1) {
+		for (i = 0; i < 4; i++) {
+			timing = &edid->detailed_timings[i];
+			data = &timing->data.other_data;
+			range = &data->data.range;
+			/*
+			 * Check if monitor has continuous frequency mode
+			 */
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
@@ -7021,6 +7217,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
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
