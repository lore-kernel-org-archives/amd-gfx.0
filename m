Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BFDC021A0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1FF10E3F3;
	Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0zXLYV9L";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0A610E3DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/qBz8lZRNXpXtAAjAsJ2M7XhhWO6tWksDqwT6su3LPa64MM+npNiCyqh1jnGSnJg1Kf1TJ8BEDgbLkG1H4Gs2M7KUbxtzalxGcHJHtTDdAiTkV/OdMR8HcxAJReT4DG1c2uP75x//U8tpb7MpyTzVLz0MSx0JqEdV4PFwjOqx3hi/lV4zSnEyKpFCwZEa+IzPnWfWaFiYpjDg5ovoN3PMayC46f3WhP5wHyVxAptQ/ll2LZB63gl7wDz2daKsYIj7/aMhcFXd37igLhhWAycXzGC/zCe1qJR87OzF/806PEAQud7gvJ/kkaIFThB9Igvrc4QFAEMM2+ukoI0UCTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGTWoiOr8/NCuqDrnqdRksEhAck80nj//ieW9Vx28nE=;
 b=ivw5YXCaF6E9gx+mwQ9KuUraT2rYrT3EGfy5CpsgDGd7ECbX0GWJBJxPf/SGvrxGP4sIRwjXGjpkth32HZel3jpF8ZopGATEI9c1iX5MG6/3XWrmud25+k91KZyhDmxxGl7ZAMEmM6/OhNFM2hOPxYLexWnXSUpCDpac5p8nxJYwUnkGBMmwaJfApCboQ0n5EPfzeMejtUfWFMkKJ9sYy9Y2t5+XJvLSqAEBedFl1OoEV4UD7YKgdlSlmCJIyKXxph83lnP/s7QVTASVYgAd2E3VjFTPyO0j5gXhzBz5YEMcpE0J6CDuI9EV4VDCmx602gn7Ws8+6ekmauWuL1Hwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGTWoiOr8/NCuqDrnqdRksEhAck80nj//ieW9Vx28nE=;
 b=0zXLYV9L1d08fV7aaYO6WjN793xeQNDcoirMmMpHS+cDXoNGj7ntFpdscoJJ2oYtY+3jrnToQZw3JI+9XZSQCAkfI/Zwza8uPzgTp94B4fJhwhj6F672ewzzqd4uMg/9h7xJyqCBSCzX8TW7WxVs66YX2isaOFUhXZOCNNTUEGY=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:23 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b6) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/44] drm/amdgpu/vcn: use per instance callbacks for idle
 work handler
Date: Fri, 31 Jan 2025 11:57:28 -0500
Message-ID: <20250131165741.1798488-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bd757a-9c76-4266-4126-08dd421878ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C9rHZ0EvQfhTbqqao5m8cje6XlbKb+fvxO+D8dIUIOT3jaWal64aURmBwB2x?=
 =?us-ascii?Q?VUzYpRyljIt1qOoaX1OZ+k1YzVpb/v8MrtRkns8ANQg60Z0pMEiFxRlId5gn?=
 =?us-ascii?Q?srnYfjt4nmv2OmNvi1N/zRAtUI57Qw7eZ19j8QHdDaAc/jq/iHfshVt0Ggr8?=
 =?us-ascii?Q?7IKnyg5VAWCMrUj7ipZ/L8JeXJuHvb9J5iG7l2ej0MTEuqlsEHI+a0TXWkvE?=
 =?us-ascii?Q?mZCrR/UOFjnmEJbBgeq+PwErFMRoUM5tSMJVWP2DQr9G4Cl/CKeiAm4I12c7?=
 =?us-ascii?Q?ziiwZJfn+BJ4GAe3Pc/2hmaebFHSuzf6q9QKQUCWSr4yTQWlzP9gTMfS4WO/?=
 =?us-ascii?Q?YMlw04BnPZJ97EnXXDzp2hjPtpZCL6iGhavgXhL4mkgqPCo4Rb6ciLAjPrIc?=
 =?us-ascii?Q?k96RYTfa86ypP9+LlYOmGUgiQPiWHWR4eO/6ctV0lyeK697Ah/k/oHdT+OqQ?=
 =?us-ascii?Q?J13LfwCJLx01JLK3pWI8JgdLYRnm3UYLhw5bZ1LCSYdJGeyBTXvXm7RcLLZX?=
 =?us-ascii?Q?3/OWWL0laEcwj2Cpe4RZkls0pR2sqXdENIR15tbPXZAZY3RKNLY7DA/pP86B?=
 =?us-ascii?Q?uwLtTmEZawQU6yiprmIieTu8Zm7b956pISzcUq2fWkeZCvNdVTz8BJySngQ6?=
 =?us-ascii?Q?DYvBVlOSQ1D38hs/N9ArlMyUPSAY+UF78pfZYRHmlMzmT/hh2E9Ha8fMxZP4?=
 =?us-ascii?Q?bCr6T8rQpbRVGfPnTCrsEcGvxzJBh8ojCMbuMNsQojowfbsd8FHrgR0BOQyF?=
 =?us-ascii?Q?tl2KFl7zDTTjDeUkNZhlVUAX36tr/7opXl/mGJtyprbb+gAzs4R3dM3pMd5A?=
 =?us-ascii?Q?0XT1E1fh2ZxQexwEL1ahsd7YbwouHUrNZ4JXcGXqFcPQrpWaj90UpO0iZKHV?=
 =?us-ascii?Q?P5W7b+fUA2BMwEapUxhCxR5BRIkYBpc3oYUbFekDq9KFQab7KznA8UvaLtcJ?=
 =?us-ascii?Q?Wgz6AuWOkgiMch2fWRJUWIzcPXWZMINo8yKQ1YQatg1s8Y+j5iIs7zybkGlL?=
 =?us-ascii?Q?+1vhroISsOwsOyaJrk4rKb+VBLhZnNLQo5dRvxIg8ApOcXxpKE0yg1k2YRUt?=
 =?us-ascii?Q?np53+6UnXcMplKjJcE3xFQ8SWQTu6kpybv+mzGfcyLP2tNiHRwAtyYmG4pFa?=
 =?us-ascii?Q?fDIrq6UnFt+J/9BRlRs+31c0gtD5Qgae+sDj55WS2/K/tg8u3cjdg3UPgoDP?=
 =?us-ascii?Q?rqB8btszHYC6LWOKXDl47W9mDrqirH60QbknyQf15dWvPe/Jo58AMnL1dDRG?=
 =?us-ascii?Q?DrevoPMnoMX+RS3s0jGu0bo6x1D8UI5Lfx6QZ4DtZg08ly3V0wF04aSU+qG9?=
 =?us-ascii?Q?sty0xLVBPti+HtUsXFjqOoGvhlgo+S5PovN/TfAdVlur6hi+ibfiVYVWou31?=
 =?us-ascii?Q?2lt3gOCDwx8+C5hufQjvZWtKPDdQEvlsWdRPmrRuob7GAVwW1VubdCVjgHHy?=
 =?us-ascii?Q?x5Q239HTMi08Q5yCA7Jil71gfgfgZsmi9XgmF2fC/5XAUWGDizxzlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:22.6744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bd757a-9c76-4266-4126-08dd421878ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
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

Use the vcn instance power gating callbacks rather than
the IP powergating callback.  This limits power gating to
only the instance in use rather than all of the instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a2250747a7c81..81bfd8a9d8268 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -424,8 +424,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-						       AMD_PG_STATE_GATE);
+		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    false);
 		if (r)
@@ -438,45 +437,45 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 	int r = 0;
 
-	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
+	atomic_inc(&vcn_inst->total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
+	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 	}
 
-	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-					       AMD_PG_STATE_UNGATE);
+	mutex_lock(&vcn_inst->vcn_pg_lock);
+	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.inst[ring->me].using_unified_queue) {
+	    !vcn_inst->using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
-			atomic_inc(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
+			atomic_inc(&vcn_inst->dpg_enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
 		} else {
 			unsigned int fences = 0;
 			unsigned int i;
 
-			for (i = 0; i < adev->vcn.inst[ring->me].num_enc_rings; ++i)
-				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
+			for (i = 0; i < vcn_inst->num_enc_rings; ++i)
+				fences += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[i]);
 
-			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
+			if (fences || atomic_read(&vcn_inst->dpg_enc_submission_cnt))
 				new_state.fw_based = VCN_DPG_STATE__PAUSE;
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 		}
 
-		adev->vcn.inst[ring->me].pause_dpg_mode(&adev->vcn.inst[ring->me], &new_state);
+		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
-	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
+	mutex_unlock(&vcn_inst->vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
-- 
2.48.1

