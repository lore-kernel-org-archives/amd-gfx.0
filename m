Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADB4EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 01:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E7E510E00E;
	Wed, 14 Jun 2023 01:21:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF3910E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 01:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai/8eaSkwMAe1+m01QoFZC+kZ5L4cvmiaa2MyVhiUASfczVD9m2Dat7Ee5iAsbX/5NWa6us9negWFpBReTPKYOWS75aRo6UcC3t8R4IgHHagCIuJrtVDhigl/9Gtv02CzDHanZ0D9yKQubqjjTAWGutSVZRsLdACT6TuUDUeRMkXPYQdJuX9en32jXldBC/s4PUqyX5h5mKh6b6TdVBYIxDPI8NJX/M2htyEhLSS5vcHVrn34/nbziyOl96/Um3q5n4K/OR69/z0+JJrM+4hIJaikIYzJQryEnVMNqfutURlkBqGbkKSCOgly2r9dF2AUxhA1HDVSrYYeag28vXlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIRDnOepnj8Xa1iYWnuMMNguQX+xyxjVNSU22B5ynws=;
 b=OKgzZMcqX1lKaDcgfJkuodz2vNBsSQd44JWyvX+jscD0VUo5ruq4jduh2FfOWDLVlPLgQB9ApfYUVi/UsLBRKJx2neWFruBqaUfgKbBg6TAlLfnGJYzyMf3ppthUSaFzLjia8AzKe9/K+S3wmxL6a2+vBZU3eniGLDiB19L+FIN3nN6cO7OJnnrnA0B7K/9FsL1wWCQ/1PwjNPg9Zg5d9EOPPuHZtC4M6lCg4nrFf1d/mEOFldqgG3UIdXUqzWS1ajJJqow77aNIxfkWm6StqQBvunSZBrfkO2NAItGvWCTqutSr9KyuzJt1B0sexwHuT9IN/5fRYcckCHT8ysP5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIRDnOepnj8Xa1iYWnuMMNguQX+xyxjVNSU22B5ynws=;
 b=tirgT9jhkMa4myUQbCszpEk5ST+a6A46UT2uWTz1PoATSLq1faecjJVVA8rnCqMLMif5vZQZu/Mo6iQM7kQhkSkScnuo9X56rfo6EDumK2UEJx9rEX+Be4Ax/FByRg/2NNZdVGtJCrdOH6m3iGwSXZqUqdkO4Qe9ilwah5zycLE=
Received: from SA9PR13CA0130.namprd13.prod.outlook.com (2603:10b6:806:27::15)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 14 Jun
 2023 01:21:21 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::b2) by SA9PR13CA0130.outlook.office365.com
 (2603:10b6:806:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.22 via Frontend
 Transport; Wed, 14 Jun 2023 01:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 14 Jun 2023 01:21:20 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 20:21:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Convert to kdoc formats in dc/core/dc.c
Date: Wed, 14 Jun 2023 06:51:03 +0530
Message-ID: <20230614012103.2866603-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 228ba53a-37f0-49be-cd17-08db6c75a923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41s06q55u/XWpVrGerqPwZX+JtPP2fLgnuYULIYvBcworX91Mc25l/9zu0GHAVh69LtgukQkQa0MyRcHME9TnnuNKcijvke+JrWZqfddLkY4+s5N0Ri06kqlFVclFsM3oTAJqI3LRiohRNH428wzud8RMwAvUp4FP7bWAZs5eS1rW07O8cOq71CNiLl4MMSWccUHd0hMVdwGHZOe4u17Kwk7m9iJMsVC2qE2121EgI1u6PAjOM5rXPgNjTHFHP9vXXBusfUArcsdNsYFbx9lQrJtiUn4Yk6s/Y+8LFMX4LlvGgnaoXjGKrSMIG1TQ1MsRwJ2TJDN28f3gjeufq4k9coUuSi6nYiCJPfiVfFNxeVOuHhQ51/V2t6EIQmxDEoiNfjghgbhOow713Pd5yqH6yJReemkr+Qm/6OPg3NmRYvOKUmsZojCgbLQghDREKr28dXfutoQNMR92JikiOIoo4SX7kCdk38BFdIvjZ10qamAaUTb9sDPWyQXZqC0otJ1SogkbbuZCGk97Bmg3ZHlNZRSK6UGmgI6RnWlbWnXNTtqXjQm3F100NIFWWoKyQDWzjFrQv9pGmeQODGIvBb+A/VgGJLLtyzQJWiqwHo60mTFyV4Ai0CVdfCGcdO9kA38DOYhW7+/8jCqfj5XtgLVCZ+bH0pzqXGS6cZGi2/gx+cSC2zXJ4lgV9O9odXay22Mc6zUan/5SbtVXd3ho2OYnV7YnRsODTYJ9RcytFEJuvmUcEFrKecDLtBFaWL/mhnlF/JF4VsYsvwxTNruKDC9rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(8676002)(8936002)(2906002)(70206006)(70586007)(44832011)(110136005)(54906003)(6666004)(7696005)(4326008)(186003)(6636002)(1076003)(41300700001)(26005)(316002)(16526019)(36860700001)(356005)(82740400003)(336012)(426003)(47076005)(2616005)(83380400001)(40460700003)(478600001)(40480700001)(36756003)(86362001)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 01:21:20.7257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228ba53a-37f0-49be-cd17-08db6c75a923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3483: warning: Cannot understand  * *******************************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4204: warning: Cannot understand  * *******************************************************************************

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 34 +++++++++++-------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d3d61faeb28..e6bd20dbfc0a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3480,23 +3480,21 @@ static void build_dmub_update_dirty_rect(
 
 
 /**
- * ************************************************************************************************
- * build_dmub_cmd_list: Build an array of DMCUB commands to be sent to DMCUB
+ * build_dmub_cmd_list() - Build an array of DMCUB commands to be sent to DMCUB
  *
- * @param [in]: dc: Current DC state
- * @param [in]: srf_updates: Array of surface updates
- * @param [in]: surface_count: Number of surfaces that have an updated
- * @param [in]: stream: Correponding stream to be updated in the current flip
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @srf_updates: Array of surface updates
+ * @surface_count: Number of surfaces that have an updated
+ * @stream: Corresponding stream to be updated in the current flip
+ * @context: New DC state to be programmed
  *
- * @param [out]: dc_dmub_cmd: Array of DMCUB commands to be sent to DMCUB
- * @param [out]: dmub_cmd_count: Count indicating the number of DMCUB commands in dc_dmub_cmd array
+ * @dc_dmub_cmd: Array of DMCUB commands to be sent to DMCUB
+ * @dmub_cmd_count: Count indicating the number of DMCUB commands in dc_dmub_cmd array
  *
  * This function builds an array of DMCUB commands to be sent to DMCUB. This function is required
  * to build an array of commands and have them sent while the OTG lock is acquired.
  *
- * @return: void
- * ************************************************************************************************
+ * Return: void
  */
 static void build_dmub_cmd_list(struct dc *dc,
 		struct dc_surface_update *srf_updates,
@@ -4201,20 +4199,18 @@ static bool commit_minimal_transition_state(struct dc *dc,
 }
 
 /**
- * *******************************************************************************
- * update_seamless_boot_flags: Helper function for updating seamless boot flags
+ * update_seamless_boot_flags() - Helper function for updating seamless boot flags
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [in]: surface_count: Number of surfaces that have an updated
- * @param [in]: stream: Correponding stream to be updated in the current flip
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @surface_count: Number of surfaces that have an updated
+ * @stream: Corresponding stream to be updated in the current flip
  *
  * Updating seamless boot flags do not need to be part of the commit sequence. This
  * helper function will update the seamless boot flags on each flip (if required)
  * outside of the HW commit sequence (fast or slow).
  *
- * @return: void
- * *******************************************************************************
+ * Return: void
  */
 static void update_seamless_boot_flags(struct dc *dc,
 		struct dc_state *context,
-- 
2.25.1

