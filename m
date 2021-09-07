Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9CFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DFE6109D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30DFE6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD5489F47;
	Tue,  7 Sep 2021 14:11:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D735F89F47
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 14:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isf5DSlxFGM+JYvx6e6mU4SY2s0OcBrvwTOuRSgcBl7Aw0ABq3EjesU00M1cOvIsSMOwNOwmNh8hsa5K3cbhA7LOeh6hMoCEnGUatqIVDR1++lx3/LN2FbvwRhTESoW4XOuZwLhThQTJAP610LHoAVe7OFcpkWSozLht/tNKOKf4Zzt90F0X6c/koyMSX5CbBexT4QK2tluBKmxhdNlVHZN6PZAZzhjTrEKj0RfUSAFrcyULITaqO19VLn4jFe4VTTjKhVVCDYpTp3Bs+RhO3kNS8sRtJm5UtoGZVFFIUHzniqMAtfSavKRPONF893bgJz1Cqd4ueGq/R/vmQtMFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eNcHxikYaXvooSnos9G6q4rsB9mixV80xiaAC4X/GYA=;
 b=HzZrvw1hrE++JMK++a+3E2iAATsR3EtMZWPj9Z7e2JBKJ/+u9uCB1u43ocVvXLEr5Z/4YJ86A+v53jxhFZRnX0exC/yURQF6pwywDAjkRvUMOYtvQYLsqYdzIgVFGejIifVBQGmyC7PjrHgj9W0kOkSaVpQeyomgwAjhR80P38xyMharipCE3xVVdHX2HsHxJOnjw7YRc/oXpk+40N25qhyOw+60b6N1wShYGl+ssVRv6hvRKM3DrrgiRp8YRbQz002WrvO6RuWBmgYDC7ZnWUKo3VWYeqHOQgSROWEzieXZhwNbhwP6jV5oZYnfJKV5YeIMvjP/NTGZYM5QI5Wlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNcHxikYaXvooSnos9G6q4rsB9mixV80xiaAC4X/GYA=;
 b=RYY2bccd33KZPu83ObAn8zL7PiRLAo5Dj0mttOhPbx7sIkx16efucVHQNx0904uIskyvXqLe6dufS8YvZb5B2Z8/FAsDvaH4fSND13MTzqqag9q7HHzeuZJtVqqXogv4xlRrbEPTv47M6gLCB+wrXmuoFKIeEIbXcWTtgmOb5eo=
Received: from DM5PR21CA0057.namprd21.prod.outlook.com (2603:10b6:3:129::19)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 7 Sep
 2021 14:11:06 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::30) by DM5PR21CA0057.outlook.office365.com
 (2603:10b6:3:129::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.0 via Frontend
 Transport; Tue, 7 Sep 2021 14:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 14:11:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 09:11:01 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 7 Sep 2021 09:11:00 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Roman Li
 <Roman.Li@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Harry Wentland
 <Harry.Wentland@amd.com>, Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH] drm/amd/display: Add NULL checks for vblank workqueue
Date: Tue, 7 Sep 2021 10:10:58 -0400
Message-ID: <20210907141058.90751-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e3a188-751a-4e8a-cf29-08d972095532
X-MS-TrafficTypeDiagnostic: CY4PR12MB1413:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1413B88A771F2639A76C012AECD39@CY4PR12MB1413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+U5VzSdoGWK1tIY9LxGq5NifeJSVyf84aTRVSQ7NwbSd4U9yRjHrbzMGmhh0uocP6Ig3u9mld4j5mSxM15HLAhgWIQ4LINC4BfiHKrb0xi+ES1SBGl4JdkmoS6409OJUuSCKDvR8F6Whn7rKApFrxr5WFUsKXWa+wt64TQfv9wD8PhB0mHBXIw9xLDSW3IUTuVZg+xxAFe6/ZLfkASi0xLNF8XWnO+Y5mWGJKIVi0XkyIwe7vxRYlHa3sojkVxRFcmOjNJEWEmxQ+2nBNPKmiHKZo8jerSlwR/Z4HX2QgdsCsPvDNu4ewWa/0hhNYK9KYmyIn2SvbvnF2xwCm1CN+MQRCtJbmea56VqAzhjeJpOKl0pWGd3fNmyVrbj2RLlHzmb1gFZAur1P3gt7Zp8pHGCRqghhczmnf1PoX4UtpRzpoHb0MSr8lxBJYGge+bVc+iNPtPO+ukMWHMBG1Vl+t5J/6TfBKhZ4SJD2Nti9IdVpDQmkR3aunTxUaQmsuCw8cypTZzh7gjE0+XozcN+bFReVBhCCNjQMZ+0gNaWcUkJqyzX5prvYBvNN1+Po3gAgj1ogX3cRwDuSDwgxMB3RP3OxeMScFd9mjMWGNHJxFdO7q1B+S1HorsqGr2mncBpYpmWSYDFxrfYey3Ob4ywU0eMXgsJ6TFVFkxoiC8hwPiWs6H8KIXfuKNvKMCy9KtHG4G1wvRZpiliPG9bVmGC3c3B66BnO8eezLOGFDYLdHM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(316002)(36756003)(47076005)(966005)(44832011)(356005)(36860700001)(336012)(2616005)(54906003)(6916009)(70206006)(82310400003)(70586007)(81166007)(86362001)(82740400003)(8676002)(2906002)(8936002)(4326008)(186003)(426003)(83380400001)(5660300002)(478600001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 14:11:05.8421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e3a188-751a-4e8a-cf29-08d972095532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
If we're running a headless config with 0 links then the vblank
workqueue will be NULL - causing a NULL pointer exception during
any commit.

[How]
Guard access to the workqueue if it's NULL and don't queue or flush
work if it is.

Cc: Roman Li <Roman.Li@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Reported-by: Mike Lothian <mike@fireburn.co.uk>
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1700
Fixes: 91f86d4cce2 ("drm/amd/display: Use vblank control events for PSR enable/disable")
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8837259215d..46e08736f94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6185,21 +6185,23 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 		return 0;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	work = kzalloc(sizeof(*work), GFP_ATOMIC);
-	if (!work)
-		return -ENOMEM;
+	if (dm->vblank_control_workqueue) {
+		work = kzalloc(sizeof(*work), GFP_ATOMIC);
+		if (!work)
+			return -ENOMEM;
 
-	INIT_WORK(&work->work, vblank_control_worker);
-	work->dm = dm;
-	work->acrtc = acrtc;
-	work->enable = enable;
+		INIT_WORK(&work->work, vblank_control_worker);
+		work->dm = dm;
+		work->acrtc = acrtc;
+		work->enable = enable;
 
-	if (acrtc_state->stream) {
-		dc_stream_retain(acrtc_state->stream);
-		work->stream = acrtc_state->stream;
-	}
+		if (acrtc_state->stream) {
+			dc_stream_retain(acrtc_state->stream);
+			work->stream = acrtc_state->stream;
+		}
 
-	queue_work(dm->vblank_control_workqueue, &work->work);
+		queue_work(dm->vblank_control_workqueue, &work->work);
+	}
 #endif
 
 	return 0;
@@ -8809,7 +8811,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * If PSR or idle optimizations are enabled then flush out
 		 * any pending work before hardware programming.
 		 */
-		flush_workqueue(dm->vblank_control_workqueue);
+		if (dm->vblank_control_workqueue)
+			flush_workqueue(dm->vblank_control_workqueue);
 #endif
 
 		bundle->stream_update.stream = acrtc_state->stream;
@@ -9144,7 +9147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		/* if there mode set or reset, disable eDP PSR */
 		if (mode_set_reset_required) {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-			flush_workqueue(dm->vblank_control_workqueue);
+			if (dm->vblank_control_workqueue)
+				flush_workqueue(dm->vblank_control_workqueue);
 #endif
 			amdgpu_dm_psr_disable_all(dm);
 		}
-- 
2.25.1

