Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975E8C88CB4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 14:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0669C10E244;
	Mon, 12 Jun 2023 14:00:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B1610E244
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R03eBeCSMtU5smKQg8btvdqqOSZjYZKQjCa3B09tRYgzJEzbGwJWe4QVglvZfX0GmLHfeBbB3rf4zynSUP70vvnkfpcb7e3MKxM5YxSlDjw9uEUEror7YcmO+Wa/Wtlu94p/SQ0I/k/YlhTAQl0jOObdi8iowRKkeqkM3gfVRLxYI3vqKUX5/2CdrSXiuZE8XxuiX2frhVQB4ncfMCHyOV//0cttAUn0FQgCCRnekGUMoeiHmvMhOVRmXYOEs/jmK+23vE5UrJ7eYP03lmAEeNtgA8RhQSr9IsQGT8G8QSFXRHvtM3ucdgWXki7s37p48CLAXBvE/gY5wbwHHY78bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVKk0UPsT4AqHjKk5mQVG67W8lmZ3JLVr0dS4r/KFKU=;
 b=SeORXccZrYZmUsXyPR5ui3MaTuUHWNp/b+f1Cq/Ggkf0pBqhPpezD6+pO00hloxDmXgL0HeUBWGX+8saCzgr3AQjpHZF04Aaj+vnw34xcgGYFFEvBI9AN7/HnaPDLRhyEyXMS9l+BkbeslcWLm6Qtz6SJx1S66eDmCmXV2r6Y8jREzM2/CPcFIQSm2ZaiWAdjA4K+NBnBdMLfVKU84HJFVLLTd2GsrMc64ffVZP9QNBNQUrTCstJkLeZnOtaQPDS98k2GkIyktOz7cqHIqxL58ChciarQbMqtyGchlsaJHhNu6bx5nQsPvl8mg8eX9UGDW8jFQKv/wBaTiGmuuUsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amdcloud.onmicrosoft.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVKk0UPsT4AqHjKk5mQVG67W8lmZ3JLVr0dS4r/KFKU=;
 b=aOrIlurn5Kd4TTevg3YmuyEdv+QI0yT6htpHloR7kiYvC87dd5hMSq57FigGUWXN33YaTPWyPef5fAiREysaMhzS+YQ8Uq8Uge4X3DCPMmOL0tP5vQpAM/pAsndcUa+weXwzbA58grAPvAHaUvlKbH/TQUxldO19BUamFaKPDTA=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 14:00:08 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::2d) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 14:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 14:00:06 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 09:00:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Hamza
 Mahfooz" <hamza.mahfooz@amd.com>, Stylon Wang <stylon.wang@amd.com>, Alvin
 Lee <alvin.lee2@amd.com>
Subject: [PATCH] drm/amd/display: Correct kdoc formats in
 dcn32_resource_helpers.c
Date: Mon, 12 Jun 2023 19:29:38 +0530
Message-ID: <20230612135938.2301377-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2de082-0b65-4b27-a81d-08db6b4d53ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTNMOw7eBXS+twNb/S5NBUCIAOW3Dvv/If2dA5F0Hb05LV/zX/h9MvsrikOEmnlhPC0if81a/u2+ZVSwkm+3Fiw0kpast/5n4dIgDkcw7RNnc1U+PS65M1XKXjO3VotVpJR5b55WCMI22pL4e3uUEbFS9E3TmwLsNjnv/+XMnAqEs0zeM0/1vG0EdbuIzRA0HffcBWEYQphJW7Po30CJGq31MBt/Deq0xGkh2PAkozb09ufD6cUVU4lu1pJh4DUw43fUrKKgUJ4XL5p+cPaWsAs7NKpGXJhK4O9ev9jIPIHgo1bhw6wGNbLbuRbvlbLeR1bn44aAe53t9j21co3MOfA559pfAqkoOHDPKj9fEuHIWQGLt1t2q8TvFuo1p2yENGnShOJxoefINuIfWMKmWPgNM9uG4Gm6s1gkqoa065Z7sWKjhLQgsjok6uX4zpdmtXKwce0jcR/gziVYm19+AyZM4Zcydz92K36E0hPaJdiFdqxjSxQSDnDjGQmFZGJXG0rjaWzH4robRZGB4YHeDYNqYaXVYS9QEObaUYj+MZf9ntiRu9eduY35hLDuQoPQgUbO42KnYETeO4Fl3zwNydGAECgF/uhSUt+zFezbdYoFktmlFh+4N4QxVRuCXLLlhHDFSzgD843kB4mbnt2RlZzoFdHfBnx+1f3ITJJGWRVlH0u/7p7WC7NhpJvCZfK5hy2oW+tGQ7FeloZiZwm5/kO4vTZUdh0TdBqzqCFwQtlER11pUWa0a9GBMn39ARaOnZs63Ew3HcS08ekHQJAOUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(4326008)(70206006)(6636002)(8936002)(8676002)(5660300002)(36756003)(6666004)(478600001)(110136005)(54906003)(316002)(41300700001)(40460700003)(7696005)(40480700001)(82740400003)(356005)(81166007)(186003)(16526019)(44832011)(36860700001)(47076005)(26005)(1076003)(83380400001)(426003)(336012)(86362001)(82310400005)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:00:06.1907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2de082-0b65-4b27-a81d-08db6b4d53ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:285: warning: Function parameter or member 'dc' not described in 'dcn32_determine_det_override'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:285: warning: Function parameter or member 'context' not described in 'dcn32_determine_det_override'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:285: warning: Function parameter or member 'pipes' not described in 'dcn32_determine_det_override'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:624: warning: Cannot understand  * *****************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:676: warning: Cannot understand  * *****************************************************************

Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 4882c3684b82..a9c41ef0751f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -273,9 +273,9 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [in]: pipes: Array of DML pipes
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @pipes: Array of DML pipes
  *
  * Return: void
  */
@@ -621,11 +621,10 @@ bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int widt
 }
 
 /**
- * ************************************************************************************************
- * dcn32_subvp_drr_admissable: Determine if SubVP + DRR config is admissible
+ * dcn32_subvp_drr_admissable() - Determine if SubVP + DRR config is admissible
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
  *
  * SubVP + DRR is admissible under the following conditions:
  * - Config must have 2 displays (i.e., 2 non-phantom master pipes)
@@ -633,9 +632,7 @@ bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int widt
  * - Other display must have Freesync enabled
  * - The potential DRR display must not be PSR capable
  *
- * @return: True if admissible, false otherwise
- *
- * ************************************************************************************************
+ * Return: True if admissible, false otherwise
  */
 bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 {
@@ -673,11 +670,11 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 }
 
 /**
- * ************************************************************************************************
- * dcn32_subvp_vblank_admissable: Determine if SubVP + Vblank config is admissible
+ * dcn32_subvp_vblank_admissable() - Determine if SubVP + Vblank config is admissible
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @vlevel: Voltage level calculated by DML
  *
  * SubVP + Vblank is admissible under the following conditions:
  * - Config must have 2 displays (i.e., 2 non-phantom master pipes)
@@ -686,9 +683,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
  * - DML must have output DRAM clock change support as SubVP + Vblank
  * - The potential vblank display must not be PSR capable
  *
- * @return: True if admissible, false otherwise
- *
- * ************************************************************************************************
+ * Return: True if admissible, false otherwise
  */
 bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int vlevel)
 {
-- 
2.25.1

