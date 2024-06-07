Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD478C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 16:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031EE10E104;
	Fri,  7 Jun 2024 16:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SR0WFcrR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF50210E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 16:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvXN8Q40XSSINJYodgSYbWXeqFL13JR4qEE6ujboFi3+i+W+haI/M+Ux8eWYGLKLS04ZYQ18HHgDyOLndY40eTaALp5WrJDkAU50DQvKA0rJZVaCMxoL35yz8DikP5uz9w440TKk0eJ8sslamPkTSl7qIq/yAUv0FQzBdSr9NyFh2sP0SOoEYRKYKQ1g0W4mRGXuAsjSZhwwfZp1aBUo2oceGKRZqstynrlNUnjpTHMktCf68Qr2t0WZ6R7UIs7G9W/MHrHVEXl5qYAU8BJVs1geIa4uLaulajYVe6S8lBspgqRI8iIrYZ91ONxT3q++YyjF8hfnTxdS38WhaZtQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2FFYfAenpwE0zQE1oidxG4f4GtlWUTj8aq9/BRIN2A=;
 b=XBfJap1D7+AIzjVQXh2uRkd66aVRoPSt4xREHRNN3y820VPD59DZwsUQgiqncAJGarBPntbisuJvdxMYPJosZOvaHs94+LoFZ1xSmAb+vayC8b5kuSPyAANsP0cBFZ81scOwDjGxJ0UO1xF+PVS0Dbroo2JrAd6sPEJCxLPkuulgZAd7uhYB7PTTcS/0imLDTRIitlXE3f56XOTEj/boLc9NcrIb/Xk3/Jp0/i7ZXH26f5G0IKPwZkEL8aK5sqNjazJUesOAfDCkFDz1rqaxsp6Po7ybRYi22nyd4EiJs0TNGG7t2oG5lgDBw9IALeNXT9HQ/SWyajy92cP7YiXM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2FFYfAenpwE0zQE1oidxG4f4GtlWUTj8aq9/BRIN2A=;
 b=SR0WFcrR6p3g6ZhMtzuBpla2edqxveFXsAm+0tGKM5fkq1dnewlTd5bTJQf31mZp2udghxXmp3ynCgfJZ7nNX/n+diUjEeJXLre388wLY6zM33+f49p+pZRatJb1ClmdpyS89ewomxOnwnx5xTM5V2+3X54hWAXhsiUWZ6G6RKw=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 7 Jun
 2024 16:33:22 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b6) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 16:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 16:33:21 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:33:19 -0500
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>,
 <rodrigo.siqueira@amd.com>, <nicholas.choi@amd.com>, <george.zhang@amd.com>,
 <alex.deucher@amd.com>, Ivan Lipski <ivlipski@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor"
Date: Fri, 7 Jun 2024 12:33:06 -0400
Message-ID: <20240607163307.18250-1-ivlipski@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3566d040-71be-4b2c-12c3-08dc870f8ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B0MLKIf2xMITHM1Eh9aal4v8nTjsAbZwgYfp6O8NqeCiQOK9AIC7Dmoms+WT?=
 =?us-ascii?Q?DBUKK3/JfWV4ezfrf6yrVBlnPUUk1u4Nr5cmT7gkH+snLj8NgrfNxvoO5Cb7?=
 =?us-ascii?Q?4HJSI4f1AFmXNxcCbYmod9UWi0llSIHN5xhEXdl4veRUK1mQp7hYRtVH+C1D?=
 =?us-ascii?Q?woLj9zaNdT8Yf004Y3U4A91hSalKSsSBjG9bBS3VtVKFCNorlG3Tp7vb5L6d?=
 =?us-ascii?Q?pLndPMmVK4BboomG04AHN3yyn0NYPS1N7GzOeYpVfUQjv12tSRCCypLwCs4o?=
 =?us-ascii?Q?ISmGBmvFbQpt20hXo3tq7olzL/01USihXcUOGORptqyXTYtfIRIuS8Rkg0No?=
 =?us-ascii?Q?GSZN03Wk8zmRf9PY4GmR5e68lXQ8FIi/AllkOXHnlWKhEvKpzPn3NGlIouxq?=
 =?us-ascii?Q?oP6sj1AUEABpS9Py+YOHK14dAY8DDGTyVYpOv8PUXytlBZYGdT/Pygq0pheo?=
 =?us-ascii?Q?PM7h3XwA4G2MlZINFJZp4D6HDTfmsfzZq9+T6RZnNWXoiis5exsV6TDulDiC?=
 =?us-ascii?Q?DHN28TVgDagZGBbd//9LKHTbEjUj/i0GV7KEFmK9tx4CycfEWAYqpEikEU1r?=
 =?us-ascii?Q?O+D0W6AupAzuO5G0EAOgq3VrAGy5w2L7f9An40W5QNsNE/F+jmP2Au4SIhlx?=
 =?us-ascii?Q?OBBBsD0R8kxjCt+u7K5YXuv9Di2f/0edRpT8PXSa5Ji0OEkexVGrNIGc3wsk?=
 =?us-ascii?Q?qxXDFQnm/D+XbhcMWarIlmcc9K+0hn5qYVjtgQDPwzyVTu3vLRxNHHqiXlRo?=
 =?us-ascii?Q?VXlqFBURBSkBcZT98+PKht5Q2BANXE3dBrnUPbRoxTxAmSJwrWGwW1lSduga?=
 =?us-ascii?Q?wKcw48C8SVEknJYz1N9uDaxmjPuK/12fZUuaztCXGP3ikQZe/7bkQ/3jmDXK?=
 =?us-ascii?Q?BZXRdYDxW8Jvf6BYDx4DpBsqlpygDdAkRuK27vwYgwjiu+vKF65ipYJFchZF?=
 =?us-ascii?Q?FktQk7c8uXZScjlm4c2WD3KT1UlIsJKRbtJ7Jzy4+llN9/sEkXodA1E37lTm?=
 =?us-ascii?Q?zXIqGSetT3olf/qA6shP3Zipzh8CxuigGPMZCEqhF9s8EDuLYVKihPFkttI1?=
 =?us-ascii?Q?cMpk8e73RViz/6W3MqZ5fj3VSwzq9wBcOYwOnWTMPL2/9OZD8j5akwuB7u1Q?=
 =?us-ascii?Q?KntYGHWOZYwfr0dnR3fYvI5yOSlOO2TdmO7y7mcqFylgHOz0xe5CFfANrQ5T?=
 =?us-ascii?Q?Tb8gc8tWe0+QVRU+46D/UfehKlc7h43wlkoyLmd7sh3Gd1oPm1z7UKKs0CHF?=
 =?us-ascii?Q?oRmG3Umlfl7GDOyMpwfsqRYmSENlAYcCrYtjd33zWKExkU1MQj/s/hioj/ca?=
 =?us-ascii?Q?e/vlPMJUeQi5AAqgDVApkUcdBSi9DLtJt5EyORSAurPcUxc+xymbZuXprsI1?=
 =?us-ascii?Q?Zj/5klKr+ypX1e0TbcgJKj0sCGvNngxFvqUgQRUz4fTXGWWoSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 16:33:21.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3566d040-71be-4b2c-12c3-08dc870f8ba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
This commit introduced a regression with kms_plane_cursor IGT
tests, causing AMD Asics to fail these tests.

This reverts commit 14bcf29b706f8ef423b86c9b783055b5b0c2cd35.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27acbe3ff57b..448932ac06fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8637,22 +8637,14 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
-	struct drm_crtc *crtc;
-	struct dm_crtc_state *crtc_state;
-	struct amdgpu_crtc *amdgpu_crtc;
-	u64 address;
+	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
+	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	uint64_t address = afb ? afb->address : 0;
 	struct dc_cursor_position position = {0};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
-	if (!afb)
-		return;
-
-	crtc = plane->state->crtc ? plane->state->crtc : old_plane_state->crtc;
-	crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
-	amdgpu_crtc = to_amdgpu_crtc(crtc);
-	address = afb->address;
-
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-- 
2.34.1

