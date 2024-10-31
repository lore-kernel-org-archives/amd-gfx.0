Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B74ED767F4
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 18:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A62A10E8FC;
	Thu, 31 Oct 2024 18:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CxxK97uK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDDB10E8FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 18:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmcdvXPNifcJBpTNUguwM3FhkH5eIC51l6TjFA6CP7ILaz8IuwLqmFudv68fTYySCkKQWtazYsgQgIlJUs9/VTww1snp67REAm2LrJdB0JgbM4Y5L7fiFiulPdq0I6OLxlNducky2LwqSc8DRNPHGyHVJsGVpKtYUfDCk1OFKRWHkR8qGretwTMUzqg7k5+/3oa2xEXGs1t4QSfTipi53CBQfDQS+D0lCcJtp0J0dVzsSE9tqufOgLXJPiWi5p9+FaSJWgUimvQcR3lB6F4JeLuirKOjeG8dTaXSdGd24VVI9muPidTeeESnuptAD1m48wjMrmI3fCeEPeQXsi17Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s8uyzpbSJ8HnSvSeho+ldHVlzr4Opp+ovXYF5xb1oM=;
 b=XMPIHFYBM1HQFwxAYjb5JVFtFToorFcMeuCwqJEzKTQlFPmon31c/H0mcolr+VxkKB6/uZH61cFuwLL5b48hjF2OwmGgImGSxF6K28TJWaJb2WTIXRoACErbxzuLvpziV+7b7eK0HYS6eT7YvhwKgjccy3ibUnF7MLnPUNkEr7pw69JKhgTs7SlVoy1no+v5GB+GSS1kFvlkT0znUBzpmNmBlZ/7C8bNCgv6hzeTF2MLyF/JVsyz9lkBWIvZYFjfePNxSGnqlLGARndjlj2+JYrAjDmCwnCbiz6/zZb1lejDW/5JuLJunFdXPfy5gz/hvgCreI/jdVFmhtyvVg2IKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s8uyzpbSJ8HnSvSeho+ldHVlzr4Opp+ovXYF5xb1oM=;
 b=CxxK97uK7w4HnBiagj4KsSRsTci8zyDbGNh9aqBPauBg22N2dLmcr0TooSWlq9Lt2gtNzOzNlVJJ3PWKY00fuMv96mn50a4i1zWxyKiFqqBG7uLhgmHaenwGP0K7/U7pVLt2iXXR/YjPLCoyPs/B3JgmTku4oEApByx5sKs86wM=
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:04:49 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::88) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Thu, 31 Oct 2024 18:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:04:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:04:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/display: add clear_tiling mi callbacks
Date: Thu, 31 Oct 2024 14:04:28 -0400
Message-ID: <20241031180430.3993389-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031180430.3993389-1-alexander.deucher@amd.com>
References: <20241031180430.3993389-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcc95f7-e9cc-4cfa-fc7f-08dcf9d682b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pw4yww14iPfx6eWseUqzQIwHzzCb0YYPFHFJk/K/4t+aypDhg+oYqDEvA5gp?=
 =?us-ascii?Q?ebVtW+3AgntudH3okUvjbgFo3RxiBJJqs/7x9q5NuXJUhP7yeYk96K4U1WUw?=
 =?us-ascii?Q?QGJuk0552S9LBe1BFSae9DEOTlNtxsRRVMnh7Snm2d/BiQMyrVuKoj+X1bJn?=
 =?us-ascii?Q?fO0g/Ygr0JOrBrOXfcgyWMIq3szDD3kZfkUetK0sWwsfrQHv5zzwjPrSeUTa?=
 =?us-ascii?Q?16nbonCeqF6QDyvE/X/hEY1jFHxrMMCp42uE2r1C6lCvBG55dIYm0d8MfXot?=
 =?us-ascii?Q?20RN0gN4TfhT2F/rrkabTMZD53adrd5aYmcZ4/drEpuKfiUxhGCLvMBUXory?=
 =?us-ascii?Q?xN+yAhJ5A7f6S//JaOImD7VxIvvKBKWUT8BkhSGROgfcv2CyIqOPB8Qx/g6s?=
 =?us-ascii?Q?Xxc4vDdhLajolMEU0/EleiDe2eIe8T3BljdOCmiNoGydWL8h+E4BBzeMm0A9?=
 =?us-ascii?Q?MTLZGj7kp1jd+3aM4tykBqb6rnNRPg5814+zpBBslrj57VdhxtbOEOWO7GoV?=
 =?us-ascii?Q?efAgSGM/wHt1w7McIbpGFn3vJIrMN9jzHnYY32EMXYSsI6jD15NphEpFvx3W?=
 =?us-ascii?Q?q/vU6fcOBEEtQJqwau4sjGbfY7oHARB8dzZFN+3yfeXT1ELTxFPyIpzxcAY3?=
 =?us-ascii?Q?yMup5kp9j4Vktz6WVKAvp4Us8/dIvyf9cbJxnUw0Gb2SREyqW5ynNRsfrcKG?=
 =?us-ascii?Q?iM3rZ7lqcoXCtYoGDl2+EIpoMVavQFNThlPAHCG7ryE4r6uvwZCX9NwfbaeW?=
 =?us-ascii?Q?ULB/i8DCqB5GM3SBBDcHJcoLDo/LlKGdXUtIGHPYkfSBw6Ny3cKIn/P5fI+R?=
 =?us-ascii?Q?5qkBI0s+Ix/eSWckN81SkuCx8vsRjxzHsapeUg3SWGrBLhPE2+EAC9iisG2G?=
 =?us-ascii?Q?E1V/1ATYW+5Vz73snPH0OBd6+1YkbmZ+UnFVFZDT08dziQUpSYGiP4gB/KL4?=
 =?us-ascii?Q?eAKXSRd9lG4LkDWT3BrSZVveHw9ChnJBrrBhVUx9Buao6YgsjfrNDbpTWqBp?=
 =?us-ascii?Q?wDmPkgYjyR1c1h7JP+CvHPPOdtI5OOinZ1cGxYqD2tDY5c5YiNUZMcOdusIW?=
 =?us-ascii?Q?umwxYv8cPNIKdiwbQ+nhg6r9mlBYzUFof+vhFtIBNfIXTVzuc6FPNvvE5Xx4?=
 =?us-ascii?Q?c7QGroVl36wYOjFp5dneaDa3bDASj7tPDyF6oa9+wgu9wgI69rRs/jFtpf3m?=
 =?us-ascii?Q?X8jA/2TflccrK76+amsn8fWze8qQgjK0G0q/yh8OuAsnq0CHKkrx1AYzrt8l?=
 =?us-ascii?Q?ABaEF3LertOF1+CzulVPZmdLMq/ri6nRC/VLoXrBHAJSoIMRa+c0Vz6Pmedw?=
 =?us-ascii?Q?yu2MbaGfJSqa0qirTsaNoAbXVWWdDx82I0k67gFaHS7AyM0KoY2IAkKtXeAo?=
 =?us-ascii?Q?V0LqU8Yjuuxxq4bl4kJQM2NPWX2UWJOdpRYFpxZqt7v+Q1m53g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:04:48.9618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcc95f7-e9cc-4cfa-fc7f-08dcf9d682b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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

This adds clear_tiling callbacks to the mi structure that
will be used for drm panic support to clear the tiling on
a display.  Mem input (mi) is used on DCE based display
IPs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 ++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index f5e1d9caee4c..ebd174be5786 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -481,7 +481,6 @@ static void program_tiling(
 	}
 }
 
-
 static void program_size_and_rotation(
 	struct dce_mem_input *dce_mi,
 	enum dc_rotation_angle rotation,
@@ -627,6 +626,27 @@ static void program_grph_pixel_format(
 			GRPH_PRESCALE_B_SIGN, sign);
 }
 
+static void dce_mi_clear_tiling(
+	struct mem_input *mi)
+{
+	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
+
+	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_SW_MODE, DC_SW_LINEAR);
+	}
+
+	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_ARRAY_MODE, DC_SW_LINEAR);
+	}
+
+	if (dce_mi->masks->GRPH_ARRAY_MODE) { /* GFX6 but reuses gfx8 struct */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_ARRAY_MODE, DC_SW_LINEAR);
+	}
+}
+
 static void dce_mi_program_surface_config(
 	struct mem_input *mi,
 	enum surface_pixel_format format,
@@ -884,7 +904,8 @@ static const struct mem_input_funcs dce_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -897,7 +918,8 @@ static const struct mem_input_funcs dce60_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce60_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 #endif
 
@@ -910,7 +932,8 @@ static const struct mem_input_funcs dce112_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 static const struct mem_input_funcs dce120_mi_funcs = {
@@ -922,7 +945,8 @@ static const struct mem_input_funcs dce120_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 void dce_mem_input_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
index a8b44f398ce6..4f5d102455ca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
@@ -187,6 +187,8 @@ struct mem_input_funcs {
 			const struct dc_cursor_position *pos,
 			const struct dc_cursor_mi_param *param);
 
+	void (*mem_input_clear_tiling)(
+		struct mem_input *mem_input);
 };
 
 #endif
-- 
2.47.0

