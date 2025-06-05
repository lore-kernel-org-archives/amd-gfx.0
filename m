Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF47C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F90C10E987;
	Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhxb8/kB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BFE10E942
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ3qyipD7MMTDiM0RYi7uKmovT+UgRUxpPs/MZM3DsNzRV1kaPNy5j0PnjhiIM86Wp3xLj3v3Iisxzz9TMNrr64zyub4WdyiewYr5a8uxNZKvRraIOGYgmNHp3oIJ5enSYCaIWyLn+tNFC3uHofL4U9koe0Cwxr9mqEjvrgUl5buH4GCQmS5F2eelJx2+dkOUWd/EwRdXIaWV3phuClHL8ZB27kNOaX1aaDaYzgpMLkBt+y5WA+XlclEZ3DEwAcGnE/YSk3yMOlCHPVcpRcxKOGroTGlu00AwMKdT8efgrYSS2Z/c5OfChI/LrHiioqtqgXZ5sqonqSq6xPvY0a81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l5X4eRxQdFZwa6GxA5PRtELK0cFgU0iZRI88nhBHkI=;
 b=c+wFnAxS0t3WzAdoxvCIVfENmS2ClisV5BQThTpQoigQSgLPZoBc1tsEveWQr2tN8dqGMT1rvEvImwPGBxxDGsX4TVmO9zzqEDZ4J08ELg08FmLjXTeDZhvafG/G4oLMWO7qwH8ZVyUybWVCMo+kcKZ4Rcd3ibykk/f1Rf6e+PU/2NMdTS+9+I/qXwGeu52fc7FwRL97W5bp6kwx6lsgB6oMRJ2f9D+HG23W6BLrSwZOkWln1J2hnn6rgPgCNOjhhZ9EdG1bDo+RfyQkhorulqMUbLkvYqk3fAeJdSmdAriWGfzIfL/nleOJ/6JpYhIoM3h8LElXxoz3vhpJ08jcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l5X4eRxQdFZwa6GxA5PRtELK0cFgU0iZRI88nhBHkI=;
 b=yhxb8/kBg3to4PK4qlkHHL9vuZE0g+YcV+lO336SSEycgH+jG+SMLd2we+XM+0z0VKPlNaaZLLowNWENfHJcmkuApI4yJjZ/QGSJkueMinqU/PsEbFoSg4Y3muLpAYJOJan0HHD7HJS92odrpl4BowUTKbgaeJsxKG/RvSIqS4w=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 5 Jun
 2025 01:46:31 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::80) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/31] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:47 -0400
Message-ID: <20250605014602.5915-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cda6f19-3796-4c38-a8a6-08dda3d2cb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltT509LUIt8gVPxgeT1xh3/pHZLg86nhRPnwfuKeZsVCBCYofa/Rteo57aWt?=
 =?us-ascii?Q?4TLYRemJS352aTQog19WKyMf1GZYVCTFrxvw0PFgcLtMiqmoWQk3bcfQhKAG?=
 =?us-ascii?Q?Ff8Fc7D1a30CkuH1sWq2RP9q0uhsGc9WZSdJedc7guAwVxo27uisWU8ATGOj?=
 =?us-ascii?Q?ue1RdBNUJFNRx3SGBBHYbopFYRyoLhde6ym8rsveJCVT0E0f14Wf498HvpO6?=
 =?us-ascii?Q?5eoANfyr05cAonkjm/cMq9WYmTbD7Sy0+q64cHWH7fHODxpYBbsd6wtWzuS3?=
 =?us-ascii?Q?2ihfyLLDadU/ANWYQk6QknEJh5lTRQaU2m/0m2NEQX+TTPAip79FVGB0lxzF?=
 =?us-ascii?Q?Wpez91Pvaibhb1buooXr+ZNkTrhYfryv31zamx440V8yVaj+6o5ValQrveDe?=
 =?us-ascii?Q?PRholTEk07ecpKkmYOamsRI/O+bJVrfIQGUSRyvduphP/m2Y2/mwCw8COi/I?=
 =?us-ascii?Q?Bj8k8cTvapR6K4Al1cqHkV1cmY3sfkuig76e4E6B2sBihWo9Xd6wrFwmcwSy?=
 =?us-ascii?Q?V8SjYb0wumKJD2ZhRDJM3/Me3G/YkSB12PniOrOc/zSbrnD6TlR3AcZlNruU?=
 =?us-ascii?Q?qjneu5Nckw+P5DLk7VhgUR4EMsfc4flTdwyGnOv/ItrrQ+UVQ3+B8jtd8G+B?=
 =?us-ascii?Q?Y/yxVXBN3ZTu/Mkj0WC8U/FGyHiopp/5ScUKOefjNk9FLt6vvN42LR4wpusA?=
 =?us-ascii?Q?etS8BR8gMep6p9ioLFw/QB547Vs4aPKCat91gFr4h247ddb7dAPKl5//Yp5A?=
 =?us-ascii?Q?Oru5J1LzMDIqydNLvUw+2fVa2U0aAf3XEFpNk2GeDff1Xjt3kea+77MSsPgU?=
 =?us-ascii?Q?XwB83AjkreK51Hcf+nVnP+T9Bvw7QY7/oUmhaz7c8rtHTFzMZTG9idhhf7nM?=
 =?us-ascii?Q?tYUBE/GG9mMjMGaEb7HO6b75M4xR1s81u6qHq38rOVn+/nCbCxkQpdPjI0Z7?=
 =?us-ascii?Q?oTXpHZcTi75pUXcWktpdPFerd2qa9kg/Hb95dKXpLT48uW0dSIGq2B7AKpyu?=
 =?us-ascii?Q?RDQL0AekUfAZ4hSDCk0XdJ3Z4ab4leJBSI0o6F3jfKPW7wVxjEEpxUESpRk/?=
 =?us-ascii?Q?Be4kY31VbovUcPPuktnAjggLvxGAxglXBSEZoiJLLAt4axS4049SGE4ijxyQ?=
 =?us-ascii?Q?JFmvOdZ4zpepl2HVAAdcmk6CBizDOMDg2zs6KiekxGoIxT30r6lcZzbq9ob4?=
 =?us-ascii?Q?eInPy/WnrrzHTsCn7wjNr/A5K4oQd+YvUQRCZDmoxBEsV6MGnhtP6Yi3Nbdl?=
 =?us-ascii?Q?2YGiXCJNNL/E0ZTqiiRxNTKkImNkmCEIF8cBfDOd0gwIPUlEEPy/exJHzl9F?=
 =?us-ascii?Q?R+KeYpJ6IjPtie3Lc0/ikdoF+M0ggty0bXOhVkujHnlu/HgDvyK7CxQDauh7?=
 =?us-ascii?Q?I5sbJOuZBpwgpGBWH9/fhoQSM3uOISrOhKoloD/DS3jkFvA7wp7P/2J/yC9u?=
 =?us-ascii?Q?wOmA8Oz/AF7WQJIudx+sFbE8SEK8nWYVA6AH+8uW4SOP1F1bqyGZzLVmwV9j?=
 =?us-ascii?Q?fAr2vtBp2cCmsTDsx0+/RmOFJ7qzIyNbPjva?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:30.8945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cda6f19-3796-4c38-a8a6-08dda3d2cb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ee94e457ee25d..7bdfdaefbf49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1455,11 +1455,8 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
-	int r;
 
-	r = amdgpu_sdma_reset_engine(adev, inst_id);
-	amdgpu_fence_driver_force_completion(ring);
-	return r;
+	return amdgpu_sdma_reset_engine(adev, inst_id);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
@@ -1525,11 +1522,11 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
-
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
-
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
-- 
2.49.0

