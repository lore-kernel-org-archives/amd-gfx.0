Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAFAC27C5F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 16:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7CB10E0D9;
	Fri,  7 Jun 2024 16:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YM0M6fqC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2703B10E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 16:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCsaSYUGzpx3gB3zmxQzxHi88HE9S7+Foz/heqYFd4gwUbyIA71prt5JCgFLGqwxqOrrXJf/VEg/H/n6Q2yyleKxjbI2+NUQ5EF6mSwr2NJHPbfTAwGNwZ5lB3piMepJBy9xPvihJ7iZJyeGtYlTTm4NoP3/B1dnNtQxWl92wlpzZWx0YEwY745JL2Ghky+zVc2zVnvHH6W3nEROJ1jKv08MrSX8bevtfrwlrrPqRPikXCaySkEdKccKCxTYkHQD16821NffSCXcigG9YSkKV/N/16aw81mcw1H5CnZHfweJPNE5+Tkyx2/MLSfMYfz0lVn3eeafI7+3waLfFf18XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmg+/qW5cvwDZIHyv+rIDFIe2JihWvkGuINl7FgQ+ug=;
 b=NnRh5J0AM9vdQgUzlBMxMUhDiqhb/6EmoUbqcOFDInTIFnZ3bMlxdas6Q/QzJA7DYu69afDS5s30GzC1kfbSt0u8wtjjXUFQqNQacALuQZIStqS3wJo/ElU89l2igA9s85R4emPrp7v2Bhy2HGvVAP5FUqEcdi52vifl2pNxtvsg6jh2fmQO8dEqdZjKczsa654yfDixkoMsRLhfVvb+5HPoH+QnaPGfQ7lQBGotMjoPEr8K2iG74Dh64lxqcZvSOkU4wbbig+xPHyPALi7M0twIpunLNkLDBcohD5hmCDbMKeYrX+Rs6eTkqGtA3YamMPaFVjx7mQdX/6VIUUD8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmg+/qW5cvwDZIHyv+rIDFIe2JihWvkGuINl7FgQ+ug=;
 b=YM0M6fqC6dlFEG5l03sqTJXDIdXVGM6jD29QGfD2cM5iB3gBZWkMIDyo8N5Xv91QAjUuEi1gyijF/E2bKLt4vmCeX/5zV3mFyK1POhuUG/DwK04NHfop3MUvBlhqKwLVt1mlSW190i3MHZcdoL1v3y+3CM70iYJwW3RXwEF+chw=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 16:34:21 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::55) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 16:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 16:34:21 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:34:20 -0500
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <srinivasan.shanmugam@amd.com>, <sunpeng.li@amd.com>,
 <harry.wentland@amd.com>, <rodrigo.siqueira@amd.com>,
 <nicholas.choi@amd.com>, <george.zhang@amd.com>, <alex.deucher@amd.com>,
 "Ivan Lipski" <ivlipski@amd.com>
Subject: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb' before
 dereferencing in amdgpu_dm_plane_handle_cursor_update"
Date: Fri, 7 Jun 2024 12:33:59 -0400
Message-ID: <20240607163359.18299-2-ivlipski@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607163359.18299-1-ivlipski@amd.com>
References: <20240607163359.18299-1-ivlipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: e5457972-bec2-4672-eb82-08dc870faf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ncqOJGwaXoB4JQzhA0MVVhxtpcoxq7WEBfnWOnNNwAOlxRjHnOm5E719Ix5?=
 =?us-ascii?Q?FeRY1Gx9Gz6wNjGGDzHb2NjioLWjCf6uLxM+cGWlDeoiqwEj7nzPoa/JxxGT?=
 =?us-ascii?Q?FGmmD+ByzEWDslgYQc918RwRWdDcWADvlGIho61ZrT9gaM4pfC6g6khME7gl?=
 =?us-ascii?Q?bg+QMYsASmjBaWc6kA9E3cyguAG3yWmi6QXibQeiMx3bGKrp2OTTW2eia7zq?=
 =?us-ascii?Q?8XXmVDAelU4HUP0u10MdrjMLlqYlPsHcxNHq4Wbsq7ba14SECJcRqJBu8fbo?=
 =?us-ascii?Q?Pmih1/892hrKK3JFJmScaNL2SfQLw4rwU5TEaNwm0EeMA0hk/5Dxagq5LvRb?=
 =?us-ascii?Q?wa09/uiUJPF7YqZIxcEkrIuMo9VSKN+mjPB+rkEwaOCideG+yenMIowJcIWv?=
 =?us-ascii?Q?5t7Z+Tyqra5qtO2EKu9dlK1+ewQrldrXkPrno4TPQiHNyhOq3eOONhfBviyA?=
 =?us-ascii?Q?nBsvS0HFHO6rP1GCMAX7ljlYJaM+pDo/G5ldwT6VDsscCPQO3Tx3LmlmSpxp?=
 =?us-ascii?Q?6/1zFBFPAQfcUoUTdTxrJcSUMpyIhQcs5qBjmesgRwn6p83seIlyHJ8cfZH+?=
 =?us-ascii?Q?sMzEJv9zViVeQF3AKX/ppxo0oLNNBwz7ZYFBnu9f+ZW8P00vau1gGfmATrzd?=
 =?us-ascii?Q?dOxwR19N60M9zcSGVdxtQLYgdcfDL6k8SNJ2M1ZGg5LBH//9NcD+0tORVFv/?=
 =?us-ascii?Q?VKsvO7bEDGnuCE4ygN53SMFuf3S7eceC+oTqmbzTabjgq1mulRbxBewTqa/8?=
 =?us-ascii?Q?Xoj7l+W2Z57bU1Fw/86nlha4Z8p9gdTmWfEbarRYvpvIM667ijh3LoIalYfL?=
 =?us-ascii?Q?lfRjUOBUpLqTt3GkKC0Cx7BhLlpQsSPMP4sqE6zLVkbLVMcHv1sbkTJDEsWw?=
 =?us-ascii?Q?x08DanGVCzjOrFfkfgM1mErg5fp9Eo2ntVxIZ+jne9YSdrtLsI4N1EpwqocR?=
 =?us-ascii?Q?uv/cavZJbUH547cUGSDseplkLRRpDL/sxzTA+kLzPhQraIQsEBeFd9G7siHv?=
 =?us-ascii?Q?cWeHFG5w25n/VY0Gp3hUQXbCoMY7um2YUxpWQ0SurYU60MDsJWt6DFMve3SO?=
 =?us-ascii?Q?cDBnEEEDBQ0dg7Q/e+dZ05RhMi7CoassMMgb3obdhkOqU4BdkThn7zE9ThaT?=
 =?us-ascii?Q?lJ1kvQF+h2M06qk4MvzHzUvtgZOGtnj02wwwISfijF/cVZHiAMxIAQmwyrga?=
 =?us-ascii?Q?mgNjehDmr2D8p7w/kNILIgNZpfvwipYIPqWcpKv+BI4vu/FL3xUZVSoGEw39?=
 =?us-ascii?Q?lxgyebrLv8THkjyJF7gymI56MghiyYKAOp0D/5F7dx4WuQ/roVakwIsaj9LZ?=
 =?us-ascii?Q?B7QzUZ5tLaipAdwtjzAXTWEiLyKYoSNHsgoGvD9OumVQ3CSyROWS6uJNCxHb?=
 =?us-ascii?Q?qBqD13ESORPGaTNuk2AttDMx/nccgjx2JGIs8oZzy6ifKNn2yA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 16:34:21.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5457972-bec2-4672-eb82-08dc870faf60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
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
This patch is a dupplicate implementation of 14bcf29b, which we
are reverting due to a regression with kms_plane_cursor IGT tests.

This reverts commit 0d84450ae0db367780c3dd2e208fe4e6fe5565b8.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b339642b86c0..a64f20fcddaa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1246,22 +1246,14 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
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

