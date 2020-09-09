Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7DC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D9D2224E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wcz8b5KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D9D2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237166EB8A;
	Wed,  9 Sep 2020 14:29:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3246EB8F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 14:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGIo+aj3IN8bAofbDpdNXxyDZ+UqwWewbxJgXBCQHKkwhoxyYSBexghlQ9vKKEd+vPgTCT1bMkxKPEouH9FQczxWp1uShn0Qmv9HG/GxTP7XBazarz+CssIy8dOXzqPcKbx4aRnU9SfG1tm4v4uiKIynsLvOnS8jTllaKSiej9FCNq1R1RKGWzIjo4mffYUyk7poVL+1Z9uyat6QIQ51sESsa0mw8zlslB/2nEiwgUx+VzS7Rdz/qmYJNPv8UzlJB5r+A183f3xkp77920ZhEFC923CXIKCLdLicJqdCRj4EUWol3J7iDDFIlO2JsP4/uMjaj7QGTZ4dKkb2svrQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVcVqZQTy7Sn7sXbFORmhclTD5om85MIekRtW5qhB2o=;
 b=ZNZoTdYDAZbLOvt+QuLJjuc96A6S3jAob1FIZp0knK8TYvyQyWm3hABRRaUTawMJS3iSmg5i47hQOIR23MequMsulufrtD0LB8sMpRdhLBLUIOeJmJikPWM7gaZLOvthmbMvR2pZq+wuIqsTAQMiW8TwO56mEMiP7FLjwpTQZq8MTDSiDFS8fwwxHte+z10sySRSAEDiSmUAYry6Ymqby/jR2hhffh1stzWSoKrJjj9p0gD3iImE6L7OHlh6Ix5kAiM+3zYc19jzPO7lAcIqOLYQK+VS4SyKbHMXc6wL9SoRfTmVRu3lN4OEKHLTm/v5qMzLFctAlaacl5827BDb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVcVqZQTy7Sn7sXbFORmhclTD5om85MIekRtW5qhB2o=;
 b=wcz8b5KMK8wajfQQnHARbfORLtsOsOPhvuPAHrof7gNCN+2e6FeBX1tMpW6iVHf6i/7KeLBrtrQKmqvbm9gvA1E3zbnm/2HLf9PRj+7mLYwlHyuoEikt69BItcvx+mXQLCJwKE6ijCOsWKiHutQ3UqMm6usJTi4Ebj/TBfkw67Y=
Received: from MW2PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:302:1::33)
 by BN6PR1201MB2515.namprd12.prod.outlook.com (2603:10b6:404:a7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 14:28:57 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::ee) by MW2PR2101CA0020.outlook.office365.com
 (2603:10b6:302:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3 via Frontend
 Transport; Wed, 9 Sep 2020 14:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 14:28:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 09:28:56 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 09:28:56 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Sep 2020 09:28:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: Move disable interrupt into commit tail
Date: Wed, 9 Sep 2020 10:28:54 -0400
Message-ID: <20200909142854.105032-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909142854.105032-1-aurabindo.pillai@amd.com>
References: <20200909142854.105032-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c299ca-fbb8-49a8-31f2-08d854ccb012
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2515:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2515E4ACE559A7FAB40FC8CF8B260@BN6PR1201MB2515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuchJ3YGCKZJq9hXALyUWe6VJXH7MB47IrBuD48EyReabbBlzcHDMdoayVSPwRp8vu4g0bdd3Q2hUEqB8mN/UXHt24qHuY7LgrtLzIaR4iIfP2ytUHPV93CtLWdk0DW48gOCVYsf2HnmufNbzKNceERu2/WpIPjzvNA6v3lr0gSZZvM56yPvjuPUPvNYSHnsLW4i58bwmdtq7Xm4GlGBF5V5DKdf4i+eCZz9eGq53mtOrnK/+a/QE7CIAyZiYOQ+ZEBoNOkIH9hI9bC8nfxRQYlmOL/pymVLaRzHfYBMzjaQb95xbT+voVEvg4hH3+qKIjaGVZkm+S1B3CP/pm9Oc/ONdgUIe7jOUSuyFIlNpNG30QO3wAqwELakrW66XUaUcNRJMubOxAc/Pp2tZ5NiqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(86362001)(82310400003)(70206006)(70586007)(336012)(4326008)(5660300002)(186003)(8936002)(44832011)(26005)(478600001)(6916009)(2616005)(426003)(7696005)(1076003)(8676002)(81166007)(316002)(83380400001)(82740400003)(47076004)(2906002)(36756003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 14:28:57.5390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c299ca-fbb8-49a8-31f2-08d854ccb012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2515
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
Cc: nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Since there is no need for accessing crtc state in the interrupt
handler, interrupts need not be disabled well in advance, and
can be moved to commit_tail where it should be.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0603436a3313..a40de242e04a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7488,34 +7488,6 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 				   struct drm_atomic_state *state,
 				   bool nonblock)
 {
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	int i;
-
-	/*
-	 * We evade vblank and pflip interrupts on CRTCs that are undergoing
-	 * a modeset, being disabled, or have no active planes.
-	 *
-	 * It's done in atomic commit rather than commit tail for now since
-	 * some of these interrupt handlers access the current CRTC state and
-	 * potentially the stream pointer itself.
-	 *
-	 * Since the atomic state is swapped within atomic commit and not within
-	 * commit tail this would leave to new state (that hasn't been committed yet)
-	 * being accesssed from within the handlers.
-	 *
-	 * TODO: Fix this so we can do this in commit tail and not have to block
-	 * in atomic check.
-	 */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-
-		if (old_crtc_state->active &&
-		    (!new_crtc_state->active ||
-		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
-			manage_dm_interrupts(adev, acrtc, false);
-	}
 	/*
 	 * Add check here for SoC's that support hardware cursor plane, to
 	 * unset legacy_cursor_update
@@ -7566,6 +7538,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dc_resource_state_copy_construct_current(dm->dc, dc_state);
 	}
 
+	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
+				       new_crtc_state, i) {
+		acrtc = to_amdgpu_crtc(crtc);
+
+		if (old_crtc_state->active &&
+		    (!new_crtc_state->active ||
+		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
+			manage_dm_interrupts(adev, acrtc, false);
+	}
+
 	/* update changed items */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
