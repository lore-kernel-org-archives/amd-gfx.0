Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EF9C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C56410EF2A;
	Tue, 18 Oct 2022 12:29:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD5210EF32
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw2x+2Xbd4RaKxC5Fzgjqiwfszhh9tphYpUq32uGTWsYnPdcS2vKHeaHK+2533qWxqgoDo+lV4UNGC8YZkgXT5o4Fssn7GDtJMiO+sDb+x6a5LV61y7Ie0VLNfaAyuaHTuScwgz8hiOKpw7Fw7Uf6PK+1zIGtofQh7/tAxc5abAWrvewwNJGXxpUYeCRS/qHRXScL7iVRC9XS0MPq6CQptZG3EHmOe5bwRuTQhiXiczBlzPOM/oPZxIy7AteIY4VdsSeHNJlC7n/ByFixsL1B4Z9039c5HnMZ0WSafsoXpkhrCmFQLcWlYsHCZwqDjZST/Ueswq/DeuGCVHR3LDnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWMUkHXT++k5VKZgTkQ+b6urNdxBDOAQRGr0q2Yc5QE=;
 b=kT2CPfMjOpQ10wki3Q5bY2EWygNkC+9RDdY5VvY5KVCXSMY51C4//KRLkCOFZ6UAZw4gNaMo66BVm5Qjcy77bIzis1DikM0wL0VOKrrfUZQBJsGt3+8vWNaOm/ueFiyqx+RYE0SD1bbE/9TkFfUygjYPiopPkjrVHhfg/ZysgC4c+LLZJqe3FJIRLMc1mBwxUfqsVIBFQWmspb7Y/sXRuez422t65ZYUVXRAxUkitCiMovGDYNhI4ygNn/c1vamb2mP+jdVONakQff0bi/bj7zpZCRW6togA8IaYBM2mD6N5griLuAsFyLTfuf8cUI3+cjWxxeJfVreV5owpd08o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWMUkHXT++k5VKZgTkQ+b6urNdxBDOAQRGr0q2Yc5QE=;
 b=PoF3UMbk7CDtglUwqTi9RiKXEUrRTTB2fYt8MgE2Fv3bODYo6gnxAp3D3pMnw+nf6E8ZSDjCQCDJRSnkL/XzEEqK+OGCxC4ILBm6mLm/xxIAlP2PV2aoTO4Yd3ZaKL+y8mUdD/eIke2NjdL//uxJW/N/7MQXxRVcGDqEThP0IDc=
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 12:28:54 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::3c) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:54 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 12/12] drm/amd/display: Move dc_state copy in commit_tail
 after dc_commit_state
Date: Tue, 18 Oct 2022 08:28:26 -0400
Message-ID: <20221018122826.1790114-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|PH0PR12MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: cc01d3cc-e569-4b82-1b2b-08dab104526c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zN3w8pQ3pIAnYcnUVFIdq/ux/5deMMUKtn8BuXFXT69ZyacGUd/VNElgdvSJbksNsI++tO+4s7ZMiaPHjl/kGd0AumgYuyIRXwYPtwZ/cxzxAEmLDcqhXzGZ2wSAtgaVQcyHPxGaqJXKHnbvR6SnVZkQvYz0zjHwtBuMRi5C5vjxmMOm1d1huhfJd20eGQgMBQtCiEX67J+2imd75VQs6qOwoZ5N8V/KA3+rFmLRSbApPnIOg9UPRz4awPdysNZnjOwsO572Dh9hYwj2v9jRvKEzsp8GAcamms5CMEjDJrobS8wiw5vztf93WIwlamAdEuqYU9IlGqyJwjYn0BxrKt6/pCNKJkfIsZqasZ3f3FrDVTfmizLAheNSISGZROSvLWL/qEktDYCaYB7IsOClUp5OpFi8s5tor/Hn93OJ7LZsJ0XwJANgqFYs+3j4joGj7+q/cdhVOFkzViPMVDzxBsT4SfAS6pKB/RDzMyXzNPT/Y2mjpQlAOywD/4r9oLvonmels1y8L6w9I6T/OQZJn2uoR9G82uff0rsLpKLHEvaE4t0HsHBP72QCCrlDoyyCehxLYOPwa946v6C3rT8WUScfS9am0OmO1jeQ2J/hBeWyViK0p1Zp4lTDZiydUzoi+/4VMPn0cPdp9vCC6dIB+8vMhDeOstRAZVRfX3sD7IMLh0a2njeZ1La5BGSZobtMKI9xCGR+OBFywOMPl5UW5J3LMysnVlY+D0k6wiB3Ijelq5lW6ycQxluMO1DPSuKM3P5bGQe4cXHL/Rqn79b2XZMdLdzAJho69D0O9FT4HjLofQJdFgxA316ayg8iFkbG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(86362001)(5660300002)(2906002)(82740400003)(336012)(186003)(2616005)(1076003)(426003)(47076005)(6916009)(81166007)(356005)(83380400001)(26005)(316002)(478600001)(54906003)(41300700001)(70586007)(70206006)(82310400005)(40480700001)(4326008)(8936002)(6666004)(40460700003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:54.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc01d3cc-e569-4b82-1b2b-08dab104526c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

The SubVP feature introduces a new mechanism named phantom streams,
which can be summed up as a fake stream used to calculate the required
parameters for handing the cache request and cache reading for a small
portion of the framebuffer used in the sub-viewport. With the new commit
sequence, we do not want the state to be copied before the call to
dc_commit_state() since this leaks the phantom streams into new state.
To address this issue, this commit move the dc state copy right after
the dc_commit_state() call.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 63f076a46260..17a9108f8186 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7999,15 +7999,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
 	dm_state = dm_atomic_get_new_state(state);
-	if (dm_state && dm_state->context) {
+	if (dm_state && dm_state->context)
 		dc_state = dm_state->context;
-	} else {
-		/* No state changes, retain current state. */
-		dc_state_temp = dc_create_state(dm->dc);
-		ASSERT(dc_state_temp);
-		dc_state = dc_state_temp;
-		dc_resource_state_copy_construct_current(dm->dc, dc_state);
-	}
 
 	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
 				       new_crtc_state, i) {
@@ -8127,6 +8120,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
+	if (dc_state == NULL) {
+		/* No state changes, retain current state. */
+		dc_state_temp = dc_create_state(dm->dc);
+		ASSERT(dc_state_temp);
+		dc_state = dc_state_temp;
+		dc_resource_state_copy_construct_current(dm->dc, dc_state);
+	}
+
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-- 
2.38.0

