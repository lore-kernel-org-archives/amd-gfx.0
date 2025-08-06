Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10275C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 12:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A791E10E28D;
	Wed,  6 Aug 2025 12:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0SgO+nV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D7810E28D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 12:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=af2wxV2NhLrr4WQdwDuua30TSvTX2PLZD5fOLGVFpTaJoTntZ7OM/fz2tUj/6CekaUdRar7yRifFdGba53D/CbvI+29G75nGSKaVVgv+y3csKRdIhSnbxUzxkmKl8Z6w0ITfn9s9yREqJ2dQTRIeZ5FP6+WswoRhUtl/3LmLRz4rI8UdDc3QGR4sZVThaYHbvw6qemOvyHl/DFnIeD5iqrq9RhuIu9g2/jbO7ZHOh4iYHs8xGbN2fjT4ki6jngXuYHDvvCt6MeeoN0lNXWSirlip2En+2rEnkXyx0a3XJA+N5SR8pnunsnOvXJy5W2hdOidp/gywz0C0/3ySYx8Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqrugk/rqcAPNRDqUzrGnHas+PuaMvh5F8b0U7BLKlw=;
 b=Uevw3qgIZEIxtuWg0+Zd2ttPJilCep177h4bM31SfluYmyUSftBhUwlHJULbM/fD17TdxdM8g3mqnFpHk3bzeN1IL21c8kQOJHSb4A2D/h4AukKsUm+Ilz2XK5159PPPjfCxWrNt4zM40TOjdUGmvbd380TEpt5ggkCM7nrbASGLK133gWUZcgGiwIRPnVp7wPYimlKk0ud4mC1IZdO+sMmC0fLCba51ZOuUMkiIKyw2pv76Y0whUHan/fvTngNQd3Q9DqrF1wMln8dG2mb04hSUy7auECnLqZzr+WmAZA9gdfIY2XaRJT+rGz537ezFdymendyGlhjpKTXoEFMIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqrugk/rqcAPNRDqUzrGnHas+PuaMvh5F8b0U7BLKlw=;
 b=U0SgO+nVB1eQfvCHMmrKQH5bBx7KC9CjsKj4yQzU1ilgugvrih5ocbuG7o2xDYlXVjOvLeGKphGG+uVBjRxVvqmRWNuDHmrhnUbUIDed5AJFuBGROaxSy9Z5eICjYq5oVuUJ1PA5ZXYYwUgfykonisWy8cuWG7YYhGP5G0qP020=
Received: from DM6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:333::27)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 12:52:25 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::d0) by DM6PR03CA0094.outlook.office365.com
 (2603:10b6:5:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 12:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 12:52:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Aug 2025 07:52:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Roman Li <roman.li@amd.com>, ChiaHsuan Chung <chiahsuan.chung@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>, Ray Wu <ray.wu@amd.com>, Daniel
 Wheeler <daniel.wheeler@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for stream before dereference
 in 'dm_vupdate_high_irq'
Date: Wed, 6 Aug 2025 18:21:55 +0530
Message-ID: <20250806125155.3615401-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: ef89ad9b-5790-4d30-fd0e-08ddd4e81715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7e5QijTGMqIGht9SqB7ftf1Dbic/lYG5cZVAc54yGwT8jX9A5bfLEwr+xt37?=
 =?us-ascii?Q?iHdqvAYIMcWrlXsKEV4l2K+hP3pxJ7RNxUqx9PdlwJLpR9ndICLWHOZlHlYz?=
 =?us-ascii?Q?YTQieiG38bF+Jm6K4Ti0T11bC1epacxfQ9blpSL17D8uz+0ENHLOqhbAhXwF?=
 =?us-ascii?Q?Bdcas72OJsdv3j+PsA5cxnfWreyCp9ysBhZB1xQ3T9hxoU6BvfUeUgZjKcj2?=
 =?us-ascii?Q?/5uuHO6erRAVeYzRy+eZPSgYxfsG1MJ8GCxCyvwREv/ui12AFGlXnpNbWhOM?=
 =?us-ascii?Q?uYFU7jXyn58KqZK/KBbdLB1e/7hKWHrsXmSQye6x+i56IuAHgFPvnAgm2wHi?=
 =?us-ascii?Q?PFWVC/546F1KotW5QOkkCoSPIRzfb0tsbFlKDrrMq5/yY7L+sq+xrJ7rxqIw?=
 =?us-ascii?Q?TOtuRnZP6CVbDNPb/fZBNnP/HhJcoxgT+h8v7fww7DVKDuHX0Z4Jzswo/Fgl?=
 =?us-ascii?Q?B/5h6fmwaT36eWbNhuRcdzbd9BUcV4ceRmPsEtwxrKO0neNhPxTMaySDZkEQ?=
 =?us-ascii?Q?3YQ3CULNIprkfqe6p1E4oxUYR517okdqu+RR8/PwzbXsx8MKofhHC2uMt43l?=
 =?us-ascii?Q?LIGQz25z18LCs3kimhp0KT+j0mtUPlA/HE+dajEi1tdnIzS2YwntLnj6oY7k?=
 =?us-ascii?Q?7hRdzv/3/wRXrKGuVahdbbtU2q4FMdz7KRxxtefjdcvuoPc2MxKeXokQgn2F?=
 =?us-ascii?Q?zkY2ys5tamgAvn1Ut3oD5pVU+yAi3ago9605GpJ9LI2EjY5aV92G8NkpOmG0?=
 =?us-ascii?Q?xCZM+VpnG9Oo0vkYd+TAgmPhCKIFnyntmqaBn1AqenkTjEMn8ZBGjjfcytZj?=
 =?us-ascii?Q?U2jNV+Fm5kClx7E7gTQaNldiXPKWWNgqn1TLW6gb9S80NiLw3CEMAWkcY40u?=
 =?us-ascii?Q?txUEElsg6+LCiu2/4eV0lsqcPmgWRms6tLzRf8IhWhjTh0LLr4bVJst1JGEa?=
 =?us-ascii?Q?ZWWsgtA99PslJz6T/1owevulv+znsm4Hiv+3vsVaMoNnnj+60Ci3p7iRDjBt?=
 =?us-ascii?Q?LlF/+s4nUtdl86wSnGtWkbxh5o+c0kH30XV8EiHcj3NLGFJR/V3EIZhKnLA9?=
 =?us-ascii?Q?LP/lTDGeBwMcZhcSh8ENUbhu5/ouySBRu0x4dF9z5fCzxrCQY0K+xko9Uqo7?=
 =?us-ascii?Q?pNz4zSc9Iib6kyr/fVD49TJL00O6yA3CYmRbGIJN78sLce+h4DbicbQgeU0P?=
 =?us-ascii?Q?9FEzBKFg8e7YjUS9YYdEV53OMD27rol7/fe7N7deL7DJ7zVX46jW5w0E/DL0?=
 =?us-ascii?Q?fT3V8T2X3f1kJ8aKhiRuqYjeuRXLlMmw8RDPsHVB7eDeDMHTb6+PdHUTbbX2?=
 =?us-ascii?Q?9Y10PdNmIM3jNO5QKpo5+BMBGb2JO5krRUPXoIgqihU0vOMYEF6JEQlngim0?=
 =?us-ascii?Q?PHKG+hBIfh2+z3VdXg9qe+YcCqz7YFnTeE9vhH9n0POBaAnC+3/8j+lEWE80?=
 =?us-ascii?Q?1wlkLZ0A0ZRclXNt4howd23VmtwoomYyzbu78hixu+DPQbz3kiuK/Gib/F8+?=
 =?us-ascii?Q?OmsdUtjhOddM5qjYIDz+UWbotXAaFTIHTjNw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:52:24.0378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef89ad9b-5790-4d30-fd0e-08ddd4e81715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
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

Add a NULL check for acrtc->dm_irq_params.stream before
accessing its members.

Fixes below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:623
dm_vupdate_high_irq() warn: variable dereferenced before check
'acrtc->dm_irq_params.stream' (see line 615)

614	if (vrr_active) {
615		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
				 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
616		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
			      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ New dereferences

617		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
618			== VRR_STATE_ACTIVE_VARIABLE;
619
620		amdgpu_dm_crtc_handle_vblank(acrtc);
621
622		/* BTR processing for pre-DCE12 ASICs */
623		if (acrtc->dm_irq_params.stream &&
		    ^^^^^^^^^^^^^^^^^^^^^^^^^^^ But the existing code assumed it could be NULL. Someone is wrong.

624		    adev->family < AMDGPU_FAMILY_AI) {
625			spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);

'Fixes: 7a586ce03c42 ("drm/amd/display: more liberal vmin/vmax update for freesync")'
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31ea57edeb45..c0d31c26850d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -611,7 +611,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 		 * page-flip completion events that have been queued to us
 		 * if a pageflip happened inside front-porch.
 		 */
-		if (vrr_active) {
+		if (vrr_active && acrtc->dm_irq_params.stream) {
 			bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
 			bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
 			bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
@@ -620,8 +620,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 			amdgpu_dm_crtc_handle_vblank(acrtc);
 
 			/* BTR processing for pre-DCE12 ASICs */
-			if (acrtc->dm_irq_params.stream &&
-			    adev->family < AMDGPU_FAMILY_AI) {
+			if (adev->family < AMDGPU_FAMILY_AI) {
 				spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 				mod_freesync_handle_v_update(
 				    adev->dm.freesync_module,
-- 
2.34.1

