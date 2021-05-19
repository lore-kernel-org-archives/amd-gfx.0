Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5BCC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629BD6100A
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629BD6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39E36EE82;
	Wed, 19 May 2021 20:12:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B946EE82
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFeLYi0kd6yn2GS8snXsI44biBb8yJkoqmQW0GnrYz89bA55QYwmWLyY456C0FZ374b+QAa2iOAdqiw0/hM5Sd7LgVzHZ76HJqTBa0UDFmjnd/1bMDWFZcYdgbD39staB8EvnIJYDmp1p4SVW/j1NvkNsWiBBstgdLNWl5F+NlYJZjXze1c5qzCn0CveTbLAt18rgHCwdeINnLIcmYedaFLjRK3aDNrtFGfhKTe1P1bF5JfsSj+PQfbFUvQwEr5VCudPAPRBlEaxQ+388WlPe+Z2c1LFknDQnHGvDm9j0v6Mkbx9mKP/ZSqOMaMWIJkvFLGauxwmQ7aGOTLstT30tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hf0YsyUfCVailxIIPvQ/Uzs9DYzKtxnAkyT0QH6b/g=;
 b=DInEuyxeFYUB8r1MDQ3ozqvbPLNlcMW2qTaiP1dO6kq+IKk5HblIhJ6nEpAi/88qXNqEoYIi54KYjPk/0k0tPozFCJZzJa1bRuXALBw1uyilQmKOCCbtpDvp5SVFSlNdrghRKi3HayT7fIv1ucFiiL4azmoZKkkJ95XQVW2PwD44A/xohRwKtFzaoObYi9laAf8l9bniTyaoqa5A7f+cVaZ/zOJy88Zt1JeFSSuPM8zyocxfYc9NfquavlnOvYAA3CIwmZIQNukaJzkYXERC3pTnC7RqFdsNc/wHitoNYIqnOZK6DaF42vkZqquVVoHjFbieOxfiWjVVEsyerABBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hf0YsyUfCVailxIIPvQ/Uzs9DYzKtxnAkyT0QH6b/g=;
 b=G+N+uOwJDkZiIqtnBmus2s8uBdYym5/0VRnbz+6bADNAgE+Gmi65ug54JEa+57YucOjKgCiCre8Cf+RH3P7iPaNWMlnx1hMYuzQlDy2Yacdmy0LdEfVGTXEZY2o56pTPDLi0MAjCXqUiLg6hOB52gCNykav9G/FtURGyjPILD3w=
Received: from DM5PR21CA0064.namprd21.prod.outlook.com (2603:10b6:3:129::26)
 by BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 20:12:43 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::a2) by DM5PR21CA0064.outlook.office365.com
 (2603:10b6:3:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.2 via Frontend
 Transport; Wed, 19 May 2021 20:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 20:12:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 15:12:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 15:12:42 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 19 May 2021 15:12:42 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix GPU scaling regression by FS video
 support
Date: Wed, 19 May 2021 16:12:19 -0400
Message-ID: <20210519201219.260847-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f252f107-4961-4d59-4df2-08d91b0275d9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2933:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2933BA212D647C7E2BFCCAD3EC2B9@BYAPR12MB2933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFrIuihFEoNsRpJVfwbzIltnqLkA8C8Bh0XJ/2KGYLgWu/aVjUija6IYV+JYArLIVgzqTxy3wki6J7S5ctItDZFyaBde6jqyVnQIAX7a5f+eGY+TOW0M5tDXUe+gnFqE1b5XMgVaq9EBPjmnqkGxqhw4VK5ccbP3ZhrlZz6Fz0jzYWViXT9Eohio5QlD26djGAAHZXVkELYaz2TYp9plUv3HZ3FK3orBKr+6GxK/ZmJxxvT+RDelrqimuQLVuDpXFAgrPSBJ54qXJnzDoYkjRQ4DZ3RqCSVKGjp0lHgxrQAvb42rcIRdY/a5hl28YIhG0BAydZHOkUl9/PK6kS2fLIAqdJ1U4BxZY+tfkjKEHsKCQBWJTPvXtrscPoepf7y5zGokcvcPE7HmoShgJKrIfBpzNVXcLExVj/baSV6EK5W82ZYeFQUyuF4OI1q4973kHtpGSOed0nWUGqHWlt8aHU8j7I+utAYvlzH8dkbMwmDRoWKDcbIMFtFeLYn1SKEAaBgZgcF0yrEKMITygoWINaaGfYbu1FK65pTYSsQzyZdhXNQKGz7uqn62MMWGinaHR4DS/fD23vhrJ8qg5aQjDwMWE3oqby6H2WVGHZ5R8fb2pKiLrY836e099q8AZk/3Ph5GSBfrAayo4UemS1nJ2OYE4j4O/kxVHJQO6F2Jy4Zoqk0WChSYeT/+GeaY40/e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(81166007)(356005)(336012)(2906002)(36756003)(8676002)(426003)(8936002)(2616005)(6916009)(70206006)(47076005)(1076003)(82310400003)(70586007)(4326008)(5660300002)(186003)(83380400001)(86362001)(26005)(82740400003)(36860700001)(6666004)(316002)(54906003)(478600001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:12:42.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f252f107-4961-4d59-4df2-08d91b0275d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
FS video support regressed GPU scaling and the scaled buffer ends up
stuck in the top left of the screen at native size - full, aspect,
center scaling modes do not function.

This is because decide_crtc_timing_for_drm_display_mode() does not
get called when scaling is enabled.

[How]
Split recalculate timing and scaling into two different flags.

We don't want to call drm_mode_set_crtcinfo() for scaling, but we
do want to call it for FS video.

Optimize and move preferred_refresh calculation next to
decide_crtc_timing_for_drm_display_mode() like it used to be since
that's not used for FS video.

We don't need to copy over the VIC or polarity in the case of FS video
modes because those don't change.

Fixes: a372f4abec ("drm/amd/display: Skip modeset for front porch change")

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cd270f129..759621b0e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5672,7 +5672,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	struct drm_display_mode saved_mode;
 	struct drm_display_mode *freesync_mode = NULL;
 	bool native_mode_found = false;
-	bool recalculate_timing = dm_state ? (dm_state->scaling != RMX_OFF) : false;
+	bool recalculate_timing = false;
+	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
 	int mode_refresh;
 	int preferred_refresh = 0;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -5735,7 +5736,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
-		recalculate_timing |= amdgpu_freesync_vid_mode &&
+		recalculate_timing = amdgpu_freesync_vid_mode &&
 				 is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
@@ -5743,11 +5744,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			mode = *freesync_mode;
 		} else {
 			decide_crtc_timing_for_drm_display_mode(
-				&mode, preferred_mode,
-				dm_state ? (dm_state->scaling != RMX_OFF) : false);
-		}
+				&mode, preferred_mode, scale);
 
-		preferred_refresh = drm_mode_vrefresh(preferred_mode);
+			preferred_refresh = drm_mode_vrefresh(preferred_mode);
+		}
 	}
 
 	if (recalculate_timing)
@@ -5759,7 +5759,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	* If scaling is enabled and refresh rate didn't change
 	* we copy the vic and polarities of the old timings
 	*/
-	if (!recalculate_timing || mode_refresh != preferred_refresh)
+	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
 			stream, &mode, &aconnector->base, con_state, NULL,
 			requested_bpc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
